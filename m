Return-Path: <netdev+bounces-37284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F37B485F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4ADC828227A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30BE182B5;
	Sun,  1 Oct 2023 15:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608FFC06
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:19:29 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47704EE
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 08:19:28 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49d39f07066so295620e0c.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696173567; x=1696778367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdQzRFnPM+ymAydUo9XAgGZeIYCPjHlHL98l6eXo/Fs=;
        b=zyRReANo/7oJRp6rQVMhH5D/stksydc+NONmpFhc3lOLFBmcWv0LCivPikyNeCFslx
         iwKKzCN+G1rTeYhuOaESKSuxNEiFDvsIUS5U+JneL9+YB408QUNLwVA8nPxNckL9fnT1
         BUnFI++wSsOLhu0S4c6E83UkZcvtigvJTwYIzs0G4+UMVStVx4e2PdGSSEHXneU49fe9
         KUH+ShbBm9YGjrzKFV/mgXBQ4fi46svJoEW0MQ6QRSPakLctEegdyLmQmPy/ctJ1S2vz
         xZX48Mjj+ouFPca7Nk5PFNGHj1rjqptBHgM1vr6chju1pNqj86oQhXvk+0QS8J4KGM79
         rfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696173567; x=1696778367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdQzRFnPM+ymAydUo9XAgGZeIYCPjHlHL98l6eXo/Fs=;
        b=fqVkhAhztelSS57G6Mww0y7zylnHuxdwD4+FFn1rgbDme2Ct+ETzuxZn5fGPl/Ll8a
         iaraWnL2LWyIhgtKgEsmGYbF6rBsk0dUMfXSmYAiDgAmQ6YcMa9Sln6FUGIhs2v6biFg
         9q5rKUN6L99YfzEhWtvHBSgl++67JfKiA2zQlLa0y4l4vvVAZEqomybFqNWIlL0EccI5
         NN2zjvO9LOH1KbGY6BPiQvSaQljd47eaP9BVRNRUWhcTepRw7NncY26VJoAfN1BghSB8
         M8VjmEObm4cdBvTQSmxl/sosmBVDaNKRZiA+rBW6tKqPFdYGGNan0HuwKaOPMKCE2NuK
         ROFA==
X-Gm-Message-State: AOJu0Yyv8D2N1RyR2pfi8kYCG2PlOxjPj03XiJgSxP2BerWBCf4LwFK3
	l2Axr3k7Z37GZEGLTGBioTGpH72Ule/TVxAv0BfEyg==
X-Google-Smtp-Source: AGHT+IGRrOujYqhzALfgMmregRD2vhyXqGo3rugpFsivQkfPgM4SDn0FQBSx9P6MaZHMEBR7Q47g+edw+eg62JJcP/k=
X-Received: by 2002:a05:6122:4113:b0:49d:10ce:9a8b with SMTP id
 ce19-20020a056122411300b0049d10ce9a8bmr6846706vkb.15.1696173567162; Sun, 01
 Oct 2023 08:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
 <20230927151501.1549078-2-ncardwell.sw@gmail.com> <CAMaK5_gz=B5wJhaC5MtgwiQi9Tm8fkhLdiWQLz9DX+jf0S7P=Q@mail.gmail.com>
 <CADVnQymiStUHkzmrTrm_uzt1Cw-NgZ_4MuF5+BptArJfGRFQsA@mail.gmail.com> <CAMaK5_i-9dGgPtK9AErfjCaBVC72F=jzdQ968q9_TBLXoH3QBA@mail.gmail.com>
In-Reply-To: <CAMaK5_i-9dGgPtK9AErfjCaBVC72F=jzdQ968q9_TBLXoH3QBA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 1 Oct 2023 11:19:09 -0400
Message-ID: <CADVnQymo2h4dYqeZQm9y5qqHoD1qrht9adLeuakFXzcKV5hyFQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: fix delayed ACKs for MSS boundary condition
To: Xin Guo <guoxin0309@gmail.com>
Cc: Neal Cardwell <ncardwell.sw@gmail.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 11:56=E2=80=AFAM Xin Guo <guoxin0309@gmail.com> wro=
te:
>
> Neal,
> thanks for your explanation,
> 1)when I read the patch, i cannot understood "if an app reads  >1*MSS dat=
a",
> because in my view that "the app reads" mean that the copied data
> length from sk_receive_queue to user-space buffer
> in function tcp_recvmsg_locked(as example) when an app reads data from a =
socket,
> but for "tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||"
> "tp->rcv_nxt - tp->rcv_wup" means that the received data length from
> last ack in the kernel for the sk,
> and not always the length of copied data to user-space buffer.
>
> 2) when we received two small packets(<1*MSS) in the kernel for the
> sk, the total length of the two packets may  > 1*MSS.

Thanks for clarifying. Those are good points; the commit message could
and should be more precise when describing the existing logic in
tcp_cleanup_rbuf(). I have posted a v2 series with a more precise
commit message:
  https://patchwork.kernel.org/project/netdevbpf/patch/20231001151239.18668=
45-2-ncardwell.sw@gmail.com/

best regards,
neal

