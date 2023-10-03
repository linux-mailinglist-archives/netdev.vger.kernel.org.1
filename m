Return-Path: <netdev+bounces-37821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B0F7B7486
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5072028136D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB23F4AE;
	Tue,  3 Oct 2023 23:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFD3CCF8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:12:58 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D2B4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:12:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so266067966b.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696374775; x=1696979575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaFpiEY5JH4xoOaWyLud8W3R/SAnqW0FuICHPBykSfM=;
        b=RS7hKJEP6pS2DPmYR+PYIf76iLY/l1jcZLAVMMKX1ld9HBXOjQaFMOgKbki/hJGMaq
         15DAR6wTs7VpZVG1jDCEvwLbKNHKfYXzeDw58AlhgXbodM26FU77UPATIFub97um+WPE
         UDYCFGp3MsSytxBx5sCFdBYLQzo9TlAkrMHKUjm2ti8w+B9PXgBQz9+4Eo/qScylulPx
         vyU0WxaIJ0eMYlYpZJ0V0oo0gGzRe0Tccae1Gk1L+MMYMYXvTNgceTW4aRWiOYNYTrbH
         SRMrTndo7QPYBHRc0kMBMCGm6cLFOu4qgRkGQYbl/Xx5FWbvNw/hVLKq+tGGvVxRZwlH
         VzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374775; x=1696979575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaFpiEY5JH4xoOaWyLud8W3R/SAnqW0FuICHPBykSfM=;
        b=tClqZ7bqBOoiNPViF3M2/wrzqPI1g9xUInQXe4dL86TgdnaEiTDO0W5zilM+hC5OHR
         34hU12XWDQ0f595etY2x07BwzCw22vAHc4vUySlUGI21Apamr51k8d1P8SRR7JYdz01I
         NmWdcYNo4V83TSJ6aEZHjrv5hhhB9zU64WALkzYDvjLsFBDcNJmtGUgsHIZ2zR+AIcbP
         gN5OmePw61fVsqBDhqefwhCKm47SBYt7mGu1q1FwsobIsHoWKBEYzM4vKHIdtLd4qkol
         0olSs0uhWHP17MUljWr0sAmU9/F4+ELC4kKJKcXUGBfy9v29vT6DbfZlhs96olHcxFSh
         WYUg==
X-Gm-Message-State: AOJu0YxWvLUlJlWLJr+XNVuX16LNrKGfFZ1kfB0EhDyCb9XqU9sBKP4g
	HtwuoMlC8VLs7cS2S77F70HNlbo/3s9B2sMM1+Vicw==
X-Google-Smtp-Source: AGHT+IGIAv1B8l7PPJwCoeN7f0g0yeR5LZROzHms5LHhhlU7a5bSwRk1Gpmtk7Zd8a8qWTdhzqWf4oRXEPk/0ORHwv0=
X-Received: by 2002:a17:906:76cf:b0:9b2:a7e5:c47 with SMTP id
 q15-20020a17090676cf00b009b2a7e50c47mr577019ejn.9.1696374774622; Tue, 03 Oct
 2023 16:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929180611.work.870-kees@kernel.org> <20230929180746.3005922-4-keescook@chromium.org>
In-Reply-To: <20230929180746.3005922-4-keescook@chromium.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 3 Oct 2023 16:12:42 -0700
Message-ID: <CAFhGd8oKZEhWhv=C3FZHH3D3DLevKONV+VdVLLpS1U8JFF3bvg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mlxsw: spectrum_router: Annotate struct
 mlxsw_sp_nexthop_group_info with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 11:08=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_nexthop=
_group_info.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/driv=
ers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> index debd2c466f11..82a95125d9ca 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> @@ -3107,7 +3107,7 @@ struct mlxsw_sp_nexthop_group_info {
>            gateway:1, /* routes using the group use a gateway */
>            is_resilient:1;
>         struct list_head list; /* member in nh_res_grp_list */
> -       struct mlxsw_sp_nexthop nexthops[];
> +       struct mlxsw_sp_nexthop nexthops[] __counted_by(count);
>  };
>
>  static struct mlxsw_sp_rif *
> --
> 2.34.1
>
>
Thanks
Justin

