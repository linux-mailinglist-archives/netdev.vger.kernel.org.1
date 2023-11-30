Return-Path: <netdev+bounces-52445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944F7FEC03
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC981C209C0
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0420538FA4;
	Thu, 30 Nov 2023 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EboWee2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D8D40
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:39:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so8478a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701337149; x=1701941949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w0Xsdxg1xmtFzBpIVytZrwRsCdJaB2rhHg1ObCl0ac=;
        b=EboWee2QIgu+TNRwGRV1uzm7x8ddpkdlWN3dnuIxKzJynRdVoMtJdpUKZrqBGcXGoB
         ioSfR8vs5rG2yyVyTVjdzkQFLxyd/bx8Hm9IxBgqMf6cfsfJH2u88lDL8lt7WHqPqlyl
         z6fWuDTTrWDwl9AFimk6oHaiuSj3m7uQcx5u6bm2KDcnhMBnwzwCyBe6XnTsNGvfaiu3
         wrTwyBbsDBqsglVlQDp7stGGcaSkP4on3UqZOnfsydoHs4oz0eyjmvbNZuoP+awyFpyo
         5GSCPLPyyohrjmB9dG3WRzKRqbZkaVuYdq7R7IJq3VywG048YF/i0AC37i3K289sp1As
         MtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337149; x=1701941949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w0Xsdxg1xmtFzBpIVytZrwRsCdJaB2rhHg1ObCl0ac=;
        b=c4MAfty+14aOHqp4uSSZfqJXZLL66Jgen3P8tHnojlYhIo3ZCjIXzmPhB/brSzvolZ
         EcpfIjxKUvZTnCQdv1wBBE0MEzShdEmonXc6MlDR8PkhrV6+YtYjpWa2+9Xk5Fqa8ejI
         jznTgTxKBLLG8zDXpv6JWjFImXiGuzEweyCs/VPgv79jSKaUfP4sRMfkqjlhQnaj5pEx
         UCYQzeStQRQofiQ4wTYloaTUMIp75Vl1YpRJKtZwy5wDzahQ1yMrxJgneFkRHQiUAMkl
         okB8oVJDAQohIU9HwVcpRr+dKUANm4GNUIj7k4qVFJon8+Ls5Df/Bl/Te/vwyoKMRGTt
         k9NQ==
X-Gm-Message-State: AOJu0YyvsxJ5yDTY0y7G9TJ2lXuKN45s1jEa+gWfc5KnksgAn3BAtxBQ
	h+In2ePfnd7hrpkc5p9g29gbUHM8/VnARdXNLl2lTs8D0uJe2qNjNJzQ0g==
X-Google-Smtp-Source: AGHT+IH01CaFUo5z6hh/wFpSzJm4ZGqsz0fZRtVHaFB0ZsdcL1YwoDq/BZCXrmXYJW7dz2uCJh9PfLM0rycp3Xm/4k4=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr122702edb.2.1701337148606; Thu, 30 Nov
 2023 01:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
 <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com>
In-Reply-To: <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 10:38:57 +0100
Message-ID: <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com, davem@davemloft.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 30, 2023 at 9:42=E2=80=AFAM xingwei lee <xrivendell7@gmail.co=
m> wrote:
> >
> > Hello
> > I reproduced this bug with repro.txt and repro.c
> >
> >
>
>
> Is your syzbot instance ready to accept patches for testing ?
>
> Otherwise, a repro which happens to  work 'by luck' might not work for me=
.
>
> The bug here is a race condition with rds subsystem being dismantled
> at netns dismantle, the 'repro' could be anything really.

Can you test the following patch ?
Thanks.

diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa735b5915fc03e29cbb155b2aff2c..36d2871ac24f383e4e5d1af1168=
000f076011aae
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)

        if (likely(sk->sk_net_refcnt))
                put_net_track(sock_net(sk), &sk->ns_tracker);
-       else
-               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);

        sk_prot_free(sk->sk_prot_creator, sk);
 }
@@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
                use_call_rcu =3D true;
        }

+       if (unlikely(!sk->sk_net_refcnt))
+               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
+
        if (use_call_rcu)
                call_rcu(&sk->sk_rcu, __sk_destruct);
        else

