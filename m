Return-Path: <netdev+bounces-47648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 528897EAE43
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29290B20AB7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14391199D1;
	Tue, 14 Nov 2023 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erNXnvAA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7968C8C8
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:44:36 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63D186
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 02:44:34 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b6cb515917so2875968b6e.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 02:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699958674; x=1700563474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ese5ke2XLpSRBDcMeCq3hzLNmJ5F/1muLUoYSwpaxSU=;
        b=erNXnvAAQjmZY/8N0o3UONhQBz7It+nSvZWY9NZYb1AneNnRakG//zneGcIkL6uQHC
         eCErB1XeMetW/8SB7Jg8GW3bPu0GFSpQ5OZ2yFcoMp2DJRpzJwJFNMYqfO3bLf3w5y8D
         cK55hGQKYULYoRsABhdMuehBlZpsH+gyD8c3U1VMcuO3fjPMt/r06unNWobcNljs/ZTy
         Cpgp2UNJ3MDNkuUu25Rjo2StmaP1UGwdD8Rt/NLXevPfVwV5YoHCR7adMO8xHaxRuyjR
         405GVgACr2qsH+uTFr3ppqCPdTCUogKVZQ2xYzCi7dBHg9k/sWLeWXIEDpvGUiP8YK2t
         ESrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699958674; x=1700563474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ese5ke2XLpSRBDcMeCq3hzLNmJ5F/1muLUoYSwpaxSU=;
        b=SEM1/APk3JnLttX3O1fqfb79nmUYroRVnrMbarLwAS06qvyD94OywO3Oo3YaYii1jd
         eRjELu2Gn6/9tR6b4MZJDw5McyNoHscVY4hJmsgTqS4X8+cnskVZw6q1KLtuwAgF6d8J
         HHx27PJMHtwfPHd9EywPXihTj/EX/eLammN7PRnNOWx6sZYm5SWNPeSm+xhwzDGvPBY1
         N5o7d+EfKNfspF985Uy4z/M9JNKNCTGQN35mosNZk4H5O5WzEQB55oeYN7J10aNZBByu
         NzfnmtJ6QjrIfAfybh5NHxjhTyAxXCaKBr8/IYlxSn8XfeqI5QtdjLFQJVJ36+gdoTvb
         DW0g==
X-Gm-Message-State: AOJu0YzLGEmYmr0KdBJZr3awS/6+0jVxMK1xmPn4AGHAlkIUGJzo9JPE
	qFP0OhUE+/ZQkVNhX2Rnj54=
X-Google-Smtp-Source: AGHT+IGQnH4wysP3HUc+bm76QQNnQoy8z59V+hxPrwkW//Up3vQN2jRytRbS8C5DgblMsthrDZb/xA==
X-Received: by 2002:a05:6808:1794:b0:3ae:4cb2:fb43 with SMTP id bg20-20020a056808179400b003ae4cb2fb43mr13561395oib.21.1699958673982;
        Tue, 14 Nov 2023 02:44:33 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id 201-20020a6301d2000000b005b3cc663c8csm5279641pgb.21.2023.11.14.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:44:33 -0800 (PST)
Date: Tue, 14 Nov 2023 16:14:27 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	jiri@resnulli.us, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] netlink: specs: devlink: add missing attributes in
 devlink.yaml and re-generate the related code
Message-ID: <ZVNPi7pmJIDJ6Ms7@swarup-virtual-machine>
References: <20231113063904.22179-1-swarupkotikalapudi@gmail.com>
 <0d902d2b15ef44e9e0157d8012c42347ffeec86e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d902d2b15ef44e9e0157d8012c42347ffeec86e.camel@redhat.com>

eOn Tue, Nov 14, 2023 at 10:45:23AM +0100, Paolo Abeni wrote:
> On Mon, 2023-11-13 at 12:09 +0530, Swarup Laxman Kotiaklapudi wrote:
> > Add missing attributes in devlink.yaml.
> > 
> > Re-generate the related devlink-user.[ch] code.
> > 
> > trap-get command prints nested attributes.
> > 
> > Test result with trap-get command:
> > 
> > sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml
> > --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1",
> > "trap-name": "ttl_value_is_too_small"}' --process-unknown
> > 
> > {'attr-stats': {'rx-bytes': 30931292, 'rx-dropped': 87,
> >  'rx-packets': 217826},
> >  'bus-name': 'netdevsim',
> >  'dev-name': 'netdevsim1',
> >  'trap-action': 'trap',
> >  'trap-generic': True,
> >  'trap-group-name': 'l3_exceptions',
> >  'trap-metadata': {'metadata-type-in-port': True},
> >  'trap-name': 'ttl_value_is_too_small',
> >  'trap-type': 'exception'}
> > 
> > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> > Suggested-by: Jiri Pirko <jiri@resnulli.us>
> 
> Please insert the target tree in the subj prefix (in this case 'net-
> next')
> 
> Does not apply cleanly to net-next, please rebase it. 
> 
> Thanks,
> 
> Paolo
> 
Hi Paolo,

I have some emergency,
hence will not have access to computer for next 2-3 days,
once i am back, i will rebase and submit the patch again.

Thanks,
Swarup

