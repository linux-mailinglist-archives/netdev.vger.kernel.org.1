Return-Path: <netdev+bounces-21011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF3762286
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D6828171E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86994263DE;
	Tue, 25 Jul 2023 19:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9231D2FD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AA6C433C8;
	Tue, 25 Jul 2023 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690313923;
	bh=GoUXo6/o1PnTsEABLRvNQd0YtZcxL3kR3vakvLywyl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnH1ULa9D14vIeeYWINMZ/8t1jpb7mg8AiXD57d9ifxw1V/KZRVPn/iM65+Ns5z4y
	 zaxsTnsd3OwTcgKVAWibNfbTYXVAUkUGq8JyFr9uIrCQL1SerZRJpLOWLgCTHNs9AA
	 HFJUnBm8JBJkp8qtKGhWr7edvTOA54o4LiSOtg8xETu0iZ3AQyTkN/I+C0O/1lVZow
	 wI9dtYWOISe9tAp17z56v3wgCPPR7qmdEw6LEQQfLXsZ/rASIECsGpjjkT1k0zFgXd
	 /kp1ZpR3WzXPorhc7tur7l0aB3Vk1AeE/lvT/9w4WY28ARLykHGOF5TBe2wj3WObQK
	 4qrcz2gJLAdtg==
Date: Tue, 25 Jul 2023 12:38:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Message-ID: <20230725123842.546045f1@kernel.org>
In-Reply-To: <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
	<20230724160214.424573ac@kernel.org>
	<63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
	<20230724175612.0649ef67@kernel.org>
	<d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 20:59:53 -0700 Joe Perches wrote:
> > Joe, here's another case.  
> 
> What do you think the "case" is here?
> 
> Do you think John Fastabend, who hasn't touched the file in 7+ years
> should be cc'd?  Why?

Nope. The author of the patch under Fixes.

