Return-Path: <netdev+bounces-297275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0j95DE90KGrpEwMAu9opvQ
	(envelope-from <netdev+bounces-297275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:15:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C036E6640C5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:15:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TYPgfy8r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297275-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35A4E3015335
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54E37AA9C;
	Tue,  9 Jun 2026 20:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B638BF9A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:15:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036109; cv=none; b=n30XdVrXaXNy0+UDNpBZxZllcfCjLbNiPIbZPDC41jzLDf/Z8SvSTdf7IN33Izs+18b/1M2HGpHmlmJiHbWefWHCc7tsCNQEGML9MPdid8zFTsbiQBUpPEnkEv5PdKn7KUrh30mlgClAo6kHUaIRgL0PPOCsnIyOrGuRiRJtaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036109; c=relaxed/simple;
	bh=ni32S3ZZKgETMDz4ml6j7NCIjmL60789CRy1qWH12t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5GIdmQgfoJTXCl4e/DNak6Z1oQOd64xxlR4Eq+oONycXFCozX/rfp6sRA6jioPDtzwAbsbUu3LhSuNPR2e8saCiqy2ZbVvnqBcC5SsC5nzcPc/5YC6XBlJftQPTdy9SJ62QCdcDEDSsU6raXfDoUSpeyWkDjdqpLFw3msJJ6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYPgfy8r; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso41511295ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036107; x=1781640907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcta9DJJF/+9FQYJ8d4PmaXYDMPEQuy9H4s7ZwnOkbU=;
        b=TYPgfy8rkY/oKBPKnfqUB4cWKIfab3XqmemETT4fsIkZQagUqTJim3jETYRz46de58
         S7BI1a++8QhiVOvtMb4/KZzH/VkpksXVZ+QQU+/EMX+xAty1/KbmADjexJ2PaByjDGtA
         WTr9jRZtYg+LIkO6b8OKCcdjzRC9HxrK+SE2ZqT6JEYy4+EcwcojOiNq4UlM3a/lg3g1
         a3FogfO7vC+0PNOcV91LYs4l7h7zeZu5d4Qx9dhxgjzB4GTfo07qTVNbTE5+ClLiLT4P
         HpsQi3nNdhT8Ndv5WZdvL3Q20spV4A6FhJlnW7+VWN8hRzrtW9fgkCpx8n1AzUbXnG4f
         9SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036107; x=1781640907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hcta9DJJF/+9FQYJ8d4PmaXYDMPEQuy9H4s7ZwnOkbU=;
        b=gsxSZ87xk+FkJ3E4Ci95otBcrjRvopd0CcurS06X70GfdqX4hJ4Zl1nSZWS1szP0oG
         a8K03V3IOXXYHTbMiXNeTeigMDPlcoRaWx9FflNX5SqX3pbe0FyDRerqs2pP7Cthyhg4
         0BSRzZqLxwRC4EA0zyle9hK/pWWNDlygUwifiaDqKhnZV/Psby+RCVX4GAFYw2MhHQek
         aSkPLpDUMUJdEksQCwY2ES/sGjg0BsfVAZIeCg5JynlCM5g8ac3MzIMHe6eei4h+Ybda
         F21rGtRugOS/y7eB7dMNvvRIOonVWPVVWruzXNcAgebzFNtfl0chI6fyF7geENb75DDq
         Ia2A==
X-Forwarded-Encrypted: i=1; AFNElJ/F7oMsWb7DoB1iMVy7aBKUDgoDDhX1vKex5Dhuke1E/F6CnlEvRzjyHLLDkMLutuAOA/uY05M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvZLf+jPBi4K/gDvb/3OhupnIVLwjPU1M6s601l4rbFLwgP03
	x86bsRPGIRBBYOWnMck4ayj/fQdGdRNkkVAd5AAe1ppZv1JfvNUvRAqM
X-Gm-Gg: Acq92OES7PPOaiXgbeDavqk4Xf0+sD5FTp3Zd9H19S30RSoouTGbEgB+zvBAGEgc+V8
	vsLYdKhc9xajN1MrGVTyHNtGixjKUbay4n29z9ENUi7zHNEn6Qb/u8EayLtai/0w8/cxvrYl3uK
	RbIxxVdSmybSV0CohPIfFdA2RLJ39+HOgm9foIhkWsPpdIInQvXyYMf45uey1/D9WxxSwEbWC5R
	g/6mhSYO6D4rhTsFScIPA9rl7UJ5Z0ogo3NDiAbDKr2FONRk/Orx7UuS/tCs4KBstjsn1nXp4yx
	Ml8s1sY2asgPFbWIe4c4wuBOs1nRVQaruVNqwtkYTt+jgQ4Gg5NuH8q5ESzAR/lebdhqG6/ZqON
	yWV3h7w+Szjzrt+hKtAwkbx8hoZoqn7R+ex9E7cxiciCy+ufKwBVeozsVyCsuUXsDsLXHe3GC/b
	x/1W3U13+yiYU9tDc4ViG7pro/ghB6fUj+HVmBIg7CU2+H+JAE0MQnfA==
X-Received: by 2002:a17:903:2a87:b0:2bf:13b0:f8ed with SMTP id d9443c01a7336-2c1e7b2ce09mr314088215ad.3.1781036107225;
        Tue, 09 Jun 2026 13:15:07 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f88473sm241583735ad.25.2026.06.09.13.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:15:06 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:15:05 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 3/4] netdev: avoid skipping objects on race with
 device disappearance
