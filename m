Return-Path: <netdev+bounces-184818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D821A974FE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9163AE5E9
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB11E47A3;
	Tue, 22 Apr 2025 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+sufVVY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1A38382
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348273; cv=none; b=RaWpFwwXPXkRih+6i866bbyTfTiKgar5GFuANvCnSAoTEQSUUw1iax7fAUEMGQsvqNefkDMEyYjsvyGGsgWRaGiIgmGDJ6TPu0kERYIG7y2ag0vWfvF0KwDiWxA13WWoR9YJxi6WzxcWgfe0hy5AAR1HxHmaSPx4KxS3Xf+pNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348273; c=relaxed/simple;
	bh=HO+fpImhO7XKnlu3DeitYxfXUm6VtfAy3gIvVV7B/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4pMMt420/3vvt+pHV5MHWTFqQ/Qzl6sHM8NTqAKLu8SFgfAWe3qCGsngUr+lS7M5rklk9tXTBCfOmtCUdZLRQ3v2TbklC9z3KWMhMGJJrqkU0yj9kWK/EiQoQhYvG7+M7PoyIboGXsbTgubcNy2r9Q59k/WPdT9gi/3gBAcBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+sufVVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCD5C4CEE9;
	Tue, 22 Apr 2025 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745348272;
	bh=HO+fpImhO7XKnlu3DeitYxfXUm6VtfAy3gIvVV7B/Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+sufVVYu/pIhm/Wvn/XMcjTI/qYO8/L3grjzZB4lyGtOMPn1WWQO8PUVnuCIj/QW
	 zdSmBkWUjKykyyMnzy9BE1riX2OrNxIeCojSb/bYeI/c2TPlg4A4Wjq5DCeamNZgV9
	 hTAvDYCok8TNEXoYZPzP+kqzGaq0BdqUV82mmUhxFNqBDU0DXWM7rKlZvmpylEcqQL
	 kVft54D5NZIKsbVUJrH7WOr97drlcZSLUoh2XPHqTEmoABIknPHDgmtQOGtlBuEXbf
	 nOHj02ME3ZagXE+Sxd3KfXjagKiQb4B0MtDT/kKUInakcDc+jkI6124aZY7/h7Mvtr
	 MNIVBYHcuOIWQ==
Date: Tue, 22 Apr 2025 19:57:48 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] r8169: merge chip versions 70 and 71
 (RTL8126A)
Message-ID: <20250422185748.GO2843373@horms.kernel.org>
References: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
 <97d7ae79-d021-4b6b-b424-89e5e305b029@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d7ae79-d021-4b6b-b424-89e5e305b029@gmail.com>

On Fri, Apr 18, 2025 at 11:23:45AM +0200, Heiner Kallweit wrote:
> Handling of both chip versions is the same, only difference is
> the firmware. So we can merge handling of both chip versions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


