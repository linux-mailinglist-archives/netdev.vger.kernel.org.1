Return-Path: <netdev+bounces-303649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JrXRJxEVRWqx6goAu9opvQ
	(envelope-from <netdev+bounces-303649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:24:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 172956EE0F3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:24:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=V2fwaHXL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303649-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303649-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1DC632EF144
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996248124D;
	Wed,  1 Jul 2026 13:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C548164B;
	Wed,  1 Jul 2026 13:00:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910860; cv=none; b=F5IZU1HEhcvIM73wnHtLXVsuasiuTd6NzI+fB/jfiDHKA2acXhAWL1aNEgRmPlpu3Vy2uUOjPJRPYNPtUg6daQ5oGWzXY5kXd4HZh2ALEg17YFy2THa/hJuazJXxDG4PHVdvDt3g6w84JdY+rDWpZKL8z6PbAO2rArSRkivRVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910860; c=relaxed/simple;
	bh=jrfeDeAYI4PeIcAHdKAxLe/qciJp/ZOV/NO64erWuaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpI+3XO4sJLbOuitoBpRkIH3TCmNieol9hwnfZRNrlaTA2vofDNpmCpjbHP65MNaMmxQY/l9iv+DT/ZVXuMQ3sOgmLBqhDelsc8KIdkXu82xUPSE7KEcxKdasSmA94kPsQno+wiDqHFqiPXwkYr44LMRAnU0CZoBrEm4Ssd6u/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V2fwaHXL; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+vR0SW1+eyWPXaVk+CC4uUvnEvWM2saEgGCA33XbCIQ=; b=V2fwaHXLUyj1lFe1lLtKNltn0e
	vTDNrNOnwFegcMfmS0vEI/KwxDm6TrcwYn+J42sHjlgtjuNymupbg6kjOyJbtFESJqXwa4QcFIx3m
	c00OSjkg1RTJNbLcFildMTIn0Ksqfk5SGeEdcEfQyLPjKoDMoAKgIAboCM/5Sl1VeXVA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weuYZ-00AAV3-PZ; Wed, 01 Jul 2026 15:00:47 +0200
Date: Wed, 1 Jul 2026 15:00:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v7 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Message-ID: <98213191-594d-4e26-beeb-fd9b9a838b64@lunn.ch>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
 <20260629064718.1349-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629064718.1349-5-javen_xu@realsil.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:nic_swsd@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,vger.kernel.org,makrotopia.org,nxp.com,realtek.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 172956EE0F3

On Mon, Jun 29, 2026 at 02:47:18PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will not pad
>  - reverse xmas tree for some definition
>  - add explanation on rtl_phy_write_mmd_bits()
> 
> Changes in v3:
>  - add struct rtl8261x_priv
> 
> Changes in v4:
>  - add struct device *dev
> 
> Changes in v5:
>  - no changes
> 
> Changes in v6:
>  - replace rtl_phy_write_mmd_bits with phy_modify_mmd, keep mdio lock
>  - check msb and lsb at the beginning of rtl8261x_fw_execute_entry()
>  - add comments on rtl8261x_config_init()
> 
> Changes in v7:
>  - no changes
> ---
>  drivers/net/phy/realtek/realtek_main.c | 220 +++++++++++++++++++++++++
>  1 file changed, 220 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index ef3700894ebf..bf7bc19fb44c 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -8,7 +8,9 @@
>   * Copyright (c) 2004 Freescale Semiconductor, Inc.
>   */
>  #include <linux/bitops.h>
> +#include <linux/crc32.h>
>  #include <linux/ethtool_netlink.h>
> +#include <linux/firmware.h>
>  #include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/pm_wakeirq.h>
> @@ -281,6 +283,42 @@
>  					 RTL8261X_INT_ALDPS_CHG | \
>  					 RTL8261X_INT_JABBER)
>  
> +#define FW_MAIN_MAGIC			0x52544C38
> +#define FW_SUB_MAGIC_8261C		0x32363143
> +#define RTL8261X_POLL_TIMEOUT_MS	100
> +
> +#define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
> +MODULE_FIRMWARE(RTL8261C_CE_FW_NAME);
> +
> +enum rtl8261x_fw_op {
> +	OP_WRITE = 0x00,	/* Write */
> +	OP_POLL  = 0x02,	/* Polling */
> +};
> +
> +struct rtl8261x_fw_header {
> +	__le32 main_magic;	/* Main magic number 0x52544C38 ("RTL8") */
> +	__le32 sub_magic;	/* Sub magic number */
> +	__le16 version_major;	/* Major version */
> +	__le16 version_minor;	/* Minor version */
> +	__le16 num_entries;	/* Number of entries */
> +	__le16 reserved;	/* Reserved */
> +	__le32 crc32;		/* CRC32 checksum */
> +};
> +
> +struct rtl8261x_fw_entry {
> +	__u8  type;		/* Operation type (OP_*) */
> +	__u8  dev;		/* MMD device */
> +	__le16 addr;		/* Register address */
> +	__u8  msb;		/* MSB bit position */
> +	__u8  lsb;		/* LSB bit position */
> +	__le16 value;		/* Value to write/compare */
> +	__le16 timeout_ms;	/* Poll timeout in milliseconds */
> +	__u8  poll_set;		/* Poll for set (1) or clear (0) */
> +	__u8  reserved;		/* Reserved */
> +};
> +
> +#define FW_HEADER_SIZE		sizeof(struct rtl8261x_fw_header)
> +#define FW_ENTRY_SIZE		sizeof(struct rtl8261x_fw_entry)
>  
>  /* RTL8211E and RTL8211F support up to three LEDs */
>  #define RTL8211x_LED_COUNT			3
> @@ -300,6 +338,11 @@ struct rtl821x_priv {
>  	u16 iner;
>  };
>  
> +struct rtl8261x_priv {
> +	const char *fw_name;
> +	bool fw_loaded;
> +};
> +
>  static int rtl821x_read_page(struct phy_device *phydev)
>  {
>  	return __phy_read(phydev, RTL821x_PAGE_SELECT);
> @@ -342,8 +385,16 @@ static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
>  
>  static int rtl8261x_probe(struct phy_device *phydev)
>  {
> +	struct device *dev = &phydev->mdio.dev;
> +	struct rtl8261x_priv *priv;
>  	int sub_phy_id, ret;
>  
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
>  	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_ADDR_REG,
>  			    RTL_8261X_SUB_PHY_ID_ADDR);
>  	if (ret < 0)
> @@ -357,6 +408,7 @@ static int rtl8261x_probe(struct phy_device *phydev)
>  
>  	switch (sub_phy_id) {
>  	case RTL8261C_CE_MODEL:
> +		priv->fw_name = RTL8261C_CE_FW_NAME;
>  		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
>  		break;
>  
> @@ -407,6 +459,153 @@ static int rtl8261x_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int rtl8261x_verify_firmware(struct phy_device *phydev, const struct firmware *fw)
> +{
> +	const struct rtl8261x_fw_header *hdr;
> +	u32 main_magic, sub_magic;
> +	u32 calc_crc, file_crc;
> +	size_t data_len;
> +	u16 num_entries;
> +
> +	if (fw->size < FW_HEADER_SIZE) {
> +		phydev_err(phydev, "Firmware too small: %zu bytes\n", fw->size);
> +		return -EINVAL;
> +	}
> +
> +	hdr = (const struct rtl8261x_fw_header *)fw->data;
> +
> +	main_magic = le32_to_cpu(hdr->main_magic);
> +	if (main_magic != FW_MAIN_MAGIC) {
> +		phydev_err(phydev, "Invalid firmware magic: 0x%08x\n", main_magic);
> +		return -EINVAL;
> +	}
> +
> +	sub_magic = le32_to_cpu(hdr->sub_magic);
> +	if (sub_magic != FW_SUB_MAGIC_8261C) {
> +		phydev_err(phydev, "Invalid sub magic: 0x%08x\n", sub_magic);
> +		return -EINVAL;
> +	}
> +
> +	num_entries = le16_to_cpu(hdr->num_entries);
> +	data_len = num_entries * FW_ENTRY_SIZE;
> +
> +	if (fw->size != sizeof(*hdr) + data_len) {
> +		phydev_err(phydev, "Firmware size mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	calc_crc = crc32(~0, fw->data + FW_HEADER_SIZE, data_len) ^ ~0;
> +	file_crc = le32_to_cpu(hdr->crc32);
> +
> +	if (calc_crc != file_crc) {
> +		phydev_err(phydev, "CRC32 mismatch: calculated=0x%08x file=0x%08x\n",
> +			   calc_crc, file_crc);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtl8261x_fw_execute_entry(struct phy_device *phydev,
> +				     const struct rtl8261x_fw_entry *entry)
> +{
> +	u16 addr, value, timeout_ms;
> +	u8 dev, msb, lsb, poll_set;
> +	u32 bits, expect_val;
> +	int ret = 0;
> +	int val;
> +
> +	dev = entry->dev;
> +	addr = le16_to_cpu(entry->addr);
> +	msb = entry->msb;
> +	lsb = entry->lsb;
> +	value = le16_to_cpu(entry->value);
> +	timeout_ms = le16_to_cpu(entry->timeout_ms);
> +	poll_set = entry->poll_set;
> +
> +	if (timeout_ms == 0)
> +		timeout_ms = RTL8261X_POLL_TIMEOUT_MS;
> +
> +	if (msb > 15 || lsb > msb) {
> +		phydev_err(phydev, "Invalid firmware bits: msb=%d, lsb=%d\n", msb, lsb);
> +		return -EINVAL;
> +	}
> +
> +	switch (entry->type) {
> +	case OP_WRITE:
> +		ret = phy_modify_mmd(phydev, dev, addr,
> +				     GENMASK(msb, lsb), (value << lsb) & GENMASK(msb, lsb));
> +		if (ret) {
> +			phydev_err(phydev, "WRITE failed: dev=%d addr=0x%04x\n", dev, addr);
> +			return ret;

Here you have a return on error.

> +		}
> +		break;
> +
> +	case OP_POLL: {
> +		bits = GENMASK(msb, lsb);
> +		expect_val = (value << lsb) & bits;
> +
> +		if (poll_set)
> +			ret = phy_read_mmd_poll_timeout(phydev, dev, addr, val,
> +							(val & bits) == expect_val,
> +							1000, timeout_ms * 1000, false);
> +		else
> +			ret = phy_read_mmd_poll_timeout(phydev, dev, addr, val,
> +							(val & bits) != expect_val,
> +							1000, timeout_ms * 1000, false);
> +		if (ret)
> +			phydev_err(phydev, "POLL timeout: dev=%d addr=0x%04x\n",
> +				   dev, addr);
> +		break;

Here you don't. It would be better if the code was consistent.

> +	}
> +	default:
> +		phydev_err(phydev, "Unknown firmware operation: %d\n", entry->type);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int rtl8261x_fw_load(struct phy_device *phydev)
> +{
> +	struct rtl8261x_priv *priv = phydev->priv;
> +	const struct rtl8261x_fw_entry *entry;
> +	const struct rtl8261x_fw_header *hdr;
> +	const struct firmware *fw;
> +	int ret, i;
> +
> +	if (!priv->fw_name)
> +		return 0;
> +
> +	ret = request_firmware(&fw, priv->fw_name, &phydev->mdio.dev);
> +	if (ret) {
> +		phydev_err(phydev, "Failed to load firmware %s: %d\n", priv->fw_name, ret);
> +		return ret;
> +	}
> +
> +	ret = rtl8261x_verify_firmware(phydev, fw);
> +	if (ret)
> +		goto release_fw;
> +
> +	hdr = (const struct rtl8261x_fw_header *)fw->data;
> +
> +	entry = (const struct rtl8261x_fw_entry *)(fw->data + FW_HEADER_SIZE);
> +	for (i = 0; i < le16_to_cpu(hdr->num_entries); i++, entry++) {
> +		ret = rtl8261x_fw_execute_entry(phydev, entry);
> +		if (ret) {
> +			phydev_err(phydev, "Entry %d failed: %d\n", i, ret);
> +			goto release_fw;
> +		}
> +	}
> +
> +	priv->fw_loaded = true;
> +
> +release_fw:
> +	release_firmware(fw);
> +	return ret;
> +}
> +
>  static int rtl8261x_config_intr(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -484,6 +683,26 @@ static int rtl8261x_config_aneg(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int rtl8261x_config_init(struct phy_device *phydev)
> +{
> +	struct rtl8261x_priv *priv = phydev->priv;
> +	int ret = 0;
> +
> +	/* The firmware parameters are preserved across IEEE soft resets and
> +	 * suspend/resume cycles. Reloading is only necessary after a power
> +	 * cycle or hard reset.
> +	 */
> +	if (priv->fw_name && !priv->fw_loaded) {
> +		ret = rtl8261x_fw_load(phydev);
> +		if (ret) {
> +			phydev_err(phydev, "Firmware loading failed: %d\n", ret);

It seems pretty verbose when things go wrong. Do you need an error
message at every level?

    Andrew

---
pw-bot: cr

