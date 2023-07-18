Return-Path: <netdev+bounces-18678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F208F75842F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A02815BA
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9565816409;
	Tue, 18 Jul 2023 18:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9E16403
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:08:14 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199CC0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:08:12 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635eb5b0320so41497436d6.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689703691; x=1692295691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZNvffSr0fIaU6E8WHPNUlcFQDdJ3Zz7MDJXSBJ4tKo=;
        b=tC02Mr7VCA5hfxlpuX429tYQT31A2sFDGB9wKKL88i9zeIA1oX4Af/v7iOqRgSOFPR
         VVi/nHnWZD0jo6H0IN8b6Dzj0qRdDopEzgGs8vv2muGNKwFCrVwNvWS0E99Q5D8+gu5t
         HPfhhBE8vYSc+EsrPpdkCt8LANiqsZnPxnhQuxxY/yrgmG0tg/Osh/oIxSIiZsfmZXD/
         7TGk0LR2akVONtI+CIFVAWRuvuDmJt14a2s3QxOJbhfVe9GW5laXojLLEwiOuWXgpH2s
         fl1BAVMQDkdy4C760VwNpTZXeWxd2zyhZQJrpXoST2/k8QLxnkvO4JDlGzI4M8r6+YgO
         hz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703691; x=1692295691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZNvffSr0fIaU6E8WHPNUlcFQDdJ3Zz7MDJXSBJ4tKo=;
        b=SPheZaLh0wPPHxcIH2sugesnSEblbR5cqRsYSD19hkHo6QWrL9PzExPxnssgW9ZEPH
         OR+/Z0wD8mTKAQHfdBYoKLd8h1oKzcejFidq7lTOnTvhgc4F87gm05xNqPbt9AG6BkXG
         A3c+68qgsl4lwQkeqQygQfWEA0Fr2cNvO45c5QhPBdmKvxC9Z7JXzcUH6MwYulE0JMUE
         BNYFlCBF6ElUP+lELiIpxc9g/LGurSkz7rkhx+utVwaeXz0q4ABjijbdYIAdJdIBiKI2
         lA1wc82pJmLkDXg+/IsRVqGr9Ml+zvvBYCmNa0FAunHldiKishpuZMXRkgz0ViU+J1ut
         f3QA==
X-Gm-Message-State: ABy/qLaOAbVyX4jZQWJdpDeLoaQ893YPYEA/Lif37fKUZx+KYd75whYl
	3esfKtsjYHAdEIf/WWpYPE0fo5SmcR4AJjaVmyvlNQ==
X-Google-Smtp-Source: APBJJlGASSITs1UcfZKqEXMMmodRln9WeyEXwjg9FvMUYmucF+O/V7bPkZvagefw+IL7XN+Hw+Z6zrT6vOduk7nN3/g=
X-Received: by 2002:a0c:9c42:0:b0:628:2e08:78b7 with SMTP id
 w2-20020a0c9c42000000b006282e0878b7mr16595302qve.31.1689703691528; Tue, 18
 Jul 2023 11:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
In-Reply-To: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 18 Jul 2023 11:08:00 -0700
Message-ID: <CAKwvOdkZjrSDxZOZvEQDoybJbDbuMhWL7BT9fLoRU=-sM8g_UA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
To: justinstitt@google.com
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 5:04=E2=80=AFPM <justinstitt@google.com> wrote:
>
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>
> Even call sites utilizing length-bounded destination buffers should
> switch over to using `strtomem` or `strtomem_pad`. In this case,
> however, the compiler is unable to determine the size of the `data`
> buffer which renders `strtomem` unusable. Due to this, `strscpy`
> should be used.
>
> It should be noted that most call sites already zero-initialize the
> destination buffer. However, I've opted to use `strscpy_pad` to maintain
> the same exact behavior that `strncpy` produced (zero-padded tail up to
> `len`).
>
> Also see [3].
>
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nu=
l-terminated-strings
> [2]: elixir.bootlin.com/linux/v6.3/source/net/ethtool/ioctl.c#L1944
> [3]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
>
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  net/dsa/slave.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 527b1d576460..c9f77b7e5895 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1056,10 +1056,10 @@ static void dsa_slave_get_strings(struct net_devi=
ce *dev,
>         if (stringset =3D=3D ETH_SS_STATS) {
>                 int len =3D ETH_GSTRING_LEN;
>
> -               strncpy(data, "tx_packets", len);
> -               strncpy(data + len, "tx_bytes", len);
> -               strncpy(data + 2 * len, "rx_packets", len);
> -               strncpy(data + 3 * len, "rx_bytes", len);
> +               strscpy_pad(data, "tx_packets", len);
> +               strscpy_pad(data + len, "tx_bytes", len);
> +               strscpy_pad(data + 2 * len, "rx_packets", len);
> +               strscpy_pad(data + 3 * len, "rx_bytes", len);

Thanks for the patch!

Consider adding a #include <linux/string.h> so that we stop having
such an indirect dependency in this TU.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 if (ds->ops->get_strings)
>                         ds->ops->get_strings(ds, dp->index, stringset,
>                                              data + 4 * len);
>
> ---
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> change-id: 20230717-net-dsa-strncpy-844ca1111eb2
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>


--=20
Thanks,
~Nick Desaulniers

