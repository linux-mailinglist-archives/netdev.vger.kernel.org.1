Return-Path: <netdev+bounces-46082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453697E120E
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 03:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFBD1C208DF
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 02:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78196ECC;
	Sun,  5 Nov 2023 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="sWkyyBE/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31280EBE
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 02:48:11 +0000 (UTC)
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAC9C
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 19:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zae8Bgl4FNskvERkFBZCnhwW1xEBIYJ6jwBTUCWsVFY=; t=1699152489; x=1700016489; 
	b=sWkyyBE/goZOqG5WvxJfBs81BPZ/b+DK+zS1kLd/4SZP5hwHeWQ7zTu+D6VZOvu4RvIlQ1+PA/x
	uMErfhaV50z4eGqfFKNXGXuVp3vyZtxD+6ZgFOYueZF8K/B9aerhCwmyjHly5uL+YpQ/0f/r6GSBf
	Cd9urmykvD8OrlEquQkOC/1b9c7b0JlpgYbmDgftgGxPtO+PVOECFUVcwt+rZKTaKknRe7aGoGzGX
	WzsqdX2/Ly5iABEaQDrYcJ/Z1Np3pYg2Q/opiTeBSosyF5Tk/gA0qVN2w2tztL+4r7D2uNeunSJdI
	pd+9mPomRplVM/WWDH7Ry89SG8+lLZclI4pg==;
Received: from mail-oa1-f45.google.com ([209.85.160.45]:57650)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1qzTBI-0004QU-8P
	for netdev@vger.kernel.org; Sat, 04 Nov 2023 19:48:08 -0700
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so2108505fac.3
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 19:48:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywww4dRlDiT6QkUUbBjHDibWaGnUZ7XJ6NPmRENs+8ALND4jI78
	8HwK4misPeYRzBPec1jGUvvsB0j2YkkOwfDY95k=
X-Google-Smtp-Source: AGHT+IF83QTldxmOrQhHrI3pYn6hWGBeq+emJwGh1M+oAxDNTnuxdvg4vdYzQ1kl6fNSeR/9+f+uI2Ljw3rEhiBhkJM=
X-Received: by 2002:a05:6870:6c05:b0:1ef:c082:ecbe with SMTP id
 na5-20020a0568706c0500b001efc082ecbemr27178445oab.55.1699152487823; Sat, 04
 Nov 2023 19:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
In-Reply-To: <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sat, 4 Nov 2023 19:47:30 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
Message-ID: <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
Subject: Re: Bypass qdiscs?
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: bd70d0bdda1312c8b25f7b39d1e2fb7f

I haven't tried creating a "pass through" qdisc, but that seems like a
reasonable approach if (as it seems) there isn't something already
built-in that provides equivalent functionality.

-John-

P.S. If hardware starts supporting Homa, I hope that it will be
possible to move the entire transport to the NIC, so that applications
can bypass the kernel entirely, as with RDMA.

On Sat, Nov 4, 2023 at 8:08=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Nov 03, 2023 at 04:55:35PM -0700, John Ousterhout wrote:
> > Is there a way to mark an skb (or its socket) before invoking
> > ip_queue_xmit/ip6_xmit so that the packet will bypass the qdiscs and
> > be transmitted immediately? Is doing such a thing considered bad
> > practice?
> >
> > (Homa has its own packet scheduling mechanism so the qdiscs are just
> > getting in the way and adding delays)
>
> Hi John
>
> One thing to think about is what happens when hardware starts
> supporting Homa. Can the packet scheduling be moved into the hardware?
> Ideally you want to make use of the existing mechanisms to offload
> scheduling to the hardware, rather than add a Homa specific one.
>
> Did you try adding a Homa specific qdisc implementing the scheduling
> algorithm? Did it kill performance? We prefer to try to fix problems,
> rather than bypass them.
>
>        Andrew

