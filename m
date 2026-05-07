Return-Path: <netdev+bounces-285397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMplAGyy/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 081614EB3B4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B265230046A7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1272C21D0;
	Thu,  7 May 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vXm+p9QW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5706436373
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168407; cv=none; b=rftNG9sf/7+XhGWQlw8L9oFlZNmZDLq0lFLUDpYDiZCkrGZge6bEaUGgD/EMhHTQasLO5iZyRm7s+7aTuwQUapZelwUBPs++mJ/NykCrnNQGWdHJIrS4kSFzZXOE8YJAB0GEUXfbsL33YLtOMMaa9c4qMkHDfFljdJfJoY/B4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168407; c=relaxed/simple;
	bh=jerrllfrOVPMP1unBGEIZ/yLuUL//c6bKh8SFy2Ubzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzP47W+FuPMMhv8ZgWcTPlXOUUzoY1tNld1ErSOaFS1i38AAvRnpHur+csbEn+gfONunAB4sLbag3B828rM/qC3C1kISCFjIVum+JWE5E9+jua5daS0APXCIVf1fbHp/Y/hQWdvwmv2E4WRedY1VOSAuPYPM3tapdm29Nlajgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vXm+p9QW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 117F64E42C35;
	Thu,  7 May 2026 15:40:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAAD560495;
	Thu,  7 May 2026 15:40:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 890D7108194AC;
	Thu,  7 May 2026 17:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778168402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=j+eVuruoMT4+C+KmGa1r15UlGIkj6f13hTtTAA+iRwQ=;
	b=vXm+p9QWSZ7gtaRbh+Y/o0qUnjmhF8MZ7CoXH66dQeFhzNjFD1xXIlj5kbLeAVx1pnNZKA
	KfMS47hyQI9LqhyLdtChHgN40pLLyZxO5TiFFv/IEwPVxeSywnHvkBfstYYuHyTPcHGT4P
	zi2enQztmnCJd/0GhRWpuW2XND12p3IvYuU3H00Jma7lDVUVWQcy0oJt/UEhjI8mJ4t3cx
	hhIlj9C3Urvbuv42nKiyy1MjH4x88mmBe2YHUOyYvuZUR58TYMOjXQaF3iD5VVlmP1OWpl
	RifqpXJ4R6yGVOgUEKtoGGJqWTCvRBJLENbIm7DDzqZtFhQkQE4c+hK/NGfsSA==
Message-ID: <329ee928-2694-4348-a6f7-099618081dde@bootlin.com>
Date: Thu, 7 May 2026 17:39:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethtool: fix NULL pointer dereference in
 phy_reply_size
To: Quan Sun <2022090917019@std.uestc.edu.cn>, netdev@vger.kernel.org,
 andrew@lunn.ch
Cc: kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 081614EB3B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	TAGGED_FROM(0.00)[bounces-285397-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[bootlin.com:s=dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,uestc.edu.cn:email]
X-Rspamd-Action: no action

Hi,

On 07/05/2026 15:17, Quan Sun wrote:
> In phy_prepare_data(), several strings such as 'name', 'drvname',
> 'upstream_sfp_name', and 'downstream_sfp_name' are allocated using
> kstrdup(). However, these allocations were not checked  for failure.
> 
> If kstrdup() fails for 'name', it returns NULL while the function
> continues. This leads to a kernel NULL pointer dereference and panic
> later in phy_reply_size() when it unconditionally calls strlen() on
> the NULL pointer.
> 
> While other strings like 'upstream_sfp_name' might be checked before
> access in certain code paths, failing to handle these allocations
> consistently can lead to incomplete data reporting or hidden bugs.
> 
> Fix this by adding proper NULL checks for all kstrdup() calls in
> phy_prepare_data() and implement a centralized error handling path
> using goto labels to ensure all previously allocated resources are
> freed on failure.
> 
> Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

> ---
> Changes in v2:
> - Add Fixes: tag.
> - Expand the fix to cover all kstrdup() allocations in the function.
> - Use goto labels for a cleaner and more robust error handling path.
> ---
>  net/ethtool/phy.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index d4e6887055ab1..f76d94d848d6d 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -76,6 +76,7 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>  	struct nlattr **tb = info->attrs;
>  	struct phy_device_node *pdn;
>  	struct phy_device *phydev;
> +	int ret;
>  
>  	/* RTNL is held by the caller */
>  	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
> @@ -88,8 +89,17 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>  		return -EOPNOTSUPP;
>  
>  	rep_data->phyindex = phydev->phyindex;
> +
>  	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
> +	if (!rep_data->name)
> +		return -ENOMEM;
> +
>  	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
> +	if (!rep_data->drvname) {
> +		ret = -ENOMEM;
> +		goto err_free_name;
> +	}
> +
>  	rep_data->upstream_type = pdn->upstream_type;
>  
>  	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {
> @@ -97,15 +107,33 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>  		rep_data->upstream_index = upstream->phyindex;
>  	}
>  
> -	if (pdn->parent_sfp_bus)
> +	if (pdn->parent_sfp_bus) {
>  		rep_data->upstream_sfp_name = kstrdup(sfp_get_name(pdn->parent_sfp_bus),
>  						      GFP_KERNEL);
> +		if (!rep_data->upstream_sfp_name) {
> +			ret = -ENOMEM;
> +			goto err_free_drvname;
> +		}
> +	}
>  
> -	if (phydev->sfp_bus)
> +	if (phydev->sfp_bus) {
>  		rep_data->downstream_sfp_name = kstrdup(sfp_get_name(phydev->sfp_bus),
>  							GFP_KERNEL);
> +		if (!rep_data->downstream_sfp_name) {
> +			ret = -ENOMEM;
> +			goto err_free_upstream_sfp;
> +		}
> +	}
>  
>  	return 0;
> +
> +err_free_upstream_sfp:
> +	kfree(rep_data->upstream_sfp_name);
> +err_free_drvname:
> +	kfree(rep_data->drvname);
> +err_free_name:
> +	kfree(rep_data->name);
> +	return ret;
>  }
>  
>  static int phy_fill_reply(struct sk_buff *skb,


