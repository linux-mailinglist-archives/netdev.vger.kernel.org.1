Return-Path: <netdev+bounces-304166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ehI3MLlYRmolRQsAu9opvQ
	(envelope-from <netdev+bounces-304166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAB6F788D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=YkrZYCt9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304166-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AB430BB8F8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C102C3251;
	Thu,  2 Jul 2026 12:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DC1CAA65
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 12:12:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994342; cv=none; b=i+K6780DlcqLBwz54Xr/JATpbxxUQ/Q/etMAGzIw2Y32T0hj0MeVjnoYTp6HOqtCNzrQnkKtctgxkdhoirRdilUWAMQox0stqkcYKSEAZOuHF8CO5LZWo6zok1UWvsp5vp7OQlkPq8kGgByNhaFnAMiqfoRqBCKVGdt+mDqLOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994342; c=relaxed/simple;
	bh=FIQvElP/fvaVWnHu7KLwOaoMX8VDXQHaIO9ym/nDSzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDJCGRZIP3396zl9/V4MyrQNBK0+JjxMPcUtnti4e/EyISt4ZWSP1kVQ2NayzuL5gHSebNAJNbGQfs1BfadIRy+rqXbyZKXRfeBNkskbii6EZAUdcFepd7Wsje+K67W+4QiHo2Gy1OQV8w8kuYJDGEF9NkpW4vmvTadcERLgfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YkrZYCt9; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3AA994E40C20;
	Thu,  2 Jul 2026 12:12:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0668D5FF03;
	Thu,  2 Jul 2026 12:12:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DA51104C951E;
	Thu,  2 Jul 2026 14:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782994336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SDqqvdIPwdQ1ISpj6SeugRYWTbMp3olpgMT1hBJXflo=;
	b=YkrZYCt98wZVf6fWfCIFd0gznXr/wvOApAjnlK3pjx7fGI3lbIHaYsYuiiv/Y3AUgO26J+
	svPe4AiNNJel7U7kDGMszLv84WwHUg6b8xFZFo/1BdHEHJt9fXtWG5o27lDLOsKhnO5VQn
	VL3RcYUsZZnpXSmyAI9+80mWkzpTdmJujJNQAXRH6hwus6inWlt2j08/UC+sQitJYMOEyK
	h3J148VodsPzcExLn/yTERVMru4oqOd5ncojqw1LmmzEx0471ErDR3iyrTJ9Cbu1C3y1mN
	PMJP9LUDsdkP4SShWjfi74hEEuzbxLRgFOopfrhfhgRelln5mbRvvHESFBRvug==
Message-ID: <9f777a53-f38e-4730-b95f-25f53cdaafc7@bootlin.com>
Date: Thu, 2 Jul 2026 14:12:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
To: javen <javen_xu@realsil.com.cn>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn, nb@tipi-net.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com
References: <20260702032020.589-1-javen_xu@realsil.com.cn>
 <20260702032020.589-2-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260702032020.589-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304166-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBEAB6F788D

Hi Javen,

On 7/2/26 05:20, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the reset
> bit in the PMA/PMD control register and waits until the bit is cleared by
> hardware.
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes, new file
> 
> Changes in v3:
>  - re-order function according to the order in phy-c45.c
> 
> Changes in v4:
>  - no changes
> 
> Changes in v5:
>  - no changes
> 
> Changes in v6:
>  - increase timeout to 600ms
> 
> Changes in v7:
>  - no changes
>  
> Changes in v8:
>  - no changes
> ---
>  drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
>  include/linux/phy.h       |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 126951741428..60d044156a83 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -384,6 +384,28 @@ int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart)
>  }
>  EXPORT_SYMBOL_GPL(genphy_c45_check_and_restart_aneg);
>  
> +/**
> + * genphy_c45_soft_reset - software reset the PHY via Clause 45 PMA/PMD control register
> + * @phydev: target phy_device struct
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int genphy_c45_soft_reset(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
> +			       MDIO_CTRL1_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
> +					 MDIO_CTRL1, val,
> +					 !(val & MDIO_CTRL1_RESET),
> +					 5000, 600000, true);
> +}
> +EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);

Can you name it genphy_c45_pma_soft_reset() instead ? That's the common
naming pattern for C45 generic helpers targetting the PMAPMD MMD.

This will avoid some confusion as some in-tree drivers also configure the
MDIO_CTRL1_RESET register, but from the PHYXS or PCS MMDs.

Thanks,

Maxime

>

