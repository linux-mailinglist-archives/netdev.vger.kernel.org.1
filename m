Return-Path: <netdev+bounces-31466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDC78E381
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C644A1C20429
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CA58C1F;
	Wed, 30 Aug 2023 23:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E06FA1
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 23:51:34 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CCFCC
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 16:51:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a42d06d02so186008b3a.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 16:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693439493; x=1694044293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ6q/L7DpPuOZlsgPuAJy04lw+a+e3wB2Is1xZz31hc=;
        b=aXu6eCJEf+6yrIaw6iXNDw47IuDKtlxO5HhQBKHSG2kkzQHEeNaeVJL7ayfnV9OwUY
         TNjtupTzo5uDKrNWyk+CLtUeYWai8JxTs9Kgp1y4xH4eBQSZvOBQ9smwD3qHcpn72tGs
         nqXn3SxZBnlyefJtZccGhFYQ/6XbMURLkvE81W7VeTvRgdrokV0Pm5SXI+97iwAfU9Nw
         9tcmACgkfUfLn+MPfSzKcbClvFuch2A49jnfwzSSY3qL/PQMJg6MA5Lrx+NDZisA1wDs
         nmF8lCvS6BAZYG//FP+y1k/2Qk0odubREP/JCUqB3cmYSjfjYlrsmUedUZNHYLiOu9bw
         aLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439493; x=1694044293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ6q/L7DpPuOZlsgPuAJy04lw+a+e3wB2Is1xZz31hc=;
        b=IKRNBykzMqPsHBgyXp+2AMfT2lNcYcKCflyzTToarZgVFBaCg3PNEiOtxHfbupLV6Y
         4zixTFcis8KZybb8aec9camvxkzC8tS2AJyIJB48MvUPP5bnb9RrfG28LIBK5lMJwOcn
         9/+CcWGKFPCyxLedKmEcsG6PWlx33mnDn7znBp2aE13E9MCSgQhrchexY4PFTRnpP2Cn
         jKyXPWhAt8PTmDQJZcni6pDPUmPQdnWkaLnQLCZUqmNOdHv4Jq4ECEYgezpJiyC2CYtx
         X/rC9i9QOvS9B0eFOE223vyBsgwNkTlzT94hun18b0zVnuqacaa6QOw7R7FXj7g0F83D
         Ercw==
X-Gm-Message-State: AOJu0Yw3Msvz2TwAcJsemrj7MFJ/2elPhL2AhIjRR8N8C5CZjcMv1PP6
	y5FevFyrtRZTfVfUsYicH9L35NFxC+Z4ng==
X-Google-Smtp-Source: AGHT+IEE/HXC5jviubSXqSEL8qpmVamEv+1ZFZSfKXxVeMbvJqahcU2jMntUGNugU71oN2RKxov3mQ==
X-Received: by 2002:a05:6a20:3954:b0:149:7fea:d89d with SMTP id r20-20020a056a20395400b001497fead89dmr4379777pzg.54.1693439493302;
        Wed, 30 Aug 2023 16:51:33 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z19-20020a170902ee1300b001b9d8688956sm57947plb.144.2023.08.30.16.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:51:32 -0700 (PDT)
Date: Thu, 31 Aug 2023 07:51:29 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Message-ID: <ZO/WAawi8rPQ4o7I@Laptop-X1>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <06c4cd5f-7241-3a72-0cab-5319b2c8a793@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c4cd5f-7241-3a72-0cab-5319b2c8a793@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 08:49:18AM -0600, David Ahern wrote:
> On 8/30/23 12:15 AM, Hangbin Liu wrote:
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
> 
> Please add the above tests for this case to the fib tests script.

OK, I will add them and re-post after net-next open.

Thanks
Hangbin

