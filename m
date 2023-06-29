Return-Path: <netdev+bounces-14627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3231742BBE
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EB21C20AC7
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7FF1426B;
	Thu, 29 Jun 2023 18:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549ED1426A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0AEC433C0;
	Thu, 29 Jun 2023 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688062303;
	bh=LcVgjztWwrEVLk/ttpaI/0iSvdHLAJ5buCBPbWTiHA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwBVOLBEo1f4s9g9vFg0AaNlw5/d9WFhZ4Ae1sJA6tM1XRzvAE8t/o8A5F1ex8i+z
	 mKRpTNQ/Ae9KWS0LDeobRbuIZGUQ5Prx50EYQp8DHxuJ9CyXZhr5XbRs1Ojzv60iyv
	 HFgr9q7IC3eEI21Kw0hFy6OIZMVlBva9ioP3WR6MkY1diyCwBCE9CYYgzHh2Yq3Rcz
	 NQTnMbZE8d7Qqc1crbblyb9ODzG9X9Sx8/unI06ToUGhOD1Iss6E9vNhIcLUpG3Rjf
	 H49EkbNN6QZl/3UvUm6O9x6SiqOSg864PSefyRbRt1vHadChT01UrJHMlNAcgMfPU/
	 XPvliTi8By5vQ==
Date: Thu, 29 Jun 2023 11:11:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Habets <habetsm.xilinx@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, ecree.xilinx@gmail.com, linux-net-drivers@amd.com
Subject: Re: [PATCH net] sfc: support for devlink port requires MAE access
Message-ID: <20230629111142.133d3610@kernel.org>
In-Reply-To: <168795553996.2797.7851805610285857967.stgit@palantir17.mph.net>
References: <168795553996.2797.7851805610285857967.stgit@palantir17.mph.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 13:32:20 +0100 Martin Habets wrote:
> On systems without MAE permission efx->mae is not initialised,
> and trying to lookup an mport results in a NULL pointer
> dereference.
> 
> Fixes: 25414b2a64ae ("sfc: add devlink port support for ef100")
> Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>

Applied (manually) thanks!

