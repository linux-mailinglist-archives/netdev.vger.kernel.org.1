Return-Path: <netdev+bounces-297249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aSC4FP5qKGq7DwMAu9opvQ
	(envelope-from <netdev+bounces-297249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:35:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E354A663C76
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:35:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="cDZNY/5U";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297249-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37A8A308D920
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF63749F7;
	Tue,  9 Jun 2026 19:24:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE73749F4
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:24:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033044; cv=none; b=Od/lGbhQRKMIRaC+ZIXVe6j73wCb5GHuoKhrcWJZqqftojnuLdiW0zOi4BClqQWVFEYW1pt2lwpHNTlnH7SK/y/elRCZqZwYnVlIQNzbgcBRpQQ+KDqjTSdp8fwdL6/W4E3+eEGa8UZmnwewFHL7We3/q1uLm2ookh0dfTy5UA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033044; c=relaxed/simple;
	bh=KvsC5nRKzTCjDyZ66c8XtBXAe/nECRHrp8xUHUPG6+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsXSnfPe2Kx7kGGQ9qgMDhkB9cORySnHpyAgIF7061qSRA8ULhgFMSWzQCj4uJEA0P2R6sV9hNUnpwUTRVXqAwH7pAHFKEgnGd4fPFBBxsD2sOpZPhoPXl7lq+ynUvzY5PBMww4+SUfDBsF1yTmo5xuozJ3C/Xbshk4b8Ha6d+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDZNY/5U; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2a68d01so40778945ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033042; x=1781637842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEQGGRW4b0GaQRZu4FO2Zva3PukuIGlCXhRpTHldels=;
        b=cDZNY/5UpGCDj7R3FPK0A53G6sQEhUlNM0WT/JJBy+hv4UkxXfODrXvRrs1e0BGIV3
         pk0pnYL/6sN8F+FXMAVGsBYj/kTsJRSI+mF2FMdhvABTndBQ8fF4rswA0wu94pyYkIpy
         /2xoBNqKT+pUzJLfz0loNWFEY/XQUrSywtc2PGeNldAWnTmIhPyGMcIDnAjApS53IE5z
         frIE4dcaTSuqLHVprqyOTk2ZdEXBeFqqwww3qfOdpIlkbJOPrz6xTAq+JoaOhEYLhNgu
         4WGYSI1KL/XhgZiq92U9jY/T3qkT7UhLAYq5cviYm7Tpz8/bGTN7JwxJKYwy89BgtGgg
         NAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033042; x=1781637842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEQGGRW4b0GaQRZu4FO2Zva3PukuIGlCXhRpTHldels=;
        b=WA3PDjOefsAn/Q4Wg2JKvEqHIEXOdeK5a1ketHTEj/yX/y6rDtc77j7I34GIa2NkmM
         EzF5HCm/wfXN7zUGf1fq9s4YRq2K9zVBWJH57FyAiTKkQJ6dRpKsKHpM08k9mmSxhYUK
         WHE8ktpg6c7+uxAiPgh3bbdYm7IuEx0WMAHI++NzDUURjLgcqdF1lSY5BKpUYgWag2Ui
         K1w2XIRjlr/cywurrpWCnmY6NzNUhdGUteUO/fbiFb/NipiWC6VlN0g7bCgDBLmMHbYF
         2n/az9Z6WxVQEG9hVRiJUUImWlT5ZVoGmUzZGKbGKD4cnKlwhq5qZXTTrZH34B1Olo4Z
         /GhA==
X-Forwarded-Encrypted: i=1; AFNElJ8y0G6mwKH7rjAvn86952GYVG1StwXlKZHAaPqDzhO7BEraHL/qXqZz/BC7DPxjg2skC1m6cn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMaOChDl0BaSeh8CjIHznqCJMKt+aXPqEwKHgXJ/eNlss6hbN
	JQ5NHoRjye6pMIDS+tkFIJJdjWxS82lu7eyC89xMajZchw9/dDiZNNXK
X-Gm-Gg: Acq92OEn6zxoGQvBl9ZGyttwOeG2ai3G5Xe3tstIlJKyTW1PUdNT82rg7Ca8DJzT3Sm
	1V71+Ja/Ix6PesF9aczLmMQgOPWv8zmq8PjD32BGOFsFVVJWsXyMwoMO6nPoBx2/HUIRfnHPiHw
	8AhhydxKJPkPbJ4UMEIdP69APjzMvwobdZS/TKmP96EvN3FuqL73T6iwS0J0FezOPXuh0LxUNX5
	DBJYDUsP7hMAsg8kODxH68G2DIclpQuh4WLov+i+Ltyl1IeCsxp2pCNkJ4krRA+nBJwAugqtOje
	ACgaAdUl2BGNSR0CyNvcy4fE78MsFm4IzrgmvN9WkiEYZe1NZFoqsNANPEcbap1JgKLx16jdxGG
	ZF3GKusvTtIhbCAJ7du3zx7vi5UsdmNjW0Kgf0rwCHHTbhOgMn4KBsHdzmHgzsVkxDFYmTnjzWo
	R5GOc5ZZbFSQ40nxKXq7WO6ueAt4fqRm/nSu51pWjXFSCnJJ6+MICDNpU=
X-Received: by 2002:a17:902:da88:b0:2c0:b5c1:8e21 with SMTP id d9443c01a7336-2c1e7e4ca11mr254437915ad.16.1781033042500;
        Tue, 09 Jun 2026 12:24:02 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1646e5c51sm223459965ad.0.2026.06.09.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:24:02 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:24:00 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 1/4] netdev: check for nla_put_u32() failures
Message-ID: <aihoUMwR+/1kyQ3Z@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-2-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-297249-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E354A663C76

On Tue, Jun 09, 2026 at 12:08:01PM -0700, Jakub Kicinski wrote:
> Make sure we check if nla_put_u32(id) was successful after creating
> objects. This is theoretical today, the skbs are large enough to
> always fit the ID.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4d48f3672a5..a10d353d5eab 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1091,7 +1091,10 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  			goto err_unbind;
>  	}
>  
> -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	if (err)
> +		goto err_unbind;
> +
>  	genlmsg_end(rsp, hdr);
>  
>  	err = genlmsg_reply(rsp, info);
> @@ -1227,7 +1230,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_unlock_bind_dev;
>  	}
>  
> -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	if (err)
> +		goto err_unbind;
> +
>  	genlmsg_end(rsp, hdr);
>  
>  	if (bind_dev != netdev)
> @@ -1237,6 +1243,8 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	return genlmsg_reply(rsp, info);
>  
> +err_unbind:
> +	net_devmem_unbind_dmabuf(binding);
>  err_unlock_bind_dev:
>  	if (bind_dev != netdev)
>  		netdev_unlock(bind_dev);
> @@ -1394,7 +1402,12 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	netdev_rx_queue_lease(rxq, rxq_lease);
>  
> -	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	err = nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	if (err) {
> +		WARN_ON_ONCE(1); /* we can't delete the queue, ID must fit in */
> +		goto err_unlease;
> +	}
> +
>  	genlmsg_end(rsp, hdr);
>  
>  	netdev_unlock(dev_lease);
> @@ -1404,6 +1417,8 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	return genlmsg_reply(rsp, info);
>  
> +err_unlease:
> +	netdev_rx_queue_unlease(rxq, rxq_lease);
>  err_unlock_dev_lease:
>  	netdev_unlock(dev_lease);
>  err_put_netns:
> -- 
> 2.54.0
> 
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

