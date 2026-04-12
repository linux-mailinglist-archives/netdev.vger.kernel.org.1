Return-Path: <netdev+bounces-277919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF+gFgsU3GnYMAkAu9opvQ
	(envelope-from <netdev+bounces-277919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:52:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64B3E63B4
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AAD730276B3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006131B838;
	Sun, 12 Apr 2026 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUXkgbrg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BD317150;
	Sun, 12 Apr 2026 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776030658; cv=none; b=LM7NyY2CB6luFNrysS/MlFrBCJvgea+pP2RrOppwwTgl+BZoZ+EAU4S1ppbGSx1zsu5N19vXDwzdp+cwRkUQ53Kw507pQVHqntcxLoLpLlEGeDjDJOwkJ0NTbL9Is+i3RUrOCdMwkkid6Cr6P2Gxsm94NqJqFg1vHxczeY+T4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776030658; c=relaxed/simple;
	bh=bmDKCVvevzuEaJk6LnhohHtZWfWE/xf9pYtUeIB7eOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DVYQd9M307UxCXOdsTLB12uAmi1gnVT8GdShmxnkR1wlDbnjiv+x/vl6Ub1J+sVTOSc83aPh3589kHsCc+2Iv4ar9CGwzdQvZ+MsA1mJICV4w8mHszuL+QGfnAiG0o6J/24hyqBqdg9ZVqJnIHnBL01AZjaF/hDkhOo/YN127/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUXkgbrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ABFC19424;
	Sun, 12 Apr 2026 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776030658;
	bh=bmDKCVvevzuEaJk6LnhohHtZWfWE/xf9pYtUeIB7eOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oUXkgbrgppoq0WYF3j3hrwy96SBRYXjV4H/fgT6jWVbBbGxkH1QOFGOn8jIDkEFDS
	 nHNfd0fsdaS0Gj6UjJbIMM6uuOitbaFObWLC+6Mf36d8vdc6/RzahxI/6POVd4vzVK
	 6b0vK4a7aQsI94w7x1QPGL2/qBVBx/Q3Oudg2BfyN4ceOstMZhALSqZmsdPXbCJoX0
	 t31AOWwm/kWkG6qMIw1dYUJEf7e2uh9d7SIyi6jYKYVwr3qBYO/88pJOEwTv5XyZQk
	 SRFt6IXFGYxnGe6HIsqtCG2gmOvoAQqNvohfd+gdzU86+QDdCP57tz1sr/SRs21meX
	 L0O/DrdocWYyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EB53809A8C;
	Sun, 12 Apr 2026 21:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] Add support for PIC64-HPSC/HX MDIO
 controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603063079.3833036.7371317402056345976.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:50:30 +0000
References: <20260408131821.1145334-1-charles.perry@microchip.com>
In-Reply-To: <20260408131821.1145334-1-charles.perry@microchip.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, MameMaria.Mbaye@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 devicetree@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277919-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CB64B3E63B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 Apr 2026 06:18:13 -0700 you wrote:
> Hello,
> 
> This series adds a driver for the two MDIO controllers of PIC64-HPSC/HX.
> The hardware supports C22 and C45 but only C22 is implemented for now.
> 
> This MDIO hardware is based on a Microsemi design supported in Linux by
> mdio-mscc-miim.c. However, The register interface is completely different
> with pic64hpsc, hence the need for a separate driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
    https://git.kernel.org/netdev/net-next/c/268bb35d1a34
  - [net-next,v5,2/3] net: mdio: add a driver for PIC64-HPSC/HX MDIO controller
    https://git.kernel.org/netdev/net-next/c/f76aef980206
  - [net-next,v5,3/3] net: phy: add a PHY write barrier when disabling interrupts
    https://git.kernel.org/netdev/net-next/c/96aefe3afe0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



