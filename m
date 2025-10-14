Return-Path: <netdev+bounces-229008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9ECBD6EC8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C65018A3156
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F132BDC13;
	Tue, 14 Oct 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NADOmdDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878F2BD5B3;
	Tue, 14 Oct 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404255; cv=none; b=mt58xsPJdn0g+Ekf3xDJwTVr31dfAYlhcK+m7QM2ycaBzvd0cM+8kY5ccRLT1d0K6clyr+VKQpVDOk7C84nvDXSbqYfvRU6h1GbCx7Sz2UlDjm/VVA1UeoRJaGMdSlfCF88eKDUrjCsFLO0GN//Q8m5EuzKRiga9pmLfeiRrQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404255; c=relaxed/simple;
	bh=Inv94ODKFsUY5/yc+DW9FTTh+sIublfdkfgxei5yXqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S9qlJuDD9igQqP4VERhchXZ3dqetzfOmOCnNLFWRrm1EowweSmVuCycjcjdjdOEWofdTyAGqX9zVwFcMDzN3vi+MkkhZt8Eztt2Imm/FlNfgonsEPk5jxfu+jrkt/GONigcsR2lkVSl8nqsIMU1+Jx1vOuM1Hr+WW1pEfIH+QYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NADOmdDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A2C4CEE7;
	Tue, 14 Oct 2025 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404255;
	bh=Inv94ODKFsUY5/yc+DW9FTTh+sIublfdkfgxei5yXqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NADOmdDLlMxy8/c0Tr0hOzoNiJA20AIwUABt9ME9pd1+KrkCP5mQSeA4WeAoDaZhy
	 fnem+VZgCLiZ3wmJcfmFlT6ltIG1010xujco1s5HEhV6ykN9wK3J5mp6mvArF7jEVb
	 75h/rg2OoWLHSv4BCAEEIrM5JKg3b1m78bMc0hb9FK8UenD2fEXuSi/CzZSFs7xN9Q
	 J1sqDuwaUAuFkQFTC97W5svPeAtb5UilJT1NDdYeLyq7xKbIJqUFU7cr3ZftcY6FIw
	 rx0nSyDl/DW1Tgwvh49eIsC3JdfdVzY9HFhlp+sApYgQC+d5OoG69uP7Vc5WV6cnr7
	 kmrjBsf6l0GqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D23380A962;
	Tue, 14 Oct 2025 01:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: zl3073x: Handle missing or corrupted flash
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040424124.3390136.12798125695127253829.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:41 +0000
References: <20251008141445.841113-1-ivecera@redhat.com>
In-Reply-To: <20251008141445.841113-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Oct 2025 16:14:45 +0200 you wrote:
> If the internal flash contains missing or corrupted configuration,
> basic communication over the bus still functions, but the device
> is not capable of normal operation (for example, using mailboxes).
> 
> This condition is indicated in the info register by the ready bit.
> If this bit is cleared, the probe procedure times out while fetching
> the device state.
> 
> [...]

Here is the summary with links:
  - [net] dpll: zl3073x: Handle missing or corrupted flash configuration
    https://git.kernel.org/netdev/net/c/fcb8b32a68fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



