Return-Path: <netdev+bounces-193812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B53AC5F26
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F04F7B0C92
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56A2D052;
	Wed, 28 May 2025 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA3TIGTW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE718EB0
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398577; cv=none; b=QIaRvJfBb9NIxWA+f6zDYlswqbLAfl7XM5t3JeSOrfzBjnkDGVbR0CfZMTxQZR/gNB+IrcwT6X8+oLzWu7sE2EZjIuFwxYXT2l/UZRc6hwDqmrM2gDadH0beCuWxtr/UDOyfvqVhwyPXR0yLyHRiuGpM+UdUieqQhApgRRCYl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398577; c=relaxed/simple;
	bh=BALfMBic2w3dWyLxkpvTFdKEzpTc82+wXIbasgQEg5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCROfrCKpn86p9NoGmqpa3xTtyW7HgHNnIZJujZG0y4VZTAWEYXokX+43bz5cFuaZx5ASk5koLUjWJWIW/pLMb1DrH84ibq+ayrlQZSa9Vw0dolI1LFf7mBJDmJyp3DvuXI1NrqhAD1QkgqFabXTZlAXbK9vjIxNbwbpr0lpgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA3TIGTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64E1C4CEE9;
	Wed, 28 May 2025 02:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748398577;
	bh=BALfMBic2w3dWyLxkpvTFdKEzpTc82+wXIbasgQEg5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BA3TIGTW56LnA61E7bpwVLKAw5zeCT1D7FlldW0JgJz+9Hl81jOWOs2NKhDBL8tvC
	 TmAbt1DlPzcMCkeUusm0eFnvnhhL+hD1Fms1VRJHi8g/sTkPerSZALcplFESXR5xJD
	 jXxu/G/WcCtkntHfr6iT26IxPtE5RSwVulxIwrZWzw7xEtqG8pw4h13FxRfkC1Fy8A
	 d5oTIs9Z72WJd4S/PbreMmcALb1NivlVqybxeZYriot4KuKdRicpCbjXfmEeBKvLHF
	 pTV9Ltu5VHCmpeIFhtDHJCeRpKFnCRWpv0K6MJ+kFkdbL95uBCAE41CXhe29YKokfZ
	 zxQn/8RRXpioQ==
Date: Tue, 27 May 2025 19:16:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v9 00/15] Begin upstreaming Homa transport
 protocol
Message-ID: <20250527191615.57502235@kernel.org>
In-Reply-To: <20250526042819.2526-1-ouster@cs.stanford.edu>
References: <20250526042819.2526-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 21:28:02 -0700 John Ousterhout wrote:
> This patch series begins the process of upstreaming the Homa transport
> protocol. Homa is an alternative to TCP for use in datacenter
> environments. It provides 10-100x reductions in tail latency for short
> messages relative to TCP. Its benefits are greatest for mixed workloads
> containing both short and long messages running under high network loads.
> Homa is not API-compatible with TCP: it is connectionless and message-
> oriented (but still reliable and flow-controlled). Homa's new API not
> only contributes to its performance gains, but it also eliminates the
> massive amount of connection state required by TCP for highly connected
> datacenter workloads (Homa uses ~ 1 socket per application, whereas
> TCP requires a separate socket for each peer).

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.

Please repost when net-next reopens after June 9th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

