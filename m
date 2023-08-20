Return-Path: <netdev+bounces-29166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4477781E7D
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212741C204AB
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE05612A;
	Sun, 20 Aug 2023 15:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09D568E
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 15:19:54 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA17E8;
	Sun, 20 Aug 2023 08:15:02 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a751d2e6ecso2006793b6e.0;
        Sun, 20 Aug 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692544502; x=1693149302;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hSZIhmkHGzjNtkdqhrKis5XPDMMe45VDbgxuLxmNpc=;
        b=afk2Ucb3vmpuLfYssTTfFt+0EA6p/DPQhSYRmg91/OavyjhqQLYy8dJCwNgvKd02G6
         NqUhAB/BPDYPlu7A2iIF9Jlw7nbstwks0mJ0wOZtOOcmWwM+MOkgWUQAti3VZ3+TLNyP
         1todpDNBj42CVsA4XmZg4np6e8nXYKnIAqpSL8hnWotP5betbKeaxajgHd6jy3qLzCgF
         Ws1RiKIn+OAqjeI5HTz49Frkciwr8UjaLbE3EB6QccxVogvQTeeBGmJVmyscFbNzAQgr
         +QMIbFOYGaxCEMk0I7EsB2c12qfhFi8rqoShfqo+NHNuqnGhzz1ilynNjRZCVdN64uTd
         9kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544502; x=1693149302;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/hSZIhmkHGzjNtkdqhrKis5XPDMMe45VDbgxuLxmNpc=;
        b=e/yQ93bwmK/GzJbs1p6SQsN60fTVMKkw1k8c5WT6V3JVYvxZqQ8UIaCgDBdcZmSeWQ
         uigf46uuteGrXTMRfg1YjhHgd+6ZFsdOlR0aQqDEHSN+n0FG5E0eFGOeRyowfp73cipK
         L7RhfHL62KS1jPqr7JwBWtn4NYmeieUggLhAIuvwn7BHygAqxsUMlfveQdLEtVKgxx2u
         GPRvd5cVKtDQt4mTXTrBfmjhR6plexXfTisJP32s09azwbozvU5LuU05pr2SgUbm/Rbb
         Wfsvr7KVLzIfQIwPzvb9MwBGBXcTUeTh2i8Rf+i8uT0dGU80VTjvrvWRKxURV5lgmHE1
         susg==
X-Gm-Message-State: AOJu0YzjRPdulzfRfZ4V0ElkTUkJSRoAT2bVImylUMLkFmLLKs3bDFjj
	yIG5MOa3Zz+zoPrJJRMPw+E=
X-Google-Smtp-Source: AGHT+IFeVM78TX6uAGcng2/uDfZQ4CAtx3zUD+6/o8h5qq1zmlLCrnu/Cdu8RbfcHK890LMj+EtFGw==
X-Received: by 2002:a05:6358:9920:b0:13a:6cb:4d91 with SMTP id w32-20020a056358992000b0013a06cb4d91mr4301834rwa.7.1692544501787;
        Sun, 20 Aug 2023 08:15:01 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id i3-20020a0cf483000000b00646e0411e8csm2251406qvm.30.2023.08.20.08.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:15:01 -0700 (PDT)
Date: Sun, 20 Aug 2023 11:15:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 shuah@kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org, 
 Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Message-ID: <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
Subject: Re: [PATCH 1/2] selftests: Provide local define of min() and max()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mahmoud Maatuq wrote:
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
> ---
>  tools/testing/selftests/kselftest.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 829be379545a..e8eb7e9afbc6 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -55,6 +55,13 @@
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>  #endif
>  
> +#ifndef min
> +# define min(x, y) ((x) < (y) ? (x) : (y))
> +#endif
> +#ifndef max
> +# define max(x, y) ((x) < (y) ? (y) : (x))
> +#endif
> +

Should this more closely follow include/linux/minmax.h, which is a lot
more strict?

I'm fine with this simpler, more relaxed, version for testing, but
calling it out for people to speak up.

Only the first two of these comments in minmax.h apply to this
userspace code.

/*
 * min()/max()/clamp() macros must accomplish three things:
 *
 * - avoid multiple evaluations of the arguments (so side-effects like
 *   "x++" happen only once) when non-constant.
 * - perform strict type-checking (to generate warnings instead of
 *   nasty runtime surprises). See the "unnecessary" pointer comparison
 *   in __typecheck().
 * - retain result as a constant expressions when called with only
 *   constant expressions (to avoid tripping VLA warnings in stack
 *   allocation usage).
 */

Note that a more strict version that includes __typecheck would
warn on the type difference between total_len and cfg_mss. Fine
with changing the type of cfg_mss in the follow-on patch to address
that.


