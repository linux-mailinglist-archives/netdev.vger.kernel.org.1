Return-Path: <netdev+bounces-197250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1287AD7EAB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1374174B2D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D58232369;
	Thu, 12 Jun 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bassEZNr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3A153BD9
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749769043; cv=none; b=PTT2STC6XaI9gTkqbeGPWSjAzrWdKslTt1AS9XFZ6EvR7XEwif3iP5hYKx7w5H3UmAlD7DNCB/OOYNckKUYmc6O/Gwohjhoj+C6UPpudc4Xqh8XkAiTUahy1VuS3tBwE3m1UWkoy4TdFrsqzvCH2tYqUbkmWxI63v/7Zz5qIi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749769043; c=relaxed/simple;
	bh=ykd8RMALh+FdUALg8KX24gUcm7zV+uiH0gak7IN+QcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3M/7Fo2dW78NdS7H1i8O1X1QWQy6Kh/cTiER+0fr2PcL96Rhr2IenIElXZo0PfDV4YigpZkJeECaIOHsnGyOjzfyWCZKVMwpbhxQw3zZhhOrhTWjbxFZ3BipgoSPpXbCsNwHFxgThbrL1h7IOraBCOWCpfo79+SYOeawgcWa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bassEZNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF88C4CEEA;
	Thu, 12 Jun 2025 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749769043;
	bh=ykd8RMALh+FdUALg8KX24gUcm7zV+uiH0gak7IN+QcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bassEZNry6kd0FxoEjj3OZds11wg8zyXxiinwQKUNNZ9d1DWAymwA9WtsM60Zm/A1
	 Qc9n+tB88AX3JOeZ6aB7sAooB+oDrBJZd60+6IjglPshNVx7FJei6c0a/kkIwp3tPN
	 75Z5kgoPW5boNXY8b/dwsUiRLVYr/kH5Gr9IcNSFFHVDSEDRj5NtCCykhkp6TkkO6s
	 4OYf1sohglFKMx3W1naaWODcpQIqIaIsTZVujtLmsGm4jAE6tNVkXb+jacNtqAROb2
	 BVhv3SbYtOJC7TLvZdVoDagGoQEEAYfzGiSinwI5+nS6AOeORKdn7Oiz9iUHFj5jO6
	 0bqn68VgBUrTw==
Date: Thu, 12 Jun 2025 15:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <20250612155721.4bb76ab1@kernel.org>
In-Reply-To: <aEtAZq8Th7nOdakk@lore-rh-laptop>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
	<CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
	<aEg1lvstEFgiZST1@lore-rh-laptop>
	<20250611173626.54f2cf58@kernel.org>
	<aEtAZq8Th7nOdakk@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 23:02:30 +0200 Lorenzo Bianconi wrote:
> > I'm not Eric but FWIW 256B is not going to help much. It's best to keep
> > the len / truesize ratio above 50%, so with 32k buffers we're talking
> > about copying multiple frames.  
> 
> what I mean here is reallocate the skb if the true size is small (e.g. below
> 256B) in order to avoid consuming the high order page from the page_pool. Maybe
> we can avoid it if reducing the page order to 2 for LRO queues provide
> comparable results.

Hm, truesize is the buffer size, right? If the driver allocated n bytes
of memory for packets it sent up the stack, the truesizes of the skbs
it generated must add up to approximately n bytes.

So if the HW places one aggregation session per buffer, and the buffer
is 32kB -- to avoid mem use ratio < 25% you'd need to copy all sessions
smaller than 8kB?

If I'm not making sense - just ignore, I haven't looked at the rest of
the driver :)

