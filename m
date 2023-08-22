Return-Path: <netdev+bounces-29538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A82783AF9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D645F1C20A7D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23F79CC;
	Tue, 22 Aug 2023 07:33:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260233E2
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C650C433C8;
	Tue, 22 Aug 2023 07:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689597;
	bh=An+zgJpx0EFTgVuD4rgsolfBepRSMglZzX8LoYa3aCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qR/R8nAI6PhTWuSLHULHtkfEP8aq0Y3GPayOzjHrkfkcIzScABc1IpCjJ5LA2dC7+
	 sbB6S0hWf3IM6UzFZAFn+74ruTgKGkrm+uIZ1azIs5467//5notCGQ4V7E2Enn47VM
	 TWmPba+q1i9p8h5IVuAV9MVheypL/MRFVBQ03eYXXJQI3F8AeqsPRo1laxNMwwOMGk
	 bWmwYrUxWaAfq7Vmz7qiaIL16vXWeU9Ab0YRTexJYdHM5xjDhC176KqwHceB5UeIHy
	 mF0/Gja+zcYq0btKLB+0wYhjjU06JwwSZGHkisIFpHS8Q0pmEkoz8nWpNNo7fjiD+8
	 Lwag/+KB1tHGg==
Date: Tue, 22 Aug 2023 09:33:13 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Sasha Neftin <sasha.neftin@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] igc: Fix the typo in the PTM Control macro
Message-ID: <20230822073313.GP2711035@kernel.org>
References: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>

On Mon, Aug 21, 2023 at 10:17:21AM -0700, Tony Nguyen wrote:
> From: Sasha Neftin <sasha.neftin@intel.com>
> 
> The IGC_PTM_CTRL_SHRT_CYC defines the time between two consecutive PTM
> requests. The bit resolution of this field is six bits. That bit five was
> missing in the mask. This patch comes to correct the typo in the
> IGC_PTM_CTRL_SHRT_CYC macro.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


