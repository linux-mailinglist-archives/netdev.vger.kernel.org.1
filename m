Return-Path: <netdev+bounces-46049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698817E101A
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DD7B210DD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE11C6A3;
	Sat,  4 Nov 2023 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGUWWvSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99188BE1
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCF9C433C7;
	Sat,  4 Nov 2023 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699112026;
	bh=CneH2QCNOFwdP3vrdBROQilhh3jKjpF9b3jeDVy9MwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGUWWvSCp6S+YsbOpxdxMXZS7IG5+uckjzR6vI86t8b1AimcNoEhQ1wPFN577zfZW
	 9ht3nhJFpqZlqORI5uTTqfSahmBazKbq1VEO5B8ERzj2D/kfZv2wJapWPXPLtWitIm
	 CX3E5XXgGuBFUcjYelg6j7Qy+PGd4OnsE4QEzECVq13S6dw5NDC2/dAnBqmIGz73f1
	 kYwz7N4rAXTIxn2LoP1H25I1UasXFMVIeLi7LEO/dino0YkJpifEUr4kj96r5zUEa0
	 zZQv6rM/AGG01x3M4m7llmeLkLN4dno1sW26ESLibYUtCP9l+W1Fgnf4GVDmsiFv+5
	 Rx/TsI2zzkZdg==
Date: Sat, 4 Nov 2023 11:33:31 -0400
From: Simon Horman <horms@kernel.org>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de, lukasz.czapnik@intel.com,
	Liang-Min Wang <liang-min.wang@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v2] ice: Reset VF on Tx MDD event
Message-ID: <20231104153331.GJ891380@kernel.org>
References: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102155149.2574209-1-pawel.chmielewski@intel.com>

On Thu, Nov 02, 2023 at 04:51:49PM +0100, Pawel Chmielewski wrote:
> From: Liang-Min Wang <liang-min.wang@intel.com>
> 
> In cases when VF sends malformed packets that are classified as malicious,
> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
> for several minutes being unusable. This behavior can be reproduced with
> DPDK application, testpmd.
> 
> When Malicious Driver Detection event occurs, perform graceful VF reset
> to quickly bring VF back to operational state. Add a log message to
> notify about the cause of the reset.
> 
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


