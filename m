Return-Path: <netdev+bounces-31128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10678BC57
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 03:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C136280F19
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F77FF;
	Tue, 29 Aug 2023 01:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6B7FA
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 01:07:55 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295812D
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 18:07:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbf10333bso30160285ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 18:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693271274; x=1693876074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPbW47pZT+pAVeMclK+lu3UmNpzz/SgVXYHgP23l6o0=;
        b=d9vq4ZZEJsCadXYoUzjlWIk+HWho6QzeJy9gB0bVV44HKqOpc/f5piFDoRIViI/0/f
         doh0AzOHWR+pXBn0vNMHjh/Vx99rsN7W06pvSht6BAY5tqPY6yfGAu9cCxcEhoC69a2h
         wDXhgdYrU4lAySm/Ky0k3qItUYutQLYCBfQN5h5hJLifKv0TXXE5MM6dA1GlCDpH+yjI
         nzNH+mUTdd9URfl7brB3ZMdx29IQ4OtsLz3UFcK6kHEJt5sYk7tmaOBJS2hnApvVFUb+
         vW5dwGtvl7gvHOdwee49EgvRe8UNV7kfjKx0cV3IlLGxZz9Wix3pygc9t79LO5LG2P3r
         D7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693271274; x=1693876074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPbW47pZT+pAVeMclK+lu3UmNpzz/SgVXYHgP23l6o0=;
        b=jaq1WzC6i5XG8AEp5v/PVU9O1h5PEOm5GpZa5Q4cEXI1v7LWcJLheFeZumkzsLVgx+
         APZCcGu3vYq0U/Y4oYJMo7ItQkVYd7l27GOfb8HAUs2JRmu1VhkSTXlb0axQR1A8Jszq
         rqPgqsye1Czy5cZTqQioUpJRAUy7I+1FPvma19DcsdnDxerBJJZAcCmy01wwo7fQ9ryr
         oWDku8ulQehOYLtmqEQH4AJH/91mm4KlLcvZGlbZkEXwcr+vyPrTksl+bYNJDMnGh0k/
         48V88JDrlRSv5LHgiFHpglzJEZHIoEe0x5vqDEB1A6XyGqVsk4VoEreeUQrqkir1Q5Rw
         xo/Q==
X-Gm-Message-State: AOJu0YyVvxOfljP1+vtufzRbbwOYdHsq6p+wFxiQixS7WqjStcHNx/WG
	/QNb5fi3arct86LKNr/SgP8=
X-Google-Smtp-Source: AGHT+IFPiy+QJXhLH+MvjpJrnkv5Jpw4ZDXQ0mgQOT7gKwNCvQNG47JzInEUeMJa0gMJ6M71G4ngYA==
X-Received: by 2002:a17:903:2291:b0:1bc:6c8:cde3 with SMTP id b17-20020a170903229100b001bc06c8cde3mr32684048plh.57.1693271273772;
        Mon, 28 Aug 2023 18:07:53 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7820:a6d0:fe00:94b0:34da:834c])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bdc8a5e96csm8048315plg.169.2023.08.28.18.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 18:07:52 -0700 (PDT)
Date: Tue, 29 Aug 2023 09:07:46 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route
Message-ID: <ZO1E4iy5hmd4kpHl@Laptop-X1>
References: <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1>
 <ZMKC7jTVF38JAeNb@shredder>
 <ZOxSYqrgndbdL4/M@Laptop-X1>
 <078061ce-1411-d150-893a-d0a950c8866f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078061ce-1411-d150-893a-d0a950c8866f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 09:06:25AM -0600, David Ahern wrote:
> >>> But there are 2 issues here:
> >>> 1. the *type* and *protocol* field are actally ignored
> >>> 2. when do `ip monitor route`, the info dumpped in fib6_add_rt2node()
> >>>    use the config info from user space. When means `ip monitor` show the
> >>>    incorrect type and protocol
> >>>
> >>> So my questions are, should we show weight/scope for IPv4?
> > 
> > Here is the first one. As the weight/scope are not shown, the two separate
> > routes would looks exactly the same for end user, which makes user confused.
> 
> Asked and answered many times above: Weight has no meaning on single
> path routes; it is not even tracked if I recall correctly.

Yes, I'm sorry that I asked this question over and over again. Because I
always got the answer that these are two different routes and weight are
meaningless for none-multipath route. But IIRC, I never got a straight answer
of what we should deal with this problem.
> 
> > So why not just show the weight/scope, or forbid user to add a non-multipath
> > route with weight/scope?
> 
> That is a change to a uAPI we can not do at this point.

Yes, that's the answers I want to receive. Either show it, forbid it, or
not change it as it would change uAPI.

> 
> > 
> >>> How to deal the type/proto info missing for IPv6?
> > 
> > What we should do for this bug? The type/proto info are ignored when
> > merge the IPv6 nexthop entries.
> 
> I need more information; this thread has gone on for a long time now.

Sure, here is the reproducer:

+ ip link add dummy1 up type dummy
+ ip link add dummy2 up type dummy
+ ip addr add 2001:db8:101::1/64 dev dummy1
+ ip addr add 2001:db8:101::2/64 dev dummy2
+ ip monitor route
+ sleep 1
+ ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100 metric 1024 pref medium
+ ip route prepend unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
2001:db8:103::/64 table 100 metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy2 weight 1
        nexthop via 2001:db8:101::10 dev dummy1 weight 1

   ^^ Here you can see the ip monitor print the route with unicast, even the
      "dev dummy1" route should be local

+ ip -6 route show table 100
local 2001:db8:103::/64 metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1

    ^^ But the final route still keep using local. Which is different with
       what `ip monitor` print

+ ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 table 200 proto kernel metric 1024 pref medium
+ ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
2001:db8:104::/64 table 200 proto bgp metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy2 weight 1
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
+ ip -6 route show table 200
2001:db8:104::/64 proto kernel metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1

        ^^ Same here, ip monitor print protocol bgp, but the actual protocol
           is still kernel. We just merged them together and ignored the
           protocol field.

+ kill $!

As I asked, The type/proto info are ignored and dropped when merge the IPv6
nexthop entries. How should we deal with this bug? Fix it or ignore it?

Thanks
Hangbin

