Return-Path: <netdev+bounces-203094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7AAF07F4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C13C4A6384
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6F61798F;
	Wed,  2 Jul 2025 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9uu6JaR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4D6AA7
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419868; cv=none; b=kDF0rpZmWJuJCJQ07sKAnO7w90NE8fQUIMd9tF7NRIxnUp1cVzSDMUwQs9TGnsN7F154ZNZsdY8QI1iI9+IiXPWmTH1HoArkxwuwIpVyWAotuwgDdSFZOhJ61J0bIV8Hd4lPa8lVUMJD1Hh2gElOPGPwTDaHeyGjUwal9g0LdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419868; c=relaxed/simple;
	bh=haLaXhadvYR6dzWWdauwWEBY2ULNfvN5Sl+PDtsxX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocu2ZSbiTtGxBMQQ+v5PcpXZ7wx83p9p+nusc1gFjb1L/0lyXQOwbIFXZoaoxXhUXd5nSApXQ4QsyZWFVhQd8vl7XlIXG7NNM/prNAEyl7EHMTOl0QTEbvwwM3NZ/0Hipd0s6r81RUTvCgNgzrk+wNbFllABz4mfJ4qCmS5hwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9uu6JaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BA8C4CEEB;
	Wed,  2 Jul 2025 01:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751419868;
	bh=haLaXhadvYR6dzWWdauwWEBY2ULNfvN5Sl+PDtsxX0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X9uu6JaRCme+4yZuP+IH05qaT4baZcuAcYZcZAKG/LhYM2IQ4n/O0I9w1yI2cVLT/
	 uK1gz3B+Wig0rDOpPKTJOHLU768YHYkJngv+FtGwkh7ubt7nj/XUb0gb5ueEuADY/6
	 g6K336ToEM2fcS7YwpbJ4YlpcCZorNih7Tc3hqSc3TkobLAv8keVVHEiCb2jD3qCTn
	 fK353H3C68lEA7viRiAVlF11utaaUfv3yE5r+FWr6+keDHwFZAKw2rdGlhesLoviUL
	 7fe2GZkk9gBnM4QCb+xKuE/0o7l+J4+UAB883YaP4UGkr9FmZV25JJ64ZxHL9wp0jN
	 hWM0aH9pXJ9DQ==
Date: Tue, 1 Jul 2025 18:31:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com
Subject: Re: [PATCH net-next 4/4] ibmvnic: Make max subcrq indirect entries
 tunable via module param
Message-ID: <20250701183107.6f6411c1@kernel.org>
In-Reply-To: <20250630234806.10885-5-mmc@linux.ibm.com>
References: <20250630234806.10885-1-mmc@linux.ibm.com>
	<20250630234806.10885-5-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 16:48:06 -0700 Mingming Cao wrote:
> This patch increased the default of max subcrq indirect entries ,
> and introduces a way to tune the maximum number of indirect
> subcrq descriptors via a module parameter. The default now is set to 128,
> as supported on P9, allowing for better throughput performance on
> large system workloads while maintaining flexibility to fall back
> to a smaller maximum limit on P8 or systems with limited memory resources

Module parameters are strongly discouraged. Please provide more details
about what this parameter does, I supposed it should be mapped to on of
the ethtool -g options.
-- 
pw-bot: cr

