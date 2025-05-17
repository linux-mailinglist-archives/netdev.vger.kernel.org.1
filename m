Return-Path: <netdev+bounces-191256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0ECABA796
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A934C4F83
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7086348;
	Sat, 17 May 2025 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgybB8fX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE9C2C6;
	Sat, 17 May 2025 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747446312; cv=none; b=K+w4W5H2sWwMBXU+wT6UVvQXlwPIm8l71gYnE3TVFWazw2yu4VebOIUYZbZj76gJcX6u4C7gQSIi0OToD+xYSWOrWEaNqjB0xO1rFCp0VD6rqX4uG4b/DajJYnJ3EST1LcWleVEedSSMnzQfVKbNStvWvxFeMHYAysh/GWaIt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747446312; c=relaxed/simple;
	bh=vU5DvzG0VX8FOkm+8Z9p+9toC+MvRZUu97/BG6AzN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKLVUpImoQ5/5svd8EzcsuHaFEQxwRcbFNxlSKz4oSyvAipGwZdNLL2fy59o1O1v55Y+1uIgERALSrRk1H2pMGsyFs6DQxh8axlI7K+WBB8bwd7cS8IcgV/EB0rzZuHrDwUW0hD/m/T6aEhzObQr3115CTXCWUTjYsbCI5armyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgybB8fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF8FC4CEE4;
	Sat, 17 May 2025 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747446312;
	bh=vU5DvzG0VX8FOkm+8Z9p+9toC+MvRZUu97/BG6AzN5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgybB8fXQU8glSOJf//hhijm+w+KUda09qPoIR3P98uk1M6aHgdk+a4VFkSIqpSU5
	 9joMLdL5teaqFrNZppfKcGfwaVv5opeB+gBZRmIl9/XK8P4yQ6c3/Pd8C7nj0aQFwd
	 akVOwAKsmyAP1MF3pM0CUOt8LlFVk0QzV+H6z4IhYldtjQp/GL+mEJvgQACvsHPMYk
	 07KJifvIbygDLaq5DGtAdwsz2skFrdvb7QZ0BhMjuMwH0AF3/xQfrQGk2BvanRokJG
	 3N1gTLiN9wJxq6kcEs519vYcoshnrbecnhDEQfNdHTx15mr3xKTJwwHQQEKLJreLtX
	 kTfEJv9rkbscA==
Date: Fri, 16 May 2025 18:45:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250516184510.2b84fab4@kernel.org>
In-Reply-To: <20250515083100.2653102-1-o.rempel@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 10:30:56 +0200 Oleksij Rempel wrote:
> - Inconsistent checksum behavior: On DSA setups and similar
>   environments, checksum offloading is not always available or
>   appropriate. The previous selftests did not distinguish between software
>   and hardware checksum modes, leading to unreliable results. This
>   patchset introduces explicit csum_mode handling and adds separate tests
>   for both software and hardware checksum validation.

What device are you talking about? How is this a problem with 
the selftest and not with the stack? If the test is flaky I'd 
think real traffic will suffer too. We pass these selftest packets
thru xmit validation AFAICT, so the stack should compute checksum
for the if the device can't.

