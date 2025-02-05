Return-Path: <netdev+bounces-163134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C03A29627
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B08168447
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB41A83F2;
	Wed,  5 Feb 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLbJWbe0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93B1A76BC
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772568; cv=none; b=nr/t2m26J+WWkHhsCVC8PPNxXH5ZXxFfZrtFodP/aREgJj+je8RJeR7rH/pEUomLzTcsEAKQivVhn+7QlSfZlFgUswHlfIA5k8WnEqaflkaTibcfvijuje4Kf3cljgNpux66sbJ2vxwqw5RY95y+IvDK7d7CTxrgfa9jNE1tXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772568; c=relaxed/simple;
	bh=7qHG0qRQfv0rjo3G08mXWOYJkJWkqfrQ7+QcqpEU3oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AteGt23mTmv0GQ4MkwkF2yEGYBiLz6B+CWj80LfJV5OpnbpKg7QVt8NwIvFJwwiN0BlB+8jFgm0Cmrd/2hpfSXQNqPSTG6BB3/4LyuYn4me/zF4g0rX+GDk+W4Oa+47prhoAmxc9vw+KMfD4YfadQvm2dsg7bRFI6oP5FGED4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLbJWbe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14065C4CED1;
	Wed,  5 Feb 2025 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738772567;
	bh=7qHG0qRQfv0rjo3G08mXWOYJkJWkqfrQ7+QcqpEU3oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLbJWbe0FR8gd/EyMCWRAb9MiNumwUoX44ljVi5ZUEkqMfhxf+J9iIZhzgvT4X5JP
	 Q5hSPkljOL8W4KKBVjM4XEy+y+rlRBLb5R6Xxj8xh5IOR4g0N1lqWPcMPOSq2nDaK1
	 2+lelDyec5BRTtrflJwcun8A5h7zMRC9rKmGp9P/WmfrrVSaEx6JSeP1LkP3tAQItK
	 MqCNDnJ1gmqjQbJ9fU0RfFi1BIJ1SXPK4Sz8ysCHHf+3aQv+TLolAmYEGEHo2ATZAf
	 F9hba1EDmwXW5WSHTcQbHP4+P95Ew5dDSptsivgthYuGIJ7aiUG2xFIiMCmcFiExgW
	 jy7/rfhGi9/tw==
Date: Wed, 5 Feb 2025 16:22:43 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net v2 2/2] MAINTAINERS: add a sample ethtool section
 entry
Message-ID: <20250205162243.GG554665@kernel.org>
References: <20250204215729.168992-1-kuba@kernel.org>
 <20250204215750.169249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204215750.169249-1-kuba@kernel.org>

On Tue, Feb 04, 2025 at 01:57:50PM -0800, Jakub Kicinski wrote:
> I feel like we don't do a good enough keeping authors of driver
> APIs around. The ethtool code base was very nicely compartmentalized
> by Michal. Establish a precedent of creating MAINTAINERS entries
> for "sections" of the ethtool API. Use Andrew and cable test as
> a sample entry. The entry should ideally cover 3 elements:
> a core file, test(s), and keywords. The last one is important
> because we intend the entries to cover core code *and* reviews
> of drivers implementing given API!
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - use cable_test as the keyword, looks like it doesn't produce any
>    false positives
> v1: https://lore.kernel.org/20250202021155.1019222-2-kuba@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


