Return-Path: <netdev+bounces-48362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC07EE269
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C961C209CD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC25315A4;
	Thu, 16 Nov 2023 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4gqsQwN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414E3158D
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 14:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D14C433C8;
	Thu, 16 Nov 2023 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700143926;
	bh=09cApBjOm/GZJvx3fQnIjMI2h9SqOuNTIIgi3UDXPtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4gqsQwNzHIq6nQYxHjsUWH1zeJuBuqP5MGaW5jZA6pSJbyJ0Fzqmf1P1GIKG+W6w
	 0RpyxriVi2lUxD9D6TaVdYbLoQ6bAMsomHzxUTpHJIN7JgVVW5HZdGfa97T1M1UONU
	 22crN/lCw2lnw7S+3RNt9wNcGWx1awv4vvBRQW15auBgp3/stiELiIIPtloq6Z6bQV
	 SMbT2L2sPG4N2L+hF+lL9vG5JwIWghND2R2xuGYOTeP+VdChJh0Lkc32Y3m1jV0GfJ
	 gnzafVOtEHI1vk0px9DBhEJOWPzuqlDtykkfARzr8D1tFwqh89Tb/KdVOqDWLFW2LP
	 egf/xZ7ITIZ/w==
Date: Thu, 16 Nov 2023 14:12:01 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 3/4] selftests: tc-testing: preload all modules
 in kselftests
Message-ID: <20231116141201.GC109951@vergenet.net>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
 <20231114160442.1023815-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114160442.1023815-4-pctammela@mojatatu.com>

On Tue, Nov 14, 2023 at 01:04:41PM -0300, Pedro Tammela wrote:
> While running tdc tests in parallel it can race over the module loading
> done by tc and fail the run with random errors.
> So avoid this by preloading all modules before running tdc in kselftests.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


