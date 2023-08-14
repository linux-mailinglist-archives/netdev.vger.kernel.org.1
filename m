Return-Path: <netdev+bounces-27405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B177BD65
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C76F28114B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF8C2F5;
	Mon, 14 Aug 2023 15:49:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB5C2C1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:49:12 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8BE4
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:49:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so3019937b3a.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692028150; x=1692632950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYiTF3LUp//kvce+GMZR6GgGsS/cIG7u9YAsbVgnE+s=;
        b=FoBT58iuObS+7FtaiTCVYKf0gb58OCOL9TQyNx59olDICau3OkAaiZU3R11DH8AgqS
         WY5Z38rWUcf6/SrYBiQiDZ61rdcYGQwl3hJSHu//WPlfKoq4w8iJJbdMElqGbrG3CTmv
         ZwdTCCcv30/xj3GL5qzO6V50yEhhPKbmVI7jmOtqDUEnDtWvRY1I1F6WI2S2TdJTDPdb
         ijBLvH1T3EysM8lHMQknd56GY02j9mJo0At4XDe6rI76hAMhKldgwwcSzL/XKKlvcLhR
         LaYBbrftKSEkz9EsS2FCgItLbXecNjouDuYzTtVEUSIQqQIbJUdgeHZHB39x/6g7u58q
         xXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028150; x=1692632950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYiTF3LUp//kvce+GMZR6GgGsS/cIG7u9YAsbVgnE+s=;
        b=bow0NakonOY0Zkx0Ytf0rm5tFNFNpZ6cCGo0xdeXm7NOk0dzYV5Y0Ui3meO5cA6G+r
         a/K4JMigQ+uNxRsB+1sVgMN7Rn1PJHHPygp2wypDdDulKoxXz43zIyccJbQ0D+av2IOS
         dOp3hxvV3CXXRQTlNEOoTEW8zAFgQgcyyGuLPxQepTvW3iMCGuSvvGLKD+vOQigEuRX5
         5nNN03N4u6F5eC21OQRCrYYuJx4cI0KPk4FrI+TzbpuMPcaCc31CDPjwX1NqgU2lJbag
         OeULm5OOfN1aAmcuQdnTA0b62qbxrDfY80rqMNv37r3QuiVM+sLZGkkvHK8AgP8C9zW8
         4b1g==
X-Gm-Message-State: AOJu0YxDxeEABBMv96Bm8wrJXHSocV06g9OCX9knRfoDAKaRsVtJ/r2J
	/MrvJ+olSWT24K8joty6L3QzQw==
X-Google-Smtp-Source: AGHT+IHDRkUwKePnso/znzWYdzs8w4Ckkub/nNx11D5ZuAZF7ZXCNDr91URmH2E26oA10zI+aZPFCQ==
X-Received: by 2002:a05:6a20:8406:b0:140:ef2a:9b75 with SMTP id c6-20020a056a20840600b00140ef2a9b75mr11090240pzd.61.1692028150113;
        Mon, 14 Aug 2023 08:49:10 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id l4-20020a639844000000b00565b8e0798csm2462389pgo.57.2023.08.14.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:49:09 -0700 (PDT)
Date: Mon, 14 Aug 2023 08:49:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Francois Michel <francois.michel@uclouvain.be>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] [PATCH 2/3] netem: allow using a seeded
 PRNG for generating random losses
Message-ID: <20230814084907.18c339c2@hermes.local>
In-Reply-To: <20230814023147.1389074-3-francois.michel@uclouvain.be>
References: <20230814023147.1389074-1-francois.michel@uclouvain.be>
	<20230814023147.1389074-3-francois.michel@uclouvain.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 14 Aug 2023 04:31:39 +0200
Francois Michel <francois.michel@uclouvain.be> wrote:

> +/* netem_get_random_u32 - polls a new random 32-bits integer from
> + * the prng.
> + * Uses a deterministic seeded prng if p->deterministic_rng is true.
> + * Uses get_random_u32() underneath if p is NULL or if p->deterministic_=
rng
> + * is false.
> + */
> +static u32 netem_get_random_u32(struct prng *p)

Overall I am fine with this patch, but the function name is getting excessi=
vely
long. It is a local function, so no need for netem_ prefix.

Checking for p =3D=3D NULL is redundant, all callers are passing a valid po=
inter.

For logical consistency, put the new wrapper before init_crandom() and afte=
r netem_skb_cb().

Since this is not security related, the change could also be simplified to =
just
always prandom_u32_state() and initialize the state on first use with eithe=
r=20
get_random or provided seed.  This would also simplify the code around stor=
ing
original seed and boolean.

Reminds me of the quote attributed to Mark Twain:
=E2=80=9CI apologize for such a long letter - I didn't have time to write a=
 short one.=E2=80=9D

