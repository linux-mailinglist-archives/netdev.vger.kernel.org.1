Return-Path: <netdev+bounces-210556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13400B13E60
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B73166A40
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED479274659;
	Mon, 28 Jul 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmflJWGr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D42273D7C;
	Mon, 28 Jul 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716533; cv=none; b=s6y8nXN8S1jUIm1UE1RkMQ8FHMvvEyqRLymjGnZcPgu/t0WIQ6AQ9GfzZLAzO4s064aWjdq/q64PxRI6wbWrCfU/9dRdSmf6iv66pd6aaOHTQf82iKcWLc2DE97IoPcFD2MxLkPErYpMys58+saN/JWWeWivCp5pNEYPiVg4pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716533; c=relaxed/simple;
	bh=lPiDGpZFpdH6itgC3rcfg1u0DDgdbAG7h3QwQTSxGz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y78vVwH74hXP0LhFlbu9mt2UjsqfwUJt00t2QWO0bcEE4LG8nAxTZJZQo0PhhCAKuLS7Bh8Pr/IgJaPbhVsjixWmhUxSP3jSTZyk9eXxOSN9zJ49psHW5+T6Lam/lyMdiwBvCMvUxsyEPowt7tD0FcAC+ViKf384wIj7BU7a1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmflJWGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01CEC4CEE7;
	Mon, 28 Jul 2025 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753716533;
	bh=lPiDGpZFpdH6itgC3rcfg1u0DDgdbAG7h3QwQTSxGz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmflJWGrgqbhGLWqVxqvw4Yq4qHbm+pgRuCev4GyeV1j2aAeS3HB94b6/1EGL4mIf
	 idZBrQtkA2SmHyKpO0xqzOndDVDewjc6byd+VyxNgF8b0+Etz0Ee62AnwveT+RgrQV
	 ywyTuzLoupa5h7V+5rvRd36XDA4YItPeALYBxlQF+x1P1T4weIm84/HMtU9kEpx8TX
	 WbD3UBTPLEYcf+lwWG0ro2jXtozr+K4eVCOZLDRmDf2KCbjj9iDGQveL2z95d/Ag1N
	 nJWkzVdosnzwEA839eeqx2paRzs8SuGcb5KJcpE/8jC7RNoXHegSUncLdUyHxQIyv6
	 SGrC0eVSBOI+w==
Date: Mon, 28 Jul 2025 08:28:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon Horman
 <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/7] net: airoha: Introduce NPU callbacks
 for wlan offloading
Message-ID: <20250728082852.158f6829@kernel.org>
In-Reply-To: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
References: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 16:40:45 +0200 Lorenzo Bianconi wrote:
> Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
> the MT76 wireless NIC configuring the NPU module via the Netfilter
> flowtable. This series introduces the necessary NPU callback used by
> the MT7996 driver in order to enable the offloading.
> MT76 support has been posted as RFC in [0] in order to show how the
> APIs are consumed.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v6.17,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

