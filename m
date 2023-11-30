Return-Path: <netdev+bounces-52708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDAF7FFD3B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB411C20EB1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC65578D;
	Thu, 30 Nov 2023 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY00rGQg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8F5FF0A
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 21:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A43C433C8;
	Thu, 30 Nov 2023 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701378282;
	bh=lqzEStZR0L5lwWNPbnwIia8GbV3FVO0c24b7gkUIOQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OY00rGQg65nix2pUBaTEtqsZ9WNsqsURFuEyte3ukcKkfiF9Yp7gCYAidbvKJglkb
	 HZWBKljsJ7JxV1s3uBODYRBSN+bTC0ZiYiHwfaNcjl3OuFZ4PPgnqaZetnyiDXXGsZ
	 g0nWhbdF6A2reE4hF69pC1xOn2svr2G/w6LudWoOGeauXSiB6NRHsVfyF3C4+cK4Aw
	 USi4zlOY9oXOfgafC+9pEgLlVgmEV7uZOX8Mfql9zLRMXst0ZU+Z++UWaGmp6gMs5t
	 FxI8IfjzyX1MD0tPWDoWcWx5xeIeAVVhytg62VIP1BtGaAE3/ATAdE6XzrzuE2G0Qn
	 48C1dxb+QFFkA==
Date: Thu, 30 Nov 2023 21:04:38 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of
 the copy of a definition
Message-ID: <20231130210438.GP32077@kernel.org>
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
 <20231130210339.GO32077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130210339.GO32077@kernel.org>

On Thu, Nov 30, 2023 at 09:03:44PM +0000, Simon Horman wrote:
> On Tue, Nov 28, 2023 at 07:48:13PM +0200, Andy Shevchenko wrote:
> > BYTES_PER_KBIT is defined in units.h, use that definition.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Did you consider a patch to update sja1105_main.c?
> It also seems to have a copy of BYTES_PER_KBIT.

I now see that you did :)

