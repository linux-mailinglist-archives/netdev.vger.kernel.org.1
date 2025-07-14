Return-Path: <netdev+bounces-206794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E68AB045F4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3641A62EA0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87125CC64;
	Mon, 14 Jul 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3iZ9xT1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF492AE99
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512109; cv=none; b=hKKdVWIZZ2xZ0mKMDoPK0loJJu1EAJ1pmUi3Ao8dPx/DRNZOC1WeiWsF+Fa6h/qUo2jNI8WDJvJFh2Fa/RgKr1a1Q3G/HCqH0PJkjRFo0sWuerSuOgLhI7xGlRkNAn+MCU7DLzwJxEyG1VU+vpfA6jR9cgzTTCRUZGw1vkSn6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512109; c=relaxed/simple;
	bh=QP5vgryP9I/5Rsgie8N3oZ4saJud46veeBWKgYovc8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzrqFy2iOnDSOCKMr4+f3TjmE1J0Q3+LcittOTPajbV6mzrJFwUrKavrKAcmlgO+VPxog8e1h+kSATM0vjMGu83W6U0vgOQ6dX56iikgWM2OYuYylNSJNQ8UAI5tBDx6CTGDvOluJSKxHPr4F6NCDvOJ3jKYaoJBwQ2dKLQvo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3iZ9xT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE10C4CEF0;
	Mon, 14 Jul 2025 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752512109;
	bh=QP5vgryP9I/5Rsgie8N3oZ4saJud46veeBWKgYovc8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3iZ9xT1KhSdZBR9qGbw02Hlt3/qor18jcVe6Pp5BZgkmX8fWNjfHixH26J8DkcDW
	 ru2Z1d7i8aSql+3xMyWnR6elQATmixHOXrK33iKdlNtjW+rT5w/uCGyGi2j2LHeI5S
	 llvDtKyYU4hDMP1Cp3+T07Fh9h8lcIXdfNv4lsFpE5acD6VVff5tVdN4Mv4QkNYP8S
	 EwDqZ4W2HNSgqGafl7jE0IB9J4/dta+v8Ztq0KPN1+D+e8ACX/DNzNMEnW2pHM7dBn
	 gwhQfFZHRA+lpwZOX2wJo/Es/tFDIACnTI3kqa4CeII1/dM3acdqrS5rSBK13vsJIb
	 qsVS6xVn1jzOg==
Date: Mon, 14 Jul 2025 17:55:05 +0100
From: Simon Horman <horms@kernel.org>
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Message-ID: <20250714165505.GR721198@horms.kernel.org>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710092455.1742136-1-vitaly.lifshits@intel.com>

On Thu, Jul 10, 2025 at 12:24:55PM +0300, Vitaly Lifshits wrote:
> The K1 state reduces power consumption on ICH family network controllers
> during idle periods, similarly to L1 state on PCI Express NICs. Therefore,
> it is recommended and enabled by default.
> However, on some systems it has been observed to have adverse side
> effects, such as packet loss. It has been established through debug that
> the problem may be due to firmware misconfiguration of specific systems,
> interoperability with certain link partners, or marginal electrical
> conditions of specific units.
> 
> These problems typically cannot be fixed in the field, and generic
> workarounds to resolve the side effects on all systems, while keeping K1
> enabled, were found infeasible.
> Therefore, add the option for system administrators to globally disable
> K1 idle state on the adapter.
> 
> Link: https://lore.kernel.org/intel-wired-lan/CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.com/
> Link: https://lore.kernel.org/intel-wired-lan/20250626153544.1853d106@onyx.my.domain/
> Link: https://lore.kernel.org/intel-wired-lan/Z_z9EjcKtwHCQcZR@mail-itl/
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

Hi Vitaly,

If I understand things correctly, this patch adds a new module parameter
to the e1000 driver. As adding new module parameters to networking driver
is discouraged I'd like to ask if another mechanism can be found.
E.g. devlink.

