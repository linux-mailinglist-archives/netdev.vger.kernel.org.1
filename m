Return-Path: <netdev+bounces-15801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685A749E33
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C70428130D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA69449;
	Thu,  6 Jul 2023 13:53:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB269440
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 13:53:04 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0934719B2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 06:53:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4036bd4fff1so314361cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688651582; x=1691243582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qXU7DJbvjvp8NOnfG/RtU8czB/tGMFzNKlo2sF77yk=;
        b=nkmLRa2pG3dc3VLFpHILMirKPgPoNY54hkVz8PeM2OoGejIvRWxpwCptjKTq4O0dTc
         Z08GqFf4YHbLuk4dVrCBmJjJ/1gIt+3hgBmmVd5bY0THo+Sv+F54hp68Uut0lusV4GJk
         nncuaqjV/mMdCpBmZSAmnPTECnwJQlAlBv8IyouM8Cw/Qo8g4wTRY/+MWYGA/LEi06fH
         j2XgvciunqOPOWcdHS20kC2P14BEuTlAeJov9u4QyBujIknokgyTANi73exvzQseF8VV
         IdQK1NaF9ijSCGleRo5pLVWeQj32eohJRe7w0ipkYCMVK9H1bDflBGf5ShY5F9RbqyED
         9MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651582; x=1691243582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qXU7DJbvjvp8NOnfG/RtU8czB/tGMFzNKlo2sF77yk=;
        b=RJbJodt2jhbGnoWQx5fSgKQn3S43n7XQK5XU0vGdw+NRnAxWQSAO3wbU3BsAOXJ+Q/
         C/o1UMLP2DU73VMbr9Au7SfjABdwU9CWK99tE7eoFBpAkVl5WAIkFA3aPUpIYKM53j8W
         r6FSUUEhbVr1YMlzRRMBfNZK4s9GxMak8SLecTCJkhUhYMA9suovTRWvkkslSIAt+5qu
         pq3n0bUJivSqhJPNqLnI27NXlJ34s9rvmQJV4HTlZdWjTMNylYUU6Dbg9NPEysqKIKgN
         Y2eonB248qFuC+r9Q1nDD0M/9UDCi/ePmj35uwDIX0UtoH4LvPC2EN0wveT8KG1W/sS3
         Jo2Q==
X-Gm-Message-State: ABy/qLatT20xHYJblQ1NzZMKLIVJXiJd2DwTWprV9YGyatgPrXXs6rXt
	R/t0PaoHoD9Oc/2eTzx8HQ/sQPG7vXmp2PzNXMfAWQ==
X-Google-Smtp-Source: APBJJlFALeU9HSen3KdmHCQrxo9kEwHDHomQmFVFUZWi0ZAX+HQA+FZala5YK6bqPhBOMR+kOF2CDd4kL0r6xVne0pE=
X-Received: by 2002:a05:622a:1789:b0:3e0:c2dd:fd29 with SMTP id
 s9-20020a05622a178900b003e0c2ddfd29mr212250qtk.4.1688651581998; Thu, 06 Jul
 2023 06:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706130800.85963-1-squirrel.prog@gmail.com>
In-Reply-To: <20230706130800.85963-1-squirrel.prog@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jul 2023 15:52:50 +0200
Message-ID: <CANn89iKxGVDQba1UCbpYKhNo=rZXuN2j=610DbJx0z=kWa7N3w@mail.gmail.com>
Subject: Re: [PATCH] gro: check returned skb of napi_frags_skb() against NULL
To: Kaiyu Zhang <squirrel.prog@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 3:08=E2=80=AFPM Kaiyu Zhang <squirrel.prog@gmail.com=
> wrote:
>
> Some rogue network adapter and their driver pass bad skbs to GRO.
> napi_frags_skb() detects this, drops these bad skbs, and return NULL
> to napi_gro_frags(), which does not check returned skb against NULL
> and access it. This results in a kernel crash.
>
> A better approach to address these bad skbs would be to issue some
> warnings and drop them, which napi_frags_skb() already does, and
> move on without crashing the kernel.
>

Certainly not.

We are not going to try to be nice to buggy drivers.

Please fix the "rogue network adapter" instead.

