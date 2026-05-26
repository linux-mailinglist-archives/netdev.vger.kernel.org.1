Return-Path: <netdev+bounces-291827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBy6JTXUFWrRcgcAu9opvQ
	(envelope-from <netdev+bounces-291827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C85DA639
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91DC30AAECC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC13932C5;
	Tue, 26 May 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YCWUJxSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23E38F934
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813706; cv=none; b=NHgfvSQjG6/wbVP58X4AMZEYhaHx7JpM9TLDewrVOIcyOVXQBMDWEx7lGd8O0mgfCUIa0oQZGMSf+N4oZk5GNZl027oyZub25/mhHRXsZdYxm/3BS3N1g8HQMFn4tmUPHEp1v7KpK3Xkjl8CKNAxp00VmSV6BElBLecLH2MPXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813706; c=relaxed/simple;
	bh=mG7PBVyeq9eqgY9w0WZ2Aq+R1WotFrAacyI5NUevEPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvRjrUVM3rVUsRqi97uVDmDa2eOo3sPt+oAujA2FX20q0VhAQTTTXMrxKTkSw49lyxgz+lTy0X9+321w7W2TeanJ2KCwQ6rrYopBCN5kE5/byV0fDtQRSNZMznJVc5sMIv1LxqJ/f2TouIyTKCo89kZSqg3094eWzOb0SHuvrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YCWUJxSK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A19E44E42D60;
	Tue, 26 May 2026 16:41:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E1A06011D;
	Tue, 26 May 2026 16:41:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D471C10888986;
	Tue, 26 May 2026 18:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779813700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=x2zp45sO/tKbVz5eCcWvfkcQYoo+j+EyKM6+LW9VNpQ=;
	b=YCWUJxSKmSFGKbG0oLl5eCKIqS0gLscEoKxxcldBJjGroYFPYWHouQNba4ycM8u10mhKDi
	V+TG9K+Cmnj5tgPRnPxXX+4eZ+BO3deJwTsWQ4LsyRgrY/YgBo+cE/eJtEBmyVrj0lQ6ql
	fEiAE30At8orL75DARDClhawzUSItuT5LExIfNJw10lWs4Qg6mkWWpp4pn/I7BnP8ST8V0
	m3ivbuIERwMZfgIR8YUiQGAUcndoIZYRuAhwc22l2JXDEbeqCg02EdQBRtqkraU2LxjFmB
	G56pvr8k+zT4NZakHEOTqbU3fXpqYITGgR4CGFJSFQEdDFBKS7WIwL0ipbxrjQ==
Message-ID: <8983c764-0977-44da-a311-8c558902b478@bootlin.com>
Date: Tue, 26 May 2026 18:41:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/10] ethtool: linkstate: fix unbalanced
 ethnl_ops_complete() on PHY lookup error
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-4-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291827-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: EB5C85DA639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On 5/26/26 17:35, Jakub Kicinski wrote:
> linkstate_prepare_data() calls ethnl_req_get_phydev() before
> ethnl_ops_begin(), but routes its error path through "goto out"
> which calls ethnl_ops_complete().
> 
> Fixes: fe55b1d401c6 ("ethtool: linkstate: migrate linkstate functions to support multi-PHY setups")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for fixing this,

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: o.rempel@pengutronix.de
> ---
>   net/ethtool/linkstate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
> index 8a5985fd7712..24569e92942c 100644
> --- a/net/ethtool/linkstate.c
> +++ b/net/ethtool/linkstate.c
> @@ -106,10 +106,8 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>   
>   	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
>   				      info->extack);
> -	if (IS_ERR(phydev)) {
> -		ret = PTR_ERR(phydev);
> -		goto out;
> -	}
> +	if (IS_ERR(phydev))
> +		return PTR_ERR(phydev);
>   
>   	ret = ethnl_ops_begin(dev);
>   	if (ret < 0)


