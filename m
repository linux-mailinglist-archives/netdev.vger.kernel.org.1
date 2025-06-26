Return-Path: <netdev+bounces-201559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973EDAE9E43
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F65656083B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66B2E5430;
	Thu, 26 Jun 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXC8r4Qq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C872E5419
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943385; cv=none; b=FgAMjgNX0wUJdCuQJ/bXDZWBHwZrpgkfbDWMahKgYobEOeWmP2lBoTCeW2UvtXvCYaQ5Ih53QrECbEMbTxeVytTkBhSr4+Jje0jX+JM6RbT88Scdywh+RqCx5/w+rt+mwecVHXdOPsjMB7/tNHZX9ib/wRdwYbt83brBmtLjzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943385; c=relaxed/simple;
	bh=IlddgYv++LImMWrYzhLo+0vbFNcqyDvNd63Rft3HVaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rlTUviQYt8YNmGaZbesyJe8gKnxeQAsPOuQbUTS52XrO3zKgpj+6H2/n6egpEYXA00ihLxp4+6r5R2tlz7FacTFtokzVIY5pW/3tcoC/hQOTgUK2+TlPn2HkjJ80cLRplPi2jlp+IMzYrxsGUM3zFAGi7g6t97qg+dEjp/vCDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXC8r4Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C86C4CEEB;
	Thu, 26 Jun 2025 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750943385;
	bh=IlddgYv++LImMWrYzhLo+0vbFNcqyDvNd63Rft3HVaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aXC8r4QqS3JWh5kR+IAmw5j9M5ROLKPjNDe5SCDtSmvqtp9Wf9N/cpY6fpZ34BgOp
	 BNIN2cR3ydcqFwDkDugfIAzkCZyHO4YA3vU91zBuVaL0trFq+1GnvfXDDPGlVqwPmP
	 c9oAVBPrrztapWSal9a5pMZ+kkv0w95hIoo2EUdCtMZ8g4iYnUc8p2+P+o7GEE07Hf
	 OV8f16rWTU8zRO8DVPrHTSplwrQ+/FvrH6h8j3aYHP0l4Rj8ekW+Jc/nb0Z0dvdOF2
	 eoDGjQ3bcT9KmkZs88fw2ztWUFBhYNEaZjBrG+j+JQR+Q5F3KbikbVOHrok0uVkbEJ
	 Cnaaq3w6GNZPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6B3A40FCB;
	Thu, 26 Jun 2025 13:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] eth: fbnic: trivial code tweaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175094341150.1196501.11866944167450703626.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 13:10:11 +0000
References: <20250624142834.3275164-1-kuba@kernel.org>
In-Reply-To: <20250624142834.3275164-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, mohsin.bashr@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Jun 2025 07:28:29 -0700 you wrote:
> A handful of code cleanups. No functional changes.
> 
> Jakub Kicinski (5):
>   eth: fbnic: remove duplicate FBNIC_MAX_.XQS macros
>   eth: fbnic: fix stampinn typo in a comment
>   eth: fbnic: realign whitespace
>   eth: fbnic: sort includes
>   eth: fbnic: rename fbnic_fw_clear_cmpl to fbnic_mbx_clear_cmpl
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] eth: fbnic: remove duplicate FBNIC_MAX_.XQS macros
    https://git.kernel.org/netdev/net-next/c/f2657cfb4586
  - [net-next,2/5] eth: fbnic: fix stampinn typo in a comment
    https://git.kernel.org/netdev/net-next/c/461bc4030dc9
  - [net-next,3/5] eth: fbnic: realign whitespace
    https://git.kernel.org/netdev/net-next/c/f7d4c21667cc
  - [net-next,4/5] eth: fbnic: sort includes
    https://git.kernel.org/netdev/net-next/c/536bc9b2d8e8
  - [net-next,5/5] eth: fbnic: rename fbnic_fw_clear_cmpl to fbnic_mbx_clear_cmpl
    https://git.kernel.org/netdev/net-next/c/d42e5248c9fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



