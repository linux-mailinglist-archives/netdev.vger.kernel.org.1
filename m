Return-Path: <netdev+bounces-297374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J+kjF7C4KGpiIgMAu9opvQ
	(envelope-from <netdev+bounces-297374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF86651F6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:06:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fTe+smOT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297374-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297374-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FC51303DB54
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5C264A9D;
	Wed, 10 Jun 2026 01:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628325B0B9;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053222; cv=none; b=JyaOdUzuNN2Fnyfwh6JkYzUQbme/a/ijVH3xycArpSUiZtdPt6HAZkRnZnm60yZ9CyKC9Pv8ElAeVw5lhPfGhF+eHuoJ8BGSWtB7EvQSuAU6Bl/0Wf4fIfXB1nLZmUmM7zx2imipk7W/XC83ClW7zj1dnzTPa2HIgi63c/KNNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053222; c=relaxed/simple;
	bh=6jo3pn7ncYNvh+ZM1hipTbj9j/x5TQMoiF2QdfK6p20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GaMh3B1mCQDJeKV40mnEO9w3Yyx2yVx9rBMEmOXNXne+kPQ+YsRcOLoeSkY5J5LnOTX/UI/jC5ZDWTySs0E02whUFI9QQ36aTm4JLdu/xGtr6ZlFHJJN/0bMALCJm9qwk8dKWMJKl2rlAgHm+6Mi9CFaC4x2IUS0YYahPEkmO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTe+smOT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9921F00893;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053220;
	bh=CisMcesBLTys4b9llimGpTUDsNVeh8kcpD3Tlw5QUk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fTe+smOTfp508L2lL1WGLVjJ/krIGfi0yOM7CXQdNTm7hbr3W3zTwyDRXycpp6oul
	 sO2HxjAtXbm7EqcPJVUcRtNlR3lr36zFNXb/NfWMITsI4m9S7G5CJ20+L7iZhJvro+
	 fcx1UZ704EGTwb6JergFpgrCIbYKR+s79abrdqosM/Xm+gDQoDSMj+RGPrOCe1Ek5N
	 oCZyX4nX+dtV4WZzThP+bu1HqP4rQA2QCAXDFGZnSb32iW9HFBzc8U9p/AzeP2OW2q
	 BUKkLNVx9LiY9XJhwOyljBwD+g+h7dV6vu3mx3h5rEvEaIXPNqGUATnTtZa8O/GNi+
	 VFd2BOaDFfl0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C83930A12;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mscc: ocelot: validate netdev belongs to
 switch in .netdev_to_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105321863.2773882.14974731560626407551.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:00:18 +0000
References: <20260606125247.305167-1-mmyangfl@gmail.com>
In-Reply-To: <20260606125247.305167-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297374-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:vladimir.oltean@nxp.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49CF86651F6

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 20:52:44 +0800 you wrote:
> The .netdev_to_port() currently takes only a net_device and returns the
> port index, without verifying the netdev actually belongs to the switch
> being operated on. This can cause flower rule parsing to silently
> resolve to a wrong port on the local hardware.
> 
> Update both implementations felix_netdev_to_port() and
> ocelot_netdev_to_port() to validate ownership. Also update the callers
> in ocelot_flower.c to pass through the ocelot context.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mscc: ocelot: validate netdev belongs to switch in .netdev_to_port()
    https://git.kernel.org/netdev/net-next/c/ea07514700f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



