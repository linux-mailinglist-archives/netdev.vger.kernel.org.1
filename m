Return-Path: <netdev+bounces-23756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D876D62C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34430281D96
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB0100D6;
	Wed,  2 Aug 2023 17:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE48DF58
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:55:30 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649F9C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:55:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cfe6e0c32so576236d6.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690998924; x=1691603724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoQ9QQBh3aNb5HAI8gb3WGWfLp4PhO0tFoxt1vgia60=;
        b=Q6P7YDb36YHTIT0J9J3mRC0xO/oM72diYAGVE7wD9ZrpTSgrRwMkpx6qVc3FNK/2Pn
         NUoLOyN5EysVLEw9KnReNoTXT1TQmvu/EeFjSPIPW4VXIHL3EQDOE7WQ3yXUa1FrC/q9
         SLdeuv1arpwmrKZHc+UXMvhgn6GtH/o6AGUfCqeO5D8DLkc9oT1MlWzSXTycAZmzBBuY
         3o5K/9EM7UZ1IoLeFl2zlLP+kQSS7ajteuX+ugpeIRpRriPMJeWFXa31Myc1VRBHmzPc
         Sd1+kJajsbenswNhz61a/cWYqHt4VZPzpbfJ9epJWbFXZ/2d8xv7i2rW2Sf190ta7Xkt
         Sc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998924; x=1691603724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoQ9QQBh3aNb5HAI8gb3WGWfLp4PhO0tFoxt1vgia60=;
        b=czmXEo7or7uL+JPJdaYB4pOlEWIMf+W8ZdMXVybIGTsd3IQ10ExXX3GXxo3cpwGbyk
         BMGlJq8zcw+cns6PP1iJ6xKWPYr0lMlqSOQUNx2H0F/Nj/yLS7r57d9xPlASk59dSfoL
         c8qnL5FJPUmV0b9hQKjsajT6kpMRKbWlEsvx2nVjMAJq5eXFKKTppCypYSclwKkxitYu
         WicwoNp7xAvWbOU03S/E1/NKoZj3a2faavJg9e71qf7XmIvAOxWgNas4nkWYHdW1aXPR
         QIApHCoyExWT0fyCRsHIBd1/ybPisGV9okuvk46g6YBdLFTa6/KsEKWs4uZJH/VdpuAE
         97vQ==
X-Gm-Message-State: ABy/qLYAJnYEr7nE9S3sR8j8Rx8UZ7Tcz8sdCRYNNSqFm4HYGgWUCYbP
	r7e4FalRUVANG3xPpvCJjvJk+MzpxRYAXKn3xAsKXg==
X-Google-Smtp-Source: APBJJlFXbcDAluXzkimyBCOpTg/tYoevL512peHPLiVSwrCaU15QF3ls/Tpp4KxMI08oy/Wr6Kb//rNAL8a2uSaqlHw=
X-Received: by 2002:a05:6214:21a9:b0:63d:2369:6c41 with SMTP id
 t9-20020a05621421a900b0063d23696c41mr20837155qvc.55.1690998924158; Wed, 02
 Aug 2023 10:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802-fix-dsp_cmx_send-cfi-failure-v1-1-2f2e79b0178d@kernel.org>
In-Reply-To: <20230802-fix-dsp_cmx_send-cfi-failure-v1-1-2f2e79b0178d@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 2 Aug 2023 10:54:47 -0700
Message-ID: <CABCJKud-ve+6v5h1QeDwUm4q7XzuhMorDTwAGmsV4h-R+0MKxg@mail.gmail.com>
Subject: Re: [PATCH] mISDN: Update parameter type of dsp_cmx_send()
To: Nathan Chancellor <nathan@kernel.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, keescook@chromium.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Nathan,

On Wed, Aug 2, 2023 at 10:40=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> When booting a kernel with CONFIG_MISDN_DSP=3Dy and CONFIG_CFI_CLANG=3Dy,
> there is a failure when dsp_cmx_send() is called indirectly from
> call_timer_fn():
>
>   [    0.371412] CFI failure at call_timer_fn+0x2f/0x150 (target: dsp_cmx=
_send+0x0/0x530; expected type: 0x92ada1e9)
>
> The function pointer prototype that call_timer_fn() expects is
>
>   void (*fn)(struct timer_list *)
>
> whereas dsp_cmx_send() has a parameter type of 'void *', which causes
> the control flow integrity checks to fail because the parameter types do
> not match.
>
> Change dsp_cmx_send()'s parameter type to be 'struct timer_list' to
> match the expected prototype. The argument is unused anyways, so this
> has no functional change, aside from avoiding the CFI failure.

Looks correct to me, thanks for fixing this!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

