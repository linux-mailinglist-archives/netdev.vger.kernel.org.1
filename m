Return-Path: <netdev+bounces-52463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E17FED11
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E731C20BE0
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687322320;
	Thu, 30 Nov 2023 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/s8yaEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E210D9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:40:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so9234a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701340855; x=1701945655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYo1naDqi++b6n6LsHhrzRbIWErfUo9pyW7yuNCRhTg=;
        b=Y/s8yaEtB3MqsgVDvBgY0xAYc2/RX7h/x8t00NfPr5Oo82mi0ChJRg7MDHTj2xfmkW
         +YktKC325BMqjdsLr+Awz6si+NZ52YIUu/F6bQqXTLV0dlAt2a1asnElPszbAqItuI4L
         baoFxeXyHkYAsJTcP4eBJz82dbqSeRWHSRdx31Syn7A+Oiccejh5JtxylWr2g4LqekmG
         qn+S5CVQrSSLvy1oOgL+tpSCobKY8avX3YAOyK+/SmBCfzrYZ50YeRlr8HKyoHFNAaj/
         4D6l2dYpCc2s15Geia6DIAZmuzatq46EzAkjw+anoifQ/r2zt/FMYLGkslZC8mFQrtRd
         U5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340855; x=1701945655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYo1naDqi++b6n6LsHhrzRbIWErfUo9pyW7yuNCRhTg=;
        b=PL90pYa7MlJp3iozqen1j1DTKKo/BmFZIB5UquS9UGORjTPj847kwUKaB+08nfX3ef
         NASjto4nt52ukErXXb9raG3AQG+hW6Je3ljpsa8DDHsdV9RdY/SCecT0m1Io12158Syx
         Pv7IYWmfPRL+YSPEoPdGhKujCakTSgwTDeWX7g1+gsX7KWIuQL1NwcFcob9EWItD8Wg1
         L1vH7IFmjr7UxjT3LSEQQKSle6kZONni0JgpRXXxxiipi4w0ROMe/wyKSkXrNyEozCaO
         MnZ52D8bbOfViF8pQ/bOozFl4uwpdwi8+KtO1JU+SoI6oDx1SkCP16R6/HT+3/LK7OuT
         EaxQ==
X-Gm-Message-State: AOJu0YyZovgFJaJ8/UBplKy0Wlf/Hx16S4YFnQc2mt/JmzMJFjZMvDpO
	yAg9CfehYvmQ5NIKqyKRQ2DEvCkf740BRJndNTqnmw==
X-Google-Smtp-Source: AGHT+IHoVd7LJS4wf4TaFFQAVTRoFHUpek7QWMtY08y4ZeZKy/5JZSMLwL+vevY+RnhT8OQoq2T0mSmBEOKFU0GGzcA=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr133739edb.2.1701340854923; Thu, 30 Nov
 2023 02:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-3-lixiaoyan@google.com>
In-Reply-To: <20231129072756.3684495-3-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 11:40:43 +0100
Message-ID: <CANn89iLDSUKBr_trZFgkFPfCGXvTRPcaaZvh0tZd=DE4RHJ9rA@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 2/5] cache: enforce cache groups
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:28=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> Set up build time warnings to safeguard against future header changes of
> organized structs.
>
> Warning includes:
>
> 1) whether all variables are still in the same cache group
> 2) whether all the cache groups have the sum of the members size (in the
>    maximum condition, including all members defined in configs)
>
> The __cache_group* variables are ignored in kernel-doc check in the
> various header files they appear in to enforce the cache groups.
>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> ---
>  include/linux/cache.h | 25 +++++++++++++++++++++++++
>  scripts/kernel-doc    |  5 +++++
>  2 files changed, 30 insertions(+)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

