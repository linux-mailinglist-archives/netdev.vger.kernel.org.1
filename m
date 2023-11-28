Return-Path: <netdev+bounces-51725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CE7FBDEA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57701C20ED3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA655D49D;
	Tue, 28 Nov 2023 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hC7XMHaL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0110D4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:17:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so9952a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701184636; x=1701789436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khl+BpfAt/ZwtTxWTLQ7sDtW6X80kcISvSv01zeMuJU=;
        b=hC7XMHaLxS0S8b/Xshb/lxOGogz67d7YYNPEk8otPZk4NlfMsmGkWHU0QcIjdbKfsA
         TTV8R3vxfF9KY9BxQWR6kTAnMoVdhiaQ+8l0f4N3kKhXViZhfBBCTc83oz5nCHYXsHLm
         m6i6lkCzeN1n7YXUsE1UEgs7YghEz8lxse3/8ig0mo30d44RTu/EomUlzZxx9GYJSu1d
         Y5q3wBnmE2dXAt5f/gm5R2pQfjEE2JKwxYcdDUs1Audr+SygJYpuMsZFPY/K6IZT5Cf9
         /eEJJ6dXNwi5x+DcKSauUhgN2CcTX4fYYBEFUa4NavMAuQhbKDmPj6W995YKnM50cMpt
         G4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184636; x=1701789436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Khl+BpfAt/ZwtTxWTLQ7sDtW6X80kcISvSv01zeMuJU=;
        b=r6Q2CwGKdPUFUGlBB9tWrQus5fnsVFGlEZLKqG1eBxps+VhXr98u69UtpXzIm2WS4t
         mA7dfcsD/9uioP5po+tSgnD2gyfqYAZiaVUyeYc2a2EOSA5srDfIaJ8J3e0kk49NTNOO
         l2KsV5arwTAujgUNrAFHpYCwESsRVn1ZUYMz0MgwCw9/2X/gkqU96gHY8jnip38/fpDP
         zO8DLZnLU3CUu10NOkznOKOkW60RUWEfE85TanWnEK8jBgBZ+SREDuZ4oA0Tps9IPrzt
         lviF3lmwFg/i2AJbNpMLAjnvJ07W77s7vnlTc7kU8roNP5Sgj8yBrHsHUwcJ1Z5FsXUb
         TbTg==
X-Gm-Message-State: AOJu0Yw6ITrzguuEFQXnyXG27QIJYGu2/7WLxEBErgf+jBd5o22UPA41
	wvhGyw3imxjvNom99Xu7stWa+M+EPTCbcq+dEwwRCg==
X-Google-Smtp-Source: AGHT+IFsyf/r10ArlKHLRG2NPSnh+bG2ggaZj7L7UsQSp3hZ7AQ0YJEucsvAEXsuY6h7/c8hq/SiXFE2g61ipSJVdxw=
X-Received: by 2002:a05:6402:2215:b0:54b:81ba:93b2 with SMTP id
 cq21-20020a056402221500b0054b81ba93b2mr268021edb.2.1701184635726; Tue, 28 Nov
 2023 07:17:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-6-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:17:04 +0100
Message-ID: <CANn89iKpxMESKffzYuDwxdkrt2+LRLdbLTK+LVhVEZZLM1vRag@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/8] tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:19=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> When we create a full socket from SYN Cookie, we initialise
> tcp_sk(sk)->tsoffset redundantly in tcp_get_cookie_sock() as
> the field is inherited from tcp_rsk(req)->ts_off.
>
>   cookie_v[46]_check
>   |- treq->ts_off =3D 0
>   `- tcp_get_cookie_sock
>      |- tcp_v[46]_syn_recv_sock
>      |  `- tcp_create_openreq_child
>      |     `- newtp->tsoffset =3D treq->ts_off
>      `- tcp_sk(child)->tsoffset =3D tsoff
>
> Let's initialise tcp_rsk(req)->ts_off with the correct offset
> and remove the second initialisation of tcp_sk(sk)->tsoffset.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

