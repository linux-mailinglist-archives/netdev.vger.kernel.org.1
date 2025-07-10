Return-Path: <netdev+bounces-205913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D302B00C59
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32B816C721
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01702FD867;
	Thu, 10 Jul 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9W901Hc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4807156C6A;
	Thu, 10 Jul 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177188; cv=none; b=Mraf4ubCnwDkLCHGC7pQfTqhbpsgcUUHEpsTwr6yNcP7WSju4bsScabF32nOuGQQ5KNW7AZDoQGpavjOU5ZLewqf7JCUG9PIAxzhVq7mbvzTNsaJr7cB9rKleVjQMjkpeYL9cKJb9hC3oHhUlJU0i9TVtaZNMty+SNGIn8jJi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177188; c=relaxed/simple;
	bh=04NzIDcpWH+kogLzpdZlTvVlQunMMoZqNMTi4fv4Nxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfxiDFfJIbYuoX36QqZaieOniIwcb2sTD3Rl3iY/PsKW7Srlno89FNYWzG/qLOV1rHFDw5Ss/4hwTkV3s97RDqx5weC35ZwqzhGjGOYphddT+L6IDtd9WhUfuWB1wxqoteAeYaYfFk1Td/3c55paf8sVk0IerVapAL4s/ltvV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9W901Hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA8C4CEE3;
	Thu, 10 Jul 2025 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752177188;
	bh=04NzIDcpWH+kogLzpdZlTvVlQunMMoZqNMTi4fv4Nxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9W901HcXPk01asEiheK5ZP9rqGoL2JLV4rii1l5MgJFOhCS2FxR+vpXUZ4zflh2k
	 FdBV5lMrd2qMY94Cv4SEe+BxmZ/Ss7uZErBwK59/Xr8VKRLqjUSpyS6biFszO4FW3U
	 019jKOkdXCo+sdTrHmYbcWyAqu8Tu5COOkzrhRhFaJ4YtFiOrz/n+P01hfoaoT7ll9
	 AOvV1qlyfkKHwAqaxvaYBhPHm3etHzHyxjEEolrSFreI8XjkO39d1BPph+idsy2RV8
	 0GLVNJy/IkQhzWM222k4N23VLucturHHm/rq7kQ56K8KX0SDYtHdFLPg9sjag8VlWJ
	 vBw+8pXNn/lqA==
Date: Thu, 10 Jul 2025 12:53:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.16-rc6
Message-ID: <20250710125307.1e6efb1f@kernel.org>
In-Reply-To: <20250710124526.32220-1-pabeni@redhat.com>
References: <20250710124526.32220-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 14:45:26 +0200 Paolo Abeni wrote:
> A slightly larger number of regressions than usual, but I'm not aware of
> any other pending ones.

Heads up that the netlink memory accounting fix in this PR seems 
to be causing regressions for wifi:
https://lore.kernel.org/all/9794af18-4905-46c6-b12c-365ea2f05858@samsung.com/

We will ship a follow up by tomorrow afternoon, with a fix or a revert.
There's also a pile of wifi driver fixes that came in late for this PR
and that we probably want in rc7. Or rather don't want them in rc8 /
final, so those will come along as well.

