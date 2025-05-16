Return-Path: <netdev+bounces-190967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC3AB985B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595D21BA2E3C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0B225A34;
	Fri, 16 May 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn/X524u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62951A704B;
	Fri, 16 May 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386522; cv=none; b=qhBrJOCBQ5xpYUPyoMUKHVwhtAhlICnx1UbaGRx3RfmZ6DNIw/CI33ht0W/c/5e7PZOCocEq3QoqJR9rCyYSgE2IW4ib5t8PJyMo+HJgMyyxKQTFRRlEUrgw6tI4tOg5XO15x+EFMHTVWWhiau36wkS5zfl7drlut1HAyWzjG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386522; c=relaxed/simple;
	bh=UALEwkCt9TSe/SLITzVhGp9yYZKC1uwhiV/qqqtwwwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YirEma0Ryo0Mf473/9AHYRfbNEXNVkc+1E1r/i3Ds+QwUOmUULnzdzexU01Jc+ZqSdEthimQmmv4qLFB+sH4Tvsq6CGGppCeEQ6/P4BnmFYFpc/dRoJ+ltAapI/q+MgDixM7/NvbwKUa95jMOLVaMkXMRH+p7M1moO1ZfzFseBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn/X524u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFDFC4CEE4;
	Fri, 16 May 2025 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747386521;
	bh=UALEwkCt9TSe/SLITzVhGp9yYZKC1uwhiV/qqqtwwwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vn/X524ulQTmzlz/OTMFbh+SoaVnp+NWrmNGy/X+1UCDmclgAiZHCsddtaqRNMIS1
	 ZKLFa+NEBF1uoK9TlD7aF1zMrIfLmSjO6JRYv+vCB9NZXcSQfxgd8U4Tiycid/+ygB
	 EHGeILgIJyJdnIOkn5w0bEBtgDbjXHSO1YoCcZZWslPV5X+B3F+ortc5ICOopDha6+
	 rH2SkmaDw1bZzOorLBo4qeJYiKBrLhLkIURBReNjKi2mNOWtoONPbGnZzhr0OX6FuG
	 rKJURNkAlTVwAWsnEYPvjkj+ZicHkOPATvlzAxvmL5DqDtork2RAZoBseGt8GjPLPp
	 WzqYoEOES8bLw==
Date: Fri, 16 May 2025 10:08:37 +0100
From: Simon Horman <horms@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5] ptp: ocp: Limit signal/freq counts in summary output
 functions
Message-ID: <20250516090837.GF1898636@horms.kernel.org>
References: <20250514073541.35817-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514073541.35817-1-maimon.sagi@gmail.com>

On Wed, May 14, 2025 at 10:35:41AM +0300, Sagi Maimon wrote:
> The debugfs summary output could access uninitialized elements in
> the freq_in[] and signal_out[] arrays, causing NULL pointer
> dereferences and triggering a kernel Oops (page_fault_oops).
> This patch adds u8 fields (nr_freq_in, nr_signal_out) to track the
> number of initialized elements, with a maximum of 4 per array.
> The summary output functions are updated to respect these limits,
> preventing out-of-bounds access and ensuring safe array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Vadim Fedorenko:
> - https://www.spinics.net/lists/kernel/msg5683022.html
> Addressed comments from Jakub Kicinski:
> - https://www.spinics.net/lists/netdev/msg1091131.html
> Changes since v4:
> - remove fix from signal/freq show/store routines.

Reviewed-by: Simon Horman <horms@kernel.org>


