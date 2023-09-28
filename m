Return-Path: <netdev+bounces-36898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2C7B21D5
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BA11A2826DA
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD43D3A6;
	Thu, 28 Sep 2023 15:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8250347B8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:56:16 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B51136
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:56:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7741c2e76a3so729769885a.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695916574; x=1696521374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFapRqAg1f8NgLKNfj2bWGd1+aMxivOO14gUb4Z7Bbw=;
        b=mKsjKW4trrLq0DQwzi1EEW4btLVZ/5RMlXXdRXZOJ3VdM2wz6z156ZBKKIzYv+tc4I
         9E/PT7Ngi8ftelyfBxjMhip9ia5J62KMv8m5QBakY0Cp3SOW2iEkOYNV3adQ6E/7jbsX
         yNDDLMgIxiRyvDl6mSInvXSKS3m2/x1Q9eAR48XKPz4V/23iPjO9RKHp+hHxT5n3dJfI
         oHL0P4z3KTfEPmxCYkmORaVphCSyxuS2rUdfeAKuJeFd1oLJ9M5NyA1efkeoYdALYTSA
         S8wz7fEBG9/RpVIfUZ49iFSDf77kyc7qvttMSPLt+yIPt7FVgo4Hiu0oNbR+KT4C0uxx
         JSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695916574; x=1696521374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFapRqAg1f8NgLKNfj2bWGd1+aMxivOO14gUb4Z7Bbw=;
        b=ey4O7qSDOuDk4sZeJzb8lxVQXtFxfKu8dcW0iald5/jpA6ly3AkHXk/i5WlIQzspV5
         Kl0SqA1lXS3qYeX5wOmngy5Auq0lypULGsm42OJeaRJ1jFwEUiT+oga25209Hs5NaYyj
         nR/b7Kg+B/3TbI82jKK4fg2/gp3F6XqhiYUCLCJVsA55OFwjzWOIbXl+Yr3/8r+mG+dP
         vcqC2FoZlJvOitEaqhdLxCn5g+cqVqiWgMAXVUGG/v2bE5TKLW/rr5Gc8naUy9mhgltz
         tUgPMWLvVK//1M+hj4ORJWyA/Pv7LDN/FhJv9FkLuybT9imVi9hVrA3I/p0oQiTHrB6m
         tbog==
X-Gm-Message-State: AOJu0Yz50k2cOYHUABXc6fq4sHYY0JRQqhm8uOnUfHRkj3ZeVIqxX9hz
	AnjlaXA+wVfWVazYKfMyO4nNNuARNTpZsyygew==
X-Google-Smtp-Source: AGHT+IGdxH96K+Sy0misa1ZFIi/Hrit3HX6bQGNKALKlXOXA4UWempxBlh6+1UqwWEvc+uzInqgfqmJnMVHE6Fr+aXU=
X-Received: by 2002:a05:6214:4b08:b0:658:310c:f6ca with SMTP id
 pj8-20020a0562144b0800b00658310cf6camr1806975qvb.42.1695916573944; Thu, 28
 Sep 2023 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
 <20230927151501.1549078-2-ncardwell.sw@gmail.com> <CAMaK5_gz=B5wJhaC5MtgwiQi9Tm8fkhLdiWQLz9DX+jf0S7P=Q@mail.gmail.com>
 <CADVnQymiStUHkzmrTrm_uzt1Cw-NgZ_4MuF5+BptArJfGRFQsA@mail.gmail.com>
In-Reply-To: <CADVnQymiStUHkzmrTrm_uzt1Cw-NgZ_4MuF5+BptArJfGRFQsA@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Thu, 28 Sep 2023 23:56:04 +0800
Message-ID: <CAMaK5_i-9dGgPtK9AErfjCaBVC72F=jzdQ968q9_TBLXoH3QBA@mail.gmail.com>
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

Neal,
thanks for your explanation,
1)when I read the patch, i cannot understood "if an app reads  >1*MSS data"=
,
because in my view that "the app reads" mean that the copied data
length from sk_receive_queue to user-space buffer
in function tcp_recvmsg_locked(as example) when an app reads data from a so=
cket,
but for "tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||"
"tp->rcv_nxt - tp->rcv_wup" means that the received data length from
last ack in the kernel for the sk,
and not always the length of copied data to user-space buffer.

2) when we received two small packets(<1*MSS) in the kernel for the
sk, the total length of the two packets may  > 1*MSS.

Regards
Guo Xin

Neal Cardwell <ncardwell@google.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8828=E6=
=97=A5=E5=91=A8=E5=9B=9B 22:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 28, 2023, 4:53=E2=80=AFAM Xin Guo <guoxin0309@gmail.com> wrot=
e:
> >
> > Hi Neal:
> > Cannot understand "if an app reads > 1*MSS data" , " If an app reads <
> > 1*MSS data" and " if an app reads exactly 1*MSS of data" in the commit
> > message.
> > In my view, it should be like:"if an app reads and received data > 1*MS=
S",
> > " If an app reads and received data < 1*MSS" and " if an app reads and
> > received data exactly 1*MSS".
>
> AFAICT your suggestion for tweaking the commit message - "if an app
> reads and received" - would be redundant.  Our proposed phrase, "if an
> app reads", is sufficient, because a read of a certain amount of data
> automatically implies that the data has been received. That is, the
> "and received" part is implied already. After all, how would an app
> read data if it has not been received? :-)
>
> best regards,
> neal

