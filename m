Return-Path: <netdev+bounces-37835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14C7B74BD
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 42D591F218E0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DA3FB0E;
	Tue,  3 Oct 2023 23:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC83F4DC
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:21:20 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B19AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:21:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so268789066b.2
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375278; x=1696980078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NEDkCvEYEdfp18YGZL4PXY8c/uK5lT9K+U1l2rQw9o=;
        b=KwtW/htcSF8wCE1h1q9KJuNnION/f7zBC5ccXE8vL6QPJ5nnQICxb9+2b0a3tinhmF
         kwJXD7NdV4pnskp8PpnlUbaojPNdi/wZQtz0o02DaGyd5wnmc4lhkmUj9X1Ou3yktij+
         qIOoMehggHBFBiUshyuh1jbFaZ6K3Y8esKhKvBYDXyuL1QyF0IJtVXiviJ3+qE2rGb3x
         PpQ+eV36T/POgtKQK7r3mXgUTqT8HsQv2RInH3VjF3G+KDd1lBj04nF9acIt3V8cOhGS
         +6VYUI7xVuTOJILbCyL1jxI4xCB26dClhtwqVI/Qx07ZDOx2W4Q1edjzgG/kiptL3ETp
         aWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375278; x=1696980078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NEDkCvEYEdfp18YGZL4PXY8c/uK5lT9K+U1l2rQw9o=;
        b=d72YSz4RWlXerAx4X7XI/bGEbCaamthjZ6EcmgMueE8BoCVzB/zLBKr6kAm6PgSdBr
         xftw2ScyYr0ZxMXCcP3WzmJOxFe9X/l9Btbd+7OBaMN/1V/M22z03atJDgV1mt+v8aSI
         6DWyW0cLfjfgsyW4UDx4xen9UTotw1HyFbWq+eGK3xzaDGmk4E+ETP9JHSV1CxZMmOGj
         Gxm7NMDS4EKQZRRyIhs3f+Wixaz9utGr3SwiidAzZKYCV0hDET8e3s26u1b0H2BDIhYQ
         rkJBSezVZZfhc/4h20QBZUjFr4IbsHk/zuaPTKXo3hfjf2JiZliQ5zw0iFL39Q5ocP92
         895g==
X-Gm-Message-State: AOJu0Yy3bQtXiQumJ92aGoFwCpJsyz08o4SbPtkmcEWln/9AWbxlA2RC
	J+yjas+oLdLoHLR1f5y+YCczdbNHRM541pcO57YFQw==
X-Google-Smtp-Source: AGHT+IG0gPECXGw9A/gIAqloUi1ngSn5XzFSHXVfzJRfB8/udSmpuXSq+v3fUnb1mtCR9QBgn9maksQ6/PKW4YpLkUs=
X-Received: by 2002:a17:906:3ca1:b0:9ae:55f5:180a with SMTP id
 b1-20020a1709063ca100b009ae55f5180amr594658ejh.9.1696375277697; Tue, 03 Oct
 2023 16:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003231718.work.679-kees@kernel.org>
In-Reply-To: <20231003231718.work.679-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 3 Oct 2023 16:21:05 -0700
Message-ID: <CAFhGd8p_o5xtmrV+Vm0JUR5VQmMenqtm3xbJuE0TSj-_4Bthfw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
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
> As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.
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
>  drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> index 17fe30a4c06c..0c26d707eed2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> @@ -539,7 +539,7 @@ struct mlx5_fc_bulk {
>         u32 base_id;
>         int bulk_len;
>         unsigned long *bitmask;
> -       struct mlx5_fc fcs[];
> +       struct mlx5_fc fcs[] __counted_by(bulk_len);
>  };

This looks good.

`bulk->bulk_len` is assigned before flexible array member `fcs` is accessed=
.

        bulk->bulk_len =3D bulk_len;
        for (i =3D 0; i < bulk_len; i++) {
                mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
                set_bit(i, bulk->bitmask);
        }

Reviewed-by: Justin Stitt <justinstitt@google.com>
>
>  static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *b=
ulk,
> --
> 2.34.1
>
>
Thanks
Justin

