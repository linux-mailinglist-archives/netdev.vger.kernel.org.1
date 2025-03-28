Return-Path: <netdev+bounces-178096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B2A7497D
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBCA16A442
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250321DC9AB;
	Fri, 28 Mar 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWFq4ERN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3A26289;
	Fri, 28 Mar 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743162560; cv=none; b=VgrkpBb7WqrorkPZQH+JT6JQk8RsjDePZxvIYdfVz3OVdHmSjsSs1ChrwNp8Dk9uYPTIw/U03Z69w/H1pADWZrotwmt2qf1g5F3Kxtki3E82UgoUsPCxi1s2Yx0vs+m4I/lNUjMM4il6Bt0OdvIryDU1oJHTplmlJ1IHKMElk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743162560; c=relaxed/simple;
	bh=h6ydLoR1ygT6038JNkdaPynVrS5SsAM4iLsC0fD3s54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+zbNgpJCE8X6QPvs1nZxlqDb9MvwGxeVKgOBl60J1P1eBGmQ/D0OwEGUK//lqmMgBxr5UkyS5jzbnPV9Wb9rHfpU5ZQlt70pDdxfIW2CBezoobVH8p/zJQ1d2LVXbXl+MsWHzvW3AsCx9Df6uL185w9upD1zF58UjuiUF0jvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWFq4ERN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206FAC4CEE4;
	Fri, 28 Mar 2025 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743162559;
	bh=h6ydLoR1ygT6038JNkdaPynVrS5SsAM4iLsC0fD3s54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bWFq4ERNXyE1g0r7zL3P6oqwYus2CfOtKHDKeQIqShIHk7imIxtVfMEnBDYlxG9hh
	 Me/ObyC4e9KrM/4vMWW+x0LK0Q4oy8zFeZ8hD8OU91gi3ea7Ax9j8Fw4oTN+YW6w7p
	 5n4rUtuwzte9qWoFovaiNRIeD1brIw/PO5ZosJfs/lMMGvvudQWJ5yz+IjJdc38V0v
	 VkL1eOUqqdYBzFSX1CgAhWey7aT0xvNYmLC9U5PxJ5naDCvOZTWRs6IU4IXddjGlLt
	 NH7ExgDqQnbIPFr21dEcfGQE5kcKonjrg9wM6vSxeEtOWczoupREo2rAzLiKP8nupv
	 T86ZNI49XDPXA==
Date: Fri, 28 Mar 2025 04:49:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 0/4] net: phy: realtek: Add support for PHY LEDs
 on
Message-ID: <20250328044918.1082fccb@kernel.org>
In-Reply-To: <20250326212125.100218-1-michael@fossekall.de>
References: <20250326212125.100218-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 22:21:21 +0100 Michael Klein wrote:
> Changes in V5:
> - Split cleanup patch and improve code formatting

## Form letter - net-next-closed

Linus already pulled net-next material v6.15 and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


