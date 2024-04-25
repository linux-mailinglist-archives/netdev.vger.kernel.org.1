Return-Path: <netdev+bounces-91259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514558B1F2F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67471F250A6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52DC1CD23;
	Thu, 25 Apr 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHTSmmf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD027FF;
	Thu, 25 Apr 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041029; cv=none; b=ps4HgqoPvtd5++7xIbL6+IRXUQLtXswMCj2fVzveWrSEOra1j8aWYTC72FTN2Nq3uojObalOiT30+IHk606heBKHGmdbxecjBFfgWOPWMy6UHcerzLRZgBSPNI0x7CSpfoOk24CGLBlvSIDxXidUhZM0n72qA1PW5sz2/M6ki5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041029; c=relaxed/simple;
	bh=tHxtzayUpNRFrnQheyyhBQiZQaqvq6KY8kVPxeurlEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YqRlcMk497b3/1HDUgzO74U82HXxl+G++nJYPVUFNSMpA9V+KGEW09ARitPGIADRQ/KiA+9UrhHXBkvNTVDlOOyn9KwTfYCFGlX9OYTYSkMIxeqe1jCTI1HprllQ8RnsQSQjUXVWTsbG+cg6JjvUaus0A2ZrOGVf1Z+WKUDR9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHTSmmf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 178A8C32782;
	Thu, 25 Apr 2024 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714041029;
	bh=tHxtzayUpNRFrnQheyyhBQiZQaqvq6KY8kVPxeurlEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PHTSmmf90Z19lLupDPl9bPDQbA1WVYSg/gRCAeARomRPmm+P9vioz9yT7EgGrGhA8
	 I6wnLvZlnxsgdopPI0M9ciCydGCnhOD7mFAb6OcUSzt3RLQySn+8L3ySyyyPJL9Ebh
	 xV77Zrw4G2V3D64jL0j6p38/a36GjQOWMthLBOkBKX4OCbqJD/NCdv+GCe90gc6Z+9
	 FA2ft2v6JglXo4HWuiJcr+VxXYtjwMgroMuklNtMmZ1XG0dN9H1HgX7cMhDRuDLdc9
	 TBw8y+ezsuIVlqthNn6jpo9/OQiAaBUbPXcsy+a9HhQ1Iw7j5xBtXH3ppgugNHASp5
	 ekpZFifMVUmQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EAC6C43140;
	Thu, 25 Apr 2024 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: dsa: mv88e6xxx: Add support for
 model-specific pre- and post-reset handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171404102905.28185.154076817026264524.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 10:30:29 +0000
References: <addee2a493823b4a7e0ea966b1713f4ed6c04a2e.1713858017.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <addee2a493823b4a7e0ea966b1713f4ed6c04a2e.1713858017.git.matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 festevam@denx.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Apr 2024 09:47:48 +0200 you wrote:
> Instead of calling mv88e6xxx_g2_eeprom_wait() directly from
> mv88e6xxx_hardware_reset(), add configurable pre- and post-reset hard
> reset handlers. Initially, the handlers are set to
> mv88e6xxx_g2_eeprom_wait() for all families that have get/set_eeprom()
> to match the existing behavior. No functional change intended (except
> for additional error messages on failure).
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
    https://git.kernel.org/netdev/net-next/c/0fdd27b9d6d7
  - [net,v2,2/2] net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches
    https://git.kernel.org/netdev/net-next/c/e44894e2aa4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