Message-ID: <aih0ST30H9rlKX2f@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-4-kuba@kernel.org>
 <aihwlI9A2TKktq9I@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aihwlI9A2TKktq9I@devvm29614.prn0.facebook.com>
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
	TAGGED_FROM(0.00)[bounces-297275-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C036E6640C5

On Tue, Jun 09, 2026 at 12:59:16PM -0700, Bobby Eshleman wrote:
> On Tue, Jun 09, 2026 at 12:08:03PM -0700, Jakub Kicinski wrote:
> > If the currently dumped device disappears while we were mid-dump
> > we will get the next device without resetting the sub-object ID.
> > This is quite unlikely, it was reported by an AI tool not a real
> > user. Let's fix it for better dump consistency.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  net/core/netdev-genl.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index d35af460e886..18046ad0f883 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -310,11 +310,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> >  			err = -ENODEV;
> >  		}
> >  	} else {
> > +		unsigned long start_ifindex = ctx->ifindex;
> > +
> >  		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
> > +			if (ctx->ifindex != start_ifindex)
> > +				ctx->napi_id = 0;
> >  			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
> >  			if (err < 0)
> >  				break;
> > -			ctx->napi_id = 0;
> >  		}
> >  	}
> >  
> > @@ -634,13 +637,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> >  			err = -ENODEV;
> >  		}
> >  	} else {
> > +		unsigned long start_ifindex = ctx->ifindex;
> > +
> >  		for_each_netdev_lock_ops_compat_scoped(net, netdev,
> >  						       ctx->ifindex) {
> > +			if (ctx->ifindex != start_ifindex) {
> > +				ctx->rxq_idx = 0;
> > +				ctx->txq_idx = 0;
> > +			}
> >  			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
> >  			if (err < 0)
> >  				break;
> > -			ctx->rxq_idx = 0;
> > -			ctx->txq_idx = 0;
> >  		}
> >  	}
> >  
> > @@ -786,8 +793,6 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
> >  		ctx->txq_idx = ++i;
> >  	}
> >  
> > -	ctx->rxq_idx = 0;
> > -	ctx->txq_idx = 0;
> >  	return 0;
> >  }
> >  
> > @@ -902,6 +907,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
> >  	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
> >  	const struct genl_info *info = genl_info_dump(cb);
> >  	struct net *net = sock_net(skb->sk);
> > +	unsigned long start_ifindex;
> >  	struct net_device *netdev;
> >  	unsigned int ifindex;
> >  	unsigned int scope;
> > @@ -934,7 +940,13 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
> >  		return err;
> >  	}
> >  
> > +	start_ifindex = ctx->ifindex;
> > +
> >  	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
> > +		if (ctx->ifindex != start_ifindex) {
> > +			ctx->rxq_idx = 0;
> > +			ctx->txq_idx = 0;
> > +		}
> >  		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
> >  						    info, ctx);
> >  		if (err < 0)
> > -- 
> > 2.54.0
> > 
> > 
> 
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

I just noticed we handle this differently in rtnetlink with
cb->seq/dev_base_seq/nl_dump_check_consistent(), but it seems like
netdev-genl.c intentionally does not use NLM_F_DUMP_INTR?

Best,
Bobby

