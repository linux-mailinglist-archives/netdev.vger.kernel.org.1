Return-Path: <netdev+bounces-30737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C587C788C67
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08C28188C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424121079A;
	Fri, 25 Aug 2023 15:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630410791
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:26:25 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4F2134
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:26:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bb29dc715bso11266145ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692977184; x=1693581984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uT9B5IhwSieTS/lycgAO9B5cbkxabumJT7OeFCsXGMk=;
        b=vvVTkRT+VuK5043ahLb/u/zj4f8sB0vqgAunodyYuRhNLeufoefzhoe4WNJFWBlqnT
         fOjWSwwVNPHbk3edqUSOVA+XxAEjDCKjxs3HxwUIlookvW4KiCnYLFtt1qTalqSJOVGF
         sScsGhUtVxEoQK15lzMQlLomYBvjcE2Sz4k/e1Oy+HS/9hhEtZcDcaVdaQEeyjXxZh3R
         TzsVUTWd7XZcUj1STnMDvCZ5q8x5tT67ioP2DbuxoS8Xvt4bmsdKfkLeTHrNoo93HISk
         V1NYfBP6/ZvZCCCq3TieE6qyCIY3XWbSHhfJP0iP2R+QQbrK8/8rYTZUS4Q+EnvzC4ai
         inOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977184; x=1693581984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT9B5IhwSieTS/lycgAO9B5cbkxabumJT7OeFCsXGMk=;
        b=gYq44WjEBqtsWpyxkF+ARNe7y5UbuefscOcWSUtx6vV0+vaFPltdWA4YaoEU9zLLNY
         P0lqxCE5nFofLCCELbZ6psJXldD4vvVCpkjK13dzoZd/ODcjfaJUqT+b8e1RXYVQO/Sv
         3alCsUmKdHbB3j1fUxFyn77kN2oitbGHNcZIZN504TAf18PPH2nJNw3fmA3Up8zWWaoa
         bjzh7gHszDNNEdV6bf6k5i840IkdRg4G4Ql1fA3HLi/HbWfHZlGKdrchyz61GhtDPMSg
         ZfqC9bIJPSjbzK7oEq3w9Yf2n87qVkSE2aEN2IpwWyF+t2DkC16O1KA7k6P/tPxOssCQ
         tc2w==
X-Gm-Message-State: AOJu0YxUZU3A3HswX9NBJT4OHYFM1GPxoBfVnLCUlXOszi0XWqCQ6Wgz
	CladZ4nMxOEP0RGrkkYz1ConRpW/wiY=
X-Google-Smtp-Source: AGHT+IHBe26z5RAiUFUIi9mr/ywY4xvfcSUx9IiaElkVhEpKpN2zZSyFkiUVw2XIEkVi8AWhgt40SvUlcq8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e801:b0:1bc:4452:59c4 with SMTP id
 u1-20020a170902e80100b001bc445259c4mr7073353plg.4.1692977184048; Fri, 25 Aug
 2023 08:26:24 -0700 (PDT)
Date: Fri, 25 Aug 2023 08:26:22 -0700
In-Reply-To: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
Message-ID: <ZOjIHo2A6HZ8K4Qp@google.com>
Subject: Re: [PATCH v2 1/2] selftests: Provide local define of min() and max()
From: Sean Christopherson <seanjc@google.com>
To: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc: keescook@chromium.org, edumazet@google.com, 
	willemdebruijn.kernel@gmail.com, wad@chromium.org, luto@amacapital.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	shuah@kernel.org, pabeni@redhat.com, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org, 
	David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023, Mahmoud Maatuq wrote:
> to avoid manual calculation of min and max values
> and fix coccinelle warnings such WARNING opportunity for min()/max()
> adding one common definition that could be used in multiple files
> under selftests.
> there are also some defines for min/max scattered locally inside sources
> under selftests.
> this also prepares for cleaning up those redundant defines and include
> kselftest.h instead.
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> Suggested-by: David Laight <David.Laight@aculab.com>
> ---
> changes in v2:
> redefine min/max in a more strict way to avoid 
> signedness mismatch and multiple evaluation.
> is_signed_type() moved from selftests/kselftest_harness.h 
> to selftests/kselftest.h.
> ---
>  tools/testing/selftests/kselftest.h         | 24 +++++++++++++++++++++

Heh, reminds me of https://xkcd.com/927.

All of these #defines are available in tools/include/linux/kernel.h, and it's
trivially easy for selftests to add all of tools/include to their include path.
I don't see any reason for the selftests framework to define yet another version,
just fix the individual tests.

