Return-Path: <netdev+bounces-270154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB+0B5UAvmn1FAMAu9opvQ
	(envelope-from <netdev+bounces-270154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93C2E2E4F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC4D30488E4
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD729B78F;
	Sat, 21 Mar 2026 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDboCm0c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F78221F1C;
	Sat, 21 Mar 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059629; cv=none; b=KGDn5iq14qkjnJ3pb0YcN2i5r3ZYzo2kmuqg0zQmPNfnd6ncuaA3UBNUOsrIFQZ/Q8lFzRP/DJGgngtQTW0Xbt7krm69VmYx2Gv+CGqTiGZu4a3xH1MHpKfjhR7D3C4ZoeVat9YhR2ZLHz2XZUJPpyQuvk6pd2ocj4PDQ2cXKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059629; c=relaxed/simple;
	bh=ZgW2pQzRfqcFCAc0KPMvKjbsg2ZOe5531/y8EAVV2SY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jj1T/GSb5RJ9yqkqpsk3jc4/JiQSAFipBMGTqhXdi/1K4RO5AY7w0XnUHJaFuZMunyawNvJ8K/Lw/dXmsPeHXOFGjlOM8fjbJl/p+6z7BwXbc5ok1cNCibZ0TWB/qEa5CUh4/Vut1NrJCkxLVnUZ1VnTZxzMkjZdhj2irYwFQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDboCm0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA75C4CEF7;
	Sat, 21 Mar 2026 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059628;
	bh=ZgW2pQzRfqcFCAc0KPMvKjbsg2ZOe5531/y8EAVV2SY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDboCm0cLiJKPWeX62pjE8FBJ1dTmc7v6xPGvprrlPrjwr+k6se/JMsherA0p80gf
	 YpbiUH2HDIWyv5GLg0stak93c7/QgbeHkCxgIkEVeBXaqm3BxJrezwuAii5MmEa0uE
	 mtQvGQxidir8frPnLSWOnC7Wy405GDlf5wA1/pkfgZy0iUash1LQ2ohMoqe5w9r8BU
	 LQ5WO0dTXyBIU18kdz7X6PItE0OVDr+hcVWJBFV3CQwYbYfuRm/pCPlZVwhxSh6fcn
	 K0mxBsd/XvdH72EtGN36gBTfr9E2NOomsILw12U0C3aM27/ijlLyZOUGoe0xwaaiFa
	 2ryb8AZo7a/iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FD03808200;
	Sat, 21 Mar 2026 02:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/4] net: phy: realtek: pair order and
 polarity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405961878.2725242.11633577639146483232.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:20:18 +0000
References: <20260318215502.106528-1-dam.dejean@gmail.com>
In-Reply-To: <20260318215502.106528-1-dam.dejean@gmail.com>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, robh@kernel.org, kuba@kernel.org,
 maxime.chevallier@bootlin.com, pabeni@redhat.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, davem@davemloft.net, hkallweit1@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270154-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,bootlin.com,redhat.com,vger.kernel.org,google.com,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA93C2E2E4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 22:54:57 +0100 you wrote:
> The RTL8224 PHY gives the manufacturer some flexbility with the pair
> order and polarity to ease the wiring on the PCB. Then the correct pair
> order and pair polarity must be provided to the PHY to function
> properly. This series adds the support to configure the pair order and
> the pair polarity to the Realtek PHY driver.
> 
> Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
    https://git.kernel.org/netdev/net-next/c/c1887257a81b
  - [net-next,v9,2/4] net: phy: realtek: add RTL8224 pair order support
    https://git.kernel.org/netdev/net-next/c/330296ea9e15
  - [net-next,v9,3/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
    https://git.kernel.org/netdev/net-next/c/58ffb5910f32
  - [net-next,v9,4/4] net: phy: realtek: add RTL8224 polarity support
    https://git.kernel.org/netdev/net-next/c/beed9c0e9b53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



