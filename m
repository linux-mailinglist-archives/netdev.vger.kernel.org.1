Return-Path: <netdev+bounces-46845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62E7E6A70
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCC31C208EA
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D91DA2F;
	Thu,  9 Nov 2023 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq1hqnZb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0728F2
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:20:38 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E7270C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:20:38 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66fbcaf03c6so5062586d6.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699532437; x=1700137237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYCupUsz0OFmITZmI4iB771dn7Xgq+QS5truD0Mrxx8=;
        b=iq1hqnZbh4rkqipbMJ4rFxT/9nBU9TAxT++ESM3Rqp4BQMH2zdjFi150zgZLFtNhhI
         m6JQx8hG1KcpGoUSj6d4/cXfQ+kYx7SaXlhbmbmhdo7uhBjIBj639BYEmDUcUKzcM1fR
         FyPWA3A7bLOrOQsZe9MAEe6kALKXxbv2QUDMLR7IpTfwNwQWrwbcUv0efCzGN7kdbtgc
         1zavg9in7THb57nD0HPfzehLip1u8vp6THBUy+JJpNKe6V1+gUEzXvT5Y2N0eP9ita96
         BvaWXVrJumt8PY+a7jIR1dm9XC+jLKgiuFELTRDZId8VKdLuGsdPiN18xlO9NSgZT2ha
         hj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532437; x=1700137237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYCupUsz0OFmITZmI4iB771dn7Xgq+QS5truD0Mrxx8=;
        b=cUxw1p9kGtLpbTUobanLe57PEsenbDwHP2iE6RUxKxrcvOoHV1mh/lAdMUBErzfPN9
         9g64Hl3OBG+JJ7PIGnJQt1fKFlSAP+QZ4iqtn8KvfoysQIAVqfa35FqfEakNxFxz8SZq
         cVzWm3jJI0i0yimLlo7bCutL2nntxlOfAOfQDsLm+pkS3r8LMFK8OzMwhzqhvoi72/iJ
         lOMaR+Ho5caqReQIPA/jdli3Mdlktu4REBFQHVONCeEOe1GkpD9ug6tfvIeVa7Pakg0d
         KBtkmev/88RPdUXAxbyOAIgftwyJ0UpWijIScxTUtEAl59v09dlZ8Six2c/z8YfsQ6qN
         kNhg==
X-Gm-Message-State: AOJu0Yx0qVl/UcXstq1HyPwuNpIKqQtyXsgFcc1QLLBExHqSicAHMLKC
	qWZE9UstbARheBaJKCIb+/85cMfdsI1fzcGy5DLL/XOmj2s=
X-Google-Smtp-Source: AGHT+IGJuSwgtYfel8FcgZHF9EV8UBBK6Q+5nORMFmh8xhrJW0YyjBaNxZZcHy5oQlLnuR0Mub/+cICRbxHFKnsssMQ=
X-Received: by 2002:a05:6214:124b:b0:66d:35b8:e661 with SMTP id
 r11-20020a056214124b00b0066d35b8e661mr5111834qvv.45.1699532437060; Thu, 09
 Nov 2023 04:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75E355CF-3621-40D7-A31C-BA829804DFA2@meinberg.de>
 <6ab3289a-2ede-41a3-8c57-b01df37bab7f@lunn.ch> <DB0904D7-4F30-4A61-A4CB-48C7BFF4390F@meinberg.de>
In-Reply-To: <DB0904D7-4F30-4A61-A4CB-48C7BFF4390F@meinberg.de>
From: Kristian Myrland Overskeid <koverskeid@gmail.com>
Date: Thu, 9 Nov 2023 13:20:26 +0100
Message-ID: <CAGL4nSN0ZLHjARRRvS8Df8gLQLUb0ddiSJ5UfjNte0oX83VTOg@mail.gmail.com>
Subject: Re: PRP with VLAN support - or how to contribute to a Linux network driver
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

If you simply remove the line "dev->features |=
NETIF_F_VLAN_CHALLENGED;" in hsr_device.c, the hsr-module is handling
vlan frames without any further modifications. Unless you need to send
vlan tagged supervision frames, I'm pretty sure the current
implementation works just as fine with vlan as without.

However, in my opinion, the discard-algorithm
(hsr_register_frame_out() in hsr_framereg.c) is not made for switched
networks. The problem with the current implementation is that it does
not account for frames arriving in a different order than it was sent
from a host. It simply checks if the sequence number of an arriving
frame is higher than the previous one. If the network has some sort of
priority, it must be expected that frames will arrive out of order
when the network load is big enough for the switches to start
prioritizing.

My solution was to add a linked list to the node struct, one for each
registered vlan id. It contains the vlan id, last sequence number and
time. On reception of a vlan frame to the HSR_PT_MASTER, it retrieves
the "node_seq_out" and "node_time_out" based on the vlan.

This works fine for me because all the prp nodes are connected to
trunk ports and the switches are prioritizing frames based on the vlan
tag.

If a prp node is connected to an access port, but the network is using
vlan priority, all sequence numbers and timestamps with the
corresponding vlan id must be kept in a hashed list. The list must be
regularly checked to remove elements before new frames with a wrapped
around sequence number can arrive.

ZHAW School of Engineering has made a prp program for both linux user
and kernel space with such a discard algorithm. The program does not
compile without some modifications, but the discard algorithm works
fine. The program is open source and can be found at
https://github.com/ZHAW-InES-Team/sw_stack_prp1.


tor. 9. nov. 2023 kl. 09:08 skrev Heiko Gerstung <heiko.gerstung@meinberg.de>:
>
> Am 08.11.23, 16:17 schrieb "Andrew Lunn" <andrew@lunn.ch <mailto:andrew@lunn.ch>>:
>
>
> >> I would like to discuss if it makes sense to remove the PRP
> >> functionality from the HSR driver (which is based on the bridge
> >> kernel module AFAICS) and instead implement PRP as a separate module
> >> (based on the Bonding driver, which would make more sense for PRP).
>
>
> > Seems like nobody replied. I don't know PRP or HSR, so i can only make
> > general remarks.
>
> Thank you for responding!
>
> > The general policy is that we don't rip something out and replace it
> > with new code. We try to improve what already exists to meet the
> > demands. This is partially because of backwards compatibility. There
> > could be users using the code as is. You cannot break that. Can you
> > step by step modify the current code to make use of bonding, and in
> > the process show you don't break the current use cases?
>
> Understood. I am not sure if we can change the hsr driver to gradually use a more bonding-like approach for prp and I believe this might not be required, as long as we can get VLAN support into it.
>
> > You also need to consider offloading to hardware. The bridge code has infrastructure
> > to offload. Does the bond driver? I've no idea about that.
>
> I do not know this either but would expect that the nature of bonding would not require offloading support (I do not see a potential for efficiency/performance improvements here, unlike HSR or PRP).
>
> >> Hoping for advise what the next steps could be. Happy to discuss
> >> this off-list as it may not be of interest for most people.
>
> > You probably want to get together with others who are interested in
> > PRP and HSR. linutronix, ti, microchip, etc.
>
> Yes, would love to do that and my hope was that I would find them here. I am not familiar with the "orphaned" status for a kernel module, but I would have expected that one of the mentioned parties interested in PRP/HSR would have adopted the module.
>
> > Andrew
>
> Again, thanks a lot for your comments and remarks, very useful.
>
> Heiko
>
>
>

