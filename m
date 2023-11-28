Return-Path: <netdev+bounces-51721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE97FBDB8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396E22828AA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DFF5CD09;
	Tue, 28 Nov 2023 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJaOZf5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D5D64
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:09:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9409a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701184162; x=1701788962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feGXB/rdpG9TDF6nNl8jQntxhUa7qIZYHR5IrUl/VUc=;
        b=mJaOZf5Yc26c08HymnIiiZey4VdV09L9d1LgKe4EEc8jlKmqwwacDgF6nfccX9+xEh
         WJCJmKLg1HnU5U+R+3xZ33CN//6z+poIFr6c8daQTXcQdjH+cdvZKzIWj2C+HlMEgQIl
         7+DcBYjvrQbYvdIgW91a4RJg0juf9qumnf5NiCXeMIOzQCtJjHk0Hl1gi3fea+E9SE4Q
         TKiG4I33RerJgbt+mLPj5VlOh7q6D9FwYfy75jzJeoEFqNYTwbiofGPVNF6wcYXt0RJx
         YGaXzweG+UsbkEzvB+kHbXllQr38DoYkOI+n+bYrHYYy66f15wKOayjMECWsaFn6s6EM
         Tpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184162; x=1701788962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feGXB/rdpG9TDF6nNl8jQntxhUa7qIZYHR5IrUl/VUc=;
        b=okBwKcfGue8lptNpCAZVzpvgsXyikcbKx3gicg3zQCJS3Uh0SD5y7Spr5bWKof5GAK
         HhHqRZgI4hmuDrH3D3Y8cvH8f0sq08gmhQ8CpSOv+yAsS7JdjtTx/za71/5yF866/wTL
         LQ1hOTxGK6YrYKk+NlyEeM3DBabsSbUiRhe15yoXwS5PZQ4kK/WSBPdGU/ymIrU2Oyhq
         sSPuwheM1Z8eq9E1Q5JYNapgj+AHulVPdsXrSBx55aXOpqZUB1AMMmqVsM/iZmoV79xB
         N1Sw4CtHnoul9ZzN94NX73e6BHET1nJwNDhmBlcbPwlcELonlnZ2X+cnZLjgec0GzxA7
         UnlA==
X-Gm-Message-State: AOJu0YxagS9oVPqjLANTlrzBtYF8LCuSI8cRawfoFUHPK8SWj2S3gX4Z
	nUfi/gyGufeXBnTgMcanipwWGfxtwRs12LERvHeUMQ==
X-Google-Smtp-Source: AGHT+IEnOBVrLQpLXtuvTXbsNy0Ta38lUsRvrZeJH8igXtbmpjO9sDxmbGEMP04yO2gSASOUBLEb8mS7gMlfble0VY8=
X-Received: by 2002:a05:6402:3510:b0:54b:2abd:ad70 with SMTP id
 b16-20020a056402351000b0054b2abdad70mr409711edd.7.1701184161821; Tue, 28 Nov
 2023 07:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-4-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:09:10 +0100
Message-ID: <CANn89iKE310bPya+40rapCzbmKei_3mEy3MS2y2aY0t=RowUVg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/8] tcp: Clean up goto labels in cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:18=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF, and then reqsk
> will be preallocated before cookie_v[46]_check().
>
> Depending on how validation fails, we send RST or just drop skb.
>
> To make the error handling easier, let's clean up goto labels.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

