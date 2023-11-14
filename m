Return-Path: <netdev+bounces-47580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69467EA7B9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236971C20A39
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EC3D70;
	Tue, 14 Nov 2023 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Gm3W4H47"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC941FD8
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:43:36 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0931189
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:43:34 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C10FF409DB
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699922612;
	bh=384E7T0VW5TfINQdbxB0+zuNVaMh+Bw+nQQjuwD00u0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=Gm3W4H476mW4tGip8l0wSMdqlcmfhxJToUVsqOZ3PTI8vGdWC423DtCMiST0JExgj
	 xmE6V2irDmvg2Hvj3wqbVfYWOh4YwWwVnoQ9vS7hooYgp5d7v5JCQ36+EsckDtiVCi
	 BWVXNHM4ZLwgiZ3QIbjWuKkdtRawwZ/pMOLSIlx/ACsSHkSGOQiUwa9/Lx9yCVj/xP
	 we82MGMi27sw0DeJxEdR5oPc0+4WOBAzpa1kEOpydXFdSTdyMnBzFK4zxkVnjRPJnr
	 ZWs7UB5lqo1omrIb8lUG7DcNmZD2LvZ2Bdv9EM6wjBZ18B1WrMI6CabBjYhBnU4cI3
	 0T2iuAFf1736A==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc1397321fso56285065ad.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699922611; x=1700527411;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=384E7T0VW5TfINQdbxB0+zuNVaMh+Bw+nQQjuwD00u0=;
        b=H+zS7m0tXKzJC/wC0eOkjtPXhZZS0GcC4wHC7R/ScJk4bPCmOxJ9a19eQWLKd/e3My
         rUlBaAjQQX4uVYAbcuhDZFN/6Nlr8AOGpgaqLKpm0JJXqtcKsa4BCSXkOA9ED05ZzbWc
         xUgZFlpibHlo8DlyrsnG6QsFLuHswx37+ml6uRa3yx9B3odSmv4TJITxROQ/E6JrQBYE
         w4ngeix7UA7xG7JST91gjlQis4Z3AHClJT0D9+XUWPNTa/pRO9dCo5iavuQVlYJ9ESWW
         BALNAv4/mGyPfH4fMM4EfBi1K5nL6efEZNzERKxsnnLifdqKqdJWVrQillzrEXwxKiQe
         rOMw==
X-Gm-Message-State: AOJu0Yzz6XU1BycqkaSOk6on99GV2UNEie7fMsQizplb61NPlWE48ufr
	R9YPW/9phN7/JyRSPAGMj64WQnoie6HqSkbB1z1Vh0v6EW6ojEWs6Yzvk5awKKoNK+I2fw1JZPr
	RTI4WUusrNOoXODYA5vNQPv9urz5qEQF+Fg==
X-Received: by 2002:a17:903:41d0:b0:1cc:5833:cf57 with SMTP id u16-20020a17090341d000b001cc5833cf57mr996860ple.45.1699922610816;
        Mon, 13 Nov 2023 16:43:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH05wu8KE2KmQ14qcwQqsgAoeC96+a9B9oZ0tecwSgGtPp1Zyrf7O4a3ulZhJfDW2bMdtLeTw==
X-Received: by 2002:a17:903:41d0:b0:1cc:5833:cf57 with SMTP id u16-20020a17090341d000b001cc5833cf57mr996848ple.45.1699922610485;
        Mon, 13 Nov 2023 16:43:30 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902900600b001c736746d33sm4588937plp.217.2023.11.13.16.43.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 16:43:30 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id BF49A5FFF6; Mon, 13 Nov 2023 16:43:29 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B5A679F88E;
	Mon, 13 Nov 2023 16:43:29 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Eric Dumazet <edumazet@google.com>,
    "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
In-reply-to: <ZU8ghyf+tAUnk7gI@Laptop-X1>
References: <20231109180102.4085183-1-edumazet@google.com> <ZU2nBgeOAZVs4KKJ@Laptop-X1> <84246.1699607962@vermin> <ZU8ghyf+tAUnk7gI@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Sat, 11 Nov 2023 14:34:47 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10373.1699922609.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2023 16:43:29 -0800
Message-ID: <10374.1699922609@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Fri, Nov 10, 2023 at 11:19:22AM +0200, Jay Vosburgh wrote:
>> >Do we need also do this if the bond changed to ether device from other=
 dev
>> >type? e.g.
>> >
>> >    if (slave_dev->type !=3D ARPHRD_ETHER)
>> >            bond_setup_by_slave(bond_dev, slave_dev);
>> >    else
>> >            bond_ether_setup(bond_dev);
>> =

>> 	I'm not sure I follow your comment; bond_enslave() already has
>> the above logic.  If the bond is not ARPHRD_ETHER and an ARPHRD_ETHER
>> device is added to the bond, the above will take the bond_ether_setup()
>> path, which will call ether_setup() which will set the device to
>> ARPHRD_ETHER.
>> =

>> 	However, my recollection is that the bond device itself should
>> be unregistered if the last interface of a non-ARPHRD_ETHER bond is
>> removed.  This dates back to d90a162a4ee2 ("net/bonding: Destroy bondin=
g
>> master when last slave is gone"), but I don't know if the logic still
>> works correctly (I've not heard much about IPoIB with bonding in a
>> while).  The bond cannot be initially created as non-ARPHRD_ETHER; the
>> type changes when the first such interface is added to the bond.
>
>Ah, thanks for this info. I just tried and it still works. Which looks
>there is no need to close bond dev before bond_ether_setup().
>
>BTW, I tried to set gre0's master to bond0 and change the types. After th=
at,
>`ip link del gre0` will return 0 but gre0 is actually not deleted. I have=
 to
>remove the gre mode to delete the link. Is that expected?

	I don't think that's expected; I'd expect "ip link del" to
delete the interface after removing it from the bond (via the
NETDEV_UNREGISTER case in bond_slave_netdev_event).

	-J

>```
># ip link add bond0 type bond mode 1 miimon 100
># ip link add gre0 type gre
># ip link set gre0 master bond0
># ip link show bond0
>21: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mo=
de DEFAULT group default qlen 1000
>    link/gre 0.0.0.0 brd 0.0.0.0
># ip link del gre0
># echo $?
>0
># ip link show gre0
>18: gre0@NONE: <NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bo=
nd0 state UNKNOWN mode DEFAULT group default qlen 1000
>    link/gre 0.0.0.0 brd 0.0.0.0

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

