Return-Path: <netdev+bounces-49950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC57F40B5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD8E281782
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB32D628;
	Wed, 22 Nov 2023 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2m8lKoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19DBBC
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:58:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so11040a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700643484; x=1701248284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWlW3pKWnalA/G4vxRFyenzr1+YYZ2kx2gq6fht33Eo=;
        b=z2m8lKoB+/e7Zq8NLDASo3bWyiU8Scq1K4aJYe/D/j2FvwbIWouAtXl4PFOn9pWFIJ
         2414NukL6wLvMQbfsFT4CPkFZDjffI+Xw+/zy3WpanuCxFIW/XHpZOD68MiYlZnC5HZF
         eUFEiLeQeqINCws0TqqDRIpAism3q0Z75gdiIZwuUlMAwabzZNJu9Bg5258v/Q4BtBbT
         QARX/DVYbIyKA6HthzDN6lEECFO+h763gyAp9zORTruEQ5CEsqP6GUdM83vKwdX3G9YA
         gGesGQWdo7l8B0hpow/nOkA3sAgU5K8vzWps2sVOYEf5zKjwNcJc6nsF5sJLqo0ZrmnC
         9ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643484; x=1701248284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWlW3pKWnalA/G4vxRFyenzr1+YYZ2kx2gq6fht33Eo=;
        b=D5NEZJuhWZI3De/ElMAo4VxDbzso5YgY9jXT07nqGrn7QygRYiZAT8FM7ceDJNOo4/
         aarnWNqIF6g8ErC9k3j4Ypi381w69LW6J/Zb98f6uDrBeqMKR/L8pYGXL+iWPU/LUx+a
         qiFp9gzoSkLdzR3LzgvkIyiY0LktPyNmQPRbNYhg8r0kwVA0cO6a1mwfPU06HIpJWNtj
         +DzIMlW+1ok9AHyI0gPdaPOllbON2t/qRSuw4bf8lgmXvQGQY8N0EgPwIA5rkZ3BdyQL
         oYni/fWGFQDPdrEy+Av3OtJfXPrAAQRGIdvKBeSAJxtVIrDKiluP19rh8Jy7ym0aEhqn
         FCYw==
X-Gm-Message-State: AOJu0YzTKM837ZodB0EO32BYk2Ky6Ki9efmf7JEzQv8iq21Pa8rJ6bXY
	S75LMJzXYxXHZNmJ/1lmOxJNsRn3GRSx5Dyb3ot65A==
X-Google-Smtp-Source: AGHT+IG+hcfxEmVuJcrkrELdJE7TNPJWr2LVjwUb9MzCyyZ1Zqkw7WYNsJsgqbuwveQ1MsBIJjhRMxi/O6DL3qMal0E=
X-Received: by 2002:a05:6402:1cbc:b0:547:3f1:84e0 with SMTP id
 cz28-20020a0564021cbc00b0054703f184e0mr66912edb.7.1700643483299; Wed, 22 Nov
 2023 00:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-5-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-5-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 09:57:52 +0100
Message-ID: <CANn89iKGz4vLMOQJe6QctPs6Y83ddpS2MFBWLG_VOQHsfZ-uog@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/13] net: page_pool: stash the NAPI ID for
 easier access
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> To avoid any issues with race conditions on accessing napi
> and having to think about the lifetime of NAPI objects
> in netlink GET - stash the napi_id to which page pool
> was linked at creation time.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Interesting... I have a patch to speedup dev_get_by_napi_id(), I will
send it today.

Reviewed-by: Eric Dumazet <edumazet@google.com>

