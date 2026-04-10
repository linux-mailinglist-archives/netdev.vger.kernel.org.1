Return-Path: <netdev+bounces-277221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPFJOIJq2GkhdAgAu9opvQ
	(envelope-from <netdev+bounces-277221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:12:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC963D1C03
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE3673013EEC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B330B51F;
	Fri, 10 Apr 2026 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOWd1ZDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13011309DB1;
	Fri, 10 Apr 2026 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790647; cv=none; b=LrmOqewXgV15q4vm8yc6pTi+08IpNTsuheGXnkBfNkDrcTFrgpGRKDXR7uacCtaa2LcFG/24/I0KVSkGaa7AVPtvmhpw1F22t5k3GyAcl7k+hx4eUhbIdWDlnstjGvCCCTwgbK0SZuhg4xTAh0hVmOAQZSVIH+kPbxVKBCCl5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790647; c=relaxed/simple;
	bh=8uwWqIKQKYdlfy9K/zuqROgSQ2HekfT66LpIoAS5aqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRbrmkfXNW0X6PIQruHTX5gvnkCuSZ9+C+pCRII2Ns6q/iss+xclYmJO2k7IRSTCrGF5siEnXFqe0A159P16omspKmCGjLlKk5Zr9EalzOmXhgARkrsV57LTUru1SLwek5U8h2sKdte+nKAPhN4IeC1viqVarmsYQVTWkesScrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOWd1ZDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980D7C4CEF7;
	Fri, 10 Apr 2026 03:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775790646;
	bh=8uwWqIKQKYdlfy9K/zuqROgSQ2HekfT66LpIoAS5aqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dOWd1ZDW8gwug6z+kpUYbQAJFVqTAmt3VjrIPR9uJkuY8Z4DLgUnSERcO4qbOzfgQ
	 qBFGhUbI63j+hR2rhVHSO/xBhIAwg5jFMBBrwSQ6kzqNlrhyj9JDrsR12PxwV9Qdrb
	 yEvw4/jkZynEahKGaWeJiUCu9aUMNcIoqYmr0Nm4Nsv6qPj92smSTZxu5lotRgsJmt
	 RQ6aCXLpZsiu+RpU2nrlu6Z/vWTPmE+BYJ1g5Y/R8bMdInKQpzuqPwUiK62QZaeDYQ
	 QZkjUAAut9tzOhTFXXniVMO3yyh0dRApgHPG5CiITCmPMdVaYnGk1pajhljmPaRLPs
	 iDobPTaYnKbhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FB53809A22;
	Fri, 10 Apr 2026 03:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v6 1/3] dt-bindings: net: realtek,rtl82xx: Keep
 property list sorted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579062179.1844106.1500361028332601259.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:10:21 +0000
References: <20260405233008.148974-1-marek.vasut@mailbox.org>
In-Reply-To: <20260405233008.148974-1-marek.vasut@mailbox.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, robh@kernel.org, davem@davemloft.net, olek2@wp.pl,
 andrew@lunn.ch, conor+dt@kernel.org, edumazet@google.com,
 f.fainelli@gmail.com, hkallweit1@gmail.com, ivan.galkin@axis.com,
 kuba@kernel.org, krzk+dt@kernel.org, michael@fossekall.de, pabeni@redhat.com,
 linux@armlinux.org.uk, vladimir.oltean@nxp.com, devicetree@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277221-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,wp.pl,lunn.ch,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AC963D1C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 01:29:56 +0200 you wrote:
> Sort the documented properties alphabetically, no functional change.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Ivan Galkin <ivan.galkin@axis.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
    https://git.kernel.org/netdev/net-next/c/4de7a8acd18e
  - [net-next,v6,2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property
    https://git.kernel.org/netdev/net-next/c/bfb859a5cb49
  - [net-next,v6,3/3] net: phy: realtek: Add property to enable SSC
    https://git.kernel.org/netdev/net-next/c/84c5a3f00084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



