Return-Path: <netdev+bounces-99249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DB8D433F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908EC1C2313B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29C6208DA;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDYLIwDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7D208A9
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034434; cv=none; b=DH9pQfbilOuFVTuFUqYfJIjgC2rx9Etwti7g1DSaADQPkwl/9PVdNJj9FBcAFHv+HPhJ9wGy4rZrUImVTnyTtS/ZeuiT2uNm7uPnLsG/rpAjpNroFoAxXr87OWDEP0gdN/xAOXsnMjiHBL4ZxPy83IoKarLQUyTfT1zr/BMaXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034434; c=relaxed/simple;
	bh=aVQRNJ63NMlxx9pW/T6v3MxeAtKrtfFn1SPjir+hFI4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AO2sGs7w2whCzob4edpgePTR1m8GKKj8c/G3krStiOQyX/wgjrdax/7u4n7JH+XYPFRxPvwQnLuL37T35leQSvPK8vABEXAcP6+J8Ddtol071QLXt/jg16ZldZqNz+3hP8oBqtGnpMk2MCHFsoUje6G25uxmKFSkIusixwURtUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDYLIwDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A201C4AF0D;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034434;
	bh=aVQRNJ63NMlxx9pW/T6v3MxeAtKrtfFn1SPjir+hFI4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dDYLIwDunq/pEFCbVYIpZwybuJppKMMrEpLQBsnGpzpfyU3PrHbnxF/NVGPW3ZOLd
	 uQhvgYlhGUW7+sHpF5yeDTrHGWT16nv0iMcGNmFNTKX5LCULNXbot2rFRwO6TDEiRW
	 vZQ6lswk6cy9FmzUzU4HfUa8xcm/ZG+UCn/tO/YA+TUSBWpToXTXCps7faQ3AgF8LQ
	 AjsgqBOi8yw/kASBZiwobJn3aZIYfxFG90aWA00FGMRM0KulsnLUbvdPVRaCTirkGD
	 sA3NZ3SrBDsC3ZMgmQoAUHQ2Cuo8jFlK6gIFIxh7RuahHvQRzT8E3KwATr6TwQt6Ww
	 IUVP12CWz/TAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E9D6D84BCD;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/4] doc: netlink: Fixes for ynl doc generator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443425.3291.5482505673967760594.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:34 +0000
References: <20240528140652.9445-1-donald.hunter@gmail.com>
In-Reply-To: <20240528140652.9445-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, leitao@debian.org,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 15:06:48 +0100 you wrote:
> Several fixes to ynl-gen-rst to resolve issues that can be seen
> in:
> 
> https://docs.kernel.org/6.10-rc1/networking/netlink_spec/dpll.html#device-id-get
> https://docs.kernel.org/6.10-rc1/networking/netlink_spec/dpll.html#lock-status
> 
> In patch 2, by not using 'sanitize' for op docs, any formatting in the
> .yaml gets passed straight through to the generated .rst which means
> that basic rst (also markdown compatible) list formatting can be used in
> the .yaml
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/4] doc: netlink: Fix generated .rst for multi-line docs
    https://git.kernel.org/netdev/net-next/c/c697f515b639
  - [net-next,v1,2/4] doc: netlink: Don't 'sanitize' op docstrings in generated .rst
    https://git.kernel.org/netdev/net-next/c/ebf9004136c7
  - [net-next,v1,3/4] doc: netlink: Fix formatting of op flags in generated .rst
    https://git.kernel.org/netdev/net-next/c/cb7351ac1786
  - [net-next,v1,4/4] doc: netlink: Fix op pre and post fields in generated .rst
    https://git.kernel.org/netdev/net-next/c/9104feed4c64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



