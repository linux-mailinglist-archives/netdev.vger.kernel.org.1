Return-Path: <netdev+bounces-28947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F333781346
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E911C210B7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E61BB24;
	Fri, 18 Aug 2023 19:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32251612B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 19:14:19 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A063A9A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:14:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40c72caec5cso54241cf.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692386057; x=1692990857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXHCjUkqoFKlzYS9KMvn3ZXtmB4Td+s6sRo0IABVIWY=;
        b=gKDWY6dlOMRMYXOYOL6u8arUvlDfwvxOpwUryZcIpiRx+xXLAT1GPfs/7wzYEvRd5v
         lSaHGtrMGEv8+sV//HvvLVVYKtzuCVatvDJzXweAE1p6cd8vl1nauVTeFJBDV23f7w7w
         OoydZ546ZpxYayW0m8Yu+jNX7s24ulRDxUE5rftyPScgevV5T77IABjIr4PLQSrSqR5B
         zrAX2NqxxDqqDIp5CDN2KDOTpH89lfBoiNaNbLjEVv/1TkYKdyAn10+U1x7C73fEso4S
         AVKma++a93l5TkobZIwpLkUA6+UfwozpGAkGnWQ8+//oq+2mbZWNQLxZ8M0KjeFsNo0l
         qGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692386057; x=1692990857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXHCjUkqoFKlzYS9KMvn3ZXtmB4Td+s6sRo0IABVIWY=;
        b=BTmNzuELVqQ/Op2P2z4BexEoLnpB0h1wavJ+sIB6uRUi6BA3UzD74Uvyqd5RnZrGqI
         uOl7Dsw7PpWlM+VdiPJA30hLJUQkKq2xETWrmh6lL523eR49lgI2zV+CfIqmnXvqGQxL
         qCrTKGtcJ97Os146sKlPgjEQ5kPBSEOdiSzW2OcliDiVXhvLNU7OozquFkJ1rTI8qrhw
         tfMIEjkSLPp5jPb2Tt8Sl0RPAnk/uN/OgLJ1rrsGT3qxQvIXhIlG5g+KyAFxN9r6aRJs
         MyoL4gTWWbqECZtw6/NZp9bcp5dZYlK5amyCE9PebmY7SkxeqQ8UqtjxL+HPOCqocqC6
         PMBw==
X-Gm-Message-State: AOJu0YzDbssxLQhmQdMg178qTaVskaSCLxjO61CWx9qvh+K0sF328Sul
	TEubAYpRH2R1HxHMRDndwHeBX4+lVfKOl4P7uZlyQg==
X-Google-Smtp-Source: AGHT+IEb7l1D6lnsbsI6Rx/NUadfQApao67W7XO8NoBwVdzBQ8PGiDIeXJspxbPwKwOkW9vHZ0zaTRxxpc5KPgskFVY=
X-Received: by 2002:a05:622a:18a1:b0:403:b6ff:c0b with SMTP id
 v33-20020a05622a18a100b00403b6ff0c0bmr341319qtc.6.1692386057235; Fri, 18 Aug
 2023 12:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818015132.2699348-1-edumazet@google.com>
In-Reply-To: <20230818015132.2699348-1-edumazet@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 18 Aug 2023 12:14:05 -0700
Message-ID: <CALvZod5NyLUV-zqd4MDMnm1Bm6Rxdfc+np+kzK7_KnSrbF=Cyg@mail.gmail.com>
Subject: Re: [PATCH net] sock: annotate data-races around prot->memory_pressure
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Abel Wu <wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 6:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> *prot->memory_pressure is read/writen locklessly, we need
> to add proper annotations.
>
> A recent commit added a new race, it is time to audit all accesses.
>
> Fixes: 2d0c88e84e48 ("sock: Fix misuse of sk_under_memory_pressure()")
> Fixes: 4d93df0abd50 ("[SCTP]: Rewrite of sctp buffer management code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Abel Wu <wuyun.abel@bytedance.com>
> Cc: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

