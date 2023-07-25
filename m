Return-Path: <netdev+bounces-21005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B977621FD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ED7280F37
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F8263BF;
	Tue, 25 Jul 2023 19:05:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A325931
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:05:37 +0000 (UTC)
Received: from mail-ed1-x563.google.com (mail-ed1-x563.google.com [IPv6:2a00:1450:4864:20::563])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157B1BE3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:33 -0700 (PDT)
Received: by mail-ed1-x563.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso3451972a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valis-email.20221208.gappssmtp.com; s=20221208; t=1690311932; x=1690916732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP0r4j0IcslSeEvLi4VIvEKUgxIuBsi7iirT+IpCVsY=;
        b=StNcrN7rgw0b1fIemzOO0EXJtCRDYueo3NIA6KZ0C1SY4XfTx9VHaIy3lnj0j8DtSi
         8RQwca6gjWoshmOwKIU3H5fmuJDPLZ1uTyzl3jf4jRKOZ1JGnDGYFQIIv56bYx8t8YfN
         emoqYtymKUSBDTxc1lFYsXQq6Kpqo9uE0Qjx5oSj1/WEOo/5PSA2qqt2CT9CXa2KLJf3
         BHzkC4wwowkuMo8pkhaAEEqy0T7UdZpxgVPXOTWudxcKY2Esx13vWmMljg/V+EGUoCn6
         OJYbnTuA6IO2MxK04IQekhtOZiLjkhKfgUU2baq88e1mpd/9LMKN0VBtiTtxjjYSAQ0G
         Ab7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690311932; x=1690916732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP0r4j0IcslSeEvLi4VIvEKUgxIuBsi7iirT+IpCVsY=;
        b=l4bnP+xSQr4dnQ3Q8GvN3+DQz8iN1GMyamRJib0E601hG+1TFygWSfaTJFmFNDvY41
         0xfo8GID6GejkVdDatqqxTJMhqLTT251cLcapBCaIwCC1SyBHhavm0jJFeieMKww/Ceo
         o/y+52PY55y5w0IqP+VwyKDm0J7LsZSfyQOGes3TbgL0SOCrBATwf2+8GqlixteI5W7S
         Ub8KqvLxjy4cMb9Xx2xW8jA2ZbPg+TCFantMugdXirebIMP+5SwgimDESofshmpBqV9g
         IyDBK+NmU7Lrr/OYsCaA55woGXyZn3dDpyz0bSJd5dBglVuOOny8TVbPJxjZNwPx3zhs
         rk4Q==
X-Gm-Message-State: ABy/qLYDfQhDqD5mdtZgCSHkkHB3PNxBi8aS6YTy6t95p7aM+AzLTLbG
	NxSYwDYm9d2BKkgM2U04dPxA5IB+P2onQAFtq2Cb86S0P6x4SmV00TfQ
X-Google-Smtp-Source: APBJJlGx/NLx07Q9sUtEZbqBlFYfqDh9yKGGg+r0JwWwcupQjrn45gz24miqEJGLkQ/ET67YfLZmnt8BZXVZ
X-Received: by 2002:a05:6402:1854:b0:51e:d4b:3c9d with SMTP id v20-20020a056402185400b0051e0d4b3c9dmr11263464edy.23.1690311931882;
        Tue, 25 Jul 2023 12:05:31 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp-relay.gmail.com with ESMTPS id v14-20020a50954e000000b00521d8912947sm2186294eda.3.2023.07.25.12.05.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 12:05:31 -0700 (PDT)
X-Relaying-Domain: valis.email
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-986d8332f50so915789466b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:31 -0700 (PDT)
X-Received: by 2002:a17:906:3009:b0:993:e752:1a73 with SMTP id
 9-20020a170906300900b00993e7521a73mr12567243ejz.19.1690311931460; Tue, 25 Jul
 2023 12:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
In-Reply-To: <8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
From: valis <sec@valis.email>
Date: Tue, 25 Jul 2023 21:05:23 +0200
X-Gmail-Original-Message-ID: <CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
Message-ID: <CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pctammela@mojatatu.com, victor@mojatatu.com, ramdhan@starlabs.sg, 
	billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 2:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> The SoB in used here sounds really like a pseudonym, which in turn is
> not explicitly forbidden by the the process, but a is IMHO a bit
> borderline:
>
> https://elixir.bootlin.com/linux/v6.4.5/source/Documentation/process/subm=
itting-patches.rst#L415
>
> @valis: could you please re-submit this using your a more
> identificative account? You can retain the already collected acks.

Hi Paolo!

The document you quoted does not forbid pseudonyms.
In fact, it was recently updated to clarify that very fact.

You might want to take a look at this commit:

commit d4563201f33a022fc0353033d9dfeb1606a88330
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 26 11:25:04 2023 -0800

    Documentation: simplify and clarify DCO contribution example language

    Long long ago, in a more innocent time, Greg wrote the clarification fo=
r
    how the DCO should work and that you couldn't make anonymous
    contributions, because the sign-off needed to be something we could
    check back with.

    It was 2006, and nobody reacted to the wording, the whole Facebook 'rea=
l
    name' controversy was a decade in the future, and nobody even thought
    about it.  And despite the language, we've always accepted nicknames an=
d
    that language was never meant to be any kind of exclusionary wording.

    In fact, even when it became a discussion in other adjacent projects,
    apparently nobody even thought to just clarify the language in the
    kernel docs, and instead we had projects like the CNCF that had long
    discussions about it, and wrote their own clarifications [1] of it.

    Just simplify the wording to the point where it shouldn't be causing
    unnecessary angst and pain, or scare away people who go by preferred
    naming.

    Link: https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelin=
es.md
[1]
    Fixes: af45f32d25cc ("We can not allow anonymous contributions to
the kernel")
    Acked-by: Greg KH <gregkh@linuxfoundation.org>
    Acked-by: Michael Dolan <mdolan@linuxfoundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/Documentation/process/submitting-patches.rst
b/Documentation/process/submitting-patches.rst
index 7dc94555417d..fab44ae732e3 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -407,7 +407,7 @@ then you just add a line saying::

        Signed-off-by: Random J Developer <random@developer.example.org>

-using your real name (sorry, no pseudonyms or anonymous contributions.)
+using a known identity (sorry, no anonymous contributions.)


Best regards,

valis

