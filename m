Return-Path: <netdev+bounces-16730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0674E925
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5971C20C49
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69111C8F;
	Tue, 11 Jul 2023 08:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8A17730
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:31:41 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2191;
	Tue, 11 Jul 2023 01:31:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c49777d6e7aso6615218276.1;
        Tue, 11 Jul 2023 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689064298; x=1691656298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXQHwA7H4BKxYYTb2kjEWqMmKPsPln0gjwSHgBiVGpM=;
        b=pwtCI+eA3pc8/M5Q+ZS9tZKwsbnA1P0CDApbwuntcWVRHjARj+uoJXkPoX4oFhyiHn
         TUIzHvznIT+rTZEZijG/xFlaJrcfaoEzMax+ds+q3o3FXBwSSCcMeUbatAkaNOQ2Q4Mf
         ylw3duVDFPu6Kq52ro6W9FYeArJ6ZseErLjvHZ5XRn+AFd3ycId9a8vTCBycGZb/GeTO
         3oCYOk/WKc1C3bmV1R9Debu416gENyTEbfJZm5ewHrX5UOAxf3qWpKIAzraSBGFXdlrM
         3/LWvD8WlFk/ohEl2M49IKqSYCS5FyEnecH2DLwDdd2U+B0crfPkVtcRzd4zcGMGO8iD
         SQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689064298; x=1691656298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXQHwA7H4BKxYYTb2kjEWqMmKPsPln0gjwSHgBiVGpM=;
        b=L6DEXOGXlABR50wufjysrSEk35xbXDGFWS7DvBOw2dOe9edESd6IF5Iaq3vxdC2pHI
         xlNVo3TfLsWEzmWf65+xDxKkCrxootje+jKyGk6b2356wdvU7s2nUbUfvKEagkG+xv/6
         AZ0P8HDs+qcDlismhOURTB0bKp6JxQSfJkOCFN6GX7u9IIy2f57Dh5GIT64XTxA5/N6e
         /ravkZbwAEEzDq+hGpZIULoDKDlWVfHIyxVmrDhF0gb86yjYU29kW9kc7fG4Dtjupz5K
         Won9/pLFjF0uvCw8QWFAoEGnqj7Xjy7+LMilJ4WpiBexGfOwWB3xoZqP71+tL8XhnFOZ
         FZtw==
X-Gm-Message-State: ABy/qLZugImKImb/RMUnsSQedD/BY1bSu+Z9ZeOAGgICyrGJDfYehjqN
	gb2uyiBrYnJWofTWY3BmlwxsGqUWYSTzmwu8AAE=
X-Google-Smtp-Source: APBJJlFV9kBJSYVRF9EQGBKu1C+CXMwjV8RCu7fEsP63WQp2AzTYHA2QQpGgUQM8ahKiOs6f6MOd6DVqYRpCYNi9MtA=
X-Received: by 2002:a25:2e45:0:b0:c6b:aef4:db27 with SMTP id
 b5-20020a252e45000000b00c6baef4db27mr12058548ybn.17.1689064298622; Tue, 11
 Jul 2023 01:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1585899.1688486184@warthog.procyon.org.uk>
In-Reply-To: <1585899.1688486184@warthog.procyon.org.uk>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Tue, 11 Jul 2023 10:31:27 +0200
Message-ID: <CAAUqJDv26FBuG+UYDc+xBYz0b8V-+eDzzLXjianmWAAo_JwvLg@mail.gmail.com>
Subject: Re: [PATCH net] crypto: af_alg: Fix merging of written data into
 spliced pages
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 5:56=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> af_alg_sendmsg() takes data-to-be-copied that's provided by write(),
> send(), sendmsg() and similar into pages that it allocates and will merge
> new data into the last page in the list, based on the value of ctx->merge=
.
>
> Now that af_alg_sendmsg() accepts MSG_SPLICE_PAGES, it adds spliced pages
> directly into the list and then incorrectly appends data to them if there=
's
> space left because ctx->merge says that it can.  This was cleared by
> af_alg_sendpage(), but that got lost.
>
> Fix this by skipping the merge if MSG_SPLICE_PAGES is specified and
> clearing ctx->merge after MSG_SPLICE_PAGES has added stuff to the list.
>
> Fixes: bf63e250c4b1 ("crypto: af_alg: Support MSG_SPLICE_PAGES")
> Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Link: https://lore.kernel.org/r/CAAUqJDvFuvms55Td1c=3DXKv6epfRnnP78438nZQ=
-JKyuCptGBiQ@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: linux-crypto@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  crypto/af_alg.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thanks for the fix! I can confirm that it fixes the reported issue.
There remains some kernel panic on s390x that I hadn't noticed in the
results earlier, but that's probably a different issue. I'll
investigate and send a report/patch when I have more information.

