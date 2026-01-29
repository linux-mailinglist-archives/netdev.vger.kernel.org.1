Return-Path: <netdev+bounces-254778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC8qEABOe2n9DgIAu9opvQ
	(envelope-from <netdev+bounces-254778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:09:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9618EAFEA0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CB78303DD7F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E23385EE1;
	Thu, 29 Jan 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNm06Yzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84621289340;
	Thu, 29 Jan 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688484; cv=none; b=As7w/J6r3cvC/EIG41mT9l3Es3KTjJEXKqi79Oimj1KI7TC+9Yb1GDWeoCGmgB39ZQ/tp94b7YfHLw3ZDX9uhM7S7dkIJjG7fXe17g1pPumhhDnY3s2Ln7rlM1KLQCt3657YzYIgxnXSjloI4YyqyNnTSlFcslm7Urq/56O144I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688484; c=relaxed/simple;
	bh=wqvYiaougo9MgdPRxH7kVqp/5WhviKS4oyIBj/a1l5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnJ6pge2l6xdyL+vch7SC2WA8xWSJj6D+G0Tv5wv/AelB3moQaBKfLpILlc33Jr4o8jU+xkDw7WR/8gXN0jGFCHCkXlx1CLtdp+6w2+oDae214cKt8bixqVUNviAD6klmFEmmioN2d4oS7JibNfGmaJ5Lf8WBsfpwesJh0MwjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNm06Yzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE224C116D0;
	Thu, 29 Jan 2026 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769688484;
	bh=wqvYiaougo9MgdPRxH7kVqp/5WhviKS4oyIBj/a1l5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNm06YzlYWUIvC+UHY6+rfdL/fSPmSiM1O1bwsVae1CYKPEPfGojHo/u4XVeRTkPb
	 zGJSnVHoGhxlyzAfDSWu+SICeSlFM0FkOQvis9LV7RtZWiJ5aqcO6pMFc5ViLc/Swm
	 PQOSLglhpraPpwoTUh9tziGgXEqlVZbex8M8TB7ghxffsuMIHvLlVafTkeU5C6Rk0b
	 yvmeTKpunVYQNE0/gn72MLgzAxTYn3QiGJEfopAEUMEkqQjttlqDmt2I3J051VtWVV
	 gl+GCccV9vum4vW1FkdtB6btpYMRTQ3LyOxlo5o5Uciwi0oOfWj5r0llS82gWJIlhi
	 fSnvfFtiNjIoQ==
Date: Thu, 29 Jan 2026 12:07:57 +0000
From: Simon Horman <horms@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com, bogdan-gabriel.roman@nxp.com,
	Ionut.Vicovan@nxp.com, alexandru-catalin.ionita@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, Frank.li@nxp.com
Subject: Re: [PATCH 4/4] MAINTAINERS: Add MAINTAINER for NXP S32G Serdes
 driver
Message-ID: <20260129120757.GA358439@kernel.org>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-5-vincent.guittot@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254778-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9618EAFEA0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:59AM +0100, Vincent Guittot wrote:
> Add a new entry for S32G Serdes driver.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa218..888674a308a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3202,6 +3202,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
>  
> +ARM/NXP S32G SERDES DRIVER
> +M:	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> +R:	NXP S32 Linux Team <s32@nxp.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/nxp,s32g-serdes.yaml

This patchset adds the following file, not the one above:

Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
                                  ^^^

> +F:	drivers/phy/freescale/phy-nxp-s32g-*
> +F:	include/linux/pcs/pcs-nxp-xpcs.h
> +
>  ARM/Orion SoC/Technologic Systems TS-78xx platform support
>  M:	Alexander Clouter <alex@digriz.org.uk>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.43.0
> 

