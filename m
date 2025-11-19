Return-Path: <netdev+bounces-239776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F13C6C549
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D59D4E4AFA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328E266584;
	Wed, 19 Nov 2025 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smLuzY2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0D23EAAB;
	Wed, 19 Nov 2025 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517985; cv=none; b=Az0DsG0WMmEBbfr4AkqiHF2rC3UJwrCiU9/j7OxIoTSjAVu+YXFFRgt5vNJMCTcMlxHu4KcwQqLEvVIzhbp8N3TSVB/gAKgcVaE8uglTcfdWKKMhYoWDRjcX/VidXgaM2NEl6ZyLJGOL9I9ySH0e0RtKXtJbeVQ13HxQceRHZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517985; c=relaxed/simple;
	bh=ov8Uqh6oWtBY7OKxa6uJlT6ObYamGTMrQ8wvTquHfFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjLRaZBPNrnWsGiuKo37cG58DTkKEYR7MGQn8lMqm6NjLtG0g1YwMXWeOM2SHNVj8jz9bDdZLzp5JY0DUsMM3vRHRk/iErbEKTHrMDyfCYIBtFcjLidgW/HPDVYrdmz0er3Tq2L2JQZR8dVJORPN8dRs1JnX6x/Q7mC1wDeBLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smLuzY2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCCEC16AAE;
	Wed, 19 Nov 2025 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763517984;
	bh=ov8Uqh6oWtBY7OKxa6uJlT6ObYamGTMrQ8wvTquHfFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=smLuzY2hKDUMmmr6YVYU6Y9V1aOG9zuQ/T+4rgbEqQM2aeKnPE2afX9A2j7E4bYGt
	 iaej3xW6BaQnBk5rI0C1tZ4e97lPM2KLKj7U7uabvSMGB0l561diqYrVUZOrlKUhGd
	 V2AUyL2kw3lDK+1yZOR7rGQYr+XvxAeiceTBA54pnz/rKMHUw9+80p42PzIfRnGUgr
	 Bzq2Z2dUyxvbLQ2eIqcjBMaQ/5QMWGwQJk1e+KTywl5R3isRIILO7KCKdz/ElB+06T
	 WY+RNtGw2DRjFxcBIQIahCZthF8TsecQuCNS75O2Pb73toUsilK7evD08R7oU24FAe
	 9VllllFEnzKGw==
Date: Tue, 18 Nov 2025 18:06:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1] r8169: add support for RTL9151A
Message-ID: <20251118180621.41a9cc01@kernel.org>
In-Reply-To: <20251118075217.3444-1-javen_xu@realsil.com.cn>
References: <20251118075217.3444-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 15:52:17 +0800 javen wrote:
> This add support for chip RTL9151A. Its XID is 0x68b. It is bascially
> based on the one with XID 0x688, but with different firmware file.

This patch does not apply, please rebase & repost.
-- 
pw-bot: cr

