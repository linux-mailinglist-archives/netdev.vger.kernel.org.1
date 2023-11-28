Return-Path: <netdev+bounces-51728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524C7FBE0B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6682B1C20ABF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E15D4A5;
	Tue, 28 Nov 2023 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lH6F9oKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76E10CA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:23:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9751a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701185005; x=1701789805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oPTybAeIMFg/XSgGZqap2vk9iDiBl6Ymx6OnapGheM=;
        b=lH6F9oKGMAwQ4UrkK6xgVxQB3bhJvZkfCdaURUYhWQ4eyRdULCpy/k5iOGLX3JrGCn
         vwOIPZWle0P3MMbXD6PirXh/1jbR36tl70eagukpujyCUwR4GWekMe16BoP/9814XCGR
         sLbS/7tbLs3qbK3yv5oiSiUopj8u8toAmfa/Tm5HHTe91r1jirv/BMz5CxPwvtICBYjO
         zrQQUEInl8tor462aj1dDNpg0oSSW6Lh/FAvSa6VS1ZE0jdct2+sBWBAKXsmoYBHAeGb
         5MXbTeJhbXwTiFxmluddhIywamFYlNFZci2tmSDrvA3OUuOVkrja+gfFIydQgwE/NtWC
         CY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701185005; x=1701789805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oPTybAeIMFg/XSgGZqap2vk9iDiBl6Ymx6OnapGheM=;
        b=P0YbqRmP1xUOOWZi8Lt6m44CWbkF2xvmT1T5eghzw8k6HsrYYbCMFrAFm0arC7qa1s
         LDnuLFYeZXxyE3VvfFHi5OcsPeEUnn3WVppFOHRw8KaWQg4D53tgsGDlZdx1OfZxE3Wt
         h9ZeXUWqqw29BLn6WCn/qq8frDwpFAu+g0hqQmSJOHEzo55nHNoDYUk/JslfKAVaxrpt
         yAW22Hh5aT8/4IMNtM2v3nJaA1LQ4hq8Cqdu3TcNwUs7FvB1IUx9t74WQwNm35vY5ZqI
         y1F3u8/zXiP+Lvnz67irNa6G0aCBhKNLOgTW2Cbj3TH1ntLtQm6AfxGgtlILLrGs5FPy
         Aj9g==
X-Gm-Message-State: AOJu0Yy69DN4gCXEuj9TKZBXMu5+ehQTOE5NQ8/a8+wtc3TyCupL5Ur4
	3YUHhCym0O0s7Z0Q2TRweMW+WoSjq2dyMn2Tb/xmLw==
X-Google-Smtp-Source: AGHT+IFN/S0erXF8DVHfexMBKyw6wucpfd0HRCfa+CDNyof6UXrdnM8dRi15j229CFPyYQQAlxXJe5ihxtFvMMAk8VY=
X-Received: by 2002:a05:6402:88d:b0:54b:221d:ee1c with SMTP id
 e13-20020a056402088d00b0054b221dee1cmr436161edy.5.1701185005325; Tue, 28 Nov
 2023 07:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-8-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:23:14 +0100
Message-ID: <CANn89iJeJj4WrMY-FxGn2RU7z9Pfg4=ZhPXPSpHNbiV+Siv5Dg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/8] tcp: Factorise cookie-independent fields
 initialisation in cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF, and then some reqsk fields
> are initialised in kfunc, and others are done in cookie_v[46]_check().
>
> This patch factorises the common part as cookie_tcp_reqsk_init() and
> calls it in cookie_tcp_reqsk_alloc() to minimise the discrepancy between
> cookie_v[46]_check().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

