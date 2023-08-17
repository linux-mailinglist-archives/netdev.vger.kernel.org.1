Return-Path: <netdev+bounces-28530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F3077FC2A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B941D2820F7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418114289;
	Thu, 17 Aug 2023 16:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF5168BA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:32:44 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5B2711
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:32:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca3311b4fso60103a34.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692289963; x=1692894763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+vwsIIkApicUDYFNS7p6Sv0nA8tfIRKAQr/UoaAwtQ=;
        b=0YyixNOhKxpiJUEKfO9Jahp9tCHjQ6Z4lZDOaoQdnQ6jXi66XBq2NQjBi9fKpsNNIu
         ivs60Nom5cM0KemUBz9E23DmOnhsMFLA7C+SpMz4G5xkvstNeFz4ZAyZAsaVrMD8biPq
         E1JKNPt6ZuB8IZ21HVzPzN4LvkuKd8jZgQiJJPUWvwHHuYew3eCBq0aHfA2xrxZLOZtI
         B4uPk3YqT7EDIwVXAh1hyrktWzRLPy5COvpoJEHpV9ClIJ8G44phSUmY5eWjw1/VeCqk
         cgMMyFbdXXawwRj36j0Fma4lVUP8XOL8/34ENz3ftQOZ05L5RXvmnxrj+VuPi5XU9gZ2
         mmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289963; x=1692894763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+vwsIIkApicUDYFNS7p6Sv0nA8tfIRKAQr/UoaAwtQ=;
        b=lPvfHbxSR8ccZPaiGankOn7bdD4jRZ148Bs0f3OMJhOGKf4Qrv63X4kbfrSROFLjHK
         LM0laMpgRf1Iyl/WR8A99v+f3H7Qdg9WVw/KzJtKWiPntpTGB/u87L0lm7lC78DAGQdT
         EFzNOk9SL15UdtocqMXhUcf3JhbbUbxejS6yxmqpjkRMdscBktb9Ika4rYC+6MwEuT+Q
         Ua/XCqp794uRG2NwhgU3/WUTyUGM8tgM6Vu9zA6A0AM/zlU94XkcuAmeFv30t5Tdu6yV
         u4XMq3bR2e0ywv6/nu+fjPnXjV4NKV1nS4zsFYEdwBaVjrpqEwonRovAuD9rRfFwtcwO
         cIOg==
X-Gm-Message-State: AOJu0YwIW9xQt8Msf2X+W3kfCg+XVTVuM66BRif62VanCVSi6l7hRATq
	b8i4/fNbnXitITdnkgm5SO8kNxPTHYWSVOJ/uT9bVQ==
X-Google-Smtp-Source: AGHT+IFPKWksr+unyACwxPrN7wNn2ejufDgCpn6okIOqLFHF2UUxRjKicoGsY0oujrUyX1uKwjOQG70DCbI0QT1/t/U=
X-Received: by 2002:a05:6358:9916:b0:129:c50d:6a37 with SMTP id
 w22-20020a056358991600b00129c50d6a37mr6032724rwa.16.1692289962822; Thu, 17
 Aug 2023 09:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZN5DvRyq6JNz20l1@work>
In-Reply-To: <ZN5DvRyq6JNz20l1@work>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 17 Aug 2023 12:32:31 -0400
Message-ID: <CAM0EoMmK0VK1=5SSHVm28zz2CUCamxJPXNukehqY955uP17VPQ@mail.gmail.com>
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 11:57=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Replace struct_size() with sizeof(), and avoid allocating 8 too many
> bytes.
>
> The following difference in binary output is expected and reflects the
> desired change:
>
> | net/sched/cls_u32.o
> | @@ -6148,7 +6148,7 @@
> | include/linux/slab.h:599
> |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> |-    2cfc:      mov    $0x98,%edx
> |+    2cfc:      mov    $0x90,%edx
>
> Fixes: d61491a51f7e ("net/sched: cls_u32: Replace one-element array with =
flexible-array member")
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98=
@kernel.org/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/sched/cls_u32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index da4c179a4d41..6663e971a13e 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -366,7 +366,7 @@ static int u32_init(struct tcf_proto *tp)
>         idr_init(&root_ht->handle_idr);
>
>         if (tp_c =3D=3D NULL) {
> -               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KER=
NEL);
> +               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
>                 if (tp_c =3D=3D NULL) {
>                         kfree(root_ht);
>                         return -ENOBUFS;


LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> 2.34.1
>

