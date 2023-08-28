Return-Path: <netdev+bounces-31000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605C78A6CF
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105021C2082F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C82CEDB;
	Mon, 28 Aug 2023 07:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D603EC2
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:53:13 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F4119
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:53:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2304490b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693209191; x=1693813991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqQWWZQ2uQBKVlfUq3BfUr1TRB7hQUuGLZ3aS8fGAzo=;
        b=cQ3FtABhXAUx7CoRPVWhRIQHJfEUkmmERXertgEfooZ6p35zvslR1r6QKeUQu8wTcx
         UIVzXZrC48A1PHnbc2dwEubbA2FtshjzHJ8wCZG+/Mg3Qwt8yGjx8/yoiGRjZ0Sk4IjA
         UvEQS7qatL7BF+m0L0mditnL7ruq611IX4UWsbkm+J0NLmBgaCzzJF96YnGKJ6PbZozk
         gI9bhgX22dXtdtpo+hBhzqDT9NxKvr3g3NjdjcPfgo72VY5OsKnZpTopEPK2yx4ylx5x
         QkSnQEVXtBh2n/iv8rWW5piIp6KJGf2XNhAfwOT9jnESglU+fB2jp6j1z5PdkRaZyOiM
         zPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209191; x=1693813991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqQWWZQ2uQBKVlfUq3BfUr1TRB7hQUuGLZ3aS8fGAzo=;
        b=KhK0TQylkbQPAThGArGanZA22PRW/1sOr7Kp7lQcwv1xRI3pKBUbbTDJI+LDJ680jK
         4MQLi3c66Z9YS7M5zBNbNv1q+FsjF1FSC6zK2Gh9qNpxvvaYlCfE/2wViq3Kafv2rcds
         41h3FLMhLiSJF6+4dI5u5EmmpJlYlk2nIQiy8f44o6tEfCIWNYdCtodRNRx14gieZKcd
         oVKYa8TD6DQwZ71/ByY8nxjpjU3oVWV+ckE/KbOj/AmR7pBtS7lQ2qwzh1pmlSG1+N4Y
         CmQuexqE4FjQzQLY1es8PE2Frm13uGi8Tn8FW40EQo2w/o3Jho3DbOa6wpsmQUVxmF0N
         DKrQ==
X-Gm-Message-State: AOJu0YxFPjnpjKT3T457UuPd5tVql/IFguq/5I1igw3Prqhb3mlf5j7r
	6XDTlccHwCFjzJFk7muxCPQ86FTCTNehhQ==
X-Google-Smtp-Source: AGHT+IFFdpMUajdkNQt5gHOhXNclFPyOySEv1CdQOtdO9dJ72xd94b38k3FcOAMjjNbpywefjx7FaA==
X-Received: by 2002:a05:6a21:498e:b0:13f:5234:24ce with SMTP id ax14-20020a056a21498e00b0013f523424cemr28317431pzc.28.1693209191163;
        Mon, 28 Aug 2023 00:53:11 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ik15-20020a170902ab0f00b001bdc7d88ee3sm6695754plb.37.2023.08.28.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:53:10 -0700 (PDT)
Date: Mon, 28 Aug 2023 15:53:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route
Message-ID: <ZOxSYqrgndbdL4/M@Laptop-X1>
References: <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1>
 <ZMKC7jTVF38JAeNb@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMKC7jTVF38JAeNb@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ido,

I'm back on this question again. Hope you are not too tired on this topic.

Because in you last reply you only answered that we'd better using new nexthop
API (which I'm totally agree) to resolve the consistent of IPv4 and IPv6. New
feature should also go for the new api. But, it always takes a lot years
for the end user using new API (e.g. some users are still using ifcfg).

What I'm asking is how we should deal with the bugs for old API. See my reply
below.

On Thu, Jul 27, 2023 at 05:45:02PM +0300, Ido Schimmel wrote:
> > Since the route are not merged, the nexthop weight is not shown, which
> > make them look like the same for users. For IPv4, the scope is also
> > not shown, which look like the same for users.
> 
> The routes are the same, but separate. They do not form a multipath
> route. Weight is meaningless for a non-multipath route.
> 
> > But there are 2 issues here:
> > 1. the *type* and *protocol* field are actally ignored
> > 2. when do `ip monitor route`, the info dumpped in fib6_add_rt2node()
> >    use the config info from user space. When means `ip monitor` show the
> >    incorrect type and protocol
> > 
> > So my questions are, should we show weight/scope for IPv4?

Here is the first one. As the weight/scope are not shown, the two separate
routes would looks exactly the same for end user, which makes user confused.
So why not just show the weight/scope, or forbid user to add a non-multipath
route with weight/scope?

>> How to deal the type/proto info missing for IPv6?

What we should do for this bug? The type/proto info are ignored when
merge the IPv6 nexthop entries.

Thanks
Hangbin
>> How to deal with the difference of merging policy for IPv4/IPv6?
> 
> In my opinion, if you want consistent behavior between IPv4 and IPv6 for
> multipath routes, then I suggest using the nexthop API. It was merged in
> 5.3 (IIRC) and FRR started using it by default a few years ago. Other
> than a few bugs that were fixed, I don't remember many complaints. Also,
> any nexthop-related features will only be implemented in the nexthop
> API, not in the legacy API. Resilient nexthop groups is one example.

