Return-Path: <netdev+bounces-20960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE39A76202D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE11C20F40
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4322590B;
	Tue, 25 Jul 2023 17:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D51F932
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:30:32 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8DC1FF2;
	Tue, 25 Jul 2023 10:30:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3344961b3a.3;
        Tue, 25 Jul 2023 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690306226; x=1690911026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UM3t/74KMPWdkZ3pY89+UmJpDjqGQV4OPuSMqiJoFic=;
        b=aO8Sw7vgWZRYzj1X9XMLSNpmW3c63c4K6svQY3VLUnezb+pyYbe/7bs9Muobm6gWHD
         GXaqGO17/mBD4qPn5o8imG7LP+7N7gLUHoHfrOm0af6c7Acexlww02Wwy1IC3Zq6lCdh
         m5Trsof2rqAKIxsr7Ob7FV26MxjA2Pw6cOrZpn+X8x3ZNFLQqYhWNdZ7eFRVNivjZBKC
         h0UhhdKnkt97qgd25OVVkPMNWtuDcT8kIGNMQB8RsME4BTsdIwmX0TLgiuDA7i6I3Y0J
         TapWlvx3rE0I3eVST8Yzot2nL1X2wr2Par9kPwFgACBpxbbnEVqAfrSVTU8ZD927kc0G
         HdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690306226; x=1690911026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UM3t/74KMPWdkZ3pY89+UmJpDjqGQV4OPuSMqiJoFic=;
        b=TrMMreO1MfskEv7Xx+YBzX5hjKP4tSSGsCS6zQJ7+UNMJ0VRAoPk5Ni2QQWtSVbm1B
         8g93FsuzTgk/yMCWa3LWjAnMWGdGtoaDF1Bbcy8AVkmRK7hxyRYvWxgYnW87iIjFGn7P
         XJiZ6r04PmSOC4BFI/u7svVS/RqWy57Vk9MtEcrJTiiOWiV9olz9FlnAk69puD3Pz0Fp
         13Z9Yfuv5NX9+siSNaTI3ryyiyYbVmoykzxdeE9O756IeZBocwj7Ik4afADbqK7/kFq4
         bq2mDQ1I95yF+0PXstNeXFn/TPg6gzlzYj21HDLzvWDgoYAGUrpIETiCkw+VHJModnNV
         qI5Q==
X-Gm-Message-State: ABy/qLarAxpBbYID+Vj/9uq1FqwckR0zRhHa2UfFpEScobUOuHdwarfz
	8ygDS27H5nG0p1PAZ5LZ6iM=
X-Google-Smtp-Source: APBJJlE5L20lCoh8USKSIgBGXLeO/cxoroFQWgkYJCipDM5fTPdXAUl7ktUZ4t6pZSjYMiQu+fmbzw==
X-Received: by 2002:a05:6a20:3b30:b0:137:26b9:f403 with SMTP id c48-20020a056a203b3000b0013726b9f403mr10619678pzh.49.1690306226289;
        Tue, 25 Jul 2023 10:30:26 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 13-20020aa7914d000000b00682a839d0aesm9900163pfi.112.2023.07.25.10.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:30:25 -0700 (PDT)
Message-ID: <c429298e279bd549de923deba09952e7540e534a.camel@gmail.com>
Subject: Re: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org
Date: Tue, 25 Jul 2023 10:30:24 -0700
In-Reply-To: <20230720161323.2025379-1-kuba@kernel.org>
References: <20230720161323.2025379-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-20 at 09:13 -0700, Jakub Kicinski wrote:
> page pool and XDP should not be accessed from IRQ context
> which may happen if drivers try to clean up XDP TX with
> NAPI budget of 0.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/napi.rst | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking=
/napi.rst
> index a7a047742e93..7bf7b95c4f7a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -65,15 +65,16 @@ argument - drivers can process completions for any nu=
mber of Tx
>  packets but should only process up to ``budget`` number of
>  Rx packets. Rx processing is usually much more expensive.
> =20
> -In other words, it is recommended to ignore the budget argument when
> -performing TX buffer reclamation to ensure that the reclamation is not
> -arbitrarily bounded; however, it is required to honor the budget argumen=
t
> -for RX processing.
> +In other words for Rx processing the ``budget`` argument limits how many
> +packets driver can process in a single poll. Rx specific APIs like page
> +pool or XDP cannot be used at all when ``budget`` is 0.
> +skb Tx processing should happen regardless of the ``budget``, but if
> +the argument is 0 driver cannot call any XDP (or page pool) APIs.
>=20

This isn't accurate, and I would say it is somewhat dangerous advice.
The Tx still needs to be processed regardless of if it is processing
page_pool pages or XDP pages. I agree the Rx should not be processed,
but the Tx must be processed using mechanisms that do NOT make use of
NAPI optimizations when budget is 0.

So specifically, xdp_return_frame is safe in non-NAPI Tx cleanup. The
xdp_return_frame_rx_napi is not.

Likewise there is napi_consume_skb which will use either a NAPI or non-
NAPI version of things depending on if budget is 0 or not.

For the page_pool calls there is the "allow_direct" argument that is
meant to decide between recycling in directly into the page_pool cache
or not. It should only be used in the Rx handler itself when budget is
non-zero.

I realise this was written up in response to a patch on the Mellanox
driver. Based on the patch in question it looks like they were calling
page_pool_recycle_direct outside of NAPI context. There is an explicit
warning above that function about NOT calling it outside of NAPI
context.

>  .. warning::
> =20
> -   The ``budget`` argument may be 0 if core tries to only process Tx com=
pletions
> -   and no Rx packets.
> +   The ``budget`` argument may be 0 if core tries to only process
> +   skb Tx completions and no Rx or XDP packets.
> =20
>  The poll method returns the amount of work done. If the driver still
>  has outstanding work to do (e.g. ``budget`` was exhausted)

We cannot make this distinction if both XDP and skb are processed in
the same Tx queue. Otherwise you will cause the Tx to stall and break
netpoll. If the ring is XDP only then yes, it can be skipped like what
they did in the Mellanox driver, but if it is mixed then the XDP side
of things needs to use the "safe" versions of the calls.

