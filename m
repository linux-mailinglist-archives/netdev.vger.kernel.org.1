Return-Path: <netdev+bounces-44082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63B7D604B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEB28103E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67D2D63B;
	Wed, 25 Oct 2023 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dchZFzro"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CA1360
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:12:53 +0000 (UTC)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9825131
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:12:50 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b6f67c708eso2114197241.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698203570; x=1698808370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9CeotXCt0ABHyMwdVVc/VsnlRNSOOXA3DuzMFPGzUE=;
        b=dchZFzroufeGBdHsCIUDvDWk+u+EEj1C+iJHKnFyFLBF7IDmSl8wsfLs2l99+PnGj9
         1YC0hFe/yK0cJqu3AuDX9OCH+lKWjAqUro3hBtPz8SK5B+XtRm8dxPyBi85kYQ7guRr5
         TdxFd4/5NINx9pJV8KJIASoYvLZ/vW72v6gFmeVB+rye9WBOUkpvs3pd0mqMHAyTsn4c
         InacMRpFzQ0sufN3QmmOvPIUtolnSSeG6BEzI+wVPmJA1YUd6COJTE9c1NZlXW1U2RKb
         AmSoBctOvo05XHdHoU65QgeXQ1isdIggo4gpWjh9gB1DTzVMPOuSIossB4vNg6QOCt09
         V6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698203570; x=1698808370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9CeotXCt0ABHyMwdVVc/VsnlRNSOOXA3DuzMFPGzUE=;
        b=JZ8+xGJOoc2afqWlKgUe/wX0xrlVteD+so7BojBcmg9FiwyacMw2+zLJ+kyJMCLbN6
         rX46AzlEpRwQPvyETFrvwWHiRBQLcsl7rRkAqWIGQkRNkAkplQHXTx9Yir7MnQU1GeGd
         vyM2Om4agqhRRFrXBdqaqvTx4C+RUKNG6uurFSlN+eT2cxXR7Gv8uBPghfL2rjjTmpkU
         DB3IwHmyG+9eXK91zzCwpLfy/tPWOVs7HPdv+IDv7CEptyYq+t4GsNsAxXs2ucdjtonX
         K7S5a6Q/xn9MQTi3wyLZhHDxjzuclBedeI9RNTrLBrIf8uXq1Pj4oOZ3ksMGAbWztT7A
         hAbQ==
X-Gm-Message-State: AOJu0Yy7fPtuOPwM7RTYzuFDqil7GV29PYU6RyG5qxbPcuasMFTIkbbw
	szPrg5jsRIMzizbEym0hZrs1mVcMAYV6LzhpKqcfEg+w2tE=
X-Google-Smtp-Source: AGHT+IEFLz4R3ZTBgbOdg46F9GaiAUGpJDiqaPhVlLtBG1DCx20/yNgrpL6te4UVBuwGNMRAsg9u3hRT4ewq0lrvE4Y=
X-Received: by 2002:a05:6122:3695:b0:49a:88a9:cac6 with SMTP id
 ec21-20020a056122369500b0049a88a9cac6mr13661740vkb.11.1698203569912; Tue, 24
 Oct 2023 20:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 24 Oct 2023 23:12:13 -0400
Message-ID: <CAF=yD-L8MobHEPvELTKkvpm4WAZAVPbJKqXnjnkaD7qr32NBEQ@mail.gmail.com>
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Willem de Bruijn <willemb@google.com>, 
	syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com, joonwpark81@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 3:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> LLC reads the mac header with eth_hdr without verifying that the skb
> has an Ethernet header.
>
> Syzbot was able to enter llc_rcv on a tun device. Tun can insert
> packets without mac len and with user configurable skb->protocol
> (passing a tun_pi header when not configuring IFF_NO_PI).
>
>     BUG: KMSAN: uninit-value in llc_station_ac_send_test_r net/llc/llc_st=
ation.c:81 [inline]
>     BUG: KMSAN: uninit-value in llc_station_rcv+0x6fb/0x1290 net/llc/llc_=
station.c:111
>     llc_station_ac_send_test_r net/llc/llc_station.c:81 [inline]
>     llc_station_rcv+0x6fb/0x1290 net/llc/llc_station.c:111
>     llc_rcv+0xc5d/0x14a0 net/llc/llc_input.c:218
>     __netif_receive_skb_one_core net/core/dev.c:5523 [inline]
>     __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
>     netif_receive_skb_internal net/core/dev.c:5723 [inline]
>     netif_receive_skb+0x58/0x660 net/core/dev.c:5782
>     tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
>     tun_get_user+0x54c5/0x69c0 drivers/net/tun.c:2002
>
> Add a mac_len test before all three eth_hdr(skb) calls under net/llc.
>
> There are further uses in include/net/llc_pdu.h. All these are
> protected by a test skb->protocol =3D=3D ETH_P_802_2. Which does not
> protect against this tun scenario.
>
> But the mac_len test added in this patch in llc_fixup_skb will
> indirectly protect those too. That is called from llc_rcv before any
> other LLC code.
>
> It is tempting to just add a blanket mac_len check in llc_rcv, but
> not sure whether that could break valid LLC paths that do not assume
> an Ethernet header. 802.2 LLC may be used on top of non-802.3
> protocols in principle.
>
> Reported-by: syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
> Signed-off-by: Willem de Bruijn <willemb@google.com>

I forgot to add:

Fixes: f83f1768f833 ("[LLC]: skb allocation size for responses")

Can respin if necessary.

At least one of the three eth_hdr uses goes back to before the start
of git history. But the one that syzbot exercises is introduced in
this commit.

That commit is old enough (2008), that effectively all stable kernels
should receive this. This commit also introduces llc_mac_header_len,
which shows at least one valid L2 header that is not an Ethernet
header, back in the day:

+#ifdef CONFIG_TR
+       case ARPHRD_IEEE802_TR:
+               return sizeof(struct trh_hdr);
+#endif

But that token ring variant was removed in 2012 in commit 211ed865108e
("net: delete all instances of special processing for token ring").

