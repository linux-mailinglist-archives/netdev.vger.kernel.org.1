Return-Path: <netdev+bounces-278069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFAoCR3k3GnBXwkAu9opvQ
	(envelope-from <netdev+bounces-278069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C683EC11F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAEE73005140
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17F3C344F;
	Mon, 13 Apr 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJu4U4hC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73C23AE87
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083990; cv=none; b=KzwmeCnRx+gKFdMj8wnx02559wpJFvRAaJilm8Un8QvKWq67SLr3NoiBOX3ja5FNUewWfqgpa0NiLdlsr2RU+jF7BuknYHKy/Mv6CEDX6iqda3GuxmhiBooyBtqIkXhj4pbhDoQAFP3gbytuPzqt5Q9KBCzsXpSfKPDIhE/a0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083990; c=relaxed/simple;
	bh=Mb8ynuEVZ9jnH95PjLHoWPiHHqGpMrjofGz0L1SAq14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3OPGujrJ0gBkv0U3lmPLpb7JzSdHBJll7Ld+z2J4Qfhj94C4/No2nnOSdpsfYvz22zVu5iEr+tWp+fkXGN7WZrrEcNk3K5FaKGBtoqGLoY6TAMA4C88XRkqe9Q9gOoBmG7le4dL9RCbAK0t6xVjnafTN8WK5BzpvKjlycLGnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJu4U4hC; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c45281a06so1970382c88.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083988; x=1776688788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjpp1vRzru8GZlAX0xmlAVC+tq/WF3FlyeoCkEJDGGc=;
        b=FJu4U4hCO+LbYb5gV7/6gBuhdnxFhK6E7OlCmpzg4CZBg1uZ+S3GuLN3Matehj2z54
         l/04aZ8teGllth6O1AeqcvNZsABDfKBbPKFL6gO4CAYo0CbF0qlo+IAZW4DTimGMzgj4
         nCnYxc3A1cmgOphIcB71vcVUoWgqPNSsORhSgpDmvZI5KUq79Buuow1uPU/6TAmb7IHD
         OEnrPDss3XMVO6wHNYq+yGbNIQYKxcnhm+Zv40BPUwHFZJlGJM0A+J97ADXRAnybiGjT
         WqwNwoAkmpCnsDZUapZXG9qbbpj3H9Bh80ljEVRzVKs45Sf0p+Fya19oJ8DId3whKESH
         3oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083988; x=1776688788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjpp1vRzru8GZlAX0xmlAVC+tq/WF3FlyeoCkEJDGGc=;
        b=lWV2uHBsUa17LPNzkqhj5XxcWzvXEd9CRjXlkv77aro2nF7Dwe79b2CMWRkBPuAMnX
         E79oPpglwJpTFPMaQdQ4aUPvXuiFMtBPVa2vCDk04INjoqoXWTI74LaCzv0xQWyCuZGS
         KjWkHvsIHdk+4AsjI5NLj4hYN0YahMJmI+VzEXF9L/oa4/eVuUhyWOF/9z8FFtmeBPr1
         90iqkiEhnOjjQf/YTsjEU2c/RQJw3Z6Gnx4ntW2yctx9gmjVbbeIUiWw8Sz5RPcBzU97
         CIVpj78QFwitaZkf3VEn/y5wXGHN8qFv30i4ERu46fYYPak9sijfvbkK4mXqCq9LBgwl
         fqlQ==
X-Gm-Message-State: AOJu0Yw0snJUIZdFs37BGeD9RVHWr6e8EQh3rrqmAfMB1/yKC9SVbgOq
	OwC/BDr7D7oje/xZrpEFq4inVTyv7LzCa69GumvdmGC1FhQsBvtnbKSZ
X-Gm-Gg: AeBDieuMu18deeHgw6Q+hT/hyMBWuQA4cROuvLMrRhSMeN0am1F4fAiItQeVLDm+QHS
	UAyACsFgC/lyIBsvUbi4C7zUA7Vjhjc0lS1gT8hgw2jrGNk7wlo2okeuQAAlfnjdPHpgvGmmCyo
	45tD+UcJdmHGSNOyYbeeeNekketqJBHA48oNlc5ngxbt7KA0faRonttsNgiB/impcuxYfArJBgG
	30Ihs2T6DmpvNtHuMZsWqgrIU2zRU9jLC1DioquN1YykIS15R7xkqkvIyCOWphKCGgRlz6vOrW2
	wNQecLBWx+8BV7K5w6WF1vGS4Q3upP9pICBE3kHIylHfbjzmu3MW0DjRNhHIBn3ey1q3G6oLhzW
	7+oJDJrbn5QLkXMzdLTvh6KzAU83wf3N4UeUwt/M8rY1W9fU0bVQlv+jENLPzO32t7gzu3fJZkC
	nKsh6mW0LEkLtJzYEDuj3+v9TxrrxfLuJj/QFGtw==
X-Received: by 2002:a05:693c:3116:b0:2be:85d4:4a2a with SMTP id 5a478bee46e88-2d5870ac158mr7345736eec.1.1776083988319;
        Mon, 13 Apr 2026 05:39:48 -0700 (PDT)
Received: from t14s.localdomain ([177.37.143.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db6ac8sm16168701eec.26.2026.04.13.05.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:39:47 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 5286813FAC0B; Mon, 13 Apr 2026 09:39:45 -0300 (-03)
Date: Mon, 13 Apr 2026 09:39:45 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net] sctp: disable BH before calling udp_tunnel_xmit_skb()
Message-ID: <adzkEQ17BD546rXC@t14s.localdomain>
References: <c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278069-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1C683EC11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 02:15:27PM -0400, Xin Long wrote:
> udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
> BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
> tunnel xmit functions"), on the path:
> 
>   udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()
> 
> dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.
> 
> Without local_bh_disable(), the context may move between CPUs, which can
> break the inc/dec pairing. This may lead to incorrect recursion level
> detection and cause packets to be dropped in ip(6)_tunnel_xmit() or
> __dev_queue_xmit().
> 
> Fix it by disabling BH around both IPv4 and IPv6 SCTP UDP xmit paths.
> 
> In my testing, after enabling the SCTP over UDP:
> 
>   # ip net exec ha sysctl -w net.sctp.udp_port=9899
>   # ip net exec ha sysctl -w net.sctp.encap_port=9899
>   # ip net exec hb sysctl -w net.sctp.udp_port=9899
>   # ip net exec hb sysctl -w net.sctp.encap_port=9899
> 
>   # ip net exec ha iperf3 -s
> 
> - without this patch:
> 
>   # ip net exec hb iperf3 -c 192.168.0.1 --sctp
>   [  5]   0.00-10.00  sec  37.2 MBytes  31.2 Mbits/sec  sender
>   [  5]   0.00-10.00  sec  37.1 MBytes  31.1 Mbits/sec  receiver
> 
> - with this patch:
> 
>   # ip net exec hb iperf3 -c 192.168.0.1 --sctp
>   [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  sender
>   [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  receiver
> 
> Fixes: 6f1a9140ecda ("add xmit recursion limit to tunnel xmit functions")
> Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Nice catch!

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

