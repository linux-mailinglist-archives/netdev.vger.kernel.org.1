Return-Path: <netdev+bounces-243899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B7CAA3F8
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 11:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B639731A4465
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0922B584;
	Sat,  6 Dec 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/Rn7T5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC129C321;
	Sat,  6 Dec 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765016161; cv=none; b=e/cZL66ynh6vFJx7Wlfl2jw022xsczUkwuo2vhLTObVw3xQVGTBsATJqJsnVInobK59NAO3OEObUB4N7g6nP45eihGrWeyqfwSx0k0TdWl6BIJdkUa545tG2j7FUq2wMD6ea6tSKcH9fsy7Sn/ZrG7hswkJ96vCPUdO+wBDNTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765016161; c=relaxed/simple;
	bh=lFU3EcGyBdpsW0Hkd/ugA31E2KOiaFQplmose0hCcHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm5YAjLoAHlZ2vsENiBhAmZ5PK4Tzyi+x9UcGtyICP1HQMdHOLH5ngo/0tGT72w2kJb0DiInG1iYsD+9y6XcbtGV4VRVRlDNLPPh9mMliLKzD3CAmr7+JfUx2REbf6WphXNW/7zMQ+xvbcDnI//o/zLPPM2VIsWFOVKKm/T+LFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/Rn7T5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB569C4CEF5;
	Sat,  6 Dec 2025 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765016161;
	bh=lFU3EcGyBdpsW0Hkd/ugA31E2KOiaFQplmose0hCcHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/Rn7T5LTn2j5E0ftO0sEqW3My68BJYzi41kYyMbmPy58PgFlDQhV2NAnoMkF2XJL
	 S/9bSc0Oz7MW8Rkm1WzvxpIXrltTIhrPLrmQP6DOhurIv/0wsGW/EYXI+iSfNCh76y
	 rK2C21OhzFC4oNIQHduO3pGpDFGXi7A+8+wJQCkKkPphVr+1TTN3CVjiAczSkR2FyY
	 QMflC5dYuVDsEACJOmdCyc9/YIFi3qVsjttJVuyRRqMiKCtc2SY/CS9GyXZuOVRU0M
	 MDPcWr7lPfk8PfOp1s0tr3kdnGjTdmXBWXMKbK4nw7DU8xjgk3egoDsh85PXvxpiLv
	 TCbZtYLOTcaUw==
Date: Sat, 6 Dec 2025 10:15:56 +0000
From: Simon Horman <horms@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org,
	steffen.klassert@secunet.com
Subject: Re: [PATCH v2] net: ipv6: fix spelling typos in comments
Message-ID: <aTQCXJ7MUvnJpG6B@horms.kernel.org>
References: <20251206083813.240710-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206083813.240710-1-i.shihao.999@gmail.com>

On Sat, Dec 06, 2025 at 02:08:13PM +0530, Shi Hao wrote:
> Correct misspelled typos in comments
> 
> - informations -> information
> - wont -> won't
> - upto -> up to
> - destionation -> destination
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

Hi Shi Hao,

Unfortunately this patches do not apply cleanly on net-next,
and thus can't be processed by our CI.

When applying manually I see:

  Patch failed at 0001 net: ipv6: fix spelling typos in comments
  error: corrupt patch at line 58

Also, net-next is currently closed.

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: changes-requested

