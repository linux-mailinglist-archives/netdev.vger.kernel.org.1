Return-Path: <netdev+bounces-199724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC94AE192B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2034616242A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF278253F16;
	Fri, 20 Jun 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgKMlyWx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559B184E;
	Fri, 20 Jun 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416163; cv=none; b=Iloi97J3mDOtkrxrvDbMVPI2xVYzYhr1I4LhcFQEMdwE+xbCiBT0Dcby5CqPuAzruZbMLcsfWC7q4iz2t1m+65o87pGotc18q9wltDuAnov+wdRsim3yfqZs6z2SxhQ93D7uzuYfu+DfJcfZQFp8KXRI4MB+xpzuU3tY2NkHyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416163; c=relaxed/simple;
	bh=oDhleMh6/r5KYmZUOnocIhizlu8G9M0Audg1hQV0wRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8yMoAbQJwD6J6q3hpsQn+BlOJWVRUY/fmO1Gaby+hUfcnhAtlrEluRHKZg3NkBHqJh0kfrOvRaDFOHprn31gIf1l837vzekcZdngK9NtxBy6i0o2aBO3TJH9mvqimSZ7TThI53wsmpKsxPPa0yv+Wt9RJxhZn6j/SoTRbJyJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgKMlyWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790CCC4CEE3;
	Fri, 20 Jun 2025 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750416163;
	bh=oDhleMh6/r5KYmZUOnocIhizlu8G9M0Audg1hQV0wRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgKMlyWxtQHaQOZrO0faug73at9WkJ3FjJz7gD4iAzy99Ok3Zhe909p1+Wl/tCC1K
	 h65pUabk0m5kMa43YAH139TBZp+wdL321XWNbx/pO10JFsI4i5o8t0lLXzTXrfM650
	 XJEDH1cbK+c7AeZDovZzBixuw1TwQKzVXRXXAME2dPO2BHzMvz8wv7Ol1PTPX4EA21
	 oE3nTAe/cv47yN39JT55RAVIKpPb1/RexJrpRTu1M9HiqWrqw3ZxkD2YjDpS10bQ26
	 oW7+lA0iI9e8VdOUiJ4mcNKZsf8rDQyMkLo39wLsm556OjuWO1Eiwz+RKqpJHdxUlb
	 89h6uc7BBsVrg==
Date: Fri, 20 Jun 2025 11:42:39 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <sln@onemain.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] CREDITS: Add entry for Shannon Nelson
Message-ID: <20250620104239.GG194429@horms.kernel.org>
References: <20250619211607.1244217-1-sln@onemain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619211607.1244217-1-sln@onemain.com>

On Thu, Jun 19, 2025 at 02:16:07PM -0700, Shannon Nelson wrote:
> I'm retiring and have already had my name removed from MAINTAINERS.
> A couple of folks kindly suggested I should have an entry here.
> 
> Signed-off-by: Shannon Nelson <sln@onemain.com>

Reviewed-by: Simon Horman <horms@kernel.org>


