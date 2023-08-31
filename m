Return-Path: <netdev+bounces-31536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318078E9FC
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4A21C2097C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83388F47;
	Thu, 31 Aug 2023 10:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD98498
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:14:21 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D42E42
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 03:14:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26934bc3059so1265456a91.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693476859; x=1694081659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f989IGcUqq8Px/bgiHpX6peJL1AeLepklJyWMmNd6B4=;
        b=oX3UpdKFSQ4YKGT60rnFvYDvPBAxUArQqMxoqnciF4AOpsaFuTEgxZHih2ABSFqjM7
         HVDNlbFEc/QPdXC7A8WuM5+brYZiKd2rma+peKjVD0tOgN45Eo5ZEgN3xCcQbvY1CZq8
         RbfU9bPgpqVWlEeeFIa+4GEC8X7rGdOFeKcUTzo6H67eL7VXJa0fizsX+FLTcDO8inMr
         brJqMQiCSMxzRjuxIbU6voaY4UIyLFb+nLpNzDgqC/dW1rX8OYB+vh11xTWPDWrGuaKb
         9bWiDTvWq2dyNSKrYr8LPXy2UJsKS/0EA5/m+BKwcmYXpHhNhUqQxZCNmk673GNp147/
         Zxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693476859; x=1694081659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f989IGcUqq8Px/bgiHpX6peJL1AeLepklJyWMmNd6B4=;
        b=TOCfUu5l9qc8uSlHci3muH6KzfHt04A6imy/rj1SWa/QEm3IkKZIuB9rCTTVD8C/9M
         1GsoMHo9SRsAm/+muezSr7xGSa5ZcWLuAXw9riLRW1asU3NIdThJU8hlUs3bpLc0NJP1
         Zr/wwY31SK8oUR6xefuCNCtaU0/PZYFqRVQCxYVwWVheN5/SKgZpQ6xoMvXVcEtNi4v/
         fhflgVy9ivGvzEpt3vlLCpE6dcKzJF341ahAqMG0/yIldqZ+SU8YKZ/pg3VSHizHe1WJ
         CAM4dpa4qurYyHshuspl4UqAPshePIpE1KgouIxqzBQ4Nuv8fftxdP91Diy+WtQ+ppsx
         /RrA==
X-Gm-Message-State: AOJu0YwOqoJqLJqqIqWf6JL8bq2XQR/S+wHOjdr/r1jN05sbemuR2PwI
	UbNQmT3noxxwT0THhQlsdLI=
X-Google-Smtp-Source: AGHT+IFjdlfv/4DY+NnfRsY2G1j/QQKfOPNL/HmoNLPcWoYlvD5QO+V8GTu26Gd7MzaaBX6DsZNzDQ==
X-Received: by 2002:a17:90b:1d84:b0:269:4fe8:687 with SMTP id pf4-20020a17090b1d8400b002694fe80687mr3189876pjb.19.1693476859245;
        Thu, 31 Aug 2023 03:14:19 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a694e00b0026b70d2a8a2sm1028615pjm.29.2023.08.31.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:14:17 -0700 (PDT)
Date: Thu, 31 Aug 2023 18:14:13 +0800
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
Message-ID: <ZPBn9RQUL5mS/bBx@Laptop-X1>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Nicolas,
On Thu, Aug 31, 2023 at 10:17:19AM +0200, Nicolas Dichtel wrote:
> >>> So let's skip counting the different type and protocol routes as siblings.
> >>> After update, the different type/protocol routes will not be merged.
> >>>
> >>> + ip -6 route show table 100
> >>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> >>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
> >>>
> >>> + ip -6 route show table 200
> >>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
> >>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
> >>
> >> This seems wrong. The goal of 'ip route append' is to add a next hop, not to
> >> create a new route. Ok, it adds a new route if no route exists, but it seems
> >> wrong to me to use it by default, instead of 'add', to make things work magically.
> > 
> > Legacy API; nothing can be done about that (ie., that append makes a new
> > route when none exists).
> > 
> >>
> >> It seems more correct to return an error in these cases, but this will change
> >> the uapi and it may break existing setups.
> >>
> >> Before this patch, both next hops could be used by the kernel. After it, one
> >> route will be ignored (the former or the last one?). This is confusing and also
> >> seems wrong.
> > 
> > Append should match all details of a route to add to an existing entry
> > and make it multipath. If there is a difference (especially the type -
> > protocol difference is arguable) in attributes, then they are different
> > routes.
> > 
> 
> As you said, the protocol difference is arguable. It's not a property of the
> route, just a hint.
> I think the 'append' should match a route whatever the protocol is.
> 'ip route change' for example does not use the protocol to find the existing
> route, it will update it:
> 
> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1
> $ ip -6 route
> 2003:1:2:3::/64 via 2001::2 dev eth1 metric 1024 pref medium
> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp
> $ ip -6 route
> 2003:1:2:3::/64 via 2001::2 dev eth1 proto bgp metric 1024 pref medium
> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel
> $ ip -6 route
> 2003:1:2:3::/64 via 2001::2 dev eth1 proto kernel metric 1024 pref medium

Not sure if I understand correctly, `ip route replace` should able to
replace all other field other than dest and dev. It's for changing the route,
not only nexthop.
> 
> Why would 'append' selects route differently?

The append should also works for a single route, not only for append nexthop, no?

> 
> This patch breaks the legacy API.

As the patch's description. Who would expect different type/protocol route
should be merged as multipath route? I don't think the old API is correct.

Thanks
Hangbin

