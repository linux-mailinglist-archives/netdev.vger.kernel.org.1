Return-Path: <netdev+bounces-30982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494778A58D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8444E280D16
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B6A54;
	Mon, 28 Aug 2023 06:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B79A4D
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:14:51 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82FBF
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:14:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c06f6f98c0so22054125ad.3
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693203290; x=1693808090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=68CcWGJ4YuPfQfiIaMvPv1zlUU3h3GYuXFhzPLKMOU0=;
        b=kjj/6kE3FMns8jRmpUOSfWnPHWGpKiPSeEMC8uj/RnvrN9dLvuG4vgf56u7ZNKZVTc
         iH1FzuJDAuwuXDncIi5XewJGMcdsgIHVl/wrDmcWzUMvDhqSBolNWHVk/w0SSP9dhD5E
         q9uTq0++fFKJSRoLbBC6qnBxvbFEmll5huStkyLYCPFud8a7PgMnVN/trZqyLf84ahZh
         za5iGhO/Dd+RYqxhfZ+ydlgtL5mg8Cs/gnKJZIRV8IHvYeIUkFz9a41aj7Qq2eoCxsR1
         OQ0w7w7gADeYO18U1OQGJW+xHsJNWLa2VZt5wW8pIFtoU4CeQdJBOdOuqNZ1oCfDyiB0
         AQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203290; x=1693808090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68CcWGJ4YuPfQfiIaMvPv1zlUU3h3GYuXFhzPLKMOU0=;
        b=kKLEy7H7OeA9Lak69Szu7IkqSSmSyNUMK+RaNrkTpNv53k6U0WuMQCWPe+rcFMZLBQ
         frjSJA0+vcSWXH8FG09KCoCOl0CKdBGbQq98OFo8TWrMmfylQAhq0wTrwAt6Yy6rYghd
         tNjvu49UjbnI/uPMxJqKn7QEHnpuQU/tDZOXGrRTG5saVMh0Ap18LkuKhyO54YZKOhEL
         mMKXjqa/XYbr2jxYOefin4022mJa4q+/WH4l89dcI6xKIeU2bVYNaUqUUhBUneyPiQlB
         qCDtI0AiAj3Hvhm8rO3X5/2h2JEyGsX0TDZUmW3QRAs70G2+Ealm97RP/2jpQMBVofNs
         BD8w==
X-Gm-Message-State: AOJu0Yx9PK26+YR5DxOWg1csbsRYZB2/48rpDR6J3Hbjbf+kA9jyM2RY
	mQ0qMzLcsBdehOjxIq0+qNo=
X-Google-Smtp-Source: AGHT+IHANB2QDvGeroTKD0s0IH/OS94RDn/s1KB6LllvNNEwSQ80juA617sZRg39eoaeQTbPcmJegQ==
X-Received: by 2002:a17:902:9342:b0:1be:f3aa:6fa1 with SMTP id g2-20020a170902934200b001bef3aa6fa1mr22422279plp.40.1693203289976;
        Sun, 27 Aug 2023 23:14:49 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001bb515e6b39sm6332579plf.306.2023.08.27.23.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:14:49 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:14:44 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Thomas Haller <thaller@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source
 address routes
Message-ID: <ZOw7VIMulJLyU0QL@Laptop-X1>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
 <20230809140234.3879929-3-liuhangbin@gmail.com>
 <ZNT9bPpuCLVY7nnP@shredder>
 <ZNt1wOCjqj/k/zAW@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNt1wOCjqj/k/zAW@Laptop-X1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Thomas,

Any comments?

Thanks
Hangbin
On Tue, Aug 15, 2023 at 08:55:35PM +0800, Hangbin Liu wrote:
> On Thu, Aug 10, 2023 at 06:08:28PM +0300, Ido Schimmel wrote:
> > On Wed, Aug 09, 2023 at 10:02:34PM +0800, Hangbin Liu wrote:
> > > After deleting an interface address in fib_del_ifaddr(), the function
> > > scans the fib_info list for stray entries and calls fib_flush() and
> > > fib_table_flush(). Then the stray entries will be deleted silently and no
> > > RTM_DELROUTE notification will be sent.
> > > 
> > > This lack of notification can make routing daemons like NetworkManager,
> > > miss the routing changes. e.g.
> > 
> > [...]
> > 
> > > To fix this issue, let's add a new bit in "struct fib_info" to track the
> > > deleted prefer source address routes, and only send notify for them.
> > 
> > In the other thread Thomas mentioned that NM already requests a route
> > dump following address deletion [1]. If so, can Thomas or you please
> > explain how this patch is going to help NM? Is the intention to optimize
> > things and avoid the dump request (which can only work on new kernels)?
> > 
> > [1] https://lore.kernel.org/netdev/07fcfd504148b3c721fda716ad0a549662708407.camel@redhat.com/
> 
> In my understanding, After deleting an address, deal with the delete notify is
> more efficient to maintain the route cache than dump all the routes.
> 
> Hi Thomas ,do you have any comments?
> 
> Thanks
> Hangbin

