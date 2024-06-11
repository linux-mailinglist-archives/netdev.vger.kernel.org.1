Return-Path: <netdev+bounces-102440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E563902F70
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68CC281EFB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD616F91C;
	Tue, 11 Jun 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAsjaLL9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBA16F919
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079032; cv=none; b=LpGJ9TRO3+cFkg/O3+dHQAUV78vF+kYATv2D5RDUkPgKDxxjdjMfbBuRtCRpr30VASl0AdfFH7UiRKEpafL77IzfkpQa0CkPd9Ju1i2HkMS2+GBL+jWi6y82eEi9m9EPR/gT/oGwMw+Vx68Fxp+Svh17FHHO14Y9+i4t3ez4nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079032; c=relaxed/simple;
	bh=qMY6wddmAoB4KyMyrQn1GCRVY31uSmb2VAa0cjH1uQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N/gxS5lhPNhYaQx3+NdVA2JzhBklXMikeyU9i2ZJMMO/3SY9Bf/zv/szWngQl8nwO0BBgdGzYZ7bQVhZ4ZmmSje5GXtSbpipwmT7O3SsIuuVyug8H5thdYvv+W3YrwhuGZG+LD/4ee0JXoYgcB7DGi0gDvG+ZLN185yzQuzusT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAsjaLL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E858AC3277B;
	Tue, 11 Jun 2024 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718079031;
	bh=qMY6wddmAoB4KyMyrQn1GCRVY31uSmb2VAa0cjH1uQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JAsjaLL9TW3BvMLzkyyf+KnOwM9gj3KYxMd4lng7NAtz82vxwj3KI4FFVB59QIsD2
	 Jw6jH/K11iBwKzoNy7BG3APoJZ+Lenxk/vYzpFJc9zBi7Ks+H7rDKGMiHozkCetwI/
	 sTRPh4OL3nhdhhtXrWAhNd3R7RPTlfxwdEvzgUnDKoDeLsqFEVcSMImW3U7uA6O0Nq
	 vnxfVKd3SVdMrUyEq7VJaI0KNyaRDIMPSEeKhHbbWPbhANlJkZvlgbToXp1M126C2g
	 9Tf6LK+DdxCmYnwSQz+prEyJGPXxBShSz/PvJQrUxhP6F8QvUQpk/E5H5DpeVwEV5u
	 6i84xZ086lCFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4D6FC4332E;
	Tue, 11 Jun 2024 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Intel Wired LAN Driver Updates 2024-06-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171807903086.27787.7363605621417885636.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 04:10:30 +0000
References: <20240607-next-2024-06-03-intel-next-batch-v3-0-d1470cee3347@intel.com>
In-Reply-To: <20240607-next-2024-06-03-intel-next-batch-v3-0-d1470cee3347@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, aleksandr.loktionov@intel.com,
 aleksander.lobakin@intel.com, himasekharx.reddy.pucha@intel.com,
 mschmidt@redhat.com, sgoutham@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Jun 2024 14:22:31 -0700 you wrote:
> This series includes miscellaneous improvements for the ice as well as a
> cleanup to the Makefiles for all Intel net drivers.
> 
> Andy fixes all of the Intel net driver Makefiles to use the documented
> '*-y' syntax for specifying object files to link into kernel driver
> modules, rather than the '*-objs' syntax which works but is documented as
> reserved for user-space host programs.
> 
> [...]

Here is the summary with links:
  - [v3,1/3] net: intel: Use *-y instead of *-objs in Makefile
    https://git.kernel.org/netdev/net-next/c/a2fe35df41c4
  - [v3,2/3] ice: add and use roundup_u64 instead of open coding equivalent
    https://git.kernel.org/netdev/net-next/c/1d4ce389da2b
  - [v3,3/3] ice: use irq_update_affinity_hint()
    https://git.kernel.org/netdev/net-next/c/dee55767dc8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



