Return-Path: <netdev+bounces-18987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA797759429
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5013B2817C3
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73213AD7;
	Wed, 19 Jul 2023 11:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5A12B89
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:29:10 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F010D2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:29:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so7550953a12.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689766148; x=1690370948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7swtIcIdYWVn2Adzv1VasFwIoW5vvKun9di4RLNshoo=;
        b=dgNGeLpD1hQxVnjhaGZygvGRbz8kym+m8BiJKnU0c/FtrMvX535uXcPGLPstdLXRkQ
         e4Njc97saZJpFQeawUY4/r/AJMvqODLhwImAcz0CHUPDJD4iyFgmP0kgWeA0FfGu7vE8
         2iMkWAe130MdG03VvjQE4KAy1zd4aBokiIKFaCbrI1bqgZTLTufLDDvhQnSovbi42pQc
         9sFRpBcxxZv81vs/Xgq9YuEWB4Narlaupo/3B5au2xvte9ya6ypl/1w11SDdl6O+XMyd
         9yYadDVaXYU5XMpLGK0dHAarzhonTb9UvZU3LxDuSCRfVvXGwPDSLWhXh93UBQU1BTU7
         GZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766148; x=1690370948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7swtIcIdYWVn2Adzv1VasFwIoW5vvKun9di4RLNshoo=;
        b=gxvW/sMfhhjmrxiagkgsfGJxT9cXA/+n7J31JFykFLS00oGB7LRP9+8xz1QTYoX/Gc
         YjL3Os2BEGUyMsX0wIebelAq48bqDLTzI14+T5sBxblmPsxqMTaeow4YkPU54jWkqszt
         pNWHK3VgRUWSHUqwxMuDvmyyiqKGFBgPOYJVrQQ0oVpNgAD5sdXVLCGod0/vLQtK3Ghb
         bgU9zSLDV+bfsoCAM4ZqFBdwAAP5w87rRE5y6Wt0V33AWlIwWJ0BzAuvS0JvI/v83dd7
         XJm6vXjeVoeeMEX3Ux99mchszT2mgjPyeNZ1tAyPKWVKe4f+m5x5VuCnrqtLxn4B2sK6
         H+VA==
X-Gm-Message-State: ABy/qLZulFpq++C3X914C2zodlejBLUhhTNz4rJi90ATw4gKK/Pgoxa1
	AM+uwq9t2B1UxI+KbwcotQ==
X-Google-Smtp-Source: APBJJlH466n33n0PrmVG2kOA+7Z+5QDxR3hEhWb8/fsNn8AA+5IzJ7gBl8NVPQwEtnTZwGJZu4TquQ==
X-Received: by 2002:a05:6402:1646:b0:51d:f37c:e3b0 with SMTP id s6-20020a056402164600b0051df37ce3b0mr2294734edx.11.1689766147624;
        Wed, 19 Jul 2023 04:29:07 -0700 (PDT)
Received: from p183 ([46.53.253.142])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7cf8b000000b0051df13f1d8fsm2599159edx.71.2023.07.19.04.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:29:06 -0700 (PDT)
Date: Wed, 19 Jul 2023 14:29:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: delete "<< 1U" cargo-culting
Message-ID: <2ff150de-8997-47bc-a3dd-114c60a7c912@p183>
References: <7b6fdc07-fd7c-48eb-ad17-cc5e436c065b@p183>
 <b3faaa6387edd97c93862cd6838808d051e338e6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3faaa6387edd97c93862cd6838808d051e338e6.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 12:47:50PM +0200, Paolo Abeni wrote:
> On Sat, 2023-07-15 at 13:19 +0300, Alexey Dobriyan wrote:
> > 6.5.7 §3 "Bitwise shift operators" clearly states that
> > 
> >         The type of the result is that of the promoted left operand
> > 
> > All those integer constant suffixes in the right operand are pointless,
> > delete them.
> 
> Indeed. Still this patch is quite invasive and the net benefit looks
> quite marginal - if any at all.

I have all tree converted, this is just net/ part.

Net(!) benefit is more readable code.

> Older compiler could adhere to the standard less strictly or

No, no, no. Unless there is known miscompilation I don't buy this argument.

> macro
> expansion - when the left '<<' operand is a macro argument - could be
> tricky.

But it is easy to verify that it doesn't. In theory someone could do

	__stringify(UDP_MAX_SEGMENTS)

but what are the odds.

> I think we are better of not applying this.

