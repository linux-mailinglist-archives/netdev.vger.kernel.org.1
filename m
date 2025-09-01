Return-Path: <netdev+bounces-218904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C1B3EFC6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4472054EC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F71270569;
	Mon,  1 Sep 2025 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB66HhVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210E270541
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759203; cv=none; b=VyjGBIgIyiLHJQ089KtJ0EFPatgDhpdzOuUboSQNDqkP770izeC69ZLzEhAISm49bgt95EObOFu9QVzWgNx3pqiDJZR49iX0SC8rxITYy7gGQfFSsymhYPN+e/ddHrxbP6+nWOaHLm3fdb0Y/WE4iS85FF0rX+KG9vxsweKnVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759203; c=relaxed/simple;
	bh=SDRfEnPDbo0TvGhLxWvCb8p6jdLwR0wt1Y/xKesV3QE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r7WrzeEqEGh67bF1RM4GwFjVHEIlHlYDgQ7BGL22KEhzhtB5Oswx9JA+TiSTwrO7im5W8KVeQz2gE8qrvrykp3L+NDGfnCvhwvjDLopyDYgH3uis2HHb7V1IjryfA1vTcgnoaJneijoolrap8pF9vRzgctFs0/hsZzLs1O3Mbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB66HhVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778B0C4CEF0;
	Mon,  1 Sep 2025 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759201;
	bh=SDRfEnPDbo0TvGhLxWvCb8p6jdLwR0wt1Y/xKesV3QE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UB66HhVL+78b+DDBf7MLrp8q8aCkplr1Jzi4MlBW3349UyLzwNojFh3llDePfewIx
	 RyaU3EiIHXinrS+VzrDGZrLpXRIDYv4ab7lx4g5CDXoKvSGJ5HhJ82fr6Y7MAcd+Gh
	 XbjNTR92Ckpi5cgTxsyUqXBdRSIzhz9T4Tllkn5sepUz0ULE+/EI5cmZi8GFDnsMfr
	 z5ywUqvQZmjfFY12AjQOIntoDki/Zt5Rodb3UT5Ami7UPURODsXucXs5ZNQADJ1koT
	 njWtFUMuELJ+Jtkdd/2mhWE40pVWObNLwHlWV5MahNW3CaItMb2NHlevq/Yz/ZK5FG
	 cLjSHEh7G2ONg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCE383BF4E;
	Mon,  1 Sep 2025 20:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: read MACSEC_SA_ATTR_PN with nla_get_uint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675920725.3877324.6929775403857037213.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:40:07 +0000
References: 
 <1c1df1661b89238caf5beefb84a10ebfd56c66ea.1756459839.git.sd@queasysnail.net>
In-Reply-To: 
 <1c1df1661b89238caf5beefb84a10ebfd56c66ea.1756459839.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, mayflowerera@gmail.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 20:55:40 +0200 you wrote:
> The code currently reads both U32 attributes and U64 attributes as
> U64, so when a U32 attribute is provided by userspace (ie, when not
> using XPN), on big endian systems, we'll load that value into the
> upper 32bits of the next_pn field instead of the lower 32bits. This
> means that the value that userspace provided is ignored (we only care
> about the lower 32bits for non-XPN), and we'll start using PNs from 0.
> 
> [...]

Here is the summary with links:
  - [net] macsec: read MACSEC_SA_ATTR_PN with nla_get_uint
    https://git.kernel.org/netdev/net/c/030e1c456666

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



