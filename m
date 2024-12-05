Return-Path: <netdev+bounces-149217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F39E4C96
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13C5168349
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDCF15B980;
	Thu,  5 Dec 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPCzmvLf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071238C;
	Thu,  5 Dec 2024 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368818; cv=none; b=FdP+OrkBvmYuBFJkP4ZB1WR8yVRBvvxgPcN0g5wuAHy62Op8aFRMp18iqVvO2qqCsg/MXyooPl7EGIkMYvNjHosjGPPlXqBKnssZHH2Q/0AVsGuQg7pvDRE7m7nLrQk2ZtDg9T6ox6OEVldkNkYVtLGK3egILmEtFCmADL1KA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368818; c=relaxed/simple;
	bh=t0xFVOPHaEG0gdPwQnZdswE/D5MNP32oEBiWtJIcnSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N06/kWvoaJJldFu32WOkKv2KkHKpj+ssv3LtSn/x7/sCxZrvlL+jwJ0Rg0kabYnyEiIA1LDqeWB8V1tiu8RQkYFubRkLMKUgj127vcCzge07XtaZfp6Nin1X/XszgcdissrBkIInJg/SGq09KeZy57OjC6BiBscTiKRh6xolN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPCzmvLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7DEC4CED6;
	Thu,  5 Dec 2024 03:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733368818;
	bh=t0xFVOPHaEG0gdPwQnZdswE/D5MNP32oEBiWtJIcnSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vPCzmvLfpZ4JCSL5khkNMEHBVawjcTvU1Zc+epQY3x1ggNJVQtWy6Cxf0c8lRL5pC
	 qTmK+SoEI5upMayAzc4QSVgHsmP7OOLqrWGIKDd/q+3BbLJAoK/0GkhwVRwovxXPxi
	 BhNxM0MTBRy1dulC0zrkOqvU23G5m01X84XxmnkuoFTLX1C+qTg6sh7+dsqzF+9yoF
	 zGA2bR8+vNqKyEMTPn9Vth6P74sXnFG4YN2XikgZ3yF6Qe8ZMFP+z89Iorzd5bv83y
	 mvDLgFhadhlAMKx05tcDvRUbzqQxZTeJFv0Qmf8Q+jEBoufNOmD1TMcUHgWUUBWrCJ
	 DfkAFuG2idasw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35657380A950;
	Thu,  5 Dec 2024 03:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] ethtool: Fix wrong mod state in case of verbose and
 no_mask bitset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336883303.1427062.8314508421207042104.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:20:33 +0000
References: <20241202153358.1142095-1-kory.maincent@bootlin.com>
In-Reply-To: <20241202153358.1142095-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: mkubecek@suse.cz, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
 thomas.petazzoni@bootlin.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Dec 2024 16:33:57 +0100 you wrote:
> A bitset without mask in a _SET request means we want exactly the bits in
> the bitset to be set. This works correctly for compact format but when
> verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> bits present in the request bitset but does not clear the rest. The commit
> 6699170376ab ("ethtool: fix application of verbose no_mask bitset") fixes
> this issue by clearing the whole target bitmap before we start iterating.
> The solution proposed brought an issue with the behavior of the mod
> variable. As the bitset is always cleared the old value will always
> differ to the new value.
> 
> [...]

Here is the summary with links:
  - [net,v4] ethtool: Fix wrong mod state in case of verbose and no_mask bitset
    https://git.kernel.org/netdev/net/c/910c4788d615

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



