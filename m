Return-Path: <netdev+bounces-37823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DC7B7497
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B01901C208F6
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CB3F4BB;
	Tue,  3 Oct 2023 23:17:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE43F4B4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:17:35 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E206AF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:17:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad8a822508so275036866b.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375053; x=1696979853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68h/m2Pi2zxdSKkFh1D4c3jbV9GqO3rEkPm7rE0iF3o=;
        b=3bx9w1Pz2fu4rHJIoaU2RQXY2OPpb+0QIgCA1wpj+ohooUs8fvoJw4TMIF3YSjXA0K
         wLrN+7eTDMpYM9SKzp99wz3Ybdu0bQvfdiZAG2DKYM7s4O1aBzDxTqi1cFxELcjAFfmT
         Ij9uLz731uineHBSJWBi/9M02Gth8hMAp+7lMdj0Sr9u09BCtldWxoVzuGTDTFL1gMdk
         u2onH0YPtCtr8WTdnFPw91+KR8w0RVz/ghbA9p3mjeG4l6RqDxSDSBu4dAr1REklne/F
         sPF6D3PKVeB05/eoaL5LmImX8c/oYVx9iynnQHex+jJ7/ID9kPbVax8UlaxL7dMx3apP
         oMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375053; x=1696979853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68h/m2Pi2zxdSKkFh1D4c3jbV9GqO3rEkPm7rE0iF3o=;
        b=bBsE4k3jgVGTrjXuonl1rvQ5Fh8OodozKJjpQ0m3HuogjwlD93KrSIHgDD0sokYi7B
         CoPkYQxcVZMKkyUaBQGXBmDlSTRcJNAhSYEP4uJ9ol1uNY2vZh85hnKfJmDfbyT9HE1b
         pdmXVgGNNU3LpyOcPFmOB5sS46ny4HpExO1LIeA5A0bvfoxqgQ0iC98Pr46Va3kKCrO+
         ABKGBZSgGzm4ShLfYAOnQD5X6sdueItBQyPtaI2IdiF/YQgOqcR0AUhicGYf3NGe0frr
         PkIY8QJodmb1x3cqv3dS0KEAJm6FaHZTCFLZOid/3CVkZ9OKXKaZjN7ta3MLc48sf0kF
         NJog==
X-Gm-Message-State: AOJu0Yyw8bBUM4gH45DKOQUyFa5gHtGNBN1moa3m3SVK9l+4blhysv7c
	xHh2x7ettvlp0uvgtBl8begXJFar/GXYPhbKVWs2Fw==
X-Google-Smtp-Source: AGHT+IGEvMe+xIOWkMolJEXQAxQowB6eO5nOtwa3QRtIQtSuD0kxolB5u9x96JruypuWe9ZfCzHgJm10L5ZJ0sCb76E=
X-Received: by 2002:a17:906:7697:b0:9b2:b119:4918 with SMTP id
 o23-20020a170906769700b009b2b1194918mr588755ejm.13.1696375052745; Tue, 03 Oct
 2023 16:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929180611.work.870-kees@kernel.org> <20230929180746.3005922-3-keescook@chromium.org>
In-Reply-To: <20230929180746.3005922-3-keescook@chromium.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 3 Oct 2023 16:17:20 -0700
Message-ID: <CAFhGd8o+0KhH2hfOLD=ru+53TPZEfsPUtjRbYOvG_D5zaz-bXg@mail.gmail.com>
Subject: Re: [PATCH 3/5] mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool
 with __counted_by
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
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_counter=
_pool.
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

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers=
/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
> index ee59c79156e4..50e591420bd9 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
> @@ -24,7 +24,7 @@ struct mlxsw_sp_counter_pool {
>         spinlock_t counter_pool_lock; /* Protects counter pool allocation=
s */
>         atomic_t active_entries_count;
>         unsigned int sub_pools_count;
> -       struct mlxsw_sp_counter_sub_pool sub_pools[];
> +       struct mlxsw_sp_counter_sub_pool sub_pools[] __counted_by(sub_poo=
ls_count);
>  };
>
>  static const struct mlxsw_sp_counter_sub_pool mlxsw_sp_counter_sub_pools=
[] =3D {
> --
> 2.34.1
>
>
Thanks
Justin

