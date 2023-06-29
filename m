Return-Path: <netdev+bounces-14583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5227427C2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF8280DFC
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF2125B9;
	Thu, 29 Jun 2023 13:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC379AD28
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:54:20 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC33588
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:54:19 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QsKgW5f5lz9sdk;
	Thu, 29 Jun 2023 15:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1688046855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0WhdJyq+S3YTJINgsZojcMNq8icUE7DhNPlzKJ/p6w=;
	b=Zowp4Bu/lyDpIgbvaWZ7HkSCgbWXXOVaZRXf9xRyeL4w5yvTgc0ru7WCMP7oZPqJosluAv
	G+GRgPjB2JMoBHle1BfnhyohC3a1ARR33kZdb9AppKf3cJ/jA1Sl8dEl/XVAC3oxbBKX5Z
	Aq2RJD9anPU/a/mgBf8HOCTj53asJC0otXRKS8DZP1ySjtxw57wZ27jA2g3CKxd7rf0zIo
	xfeAkZChAt+NFlAx9+ZDplsf4HWzmUjmi2rOHoXS20DFYeNHyBVrtAeBRDGrUTWeW8+lUu
	/ybT3hVaPEXoSi59XWAMucokC1xzezSeRyRTyJJuEbvvL2Xa/WdsR7FDUAMldA==
References: <20230628233813.6564-1-stephen@networkplumber.org>
 <20230628233813.6564-6-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 5/5] ifstat: fix warning about conditional
Date: Thu, 29 Jun 2023 15:49:49 +0200
In-reply-to: <20230628233813.6564-6-stephen@networkplumber.org>
Message-ID: <87h6qqe5mi.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Stephen Hemminger <stephen@networkplumber.org> writes:

> Gcc with warnings enabled complains because the conditional.
>   if ((long)(a - b) < 0)
> could be construed as never true.

Hmm, yeah, it would never be true where sizeof(long) > 4.

>                                    Change to simple comparison.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <me@pmachata.org>

