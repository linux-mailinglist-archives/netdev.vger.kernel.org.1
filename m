Return-Path: <netdev+bounces-49319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE07F1AC8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C8CB21704
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2821A12;
	Mon, 20 Nov 2023 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpwcdOgm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF92225A5
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A750C433C8;
	Mon, 20 Nov 2023 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700501932;
	bh=KMNX5099xzHsHJeyawG4lhzr2opPwh86ii0WD3uylPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpwcdOgmaShmGRUBBygiyt/K9P0lQAat9gROhw8yE/C5vyNw9gsVY9Wei5VAgOhtG
	 E33vJUkTq6XUKRriRRwR5m6zIuOQ5imRi2embJpUvzv9NJn3IWTGVqH4Vr5rOle8qv
	 KiD59k+Dr1SJQZ+Dt2ENLIKzTZXBA5bhXDzizn9a60KfmdKbJlzBNohiolwz6XBFO9
	 u5zINkWMDJA8+MXCGnpxfMoV64TGl/AnY0w/CAurog8dP9hOp6qvSt1UCEh4QCvuhO
	 sIE2a233wB+iiCGYg3IMG+AXCScNM/NE1bMUrMHW5A5My32MYotsbMIzCLX+atN0pA
	 xZEF6BpyH1e8A==
Date: Mon, 20 Nov 2023 17:38:47 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH net-next 2/6] selftests: tc-testing: move back to per
 test ns setup
Message-ID: <20231120173847.GG245676@kernel.org>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
 <20231117171208.2066136-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171208.2066136-3-pctammela@mojatatu.com>

On Fri, Nov 17, 2023 at 02:12:04PM -0300, Pedro Tammela wrote:
> Surprisingly in kernel configs with most of the debug knobs turned on,
> pre-allocating the test resources makes tdc run much slower overall than
> when allocating resources on a per test basis.
> 
> As these knobs are used in kselftests in downstream CIs, let's go back
> to the old way of doing things to avoid kselftests timeouts.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202311161129.3b45ed53-oliver.sang@intel.com
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


