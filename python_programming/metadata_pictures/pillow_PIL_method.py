# Using Pillow (PIL)
# Basic EXIF data
from PIL import Image
from PIL.ExifTags import TAGS
import os

def extract_exif_data(image_path):
    """
    # Extract EXIF metadata from
    # an image using Pillow.
    """
    try:
        with Image.open(image_path) as img:
            exif_data = img._getexif()

            if exif_data is not None:
                metadata = {}
                for tag_id, value in exif_data.items():
                    tag_name = TAGS.get(tag_id, tag_id)
                    metadata[tag_name] = value
                return metadata
            else:
                return {"error": "No EXIF data found"}

    except Exception as e:
        return {"error": f"Error reading image: {str(e)}"}

# Example usage
if __name__ == "__main__":
    image_path = "space.jpg"  # Image path

    if os.path.exists(image_path):
        metadata = extract_exif_data(image_path)

        print("Image Metadata:")
        print("-" * 50)
        for key, value in metadata.items():
            print(f"{key}: {value}")
    else:
        print(f"File {image_path} not found!")
