Return-Path: <netdev+bounces-57892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB38146C6
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F242E280FE3
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E876D24A03;
	Fri, 15 Dec 2023 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="FSmmcIVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2A24B22
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so388776276.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1702639410; x=1703244210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NmhNyd1xj/HVPSRLTYbT9oQXg1j0xtH2WUO6Ft/wi5I=;
        b=FSmmcIVitzrnMPjVHngHgLaDGph996GZNazb8c2XntlCSlhW3ZQFg9/4Cwc3Irvwrd
         0qfhbys56PXb4SZRbhUtpk74nGwHSGvKdanp1Vg4YL4Hqtf/Iw9duSfsSu6JHDJm64U6
         Mmod38jr8en4U5FYhpFx+udGlGzPaZBCmGBS4PpEZH9Z8YVf06G66aeJN044arnKeJQq
         XVAHZJOyMrJDXd+83Dd5GW+HkVaFnqnzmWLjzoJ3y6WgRQsHItbbF8h2rR40gHbRqhBB
         i9jvRo5A1qzj+GF1r9VmnrjG4jdOM98ESBvzqzsXJeTM/rz2INI56UhdGsMbA+nJEG8M
         aVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639410; x=1703244210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmhNyd1xj/HVPSRLTYbT9oQXg1j0xtH2WUO6Ft/wi5I=;
        b=kmfVTMnnmLjpXfN0r5PPV9STI6ldDLLpZqFkVh2IlmlTxCDIIHgotUbiKKX5XS7SEQ
         FvxqT5hXb2GQ8e0h2BG7seIsAcLnWfGys/o/96gGzo3j/cFJN4vGAY45ADJ91qlmN/bO
         8Y1h7RXB/Udo77NowNkqPu6pUFZXn++LLYnRllnvobljSvqztJE1cJbYaPlqxcacdItJ
         ShS0WkSDr/JzXfZ/c/F2imso0Ba93fb1N6W/i5szIVYlgrMLRZMptQ3NWStLFAZpTXTR
         CXl9CPOUtEy+X2zbm6swYpA2BGM3FmVa4u5u4XsYZslMtbKAzQpykjs9VhDAFbZ8WmdJ
         RSLw==
X-Gm-Message-State: AOJu0Yx56Jei+ePJd6vD9sO9NIxC8B63ur++CgXPcjVJrt2QMlwAMiDB
	o+8NfJMZtxXQHQHyAzJ9S68iUJqY/BG68MqnFDXGA69pN3l/bucB
X-Google-Smtp-Source: AGHT+IFELbIKnl7b+tJIsCbAbSn87DriTOtlshil7B4O+a8uCbzQG0yJ9ek4X4N4Vc0uY+EQpAJI456U1IMrg2ketLo=
X-Received: by 2002:a25:2e4e:0:b0:dbc:e2a6:b0fc with SMTP id
 b14-20020a252e4e000000b00dbce2a6b0fcmr1680843ybn.44.1702639410731; Fri, 15
 Dec 2023 03:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPY8ntBEsfUhE7wHR7dOXh0=LiZkM0uBR9KxsmUspH2CAobtUg@mail.gmail.com>
 <8b4b8f65-b536-2036-f946-bae55a34bce4@broadcom.com>
In-Reply-To: <8b4b8f65-b536-2036-f946-bae55a34bce4@broadcom.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 15 Dec 2023 11:23:15 +0000
Message-ID: <CAPY8ntB-_m-JZqveVXaYkpQ6xrmHcWvE-zfysvNCNTKws7qFdg@mail.gmail.com>
Subject: Re: Jumbo frames on Broadcom Genet network hardware
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Florian

On Wed, 2 Aug 2023 at 00:27, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> Hi Dave,
>
> On 7/14/23 10:02, Dave Stevenson wrote:
> > Hi Doug, Florian, and everyone else.
> >
> > At Raspberry Pi we've had a few queries about enabling jumbo frames on
> > Pi4 (BCM2711), which uses the Genet network IP (V5).
>
> We have had quite a few inquiries through direct emails so there does
> appear to be interest in supporting Jumbo frames indeed.
>
> >
> > I've had a look through and can increase the buffer sizes
> > appropriately, but it seems that we get the notification of the packet
> > whenever the threshold defined in GENET_0_RBUF_PKT_RDY_THLD is hit.
> > The status block appears to be written at this point, so we end up
> > dropping the packet because the driver believes it is fragmented (SOP
> > but not EOP set [1]), and presumably any checksum offload is from that
> > point in the frame too.
> > Setting RBUF_PKT_RDY_THLD to 0xF0 (units of 16bytes) allows for 3840
> > byte buffers plus the 64byte status block, and that all seems to work.
> > (My hacking is available at [2])
> >
> > Is this the right way to support jumbo frames on genet, or is there a
> > better approach? It appears that you can configure the buffers to be
> > up to 16kB, but I don't see how that is useful if you can't get beyond
> > 3840 bytes sensibly before status blocks are written and the host CPU
> > notified.
>
> About 10 years ago is the last time I tried to implement Jumbo frames
> with GENET and at the time I only raised the Unimac maximum frame length
> register and would get an Ethernet frame that is fragmented with a
> SOF=1,EOF=0 initial buffer, multiple SOF=0,EOF=0 buffers, and a final
> SOF=0,EOF=1 buffer. This was the best I could achieve at the time.
>
> >
> > Others have reported that before the status blocks were always enabled
> > [3] then larger buffer sizes worked without changing the value in
> > PKT_RDY_THLD. I haven't managed to reproduce that. They were also
> > hacking global defines to allow selection of larger MTUs, so I
> > wouldn't like to say if they broke anything else in the process, and
> > it was also quite a long time ago (pre 5.6).
>
> Yes, I have seen those hacks, and they do not look too good. Let me dig
> up the little hardware documentation I have left and see whether we can
> come up with proper 9000 bytes Ethernet frames without too much hacking
> around.

A gentle ping - did you find anything?

Raspberry Pi and Broadcom obviously have a business relationship and
NDAs, so if documentation can be passed across for us to try and add
jumbo frame support, then that would reduce your work burden. I
appreciate that it has to go through the right channels though.

Thanks
  Dave

> >
> > Many thanks in advance.
> >    Dave
> >
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/broadcom/genet/bcmgenet.c#L2324
> > [2] https://github.com/6by9/linux/tree/rpi-6.4.y-genet/drivers/net/ethernet/broadcom/genet
> > [3] https://github.com/torvalds/linux/commit/9a9ba2a4aaaa4e75a5f118b8ab642a55c34f95cb
>
> --
> Florian
>

