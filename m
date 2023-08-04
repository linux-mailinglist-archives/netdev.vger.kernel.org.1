Return-Path: <netdev+bounces-24497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9A770615
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849E81C218D3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F39C15C;
	Fri,  4 Aug 2023 16:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1A34CC7
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:32:25 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C54946B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:32:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40ffbc3488eso1990871cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691166743; x=1691771543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gT54qgeEYngYTihQDJO08HO0KSWygFTy5CQcWKvL0Ek=;
        b=Z9AJnt6pZOtM0YkgWmwF+Qr51VRkSL5FTiRGsZAAi4WvjJ273A2yVrbNXLfyOqu0yA
         UGxqJ/yk04b1An2gumgjmdJPHhgc3QZJDyOzkNJVGwPBvUeqp312/8eiawO11bKkcU56
         GUsRjOwFT/qFKujJxuDoRIIM2Hew8ziHZF+wak1CvVW62bMe1BTnUXx4d0ftR20WKWNp
         OaKJ/7o6k+g4Wp5/me7vcNgqWqlHQPIlsnL0SzHW7+P7i3SBMBdoqxDwkcIuxAhMDXZO
         Uf0tJn9abyQ8g3QF4aefJgb/obf3GzZVm3SiVIiAAQIKfGwvfR3I7DKUV5fTMPe2rHOc
         y5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166743; x=1691771543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT54qgeEYngYTihQDJO08HO0KSWygFTy5CQcWKvL0Ek=;
        b=QNXh3kcxY1GxTwl6ff8EFS7Wc2OPMdm0ZVu0TEZ9KBELmGPD5311+JYqn2TYBHbGnT
         BS3eicDJtSC0tRvlL6PO2sCwgQe5YmaJJOfu9P7rkaWPcjkigVPDVkuBSF1bbpCE8NFm
         4cX3vSlLQxzSvB09rH0bWAIeRpk2QK6lFKP1546Hw30pjbroI0RQ5jy93piUlNAES7+x
         39c7axHtd/T86iGm4TlNCCksM/AuzbcIV4Js7xgmwu905xM31xoGtFlUEuR+1xYSLknx
         0smlujMBaxoUfy+bKxHuL7WolRePDRC5mo1FOpIGze25Z3wjh/+u8fnh4QebtqhBr/kp
         9NKA==
X-Gm-Message-State: AOJu0YyuAoGfqWeFAjo7dfRPvjqdgmbGzBRHWQQ675LFbuy2Sai62uZK
	lGLY9jlMjT2AZVA/ZvAQU94=
X-Google-Smtp-Source: AGHT+IFJClDYxxw++f4c1URlrJk6KPDBVitvq2ChETsFH7kTfGomAT76FeOZcxtr3Whk8YLHM+Jtbw==
X-Received: by 2002:a05:622a:d1:b0:3ff:3018:8d9c with SMTP id p17-20020a05622a00d100b003ff30188d9cmr2915131qtw.17.1691166743027;
        Fri, 04 Aug 2023 09:32:23 -0700 (PDT)
Received: from luigi.stachecki.net (pool-98-113-30-64.nycmny.fios.verizon.net. [98.113.30.64])
        by smtp.gmail.com with ESMTPSA id j2-20020ac84c82000000b003f3937c16c4sm768850qtv.5.2023.08.04.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:32:22 -0700 (PDT)
Date: Fri, 4 Aug 2023 12:32:19 -0400
From: Tyler Stachecki <stachecki.tyler@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, Martin Habets <habetsm.xilinx@gmail.com>
Subject: Re: [RFC PATCH net] net-gro: restore check for NULL skb in
 napi_gro_frags
Message-ID: <ZM0oE98EpPgAilda@luigi.stachecki.net>
References: <20230802092340.9640-1-edward.cree@amd.com>
 <ZM0M7UgvMPFmDfie@luigi.stachecki.net>
 <CANn89i+VYvOrXPFNgqKjTJ+EeMUngXrVzoppynkn2HBnYAdqEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+VYvOrXPFNgqKjTJ+EeMUngXrVzoppynkn2HBnYAdqEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 04:45:13PM +0200, Eric Dumazet wrote:
> This is already done, a compiler should already infer this from this code:
> 
> if (unlikely(skb_gro_header_hard(skb, hlen))) {
>     eth = skb_gro_header_slow(skb, hlen, 0);
>     if (unlikely(!eth)) {
>         net_warn_ratelimited("%s: dropping impossible skb from %s\n",
>                                            __func__, napi->dev->name);
>         napi_reuse_skb(napi, skb);
>         return NULL;
>     }

It is a good point - though, FWIW, at least with clang-16 I am observing that
it does not leverage this fact (fully?). Mostly for my own curiosity, I took a
look...

In both cases, the generated code for the NULL check is emitted as a a forward
branch, meaning that (at least on x86), the branch direction hint is rendered
as desired.

However, without unlikely(...), the code for the taken branch is clumped
roughly after the inlined code for napi_frags_finish and before the (hot paths
of) napi_frags_skb.

With unlikely added, the code for the taken NULL check is seated right next to
the code generated for the unlikely paths in your comment. So, it does seem to
have an effect, however minor!

---

Anyways: perhaps the more important note here is that, at least with clang-16,
I can confirm that everything is still inlined with this change.

