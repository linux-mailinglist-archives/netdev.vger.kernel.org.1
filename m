Return-Path: <netdev+bounces-47176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB17E8985
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 07:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126011F20EEF
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114116FC8;
	Sat, 11 Nov 2023 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJfha56h"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB526FBE
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 06:28:47 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CEE4204
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 22:28:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc1e1e74beso24919105ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699684125; x=1700288925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E63zgqUKaQM4aLm+widqkwMi/0OVWJqab8uh2TRe2so=;
        b=KJfha56hOQOCJUj5fk52vyR2H1tNaJ/nHl9WAUtrU9m2mddsQZpMrxXnED+tO59sqp
         yl9cccYjgb+1MAyzaSz8UzNYzd8q1c1U1uRp0qIYlzPeLeB9Dh0MNv3u8bIysqx/ryV/
         G4kDGd1UQzDtBNDS3jO1pluexJ9MDKsjr0KI2S4hYkbr+weQvRBQW5lYLJ2MgbKqTDmq
         NN8UAkRzEfRf3NE0djs6Hk+PUVj3q2aQPLfyNR7T2xPKejNTPPLnm5Amaq7m5PL7Se7k
         asODeshlknRULsLfpk4V40ttNrW95HjYH+KcrzjMQuNdTTEJRRM3VUIRI3Zg22kQhT4N
         4FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699684125; x=1700288925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E63zgqUKaQM4aLm+widqkwMi/0OVWJqab8uh2TRe2so=;
        b=EmQyxX93IwOSBPB4UGWygzi6s1tBMvEEpkkJp+dLS6LJTkd46f19fupAK4YgVI8wyl
         /P5LaJOPeLY19azhGAUFQlxXMIF2frKxV+O92n+oHL7ydgUzJu5kzvpm+Q+49K9tE2sg
         IciAavfIfBiJLsm9rjcgx+FQrHXLeaW3RJJWO3GHItg1RECdKknxuVHR3vXJaL6nmmVx
         oPtN3ImD9BUfA7HUGtkWdPdAzAiaIIlMGn8e7mwmNQ61KAzjBijt7cfX/jZHje6rtyT6
         5h8ICJDCb3lFx/gYR2JnofxP+CVe3HPY143ypnUZsUZH5tVZqIYYPJX28GHffrSn6oKU
         +85A==
X-Gm-Message-State: AOJu0YzoYleWHVlbkP4tdT0A2DKPet7cLa3dYyPe7oLSnUI3P1rpYpzs
	le/5unJCyjTcCwYoCIaN11w=
X-Google-Smtp-Source: AGHT+IG8RYqG4+cbr0cXBnA3+mUwD+Xoszuj6S15SKaHRrhyPYaVUjDk701ujiA4DD2KyAWN305WSQ==
X-Received: by 2002:a17:903:41c9:b0:1cc:4a84:27f2 with SMTP id u9-20020a17090341c900b001cc4a8427f2mr2264972ple.0.1699684125547;
        Fri, 10 Nov 2023 22:28:45 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001c5f7e06256sm653048plf.152.2023.11.10.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 22:28:44 -0800 (PST)
Date: Sat, 11 Nov 2023 14:28:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
Message-ID: <ZU8fGPrYauq9pojf@Laptop-X1>
References: <20231109180102.4085183-1-edumazet@google.com>
 <ZU2nBgeOAZVs4KKJ@Laptop-X1>
 <CANn89iLXNnHNdApy3JaOpnq-hkrDyR-vTYjDEiTaU5oJ1uAPTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLXNnHNdApy3JaOpnq-hkrDyR-vTYjDEiTaU5oJ1uAPTg@mail.gmail.com>

On Fri, Nov 10, 2023 at 09:38:18AM +0100, Eric Dumazet wrote:
> On Fri, Nov 10, 2023 at 4:44 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
> >
> > On Thu, Nov 09, 2023 at 06:01:02PM +0000, Eric Dumazet wrote:
> > > Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
> > > has been able to keep syzbot away from net/lapb, until today.
> > >
> > > In the following splat [1], the issue is that a lapbether device has
> > > been created on a bonding device without members. Then adding a non
> > > ARPHRD_ETHER member forced the bonding master to change its type.
> > >
> > > The fix is to make sure we call dev_close() in bond_setup_by_slave()
> > > so that the potential linked lapbether devices (or any other devices
> > > having assumptions on the physical device) are removed.
> > >
> > > A similar bug has been addressed in commit 40baec225765
> > > ("bonding: fix panic on non-ARPHRD_ETHER enslave failure")
> > >
> >
> > Do we need also do this if the bond changed to ether device from other dev
> > type? e.g.
> >
> >     if (slave_dev->type != ARPHRD_ETHER)
> >             bond_setup_by_slave(bond_dev, slave_dev);
> >     else
> >             bond_ether_setup(bond_dev);
> 
> Hmmm... possibly, but as far as I know, nothing can be stacked on top of IPoIB

The "stacked on top of IPoIB", do you mean IPoIB as an up layer or down layer
device?

BTW, not only IPoIB can be enslaved to bond, but also other types like gre could be
enslaved to bond.

Thanks
Hangbin

