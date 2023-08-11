Return-Path: <netdev+bounces-26606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718B778557
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D16F1C20EB8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347DA2D;
	Fri, 11 Aug 2023 02:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD997F1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C485C433C9;
	Fri, 11 Aug 2023 02:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691720464;
	bh=UK6+nIoJRgJe0+F29KexKJZ3mwOyj8uyJA/QEbO/nzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nlyPGGNQHpnfgEzkccS7V21YanmKRT5NmOZkZ0vxI3cxuA+qEIXYdbV1YPv15SwfV
	 dJDrm3q8As5NaOwmz+ZyyvRwaRGdhPZb6ZhWvu8eN7xRR2MNdRYpU+11nVYFlWGZyQ
	 b0dun7VFZkFM3de5z4jea7M9rrUqSH4UJ3E7bZzbiTaTxjCjDzcDoTq4xlb+IthX5x
	 kfRFFau04EZPlvmSAZnPsNuwkCuObqRy65BsD2Pgq3OvZwWWpyFiELT3rkHE0WFoMR
	 Jx589/2coK2xhWBfT3vJK3n0qnq9h7DrvHVGGywWYcbE2mtLB3xhtCrFHsY2PNX69X
	 J9bBJgjMygL8Q==
Date: Thu, 10 Aug 2023 19:21:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 6/9] ice: add admin commands to access cgu
 configuration
Message-ID: <20230810192102.2932d58f@kernel.org>
In-Reply-To: <20230809214027.556192-7-vadim.fedorenko@linux.dev>
References: <20230809214027.556192-1-vadim.fedorenko@linux.dev>
	<20230809214027.556192-7-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 22:40:24 +0100 Vadim Fedorenko wrote:
> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> 
> Add firmware admin command to access clock generation unit
> configuration, it is required to enable Extended PTP and SyncE features
> in the driver.
> Add definitions of possible hardware variations of input and output pins
> related to clock generation unit and functions to access the data.

Doesn't build, but hold off a little with reposting, please hopefully
I'll have more time tomorrow to review.

