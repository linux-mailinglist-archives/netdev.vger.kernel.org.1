Return-Path: <netdev+bounces-246806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485CCF140F
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8B33007FD0
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFE2E6CBC;
	Sun,  4 Jan 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9rzEf25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A832E6CC5
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554141; cv=none; b=YoYv/yr1Ati+zVYXJjCMuKH5fH+HCjX6FX2ZmaQkd4UpwJUuz0aSKuXf5KtfVYMdaIsq4cP+S7d8WEXpOSQmLegm6Gki+aHlIrSJxLN0ItBYyLkS5mcUoxwIXhwxhQo48BZqTUUIukIyFlmp0laaCltO26W16kYHwTZgrYakkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554141; c=relaxed/simple;
	bh=dIosZkwP12BsXT7ksW4hx+adYW8gcZRJiAI2AsvEGIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUmFVhGtdOqOTWs1p1RNQQwRckAwqsqwXOv3I8P00cnMpmM4+jj8jemUsLy2DvQKOxjFt73SWHQyOVjjXhopOginPadBqRoETcG/CuahpkP96GSJQn2kvfemAvk5dtvG1Ov8r51eQreOhxuHggAPfgeH2fd4XJ2YyAWtgYO2K/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9rzEf25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D52C4CEF7;
	Sun,  4 Jan 2026 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554140;
	bh=dIosZkwP12BsXT7ksW4hx+adYW8gcZRJiAI2AsvEGIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9rzEf25K1THcNiCSxJMP8OMYIo1JBjhLziuB6w1DKzjST2F2cOsqcvP7N8C4T8DK
	 w8r5xKIIj11xIXME8ijMFsBE5IJ1EwRO561bSYM/MU25ZY+i9nk3vF5b0CzfjxJmii
	 epHfMD3i9mtCtOCgXS/Fb8cNlETytXgpLydYntxMdS7LC81VEBEL3SnVEV9xBy+2DB
	 dUFCmg6RQ/Q3P5s1YfrjWG8v16vlNSN8Yd+jBwFS+yE8Q6Zksh7+1FILC53XItR1Fy
	 ziF+MtevksFfpv4iIaRKvdoaaz10oA48HM5zt8ga/k7Zo1NaG/ZEB64rjDuxH9PldK
	 kXSiBOoDG4jIA==
Date: Sun, 4 Jan 2026 11:15:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [Patch net v6 6/8] selftests/tc-testing: Add a test case for
 piro with netem duplicate
Message-ID: <20260104111539.61f97ad0@kernel.org>
In-Reply-To: <20251227194135.1111972-7-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
	<20251227194135.1111972-7-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 11:41:33 -0800 Cong Wang wrote:
> Subject: [Patch net v6 6/8] selftests/tc-testing: Add a test case for piro with netem duplicate

nit: piro -> prio

