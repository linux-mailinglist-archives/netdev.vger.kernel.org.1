Return-Path: <netdev+bounces-18890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB6758FBE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0282812F9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45050D305;
	Wed, 19 Jul 2023 07:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFDD2EE
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:56:59 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB60134
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:56:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a3efebcc24so4832665b6e.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689753417; x=1692345417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6YddHMYSIK0vis6YRkW9OC9r6ITP4FxaU9aH8dABhY=;
        b=AhVjpzM12pblyzjF6MLNrrUvxLwdnvVaOaNFsOmdG0kn85Z9msV7LgXzL8G0Fw9YBD
         y0+hyHBG/LeFD1DCvDKJMDA+nxyZ/fh3AT4xqintXk/9IasRqY9o4S3LLyy5/RJMK+fX
         2qlvds7UTl/VocTi4CvoQQENoNAMKFiKWJfmwJufGsaYbyzmObItD+2fdO5O1CIr6/oI
         XxEB7yXpYwjFHtTj8LBLP3yCDt8+T0Y4gJbRe626irtOGBq1WGi01mrFVFacvL1Ufzkq
         lNro7HuVbsVzWzI+oS5bu6twY+NFJ3SCKYhFMT78spd0pXO8ISv6kgghsHiIiUNQNny9
         1GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753417; x=1692345417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6YddHMYSIK0vis6YRkW9OC9r6ITP4FxaU9aH8dABhY=;
        b=JlqfVlehhlWeaZc4X2Y2VQ0iAvSRMhbS4Pc3TULvHmBGy/RtsiGwnmo3MSVoNkhJ/4
         CxmNXsnRMTgUbYGl79ZPKR8JvhtS29mvawMr/3TgDKB3yPAJ3I/Czu0KByLNHfGq4FOc
         7tRZFdsoQcwel2aMToAbaUPYfr6ixI+yMpDXg5rPOGd3RrpRBXoxo7Q0hzOgtwiejf1U
         UGNjjbjjVHEehPwg5C8Pou3I0OmHeg82uIuTknUjGTRLBnGmDQefqmf1Y35pMBC9hxc+
         wQbQWKqMpCDOD+3xiIadjTSee3c5EYt8qSFHBI06pHQ5LqHw3uouHB1VYaCTs68GGrwz
         5LQw==
X-Gm-Message-State: ABy/qLYKYzxkeSDiBIhCqY1ATERLpe6OmKooh3WcWuNY7fTOEEDBJ1fW
	pXRESxlked5CmwiJTZMJG6msNFN+ewoFG9d4
X-Google-Smtp-Source: APBJJlG8oXEBj59Wj7xcKE/thDjhatrkv7iMhKR5XXxYcy11plTBdLrP3YZ7QpFuTxwLF+j0tNZ1WQ==
X-Received: by 2002:a05:6808:1415:b0:3a3:7e8f:2f2a with SMTP id w21-20020a056808141500b003a37e8f2f2amr7503965oiv.11.1689753417237;
        Wed, 19 Jul 2023 00:56:57 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a1a1a00b00263987a50fcsm754777pjk.22.2023.07.19.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:56:56 -0700 (PDT)
Date: Wed, 19 Jul 2023 15:56:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net] ipv6: do not match device when remove source route
Message-ID: <ZLeXRBbsrSlAOiyE@Laptop-X1>
References: <20230718065253.2730396-1-liuhangbin@gmail.com>
 <ZLZ6ipKWo1dSW8Xc@shredder>
 <ZLePByChs5ZNtplQ@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLePByChs5ZNtplQ@Laptop-X1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 03:21:48PM +0800, Hangbin Liu wrote:
> On Tue, Jul 18, 2023 at 02:42:02PM +0300, Ido Schimmel wrote:
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index 64e873f5895f..ab8c364e323c 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -4607,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
> > >  {
> > >  	struct net *net = dev_net(ifp->idev->dev);
> > >  	struct arg_dev_net_ip adni = {
> > > -		.dev = ifp->idev->dev,
> > 
> > Wouldn't this affect routes in different VRFs?
> > 
> > See commit 5a56a0b3a45d ("net: Don't delete routes in different VRFs")
> > and related fixes:
> 
> Thanks for this notify. I saw this is for IPv4 only and there is no IPv6 version.
> I can try add an IPv6 version patch for this issue. The fib_tb_id is based
> on table id. So in same table we still need to not check the device and remove
> all source routes.

Oh, I saw struct fib6_info has fib6_table, I think we can check this when
remove prefsrc.

Thanks
Hangbin

