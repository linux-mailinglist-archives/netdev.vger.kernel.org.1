Return-Path: <netdev+bounces-208091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B4B09C2A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A1562007
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEB218858;
	Fri, 18 Jul 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVP99uSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E291E8322;
	Fri, 18 Jul 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822843; cv=none; b=XykLrqkgDQxE6eHUse0mQg2uNU98CZEdinE07ZJ3zpnUqX3l+twjFUjQhi0+mg2tcv9C2X5mSfuPI2iZ1lXPZPv4UzeM/CRW6vRQ4pjL8QnYAeQaaa/qFfX5LeH8PaoO9ZRUTKARqN5BLg+jb6I4Eto7PG3hYjprpjNkDvBD/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822843; c=relaxed/simple;
	bh=6wnS2xtxbpcAFUB1BnrJaz1aAjdAqzNZyXAbUulIYnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5+OyXi8jl9rKi/nb7cntQFqP5xBH32zEGZZ6mrbpls2QEOg/jzPXLSZqYlyH3KIrmqVyTtZ76p34/0VozbYuyj1/jUwoeVAe2k516ppXgWocvMDQTijlbxyV5SNyPgJbei6EW+kNvIp896dkM98YujQm09Fgyul82Nokx91SQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVP99uSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48874C4CEED;
	Fri, 18 Jul 2025 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752822842;
	bh=6wnS2xtxbpcAFUB1BnrJaz1aAjdAqzNZyXAbUulIYnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVP99uSgcEX3099jFyPoXovhI+iXC/4894QOq8GLAMo+8ebJE8XBwBedRXTWsAVxv
	 Am+ULddeOWzprPWACkqZhMt8wTHF7woLG05KwrO3HplkKO+5Ecjvl73cm/8WR5qGyh
	 AjCP5KKDgn6SXcFjY95xtpDaObC5JjKzRGewdpdb+11XE1bV/JSh93YYgPOxa64DY5
	 1I6d88v7lpNz1dUgM3VqJUBMticCE+k5fUtnBslcCm4gf7wY3uhVe/I+jBniKkbbOd
	 9MwThN779mxxK6FZsZMx+EEiZGTMy/Jt6Hvku7db46Sohp1ZQnZN37vkA02kZ4pWr/
	 /MquzMECERMag==
Date: Fri, 18 Jul 2025 09:14:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <20250718-sceptical-blue-bird-7e96e3@kuoka>
References: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
 <20250717-airoha-en7581-wlan-offlaod-v4-1-6db178391ed2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-airoha-en7581-wlan-offlaod-v4-1-6db178391ed2@kernel.org>

On Thu, Jul 17, 2025 at 08:57:42AM +0200, Lorenzo Bianconi wrote:
> Document memory regions used by Airoha EN7581 NPU for wlan traffic
> offloading. The brand new added memory regions do not introduce any
> backward compatibility issues since they will be used just to offload
> traffic to/from the MT76 wireless NIC and the MT76 probing will not fail
> if these memory regions are not provide, it will just disable offloading
> via the NPU module.

That's not what I see entirely. I see the same problem I told you already.
of_reserved_mem_region_to_resource_byname returns error ->
airoha_npu_wlan_init_memory returns error -> your other patchset prints
big fat warning in mt7996_pci_probe().

So all correct DTS now gets a warning. Warning is a state of failure,
even if probe proceeds.

I don't understand why you can't make it fully optional, so also fully
backwards compatible.

Best regards,
Krzysztof


