Return-Path: <netdev+bounces-21614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E99764085
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AABA1C213D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B24CE81;
	Wed, 26 Jul 2023 20:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A91989E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 20:31:17 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968F2127;
	Wed, 26 Jul 2023 13:31:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99b9161b94aso16665866b.1;
        Wed, 26 Jul 2023 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690403475; x=1691008275;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+pV4iCMz6JjqVwmfQiE6VOuZFXbz9ARYQvR895v1vFE=;
        b=JNUbBAXD3E216BCygF81S/3TlUl81snUcIHssa5bxnCxVIlFD/kLrowujjEdB2FMtj
         59g0uCjq1k9c4vowKmz3i1ItUM2erxywPCqYLVjhsD/7Fxn7hMbF6Mj4JONIQhLmfJE9
         KbSZcoXRb/HbgdS4bNRaWdPxaOxS940pMiCarO2ThCMxPxI8mBdYqSSFTsdGNwq6zu6B
         pbOX8Teh9k1lFFzP6djerTL1dsI3L0sqayfCrgtQzEEQSEJvjRFBACdnN2MJAkgivUWs
         Dl53hiq1NW+o45YDTXDG1bv9iJ/191AmFoJJ8nLaztozT/WnTeFt+jRz6s+OOtgRPake
         WUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690403475; x=1691008275;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pV4iCMz6JjqVwmfQiE6VOuZFXbz9ARYQvR895v1vFE=;
        b=fR/W6PZLwq7l6BhvxQnx2sFz2moOJj1MlSZHPy0pmtNg4yExdhgDE1NPlBeHA7S68f
         X/CYwummpf5zaJ9DnrdL8X4ICLDcgP37omAme9iswcQDz3l0u63SIGvek7fwIOS76pPT
         VomY9P3XNsflMT7ejJEmdASeTPu5b2sOIBuUtlLtBbz8oLFLN6Q9SQm2UIi4XdHL95/5
         L+V0BCTE1B1A0ljXTlnGkcFMnGeoYdje1SuSq4sY4M/LQKbOhXUz7DI/RY0CTkHuu2Va
         IAhImTJoWdLJrgcKeGi8ONxJiOFD6TZEFlzJ9IFaQJ83aOPm1jFnqDbHgg0r3xXbx0qH
         S7Xw==
X-Gm-Message-State: ABy/qLZnTpKP3Rno3zr6W4iWMqv0pS7xERl4fYcAO+nrkyRj0Z3VQs9S
	pY4H+6+Kz7qMIYs0tUwzaT/aPsn5aUyutKhRyRc=
X-Google-Smtp-Source: APBJJlEMSBpMM9/vHYFMY2X+yF+5ZRvyi5C+cWFBG+9gSm9BidcFDe78hGuQT2ngJP70tET0/CvJguorQGPQ2/Tqdg4=
X-Received: by 2002:a17:907:2cd5:b0:99b:5a73:4d04 with SMTP id
 hg21-20020a1709072cd500b0099b5a734d04mr228592ejc.71.1690403474891; Wed, 26
 Jul 2023 13:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a17:906:dc89:b0:978:9011:58a1 with HTTP; Wed, 26 Jul 2023
 13:31:14 -0700 (PDT)
In-Reply-To: <20230726112913.4393-1-machel@vivo.com>
References: <20230726112913.4393-1-machel@vivo.com>
From: Jay Vosburgh <j.vosburgh@gmail.com>
Date: Wed, 26 Jul 2023 13:31:14 -0700
Message-ID: <CAAoacNk1sdkvdkdNpOu9yy9RtRW2zRbuNWnPV2cFzijfuQbMLw@mail.gmail.com>
Subject: Re: [PATCH net v5] bonding: Remove error checking for debugfs_create_dir()
To: Wang Ming <machel@vivo.com>
Cc: Andy Gospodarek kjmatt <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/26/23, Wang Ming <machel@vivo.com> wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in bond_debug_reregister().

I'm confused; I recall that the prior version kept the pr_warn(), but
changed the
test from a NULL check  to instead use IS_ERR().  I'll state again
that I think printing the error is useful, as it would provide an
indication of why the debugfs directory isn't available.  I also don't
see an obvious way the error could be used to spam the dmesg.

        -J


>
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/bonding/bond_debugfs.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_debugfs.c
> b/drivers/net/bonding/bond_debugfs.c
> index 594094526..a41f76542 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -87,9 +87,6 @@ void bond_debug_reregister(struct bonding *bond)
>  void bond_create_debugfs(void)
>  {
>  	bonding_debug_root = debugfs_create_dir("bonding", NULL);
> -
> -	if (!bonding_debug_root)
> -		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>  }
>
>  void bond_destroy_debugfs(void)
> --
> 2.25.1
>
>

