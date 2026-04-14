Return-Path: <netdev+bounces-278441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL8tCbI23mkRpQkAu9opvQ
	(envelope-from <netdev+bounces-278441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E73FA1B9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DE3A301FCA3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AAC3E6389;
	Tue, 14 Apr 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQEhuZc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429043D9DA7
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170670; cv=none; b=Bx2hvMA4vOAOaStKnSj6u1dB9F914ZPlifyyAhECkuOvmwSg6pvwTjCgs07zsibYZIrW1bOBaMp1LXYgrEmfMtqPkDL7/w3PJubYgY2fRIYb1wwMhogbHWDnhVNvBk/SzXf1UUIJMZ8+i3srZWCguU6OKkCj4Tb0ZLyoQUQ6hts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170670; c=relaxed/simple;
	bh=S9r9JmYJKuqSgb2TBRmuvvesXKnOjPAwqMTEkleci+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoPLOOuUKc31dj5NDzTbuZheFcW+dzOopVCB5pvE8kxD9gXbFvI1CFsW1/EbSpVjLfjfsTN+gGuoBw+cSGaWVU32uDonR7pX0zv3JY9z/zUs4UcrGSj+VjAzSCfAC+YGY5mZz6bBUMU/WBs0pBjOOixy9xZEgmjf0FNuYQrodK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQEhuZc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EBEC19425;
	Tue, 14 Apr 2026 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776170669;
	bh=S9r9JmYJKuqSgb2TBRmuvvesXKnOjPAwqMTEkleci+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQEhuZc5xBjH9fXIZxKfGPFrIYak5vTyirF7S2PfwZGvDrTklSQ/DgAt+SddZpDwZ
	 C+sqvj+Xp2XajjxVJyfC51Mvmt7F439K5lWc5NVVWMcRnlBqgBGSFCze8axzg7uiv1
	 zfHMu5hqUCbQAxXP4u8mgxaZ5aWlYga3WufL+mFl+5wSnV64eerkCEsnJ1N2YgRrW7
	 M6RBF12/lIykMuM+EcFVKU44nbzXwWcqu8P7Q3jbLnK8UIJhqeSnf6k0rEa0zKHVTP
	 /hGQOjlH5Xizv+rbDcEojxu518+Cj6lnQJs9YDrirGAdrSAVkcHF2BoVemBW/H6Agi
	 UHOZ0USc5Vwcg==
From: Simon Horman <horms@kernel.org>
To: n05ec@lzu.edu.cn
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	caoruide123@gmail.com,
	zylzyl2333@gmail.com
Subject: Re: [PATCH net 1/1] ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()
Date: Tue, 14 Apr 2026 13:43:06 +0100
Message-ID: <20260414124305.752447-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fc06a81e1c1cbbb3e918825a718046cb18204f3c.1775886483.git.zylzyl2333@gmail.com>
References: <fc06a81e1c1cbbb3e918825a718046cb18204f3c.1775886483.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,google.com,redhat.com,queasysnail.net,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 814E73FA1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

This commit fixes a dst entry leak in xfrm6_rcv_encap() by ensuring
the dst is released when ip6_route_input_lookup() returns an error route.

> diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
> index ea2f805d3b014..9b586fcec4850 100644
> --- a/net/ipv6/xfrm6_protocol.c
> +++ b/net/ipv6/xfrm6_protocol.c
> @@ -88,8 +88,10 @@ int xfrm6_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
>  
>  		dst = ip6_route_input_lookup(dev_net(skb->dev), skb->dev, &fl6,
>  					     skb, flags);

This isn't a bug introduced by this patch, but is it possible for skb->dev
to be NULL here?

When ESP packets are delivered over TCP, they are processed asynchronously
via handle_esp() in net/xfrm/espintcp.c. This dynamically resolves skb->dev
using dev_get_by_index_rcu(). If the interface was removed before this runs,
it returns NULL.

Because TCP receive paths drop the skb's dst entry, skb_dst(skb) is NULL.
When handle_esp() passes the skb to xfrm6_rcv_encap(), it enters the
!skb_dst(skb) block and unconditionally accesses skb->dev->ifindex and
calls dev_net(skb->dev).

Could this result in a NULL pointer dereference if the interface is torn
down while packets are being processed asynchronously?

> -		if (dst->error)
> +		if (dst->error) {
> +			dst_release(dst);
>  			goto drop;
> +		}
>  		skb_dst_set(skb, dst);
>  	}
>

