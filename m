Return-Path: <netdev+bounces-54075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD6805F1C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753C21C209C3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C736DCEA;
	Tue,  5 Dec 2023 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nkej/qX5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC53188
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 12:08:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so2335a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 12:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701806906; x=1702411706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSrsxMtqGFne/rd9wakrOSxYSu6JhQYC9mQGxjxNaLs=;
        b=Nkej/qX5KPlULdY17d8saOt9nG58vBfKivU5+ekIFTPEr6Mr82mUOjFL9a0FETH1dv
         agMOMzvDhH4bOsf1vZjHBPNa5okI0KCyr841RRUZL7HJF3w/0daKxzr3ZL9d60IKas1N
         3f1Ftz0fvIxw8sqYMD9d3GScY+uEdoseI5WxaeFo26jlkr3hxW/cQCDz+nscQM8XlVE3
         UYNz7f++a/UjTLpsT6PQS+caTiQ0S8B0aHMk/cPMucBB8WXSX7sXNExMjTsi6Tdiv3DF
         V8qhfifY3UZVvRPm0fvUVFx0S4uKCKf2VoqNtAhCdVKPgiCOBMd9fQDPZIdsONoVOEVK
         KlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806906; x=1702411706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSrsxMtqGFne/rd9wakrOSxYSu6JhQYC9mQGxjxNaLs=;
        b=tyUbRTVNnui50DQv/+G4gl3/btx+AaF0gsd7waCo+1gyDkQFsYgVwRzQ5OjFcynOPg
         I4A5SCCJxhnD8lsevkxZuwKm3V9mH3X0imUswAJZW7ldUSOVhEINsuIEEaL6wTIDB+AF
         bgAB/0RQSvgkLy7NvmNVZt3lH8+TO8upj7A09NyoKvUhB74KDzcBCyfoyLa4zW5umFS/
         G3Tv0uuwctuhf5A/WcsGXr4zFxQdGaM/8r3QifzNJ3FcN/zJpldu3gKEj0fTOhdzT1sA
         +SQFQ0SUr5l4dl7C31A6KT9QO5kd+Kl4vRbs4snWDwsa1n/9G0yr8RFfK7JXo0QogXWH
         YaFQ==
X-Gm-Message-State: AOJu0YwUEZnnYb4D/3racMawPdTfCy+Eb0aGRR3TT6XNqDMSDo+ctIMs
	6YytxHqZ9ma2NkydAUR4Mu46I/jIqC8YOgdM9I3CIQ==
X-Google-Smtp-Source: AGHT+IHZQnoSTZyFKEeDjGAGUcLeLiFTjK6MEaV3VXgaIebW7/Or+MYLeDikbTpb2u47fwxuuXCl/psDeThixjU0I1s=
X-Received: by 2002:a50:f61b:0:b0:54c:794b:875b with SMTP id
 c27-20020a50f61b000000b0054c794b875bmr13467edn.1.1701806905505; Tue, 05 Dec
 2023 12:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205190951.67-1-yx.0xffff@gmail.com>
In-Reply-To: <20231205190951.67-1-yx.0xffff@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Dec 2023 21:08:12 +0100
Message-ID: <CANn89iLibjjMhJqX_CA4gSDxpBuD9bytfW6LSCKM0fyDvv5K0A@mail.gmail.com>
Subject: Re: [PATCH] net: remove ___neigh_lookup_noref().
To: YangXin <yx.0xffff@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:10=E2=80=AFPM YangXin <yx.0xffff@gmail.com> wrote:
>
> key_eq() and hash() are functions of struct neigh_table, so we just need =
to call tbl->key_eq() and tbl->hash(), instead of passing them in as parame=
ters.
>
> And if those two parameters were removed,  ___neigh_lookup_noref() would =
be pointless, so I replaced ___neigh_lookup_noref() with __neigh_lookup_nor=
ef().
>
> Signed-off-by: YangXin <yx.0xffff@gmail.com>
> ---
> Last time I comitted this patch, Mr Dumazet said "this might defeat inlin=
ing.".
> So I compiled kernel on my computer with defconfig, made sure that this p=
atch would not lead __neigh_lookup_noref() fail to inline.

Not sure how you checked, but I found the opposite.

This patch adds additional indirect function calls, with additional
RETPOLINE costs.

Look at ip_neigh_gw4() disassembly before/after your patch.

