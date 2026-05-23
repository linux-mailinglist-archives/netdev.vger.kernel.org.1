Return-Path: <netdev+bounces-290984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF+5AtH3EGoxgAYAu9opvQ
	(envelope-from <netdev+bounces-290984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E65BC201
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8033020A69
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4570E214813;
	Sat, 23 May 2026 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf0boKZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155B2066DE
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496825; cv=none; b=llECCh36MGPpr82xVX2thb8lNHvdsHl6td6ykrv24jqQdiIXhcCtfQ4xuOlW7eYaV2ykxDErxxN55436/4PBn08xf6ga21vCQ3hHfAcqJ3pDfjXa/evO8T6lhQTbUxQjhPfDUxO2gb+siHPR0kla5uj+9oeXU8EeHk+PZbsg2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496825; c=relaxed/simple;
	bh=hgHQ0gOsVc8/wwAj7SxdlCkaOHz3iPKBfEri5VuDLnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9j7jpU1X+f1x3JVVqOhjCVNX1q7kThyBKFCUSDfbOprIMLlAD01qqZc1afTzvL0eY/LMvcx76VUZsh3cbOpLvh48nXokKim+yFIHgWn3TkrcoYL8Oo5PLb4eXFoECRK21R1cNQPswgECR3uE1WebTs2ITd5F7/rms8JCQLMcIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf0boKZR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3511F00A3D;
	Sat, 23 May 2026 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496821;
	bh=CyXVcoNay9MIxZuD0Iv/0SEi00lexVgCbwnVb2yPKx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nf0boKZRTqlZ4Pp2Ovb6NRG9XbMhpP0CWMjHUEYvfg/sGYWtIVLaTx/AWhrTalEOE
	 HSp3e11Dy/mKxkvVfBcDqdbS8XZ6zywJIo16kbrogosjnertGx8zfvjx7THStxM9C9
	 lg9ozCy4WMDQbFbUiJpbI1tXl8dcZr5KEcO8g9OO3vTZswPG1mAB0JCJEC6L/uw5FD
	 OawTmrDGbYUpExcXxTxmS9MvDJDuDWbgvWjSZ3VhUif5DnaY6JMcIW5CCWJMfxNEo/
	 mv6VM9EyHhkVKWSUlKOXT59hx2mfkT8A0ZOTjcmwFwTWQuUayvfisjog71WLKbRx1p
	 Hjp8XZvaIhTQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4A393100F;
	Sat, 23 May 2026 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/7] ARCnet: remove outdated drivers and information
 and
 unused code; small cleanups and documentation improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949683013.1426243.17915123614529582459.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:30 +0000
References: <20260521001631.45434-1-enelsonmoore@gmail.com>
In-Reply-To: <20260521001631.45434-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290984-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 699E65BC201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 17:16:12 -0700 you wrote:
> v2 of this series is identical to v1, but with the patches reordered to
> resolve a transient build failure. The description from v1 follows.
> 
> This patch series mainly removes the ISA and PCMCIA ARCnet drivers and
> documentation for them and hardware they supported. While ARCnet is still used
> in industrial environments, and cards are still manufactured, it is unlikely
> anyone is still using it with ISA and PCMCIA cards. Removing these drivers
> reduces future maintenance burden.
> 
> [...]

Here is the summary with links:
  - [v2,1/7] net: arcnet: com20020: remove misleading references to multicast
    https://git.kernel.org/netdev/net-next/c/ced9c8cf5768
  - [v2,2/7] net: arcnet: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/5bc0c090bcad
  - [v2,3/7] net: arcnet: remove ISA and PCMCIA support; modernize documentation
    https://git.kernel.org/netdev/net-next/c/910394c74c5a
  - [v2,4/7] net: arcnet: remove code depending on nonexistent config option
    https://git.kernel.org/netdev/net-next/c/c1125f6d4843
  - [v2,5/7] net: arcnet: expand unnecessary I/O abstraction macros
    https://git.kernel.org/netdev/net-next/c/e859db8ac490
  - [v2,6/7] docs: net: arcnet: remove outdated/irrelevant information; improve style
    https://git.kernel.org/netdev/net-next/c/19d554d3296c
  - [v2,7/7] net: arcnet: com20020-pci: avoid -Wformat-truncation warning
    https://git.kernel.org/netdev/net-next/c/eb8ffe14a554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



