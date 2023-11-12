Return-Path: <netdev+bounces-47255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E877E92CA
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 21:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3D41F20FA1
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D45182BD;
	Sun, 12 Nov 2023 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrzHfgSa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EB1A27D
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 20:52:22 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76510115
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 12:52:20 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6705379b835so24185856d6.1
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699822339; x=1700427139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0U+QD1/xQ/wSQmpciOUUclhyMvBgrvAzUxebWK9jgM=;
        b=WrzHfgSaHNf/YYrTThSDL+Elg3j02IA+5luZNP1Bem9EarUBR0YEuAPIMFgHFwZ/EX
         Mi+qPrWCD6iD3uPO/ZdxlxYEJmXjL/ABWLq06+e6Tx5BmgYzjyiKrKwx0wAyxc30LeBT
         Sr5MDplT0YK71hmBFU0ovCWJqbyLySi1tjbBk7HPOKK8xs3eVyMkTmQgqCfcxUxcdx5T
         +UcvdBT3lURLafzW/xMDOzkOrI8DLw/CRGTxjvYtqx1HBh/YWOklYionUylxCP2uJ8qk
         lXScgrpgo3gXUUchcxmLWnt1eewNMcozmWAEWVcSC9csfa8LrPKv1K8NnZ8oT8CnABsG
         SD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699822339; x=1700427139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0U+QD1/xQ/wSQmpciOUUclhyMvBgrvAzUxebWK9jgM=;
        b=DhoycEWCKXJFxanONyfJcUY/PguQQOXELTSaFsdb0LngndsN0SnwVMHDB1KCqcC2tb
         IIl/vrGG2jjM+BnxXVvJL2O8YBMn4OQp0EoIqmi3LiSKJePirqlaUyMlm3m8+RQc4Ubm
         36ez/pYPg0ESQc8l+/YwBG4KWSjDu2YuInSOpHP/3nVa7MiqAsZd6u4zZ2DKT+geHOE8
         q40NUcR+sQ9V44R6VZ8/gMIDsTtjEqbIxOVvxw6Nwj0Fd30Y44bPOPK5MshkmjDLup4m
         EmMQfl4empD1zkBvOVls4/q1xKvAjYfyvfSu9u/d9X0jQq2z5GC6D6ubpnQ98AWSwey+
         d0kA==
X-Gm-Message-State: AOJu0YzmzuXcPF4GsGucs5Dg1Ty5DUS5xCSJdg1mANyGewrjC3Ss99NG
	2L/4f0ZEfwDxD3UiR7nvwMmZphlKfZ3trnw0IdG+oPLHU0U=
X-Google-Smtp-Source: AGHT+IF1AThA82JBrZ2cJ5X0ObTwk5+Udu8CGt92hx+cSKWdrBenanRzErHBKAWA2vojPFK2a/UjJqlcr0wNmfw7W0Q=
X-Received: by 2002:a05:6214:324:b0:670:63cc:210c with SMTP id
 j4-20020a056214032400b0067063cc210cmr5119787qvu.39.1699822339429; Sun, 12 Nov
 2023 12:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75E355CF-3621-40D7-A31C-BA829804DFA2@meinberg.de>
 <6ab3289a-2ede-41a3-8c57-b01df37bab7f@lunn.ch> <DB0904D7-4F30-4A61-A4CB-48C7BFF4390F@meinberg.de>
 <CAGL4nSN0ZLHjARRRvS8Df8gLQLUb0ddiSJ5UfjNte0oX83VTOg@mail.gmail.com> <9AAC668A-22F2-4A91-84C9-93F0186344CC@meinberg.de>
In-Reply-To: <9AAC668A-22F2-4A91-84C9-93F0186344CC@meinberg.de>
From: Kristian Myrland Overskeid <koverskeid@gmail.com>
Date: Sun, 12 Nov 2023 21:52:07 +0100
Message-ID: <CAGL4nSOwAMW_yQ129J_jeukQffv=xQfhpA9mnKsmvJe+FvQa3w@mail.gmail.com>
Subject: Re: PRP with VLAN support - or how to contribute to a Linux network driver
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

> thanks a lot for your respsonse - we tried removing the NETIF_F_VLAN_CHAL=
LENGED flag and it did not work for us. We could set up a VLAN interface on=
 top of the PRP interface, but traffic did not get through. I will retest t=
his to make sure we did not overlook something.

It worked for me on Ubuntu 22.04.03 LTS, but I haven't tried it on
different distros. You can use tcpdump to check if the vlan frames
reach the prp interface. If not, it's probably a vlan configuration
issue.

One thing you should be aware of is that unless you're testing on the
vanilla kernel, you should compare the source code of the hsr module
with the vanilla kernels. For example, the hsr module on Ubuntu is far
behind the vanilla kernel and I needed to add changes manually to get
rid of some bugs(not related to vlan though). If you are using a
distro with an even more outdated hsr module, this could be the reason
why your tests are failing with the NETIF_F_VLAN_CHALLENGED flag
removed.

> If I understand correctly, this would make the discard process more robus=
t because in the access port scenario the frames can arrive in an even more=
 mixed up order or do you mean that the access port is removing the VLAN ta=
g and sends the frames untagged to the node?

I see that I could have explained myself better here. I meant that the
access port is removing the VLAN tag and sends the frames untagged to
the node. In this case you cannot differ between the different vlans,
which means that you have to keep track of all sequence numbers that
should be dropped to avoid that legit frames arriving in a different
order is dropped. I wrote that the vlan id must be stored, but this is
not necessary since the source nodes don't consider vlan ids when
setting the sequence number for the outgoing frames.

