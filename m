Return-Path: <netdev+bounces-47017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F37E7A36
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF21B1C20B6E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F3ED7;
	Fri, 10 Nov 2023 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7dujEP1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8141C3C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:38:36 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BCA256
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:38:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so21284a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699605512; x=1700210312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9enKIlQx7Ll0We+uQl4xwkZb2Jwnx+iM0ls3QWAyu8=;
        b=N7dujEP1wOWD8itcEQmgaq+WuFYrXo+xdSLevfOA8blSoS6qfugDXqeAQxueiPE1SY
         Axr3XWI6DIw8hSo6kFMVVaGi608Br65/HWOhtNRiicOBBQ9X1tTNS/FBVP6CppXC9khp
         jvK3QF4Kg0qxf9foxJi6xNdeYxbtkG8ASvTzmZ2T+2wAWqqeMI2lfzBHgwpgD/i7DsyU
         vVQsnINjIDTg/22YJrYPeaCacwC9qwV5Fky3V9PKTPGesdRrAot+cem8UW3J/0z02tn+
         s+vT6kVA+iIl3vTbXN9uOGpYwhE/cNvUl9BAJj3QTe1u2eQzohR9uMxyOqbetMfoub/D
         SbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699605512; x=1700210312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9enKIlQx7Ll0We+uQl4xwkZb2Jwnx+iM0ls3QWAyu8=;
        b=ZnUlGOjOlk1+9wDBVbwanGXrxEcOH9PreQ2XYSEGdSdPfdDKP1oZ67rnt1PciAYBQ6
         3WRW8rJomZY4BMZW5n5s9oot7UIiEorS+8uX5PUt0mZLR9v0JyFeAoUFM/F59fdoLq6y
         sS4JNiiuGR63cCqU7oEhRM8S/Kd+kQEdvoUlj6c3NXcegEV0tJskzhZBo+i6oEd94kRW
         5LZ8Cu+/yYZQ14XPkDHEU11N7A+4nbFliNhipmAVlQ2OpjM1SE/qDSpuY2nOwwXc3W40
         nqV3YoAqxs+uYBrgaG0yQd5ZzTNc6XCf3CBGbIalnRzYVQPIUKhlqFLGEI/1iXaHG/mJ
         zGFQ==
X-Gm-Message-State: AOJu0YysqBuZ9d05QCR4yvQbSFhQGZxe7ryBBdk708PeopCC/c5iNo5/
	9POKMT/V3wthhVG1cUy0a4aFeZoY/c8hpP0NOHRlWA==
X-Google-Smtp-Source: AGHT+IEBFpWM6rT58IrR0RMqmNvgsw5e9jnd06qZHvYrlq5rVZEoxlryCRIKPsRcix1X+pGqo0qCGXhR77kw2edEUQM=
X-Received: by 2002:a05:6402:5410:b0:545:2e6:cf63 with SMTP id
 ev16-20020a056402541000b0054502e6cf63mr356431edb.6.1699605511709; Fri, 10 Nov
 2023 00:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109180102.4085183-1-edumazet@google.com> <ZU2nBgeOAZVs4KKJ@Laptop-X1>
In-Reply-To: <ZU2nBgeOAZVs4KKJ@Laptop-X1>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Nov 2023 09:38:18 +0100
Message-ID: <CANn89iLXNnHNdApy3JaOpnq-hkrDyR-vTYjDEiTaU5oJ1uAPTg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 4:44=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Thu, Nov 09, 2023 at 06:01:02PM +0000, Eric Dumazet wrote:
> > Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
> > has been able to keep syzbot away from net/lapb, until today.
> >
> > In the following splat [1], the issue is that a lapbether device has
> > been created on a bonding device without members. Then adding a non
> > ARPHRD_ETHER member forced the bonding master to change its type.
> >
> > The fix is to make sure we call dev_close() in bond_setup_by_slave()
> > so that the potential linked lapbether devices (or any other devices
> > having assumptions on the physical device) are removed.
> >
> > A similar bug has been addressed in commit 40baec225765
> > ("bonding: fix panic on non-ARPHRD_ETHER enslave failure")
> >
>
> Do we need also do this if the bond changed to ether device from other de=
v
> type? e.g.
>
>     if (slave_dev->type !=3D ARPHRD_ETHER)
>             bond_setup_by_slave(bond_dev, slave_dev);
>     else
>             bond_ether_setup(bond_dev);

Hmmm... possibly, but as far as I know, nothing can be stacked on top of IP=
oIB

Note that another way to deal with this in a fine grained way is to
return NOTIFY_BAD
from NETDEV_PRE_TYPE_CHANGE event (vlan, macvlan, ipvlan ...)

