Return-Path: <netdev+bounces-287175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJNmDBY5A2q11wEAu9opvQ
	(envelope-from <netdev+bounces-287175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:28:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F716522770
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F01312D9A7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA243911A6;
	Tue, 12 May 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MdHX5i1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2B3E1730
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592743; cv=none; b=YF2aEugGmtAbJ80IQ8IuYgL7V+/O+JZuDiZlVHv5e6wxEySzzIADJneLAcg8z8EbLZeU0hQYhMmrSFgLDU8pi3cxEicK5Y2zId83pEcgu9dkKQhg6WjFw16+I4zMRYNCIjP3krSrcC4h6pt1NHaYilAykSAjqwGHAN9RloxL7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592743; c=relaxed/simple;
	bh=2a0VEEh++ToCnDM9Nu78zdEEiYidXVyrGVfaJTq+Q0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFDelYIhTOYo4Mx4JzRecEKq2x2cEY506ekcDUvgh0BF1QCeBXfKywViHj8PlflDjSBZ+16XLx36BZVMHFwGvvwd4JTiA+I0VPZfjihuizRhR6YqELDrKQavg5pOi6d398Fs+1WxOkarfXeQ83Yjq/lRl1WDmS2prHBNbFLoxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MdHX5i1Q; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B01A74E42C83;
	Tue, 12 May 2026 13:32:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7972F60646;
	Tue, 12 May 2026 13:32:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F14E311AF874F;
	Tue, 12 May 2026 15:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778592739; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wbVp7XXps13Zl+aS41wr/B33E+sqORYJAXToq+Zs+Ik=;
	b=MdHX5i1Q8NssOZq+1LruwkFS6kyKJ4OV8H3ot/+3hAFAfhsbunczThxiQWnNZxANw74X5V
	zMeWluvrhl//mYxDzfVc8KUIEG2cgEtqxBQwRd0gum7+HWwrEWMcjbR3LxwWZRn+An5AOv
	eeuWQ0VNbwCRZfnIFcvM662lvqfdPsCQX9dAGDMVPUSZwve68pLbzyUlgRxquewNv/5RiH
	4YGuBgmUIvBzR3S+jXfVMHogC/zTTKUukH7tlUQMR4g51xa/K1Ip8GTmRM3oyN9gENMmKi
	6V5o65XlpWme6f4JAQNwmcqu5B6Y2xvMozTc8Be7416H7/3k5w38FxkfDlI0zw==
Message-ID: <91f86e6c-6013-42cc-8a4b-2b32093b9eae@bootlin.com>
Date: Tue, 12 May 2026 15:32:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
To: Minda Chen <minda.chen@starfivetech.com>, Frank
 <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
 <20260508094522.3952-3-minda.chen@starfivetech.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260508094522.3952-3-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9F716522770
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[starfivetech.com,motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action



On 5/8/26 11:45, Minda Chen wrote:
> Set RXD and RX CLK pin drive strength while in YT8531s connect
> with RGMII.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   drivers/net/phy/motorcomm.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index c66804537aa2..ebc24f51e626 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1698,6 +1698,11 @@ static int yt8521_config_init(struct phy_device *phydev)
>   		if (ret < 0)
>   			goto err_restore_page;
>   	}
> +
> +	if (phydev->drv->phy_id == PHY_ID_YT8531S &&
> +	    phy_interface_is_rgmii(phydev))
> +		ret = yt8531_set_ds(phydev);

Minor detail if you re-spin, there's already a check for the interface 
being RGMII a bit above in the same function, but it's written as :


	/* set rgmii delay mode */
	if (phydev->interface != PHY_INTERFACE_MODE_SGMII)
            ...

could be a good idea to change that check to a more explicit
call to phy_interface_is_rgmii(), or even add the drive-strength
configuration under the same block, provided the order of operation
doesn't matter w.r.t the pll/auto-sleep configuration.

Maxime

> +
>   err_restore_page:
>   	return phy_restore_page(phydev, old_page, ret);
>   }


