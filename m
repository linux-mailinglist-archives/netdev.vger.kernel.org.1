Return-Path: <netdev+bounces-238030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C97C52ECD
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1135389B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7EB33D6F8;
	Wed, 12 Nov 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NATvYEnD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544933BBA4;
	Wed, 12 Nov 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959442; cv=none; b=s/vYBAKCPQd4vd3oXL03IStH/A6NiVr3mIWIlGaZpnhn3gZQh6zQT0MeYGtpKcB0O3q6n2Gts5/tYtn35AsYcIaONeG5GUOsxEkvSFyP1x7z4p7IqA1ynBzWShGNjv8vbgrybccOdzyVjvU7QhGeAadhhewm6Y5uRdo9/rKbqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959442; c=relaxed/simple;
	bh=5xBz4HsC6lNkPpfpPsm7ohmMixPyiH3CxITYUK1Do08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N474olH4baySBzSZf/9GMKNCIucAeiHQBBUXrgI78jilB5AJAbXInnIDwd+3Q4T68HLAUNKk+5HhQax28Q1tSLN4pCBh67vRVCoGLjZe0gYaV50Rpnkm67HroyUfAWP1ESAbhmNZH6+pdoz2fXn3OVOzjYHPNCy8jDqKFMaW8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NATvYEnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC66DC19421;
	Wed, 12 Nov 2025 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762959442;
	bh=5xBz4HsC6lNkPpfpPsm7ohmMixPyiH3CxITYUK1Do08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NATvYEnDqpBXuxiSQBGqf7jsc0R7JWOZmMQcmRHdjZUnMICciuBiEOqIqeQ21/abT
	 G3r21SoZ+Jy6VUOQs2xU6OdnM8nM+wVCP7f26ggFL60i8bUjAqfgwVPFfiYu5zDT6o
	 ukPrQ5jDJ7+n0TTlLmv1/7qLrGmqgPRNKZDfnb6Yryy3D7z8rQTCltzHgwYHtgDmZR
	 nya41DN0KieLgENo1Zk70cgpXhwHscCUGLxAVtpze+Hf+FVSEXpAbdQym1MxVfcxl6
	 i+QyVv6OG0S00f/fmgUEE1BABsOlKGytSf23Sp9NkVvSZJAeT61bXB/fuHNuEuH1sm
	 /oZAtkDarT/Zw==
Date: Wed, 12 Nov 2025 06:57:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Yanteng Si <si.yanteng@linux.dev>, Huacai Chen
 <chenhuacai@kernel.org>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Philipp Stanner <phasta@kernel.org>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, Qunqin Zhao <zhaoqunqin@loongson.cn>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <20251112065720.017c4d07@kernel.org>
In-Reply-To: <20251111100727.15560-3-ziyao@disroot.org>
References: <20251111100727.15560-2-ziyao@disroot.org>
	<20251111100727.15560-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 10:07:26 +0000 Yao Zi wrote:
> +config STMMAC_LIBPCI
> +	tristate "STMMAC PCI helper library"
> +	depends on PCI
> +	default y
> +	help
> +	  This selects the PCI bus helpers for the stmmac driver. If you
> +	  have a controller with PCI interface, say Y or M here.

I didn't pay enough attention to the discussion on v2, sorry.
I understand that there's precedent for a library symbol hiding
real symbols in this driver but it really makes for a poor user
experience.

The symbol should be hidden, and select'ed by what needs it.
With the PCI dependency on the real symbol, not here.

The "default y" may draw the attention of the Superior Penguin.
He may have quite a lot to criticize in this area, so let's
not risk it..

