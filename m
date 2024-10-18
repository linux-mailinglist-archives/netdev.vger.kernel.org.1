Return-Path: <netdev+bounces-136830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593A9A32E0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190B4280E11
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3815573F;
	Fri, 18 Oct 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMreIVId"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE8154C05;
	Fri, 18 Oct 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218630; cv=none; b=Nl9bfNg1+zYGp18/f3aXV83rdXpi0OsUKP1Y+bDlKJ3u/Bb8XgUyrzfcYn20k8anMtFzP+wqBXu+NOA+YlOaDvJ8gQbUzHZflOrEc2/Nb3xCBIAjdcJJ+iecswQG9HFgQjEkAntf8Imt7InvylpNTOgnUE2smgYSKa9Aawq2RaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218630; c=relaxed/simple;
	bh=lFMFUY3CTFJtcrIk50sjUgdCVM4UQPSg/6YKHVeAc48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P9+CGvpaWmkpywGBchnowVIa5MCi6SR9LrTn1j7F5/OrBtx+YzHNaZVeQs+ujvNCjIRI13EZLD3PZqaHtAqoVpceCxcLMDKXorCwNL4rLS/NlET7SOXDmBucqoC8QTbZ67wQbA4oxWE1HSLejW+omq/qVYdBBue4iiOyR/nW1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMreIVId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E53C4CEC3;
	Fri, 18 Oct 2024 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729218630;
	bh=lFMFUY3CTFJtcrIk50sjUgdCVM4UQPSg/6YKHVeAc48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lMreIVIdGwN9ObVxHW+umWNsnmsmyOw0jwNBCbUiDe3UBCxkj+EkWHhE4tdGPhBR5
	 ydisxnpXNJ1x3GQQqCf3ZelaH4H+C7nq2ikF1kYmOP27wx0iqCkIDiyXjfJ6nCSyMd
	 7w4qE2ZJccqkY9B5Z2QktI2SnaY1r7B9rjkj4PAnPjABvhUbKqEAsGQ9JZoY6+infj
	 9+zpnqLX4xGGIW0wHWVPnIPsU06lfw5oaFRTbBm5Yn0/V5sC0MKmRtbv9TUq1lvtm5
	 VkvvjN0ykUh13KtPxh79moJBwmQTLDdemYOz0NnUTD9Oth0wehzhtSeGCqNdJano1i
	 dqLKnrbvBf6Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1243809A8A;
	Fri, 18 Oct 2024 02:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: only store little-endian values
 in __le16 variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172921863525.2663866.240523041455432199.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 02:30:35 +0000
References: <20241016-blackbird-le16-v1-1-97ba8de6b38f@kernel.org>
In-Reply-To: <20241016-blackbird-le16-v1-1-97ba8de6b38f@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 15:31:14 +0100 you wrote:
> In sr_mdio_read() the local variable res is used to store both
> little-endian and host byte order values. This prevents Sparse
> from helping us by flagging when endian miss matches occur - the
> detection process hinges on the type of variables matching the
> byte order of values stored in them.
> 
> Address this by adding a new local variable, word, to store little-endian
> values; change the type of res to int, and use it to store host-byte
> order values.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: sr9700: only store little-endian values in __le16 variable
    https://git.kernel.org/netdev/net-next/c/4b726103796a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



