Return-Path: <netdev+bounces-161666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63277A2323B
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4C7A4148
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9E81EEA3D;
	Thu, 30 Jan 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhuv74HS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E741DA5F;
	Thu, 30 Jan 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255440; cv=none; b=hkWamNPgTCxbAAX7oan9ZEQ2K42qOfhdNnNyI3+90HfY9nmX1G6lVz/hAomDS4sF6QtSEeyeMHrMq+vNFmzKm0uSuvkz1zDp/kInohZCxx+oVEPRKGsMA2Xi7OBRO9LpsyY6eus/LH06ksH6Xk7tiMOVOIo85rKzhQCDM1ANHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255440; c=relaxed/simple;
	bh=ad0gtERyDtVIOMUKXUEmvbYfeQm90MQkvXdXwrnxB+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IA6tgMJCsHz4AcsRodhbvyHf4sF0p6OddP6THZyNVHPkwz3/TkkumnKB3xklUsIyPH/DAk/S++/Db2fE6jnCwrI3523pJEzWzAgJ/m3Be5ZXqY4moNhE50iTGLDCJwshwD2eiigMTKGg3fwCqOjH3oxzkxxBmhI+rAc0ALwr+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhuv74HS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74018C4CEE2;
	Thu, 30 Jan 2025 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738255439;
	bh=ad0gtERyDtVIOMUKXUEmvbYfeQm90MQkvXdXwrnxB+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bhuv74HSgdXLo+YQDmF74AZHQbPOlxmdiQgBAA+Am4tUCe3R7KsoY8dPkKjKWi44s
	 +r2wMXYdUHamKD46NPORv2NYjMZQYwlPlCvvksPifCGcFrCKx9uwSO+gPUn7/FEhfk
	 S3QJRx9+4RSQnCXn/Qm+uyrhrQRJbAbd+5EzZ+fmmMUKRTNy8ZD6r5oXQ8AzlGZJOq
	 zJPix0v4UkI038kHuATbE3Ioyp/4mnMl8T+g+Vl+3mqJmGvM8z2fKuU/SL0oyrZq5z
	 FjoeGreURqz1B3grZlA5jxuC3I+9BK8hT0NkQMA2Lb5J9jHr1WxrpxBiZRjnutN1jI
	 eyxJkBLamivRQ==
Date: Thu, 30 Jan 2025 08:43:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: ethtool: tsconfig: Fix netlink type of
 hwtstamp flags
Message-ID: <20250130084358.5e895d2c@kernel.org>
In-Reply-To: <20250130102716.3e15adb6@kmaincent-XPS-13-7390>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-3-87adcdc4e394@bootlin.com>
	<20250129164907.6dd0b750@kernel.org>
	<20250130102716.3e15adb6@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 10:27:16 +0100 Kory Maincent wrote:
> > In general IMHO YNL makes the bitset functionality less important.  
> 
> Do you mean you prefer u32 for bitfield instead of the bitset type? Why?

Not in this case, but in general uint can carry up to 64 bits, 
and the names of the fields are in the spec (both Python and 
C code automatically decode them based on the spec). I see less
of a need for the complex "forward compatibility" handling
in the kernel because of that.

