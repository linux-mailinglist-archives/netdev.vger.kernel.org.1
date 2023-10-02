Return-Path: <netdev+bounces-37312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190717B4B27
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2F75CB20897
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D52A41;
	Mon,  2 Oct 2023 05:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61A388
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:34:08 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C411BD
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 22:34:06 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41954a3e282so51471961cf.2
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 22:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696224845; x=1696829645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mpd7C1usvsa85MDKv77ELi4n1g2XqSkXvjYAKLQnwqo=;
        b=WnbvWkOhuGpWR4VCiBrz32jnq8K7tUXL9Ptpe8cJIwsYIBZI7Fets/h1ZocLjKEWZg
         jQ9Dm8ttS6uiHnbLgGbdM5IJ/EASVo6EFuVhEZ2JCKZKclKkPgCrjziSWe45Ri5PD2mf
         Qij/5XZkSV0gNiOj1j0EKOR3yx77YxObYMkXQyhpu9phtI60F6AtlHEpBQwqA1RSaR8G
         T3GOF6cFDKthSkvKMYFdFsa2uDiW38y+oBclpmeu10LyzjECGe2q8+fgRKsnyMZR9Lca
         ku/wBYwKSMMV3oKP00X/0TOaReJDP7Vj+5CiR1mkjdu8WDQqH3or9eC49l2Y2sfWqJNz
         I/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696224845; x=1696829645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpd7C1usvsa85MDKv77ELi4n1g2XqSkXvjYAKLQnwqo=;
        b=pqpdUImwl8upAmn5lF8DZs/jdOSxZagrVYDwXUAriftiLzz7BU+kVnws/0M4tJ7vBi
         88jJygrjWewec7GYYTIsszQ0lD1h1dC2CdSfzaBo9kjeXYFn3vLhhNeVjaYtAqJD1uAs
         d1h6uFb/VAvXKp66Tw+xnQI83QVRTGdLD49+GUNTtJ1ZKqPUa53dtxiWQg7/07WciKk5
         J3oh9q/izV0ysv85sgNzXk/kfTGUYHQlpCOJ6XMmhJ6gf7LYgLWv+hbCGTUSx9HQKYg6
         vvt2dAxug7gv/qyGcdV6HZfvuy6S14Rd7VmszUTHqB+S61k8IGntyUvKMFE3toIn5c4v
         VRtw==
X-Gm-Message-State: AOJu0YyKUn0ReHVa9oMt3M2nIgb6f8MlGHaw5hKolUpcMbA6CGd5G5Cz
	Yfil0POWClI24z3izCop8vkfnWAUQBk43HhfTg==
X-Google-Smtp-Source: AGHT+IH5VL9AsI3K1Oi4uWM/GpqhHOLf0FlLP3EZtuK0x7LX+ypzJPiekTNPwRUI9OyUEqqtSLwtbB6VLKkZhAr8uHg=
X-Received: by 2002:a0c:cb86:0:b0:65b:1b3d:74b7 with SMTP id
 p6-20020a0ccb86000000b0065b1b3d74b7mr9079134qvk.0.1696224845292; Sun, 01 Oct
 2023 22:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
 <20230927151501.1549078-2-ncardwell.sw@gmail.com> <CAMaK5_gz=B5wJhaC5MtgwiQi9Tm8fkhLdiWQLz9DX+jf0S7P=Q@mail.gmail.com>
 <CADVnQymiStUHkzmrTrm_uzt1Cw-NgZ_4MuF5+BptArJfGRFQsA@mail.gmail.com>
 <CAMaK5_i-9dGgPtK9AErfjCaBVC72F=jzdQ968q9_TBLXoH3QBA@mail.gmail.com> <CADVnQymo2h4dYqeZQm9y5qqHoD1qrht9adLeuakFXzcKV5hyFQ@mail.gmail.com>
In-Reply-To: <CADVnQymo2h4dYqeZQm9y5qqHoD1qrht9adLeuakFXzcKV5hyFQ@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Mon, 2 Oct 2023 13:33:54 +0800
Message-ID: <CAMaK5_jxXu+no76U9ucUSdzN_qeNUFT2-n8GYoy=B3Yh9+ChmQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: fix delayed ACKs for MSS boundary condition
To: Neal Cardwell <ncardwell@google.com>
Cc: Neal Cardwell <ncardwell.sw@gmail.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks,
the commit message in the v2 is so good.

Regards
Guo Xin

Neal Cardwell <ncardwell@google.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=881=E6=
=97=A5=E5=91=A8=E6=97=A5 23:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 28, 2023 at 11:56=E2=80=AFAM Xin Guo <guoxin0309@gmail.com> w=
rote:
> >
> > Neal,
> > thanks for your explanation,
> > 1)when I read the patch, i cannot understood "if an app reads  >1*MSS d=
ata",
> > because in my view that "the app reads" mean that the copied data
> > length from sk_receive_queue to user-space buffer
> > in function tcp_recvmsg_locked(as example) when an app reads data from =
a socket,
> > but for "tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||"
> > "tp->rcv_nxt - tp->rcv_wup" means that the received data length from
> > last ack in the kernel for the sk,
> > and not always the length of copied data to user-space buffer.
> >
> > 2) when we received two small packets(<1*MSS) in the kernel for the
> > sk, the total length of the two packets may  > 1*MSS.
>
> Thanks for clarifying. Those are good points; the commit message could
> and should be more precise when describing the existing logic in
> tcp_cleanup_rbuf(). I have posted a v2 series with a more precise
> commit message:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20231001151239.186=
6845-2-ncardwell.sw@gmail.com/
>
> best regards,
> neal

