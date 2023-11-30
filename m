Return-Path: <netdev+bounces-52707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B542B7FFD38
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAD281A85
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CF55774;
	Thu, 30 Nov 2023 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1L/ZKxQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469154675
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 21:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC6CC433C8;
	Thu, 30 Nov 2023 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701378224;
	bh=FYzHZid8c6XjOdWhWeelNMtPY06u1fDsv1tVwwjawik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1L/ZKxQBxggZ1qM08BUUtRelszOqyMXNJmbam8Q8Mb8j20Ew95ekcQIiG/hILJmR
	 vfmIOtmsqH25UYsaPurgvyNYnbykydjTh0f7YUutOD4aZOhTpsGhugKtT8wDsO+xXB
	 4cIMjauEYUUAzFJsjdURx7JQUopvUhIYEsPY+26pM/McIXwOUhmxnpa4yGOFi3eNmO
	 4Z6sVfC9E+xmK6e4lHxFrpjVsHptoNuTdO1fmOYFsmauyO3UFAEPdkITCTzM85udu8
	 BYm+hiDbWyCL/yS/PghlhUfyGIK0iF8ezT8fGj1S5wPMe53ir25uh1YyeIp4dGMowx
	 qpyyekmJ1DbXw==
Date: Thu, 30 Nov 2023 21:03:39 +0000
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
Message-ID: <20231130210339.GO32077@kernel.org>
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>

On Tue, Nov 28, 2023 at 07:48:13PM +0200, Andy Shevchenko wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

Did you consider a patch to update sja1105_main.c?
It also seems to have a copy of BYTES_PER_KBIT.

