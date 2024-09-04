Return-Path: <netdev+bounces-125295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704796CADE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0459D2898A4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DCF183CCC;
	Wed,  4 Sep 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsMmucNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD117C9B9;
	Wed,  4 Sep 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493234; cv=none; b=J3jUYKrcYW/znfsmjgbiYT4z1atO090SYqgJkUjlWoXRezYIhUS9OrfGyRQscOnYSsyLdcSPRbFhPwbS3r8fdhkKR29t8G0EIiE6BBM0HE9PnHTkLTHj2nGs+HAFduQGATxBJZO6UjW3EzizKo2hUIhRqsZ8pNKI7nrIgIoGBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493234; c=relaxed/simple;
	bh=zVSb90sLTNYgIoTPRnjs98ty8wxs/c8jl0LH1KH+cxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rVBRkSx9b63cZDUw7F5/EDGp/NcYV0x0TGOoxvmFY7+4ppt5PPM40GGBUnJJjvjilA/hNxZaglw6cP6oXGEECOlhe8mwpc2ShLygqxp0YSw4txQY+VEDH4Uye2WPlWBU5CXQKQ2pM2KD2BesAdAr/We68G2iuHRHRuMljpi2M/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsMmucNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A353CC4CEC2;
	Wed,  4 Sep 2024 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493233;
	bh=zVSb90sLTNYgIoTPRnjs98ty8wxs/c8jl0LH1KH+cxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsMmucNbnUzbTODOvRhIecAG+xRFIIaayTq2R4J5vLbjcNMWQUd5INsTwrXENXGT+
	 xqiKvs8w1n9qweXST6roo8k9CNp7ZgTxppm4IrCTIsoR9f3wfJqTaxZ3H/bo6UP9iE
	 nsYyMBr9GQF3Sqwo9HJiJymLtK3O9A99oD+LTOM9gIJCk5egYZEUo81hzNLktm2DDE
	 28I9njCahOXNPGDdcPEbLc9G5dM85ENgLjOvSdLvCNaj5wiuFL0kWNXQPFDxpeGYYp
	 qdsskIiTBPeBh438Nde7a86ihs1DTgXB+BevUxvQg73GSpzt4hNnnIT0CkvlFKmmuS
	 2KgwX2sd61zYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9163822D30;
	Wed,  4 Sep 2024 23:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8152: fix the firmware doesn't work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549323425.1198891.7163852244083604728.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 23:40:34 +0000
References: <20240903063333.4502-1-hayeswang@realtek.com>
In-Reply-To: <20240903063333.4502-1-hayeswang@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Sep 2024 14:33:33 +0800 you wrote:
> generic_ocp_write() asks the parameter "size" must be 4 bytes align.
> Therefore, write the bp would fail, if the mac->bp_num is odd. Align the
> size to 4 for fixing it. The way may write an extra bp, but the
> rtl8152_is_fw_mac_ok() makes sure the value must be 0 for the bp whose
> index is more than mac->bp_num. That is, there is no influence for the
> firmware.
> 
> [...]

Here is the summary with links:
  - [net] r8152: fix the firmware doesn't work
    https://git.kernel.org/netdev/net/c/8487b4af59d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



