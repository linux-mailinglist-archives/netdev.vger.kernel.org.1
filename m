Return-Path: <netdev+bounces-26520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADE777FEB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3801C21128
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9621D21;
	Thu, 10 Aug 2023 18:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98221512
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5BCC433C7;
	Thu, 10 Aug 2023 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691690682;
	bh=kQ68C7GyuXbyorY4HjtGnGMOJaryfDgyULMu79dYD+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7VzM9ELObBDpUElFEoj6Iyyuy9pIMWnYBXIeVbjmV12DV+DIRcGIxS4wW08T+BMH
	 NGbA6hzlkGCCzT+73zr68lnHUOaJQBxelH764uUbZin+7uoNvm5eWVg/NWs9NujsfU
	 fjr/a/l0lYiOoT/syiDOk9goV+FN4jTz9nXUXXfOu3tGNnrqc8V8AkZe2lRuAaCVGs
	 WmD6cysBHFcgISqteCDMWZYsob7uSi7a0iWyvv5i018VKgFTajpHHH5hodAA2M0KVq
	 17wPyRTQBobNmEsr+WVCuIbPMmMeBxYKRpaYDo35QBHNJEE6tZhTQcvSP96e+Sj5bf
	 dCRdKSFW1nSqw==
Date: Thu, 10 Aug 2023 20:04:39 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: caif: Remove unused declaration
 cfsrvl_ctrlcmd()
Message-ID: <ZNUmt4Vf2Ph3tqDd@vergenet.net>
References: <20230809134943.37844-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809134943.37844-1-yuehaibing@huawei.com>

On Wed, Aug 09, 2023 at 09:49:43PM +0800, Yue Haibing wrote:
> Commit 43e369210108 ("caif: Move refcount from service layer to sock and dev.")
> declared but never implemented this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


