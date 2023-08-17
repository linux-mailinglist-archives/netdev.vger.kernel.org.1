Return-Path: <netdev+bounces-28599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EACE77FFB3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F002821B5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8991ADD6;
	Thu, 17 Aug 2023 21:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3291ADC8
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:21:25 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76623E4C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:21:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe655796faso266682e87.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692307282; x=1692912082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeALbQx5LxBzM1MS6Rc6ll0OcowbkB9LP6Bj9ouPlmM=;
        b=r2BSbs41E3psTG4zlT/6L4I1b03YBb00iebZ40WnpKqoJsQeLxPfPQILffi9Isyt5e
         DIAVRDMitsROKjFFg3zhKIC+75cxN7MgdkMHAYGTrmznmd8R9V1sCiqNtee8tSYUfeSl
         4hKjJOjZEuseG3873Mdya5l9Gp+7HLExt39/BpyyUJW1zPbOpY3gKT8d7WqGKybcnRJs
         1uV0k7CPsgeOlVT6rg1yHqnyvtLLIoKU8/rWyCAs2KW/5dTrSBdx9Ketg27aOdMT/b+0
         M/OJMmfqEyolSVetziGgawKhRc2djgMRUPxbYf3jNXN+mfm3IZJOpYUdwyfLi7tWGbtx
         NeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307282; x=1692912082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeALbQx5LxBzM1MS6Rc6ll0OcowbkB9LP6Bj9ouPlmM=;
        b=KzjXwPNH4n8bKJnp/EmNFZd2H+Vqw9J592+VOaLInkztm+K6NWCeUtlL9H5Ikpg6Gs
         LpGX6/MEzV6S+yTSpVxCdatU/QgZJdwAqBIG7uCJWD7H8YrseayjrZEPv9lhXBPQpbyH
         g+bYHVV3d+TcjXHVjpFuHFVEW6om4sZyRVbhkfRoO94w49+BNllrqxEDfs6uvrobwXPW
         /Eo/FUxGOZITfdm0hT/lNM2jYKT62kspXMx5r9kh6oNNmWPuKNG8qkwd0/LP6npcN4dk
         /MSoDygKHKKPbNA9ZGMNHZ7HJW3MMoNiwagUOVs2dfI6S4Ar9c3V3eu6AcG9mQiUk7lU
         49UQ==
X-Gm-Message-State: AOJu0YzkMMTwboJIRSepYTB/DE7UC5dgwx/NO7rafuYCzFbX+0PRA8YE
	N9/2whDXE+EkAcq79IuHCOYMq0sKQilNlm+sBTUCTg==
X-Google-Smtp-Source: AGHT+IF/wiTT9wIP3+3ZHZmD8p/Ah3L5qulD8+FJwJ+Q2KQcVBd0I/M4ovMbQFsOqVAG3uMWNbarBRjmU6goY9fjd54=
X-Received: by 2002:ac2:5226:0:b0:4ff:8aa7:185c with SMTP id
 i6-20020ac25226000000b004ff8aa7185cmr347546lfl.7.1692307281523; Thu, 17 Aug
 2023 14:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230817211114.never.208-kees@kernel.org> <20230817211531.4193219-1-keescook@chromium.org>
In-Reply-To: <20230817211531.4193219-1-keescook@chromium.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 17 Aug 2023 14:21:10 -0700
Message-ID: <CAFhGd8ra6vpUvLc_Z7zRA8kVOzu7=o6b6vFL+QvcGi34-nVmFg@mail.gmail.com>
Subject: Re: [PATCH 1/7] wifi: cfg80211: Annotate struct cfg80211_acl_data
 with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 2:16=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct cfg80211_acl_dat=
a.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/net/cfg80211.h | 2 +-
>  net/wireless/nl80211.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..eb73b5af5d04 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1282,7 +1282,7 @@ struct cfg80211_acl_data {
>         int n_acl_entries;
>
>         /* Keep it last */
> -       struct mac_address mac_addrs[];
> +       struct mac_address mac_addrs[] __counted_by(n_acl_entries);
>  };
>
>  /**
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 8bcf8e293308..80633e815311 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4889,13 +4889,12 @@ static struct cfg80211_acl_data *parse_acl_data(s=
truct wiphy *wiphy,
>         acl =3D kzalloc(struct_size(acl, mac_addrs, n_entries), GFP_KERNE=
L);
>         if (!acl)
>                 return ERR_PTR(-ENOMEM);
> +       acl->n_acl_entries =3D n_entries;
>
>         nla_for_each_nested(attr, info->attrs[NL80211_ATTR_MAC_ADDRS], tm=
p) {
>                 memcpy(acl->mac_addrs[i].addr, nla_data(attr), ETH_ALEN);
>                 i++;
>         }
> -
> -       acl->n_acl_entries =3D n_entries;
>         acl->acl_policy =3D acl_policy;
>
>         return acl;
> --
> 2.34.1
>

