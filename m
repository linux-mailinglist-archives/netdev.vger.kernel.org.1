Return-Path: <netdev+bounces-45287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371467DBF2C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E03281655
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B76199AE;
	Mon, 30 Oct 2023 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXJV8sSs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F614199AC
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 17:40:25 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D032A9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 10:40:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507c8316abcso6729409e87.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698687621; x=1699292421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0ir2D4QCfLQnWbR8rXv+lrdC0LI67HN6g7rBTtSt0E=;
        b=NXJV8sSsllAMLgEMWhKoi37VXaPI/zzX0I/gohKQjl8rwk/6NOPsk6rorWKvRpx1EY
         0725YuMejBHp+XkhjbolRMvkXSCw3LIysfnDT6SsFZLgvxL1gugwZzoDUfQuo/vzt9wZ
         YJG4QCRFcBkwrYzgC7H8vGqbNmP0dGIj3YzQ3xwUzFSElUIzgQI125hiG9tC7yihh/h3
         14RO6mlMzcaoXiEsYeURMTTJCu2pRDZQJ849xFeq7tG6ZQidonKk+BusJii5KQggMzbK
         tFY8SJGpY0CDYyIBu2RPvVdK8kFIFj1D2ctXoWgiFUheiGUznVdERJRFnImsInnvZC8Y
         hlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687621; x=1699292421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0ir2D4QCfLQnWbR8rXv+lrdC0LI67HN6g7rBTtSt0E=;
        b=Rw2icAn0CGGPBGxA4yJUgXu/mPkPKp8QnU1p+i3xVytreXdjYGY47tA7O07x4dO29F
         LEUVyKJhnPvDqcUzNIU3WNSKixBVssYib/0+hnV37E5sPm6YgjpXbJAQefMNNep+Jys2
         nrxpgou02QMWOAAvVKkMabZwSWTRo1pEt2oJtnygc3/jSjatItYz/EFTAHM4UG3aVowk
         ApUpsbbbC+94YqEGBe96aGl0JzNWI2Nbvgo5UZVh8lrUqWevyXmJ7c97f57j7DHUTxkA
         S8fNRvpS3EL+5ZQjYlu0PU9hLF3WKwn/vsX+0kucte2aQn71kY4waOxjO+r3f1QKQpT4
         ShgQ==
X-Gm-Message-State: AOJu0Yx84esqIv+7S/QxjrANOZG82tvmNKr0gomU7E4I7qrfH/zMl3Oo
	fxdORNM1IIL+XTQsdd9/HvmOH6HE88TeJBGD1hHEmg==
X-Google-Smtp-Source: AGHT+IGVUD6diH5ENQ4J/fApQAHbs0bzqg4El0Q54SM7Jan2NxauyGPeedCJqSM3NOBGaw3YFoQFSWASkx8JzdIELYA=
X-Received: by 2002:a05:6512:1081:b0:507:a5e7:724 with SMTP id
 j1-20020a056512108100b00507a5e70724mr8955304lfg.38.1698687621042; Mon, 30 Oct
 2023 10:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028192511.100001-1-andrew@lunn.ch>
In-Reply-To: <20231028192511.100001-1-andrew@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 30 Oct 2023 10:40:09 -0700
Message-ID: <CAFhGd8rdziUZXH4=CxnZZKuS3X2EpTajxBgat+fvr-5RRzAekg@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: ethtool: Fix documentation of ethtool_sprintf()
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 12:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> This function takes a pointer to a pointer, unlike sprintf() which is
> passed a plain pointer. Fix up the documentation to make this clear.
>
> Fixes: 7888fe53b706 ("ethtool: Add common function for filling out string=
s")
> Cc: Alexander Duyck <alexanderduyck@fb.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/linux/ethtool.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 62b61527bcc4..1b523fd48586 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1045,10 +1045,10 @@ static inline int ethtool_mm_frag_size_min_to_add=
(u32 val_min, u32 *val_add,
>
>  /**
>   * ethtool_sprintf - Write formatted string to ethtool string data
> - * @data: Pointer to start of string to update
> + * @data: Pointer to a pointer to the start of string to update
>   * @fmt: Format of string to write
>   *
> - * Write formatted string to data. Update data to point at start of
> + * Write formatted string to *data. Update *data to point at start of
>   * next string.
>   */
>  extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, .=
..);
> --
> 2.42.0
>

Great! Now the docs more appropriately describe the behavior. My patch [1]
for ethtool_puts() will use this same wording you've introduced.

Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://lore.kernel.org/all/20231027-ethtool_puts_impl-v3-0-3466ac6793=
04@google.com/

Thanks
Justin

