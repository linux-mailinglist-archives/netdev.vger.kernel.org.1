Return-Path: <netdev+bounces-121717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFC95E2BA
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9801F2172C
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166414AEE5;
	Sun, 25 Aug 2024 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh+PlAiW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAD6F2E8
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724575391; cv=none; b=G8EqFFPNy0zKzPZNTbPWFK8nFr772gKU5fGb6q+EdRwQpz1Kzw7zJT4oRlJOIrNyBdlEcfyaITeIEEpyXlRoV2nuE32V/g5xILO082R0VwTXKm+hECistil4qJcccIQHgKl7Ne/VWFaXAw6eVIOYEa713Ru5AgMhxLbnEBauWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724575391; c=relaxed/simple;
	bh=GfT8JC95S7H5IXfbFLJajM+EBr4ZAYq4YB9Z8VU+K+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS0ER9pKU9D6ewZn38Vn/+kQuhbS7OIbnmrlWD/9Km9wR7lIGvg7HFnbB/Nbc1vIUY5tmiRd0mv3EG2pEQVrbGfz8UZ4awGVEGWBjv4vbPHciWRC1axon4xC3Xvjc6sBhDX4x60/AdyP4rjQneXjr83Gu5YtRINwymxn+38BqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh+PlAiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ECBC32782;
	Sun, 25 Aug 2024 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724575390;
	bh=GfT8JC95S7H5IXfbFLJajM+EBr4ZAYq4YB9Z8VU+K+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sh+PlAiWfHH3S/GBkGpmmZFUtwOQekHkZPBIPHUlgFHrlQalJLUOc9m/Eeq0RlznU
	 X7iHkwRNjilJneyMVqmUvSjSRu+yHxlRjGmE/g+Ueyu5gfIq/PFrXpODb56V8o42By
	 CVWBliw/QPg4VmvkAfKpIukoIC1miWNk6EzkkhQ+nGTHWXEbpr6o/aTlj8ZNW7LxhC
	 kmI7W5E9tWqwjm0OiNs/8Eh49PRei54EVDO8QZW4hyReDDGFWdorTGgAHXUrBw7C+Y
	 qQVEJ+f0cFYrahCoE7N6SStakMoE+pa+MiYU06ninHmfZuS1LrLnlrTKL8XaSR/bdm
	 7sBYxXolno7cg==
Date: Sun, 25 Aug 2024 09:43:06 +0100
From: Simon Horman <horms@kernel.org>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH net-next 1/2] net: phy: aquantia: create firmware name
 for aqr PHYs at runtime
Message-ID: <20240825084306.GX2164@kernel.org>
References: <trinity-916ed524-e8a5-4534-b059-3ed707ec3881-1724520847823@3c-app-gmx-bs42>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-916ed524-e8a5-4534-b059-3ed707ec3881-1724520847823@3c-app-gmx-bs42>

On Sat, Aug 24, 2024 at 07:34:07PM +0200, Hans-Frieder Vogt wrote:
> Aquantia PHYs without EEPROM have to load the firmware via the file system and
> upload it to the PHY via MDIO.
> Because the Aquantia PHY firmware is different for the same PHY depending on the
> MAC it is connected to, it is not possible to statically define the firmware name.
> When in an embedded environment, the device-tree can provide the file name. But when the PHY is on a PCIe card, the file name needs to be provided in a different
> way.
> 
> This patch creates a firmware file name at run time, based on the Aquantia PHY
> name and the MDIO name. By this, firmware files for ths same PHY, but combined
> with different MACs are distinguishable.
> 
> The proposed naming uses the scheme:
> 	mdio/phy-mdio_suffix
> Or, in the case of the Tehuti TN9510 card (TN4010 MAC and AQR105 PHY), the firmware
> file name will be
> 	tn40xx/aqr105-tn40xx_fw.cld
> 
> This naming style has been chosen in order to make the filename unique, but also
> to place the firmware in a directory named after the MAC, where different firmwares
> could be collected.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Please consider running this patch through:

./scripts/checkpatch.pl --strict --codespell --max-line-length=80

