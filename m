Return-Path: <netdev+bounces-198592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D2ADCCDE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56A319404E1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D22E7172;
	Tue, 17 Jun 2025 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOhoEtyF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209512E7175
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165812; cv=none; b=O2QeF+Usux6QYCvr2hFNWLEBBdIPhCNqaMNhythLxtt1SzAB78CRDKE0qTbovpWMvLBycWGC+XA4viVQzFlm4mUOX2dlv154PYdGSvDfwXPt7fkckTFOZRp3cYtm5Zt5D9Ekkfi6AP2okzcd8fO1P4q+0o5fACDvDnG7p71UXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165812; c=relaxed/simple;
	bh=rzhBktWYLUVD2Je0U8gOnQ/C308rWqSm2eNzRCVbkvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IpRXx3NDhAeY3oR0KSB1MEultdzrkMhhf9XDRQjl66ZBNUVT7Nx07iFFxB00B4h5WITrgcjNoM7y4gbdsRIXerWdVlqcdW+96C9YHYkQuwdb97HcwQRubyZW7tIcsE6Fy7VPuOg1xf77WoRimN3L6cdq8X8IfIvBW3qSbYcR7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOhoEtyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9129AC4CEE3;
	Tue, 17 Jun 2025 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750165811;
	bh=rzhBktWYLUVD2Je0U8gOnQ/C308rWqSm2eNzRCVbkvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pOhoEtyFi0pZoAdU9uKxT4dctaSg40+vf6nxRn0te+JTwc0HITmB+6v1jdKHTxQWl
	 ODDnX7JXgYD/Z/0p22gn7pXg9SO5v8Iuxl9U6TPUrlTjeOF4w1mAa5mJbyUS4ansFN
	 uR3QOzj7/VptUJdN/5c8vUwQusrNZcJnHwnozv1wEXrTra9hFvQa+tTfH90n6f9mNU
	 Gpw6VctYaBhOU9MqO0kXVCTclA32GDp8R/YciSfANJt9vEWEJeMfeNJaOP1y1rQtZh
	 B14ytXf1N/dA+6X1HsJZokpFr6jY7vChTOCPPra+nLuLmO3RP8FHf69ToEHDigY/dQ
	 Zh/y8fMfW3rnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F42380DBF0;
	Tue, 17 Jun 2025 13:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] igc: harmonize queue priority
 and
 add preemptible queue support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175016584025.3120559.2555735972352303574.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 13:10:40 +0000
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 faizal.abdul.rahim@linux.intel.com, faizal.abdul.rahim@intel.com,
 chwee.lin.choong@intel.com, vladimir.oltean@nxp.com, horms@kernel.org,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 11 Jun 2025 11:03:02 -0700 you wrote:
> Faizal Rahim says:
> 
> MAC Merge support for frame preemption was previously added for igc:
> https://lore.kernel.org/netdev/20250418163822.3519810-1-anthony.l.nguyen@intel.com/
> 
> This series builds on that work and adds support for:
> - Harmonizing taprio and mqprio queue priority behavior, based on past
>   discussions and suggestions:
>   https://lore.kernel.org/all/20250214102206.25dqgut5tbak2rkz@skbuf/
> - Enabling preemptible queue support for both taprio and mqprio, with
>   priority harmonization as a prerequisite.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] igc: move TXDCTL and RXDCTL related macros
    https://git.kernel.org/netdev/net-next/c/fe4d9e8394ff
  - [net-next,2/7] igc: add DCTL prefix to related macros
    https://git.kernel.org/netdev/net-next/c/4cdb4ef8a9ff
  - [net-next,3/7] igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
    https://git.kernel.org/netdev/net-next/c/e35ba6d3c6c3
  - [net-next,4/7] igc: assign highest TX queue number as highest priority in mqprio
    https://git.kernel.org/netdev/net-next/c/650a2fe79538
  - [net-next,5/7] igc: add private flag to reverse TX queue priority in TSN mode
    https://git.kernel.org/netdev/net-next/c/e395f6a690d8
  - [net-next,6/7] igc: add preemptible queue support in taprio
    https://git.kernel.org/netdev/net-next/c/17643482e9ff
  - [net-next,7/7] igc: add preemptible queue support in mqprio
    https://git.kernel.org/netdev/net-next/c/a7d45bcfde3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



