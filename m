Return-Path: <netdev+bounces-208184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F8B0A657
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF01818841C3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6D2DAFCC;
	Fri, 18 Jul 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NViRITx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E02D94B3
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848646; cv=none; b=h+jbpffCR/vCYtan+Y2jPDZCoKFBABA81nlG2XdCVmf5C7HiesfDsh1ahe7Mj4BKNAx1PjxsuwSF5fnSIlKwGjAjzZZiQCmSmMlVrfIciHKOnxymeJIZ6Dqd3TVvDXtEGyrZ9/rzRsiGLa5Iy4uwR5YWoqryz5vDdRKd4b+fZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848646; c=relaxed/simple;
	bh=V4VYmzQAN0a9iO2EvpYqv/efxh6I08+dEk6t0GckWv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2geZm4H+3tIp7t5VWz46WZGRpVbYqMJV3O0kAsDVFhtVUN6Nzx/WjgMbqPCnPSzqdUc8yt7DbhDaJlqM5aXcI+vOOTo1B0tnnmdrZIGuxO2z/43V4io5FQMwIsleF6l5beh4/z3gQCMuDX5BOH2WqpzR0YOoSNZeoxCHh3HilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NViRITx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F4FC4CEEB;
	Fri, 18 Jul 2025 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848646;
	bh=V4VYmzQAN0a9iO2EvpYqv/efxh6I08+dEk6t0GckWv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NViRITx6rvbHyn7rB8mLccbbHh51pE2i9bprQS2TjHpOLEU5MaxaZM2CGc+Kkg40A
	 G9ZqD/SRaNLFGbF8bQLzZ/33CvD/WODgBFYcbDMSWhyOKKbvWWw+NeFbdvcJzd6xkW
	 4KTFzeQ8CEHyJYBJklTOfNhKtvMAtVOiSz7a+ItMumuqHGdZHoquuDEQmLeeaFuzcj
	 kAT0ZuxHZugRpiVUh7i627fqGtl8AqhnGywZAtCJZ2eI8sy7xaQAiQG/FY6wVDG64k
	 6x4DFzhz0oxfCu207j7oiKTy7rZXm3Px8rKo6C1rof91OAPVsj7knwAw3Uz4fuKEAA
	 K/2hOXJivUK3w==
Date: Fri, 18 Jul 2025 15:24:02 +0100
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next] selftests: rtnetlink: Add operational state test
Message-ID: <20250718142402.GC2459@horms.kernel.org>
References: <20250717125151.466882-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717125151.466882-1-idosch@nvidia.com>

On Thu, Jul 17, 2025 at 03:51:51PM +0300, Ido Schimmel wrote:
> Virtual devices (e.g., VXLAN) that do not have a notion of a carrier are
> created with an "UNKNOWN" operational state which some users find
> confusing [1].
> 
> It is possible to set the operational state from user space either
> during device creation or afterwards and some applications will start
> doing that in order to avoid the above problem.
> 
> Add a test for this functionality to ensure it does not regress.
> 
> [1] https://lore.kernel.org/netdev/20241119153703.71f97b76@hermes.local/
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


