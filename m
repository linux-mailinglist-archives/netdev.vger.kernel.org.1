Return-Path: <netdev+bounces-37726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A99F7B6D27
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2A065281355
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848E3588F;
	Tue,  3 Oct 2023 15:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557E347A2
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:30:00 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C616BB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 08:29:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so1253713e87.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346995; x=1696951795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amro8Gq6QWRGZvPI8kQ8K9MaGGmsh2qAsN2cjlX45YQ=;
        b=C4vwP/YRS+PaN1DO/5xZBx/3P8upUxPw87HBcOcnh+QWDLvmv4pLsi1bQButNXigkz
         rrVKBZz6xfmJldDWDyt4LJb5NmxFXarIqprw8jf4Y84Msittsjgp2w1tiLpLlsacsK/l
         N1/c62Zyq8jI2jc+DCpwXZ7mQtlMJSjoGk0QbG41NQSnV5x913mgYLdXS6RVFjNFzoRT
         k8yQP1f7vNkNbIMk7F4NAfer3//gM2LDxLyYjo5NGhCum7UKMSn0tEtEKCIrLlmUmqZK
         sZaWGmlmZGB3MmzrtxZaiIICpgNcyi4kXuJnc1gPKESTJMRRxdcaJ+58oak5+8a/Fgpg
         2ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346995; x=1696951795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amro8Gq6QWRGZvPI8kQ8K9MaGGmsh2qAsN2cjlX45YQ=;
        b=UPVSxD/L2sYFvNtp39ys2PSdijQnOo47teA2TNG+V1xwD7NWUlrOK2f8GuYbJPAFdM
         UFRXJUTj1kt/ybkb6UsEUaxukdZis8U3Enjv+29ZW20+B0fATOrNpkaQ3fquoUvGiXiJ
         jVfsQiXKj25epbQyMFf6VWcRGqg/dujzDCtlgx6wsWNKQrSKonoYgji9kVe0ZwMjXYUE
         HQyLekagSSHpnn358QEIXQJOeVm13mVV9qGb8nFxDcPU1Iro6+V5FoKki4lM/85YE4pH
         zl910yuhZ+pe0+9Le2AVnSKzQEpyAJ9ZU1tcVtrjOpz/APkucCs+m5ev8D26Jy27Y3gR
         rQ4w==
X-Gm-Message-State: AOJu0YxQT+Imb8XRspzrzNjb3PZ4gqmYEHqwoZD4zWWDYDiR1VdTCxeZ
	EHAc9apVajUgXGYr7iH3A9n9Y/BEHHnjlLS1jdF5xdQXCakOF8tw7ma5Gw==
X-Google-Smtp-Source: AGHT+IGx0FgrW2Ah4ADgj45zfcrPkZEtVTpoj4C20Ji+ONiK6KoICzW/yWQ22hIx9FDK7G+rLghZBNV93m9mJQ5IaUo=
X-Received: by 2002:a05:6512:1246:b0:502:cc8d:f1fc with SMTP id
 fb6-20020a056512124600b00502cc8df1fcmr16458163lfb.37.1696346995109; Tue, 03
 Oct 2023 08:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001003846.29541-1-rdunlap@infradead.org>
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Oct 2023 18:29:18 +0300
Message-ID: <CAC_iWj+rqx1v1s6p3c92iv_nyzNOA7bRX=vLZPsHOSryXrmycw@mail.gmail.com>
Subject: Re: [PATCH] page_pool: fix documentation typos
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks Randy!

On Sun, 1 Oct 2023 at 03:38, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct grammar for better readability.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/page_pool/helpers.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -16,13 +16,13 @@
>   * page_pool_alloc_pages() call.  Drivers should use
>   * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
>   *
> - * API keeps track of in-flight pages, in order to let API user know
> + * The API keeps track of in-flight pages, in order to let API users know
>   * when it is safe to free a page_pool object.  Thus, API users
>   * must call page_pool_put_page() to free the page, or attach
> - * the page to a page_pool-aware objects like skbs marked with
> + * the page to a page_pool-aware object like skbs marked with
>   * skb_mark_for_recycle().
>   *
> - * API user must call page_pool_put_page() once on a page, as it
> + * API users must call page_pool_put_page() once on a page, as it
>   * will either recycle the page, or in case of refcnt > 1, it will
>   * release the DMA mapping and in-flight state accounting.
>   */

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

