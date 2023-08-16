Return-Path: <netdev+bounces-28174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41177E764
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE73F1C20EEA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90256168B9;
	Wed, 16 Aug 2023 17:15:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334C20E7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 17:15:53 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775C326B5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:15:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686bc261111so4834532b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692206150; x=1692810950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7B76SJZwWFMgq0rko03a7Yz1GdXT9RGFlT0uSeLt/U=;
        b=SqumvEkUWOKVKVphJsOra1B+koAdAzNVMAqoBFr8JLYxranHE3Nq9RKsDRrbdVw1J6
         z0AAXHbbueNvlnZcDR2/mMfBK4iNUyPpTarMiKJlIGiX9SkHCZV0ElPfj9uktHc8Ih6X
         97eD3EnVPkvcNmwRNWdp8Z5jEtCLlZQh0Z8XMFA4MID2UzQg3ECe8c1qpN+Nok/0hcDW
         Q/QLkwxxbsOUYVAT0ma4hqxmOY5tBDd3akelBipRvIsmrg0TswUaH0uMmaOVcRZk+fZg
         Nm4Va85F4zJMc1heAS9FdqLCICUoXKmeD8CIErRedhVrpU2NMPt/N+sO261agvS1uqlC
         DCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692206150; x=1692810950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7B76SJZwWFMgq0rko03a7Yz1GdXT9RGFlT0uSeLt/U=;
        b=kCxpeN5Aj5Mj/5aSWL+Mor+t/Wbo7gXMLISFS7m7YYpYmAMqDMenUjMAkoTIRSB0NN
         jc751JfD+jVLvRND3umacHco06AJ5Mr477Y4nMWe/t0BL1oWE6xL6DfS2LJNqNfoYIeH
         kHVF8ED2CTv8fIcwTmiF2L1VigkCmJWOMKukGMUddPdYZcNbOWExhrbQkTL35lAHFR8W
         eMutUdNWo1RcaQwf9RmZ2SZj5OY1xneCLB2jDuOen0xSasgfdkG6SiBOCtgVook78HYn
         uJOJHsN/vvECPuuiA/pEHTd+YghgAjMjPhft5Jy9l/QtnnUm2f8W4InwG1U4S4JCKmAc
         FFqA==
X-Gm-Message-State: AOJu0Yw9/gQYttSMGwMPxtOJIAXJ+g6bbAZHjIgcFUJChn87Em7yig43
	nuRxpKjxnyHoJUi/3tHsk6PrJg==
X-Google-Smtp-Source: AGHT+IFDAN4SAqw8dD0iA55i4WY6tAW2NAHTEdTdpyzFzY6vUchTzjmO75n3NGUYwFqumrcWLAckoQ==
X-Received: by 2002:a05:6a00:2345:b0:686:2668:796f with SMTP id j5-20020a056a00234500b006862668796fmr2606461pfj.32.1692206149935;
        Wed, 16 Aug 2023 10:15:49 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78112000000b00659b8313d08sm11383202pfi.78.2023.08.16.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:15:49 -0700 (PDT)
Date: Wed, 16 Aug 2023 10:15:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Rakocevic, Veselin"
 <Veselin.Rakocevic.1@city.ac.uk>, "Markus.Amend@telekom.de"
 <Markus.Amend@telekom.de>, "nathalie.romo-moreno@telekom.de"
 <nathalie.romo-moreno@telekom.de>
Subject: Re: DCCP Deprecation
Message-ID: <20230816101547.1c292d64@hermes.local>
In-Reply-To: <CWLP265MB644901EC2B8353A2AA2A813CC915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
	<20230710133132.7c6ada3a@hermes.local>
	<CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
	<CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230816080000.333b39c2@hermes.local>
	<CWLP265MB644901EC2B8353A2AA2A813CC915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 16 Aug 2023 15:26:07 +0000
"Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk> wrote:

> > Is the scheduling in the kernel? If so yes, it will cause a MP-DCCP not to be accepted.
> > If it is all done in userspace, then it leaves option for someone to reinvent their own open source version.  
> 
> The protocol works at the kernel level, and has a GPL scheduler and reordering which are the default algorithms. The GitHub implementation includes some non-GPL schedulers and reordering algorithms used for testing, which can be removed if upstreaming.

IANAL

The implementation I looked at on github was in IMHO a GPL violation because it linked GPL
and non GPL code into a single module. That makes it a derived work.

If you put non-GPL scheduler into userspace, not a problem.

If you put non-GPL scheduler into a different kernel module, according to precedent
set by filesystems and other drivers; then it would be allowed.  BUT you would need
to only use exported API's not marked GPL.  And adding new EXPORT_SYMBOL() only
used by non-GPL code would get rejected. Kernel developers are openly hostile to non-GPL
code and would want any export symbols to be EXPORT_SYMBOL_GPL.


