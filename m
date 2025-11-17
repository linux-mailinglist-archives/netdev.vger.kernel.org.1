Return-Path: <netdev+bounces-239170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FADC64EC6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 959F4340F6C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA4279DAD;
	Mon, 17 Nov 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQv/XZQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01527511A
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394041; cv=none; b=Sq1iWhGC3R/OIL/5M/ezXAO+VMIJI/EG0Q24wRCysJzLTbyVWfBZH/QaQpSSIp4qmYxpG6eJdhnNRn2vzJRTnT97IGLfBjs/FBLrhnuH+phGAYAjusUPLwMrtHlAXFE44PjXsTWUXVc0MuciW5Ue/Yd4qufrY2rMUZBk+5OyOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394041; c=relaxed/simple;
	bh=CK6+m5JOF8NGsq5GvbbHRHbK1eiNpV1QWcAS3+3APfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAlivuPDibxUQblJVQuXHjNBSlfaHDWVVBeMkO/PS/KZAIn/Chb3vULrZRRRGWOJaTNwgwMV2LUyLS1StNFn6KxkEop/ZhTSWVlPWMdE8dhqQHl6m/e5659P7Fq+iFAwFdmQfRFuUsQXspd1/oGabFzLkp58YizynOW87Voxofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQv/XZQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FD4C4CEF1;
	Mon, 17 Nov 2025 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763394040;
	bh=CK6+m5JOF8NGsq5GvbbHRHbK1eiNpV1QWcAS3+3APfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQv/XZQKDKwhLYcHgxlN8C2Pexfjlt4fjhvZxl1RZ3NuQFscbAhz35ityaEJeZrx8
	 SD6WZ2nGLbSZBzeuW8XZG4465rYSNlM2AwaUGscyEeTYr050Ws6WKnsPXU+5vEoUTz
	 L9LqeCd4rMr6QLPXtw2Es5noWqrHdzAvgGbQzttO6jFcyucMRIm6GKR038fFrg4cIN
	 hCHOQKf+KwcnMPg92uk+m9U7za+XNeLHjH5ox06ezUElKJMlm8oM7qIJvgtM+pK3wH
	 mzB9KhShTRWjzNxRSUpBC2DRx0nlhiC9tlyUQyMUm/6Y6p9CEBRMQZV9cHZGDDAjvj
	 1GkHhSh/qBXSA==
Date: Mon, 17 Nov 2025 07:40:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: xu du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnels
Message-ID: <20251117074039.31424f12@kernel.org>
In-Reply-To: <cover.1763345426.git.xudu@redhat.com>
References: <cover.1763345426.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 14:24:56 +0800 xu du wrote:
> This patch series increases test coverage for the tun/virtio use-case.
> 
> The primary goal is to add test validation for GSO when operating over 
> UDP tunnels, a scenario which is not currently covered.
> 
> The design strategy is to extend the existing tun/tap testing infrastructure
> to support this new use-case, rather than introducing a new or parallel framework.
> This allows for better integration and re-use of existing test logic.

Hi! I haven't looked closely but the new cases don't pass in our CI:
https://netdev-3.bots.linux.dev/vmksft-net/results/389682/14-tun/stdout
Please see these instructions for how to repro:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
-- 
pw-bot: cr

