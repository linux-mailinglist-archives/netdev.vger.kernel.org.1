Return-Path: <netdev+bounces-224232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E5B82A7E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293CD188CBC7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C725F241CA2;
	Thu, 18 Sep 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNAjsNKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B123F42A
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162616; cv=none; b=eQhL/onyikZH5ZDpyDXfvrJDaHC62OqA1Awtix0YqmgyOpiNEnF2tezvWMQuGr9T0SobaZogrcibxMAcLMCY84fXwTrKUh8hyZ2uJe/DIHGDR2+oO1V85oKXWNZmeEJofqcCyDLCMWh/fet6Kv2k0IDCVZKelf/ZJwFffFIn+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162616; c=relaxed/simple;
	bh=0Dps7J/dHshrqTI9Xo/beNOvJBaeuVZm6ksfPFUEoTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLfErJcQfQfpmsI0ziUD4KG07BS5Cez1/jNuV5YQp5t3XU20A38PX+kc7W2YpOB2jpPwEnh7braVA8xOIGbqbjSE1E1Z00qmEEuk2nz08Baoe6Brgpp6jKJE06diQHkPKESW3DG84ePwuGMlpXDNkwxJLMFdggx7LBkfaLfuNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNAjsNKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FDC4CEE7;
	Thu, 18 Sep 2025 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758162616;
	bh=0Dps7J/dHshrqTI9Xo/beNOvJBaeuVZm6ksfPFUEoTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qNAjsNKdAVD4KNlG0mJ5y67/jqqBsTeG25sSndUy9WAvSW9LRUS9cZIlA05rCHmbI
	 /435IkRscWFba8xXBTI+3+NvW1zaNKquwsvbYdhHp3e/qGiPaLb4Pltmy2RQNfeHKm
	 eNQ/QodZvQavW6tCg4olw6uMISS6I+z/y1hhEkWW3QU8+7aaJfbHfR3EdCDL02WNip
	 +6ORoBoYpp36+khTc1DTgAjqRslTufopjAwlYm46P3bEBmkgiNOIEJzGyAUNKf0Zvy
	 dAphjzIIkzKbNgANhroUTTwkWEssFpSMSpzJVB5iR74gG80K2vVuJEuQIdFqsXNX8q
	 GYdVBwSW5gZwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5839D0C28;
	Thu, 18 Sep 2025 02:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4 iproute2-next] tc/police: Allow 64 bit burst size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175816261648.2229542.5348982217548868366.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 02:30:16 +0000
References: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
In-Reply-To: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org,
 dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 16 Sep 2025 14:57:27 -0700 you wrote:
> In summary, this patchset changes the user space handling of the
> tc police burst parameter to permit burst sizes that exceed 4 GB when the
> specified rate is high enough that the kernel API for burst can accomodate
> such.
> 
> 	Additionally, if the burst exceeds the upper limit of the kernel
> API, this is now flagged as an error.  The existing behavior silently
> overflows, resulting in arbitrary values passed to the kernel.
> 
> [...]

Here is the summary with links:
  - [v3,1/4,iproute2-next] lib: Update backend of print_size to accept 64 bit size
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1ee417ac43ee
  - [v2,2/4,iproute2-next] tc: Add get_size64 and get_size64_and_cell
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8798ab4c4c02
  - [v2,3/4,iproute2-next] tc: Expand tc_calc_xmittime, tc_calc_xmitsize to u64
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=13b999aa74c8
  - [v2,4/4,iproute2-next] tc/police: enable use of 64 bit burst parameter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3b26e8abf404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



