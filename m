Return-Path: <netdev+bounces-69345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1AD84ABBA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF40F1F2514B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19288137E;
	Tue,  6 Feb 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLoqMAFn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF41373
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183698; cv=none; b=OKOTv7fdMc2fcuN/4AJBk9Gz6aEH/z+0e3sjTp1ozHtpkOrvwUbejrC4CyUHmM4PkpoZvFZ+hcafx6x3WszFJTvMre4CVdnWYH7YBzmOeUkskRWMUzd2cbeqHLcRRTNDvkTQYM6bcFGFWziw2qLQvalJKOU29vPcWkKCSl2fJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183698; c=relaxed/simple;
	bh=1kxUlv478WcpxZQXGXfoQYsLRnW2Wv4iUtvSLs69hd0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=F9BYnmfTmIZdjUXSnEmR9GMWiwjrJiMJIqdP0QSa2kB31Pv/0jv8q8Etv2zX1MpjB6gNEZvCUKCUI9dhBdFiP3787eNdmEF6fvzp18pdAF7INpJI8JQ/GEj7GKVIRdcFsDll0CR+trqLQz2DUQMRg+nUJw0S9vfo1TrwI81v0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLoqMAFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DC2C433F1
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 01:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707183697;
	bh=1kxUlv478WcpxZQXGXfoQYsLRnW2Wv4iUtvSLs69hd0=;
	h=Date:From:To:Subject:From;
	b=OLoqMAFntA1TRHcs5H0rmNdF2s1F7UeSo76axC9/Ia6b1S4UnxNN+/GTLjODVQ61m
	 CL8xaku9D1yZonKqyqwGkgXFOi+HPXM798WN5ipnN2rfSThxwOi8cxwOdXzWZHHSlk
	 fkoexr+T8AqqIVfeiYd2kE7qaBhXPM9fDpAerWA8r4Q7KV/5F0tPCzbM0oRbZhC+vh
	 fOm8yWlwzAuOdmtCqRV0gwsgDHSweoa6Ic7odwO0UNGmfqefDzLjfSk5LJOI6mHdLG
	 0dTQ/Hsk98nB7OaJZYIFfkLe78W+9EkaXFo0g+59OprlFQacoZA+LS76IGmyB/DYlP
	 tQVEDMKXUxI1w==
Date: Mon, 5 Feb 2024 17:41:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] The no-kvm CI instances going away
Message-ID: <20240205174136.6056d596@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

because cloud computing is expensive I'm shutting down the instances
which were running without KVM support. We're left with the KVM-enabled
instances only (metal) - one normal and one with debug configs enabled.

