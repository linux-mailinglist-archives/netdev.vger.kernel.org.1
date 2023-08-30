Return-Path: <netdev+bounces-31359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6678D4E9
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92113281366
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D041FBF;
	Wed, 30 Aug 2023 09:48:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6001C03
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:48:30 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D691B0
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:48:29 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6beff322a97so2970794a34.3
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693388908; x=1693993708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQQuEwTR3TXJbHoTUE5RO7q0He3KJgO0R8fbnOABrZc=;
        b=TGKIxjaY74tg7CVFUNKoHoEWNFh7PwJ8yG/3UjVj2wBmvGK6CWDIOuu3TkjXG/atHQ
         fwkqdMgPgLEDaZ4IM0tiRvQR98gh1fGzLkY60/EvKD601YaDQa2V0jadc23JZ4edyYa2
         T3/noRSOOreVAT74kPmT7Ns8mboFty/zMUPyBPTexvKvJo0oNT9OEjUOWF277eAt8hbr
         YozWWsHEbMPIsakJqp2Hrf6190uyGNxYiizkcbC6/+eri9fm4vJL4jnIGqOLbfX5UZSZ
         ngJRKRLv8qVCEojCurlNaUDrP6uGkBWqAFzlqRc0KX27cTMeGwPsvnsBDqReNAm3kB5S
         jTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693388908; x=1693993708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQQuEwTR3TXJbHoTUE5RO7q0He3KJgO0R8fbnOABrZc=;
        b=VGet+ThjCMmte56njNJB6bRG3t5rOz78zbw3mJHldFYbp0kucHWZCI8PpKhVCDl5Mk
         9WC2EHj6W6F2YiAV1WZ2dVg28Ak66LVwqqmeyX3fWKMGtwY1Xt6kqwOiEQ8quK1wqLl4
         dpRCF3ZBfsOPv4kXEluwwLKFb2CNiYBIxCtMKDk1kPfSXAoHwal9kCJb5W7LbFfKjBdc
         anxSzhm6su01qjZoz/leoeNHZBYO4APw8qnnszBpm8lvOa1FG7gf6jP/SPvZUmwki4RJ
         IfOSDh6VIiQPleiVVlIuOtcQnvKPMXeI3QbsK0ZfD3jZ5gsAoFQTE/MB4ToQyOHJo9IF
         r/Cg==
X-Gm-Message-State: AOJu0YyOOGdr8KpEQHXrENRHY/PAv2nU0/DGpGaAk0puZ/Gg5Nk1Faye
	rOR3RJpjPXW3aoc8UX8P+Gca7vffeuQ=
X-Google-Smtp-Source: AGHT+IH/Hb/gZUKsS42qJ3T3QaOq9XmP2trX9j6VJmKvDC5HlO+sOInyEOvDdcQyXFmyUvr9CPGQww==
X-Received: by 2002:a05:6870:a2d0:b0:1b7:670e:ad85 with SMTP id w16-20020a056870a2d000b001b7670ead85mr1897792oak.49.1693388907821;
        Wed, 30 Aug 2023 02:48:27 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7820:a6d0:fe00:94b0:34da:834c])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090a498400b002682523653asm908029pjh.49.2023.08.30.02.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:48:27 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:48:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Message-ID: <ZO8QZJK89GMZ7taF@Laptop-X1>
References: <20230830061622.2320096-1-liuhangbin@gmail.com>
 <ZO8N8yyYubzB2bJF@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO8N8yyYubzB2bJF@Laptop-X1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

OH, Just saw net-next is closed. I will re-post it when open.

Hangbin
On Wed, Aug 30, 2023 at 05:38:01PM +0800, Hangbin Liu wrote:
> Sorry, Looks it failed when I cancel the git send-email. There is
> a typo in the subject. Should be "different" instead of "differe"...
> 
> I will fix this if there is an update needed.
> 
> Hangbin
> On Wed, Aug 30, 2023 at 02:16:22PM +0800, Hangbin Liu wrote:
> > Different with IPv4, IPv6 will auto merge the same metric routes into
> > multipath routes. But the different type and protocol routes are also
> > merged, which will lost user's configure info. e.g.
> > 
> > + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> > + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
> > + ip -6 route show table 100
> > local 2001:db8:103::/64 metric 1024 pref medium
> >         nexthop via 2001:db8:101::10 dev dummy1 weight 1
> >         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> > 
> > + ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
> > + ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
> > + ip -6 route show table 200
> > 2001:db8:104::/64 proto kernel metric 1024 pref medium
> >         nexthop via 2001:db8:101::10 dev dummy1 weight 1
> >         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> > 
> > So let's skip counting the different type and protocol routes as siblings.
> > After update, the different type/protocol routes will not be merged.
> > 
> > + ip -6 route show table 100
> > local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> > 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
> > 
> > + ip -6 route show table 200
> > 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
> > 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
> > 
> > Reported-by: Thomas Haller <thaller@redhat.com>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2161994
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> > All fib test passed:
> > Tests passed: 203
> > Tests failed:   0
> > ---
> >  net/ipv6/ip6_fib.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index 28b01a068412..f60f5d14f034 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -1133,6 +1133,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
> >  							rt->fib6_pmtu);
> >  				return -EEXIST;
> >  			}
> > +
> > +			if (iter->fib6_type != rt->fib6_type ||
> > +			    iter->fib6_protocol != rt->fib6_protocol)
> > +				goto next_iter;
> > +
> >  			/* If we have the same destination and the same metric,
> >  			 * but not the same gateway, then the route we try to
> >  			 * add is sibling to this route, increment our counter
> > -- 
> > 2.41.0
> > 

