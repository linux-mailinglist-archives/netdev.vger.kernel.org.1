Return-Path: <netdev+bounces-20923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4F761E9B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6269F1C20F15
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C61F17F;
	Tue, 25 Jul 2023 16:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34323C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:36:22 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F41723
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:36:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666eec46206so5332468b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690302980; x=1690907780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A97CSwlbfr210L3xTQ2jj0vKUT2FgRDInPwyOX20/gE=;
        b=VRysFcXRTefeFQBE0UR6NDP+PAQQjgwFNVpTR8WfNFrozyrp+1T0W7dkICBUD122V7
         eQhtA7g7ciSBBGSQlMx5iahj207wZkIO/O0/YAltwAI8B9ujueQeUJ4QD+EnuZ9tGOZz
         kfEKTVbrtx/NaHdNbYltAOIMjG5L1AQRuaek0DS34N5huJoT1ZZTEPrZdP+2HdbUGzJW
         14PjctGmCeVcMqxCfTjnHplB0aM9EZzqcqMHcMGNrXT2hKCiVvGytfY+zh5oMppE1VQf
         +OYYrJ0TdB/Q2SKql51mhCi3NCVWitFr0D0NHd9ml71JPnOKfaL8tr2bNVJ/Oi6ii13E
         9QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302980; x=1690907780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A97CSwlbfr210L3xTQ2jj0vKUT2FgRDInPwyOX20/gE=;
        b=dmfghQlgx3po9FRnHWSi2XCRjJCGPCUmqZmecLHfj81iuik0G/b+89BRBOu7yZfda0
         wiZc64d57u7mGgwNXqIMhTe4bhZrT3D9eJb6oPgXyzJtLygiGJlyJ9KONxsr81pVZWvo
         AXVB+xTqUoCgP/9DuVOB2ppbXEXh9HtLvQIvd2rOddqkop90C6R2OZV3FAvEsi41DW6E
         oA6Z3oseZHkmH90ARnHO6R0iSDOri1betgY/LAchCNBNQvoZXJKSTTUlb9tbT086qGhc
         aEbKivbjWj7dsExRhhgXmoCNDgZZC1IgmQ3ycHYxAfKIrsOfUnCdnxL5CUjpo8PmNcVd
         P64A==
X-Gm-Message-State: ABy/qLY0M2nCDs0jvKu/xvhyOls84IMKwAoDhfSyVizizoPWVWiVHJPR
	l2FNsmNTPhMY9VGQ3GzOvBwzHA==
X-Google-Smtp-Source: APBJJlF4Q5goY33ok4MsLz2bafCQ34dB7Bd0Vs7XQAJPCYP93GYqwi8qz52aspKgRe+xdEV68Cp3Bg==
X-Received: by 2002:a05:6a00:1409:b0:686:24e1:d12e with SMTP id l9-20020a056a00140900b0068624e1d12emr14484091pfu.30.1690302980077;
        Tue, 25 Jul 2023 09:36:20 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id h23-20020aa786d7000000b0067f11aa76cbsm9856360pfo.108.2023.07.25.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:36:19 -0700 (PDT)
Date: Tue, 25 Jul 2023 09:36:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <20230725093617.44887eb1@hermes.local>
In-Reply-To: <ZL+F6zUIXfyhevmm@Laptop-X1>
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
	<ZL+F6zUIXfyhevmm@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 25 Jul 2023 16:20:59 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Mon, Jul 24, 2023 at 08:48:20AM -0700, Stephen Hemminger wrote:
> > On Mon, 24 Jul 2023 16:56:37 +0800
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> >   
> > > The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
> > > the cache becomes inconsistent. The IPv4 will not send src route delete info
> > > if it's bond to other device. While IPv6 only modify the src route instead of
> > > delete it, and also no notify. So NetworkManager developers complained and
> > > hope to have a consistent and clear notification about route modify/delete.  
> > 
> > Read FRR they get it right. The routing daemons have to track kernel,
> > and the semantics have been worked out for years.  
> 
> Yes, normally the routing daemon need to track kernel. On the other hand,
> the kernel also need to make a clear feedback. The userspace developers may
> not know the kernel code very well. The unclear/inconsistent notification
> would make them confused.

Right, that should be addressed by clearer documentation of the semantics
and the rational.

