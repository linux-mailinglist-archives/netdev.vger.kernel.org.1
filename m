Return-Path: <netdev+bounces-34001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB27A1491
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 05:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A820C1C20A2D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 03:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB5258C;
	Fri, 15 Sep 2023 03:49:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770623DB
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:49:11 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE0196
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 20:49:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a8614fe8c4so1089046b6e.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 20:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694749750; x=1695354550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPjjclwNyALFuH/baa790B/YULmKXPGsRhDjznlRHXU=;
        b=GmI642Nk5/qjPAGM4Y/onKBQxA5Y38b0D2TyGNHPw8kmF3xYuGe+LBLEjke2XmgqYk
         5qqCo3sK6rTL3m5do9842G0LpwGz4JrJZsmQBBKGDJSw7tqgmDIYISA5gVZ2/EbD4XfT
         dIQG7Y3AyQjUlcNZfsrBefDwBKl6ETm+4CoNB2zWr7yt9QbNbcDEFQX6E3dQK68STWcW
         rD4Y06PG+KCeFxnMXW8Wg+AGBnyWBKmm+77zA/nKqwN61DMILmz1rFcUGW3PgOf4ptYC
         bg+oKT3r8wsUPjVRlc79EzvQetG5oS6uJICsFC6yaYnlmIJK6eXZ3KtjmUPpMOOfOrF7
         gDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749750; x=1695354550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPjjclwNyALFuH/baa790B/YULmKXPGsRhDjznlRHXU=;
        b=GCupAs7VaoXvT3uw2ehCKTaGZFXyqSLiWeNbryjDCbxfoXSCQPkny/JFjwQR4+o+J7
         TMwiQlV2TR4b1OqvTi/jhJkO4RL/WeRo11e/2v0jLxpvrKbstqJKHlEniWF1zgCTHWg1
         Llv+n+bf8Z3lj7jLAiChfBsFP8WfXh3CMnvzgHG0VebTkn2kVxLaP6cG9IaiwkHCLCEO
         WhrL7NmLQSb348Rorxsr+bLOstCubZ/rGcfPNS7rro8P70k2n5tKht9IDFmwxcAmXk6S
         fe0IUr3bv1E0MhBR+JIXm9Tq3zx/aF4p0viDPi29x4CBNkJKF/YH+rhWrPy73lZxd6jx
         pi7g==
X-Gm-Message-State: AOJu0YzoHI0hbDNwLNu2DoufYgETOgINuWKTd3PONLCdsCfaBglSdA/8
	Z3VOswjxD4NI+sj2WkQhXVM=
X-Google-Smtp-Source: AGHT+IGpyGTcAbx4cfyDhIXccmBrkGZhLwoDCfo/JXY+FSELy2qLWPiL+T8OsExW8Kh96KAoF/+Xhw==
X-Received: by 2002:a05:6808:3d1:b0:3a7:4b9a:43c2 with SMTP id o17-20020a05680803d100b003a74b9a43c2mr537684oie.13.1694749750369;
        Thu, 14 Sep 2023 20:49:10 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b0068fb783d0c6sm2068832pfo.141.2023.09.14.20.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:49:09 -0700 (PDT)
Date: Fri, 15 Sep 2023 11:49:05 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Message-ID: <ZQPUMchAuQma7Xrh@Laptop-X1>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
 <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
 <ZPFhfgScZiekiOQd@Laptop-X1>
 <b4b81499-d53a-d697-4cb6-20338606d68a@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b81499-d53a-d697-4cb6-20338606d68a@6wind.com>

On Fri, Sep 01, 2023 at 11:50:12AM +0200, Nicolas Dichtel wrote:
> > + ip -6 route flush table 300
> > + ip link add dummy1 up type dummy
> > + ip link add dummy2 up type dummy
> > + ip addr add 2001:db8:101::1/64 dev dummy1
> > + ip addr add 2001:db8:101::2/64 dev dummy2
> > + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> > + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> > RTNETLINK answers: File exists
> > 
> >      ^^ here the append still failed
> And if I play a little bit of the devil's advocate: why is it rejected? It's not
> the same route, the types differ :)

This is actually for compatibility...
> 
> > 
> > + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
> > + ip -6 route show table 100
> > local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> > 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
> 
> What is the purpose of such a routing table?

As I replied in last mail. I don't have a clear purpose. A user may use
the local route to block traffic temporary.

> How is the gateway of a local route used by the kernel?

I don't know. IPv6 support this since beginning...

> Which route will be used when a packet enters the stack?

The first one it find?

Thanks
Hangbin

