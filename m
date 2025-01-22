Return-Path: <netdev+bounces-160432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9EBA19B60
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E547A54F8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 23:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662681CAA84;
	Wed, 22 Jan 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2sVWvdz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FC1C5F39
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587626; cv=none; b=jA1xeMcgAwxXB+jrfrbdpuoT/WuNDV5EBqrGytxMGOBgllw46yH66GnrfF+o8Cb6vHA/9eORWW/1kylb10Lggzo5PeMX7H5Co/I8Sq/AoOjqTjaeugOizDw9H0woX0LcHxe1OYbRLP9DqExofn1nsLP9Uyq1Y2TH6b+T6QLq6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587626; c=relaxed/simple;
	bh=7/dt/qBpTfAuEMLauE9KGpAoIRe0Sj+95CGwygAU6rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JN8RTii6ETYdZl0cPJA9hwx+EResPMwZDuvCh2a1yzANx7EpKZCWQeL5YaLMAHCyLuoS63S9oD41mew8tUm4VkeTeJWuQlR5emZvKysIjxg7z8bfKZomrtaGVN0hqfKTpsceCcRRxSdPSNhad7e7ef3niduogovNe4xvF3nkJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2sVWvdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68594C4CED2;
	Wed, 22 Jan 2025 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737587625;
	bh=7/dt/qBpTfAuEMLauE9KGpAoIRe0Sj+95CGwygAU6rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2sVWvdz3mi8x76pS9mw09svmnBlMMXT6Ggya9Ldxv0N3LjYTYEwhcEx+79JOIlPA
	 9BYJ+AqSc1E8I92nTXmUDhzu1Eh3k7fu2dQU+TlNvtRU8KtsLTftYrCnB3QZGRP8As
	 RuSQIFB1i2uCf8nx6aU9IUKjtF8BsCbKFMjhtcqQOajFktCmwAxseegvDVx7oRLJk/
	 C9HDwU4U3kLY9lJ1YSkDMPx1mDNtl/Uc+69xRmX6C7I+wzma9DbO0cfyQgcf71Is03
	 vFzYiVSwk1z7VK2P077UCOyxZSan0NGcse8vmUzdpUe6svRiZulA3oc48uzz2TrEL1
	 Wg5LhqVwha4fA==
Date: Wed, 22 Jan 2025 15:13:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Edwards <mkedwards@meta.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>
Subject: Re: [PATCH] ethtool: Fix JSON output for IRQ coalescing
Message-ID: <20250122151344.03f55b59@kernel.org>
In-Reply-To: <20250122181153.2563289-1-mkedwards@meta.com>
References: <20250121181732.4f74b6a6@kernel.org>
	<20250122181153.2563289-1-mkedwards@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 09:40:15 -0800 Michael Edwards wrote:
> This diff will change the first rx/tx pair to adaptive-{rx|tx} and
> the second pair to cqe-mode-{rx|tx} to match the keys used to set
> the corresponding settings.

This has been broken for 3.5 years, so I think we can assume the old
keys weren't used:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

