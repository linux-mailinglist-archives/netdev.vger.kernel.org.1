Return-Path: <netdev+bounces-34651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980A7A514E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0677B1C20AFE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650CA266D1;
	Mon, 18 Sep 2023 17:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2838FB7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:55:33 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC19FD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:55:32 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-495d687b138so1701444e0c.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059731; x=1695664531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or5c27IBRGsyVefv3xNP6D4kn8Jm9xz9lhtSWISxfZ8=;
        b=aMtBMYP6PLWrBrNGDGw5nwz2bRTwXUqXn4Hcqn6p6G0BUSFNCksqc9KLPbq8UtVfqy
         xlklIXyLBt3mfV1ieSqaMRVn/cxSIGTSGggck5xJlYAEXxrul+FIklEm/0zzuHY1Ox+k
         him6eEVxVdLMEe4JJawwyeSGKuDiEDBzuUJ+j4cdxBLZTn8y/UeU6xDJF9gU8eTKYqJj
         LhMAi/1P8p+E604rqFUtJ+cRGNzyNHPxfCGFEfGT1TUog0UmBxXXtdWuJQsfaC3sx2yi
         s/FSuT6Wp5e2l/O99ExOm8X/D/yLlWrDkk9PctAVRA9HA6BYTE35yd7ze8inpN6JWd12
         GCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059731; x=1695664531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or5c27IBRGsyVefv3xNP6D4kn8Jm9xz9lhtSWISxfZ8=;
        b=p517tge2lz3wyc1QVBKc5wtmaO13IPIWrBWpmfapHDyCbr0UkYdv7Pm65ogu7CdQSj
         yS2kNxcpdCDCCaEvsjtY4tBJuTCedSzVbUNOirZyY/R76jodxX9HwaTti3ukEV013lfg
         yA60c7S24IjWofKvMnMUnqJ0bW5RST4iCcFii5ipzz6DREDqfLLcXU8MeMPdgulWXsZx
         PLK3XBAifDJ/VuZwILAXraVKshSLOb2VV44vXsp4w/+JaZ7rf1qNE4+JiDQ8wjQgjyp7
         41YFHUW1Ld6LKBpAHhNC+hCzHiNYtdnM9QvVH2x9Av3a4sPRCyY+VLaAPabiOlZXpfqn
         cAAQ==
X-Gm-Message-State: AOJu0YxvnIwyxaPANiG4MLY/3hN7Qy90sebAcNc4DKmci7PGroQSuja0
	Ezs/8Gq4O1vHuZkX3f/c6Fj3SrZr2ttSNyKHVbg=
X-Google-Smtp-Source: AGHT+IGfO9X8FSzjI1PihyAA/O4gBEBtw8leKxbrT27jxlvTKYYNfSQcaLN9x4Q3HMP1nk8NKj+uRYU39bkfsp4cZUY=
X-Received: by 2002:ac5:c907:0:b0:496:a6cc:7ffe with SMTP id
 t7-20020ac5c907000000b00496a6cc7ffemr1963560vkl.13.1695059731316; Mon, 18 Sep
 2023 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-2-jrife@google.com>
 <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com> <CADKFtnQnOnaq_3_o5OoWpuMvzTgzL2qKcY5oc=AbdZJvONSyKQ@mail.gmail.com>
In-Reply-To: <CADKFtnQnOnaq_3_o5OoWpuMvzTgzL2qKcY5oc=AbdZJvONSyKQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Sep 2023 13:54:54 -0400
Message-ID: <CAF=yD-+DmargLvi=i-YJ6JCJov8xYEbyQf8+KhQ00UTYry_9UQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 1:52=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > You used this short-hand to avoid having to update all callers to sock_=
sendmsg to __kernel_sendmsg?
>
> Sorry about that, I misunderstood the intent. I'm fine with
> introducing a new function, doing the address copy there, and
> replacing all calls to sock_sendmsg with this wrapper. One thought on
> the naming though,
>
> To me the "__" prefix seems out of place for a function meant as a
> public interface. Some possible alternatives:
>
> 1) Rename the current kernel_sendmsg() function to
> kernel_sendmsg_kvec() and name  our new function kernel_sendmsg(). To
> me this makes some sense, considering the new function is the more
> generic of the two, and the existing kernel_sendmsg() specifically
> accepts "struct kvec".
> 2) Same as #1, but drop the old kernel_sendmsg() function instead of
> renaming it. Adapt all calls to the old kernel_sendmsg() to fit the
> new kernel_sendmsg() (this amounts to adding a
> iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size); call in
> each spot before kernel_sendmsg() is called.

Thanks. Fair points.

Of the two proposals, I think the first is preferable, as it avoids
some non-trivial open coding in multiple callers.