> ---
>  drivers/net/phy/aquantia/aquantia_firmware.c | 78 ++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index 524627a36c6f..265bd6ee21da 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -5,6 +5,7 @@
>  #include <linux/firmware.h>
>  #include <linux/crc-itu-t.h>
>  #include <linux/nvmem-consumer.h>
> +#include <linux/ctype.h>	/* for tolower() */
> 
>  #include <asm/unaligned.h>
> 
> @@ -321,6 +322,81 @@ static int aqr_firmware_load_nvmem(struct phy_device *phydev)
>  	return ret;
>  }
> 
> +/* derive the filename of the firmware file from the PHY and the MDIO names
> + * Parts of filename:
> + *   mdio/phy-mdio_suffix
> + *    1    2   3    4
> + * allow name components 1 (= 3) and 2 to have same maximum length
> + */
> +static int aqr_firmware_name(struct phy_device *phydev, const char **name)
> +{
> +#define AQUANTIA_FW_SUFFIX "_fw.cld"
> +#define AQUANTIA_NAME "Aquantia "
> +/* including the trailing zero */
> +#define FIRMWARE_NAME_SIZE 64
> +/* length of the name components 1, 2, 3 without the trailing zero */
> +#define NAME_PART_SIZE ((FIRMWARE_NAME_SIZE - sizeof(AQUANTIA_FW_SUFFIX) - 2) / 3)

nit: I would have made these declarations outside of aqr_firmware_name(),
     probably near the top of this file.

> +	ssize_t len, mac_len;
> +	char *fw_name;
> +	int i, j;
> +
> +	/* sanity check: the phydev drv name needs to start with AQUANTIA_NAME */
> +	if (strncmp(AQUANTIA_NAME, phydev->drv->name, strlen(AQUANTIA_NAME)))
> +		return -EINVAL;

A general comment: I've been over the string handling in this file.
And it seems correct to me. But it is pretty hairy, and I could
well have missed a problem. String handling in C is like that.

> +
> +	/* sanity check: the phydev drv name may not be longer than NAME_PART_SIZE */
> +	if (strlen(phydev->drv->name) - strlen(AQUANTIA_NAME) > NAME_PART_SIZE)
> +		return -E2BIG;
> +
> +	/* sanity check: the MDIO name must not be empty */
> +	if (!phydev->mdio.bus->id[0])
> +		return -EINVAL;
> +
> +	fw_name = devm_kzalloc(&phydev->mdio.dev, FIRMWARE_NAME_SIZE, GFP_KERNEL);
> +	if (!fw_name)
> +		return -ENOMEM;
> +
> +	/* first the directory name = MDIO bus name
> +	 * (only name component, firmware name part 1; remove busids and the likes)
> +	 * ignore the return value of strscpy: if the MAC/MDIO name is too long,
> +	 * it will just be truncated
> +	 */
> +	strscpy(fw_name, phydev->mdio.bus->id, NAME_PART_SIZE + 1);
> +	for (i = 0; fw_name[i]; i++) {
> +		if (fw_name[i] == '-' || fw_name[i] == '_' || fw_name[i] == ':')
> +			break;
> +	}
> +	mac_len = i;	/* without trailing zero */
> +
> +	fw_name[i++] = '/';
> +
> +	/* copy name part beyond AQUANTIA_NAME into our name buffer - name part 2 */
> +	len = strscpy(&fw_name[i], phydev->drv->name + strlen(AQUANTIA_NAME),
> +		      FIRMWARE_NAME_SIZE - i);
> +	if (len < 0)
> +		return len;	/* should never happen */
> +
> +	/* convert the name to lower case */
> +	for (j = i; j < i + len; j++)
> +		fw_name[j] = tolower(fw_name[j]);
> +	i += len;
> +
> +	/* split the phy and mdio components with a dash */
> +	fw_name[i++] = '-';
> +
> +	/* copy again the mac_name into fw_name - name part 3 */
> +	memcpy(&fw_name[i], fw_name, mac_len);

Are you completely sure that there are mac_len bytes available here?
I appreciate that you need to clamp the number of source bytes.
But elsewhere, where strscpy(), the space available at the destination
is bounded for safety. And that is missing here.

> +
> +	/* copy file suffix (name part 4 - don't forget the trailing '\0') */
> +	len = strscpy(&fw_name[i + mac_len], AQUANTIA_FW_SUFFIX, FIRMWARE_NAME_SIZE - i - mac_len);

nit: I might have incremented i by mac_len to slightly simplify the above.

> +	if (len < 0)
> +		return len;	/* should never happen */
> +
> +	if (name)

name is never NULL. I would drop this condition.

> +		*name = fw_name;
> +	return 0;
> +}
> +
>  static int aqr_firmware_load_fs(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
> @@ -330,6 +406,8 @@ static int aqr_firmware_load_fs(struct phy_device *phydev)
> 
>  	ret = of_property_read_string(dev->of_node, "firmware-name",
>  				      &fw_name);
> +	if (ret)
> +		ret = aqr_firmware_name(phydev, &fw_name);
>  	if (ret)
>  		return ret;
> 
> --
> 2.43.0
> 
> 

