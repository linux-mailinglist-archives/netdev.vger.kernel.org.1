Return-Path: <netdev+bounces-26130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DD776E53
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 05:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B946C1C21403
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AC815;
	Thu, 10 Aug 2023 03:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B77E4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:08:21 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661D1BFB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:08:21 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bca3311b4fso466730a34.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691636900; x=1692241700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXKc5zf0wzTy7sGcPtVBSnQoBNfCr8NlGw8/yx+aB/4=;
        b=ixL4JI6ol7z4DOM6R7gMzFQs7chKanmnPhJ6KU2rrnQfRpO+dyBZxburVpQv04gMkO
         Zg0nsAWpk7l3kpyLhdAWZCSQBirXbbnep6yxWDn3AimCyItOx7mKIjH/MD+OgfEycPpP
         dOv1XH1otgLvdbDVRCh0ypN08FqWxVGn++sPxCD1hFvyZcKxLr8+bWosCuLQ4XUUxY7O
         6wR+roaNYe7IlYl8ocwQTh45IgzEyNNHyeRoQWhY8oMoHvPfWL07XdYDObWAB3gFNky3
         T+/kWb0BwxbiVgJB2DuqNTQmmVVFAUro93OxkpZgDA0Q/DG32nxOTWBgH4z+be5zQJ0Q
         PkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691636900; x=1692241700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXKc5zf0wzTy7sGcPtVBSnQoBNfCr8NlGw8/yx+aB/4=;
        b=fLKzQfM1pQE98osPWJEKet8oxT16aVVNbMVMayzS2CrkbmUTb3ehgKJ6YMWeKpwSr8
         15CtcE8Nn8LiGSQt6SwzQzuEseCVgOUUNyAAnaW8mshLzQAaTu8/ZOOn93uvJW2RwkTW
         zYYUVRP3LPG4fknqKV4n0JT/us9QAfbin56/LTcRstYzGIZuYkJnATJmdwgNIJnWPUzD
         Us70gofGdjQSZjEuyancQWuAa7srKLSDiXVUW7hFiqhgyTo2tgpjqMKNbOkylfBk9XBz
         rT6uiAv2d5224YThAePcSAssDZD/alhZKMYOOwbDvrrr4mpVwLLD4uL9jGGYk0lzPBmL
         eobQ==
X-Gm-Message-State: AOJu0Yx+JxCVosfaAUEtOIZ3Id5tL57LP6qz8+ws1XIdcc0B1sDTqKh3
	zjY6V3qcfZQjK0wPWp+FRPY=
X-Google-Smtp-Source: AGHT+IFzAMNrIOZC275tLXdbTvoNe9+d4DYj7DqZj1FMPkHb8ZZnE3e+F8pVTMLVE4p7gvf+gvdRfQ==
X-Received: by 2002:a05:6358:8a1:b0:135:99fa:5040 with SMTP id m33-20020a05635808a100b0013599fa5040mr1659446rwj.12.1691636898679;
        Wed, 09 Aug 2023 20:08:18 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s189-20020a635ec6000000b00563feb7113dsm351631pgb.91.2023.08.09.20.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 20:08:18 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:08:13 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andy@greyhouse.net, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH net-next 3/5] bonding: remove unnecessary NULL check in
 debugfs function
Message-ID: <ZNRUnUV92x1s3Aj0@Laptop-X1>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-4-shaozhengchao@huawei.com>
 <CAAoacN=Lmh0h_9wQvAe_NRDw_SV22NYA3CN_-uvkOoPs6kQmxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoacN=Lmh0h_9wQvAe_NRDw_SV22NYA3CN_-uvkOoPs6kQmxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:13:31AM -0700, Jay Vosburgh wrote:
> On 8/9/23, Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> > Because debugfs_create_dir returns ERR_PTR, so bonding_debug_root will
> > never be NULL. Remove unnecessary NULL check for bonding_debug_root in
> > debugfs function.
> 
> So after this change it will call debugfs_create_dir(), et al, with
> the ERR_PTR value?  Granted, the current behavior is probably not
> right, but I don't see how this makes things better.

I guess Zhengchao means to remove Redundant checks? The later
debugfs_create_dir/debugfs_remove_recursive/debugfs_remove_recursive functions
will check the dentry with IS_ERR(). But I think the commit description need
an update.

Hangbin

> 
> -J
> 
> >
> > Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> > ---
> >  drivers/net/bonding/bond_debugfs.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_debugfs.c
> > b/drivers/net/bonding/bond_debugfs.c
> > index e4e7f4ee48e0..4c83f89c0a47 100644
> > --- a/drivers/net/bonding/bond_debugfs.c
> > +++ b/drivers/net/bonding/bond_debugfs.c
> > @@ -49,9 +49,6 @@ DEFINE_SHOW_ATTRIBUTE(bond_debug_rlb_hash);
> >
> >  void bond_debug_register(struct bonding *bond)
> >  {
> > -	if (!bonding_debug_root)
> > -		return;
> > -
> >  	bond->debug_dir =
> >  		debugfs_create_dir(bond->dev->name, bonding_debug_root);
> >
> > @@ -61,9 +58,6 @@ void bond_debug_register(struct bonding *bond)
> >
> >  void bond_debug_unregister(struct bonding *bond)
> >  {
> > -	if (!bonding_debug_root)
> > -		return;
> > -
> >  	debugfs_remove_recursive(bond->debug_dir);
> >  }
> >
> > @@ -71,9 +65,6 @@ void bond_debug_reregister(struct bonding *bond)
> >  {
> >  	struct dentry *d;
> >
> > -	if (!bonding_debug_root)
> > -		return;
> > -
> >  	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
> >  			   bonding_debug_root, bond->dev->name);
> >  	if (!IS_ERR(d)) {
> > --
> > 2.34.1
> >
> >

