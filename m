Return-Path: <netdev+bounces-296184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0dOiNw8IJWqyCwIAu9opvQ
	(envelope-from <netdev+bounces-296184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:56:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE664EE98
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:56:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=l37jFAbX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296184-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 350AF300DF6E
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A92E736E;
	Sun,  7 Jun 2026 05:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14564071DA;
	Sun,  7 Jun 2026 05:56:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811781; cv=none; b=rs7W+Tg55ovkkbtBENV/ZstcYIwIy8HhK0PLzFFcsb5Hkpx7Fsq3uDo3dySm4qPu1QVY2urmhYNrqMxjaZvurDbURlTRK3DlKsx8CK41qjVzQ7lNhrR8lmQIf0DmDie+SdlUO8PvO7sGF/uVrCeGkcgvJRff9xoLE4tBE/+Yea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811781; c=relaxed/simple;
	bh=O9bbc55RP/7DjZLkIIfk+yflRtnl8laxQO5F2O17ctk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm3e94Na2LcpzgKlLAza07MyQDrkFRoo6oSGMrsLDY652P0r5o35uArrFA+B0WUd1pnbcvvfjvk9qBtY4utyRM78hKiqArr9jUHUCwrL4GtLmyAYuO+/ITYx5jJ9U6a8kacXtVBC8nWEdw5d0uK14/QwsYy3aYxhR4kO9mZa4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l37jFAbX; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NeQ6BYZhusOLotH8hK5nOEdFbaxx2YSTHNnlF45nJRw=; b=l37jFAbXe/eOSoJeT1rV1vGLYM
	bxLPOzGyVCqg7uJymupQNnvwoAsw2whFY6fP+PC1+rXT5rRgMg6kVbEFVwcMC1egm1nnDninToJy5
	RjMIezei0nTogdZG+dopGVR8lcmHsqYSUzpvgClHnczxuzyy9qc/UD16Iu22rLHILG+0njdOZ7IPH
	KFVzdHCCMIpI9dB2H+ty7GK7v4YEVRdnf/8bECD2fpfR7eje8TWWW+jLH0Y9ZRNKl/HWut97xMZBp
	rDMxKKU9pp7OOJW8dfK2o+fGQp5pXCzG3soN4X9VuNHctUQv1CUi4KftJNwMBXlpw9j1XxWq7fxgI
	od1kRvRQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW6UZ-000000023dZ-4AMN;
	Sun, 07 Jun 2026 05:56:16 +0000
Message-ID: <7b100b6a-40c5-407d-8de0-7b1edb82a16c@infradead.org>
Date: Sat, 6 Jun 2026 22:56:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/16] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
To: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jerry Ray <jerry.ray@microchip.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-13-de0fbc13c6d8@onsemi.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-13-de0fbc13c6d8@onsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296184-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:from_mime,infradead.org:dkim,onsemi.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68CE664EE98



On 6/5/26 10:42 PM, Selvamani Rajagopal via B4 Relay wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> Support for onsemi's S2500, 802.3 cg compliant Ethernet
> transceiver with integrated MAC-PHY. Works with
> Open Alliance TC6 framework.
> 
> adjtime callback is implemented using adjfine. If time
> delta is too big, bigger than 1 second, using adjtime
> would take long to reduce the delta. In those cases,
> settime callback is used to reduce the delta. Once delta
> becomes less than a second, it uses adjfine to reduce
> the drift further.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  MAINTAINERS                                       |   7 +
>  drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h      |   2 +-
>  drivers/net/ethernet/onsemi/Kconfig               |  21 +
>  drivers/net/ethernet/onsemi/Makefile              |   7 +
>  drivers/net/ethernet/onsemi/s2500/Kconfig         |  21 +
>  drivers/net/ethernet/onsemi/s2500/Makefile        |   7 +
>  drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c | 347 ++++++++++++
>  drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h  | 225 ++++++++
>  drivers/net/ethernet/onsemi/s2500/s2500_main.c    | 632 ++++++++++++++++++++++
>  drivers/net/ethernet/onsemi/s2500/s2500_ptp.c     | 233 ++++++++
>  10 files changed, 1501 insertions(+), 1 deletion(-)
> 

> diff --git a/drivers/net/ethernet/onsemi/Kconfig b/drivers/net/ethernet/onsemi/Kconfig
> new file mode 100644
> index 000000000000..8dd3a3f074a2
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# onsemi network device configuration
> +#
> +
> +config NET_VENDOR_ONSEMI
> +	bool "onsemi network devices"
> +	help
> +	  If you have a network card belonging to this class, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about onsemi ethernet devices. If you say Y, you
> +          will be asked for your specific card in the following questions.

Above line should be indented with one tab + spaces.

> +
> +if NET_VENDOR_ONSEMI
> +
> +source "drivers/net/ethernet/onsemi/s2500/Kconfig"
> +
> +endif # NET_VENDOR_ONSEMI
> +


> diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
> new file mode 100644
> index 000000000000..22b0afad7a21
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# onsemi S2500 Driver Support
> +#
> +
> +if NET_VENDOR_ONSEMI
> +
> +config S2500_MACPHY
> +	help
> +	tristate "S2500 support"
> +	depends on SPI
> +	select NCN26000_PHY
> +	select OA_TC6
> +	  Support for the onsemi TS2500 MACPHY Ethernet chip.
> +          It works under the framework that conform to OPEN Alliance
> +          10BASE-T1x Serial Interface specification.
> +
> +          To compile this driver as a module, choose M here. The module will be
> +          called s2500.

Kconfig help text should be indented with one tab + 2 spaces (applies to
all lines following the "Support for the ..." line).

> +
> +endif # NET_VENDOR_ONSEMI
> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
> new file mode 100644
> index 000000000000..fd6617c7ac79
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c


> +static int s2500_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct s2500_info *priv = container_of(ptp, struct s2500_info,
> +					       ptp_clock_info);
> +	u32 sign_bit = 0;
> +	long adj;
> +	u32 val;
> +	u64 ppm;
> +
> +	if (scaled_ppm < 0) {
> +		/* split sign / mod */
> +		sign_bit = 1U << 31;
> +		scaled_ppm = ~scaled_ppm + 1;
> +	}
> +
> +	/**

Use	/*
since this is not a kernel-doc comment.

> +	 * Convert unsigned scaled_ppm to atto-seconds per clock cycles.
> +	 * The scaled_ppm format is Qx.16 --> 1 lsb = 1/65536 ppm.
> +	 * The clock period of the S2500 is 8ns (125 MHz), so 1 lsb of
> +	 * adj register LSB is 1 atto-sec / 8ns = 0.000125 ppm.
> +	 * Represented in Qx.16 format, this is 0.000125 * 2^16 = 8(.192)
> +	 * To convert scaled_ppm into a register value we need to divide
> +	 * it by the LSB value, hence adj = (scaled_ppm * 1000) / 8192 to
> +	 * minimize the precision loss due to the integer arithmetic.
> +	 * That further reduces to (scaled_ppm * 125) / 1024.
> +	 */
> +	ppm = (u64)scaled_ppm * 125;
> +	do_div(ppm, 1024);
> +	adj = (long)ppm;
> +
> +	/* check overflow */
> +	if (adj >= (1L << 28))
> +		return -ERANGE;
> +
> +	val = (u32)adj | sign_bit;
> +	return oa_tc6_write_register_mms(priv->tc6, S2500_REG_VS_PTP_ADJ,
> +					 OA_TC6_PHY_C45_VS_MMS12, val);
> +}


-- 
~Randy


