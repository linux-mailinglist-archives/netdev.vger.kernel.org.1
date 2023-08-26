Return-Path: <netdev+bounces-30847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E5F78933C
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C2F2819E4
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF20538C;
	Sat, 26 Aug 2023 02:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625D37F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A53C433C8;
	Sat, 26 Aug 2023 02:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015396;
	bh=3W4XQ97rlqrgk7QOix5r76jiT+k1DRDAQAqpOt8QTRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hNyqaXGlM0uS4cBxXQ6I8iEUFbZg/N1rT5vHUaz4mrzLIEmG8p47j1vIeNOwS4fp8
	 1oaFJfYoPLblNFPO5rsSKAcvB4LJX0YikDYngCJxzF9xSWIGtaq+Nn55R4szmEnhh+
	 wehWkHBqmEgJCVDrvOdr71bINGzIkVrcwhFRtIlc23VSvJQJ/G5YSFtNRS7PT9SGVp
	 8b8+Gbvph0kuQ5XSnrtQqn8HnbtH6TWLtxzNiEip8jrH3u4GB52bwxYK0jyAQvmCS+
	 3BYVFl/BhMQ3FuTeeuHQc4PgoNYtzPLbSWXYvVl71rTTYia7c3PI8+S2c0RCqCBtqk
	 mmCxwtSfHNZTA==
Date: Fri, 25 Aug 2023 19:03:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next 00/15] devlink: finish file split and get
 retire leftover.c
Message-ID: <20230825190314.65309ec5@kernel.org>
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 10:53:06 +0200 Jiri Pirko wrote:
> This patchset finishes a move Jakub started and Moshe continued in the
> past. I was planning to do this for a long time, so here it is, finally.
> 
> This patchset does not change any behaviour. It just splits leftover.c
> into per-object files and do necessary changes, like declaring functions
> used from other code, on the way.
> 
> The last 3 patches are pushing the rest of the code into appropriate
> existing files.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Nice!

