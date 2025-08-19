Return-Path: <netdev+bounces-214810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5497B2B59F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BF33B95A2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3E188734;
	Tue, 19 Aug 2025 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXUpGYPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B03451D0;
	Tue, 19 Aug 2025 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565142; cv=none; b=HKz4Fzo2ANKnHo94ltHL3UJ50oOQBBrt4Vo/8oV4Ybts8iBdzyc41GnQzxd9neY0VMLEpr5nOHWhDT9kVTySbHp/CoMrZDU74PBP/LlC+zFI8ShNqcik+wGESADBx8G8+crhvV8ISG0hMoSonStquuB5ywqCkmKDoZtkwefFks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565142; c=relaxed/simple;
	bh=9T0dOVwu+vVQ2RIasShYoplaSomai6cPaXmNmicLnmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNj5yMeQN3caLPImIuAkcwo78IPX9Iozae5cVRHL7Tq0Qm17t8YyQJmdxWZFX3XAf4xhZhtCYLe/6RuFB6QvOTr6EJ/DW4rkXC0SK6J9uBpe8oXNt4m6g2hI1oZiQylDUI+tUlpBgMhqlhLad2CcZvcQFu2pZuM7Mo2Tz2+NPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXUpGYPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DB6C113D0;
	Tue, 19 Aug 2025 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565142;
	bh=9T0dOVwu+vVQ2RIasShYoplaSomai6cPaXmNmicLnmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OXUpGYPD2EptVvhF6t0cFflJxmpkK0zTxgqQLggSfl1DMWH5GOH3oAUugVeOaa9mw
	 Gc+Eil68ZGUMn4UyuHScv0HHGAScdC2bsht1MHE44yTWE49KYfwymM9nBDdM6TOath
	 df1bPZBcDCDuX01vOgqmuv4iXD/8yjU8TQKL1fULsZoYsmlMlg9/z7wg4iFeHEx8iS
	 nnlTNs3TySJBLzsMvGP+zFT18PRX4V2SN/ifowGYgTqZ23yZ0nEdGJNP8aICBiSQ38
	 wWlbHF1HRZeTlyhNxyc7Aza+hEAr0CYK5CZYpEei9JqzLYpyVP6glT3Zdh3v/V/tro
	 99HxochJ5yhtg==
Date: Mon, 18 Aug 2025 17:59:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Osama Albahrani <osalbahr@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Fix broken link to cubic-paper.pdf
Message-ID: <20250818175901.5b499b8c@kernel.org>
In-Reply-To: <20250817133945.13728-1-osalbahr@gmail.com>
References: <20250817133945.13728-1-osalbahr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 16:39:45 +0300 Osama Albahrani wrote:
> Use first Wayback Machine snapshot

Maybe replace it with a title + author?
The links keep getting stale, and for academic papers the reference
should be pretty unambiguous.
-- 
pw-bot: cr

