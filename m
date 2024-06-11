Return-Path: <netdev+bounces-102415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A9902DFF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 03:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FBC1F22A7E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B108F5A;
	Tue, 11 Jun 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gszLsRIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C28488;
	Tue, 11 Jun 2024 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070039; cv=none; b=qr9fRdzdxeowrg+vcw5QNqiI6O+1cQGjffb5dB/szhAs8ppfjeg2uwCfrANaQ9Qz3aCUBYocgHLyPRSppmiXY5Aiul25i+svQjcGVR0CVd7EjkX98/y4aMzw+gwFMg+7X4lTzG0kI6b6RFQ0xQvSLbVdlTAcZlnpeh87wxMsRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070039; c=relaxed/simple;
	bh=j7HCWuWgHbxnyKpBoHz9jiNnduHdqNBguHdWyEaUkeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E+/76Com0gcCJ+EyH2XQPusijYqFGosLoZKAFPfXHTHutw1Li79my463i78lz0naTm2d1Qop7FuvDoCco+I1YWkCeUSxG7QwCcjj/hYKtsU+wfYM6ziDQ+dr4RCShiNC3mKu7iHXUWeaDdKvrAktsn8PV39f38hcb8iDx5xOUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gszLsRIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF96BC4AF49;
	Tue, 11 Jun 2024 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718070038;
	bh=j7HCWuWgHbxnyKpBoHz9jiNnduHdqNBguHdWyEaUkeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gszLsRIN2CpfC5SXqU7SF8D7iD4hAZ/ntx8Yatxf+blU0aITsUww+695zk1JZnewo
	 gtfDw9rmWZuHiHY32zuu97h4zs0eLZ8q/cEfooHUns47w53Cmx67jIUJ/1vdNLkDWv
	 KDrxQOIb0scj/+IIS1e06BZWhqA2QxAiQAdlLatSI35GC71eXuNaXsp84M7Oa9dfkA
	 uXU+0Y+1XP1Iq9BLhUn8hFNZMsXANyP0WKQ7MSeE1WjK7usZEwekWxb80SWRnUCjGq
	 h7mvs30kqSnQDO5KJtOK18VoP2im3gC3kqWCInhXP7kkDB5kEVgXgHw1GFbKMeuf6u
	 GLMyUO9f75a5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C39AC54BB3;
	Tue, 11 Jun 2024 01:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] isdn: add missing MODULE_DESCRIPTION() macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171807003863.13638.7461391442889099274.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 01:40:38 +0000
References: <20240607-md-drivers-isdn-v1-1-81fb7001bc3a@quicinc.com>
In-Reply-To: <20240607-md-drivers-isdn-v1-1-81fb7001bc3a@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Jun 2024 11:56:56 -0700 you wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcpci.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcmulti.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcsusb.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/avmfritz.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/speedfax.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNinfineon.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/w6692.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/netjet.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNipac.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNisar.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/mISDN_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/mISDN_dsp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/l1oip.o
> 
> [...]

Here is the summary with links:
  - isdn: add missing MODULE_DESCRIPTION() macros
    https://git.kernel.org/netdev/net-next/c/2ebb87f45b3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



