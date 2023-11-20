Return-Path: <netdev+bounces-49164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11687F0F90
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FCEB20F1E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E87125A7;
	Mon, 20 Nov 2023 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxImC+f9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA0494
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 01:57:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso5038a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 01:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700474278; x=1701079078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2YoIj7IxZVQMxemwiREVJYCJdXNAZDi8IPlwZCc5gE=;
        b=FxImC+f9+8IzbDwBgrwvHiHC6CBKiZB0lunGeN/z59pZ/GwLTupid8MLYr8IruCmfM
         4i2oncCTGvX6kn41g3nqLUr1Np4feKxRAKEtDaa5M7yW6EvFtluKLHjLnIvh2H8YspOF
         /OlHLQ/Cb9mNkLePbkdGPrk8b2/wXEv2RShjmxjJMPMrGUXkZbtyobACvg6xj68G+B+E
         l0X6ojHFiZlICgPTd612gMW7D6Sk2otb8+PT+p/gdGQnB/yUJXRuksTdohJHELCIj7Fz
         fOwnzAwbFH0xBH3yPfuptn9cbRDtngVpbWKTlKpFtWNvi0suqMbbZKNUnQ6TxuT5DPYS
         MlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474278; x=1701079078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2YoIj7IxZVQMxemwiREVJYCJdXNAZDi8IPlwZCc5gE=;
        b=dQLAQtg0MHhFpBMkYLZNpz33Sm66vG/leI4/5oizn9uoL57CTW7k+glifWgY4K/5tl
         xU0sVHq4zFhL+aX4OslNyPkXk6KLRLsHsq0gCq2Szl4LnPuxSKuCHHWSlEr/znG2Of2o
         FxKwkTyZU/DYtYRdFoin1SjUT9RtwpNYH5PnLFMTzYitRder6v2M+4qWtZPgCvNlJsDQ
         QzKP+CviKpBIDhYZAtFkOPnFqU1wmNW1GwB+0DBaqlsoTN7uZD5C/Gdwu//7DdgpS1rz
         CJpWhfWKyptv9laXRuEyTUfDOyP4YtjXUdzQABQTSdnZTjszXfWpG90p/vspeHHG3/hw
         pnew==
X-Gm-Message-State: AOJu0Yw9zLeWEwG8bk5zUDHi2bFZq/3BXfv+Kt45o0nSvmi3tUUTS7rh
	pfWZWLUJqjlO/6sGVHNCpbi9c0wd0e9/J14VQm8jG+VifHH1r9qIx8rbIg==
X-Google-Smtp-Source: AGHT+IFCGagQaI6uXwg0TJHnLdCwNRH9AV2vQwnqB2jNFhZlUMWYV3MA9OBS+uIgQn0GN1GhmneyAlVluouNdzaJIX8=
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr219302edb.1.1700474278195; Mon, 20 Nov
 2023 01:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
 <20231119092530.13071-1-haifeng.xu@shopee.com>
In-Reply-To: <20231119092530.13071-1-haifeng.xu@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Nov 2023 10:57:47 +0100
Message-ID: <CANn89iL3hY5BcdJi1yRrB6YphnucYtAM3Z8bz-zWcvv49T34uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bonding: export devnet_rename_sem
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 10:25=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com>=
 wrote:
>
> This patch exports devnet_rename_sem variable, so it can be accessed in t=
he
> bonding modulde, not only being limited in net/core/dev.c.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/bonding.h | 3 +++
>  net/core/dev.c        | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 5b8b1b644a2d..6c16d778b615 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -780,6 +780,9 @@ extern const struct sysfs_ops slave_sysfs_ops;
>  /* exported from bond_3ad.c */
>  extern const u8 lacpdu_mcast_addr[];
>
> +/* exported from net/core/dev.c */
> +extern struct rw_semaphore devnet_rename_sem;

This probably belongs to include/linux/netdevice.h

Reviewed-by: Eric Dumazet <edumazet@google.com>

