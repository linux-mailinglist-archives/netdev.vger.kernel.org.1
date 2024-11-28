Return-Path: <netdev+bounces-147720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF569DB667
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6095D281A28
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A6195980;
	Thu, 28 Nov 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUr8jQJ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662621946A0;
	Thu, 28 Nov 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792819; cv=none; b=ZcW6YZmve2L7FC+Mbf5IKpWqrfLbnpPq4tFwZP3NiGLr3yQtvM1NqhtNM+J7eDshCzHCqWj0Z2fwr+42JL2QZ/WvrSkFiaszohlCdW3fAdIUoBL+y1i+ayHqqPXyO1dKIK2sgyoCBQbbUgJEF4k9lRZzeD1BdNK6sefHDce+bSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792819; c=relaxed/simple;
	bh=vxr+ZWoGJeha96CxgdJDibecbCcrxIa6s/fMYGnTqEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghIZ2RNQe2Md19qfiTeqfSTdBf9GIHH7WxTiDG5KRu6ruowJEh6gOoFEDE2jUsQ+irB5cUMZA11hAHDGkeh+QECGWR6YSH+V5xvzXVB9+5B0xHnpHXCOKNvi1PFtnx3IRmYhx1u0EyXMxEVW0l6uCSedZW4OiD1uLrLcFpNW87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUr8jQJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CA2C4CECE;
	Thu, 28 Nov 2024 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732792818;
	bh=vxr+ZWoGJeha96CxgdJDibecbCcrxIa6s/fMYGnTqEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EUr8jQJ2Gr6XXU5VgNrRGlv9wQDCi/v3LkXuqpeal8YFxYOb3lqfRgWslOJWJjhql
	 czmDNGjk+PEtFFJmxeWq0/sySbr74poGs/ai9oBq2acXy8X0HxzJ6tJovtIHkjgp1Z
	 6kQGiWBsDVRYjVFJJepf7YfbckM2BknHk2cPEPp4oIfHKg2dngssxmhC7qxBpPt82u
	 CSkGv9D0VdWfOuEEN+cD6imDXdKjsjqeJE6Q5l6gIxxfnlnlWXWat0gJnjsply0q6H
	 RVtDFAX5vr3QiioBHAEIETB0zlDRzilXBwwwuk/mtiTh5XistJESyiV1DFn1p6rLPZ
	 ZRBMC7w281J2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5B380A944;
	Thu, 28 Nov 2024 11:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Documentation: tls_offload: fix typos and grammar
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173279283201.1703182.10723612570278206669.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 11:20:32 +0000
References: <20241124230002.56058-1-leocstone@gmail.com>
In-Reply-To: <20241124230002.56058-1-leocstone@gmail.com>
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Nov 2024 15:00:02 -0800 you wrote:
> Fix typos and grammar where it improves readability.
> 
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
>  Documentation/networking/tls-offload.rst | 29 ++++++++++++------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [net] Documentation: tls_offload: fix typos and grammar
    https://git.kernel.org/netdev/net/c/04f5cb48995d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



