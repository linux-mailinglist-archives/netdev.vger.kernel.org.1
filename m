Return-Path: <netdev+bounces-90151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B18ACE0C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8502D2816D2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C614F137;
	Mon, 22 Apr 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1+Q+ZPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1E14F12A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792028; cv=none; b=Z20VFhraYIxUn6eTboUIpueAn2z6EiCaIXFoAMQ8IhuUlZp9Og+A5fm/S2Kb8ctBVNdCSCx+zbByb3m/xfsdNINssJfY1rWtaPelVbdN0LvXBXJF6Y/e0ROKwyfpkeaceWIWQw+B9CmP6MeHxmaFa1soTUy31OY+P3fx5s6jzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792028; c=relaxed/simple;
	bh=naB78KLtiZCPfl31Edt4r7y57gtvQ5A/5E5tvAwA20Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OzuzEptuD5flE+9oy/dWyAF9giaK0J46ToAJ2IL5+ZcFiXN720JS77L6HjbSWCU9egzTDEocAWo9UHn6yILiUEePDj5xIE458aUKyoFQX/WofErJkIibUhJGF+gAotrOHZxwo4pBx0xOuUjQTWC6OVDsEwdlqRy9owtgDF2NP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1+Q+ZPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79A6CC32786;
	Mon, 22 Apr 2024 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713792028;
	bh=naB78KLtiZCPfl31Edt4r7y57gtvQ5A/5E5tvAwA20Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1+Q+ZPBtrDSYTJULGxqCx7xTuQzEHwHd2DidjB59J3xXeQHkcSC3OK6P5hr75jAq
	 gcjwdLcahKtDRYt7Iz3d8flpCy1nfidq4Vuo9ihpZp5kDsx2t3hzPKMp4WvZR3Crzm
	 8lqxB9RJAnxxtnia03TT83kUotitRe+PEDYnlut50VG8litntYJY+cWE/JOS8kvFr1
	 4Meggw6WR8HdinjvII2dFuJ+qKW4fyzju6Kr2BspBWmsCY2TQQC2Aaz3cpThKRCSnz
	 dhQh5y0NiPAFruK+VNkSnp/WvCSE5Z/CBP+CyYHuFAw3JbMctzIltaBaDTsya/kIhG
	 HChl8I1Obi3Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BB34C43440;
	Mon, 22 Apr 2024 13:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: AER fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171379202843.18149.6132881529673561578.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 13:20:28 +0000
References: <20240419183449.234327-1-michael.chan@broadcom.com>
In-Reply-To: <20240419183449.234327-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Apr 2024 11:34:46 -0700 you wrote:
> This patchset fixes issues in the AER recovery logic.  The first patch
> refactors the code to make a shutdown function available for AER fatal
> errors.  The second patch fixes the AER fatal recovery logic.  The
> third patch fixes the health register logic to fix AER recovery failure
> for the new P7 chips.
> 
> Michael Chan (1):
>   bnxt_en: Fix error recovery for 5760X (P7) chips
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: refactor reset close code
    https://git.kernel.org/netdev/net/c/7474b1c82be3
  - [net,2/3] bnxt_en: Fix the PCI-AER routines
    https://git.kernel.org/netdev/net/c/a1acdc226bae
  - [net,3/3] bnxt_en: Fix error recovery for 5760X (P7) chips
    https://git.kernel.org/netdev/net/c/41e54045b741

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



