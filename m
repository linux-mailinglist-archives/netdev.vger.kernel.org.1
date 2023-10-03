Return-Path: <netdev+bounces-37839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD67B74D8
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id DC73CB20849
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC2405C2;
	Tue,  3 Oct 2023 23:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD31F3F4DD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:26:51 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C98BD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:26:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso255567166b.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375608; x=1696980408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkOmFORPNdegsvUzletDdGNQTS/35DzAQHoVxYp5MXg=;
        b=g8BdXQY2ymaa+Ax1z7Lecj0GB4zjvxggDOmeVtM/kQn/8YBjYIz0I07RM51X9bcp2x
         MZvnbvAQz6x5X9OlSeEJe9ec6+OQyqFNPktZvPfgDVieDIfOjLZAV+mWjAD3xSza3tnK
         d5q20wEOwJLmLUMru5coi3WCU1T5UgAoIk7GyDWXMkwu5JkkzwDoKMufZILEweUSBgn5
         g26ShFblNyVG1xMHe1WgXzU8wXr3h7yi1UafE9HwEB/tbu9QcD2lrDEEzxpMidIFQsrc
         JIuRF4cGFXwlXPUGx4vTsZSRzb5ac7kwQBCm+svodMikpQx7VV0DnBG3rHGGFr+vSlxp
         FyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375608; x=1696980408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkOmFORPNdegsvUzletDdGNQTS/35DzAQHoVxYp5MXg=;
        b=SL037qa5fm813fLJIylaG1est50wSW1wzdscHvv0cfDrzR2BEUO/5XYI3c+YhWQkzW
         2se3sdSM2loCrlI4oIsZOcLiXhjE2SX7t6O13+DmUSFftai9h+/qxHp7IJM9mxHF8tn5
         aMzXE+S/6VfsQtUYvo+CPRvQSOZnVvWBFbp8/PiTlksL7VnLo3ENw9GJlBIUB7Dlz11i
         lbNX3ztVCphKk7BxcPtgCpzbT00wuoarGeYb6ovIYiHtuV2/PPPGDuOoEq2cWC8MJa3W
         PEyQGB7iVNlM22kpzfh/QX/pMIbBAA0IRiohEYR8hBOdS8wCMOPQ1IRnx8DGlz38zbY5
         +EgQ==
X-Gm-Message-State: AOJu0Yzi/yzG56EnWuXx7x8yIRuHGYA3mbTU0PqyQ92M5lseI/87BBPf
	78JVl7Cg+1WLM7YyHFuEt6LEhD1SQZQnBjtbPRUNjQ==
X-Google-Smtp-Source: AGHT+IF1d5AjAJYgdKzsBfMm7uGg6I8MvuOFlaYXOCXzffRCV1Xz22bcMhb3NFM3XTYkvVVirGgXazVoYcInwB6GX3o=
X-Received: by 2002:a17:906:da8c:b0:9a2:139:f45d with SMTP id
 xh12-20020a170906da8c00b009a20139f45dmr657784ejb.43.1696375607793; Tue, 03
 Oct 2023 16:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003231730.work.166-kees@kernel.org>
In-Reply-To: <20231003231730.work.166-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 3 Oct 2023 16:26:35 -0700
Message-ID: <CAFhGd8qFcusVNabygT2PuuzqaeFH27BJP9BfWiF7Keo-j2RVQg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 4:17=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle=
.
>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/=
net/ethernet/mellanox/mlx5/core/fs_core.h
> index 4aed1768b85f..78eb6b7097e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -181,7 +181,7 @@ struct mlx5_flow_rule {
>
>  struct mlx5_flow_handle {
>         int num_rules;
> -       struct mlx5_flow_rule *rule[];
> +       struct mlx5_flow_rule *rule[] __counted_by(num_rules);
>  };

Great patch!

handle->num_rules is properly assigned to before handle->rule
has any accesses.

        handle =3D alloc_handle((dest_num) ? dest_num : 1);

then

        static struct mlx5_flow_handle *alloc_handle(int num_rules) {
                ...
               handle->num_rules =3D num_rules;

then

        handle->rule[i] =3D rule;


Reviewed-by: Justin Stitt <justinstitt@google.com>
>
>  /* Type of children is mlx5_flow_group */
> --
> 2.34.1
>
>
Thanks
Justin

