Return-Path: <netdev+bounces-29534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9087783ADD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F441280FF4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF8746B;
	Tue, 22 Aug 2023 07:29:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D66FCB
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E1C433C7;
	Tue, 22 Aug 2023 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689354;
	bh=GlJaG6ZRX4I+wLZZpdMZ3KFHFXQKGDaXAy2IBBc3GbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjgVnoGJcw74HmYSqB6jRUSxklL0xe0dMpoQ1IbbOzNF5O+BwkgcFUbgkCKQ7tChj
	 F/6JaZh4IvIeNwAagbv/7PWVgxU8cM7KZMcUwjWqTq6wVM9OVHlQhytYWuAGXfRrkJ
	 9o9bsNCL3trRb85Jjgq/twaGiFlXQGGxFb9LxVAYi8TLZ8CUaxhYXvhlWTuGnzOBFd
	 ljJFeKnL6TS+NOQGJTV1laphANXn1ps5cOm6ugetCjsyL2LWsR3MupSfOctdQkrhul
	 BSJRgf/JzGcAMkrJqavFt/5LoT1dyezUX3tP2/lL6hjwvFLhFxUGcypmbEKI6Mca9/
	 G5CfjfofiRRIg==
Date: Tue, 22 Aug 2023 09:29:09 +0200
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	richardcochran@gmail.com, kalesh-anakkur.purayil@broadcom.com,
	leon@kernel.org, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v4] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230822072909.GM2711035@kernel.org>
References: <20230821103629.3799884-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821103629.3799884-1-saikrishnag@marvell.com>

On Mon, Aug 21, 2023 at 04:06:29PM +0530, Sai Krishna wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> v4:
>     - Addressed review comments given by Leon Romanovsky
>         1. Unlocked mutex in error conditions.
> v3:
>     - Addressed review comments given by Jakub Kicinski
>         1. Fixed re-ordering of headers in alphabetical order
>         2. Refactored SoC revision identification logic
>         3. CN10K errata revisions can be different from atomic update
>            supported revision devices.
>         4. Removed ptp device check.
> v2:
>     - Addressed review comments given by Simon Horman, Kalesh Anakkur Purayil
> 	1. Removed inline keyword for function in .c file
>         2. Modified/optimized conditions related boolean

Reviewed-by: Simon Horman <horms@kernel.org>


