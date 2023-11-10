Return-Path: <netdev+bounces-47032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E07E7A91
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E48F1C20B21
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2C10A33;
	Fri, 10 Nov 2023 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="um4F9GEg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044D10A22
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:19:27 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EB2BE0B
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:19:26 -0800 (PST)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EF5D140C37
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699607963;
	bh=M/V03KjMzwGuzb7oZQUr5e4nxvXwaKWIZ570CjwTnKs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=um4F9GEg9nftyLzMjkLnMdhRyidGSfGT9eabsy2WYbCjWwLUym3RP0PbAhhURq3Ok
	 xWekoQ/JNvJZpupgPSAoP3/gASw23Iim8kAMN4AJAEDE1aiN43tZiZpKsgsuCE/JkB
	 sB0vIOFjSziSl0NilqFtA0QEC+P4Qa318XabZ0wTBBcRfoZZKv3VQUCfrPQYUO5GNP
	 fd5rSnr5TXsl//guLLNbEctJHimdd4KPSWNbd6x7VKBU/3I/mV6Q0P+DNYEhc6RKkg
	 tSt1twh/Kc0N7gLI8Hwgt/0WEnzrwTliTUtf0ytiQXhM+C0IsJurLIS6tkPg1iRrOn
	 dRl/gGHE5dDtQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5091368e043so2117998e87.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607963; x=1700212763;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/V03KjMzwGuzb7oZQUr5e4nxvXwaKWIZ570CjwTnKs=;
        b=JUIdPdSiZStDDInYHnJspfbvTzr3uPS6z3FwK/d6c8AYN8C5qqHIs89zs8UmJFSVj/
         RyeqbNLygTf9yXHkwxWOb1KXdq19FVQfNod7JTDO0GFgsMly3EQ6yW+wtkjbffxFRpnG
         fmz0C7wvBC8JWdX7CfdlYpVe2hfmogcxTuGhDZOmUfNjuShdie7vgF152cCD6GMwNfos
         hBfWL4IE/0xb0chJ3LgCAHFSCi2gR6tMyVb0S7B3FovEkqxkLWfn+IGtD5/lXGQLasSe
         qcjs4tkmqJVi4Dr/W/sA12trNIJGOakzhKEVTcTxtZY2mIug26VTtKLqTlOB8cH6xtSK
         ua4w==
X-Gm-Message-State: AOJu0Yxy1HH44djfPjd/5KxB+epZzCIRFt3ekrrBuz3QmJ8aOO+lbILF
	6vgefUTiFeTmRhK7BeuMim/6ROxt2Pb5aZPmA+sGvk5GYRcZBBQV3+DiEEgY1+SoZ2r1IJ0Jl5r
	AHKw3FJZxW/tTlIXWXnlVjOmyo4WhEhgxuQ==
X-Received: by 2002:a05:6512:617:b0:509:8eb6:6837 with SMTP id b23-20020a056512061700b005098eb66837mr3298106lfe.47.1699607963449;
        Fri, 10 Nov 2023 01:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWYrFu+gO/ovDyZjG0tXens3pSjiW63V/nW6cVYUdFk5+H1lQ+RUF2R2S6ZaHcbrD2yQ50Mw==
X-Received: by 2002:a05:6512:617:b0:509:8eb6:6837 with SMTP id b23-20020a056512061700b005098eb66837mr3298093lfe.47.1699607963100;
        Fri, 10 Nov 2023 01:19:23 -0800 (PST)
Received: from vermin.localdomain ([195.13.248.78])
        by smtp.gmail.com with ESMTPSA id k32-20020a0565123da000b00507f18af7e0sm1324656lfv.4.2023.11.10.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:19:22 -0800 (PST)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 20AF01C3B46; Fri, 10 Nov 2023 01:19:22 -0800 (PST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 1F0611C3B45;
	Fri, 10 Nov 2023 11:19:22 +0200 (EET)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Eric Dumazet <edumazet@google.com>,
    "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
In-reply-to: <ZU2nBgeOAZVs4KKJ@Laptop-X1>
References: <20231109180102.4085183-1-edumazet@google.com> <ZU2nBgeOAZVs4KKJ@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 10 Nov 2023 11:44:06 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84245.1699607962.1@vermin>
Date: Fri, 10 Nov 2023 11:19:22 +0200
Message-ID: <84246.1699607962@vermin>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Nov 09, 2023 at 06:01:02PM +0000, Eric Dumazet wrote:
>> Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
>> has been able to keep syzbot away from net/lapb, until today.
>> 
>> In the following splat [1], the issue is that a lapbether device has
>> been created on a bonding device without members. Then adding a non
>> ARPHRD_ETHER member forced the bonding master to change its type.
>> 
>> The fix is to make sure we call dev_close() in bond_setup_by_slave()
>> so that the potential linked lapbether devices (or any other devices
>> having assumptions on the physical device) are removed.
>> 
>> A similar bug has been addressed in commit 40baec225765
>> ("bonding: fix panic on non-ARPHRD_ETHER enslave failure")
>> 
>
>Do we need also do this if the bond changed to ether device from other dev
>type? e.g.
>
>    if (slave_dev->type != ARPHRD_ETHER)
>            bond_setup_by_slave(bond_dev, slave_dev);
>    else
>            bond_ether_setup(bond_dev);

	I'm not sure I follow your comment; bond_enslave() already has
the above logic.  If the bond is not ARPHRD_ETHER and an ARPHRD_ETHER
device is added to the bond, the above will take the bond_ether_setup()
path, which will call ether_setup() which will set the device to
ARPHRD_ETHER.

	However, my recollection is that the bond device itself should
be unregistered if the last interface of a non-ARPHRD_ETHER bond is
removed.  This dates back to d90a162a4ee2 ("net/bonding: Destroy bonding
master when last slave is gone"), but I don't know if the logic still
works correctly (I've not heard much about IPoIB with bonding in a
while).  The bond cannot be initially created as non-ARPHRD_ETHER; the
type changes when the first such interface is added to the bond.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

