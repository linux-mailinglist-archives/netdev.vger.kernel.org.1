Return-Path: <netdev+bounces-98358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E698D10D7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B091F21AE7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBD1870;
	Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPgpjpAe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10246BA
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855631; cv=none; b=nKjFOyNm4sO8190fariqLuJb6kmeaIPuZiE2K5ELc1ubC9SlKzXqzkBQJFZm7Y3ojNbI+ec5xnPmXYLoTQgEkhrMitm3PffE1V7yE2KXRBnJOUvqxK+Y/iTqjof/wR0d/NhQimSEqY0ny7PfoImRJ6VN89N6zBwiyyMvNr3POio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855631; c=relaxed/simple;
	bh=1rXtvW+nEEBQwecLF6iUcm2F9makyjvpjpJigY95FXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MVLFIFhgVHGoBX9n3ZPUP4aS47s1zWUxUs07o8cRLE0ePMfWngODI5Qw4zyAciwEXaU8l4T+ETLsrQ7lFz8ygXNY7wZiAdXqrfT9DqenX1J82XUmb04Om7IwHJGbFkd6+6L+8aLL/2SnHHoqTIGqOJQSz92m94ZN8TObgob2reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPgpjpAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8E7DC32786;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716855630;
	bh=1rXtvW+nEEBQwecLF6iUcm2F9makyjvpjpJigY95FXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cPgpjpAeW+sFZsKj0I/6esYU5OYU3acmBCyByRol3jXyquA0K7kBGImkhloYLwN9R
	 lxsHgsVQpdAlu5WhJGKtmYe1sCUd80n+PFQfHvmwdF6QsZdT+R5hH/YtuuvfZqzVXr
	 PjE9ZlySwd0eIf4LgvZl+kCMxrKXLxgT+LbMIQrszPk1wkV3dFooLbMyxlnrZrk7vq
	 S9QRD0zgBXjXQoGsJqs/oyvDKhYzgGfs6F4CO/1vFhXk/Q6rYzT5J1coVaYd9toKsw
	 0k/gxcotX43zuJTFUSffec5Hq9jIOZcLk9NmuXMBOaOKLuhyDD2M/fIdDor7wJ8Z9s
	 mA+CLJbQNCZlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0334D40196;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Intel Wired LAN Driver Updates 2024-05-23 (ice,
 idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685563078.6024.17644411462995653095.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:20:30 +0000
References: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
In-Reply-To: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 aleksander.lobakin@intel.com, michal.kubiak@intel.com,
 wojciech.drewek@intel.com, horms@kernel.org, krishneil.k.singh@intel.com,
 himasekharx.reddy.pucha@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 10:45:28 -0700 you wrote:
> This series contains two fixes which finished up testing.
> 
> First, Alexander fixes an issue in idpf caused by enabling NAPI and
> interrupts prior to actually allocating the Rx buffers.
> 
> Second, Jacob fixes the ice driver VSI VLAN counting logic to ensure that
> addition and deletion of VLANs properly manages the total VSI count.
> 
> [...]

Here is the summary with links:
  - [net,1/2] idpf: don't enable NAPI and interrupts prior to allocating Rx buffers
    https://git.kernel.org/netdev/net/c/d514c8b54209
  - [net,2/2] ice: fix accounting if a VLAN already exists
    https://git.kernel.org/netdev/net/c/82617b9a0464

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



