Return-Path: <netdev+bounces-66856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D531E841339
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EB21F253B0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEED153BC8;
	Mon, 29 Jan 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAd/I+0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F276041;
	Mon, 29 Jan 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556059; cv=none; b=KEN8FovF5fNT0ElcP45phEY05ug79kNECqC+P/77orTqSzYVWAV49Ph6FqZWZR0wzPCShFzTOwC6QaadBu7e04K4x5+QoUP1Sb82QTUlDjGlsLqPlC71b8BVAb4v1BEbf2XLN2JDpqXtUPiJCAQBPlOxm64Hrvpygyp9OEccq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556059; c=relaxed/simple;
	bh=IMy2kDNdaeaOGydA471KIv8mRgYqwEbm0IYcSVuHj7Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=X1iKRqulLGN1U2P7J+CR2/OYbHK/Fuyg8MK0/5AlJWKYf4UJkzqcWu3LqdkEal/gj13/BjyMIK8i5Oxvc2QNTeuO75JGgUa+ObdLlza/EHtAIO/IPxO27FPDW5O/mlZHCGVQ84d6za5ErUiTh2DYXgY6bVkoSXw/n7UEFbBvTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAd/I+0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E397EC433C7;
	Mon, 29 Jan 2024 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706556059;
	bh=IMy2kDNdaeaOGydA471KIv8mRgYqwEbm0IYcSVuHj7Y=;
	h=Date:From:To:Subject:From;
	b=kAd/I+0KUtbG3uTIyTeKWER1SHiveGMzbhqiAQFf+oml+IfmLJLoeFJmSX7HZuHVj
	 nuM2QyR7dZeGmiu6P9x7wSv1/8gfqjQwglKif0KoZFBQvgcxvSWrfnl4PgUvtfFiOC
	 5wFAhUgSpkaSp+E08M5X0Z4QUW6ip6KhOA4CRdND1yzSB1k2ktpwfbM584z8DAqvnz
	 8UYKj8baIQoAsINNosfiOwqhsDxSIfcYKPqIXWh2MEhY1S8dJ1bTCPu2LgusyaGpVS
	 w23cVW1yuQhMUI93mgqu7L+BwaZCPzcuBrF9Li+6ESczDBR/6Uecp7drWrbE4WSEnQ
	 a7fRBYA2ZiX3Q==
Date: Mon, 29 Jan 2024 11:20:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jan 30th
Message-ID: <20240129112057.26f5fc19@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

We'll certainly go over CI updates, but please feel free to suggest
other topics!

In terms of the review rotation - this week's reviewer is nVidia.

