Return-Path: <netdev+bounces-20082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BD75D8CF
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AEB1C21840
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4863A1;
	Sat, 22 Jul 2023 01:45:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA317480
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A6C433C7;
	Sat, 22 Jul 2023 01:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689990319;
	bh=xWFlk0dYt7/YNjb3bVEqK50P29rrnkR0ycCLP2RQkFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXT4QB21VXHPsgb5gMo1lbluzaifEtZo+gpjqSvukz2O7BzC2SR3P9UxjEZEWt4Yv
	 3tPER4/XcA7YQ1PXft2o80+BBPFVQ19QIHRxojV5p5hFerjpye3OI3gVI04A4czHUh
	 GiaP7ApqiebcfdwbGpuHVdpJZtw2DSJRZ0AoDba4V9gErzPrqxkbeIgwMfzkDzeMAW
	 F7J8kO6B32M/VzcMddqBRct6R9o0Prv51vRU2I/KnMJ8V8U1ZO3eJcr+EFmtmrzNAp
	 pPUIAOpPLw8kkJdFmPZPROYWg6DAH8qSWfFiXfb/0+7LDne5VzBSgkj0skTYevkkla
	 dXw8WXzqBNArw==
Date: Fri, 21 Jul 2023 18:45:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
 <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
 <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] page_pool: add a lockdep check for recycling
 in hardirq
Message-ID: <20230721184517.11003011@kernel.org>
In-Reply-To: <fc51f6be-819c-7b42-e0e7-4b474a690a8e@intel.com>
References: <20230720173752.2038136-1-kuba@kernel.org>
	<4abeeded-536e-be28-5409-8ad502674217@intel.com>
	<20230721090538.57cfd15d@kernel.org>
	<fc51f6be-819c-7b42-e0e7-4b474a690a8e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 18:33:39 +0200 Alexander Lobakin wrote:
> > No strong preference. Would you mind taking over this one? 
> > It'd also benefit from testing that the lockdep warning actually 
> > fires as expected, I just tested that it doesn't false positive TBH :)  
> 
> Sure! I'll add it to the optimization series as a pre-req to more
> aggressive direct recycling, would that be fine?

SG!
-- 
pw-bot: cr

