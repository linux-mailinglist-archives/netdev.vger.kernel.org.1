Return-Path: <netdev+bounces-55552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1AD80B3DF
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F84FB20A99
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6013ADE;
	Sat,  9 Dec 2023 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApGBqD90"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0010E0
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 03:03:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so20155e9.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 03:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702119819; x=1702724619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI6xmx95agIR2TNeVHdA7LNV7ZwckJuCguJdbZbP9lc=;
        b=ApGBqD90wH7R16aLVblV8x+8edLzMKLBOojQ0HAmFtPOzcRWXp3jRH6GvESaNy1E2l
         4lbGs58b7+OPuRZEShypax3Rvkn2QIATvuw3yRY1e96+wgAYyMC9zFY5ov0aPiAfVZxz
         fDg9NjRQi4mG9QyP7H+bJpPcqguLSrgebpDW4na1aqfQ0VqAsJNssJst+Guby0SfJ1bM
         ibb671oYyKAgHVOvU5yygJy5EKB9aic4VYeaCdzKi9/KLrw2C5QiVnESHthsLhYTva0H
         m0j9/16OIir3HLPs4SIDTgSSR7YVkdLY+5Pr+8brq7FdV5mA7KaJwy1bEbZZuPTBC2Vl
         m/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119819; x=1702724619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI6xmx95agIR2TNeVHdA7LNV7ZwckJuCguJdbZbP9lc=;
        b=l4q5lBHFIw8TckcwO+W6gzFzdy0lI94207YizsmKDg7G6FOB6SXbS6238MOJSV7mb7
         VHxUTeZXHUHBw5+qIbmfymUhFGNaKY4tkpA7whpM8C/+9lISUqJudy50kPQDZmdpvdYR
         xGmomX1JO7aP+O1qBcX7uqSJ7g5iRKy6d97KjUfXyHt5vL4ddxNrdtYBF2h5tyO/b3wK
         zQlE7KSfPcl43M+Kyy/IWL51qMq2tKcipYwhi4kc5vjXRW7U40oIchtDkhAOTC4lvCgB
         CdLUkq+t3TTPjFTZHM8qaJVKm1wV1K/vrG2XjcQIveBFNAjQ0Nbtjovg5nYDVVNlDFW4
         kY4Q==
X-Gm-Message-State: AOJu0Yw987GGJElId7qMt5wEwRAaqd8NOjul+Xnr37DzmmVB14sje1D2
	+DliT4NFJSR4uatuNhe+MH1HR3KlJfeZvGSzmoUqnA==
X-Google-Smtp-Source: AGHT+IF+yEW6SmM51p0Q2+P3Tb1NdPqtpvvdtQwM30w+bdl8MkJkX2SdlEiWzaRVnf9pIEZBDpuEsHP67vv7B25i4rc=
X-Received: by 2002:a05:600c:2804:b0:40b:2ec6:2a87 with SMTP id
 m4-20020a05600c280400b0040b2ec62a87mr125095wmb.5.1702119819398; Sat, 09 Dec
 2023 03:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208182049.33775-1-dipiets@amazon.com>
In-Reply-To: <20231208182049.33775-1-dipiets@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 Dec 2023 12:03:25 +0100
Message-ID: <CANn89i+BNkkg1nauBiKH-CfjFHOaR_56Fq6d1PiQ1TSXdFUCAw@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, blakgeof@amazon.com, 
	alisaidi@amazon.com, benh@amazon.com, dipietro.salvatore@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 7:23=E2=80=AFPM Salvatore Dipietro <dipiets@amazon.c=
om> wrote:
>
> Based on the tcp man page, if TCP_NODELAY is set, it disables Nagle's alg=
orithm
> and packets are sent as soon as possible. However in the `tcp_push` funct=
ion
> where autocorking is evaluated the `nonagle` value set by TCP_NODELAY is =
not
> considered which can trigger unexpected corking of packets and induce del=
ays.
>
> For example, if two packets are generated as part of a server's reply, if=
 the
> first one is not transmitted on the wire quickly enough, the second packe=
t can
> trigger the autocorking in `tcp_push` and be delayed instead of sent as s=
oon as
> possible. It will either wait for additional packets to be coalesced or a=
n ACK
> from the client before transmitting the corked packet. This can interact =
badly
> if the receiver has tcp delayed acks enabled, introducing 40ms extra dela=
y in
> completion times. It is not always possible to control who has delayed ac=
ks
> set, but it is possible to adjust when and how autocorking is triggered.
> Patch prevents autocorking if the TCP_NODELAY flag is set on the socket.
>
> Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04=
 and
> Apache Tomcat 9.0.83 running the basic servlet below:
>
> import java.io.IOException;
> import java.io.OutputStreamWriter;
> import java.io.PrintWriter;
> import javax.servlet.ServletException;
> import javax.servlet.http.HttpServlet;
> import javax.servlet.http.HttpServletRequest;
> import javax.servlet.http.HttpServletResponse;
>
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> ---

Very nice catch.

I suggest this patch lands in net tree, what about we add a Fixes: tag ?

Fixes: f54b311142a9 ("tcp: auto corking")
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

