Return-Path: <netdev+bounces-69978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997584D299
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1477028B631
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E1126F37;
	Wed,  7 Feb 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXs9/Xw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389A126F12
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336439; cv=none; b=FJNG0BGvkf9aGUns/xxlB43af5BKX/2vv5VZl0kify8aP31RH2B8iY9zIRPPCRO9DwK5wmptQirgPZw8U+AzhlcUyLS+U4oZmtrdO2HuMNHWZJZvvaNIarpBh74MpxhGBe28pDVJegi7/F/eqQYrUQxdxvhF37KjvHtyX9cMY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336439; c=relaxed/simple;
	bh=BgInF5PsyWEKxegQFyX+Q4EoDF5vEsUILaSqTH2M0ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y71mTBbCr0z4kRP/9rcNKLLhumG0l61NETA+VfNiUknWR+7IVbNTCCE0xHW0lSnB0GfY7Hs5GrG1IlWEyV+5thP49eR2KkNQnJxH0gRSQIrkkxYMhseufhuMu9xPfZbNzkLoRXCvOM21OUC3gYBMyzU9iTB6hq6V1M2DqzX6JhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXs9/Xw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C880C43399;
	Wed,  7 Feb 2024 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707336439;
	bh=BgInF5PsyWEKxegQFyX+Q4EoDF5vEsUILaSqTH2M0ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXs9/Xw/H7kjcfgnn5jf+D5VjakM7rbS0+TYvOXjdDMzEGLoVk+4EXXnZd9mlFK//
	 wGGMtcnCP+KFClYYs6Q/sth/2T5rH5J0Bu/c0e6T+doD/n0InqXs82PalHT8LxPVka
	 9HH3tHqhvgAMQR3S5dTZKVpjkPkwIzdJHlYYjSEG/CbEZ2/CT+WB6/uAhEwo57rqlV
	 2jfGuxcky1R6rXdNxFG6XpYFfuAuEHSbV6IcZNRTR1AnCcoPk74XUM0Ye6ZoHdfpF7
	 elpzJIc+pT2RaZbXrgUQEt/KfYgsGXAYmAc0g8FLEwEEJF+hR08Rey1tVrWNKm5Oam
	 /Zlf0WAyOHnsw==
Date: Wed, 7 Feb 2024 20:07:13 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove setting LED default trigger, this
 is done by LED core now
Message-ID: <20240207200713.GN1297511@kernel.org>
References: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>

On Mon, Feb 05, 2024 at 10:54:08PM +0100, Heiner Kallweit wrote:
> After 1c75c424bd43 ("leds: class: If no default trigger is given, make
> hw_control trigger the default trigger") this line isn't needed any
> longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This patch looks fine to me,
but the cited commit is not present in net-next.

