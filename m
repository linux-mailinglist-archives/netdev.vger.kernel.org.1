Return-Path: <netdev+bounces-21305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0AA763345
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB332819FE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F27BE69;
	Wed, 26 Jul 2023 10:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A976BE66
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:17:13 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1C1BE4
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:17:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b9964ae2so761170b3a.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690366631; x=1690971431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0xTc+3kGczA2Gq6z9+jZQraZwV8GBqSeU4L6Np+R9s=;
        b=oykU9504FH1iLJ+B6/uRGf1U6Pzi72Sy4TWkfMu86J8PyYPmAe+WbBOohjE9n8hojt
         W0bCFsxEvyoT81Uq9GLW0aIhSqkQTeg/7wwoKmQ6xEqvUXwq7srALo+P3z5C1ubscjXe
         Yu7dchRVZDNprdstII1MyvR8Ixcl4ieXVoz3xIFMhe49NyUC27mXKtZTcvsKe4+u6wnO
         5aarxV3scHSGWQFQWEPnfCHKT2bf33zN1LaMNVk5NE5gSUzM7roEAfy1JEwYk56exOph
         FGmPNCIGfORJTGvr4j7CTHg2weZrXTyVKvlSAbsU0Plcig1oRR64tXOYuTuP2cpn0phv
         UnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690366631; x=1690971431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0xTc+3kGczA2Gq6z9+jZQraZwV8GBqSeU4L6Np+R9s=;
        b=KargKxCLgFgGcaTctxDCFigAqarIkHPtSkBaANey1j42ERBLDnv7O6Wcv7UaTle31/
         4s9t9AB0kcSYbAJeQ91IhzMf6QI5Mbm5Zt7Os/TnX/UuKySQrrlUemO81Ng5H4B02RbL
         VKO+Siqc4BPjkZMp9gi367FAD+DggTUwMxdQF3Uho/L4gsx+R7IsOqzFHBuLhTSVT5xH
         LVbvEuEswk4EedhiE1xedAuvZjWpgMZap0ZS0OAhf2VnGlnc1PYq2l1dpuy46MJeiVZM
         EYgOI0JENzOainu7mVY3vnlNQtmQGb/qJAO18o3Xj47MXaxjPMxoRHYQspqQ5ImmSwA3
         d6DQ==
X-Gm-Message-State: ABy/qLYfzz6IiiyI8Cr3tz6q9v1uHl3GSQI6xiJaCo2HatlYTnAvX3Bl
	f2jdQXihjuqc6q0rh5SGEK8=
X-Google-Smtp-Source: APBJJlH0g5CulvononTtA3gfZ2zxJ7QLVR2t6kEn53l+58QsZ4YUwDOm5XWueHP6C98hMADPcjJuJA==
X-Received: by 2002:a05:6a00:1949:b0:643:aa8d:8cd7 with SMTP id s9-20020a056a00194900b00643aa8d8cd7mr1472788pfk.32.1690366630723;
        Wed, 26 Jul 2023 03:17:10 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0066a31111cc5sm11098712pfh.152.2023.07.26.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:17:10 -0700 (PDT)
Date: Wed, 26 Jul 2023 18:17:05 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: [Questions] Some issues about IPv4/IPv6 nexthop route (was Re:
 [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush fib)
Message-ID: <ZMDyoRzngXVESEd1@Laptop-X1>
References: <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724084820.4aa133cc@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stephen, Ido, David,
On Mon, Jul 24, 2023 at 08:48:20AM -0700, Stephen Hemminger wrote:
> On Mon, 24 Jul 2023 16:56:37 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
> > the cache becomes inconsistent. The IPv4 will not send src route delete info
> > if it's bond to other device. While IPv6 only modify the src route instead of
> > delete it, and also no notify. So NetworkManager developers complained and
> > hope to have a consistent and clear notification about route modify/delete.
> 
> Read FRR they get it right. The routing daemons have to track kernel,
> and the semantics have been worked out for years.

Since we are talking about whether we should fix the issues or doc them. I
have some other route issues reported by NetworkManager developers. And want
discuss with you.

For IPv4, we add new route instead append the nexthop to same dest(or do I
miss something?). Since the route are not merged, the nexthop weight is not
shown, which make them look like the same for users. For IPv4, the scope is
also not shown, which look like the same for users.

While IPv6 will append another nexthop to the route if dest is same. But there
are 2 issues here:
1. the *type* and *protocol* field are actally ignored
2. when do `ip monitor route`, the info dumpped in fib6_add_rt2node()
   use the config info from user space. When means `ip monitor` show the
   incorrect type and protocol

So my questions are, should we show weight/scope for IPv4? How to deal the
type/proto info missing for IPv6? How to deal with the difference of merging
policy for IPv4/IPv6?

Here is the reproducer:

+ ip link add dummy0 up type dummy
+ ip link add dummy1 up type dummy
+ ip link add dummy2 up type dummy
+ ip addr add 172.16.104.1/24 dev dummy1
+ ip addr add 172.16.104.2/24 dev dummy2
+ ip route add 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy1
+ ip route append 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy2
+ ip route add 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 1
+ ip route append 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 2
+ ip route show table 100
172.16.105.0/24 via 172.16.104.100 dev dummy1
172.16.105.0/24 via 172.16.104.100 dev dummy2
172.16.106.0/24 via 172.16.104.100 dev dummy1
172.16.106.0/24 via 172.16.104.100 dev dummy1

+ ip route add local default dev dummy1 table 200
+ ip route add 172.16.107.0/24 table 200 nexthop via 172.16.104.100 dev dummy1
+ ip route prepend default dev dummy1 table 200
+ ip route append 172.16.107.0/24 table 200 nexthop via 172.16.104.100 dev dummy1
+ ip route show table 200
default dev dummy1 scope link
local default dev dummy1 scope host
172.16.107.0/24 via 172.16.104.100 dev dummy1
172.16.107.0/24 via 172.16.104.100 dev dummy1

+ ip addr add 2001:db8:101::1/64 dev dummy1
+ ip addr add 2001:db8:101::2/64 dev dummy2
+ ip route add 2001:db8:102::/64 via 2001:db8:101::10 dev dummy1 table 100
+ ip route prepend 2001:db8:102::/64 via 2001:db8:101::10 dev dummy2 table 100
+ ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
+ ip route prepend unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
+ ip monitor route &
+ sleep 1
+ ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 100
2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 table 100 proto kernel metric 1024 pref medium
+ ip route prepend 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 100
2001:db8:104::/64 table 100 proto bgp metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy2 weight 1
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
+ ip -6 route show table 100
2001:db8:102::/64 metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1
local 2001:db8:103::/64 metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1
2001:db8:104::/64 proto kernel metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1
+ kill $!

Thanks
Hangbin

