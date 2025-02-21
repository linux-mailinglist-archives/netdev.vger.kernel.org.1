Return-Path: <netdev+bounces-168350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197CEA3EA07
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A98421055
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF31D6DBB;
	Fri, 21 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHONPBGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE72AE84;
	Fri, 21 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101405; cv=none; b=dJ2qeWv4DJPvXhn9Ij200a0+LYdeqcG7FqUuoJBOiasQfWcq6rwV4jUJKT3GO3SWyf0nipif8ry+4VV/3QQsRh/PQpwvij11Lc5o8TXuJO/DoEKf334LYm3K/cpgKW0BGcmYK3c3XDnfzEaZ/DxFhJ3Tp5km4BEuGYfDTIA6v/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101405; c=relaxed/simple;
	bh=8jveZet82L53lEmI6sZO2JxHVF4Ze223BTjGLS073wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkGVu5s3VWPp+sOkAzA3vWlfTFw3gYFMS0/vpdNVkH+QHDxKFIPkii2ExgCw5Tfp9v5nYMxoWRuZqtNnycbKNc3BMwMVVaeEErLVezWO6MxxqkwM6X7t8oMykd+oOzfB+fbrvqYEQ1wubVgHjT2m2BwfYbjoeSlHBEVhP2lQqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHONPBGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CDBC4CEE3;
	Fri, 21 Feb 2025 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740101405;
	bh=8jveZet82L53lEmI6sZO2JxHVF4Ze223BTjGLS073wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uHONPBGPgyIaiZ7Gu0FKo8QNgSt05CDummdUww0R887YxvHGjd5FC1dQ/SbJaNzOC
	 RiDwqqhk2xYsn/Z2pdCCxqykG1ByYKEpsEGZK+0TAL3DXMTLvl9SuwbEYCOuiu5A32
	 3T8Vo1VD8d2duvZttd/cmF/PDyK5qrWPNUJ02sr97+K5ZipQQbEvX5yARy6RPqJBAr
	 ZGoAx4Lwf5aeBZHwjVVR/5HWUtFEIQ6HFuZKLv/fUhstV0cWT0trEQS4alXKd4kGu8
	 FH3Ny3cXW1kZeYEV6yw0TxczklnB+mxHtd16EBAbU46sJ3v7y3vvqtsLzZPa/3NDGZ
	 B7VbBkjZCzfiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB1380CEE2;
	Fri, 21 Feb 2025 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] af_unix: Fix undefined 'other' error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010143576.1536213.862503926616277176.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 01:30:35 +0000
References: <20250218141045.38947-1-purvayeshi550@gmail.com>
In-Reply-To: <20250218141045.38947-1-purvayeshi550@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, skhan@linuxfoundation.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 19:40:45 +0530 you wrote:
> Fix an issue detected by the Smatch static analysis tool where an
> "undefined 'other'" error occurs due to `__releases(&unix_sk(other)->lock)`
> being placed before 'other' is in scope.
> 
> Remove the `__releases()` annotation from the `unix_wait_for_peer()`
> function to eliminate the Smatch warning. The annotation references `other`
> before it is declared, leading to a false positive error during static
> analysis.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] af_unix: Fix undefined 'other' error
    https://git.kernel.org/netdev/net-next/c/1340461e5168

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



