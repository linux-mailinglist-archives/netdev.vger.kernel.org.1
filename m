Return-Path: <netdev+bounces-155635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F14BEA03378
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887A218857BA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894619049B;
	Mon,  6 Jan 2025 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4T9+0UW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4AEEB3;
	Mon,  6 Jan 2025 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207262; cv=none; b=bT+YXZFq8VrF5RxuXstm5cjWQNfqSjkEJdrWEp2LRJ2a1GLMNSqk0TijYiQnrTA4YRFRIETevQ2CLgtUJD6ER4BpwS1tyMsnlX1db+CPyvM22VdYORq1ToD9egvMMPGu2y7vLuW9SpbfIC/icx3ncEcpr5HCUNaExNrOwlCxu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207262; c=relaxed/simple;
	bh=sVo7soG1TzCZsb/f7XJxfwU8q9taGAAjjk9P4y6Z8e0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESccoMF42GC0LvbfQbFgAXCQZe0QPpyGk10/VG1EyrLcHhBX3Jb0lLW1nzBE7ReI0DDJL7HqAzsOoZ4XIqwsycjTxBq6s0K1Av4kHeHJgmHkZpHcsJBKg2969ZOxQkzAYeHIjroVPcxSd9nggx8J6Q9/O6Pyod1Rq+OGkmftaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4T9+0UW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE218C4CED2;
	Mon,  6 Jan 2025 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736207262;
	bh=sVo7soG1TzCZsb/f7XJxfwU8q9taGAAjjk9P4y6Z8e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o4T9+0UWqD7TLHph7Kcg52jnubZb7t8Hr/sSHslQTiakFVrTdLZqr87rcdXztZSOb
	 GaYdbn+TWLUQEqe1t7WR/woEHUELoCt1krLs6GNj+B7Z6RW1rPSe/u4OjfcIRqMGsO
	 uQPHuq7aV8WvWynTP5sVv87PnMks4ilNTzdM9dgIoU0mSNWoQjWUYeMEusWsKWUDpe
	 6/C2++P4WQvW4d5o/rj8X/2O7zawmKTnTGniPdyNsqK0c4YhWpYWsMPK3B/cGsmzMv
	 LT/bG/nnFefFzxUqfdPQClUzkqCBZyGxFAToBMtiFSHSMRihvuDA4v/yR2UjTTaOyR
	 +gS2YkCT8848Q==
Date: Mon, 6 Jan 2025 15:47:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
Message-ID: <20250106154741.23902c1a@kernel.org>
In-Reply-To: <20250105213036.288356-1-atomlin@atomlin.com>
References: <20250105213036.288356-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jan 2025 21:30:35 +0000 Aaron Tomlin wrote:
> I managed to trigger the MAX_PAGE_ORDER warning in the context of function
> __alloc_pages_noprof() with /usr/sbin/ethtool --set-ring rx 4096 rx-mini
> 2048 [devname]' using the maximum supported Ring 0 and Rx ring buffer size.
> Admittedly this was under the stock Linux kernel-4.18.0-477.27.1.el8_8
> whereby CONFIG_CMA is not enabled. I think it does not make sense to
> attempt a large memory allocation request for physically contiguous memory,
> to hold the Rx Data ring that could exceed the maximum page-order supported
> by the system.

I think CMA should be a bit orthogonal to the warning.

Off the top of my head the usual way to solve the warning is to add
__GFP_NOWARN to the allocations which trigger it. And then handle
the error gracefully.

