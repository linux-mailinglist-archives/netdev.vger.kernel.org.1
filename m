Return-Path: <netdev+bounces-31668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6C78F797
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 05:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388FD2816E3
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411B1FA1;
	Fri,  1 Sep 2023 03:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63BA1C3E
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 03:59:00 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD7E47
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 20:58:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a410316a2so1291432b3a.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 20:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693540739; x=1694145539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IpcFV2+HszfTBdWrnWFCNFj/WvDzdsRlCY13GnN22Y=;
        b=YtLrVK1XRZ6w7FLutDcwp1ZCZuXDuGoZKFGAJvJA50e57s5QO3qmgY7JtpeoIguY0X
         NgR9TAl1aJ82PUroNLjc5bUpZiY+TSfUSu7JsNLoyLk1GY4rmBTQfNxifTNBvEeVCjRP
         Jeg6gSKBbBl1kVE0gnTbxy8DclIlnan6uQNEqHTGGgGxGWg8qaAeIN63hF3LsIJksrIF
         +Qgkt/nvu75vNiVThgqCVo4aPeW8Rd5wA29IIonaMF3ZtKvuI+9QU6avkoFn6XNInCjt
         IUh7t8uD9z8FMtbzJ8+eREKpTip9bcxBEuBXrCLWWSwtu+r7dBeho8jQ0IuDDnIJEa6D
         d9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693540739; x=1694145539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IpcFV2+HszfTBdWrnWFCNFj/WvDzdsRlCY13GnN22Y=;
        b=OCcHiUeh0O8c+0mAYAPxslV5bR/Hznxnj0pSRfKhjMm9DEFGIzD0pw0v0sfQYM7Xbf
         t379CztphOWoyjZhhg2BIC4tw5tL82KwW5KQl/NlQyWskbdu5koGctgHKeG2osY0LoBI
         QwVqhqwp1Bf8gGRZFS4PImH6cLVgZGEIGow68kpZ/6FcYOV2H18FC5f/cxgb3nPFeBqQ
         cf/6vRI6WoDuMFLq6R7QYCoyy7FWGc1Mt1DaxQC8CQ5b2hgYAhSvXjlmpqJptqafUZsE
         cC0jpjqbPCK/CPaxw8jpRrsIzi7P+ASjZz0fLC4Dbsj5kulg1x0J/pZU7yE58+grkj8M
         q/vg==
X-Gm-Message-State: AOJu0Yy3DAoBabHiwPxRWK1NrmjCCFWqXEOw697FBefPNPtWMdJsPDx2
	xyABgecg9JOelWBdofArJWs=
X-Google-Smtp-Source: AGHT+IFTukPoRl85qqjs3guAEMyoOj7+HD8IiQ011o5iu0v1vITJgg3roP3xz3xOnGPkcQG1/LeXoQ==
X-Received: by 2002:a05:6a20:728e:b0:148:2f62:c47f with SMTP id o14-20020a056a20728e00b001482f62c47fmr1837377pzk.41.1693540738906;
        Thu, 31 Aug 2023 20:58:58 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v25-20020aa78519000000b00682c1db7551sm1994995pfn.49.2023.08.31.20.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 20:58:58 -0700 (PDT)
Date: Fri, 1 Sep 2023 11:58:54 +0800
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
Message-ID: <ZPFhfgScZiekiOQd@Laptop-X1>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
 <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 01:58:48PM +0200, Nicolas Dichtel wrote:
> > The append should also works for a single route, not only for append nexthop, no?
> I don't think so. The 'append' should 'join', not add. Adding more cases where a
> route is added instead of appended doesn't make the API clearer.
> 
> With this patch, it will be possible to add a new route with the 'append'
> command when the 'add' command fails:
> $ ip -6 route add local 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
> $ ip -6 route add unicast 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
> RTNETLINK answers: File exists
> 
> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp table 200
> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel table 200
> RTNETLINK answers: File exists
> 
> This makes the API more confusing and complex. And I don't understand how it
> will be used later. There will be 2 routes on the system, but only one will be
> used, which one? This is confusing.

Just to makeit it clear, the new patch will not add two route with only
different type/protocol. Here is the result with my patch.

+ ip -6 route flush table 300
+ ip link add dummy1 up type dummy
+ ip link add dummy2 up type dummy
+ ip addr add 2001:db8:101::1/64 dev dummy1
+ ip addr add 2001:db8:101::2/64 dev dummy2
+ ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
+ ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
RTNETLINK answers: File exists

     ^^ here the append still failed

+ ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
+ ip -6 route show table 100
local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
+ ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
+ ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto bgp table 200
RTNETLINK answers: File exists

     ^^ And here

+ ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
+ ip -6 route show table 200
2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium

Thanks
Hangbin

