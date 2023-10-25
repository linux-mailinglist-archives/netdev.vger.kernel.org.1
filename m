Return-Path: <netdev+bounces-44100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65A7D622E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D9B20F61
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711A15AEE;
	Wed, 25 Oct 2023 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYvrc4vp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667C156F5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:12:35 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E4133
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:12:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso127785ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698217953; x=1698822753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwbGfylf8dqZZHtCf2e2D7FZ7upydRRgKUPRy5QiEuc=;
        b=RYvrc4vpAYfAWRjya4viKV5VoAkN7P4P/3Q8rVc2lKGBfmDHbEaDhf+1BeSuWIitUF
         06OwNQIAO9a8zGff3qg0rlJjLHIoddL2MxkY8Nm3WMyxPeoKzi7H2748C98VEPJYMgq/
         nVBgDb38f/nIkkwGPLHedfoq+FEe49bXgxiWmt8zgv2ImqM3zLFVTc8RmN1p/hbY7fF+
         19XEjlcvqaxEKX4SxYxAEeEVQD4IPOqHTd9rNl4wMegT69pjE25brfu3kv+xXJSInhUn
         JzGqcFAGeAlH1qM2MruXBvN4OHpiB+Py6z4T0CPl/RwwGrjgRU7YL4dd/1vdtC08bSTd
         DbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217953; x=1698822753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwbGfylf8dqZZHtCf2e2D7FZ7upydRRgKUPRy5QiEuc=;
        b=KHQ47J+XE5uuW8OdDO1Kn6BHzEBFEkSVy+6C3tAovINWsoU8HPRfpcXyM0RZGLWWXn
         d6l3PpvygsThi0WwsNmbdKlSy4AnaOr/zywmvNddIjCiPB5FaeRkl8x/jAZ1gTpXff+4
         b/MTzyAmNHMP+uWExvKsy7qWouV1qS0mxgbVPcw3NXTIl2xW10WCUPpJ8mbIAgK3H+hO
         isluQGQQa25l1Vn+uysq9W52t5uwe31PsX2vKSNb+TnNmY+Vfs4KUlc6hLCTzce5AqxW
         2FI8tI785iJ3BJEXEf8HUbURxP4sLQgKA4u2uRHPPfM7renZCHbgMKhaF+ph6vuVUYjq
         6Klg==
X-Gm-Message-State: AOJu0YwxANoWTcZ2GsxPyMyuOXYktKdNwgmiIo2W7utVU6etTaFke3cY
	QnRMXW6g51mPkO0jZNCaLjv6ctNArHBWSJilkfxZUw==
X-Google-Smtp-Source: AGHT+IHU1BXYoAQ/WKeStF7iKz6ollBNNgSRA5J4cOXGGIgOTujOOgOlVNvae2Wn5XL+9vVCiPLu89alCeafa3ZNc3k=
X-Received: by 2002:a17:902:cf0a:b0:1c4:1392:e4b5 with SMTP id
 i10-20020a170902cf0a00b001c41392e4b5mr83859plg.21.1698217952599; Wed, 25 Oct
 2023 00:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3+GHxahA@mail.gmail.com>
In-Reply-To: <CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3+GHxahA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 25 Oct 2023 09:12:20 +0200
Message-ID: <CANp29Y5duVTxPyB=O+nyi8r68iebvEQmcCGOapL5b8Qpym8keQ@mail.gmail.com>
Subject: Re: KASAN: slab-use-after-free Read in nfc_llcp_unregister_device
To: Abagail ren <renzezhongucas@gmail.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Please also note this report by syzbot:
https://syzkaller.appspot.com/bug?extid=3D81232c4a81a886e2b580

Its title is a bit different, but the stacktraces are the same. At the
bottom, you may also find KASAN crashes.

Judging by the "Discussions" block, there've been a couple of fix
attempts already, but they did not make it to the kernel.

--=20
Aleksandr

On Wed, Oct 25, 2023 at 9:03=E2=80=AFAM Abagail ren <renzezhongucas@gmail.c=
om> wrote:
>
> Good day, dear maintainers.
>
> Since the email system replied that it refused to accept the email becaus=
e the text contained HTML, I sent it to you again in the form of shared fil=
es.
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the probability of vulnerability discovery using our prototyp=
e system developed based on syzkaller and found a bug "' KASAN: slab-use-af=
ter-free Read in nfc_llcp_unregister_device." I'm still working on it to fi=
nd out its root cause and availability.
>
> The stack information: https://docs.google.com/document/d/1gdHebCRsvVsSPK=
filcoXVu3Pctvoj2FSZCACcVYZXns/edit?usp=3Dsharing
>
> Kernel Branch: 6.4.0-rc3
>
> Kernel Config: https://docs.google.com/document/d/1WIM0btqS2dex18HQYaL2xy=
oW6WdX2TsaNguTnWzHMps/edit?usp=3Dsharing
>
> Reproducer:  https://docs.google.com/document/d/1LrgGdOgZwO8wz0opusZ7flP9=
QSFZa32GdozvoxGysyY/edit?usp=3Dsharing
>
> Thank you!
>
> Best regards,
> Ren Zezhong
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3%2BGHxahA%40mail.gm=
ail.com.

