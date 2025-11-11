Return-Path: <netdev+bounces-237412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF4C4B2B0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67A9834BFE1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF7343D6D;
	Tue, 11 Nov 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZCHUiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA32F83A3;
	Tue, 11 Nov 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826869; cv=none; b=GIQ67YnVNeRVYIW597zcfiz4dZQgXkS4eu49BmKFPZfCbaXUCZkk4pZwXa30eWovJB9b7yrZgWgiYIKGULjLLtDy/MEAnz19LMKtAPJshMJlgDv4ZJEnOTkHddqcAV25S2s4IpH5SNueblXpde0J7YMoOf9feSGejxjLzatjVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826869; c=relaxed/simple;
	bh=K4WT5DI/LVHmAVyUF3Hc6XM6+Zcclzbiou6WsDsETpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjKBcFxoJOq7MkI1cJhwL1k6RGi9GA9SgurhR9XjNFhXLb66uD94RwxqkXmtxpi7K45sIsi9HfrPOUMBn91ycKAKBYocas/Dyu0ha/tzW0gMoB2BzgMu7p1LD33dl6Rly7ZbadBrsor/AVwlSA9IyzmYCRtjJbhUbvDLK7uSVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZCHUiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7441C16AAE;
	Tue, 11 Nov 2025 02:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762826868;
	bh=K4WT5DI/LVHmAVyUF3Hc6XM6+Zcclzbiou6WsDsETpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fpZCHUiNdE0INp+y8GKME3KEFMZP7wbF+SRaAFqCm9r0dO9nv8bKtxUTbh5vgtnkS
	 r8xmLUbrOjhq3B9dOHBqVk1hwDEinn21GU4jhPJj7mxInE6FAabmZYxM38FAltWNha
	 4HAdZdIa4Rhx7kXxpRRwdCm7UmolwEQgxr2AXVElO54EBYKUgTilEok/fEbcH30niW
	 h98IVyANHih0auZWQD3Gsn0Amt0T3c4CFkKDWhItb8msGb72/NPq4Awb8DCxtnuW2G
	 sKxWTvOMpN4RLf7Cu0VLRwfMra+Sf5Vm7bgBzsZD2tus10HQRXiix2T8Gk16mbs0zl
	 7EmR5PHMgEfLw==
Date: Mon, 10 Nov 2025 18:07:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 00/11] wireguard: netlink: ynl conversion
Message-ID: <20251110180746.4074a9ca@kernel.org>
In-Reply-To: <20251105183223.89913-1-ast@fiberby.net>
References: <20251105183223.89913-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Nov 2025 18:32:09 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This series completes the implementation of YNL for wireguard,
> as previously announced[1].
>=20
> This series consist of 5 parts:
> 1) Patch 01-03 - Misc. changes
> 2) Patch    04 - Add YNL specification for wireguard
> 3) Patch 05-07 - Transition to a generated UAPI header
> 4) Patch    08 - Adds a sample program for the generated C library
> 5) Patch 09-11 - Transition to generated netlink policy code
>=20
> The main benefit of having a YNL specification is unlocked after the
> first 2 parts, the RFC version seems to already have spawned a new
> Rust netlink binding[2] using wireguard as it's main example.
>=20
> Part 3 and 5 validates that the specification is complete and aligned,
> the generated code might have a few warts, but they don't matter too
> much, and are mostly a transitional problem[3].
>=20
> Part 4 is possible after part 2, but is ordered after part 3,
> as it needs to duplicate the UAPI header in tools/include.

These LGTM, now.

Jason what's your feeling here? AFAICT the changes to the wg code
are quite minor now.=20