Kristian






fre. 10. nov. 2023 kl. 09:24 skrev Heiko Gerstung <heiko.gerstung@meinberg.=
de>:
>
>
>
> Am 09.11.23, 13:20 schrieb "Kristian Myrland Overskeid" <koverskeid@gmail=
.com <mailto:koverskeid@gmail.com>>:
>
>
> Hi Kristian,
>
> > If you simply remove the line "dev->features |=3D
> > NETIF_F_VLAN_CHALLENGED;" in hsr_device.c, the hsr-module is handling
> > vlan frames without any further modifications. Unless you need to send
> > vlan tagged supervision frames, I'm pretty sure the current
> > implementation works just as fine with vlan as without.
>
> thanks a lot for your respsonse - we tried removing the NETIF_F_VLAN_CHAL=
LENGED flag and it did not work for us. We could set up a VLAN interface on=
 top of the PRP interface, but traffic did not get through. I will retest t=
his to make sure we did not overlook something.
>
> > However, in my opinion, the discard-algorithm
> > (hsr_register_frame_out() in hsr_framereg.c) is not made for switched
> > networks. The problem with the current implementation is that it does
> > not account for frames arriving in a different order than it was sent
> > from a host. It simply checks if the sequence number of an arriving
> > frame is higher than the previous one. If the network has some sort of
> > priority, it must be expected that frames will arrive out of order
> > when the network load is big enough for the switches to start
> > prioritizing.
> >
> > My solution was to add a linked list to the node struct, one for each
> > registered vlan id. It contains the vlan id, last sequence number and
> > time. On reception of a vlan frame to the HSR_PT_MASTER, it retrieves
> > the "node_seq_out" and "node_time_out" based on the vlan.
>
> I agree that it would be necessary to handle frames arriving in a mixed u=
p order.
>
> > This works fine for me because all the prp nodes are connected to
> > trunk ports and the switches are prioritizing frames based on the vlan
> > tag.
>
> > If a prp node is connected to an access port, but the network is using
> > vlan priority, all sequence numbers and timestamps with the
> > corresponding vlan id must be kept in a hashed list. The list must be
> > regularly checked to remove elements before new frames with a wrapped
> > around sequence number can arrive.
>
> If I understand correctly, this would make the discard process more robus=
t because in the access port scenario the frames can arrive in an even more=
 mixed up order or do you mean that the access port is removing the VLAN ta=
g and sends the frames untagged to the node?
>
> > ZHAW School of Engineering has made a prp program for both linux user
> > and kernel space with such a discard algorithm. The program does not
> > compile without some modifications, but the discard algorithm works
> > fine. The program is open source and can be found at
> > https://github.com/ZHAW-InES-Team/sw_stack_prp1 <https://github.com/ZHA=
W-InES-Team/sw_stack_prp1>.
>
>
> I will reach out to ZHAW and check with them if they would be willing to =
implement their more robust discard mechanism into the hsr module. The gith=
ub repo has a note saying it moved to github.zhaw.ch which I cannot access =
as it requires credentials.
>
> Thanks again,
>
> =EF=BB=BFHeiko
>
>
>
>
>
> tor. 9. nov. 2023 kl. 09:08 skrev Heiko Gerstung <heiko.gerstung@meinberg=
.de <mailto:heiko.gerstung@meinberg.de>>:
> >
> > Am 08.11.23, 16:17 schrieb "Andrew Lunn" <andrew@lunn.ch <mailto:andrew=
@lunn.ch> <mailto:andrew@lunn.ch <mailto:andrew@lunn.ch>>>:
> >
> >
> > >> I would like to discuss if it makes sense to remove the PRP
> > >> functionality from the HSR driver (which is based on the bridge
> > >> kernel module AFAICS) and instead implement PRP as a separate module
> > >> (based on the Bonding driver, which would make more sense for PRP).
> >
> >
> > > Seems like nobody replied. I don't know PRP or HSR, so i can only mak=
e
> > > general remarks.
> >
> > Thank you for responding!
> >
> > > The general policy is that we don't rip something out and replace it
> > > with new code. We try to improve what already exists to meet the
> > > demands. This is partially because of backwards compatibility. There
> > > could be users using the code as is. You cannot break that. Can you
> > > step by step modify the current code to make use of bonding, and in
> > > the process show you don't break the current use cases?
> >
> > Understood. I am not sure if we can change the hsr driver to gradually =
use a more bonding-like approach for prp and I believe this might not be re=
quired, as long as we can get VLAN support into it.
> >
> > > You also need to consider offloading to hardware. The bridge code has=
 infrastructure
> > > to offload. Does the bond driver? I've no idea about that.
> >
> > I do not know this either but would expect that the nature of bonding w=
ould not require offloading support (I do not see a potential for efficienc=
y/performance improvements here, unlike HSR or PRP).
> >
> > >> Hoping for advise what the next steps could be. Happy to discuss
> > >> this off-list as it may not be of interest for most people.
> >
> > > You probably want to get together with others who are interested in
> > > PRP and HSR. linutronix, ti, microchip, etc.
> >
> > Yes, would love to do that and my hope was that I would find them here.=
 I am not familiar with the "orphaned" status for a kernel module, but I wo=
uld have expected that one of the mentioned parties interested in PRP/HSR w=
ould have adopted the module.
> >
> > > Andrew
> >
> > Again, thanks a lot for your comments and remarks, very useful.
> >
> > Heiko
> >
> >
> >
>
>
>
>
>

