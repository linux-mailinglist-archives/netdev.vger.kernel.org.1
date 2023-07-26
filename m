Return-Path: <netdev+bounces-21292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929437632AE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F47281D0B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DC5BA57;
	Wed, 26 Jul 2023 09:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66753AD5F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:46:11 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA0C1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:46:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8c81e36c0so38933485ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690364768; x=1690969568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuFK5SM2gcVf4QmPaegQHLTb3Wt0WI4QKbQTWkY+2Tg=;
        b=XJGVZmqmYMW43zSyqwYo+s665CZeAF6Uf+2+zqifoSAfiFIBhrBYGvO39h02NDRgC/
         ao4z7Vrc7ZZS4yWuDWcCf/xoqOr2VAv3uujKW3jw7snIWIV2tlJcfAwKzf92fUH6JJJf
         Hju5MYC3tOVeaut+QY6VNz6EOtJ7YsFFmqPvz40Jd69oVsoRI+HQx8N/e+5vc6n+1q3y
         RnXrZlhR9x7StpwJWGLOcagHtuOcMcF7qqCCQBaJa7rKTAoi4IGoK1+/tS44MHhSFQkQ
         YP3ACdIuhKK2g5+1cKc7BAXRFr8PjldpYXzdzDYJDCO+goXG94ywn770sSVJBtRxwwdF
         H/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364768; x=1690969568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuFK5SM2gcVf4QmPaegQHLTb3Wt0WI4QKbQTWkY+2Tg=;
        b=F45zWlQJXFQAzc9PFsTbI6n2ONjebdr4wd8n5MSYtPPMXXOIi9xoJNpBeaNdT9+dZd
         1EiM2hdsC9+4EOdtw80wAN9gxw9PPD9z3z6QAUzqwRxaUeFw0tbf5eqXip/Fj5Ww4rpi
         NNqZP5lvrC41F6vf47foDDMqULA25gDjEkafDHK3PEv5+JJY+sz6FRQv0swatfWP62R3
         63k52ZBYSKTx9+epATVBmMxwdHpKzHJR6yK6C7PIZgHH2o+RWkoZVIJd+p9WfX4y5MCZ
         OlMJi6WOmcD54oaaMNZ1FjSN9U/m1DrCvy1wf41mC+5FIxSkUUKMQraP6YxJ0hNYV5WV
         dxyQ==
X-Gm-Message-State: ABy/qLaVzwmZkj1JyGV6D0xSh02VeR+zs0XTwd30WoJIDnJupm2rCKH3
	3nnMO2z13qW3PHJmZw6Yjv7jgkJrDjMiTA==
X-Google-Smtp-Source: APBJJlF1qznvTeXK3XWnPOOc3GGFhXRUAVUiuL655DCG+mTbZ2Vd6WoskvWBN+xAfSrNMULb4L7l3g==
X-Received: by 2002:a17:902:e5cb:b0:1b8:a328:c1e6 with SMTP id u11-20020a170902e5cb00b001b8a328c1e6mr1436000plf.63.1690364768601;
        Wed, 26 Jul 2023 02:46:08 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902aa8700b001bb54abfc07sm12524660plr.252.2023.07.26.02.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:46:07 -0700 (PDT)
Date: Wed, 26 Jul 2023 17:46:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>,
	Donald Sharp <sharpd@nvidia.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZMDrW4nbj73IuDL8@Laptop-X1>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
 <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1>
 <ZLzhMDIayD2z4szG@shredder>
 <8c8ba9bd-875f-fe2c-caf1-6621f1ecbb92@kernel.org>
 <ZL+ekVftp24TzrHz@shredder>
 <7fb36754-9e7b-73a7-3c3b-0a8141e4a85f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb36754-9e7b-73a7-3c3b-0a8141e4a85f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 04:37:15PM -0600, David Ahern wrote:
> > This already happens in IPv4:
> > 
> > # ip link add name dummy1 up type dummy
> > # ip link add name dummy2 up type dummy
> > # ip address add 192.0.2.1/24 dev dummy1
> > # ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
> > # ip -4 r s
> > 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
> > 198.51.100.0/24 dev dummy2 scope link src 192.0.2.1 
> > # ip address del 192.0.2.1/24 dev dummy1
> > # ip -4 r s
> > 
> > IPv6 only removes the preferred source address from routes, but doesn't
> > delete them. The patch doesn't change that.
> > 
> > Another difference from IPv4 is that IPv6 only removes the preferred
> > source address from routes whose first nexthop device matches the device
> > from which the address was removed:
> > 
> > # ip link add name dummy1 up type dummy
> > # ip link add name dummy2 up type dummy
> > # ip address add 2001:db8:1::1/64 dev dummy1
> > # ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
> > # ip -6 r s
> > 2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
> > 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1 metric 1024 pref medium
> > fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> > fe80::/64 dev dummy2 proto kernel metric 256 pref medium
> > # ip address del 2001:db8:1::1/64 dev dummy1
> > # ip -6 r s
> > 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1 metric 1024 pref medium
> > fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> > fe80::/64 dev dummy2 proto kernel metric 256 pref medium
> > 
> > And this is despite the fact that the kernel only allowed the route to
> > be programmed because the preferred source address was present on
> > another interface in the same L3 domain / VRF:
> > 
> > # ip link add name dummy1 up type dummy
> > # ip link add name dummy2 up type dummy
> > # ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
> > Error: Invalid source address.
> > 
> > The intent of the patch (at least with the changes I proposed) is to
> > remove the preferred source address from routes in a VRF when the
> > address is no longer configured on any interface in the VRF.
> > 
> > Note that the above is true for addresses with a global scope. The
> > removal of a link-local address from a device should not affect other
> > devices. This restriction also applies when a route is added:
> > 
> > # ip link add name dummy1 up type dummy
> > # ip link add name dummy2 up type dummy
> > # ip -6 address add fe80::1/64 dev dummy1
> > # ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1
> > Error: Invalid source address.
> > # ip -6 address add fe80::1/64 dev dummy2
> > # ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1
> 
> Lot of permutations. It would be good to get these in a test script
> along with other variations - e.g.,
> 
> # 2 devices with the same source address
> ip link add name dummy1 up type dummy
> ip link add name dummy2 up type dummy
> ip link add name dummy3 up type dummy
> ip address add 192.0.2.1/24 dev dummy1
> ip address add 192.0.2.1/24 dev dummy3
> ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
> ip address del 192.0.2.1/24 dev dummy1
> --> src route should stay
> 
> # VRF with single device using src address
> ip li add name red up type vrf table 123
> ip link add name dummy4 up type dummy vrf red
> ip link add name dummy5 up type dummy vrf red
> ip address add 192.0.2.1/24 dev dummy4
> ip route add 198.51.100.0/24 dev dummy5 src 192.0.2.1
> ip address del 192.0.2.1/24 dev dummy4
> ip ro ls vrf red
> 
> # VRF with two devices using src address
> ip li add name red up type vrf table 123
> ip link add name dummy4 up vrf red type dummy
> ip link add name dummy5 up vrf red type dummy
> ip link add name dummy6 up vrf red type dummy
> ip address add 192.0.2.1/24 dev dummy4
> ip address add 192.0.2.1/24 dev dummy6
> ip route add 198.51.100.0/24 dev dummy5 src 192.0.2.1 vrf red
> ip address del 192.0.2.1/24 dev dummy4

I can add these to fib_tests later.

Hangbin

