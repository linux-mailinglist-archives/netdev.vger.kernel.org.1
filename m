Return-Path: <netdev+bounces-142169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D69BDB0C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CF81C22481
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD9186E20;
	Wed,  6 Nov 2024 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYcfJRGz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84331EA91;
	Wed,  6 Nov 2024 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855768; cv=none; b=YORS+eyinxxTb2vlzvfmFscUBJYhbgzVdMK+hm8qV7uly1O/+15jTqAIbpNCh/rDVh6hJ7ChABA200K6FDRkdzAa8p2J8LppWw1J/FQIErF/aynf9GvMzC7yAf6pWdnykZpcAzsD1wyLTF7hj8nmk/LuJnobXNsg/mUqQbctirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855768; c=relaxed/simple;
	bh=svZotiWug5mCuHoOIxCvTAaQdWf8Cc3c/+Eu+/tM+94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leULojPP9qI2PCgSycqnt6DtJXWsTgffE/EtVktH+zXQKpqa/KPIRjzlb1UutVbA6MFPn7Rdw801vA3AnUJiI11ODhCbrrtrWTcu7wzlozpQVfucGcjb4cbRh2fx772ivo6E0VHVFmO2qUzMThIhyy9p5wDVVRP0NZUQDWWBs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYcfJRGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB00C4CECF;
	Wed,  6 Nov 2024 01:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730855768;
	bh=svZotiWug5mCuHoOIxCvTAaQdWf8Cc3c/+Eu+/tM+94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fYcfJRGzrIilpwNtcxl1QEv4BG6Ov4XXCeQWZtVXXMvNecrf/8YlZIhJvPDsbbsS7
	 m7dZL67p37MDREsqmxA3ru9hRG2QyiX5d+YHk44oK9mVIdYZy9BPzSGri3uO9Hyk6c
	 TOJ5lHJL0pqod/14xjws6NzPV2ZBuPv2QboEmf0OQ5d/Mc0FWqvVeW189x6mbqg7uC
	 B51qETkmpjwGX7Wd0qXStbNAo9mwTLkENGV+1O399Rc+wTcB1rfOWT+eAt7SKE3rGk
	 ++AaztH2v+O5j4vqOq36hBounbR3krgcEOBBg5JLjZjPcRWAiRLBBvP/WQmTRHLL7n
	 bNen9Q9tYHYfQ==
Date: Tue, 5 Nov 2024 17:16:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] sockaddr usage removal
Message-ID: <20241105171607.48c0c24d@kernel.org>
In-Reply-To: <20241104221450.work.053-kees@kernel.org>
References: <20241104221450.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 14:25:02 -0800 Kees Cook wrote:
> I think for getname() (and similar interfaces) we *do* want to use
> sockaddr_storage, but there is kind of an argument to instead use
> a struct with a flexible array, e.g.:
> 
> struct sockaddr_unspec {
>         sa_family_t	sa_family;
> 	char		sa_data[];
> };
> 
> If this was done, then all these APIs would switch their casts from
> "(struct sockaddr *)" to "(struct sockaddr_unspec *)", even though in
> most cases the object is actully a struct sockaddr_storage.

struct sockaddr_unspec was my knee-jerk reaction but looking at the code
- indeed passing struct sockaddr_storage seems cleaner.

> What do folks think?

Looks nice, and feels like the right direction :)

FWIW if the conversion work is too tedious I think I can find some
people that could help.

