Return-Path: <netdev+bounces-304009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LP3YN4gRRmojJAsAu9opvQ
	(envelope-from <netdev+bounces-304009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:21:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DB6F420A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:21:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ea4vUYTX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304009-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69A630325A1
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A4366575;
	Thu,  2 Jul 2026 07:17:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B629D270;
	Thu,  2 Jul 2026 07:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976661; cv=none; b=McJssexP2pirEan65VdTRKrywSxzyPrcdWPI3Ksybls81YVLsUBcwZfg4zXHL7JW98m5kbQH0RGoznH6YTqK31Hxhn/6DH/g3h9/AT6N0g0+N0irkfKjCsRhSE++xToR0W0aFAE7UzIO8V6YYaFmMs5LFQKZcwnBP1tWtQXS0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976661; c=relaxed/simple;
	bh=m4lZ1xJkxvf6unvIMi1BMFfIpMeZ8goWxT99ZMwyAdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCf6xUWEMqs279Zic41deQBnw3CLlFStaCv00h1Opvt8QK+1LK05g6mtHYV0x3Vlb7JU2TmhGQHB7nF02a501uYOlG6o1F6CzaO6+ogOQITAKzvwW/8zHFCLn4mlvFmRaYfHSoIkjTu4rII9MUC/bqcUBifs6Jqv46hZOKF+a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea4vUYTX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03E01F000E9;
	Thu,  2 Jul 2026 07:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782976660;
	bh=FLfLHXB6XVnWPAXACR2GqBUMy1yDBcitTcqXrCAOdq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ea4vUYTX3wUakbg66YR5woPZX3N32vcgYgxn8ziX3MVs3kdw9eHLfFxHAffvA2dRn
	 cQnteDyEQiFEP23wofK62YFT9QjFrhpLc5RN8AyQth+sboFgch/ph7UQ9neEUVX07X
	 Mdg6SC5onZvhEslmJ96bEgAtOD/KId+4B7ov8daikBPq0FKuuufUTAbYgHv7tgeTUN
	 nDUIuHbYqWYIA9oT18hpw49uRSywadgbhQapaV0XaCfxJJH0R/+sOgfP5080L9D1+U
	 gXWhupXDn9gYZyj3zjUQhFBXpOnIkC3TeOiK1/JonB7vrUrwLs6BnY5C9kFHljCWvy
	 re4/7JUPFNpsQ==
Date: Thu, 2 Jul 2026 09:17:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Message-ID: <20260702-heretic-fractal-jackdaw-70681b@quoll>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,quoll:server fail,altera.com:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-304009-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quoll:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F6DB6F420A

On Tue, Jun 30, 2026 at 06:31:07AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Add device tree for the Intel SoCFPGA Agilex5 SoCDK TSN Config2 board
> variant. This configuration enables gmac1 as a TSN port alongside
> the standard gmac2 Ethernet port.
> 
> The TSN port (gmac1) uses GMII internally in the MAC but connects to an
> RGMII PHY. The mac-mode property is set to "gmii" to reflect the
> MAC-side interface, while phy-mode is set to "rgmii" for the PHY-side
> interface.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |   3 +-
>  .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 133 ++++++++++++++++++
>  2 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 270c70fdf084..fc7ba2c6384b 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -4,10 +4,11 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>  				socfpga_agilex_socdk_emmc.dtb \
>  				socfpga_agilex_socdk_nand.dtb \
>  				socfpga_agilex3_socdk.dtb \
> -				socfpga_agilex5_socdk.dtb \
> +			socfpga_agilex5_socdk.dtb \

Why are you making this change?

>  				socfpga_agilex5_socdk_013b.dtb \
>  				socfpga_agilex5_socdk_modular.dtb \
>  				socfpga_agilex5_socdk_nand.dtb \
> +				socfpga_agilex5_socdk_tsn_cfg2.dtb \
>  				socfpga_agilex72_socdk.dtb \
>  				socfpga_agilex7m_socdk.dtb \
>  				socfpga_n5x_socdk.dtb

Best regards,
Krzysztof


