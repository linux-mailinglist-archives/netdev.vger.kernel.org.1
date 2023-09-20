Return-Path: <netdev+bounces-35274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522DF7A8658
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0698E2816F2
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F23B297;
	Wed, 20 Sep 2023 14:17:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A436B04
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:17:56 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80096AF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:17:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fac346f6aso6176746b3a.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695219475; x=1695824275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/eTFZ7uCKZ9v4CHpUqYa98em2L3vG96HBbArbtAyZs=;
        b=i152UXeiSqxFrFwIzm2WlTzsnG2hVU96s3UVWTxBRaJJggON/79wDRL/lWRDmi8Qix
         umQdqVhv1UYSgzmTIE79CK1EpCYJxD8f52dr+TpwWRwV/ao0ceffBQgx/iC/8ytWsLD5
         1wmWKKqj0XYykxNaYbQJ1RA0cGEAgvr6bMEvOpW3cLHzjcmzAWOP0rPnSs1PCBHO3Bdd
         l3Px1U1aO/au9J0j+ZrFiUfdtcz5phNrd52hGx9Bby0kFDkwsdkZjrX+svODRhv/mKCR
         dZX7Ah7BBEKaJEu3MDAZj71c5VP30rD1z1xuZqToWcL36ypIlBnEyau2tO5PIOnEA2OO
         hcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219475; x=1695824275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/eTFZ7uCKZ9v4CHpUqYa98em2L3vG96HBbArbtAyZs=;
        b=nGuB7NHT44f5Wpg7UxiKIhp+XJ2CQjTeV35i2UrF51lJVrqs3FKdG8FslyUiYFs0s7
         G6K63J8iWVSQCMHfPu/GSM2UU+0tJ8zAPkIT9S0u6pDqzJ21wjicFscqj0ExxnpGJ79d
         55v99yjcX3iAjv91oCP8/Ml4+nJUHaPwdMLQ5NO3Y8iGBhcmB4LGLj3HjWo4AEfdVC51
         /our9jOziUB3BOXAGpwk/8yB69OkJRhSupCZAr+o6qcDbSnKc0QUmX+3IbOCG37p44sH
         yMV0XT2HPlIj4FT+1LfwVix0WjwDKcikW0kpTtHyL+DLt3jQTU5IVbnAeZz/6m1QIVyX
         xkXA==
X-Gm-Message-State: AOJu0YzbmcJLeB+Yi6rOcxwYl2ey74hvKd6mJehFAO+t20vYZ9zasTNm
	eoV3A+Tnl3xwnv+pRXBbLNI=
X-Google-Smtp-Source: AGHT+IHFciWSYuMa8CVewG06ZBezK8P38CP9I1yZhBAZNfVBkgTUkKn/SuvMhOPn7p8aVhWrflxoHw==
X-Received: by 2002:a05:6a20:258b:b0:151:577:32d1 with SMTP id k11-20020a056a20258b00b00151057732d1mr3118581pzd.22.1695219474744;
        Wed, 20 Sep 2023 07:17:54 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i189-20020a639dc6000000b0050f85ef50d1sm9370804pgd.26.2023.09.20.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:17:53 -0700 (PDT)
Date: Wed, 20 Sep 2023 22:17:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC Draft PATCH net-next 0/1] Bridge doc update
Message-ID: <ZQr/DCnTQXu34K61@Laptop-X1>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
 <ZQq5NDqPAbwi98yU@Laptop-X1>
 <e6b9ed8b-7044-0fab-a735-fa9cbeeb97c1@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b9ed8b-7044-0fab-a735-fa9cbeeb97c1@blackwall.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 01:38:44PM +0300, Nikolay Aleksandrov wrote:
> > On Wed, Sep 13, 2023 at 05:28:52PM +0800, Hangbin Liu wrote:
> > > Hi,
> > > 
> > > After a long busy period. I got time to check how to update the bridge doc.
> > > Here is the previous discussion we made[1].
> > > 
> > > In this update. I plan to convert all the bridge description/comments to
> > > the kernel headers. And add sphinx identifiers in the doc to show them
> > > directly. At the same time, I wrote a script to convert the description
> > > in kernel header file to iproute2 man doc. With this, there is no need
> > > to maintain the doc in 2 places.
> > > 
> > > For the script. I use python docutils to read the rst comments. When dump
> > > the man page. I do it manually to match the current ip link man page style.
> > > I tried rst2man, but the generated man doc will break the current style.
> > > If you have any other better way, please tell me.
> > > 
> > > [1] https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/
> > > 
> Hi Hangbin,
> I support all efforts to improve documentation, but I do share the same
> concerns that Stephen has already voiced. I don't think we should be
> generating the man page from the kernel docs, IMO it would be simpler
> and easier for everyone to support both docs - one is for the user-space
> iproute2 commands, the other could go into the kernel api details. All
> attribute descriptions can still be added to headers, that would be very
> valuable on its own. I prefer to have the freedom to change the docs format
> in any way, generating them from comments is kind of limiting.
> The purpose of each document is different and it will be difficult
> to combine them for a man page. It would be much easier for everyone
> to add user-related command descriptions and examples in iproute2's
> documentation, and to add kernel-specific (or uapi) documentation to the
> kernel doc. We can add references for each with a short description.

Hi Nikolay,

Thanks for the feedback. I agree that it's more reasonable to have
different docs for user-space and kernel api. As long as our bridge developers
satisfied to maintain these 2 docs at the same time, I'm totally OK to drop
this bloated convert tool.

> W.r.t the kernel doc topics covered, I think the list is a good start.

Thanks, I will add more parts and re-post it next month.

Regards
Hangbin

