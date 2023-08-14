Return-Path: <netdev+bounces-27478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F377C202
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5F81C20B9A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F52DDC4;
	Mon, 14 Aug 2023 21:01:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E0DDA3
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:01:40 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7BC1718
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:01:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26b5e737191so745547a91.2
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692046873; x=1692651673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnOqfXebl5dRNUljflWYEjtYdatKhTnC4hi2EDyy3rE=;
        b=f+mEmzgNuQSxLlf1UxAtmo6Xr2Chh74/KT2SGtB4Uyic5HM7yZZU1RBC10Kl8xqQ/W
         02J31pTYLLLGXokaE7rm/p7zFgPiBbeXCfyrNz8Jna9t2q9JeLKRFoK53nF241hyOkoo
         0ckUDmz5DEwchQ+H5W4az68Ntwo/6ZvAPVhTPHVedPrVYIF6g5ZykgeS8IsgvPInsL6N
         Yfte/JwM7v0eODQ/sucspVhNQbDL/F6r/HywLGUEiKXCOdOAvCfmEkAs+ptoQUSCoDoP
         U2/B0a/Kq+5r/Yom0IqKkkVvB8pdgl6JMsV/fExMwTYhdsGmQs1ahycGJl2W/EX0C7Ue
         z6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046873; x=1692651673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnOqfXebl5dRNUljflWYEjtYdatKhTnC4hi2EDyy3rE=;
        b=ivLKUFGoU8VATZmRuJaMcQ3fEJn+ZRZVlEgW2LbmaSMX0aHLcavdHzOyQBy2D1fJG7
         MwJTcLr+hrMsS9gc38DLCBT3YqUKSGHmFL0wS2TJLs8GGc7tzy1gOAw3RoSM+H+RLYDo
         /PnxzkK3ra8Dr6DX5rcUmeBXSRrwaTnMOpghD3vLww9PEEC3DA8P6jPbiZOQZSMhJxSC
         T+ino53M76UpayrtK8YBQNrbynJPU0LSIrVnaDTqlvH3I+NqlLOnIYkRTopN+xAEDAGB
         D2ZfLiKJxfzK/m6OYC6bwEGArDntWsu3tFLT0LJ/V0aRVOnpLDynBc/p7gXxVWa9LUDL
         g6Wg==
X-Gm-Message-State: AOJu0YxO6zOmXNP+4SEhFNb0vdmakQQu+QX+Xur88u+puA59I/bmwoQr
	8o0ei1oHr8hIpCHLDb/tdrgRyw==
X-Google-Smtp-Source: AGHT+IHKNceQUmeAFhyH23LTGWMQK0GUOJmI4GMnK7wvaQ5bf2A5drLHyKcLWNJ7Ia+S/WbNSTQ+Yw==
X-Received: by 2002:a17:90a:e584:b0:267:f758:15d4 with SMTP id g4-20020a17090ae58400b00267f75815d4mr6835511pjz.48.1692046872860;
        Mon, 14 Aug 2023 14:01:12 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id gk18-20020a17090b119200b00263ba6a248bsm10469478pjb.1.2023.08.14.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:01:12 -0700 (PDT)
Date: Mon, 14 Aug 2023 14:01:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?RnJhbsOnb2lz?= Michel <francois.michel@uclouvain.be>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] [PATCH 2/3] netem: allow using a seeded
 PRNG for generating random losses
Message-ID: <20230814140110.0b35eb8b@hermes.local>
In-Reply-To: <dffa41e5-cde3-5b88-9539-9c03d9e10807@uclouvain.be>
References: <20230814023147.1389074-1-francois.michel@uclouvain.be>
	<20230814023147.1389074-3-francois.michel@uclouvain.be>
	<20230814084907.18c339c2@hermes.local>
	<dffa41e5-cde3-5b88-9539-9c03d9e10807@uclouvain.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 14 Aug 2023 22:14:53 +0200
Fran=C3=A7ois Michel <francois.michel@uclouvain.be> wrote:

> Thank you very much for your comment.
>=20
> I do not use prandom_u32_state() directly in order to ensure
> that the original netem behaviour is preserved when no seed is specified.
>=20
> But I agree that it would be cleaner to directly use prandom_u32_state()=
=20
> instead of get_random_u32(), if we are sure that we won't have problems=20
> (e.g. short prng cycles) with the randomly generated seeds when no seed=20
> is explicitly provided. If it is okay, then
> I don't see a reason to not use prandom_u32_state() directly.
>=20
> I'll make an update of the patch taking these comments into account and=20
> simplifying the patch.
>=20
> Thank you !
>=20
> Fran=C3=A7ois

Older versions of netem had prandom_u32_state() equivalent built inside.
The code was split out later to be usable in other places.
Over time, get_random_u32() was added because it was more random and
there were calls to unify random number usage.

The prandom was based on Tausworthe to have good long simulation cycles
and reasonable performance.

Going back to prandom always is good idea, since get_random_u32()
has addition locking and batched entropy which netem really doesn't need/wa=
nt.




