Return-Path: <netdev+bounces-53627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35615803F52
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C40281210
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7553308C;
	Mon,  4 Dec 2023 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZH+6lPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B2D5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:31:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso2910a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701721891; x=1702326691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RWJXXEX+CUQpaAt6K+sI88L2c8E3808hAhVdEnZ7b0=;
        b=kZH+6lPzaC5MombuVZQliU6syl0ONE1jpadhBgpQ8P2mhtCTTab4rW7QEjW98HdSlM
         01hDd4HZ7dGQ4cxgPhVMcDrYsVx0kSV4ZSbaOvz5NqP4zwCrUSNC1GXqoGY5hP4UFBjY
         YZu86QEEtF6ysFVFCVgtcWlQ7JMQ/dFUFG4csOKA7W4FwtFM84Z5VypneTtsow0mBHsi
         PKYUDxUX3aMOGo6AZV5wTbZuYx3BjwWP9YHTrQYzrX8psWJvQq7qDROmVdHKdkBvrMvQ
         Qza9GNbOavEGCi5LeC0NFtvQJrQlX28+zP1zhsaqWy/b/2IPYSEUuqNN0MQBzqpJIujS
         Vs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721891; x=1702326691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RWJXXEX+CUQpaAt6K+sI88L2c8E3808hAhVdEnZ7b0=;
        b=aydx7ar1eBeklBwIKALU8cccUjwbjHVy81kaOy2LjPMDdfXIqcoElircgmyc0Zi2cq
         WmSC1X8FluRNjFIAL3OFjqR3+wHKxa4YvdSEKUiqpvaB/sEpcsi2jzC5VjwsQ9l8aKfy
         R0S6cVBSIxLFVNWeyMpi94VTZNpHy7nyKSPxezZ4TS6E9jVFATXnQGPxEfgVJeee+XdP
         8QWDVxIcFlSWZP+H54PzY5CCGvERMoN2kI8AECE1t1NiZx203f4RgUO1BZxqLLFmMHhS
         3Hklj1YhWLJlgOb9ne1wz1Ch3P9WKuerT6/mF4s5lEnXDP8VBh5PL1plLthvOp1Gazgn
         MlUA==
X-Gm-Message-State: AOJu0YzFPTxXMTGPjzazO5RR7NrbTNg5sSKjHwsKHhZ+sBUK1fIUl6eM
	6gfkUSAF0fQv+SJEHXm75UJvd47m/gutiXQbl/DpnA==
X-Google-Smtp-Source: AGHT+IG5SH1KUOzsBXW9cKCb9QZCRORLCTuiIUG+SIR9vvNDgtbjFsOtqMIrlRnsph66t67LU3z74toDA0YEfbkO9Yo=
X-Received: by 2002:a05:6402:35d3:b0:54c:9996:7833 with SMTP id
 z19-20020a05640235d300b0054c99967833mr159216edc.7.1701721890602; Mon, 04 Dec
 2023 12:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201232.520025-1-lixiaoyan@google.com> <20231204201232.520025-3-lixiaoyan@google.com>
In-Reply-To: <20231204201232.520025-3-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 21:31:19 +0100
Message-ID: <CANn89iKfwD_yaAWy7vww31f4dYu0FTgAN34ii=xPwzu6KL6y9g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/2] tcp: reorganize tcp_sock fast path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:12=E2=80=AFPM Coco Li <lixiaoyan@google.com> wrote=
:
>
> The variables are organized according in the following way:
>
> - TX read-mostly hotpath cache lines
> - TXRX read-mostly hotpath cache lines
> - RX read-mostly hotpath cache lines
> - TX read-write hotpath cache line
> - TXRX read-write hotpath cache line
> - RX read-write hotpath cache line
>
> Fastpath cachelines end after rcvq_space.
>
> Cache line boundaries are enforced only between read-mostly and
> read-write. That is, if read-mostly tx cachelines bleed into
> read-mostly txrx cachelines, we do not care. We care about the
> boundaries between read and write cachelines because we want
> to prevent false sharing.
>
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 8
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

