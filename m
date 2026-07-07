Return-Path: <netdev+bounces-305359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ez0MMsbFTGoJpgEAu9opvQ
	(envelope-from <netdev+bounces-305359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:24:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB04719B72
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:24:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ksOV7y0R;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305359-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305359-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D137318896D
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1139023D;
	Tue,  7 Jul 2026 09:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0496390224;
	Tue,  7 Jul 2026 09:10:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415427; cv=none; b=KVkz2y4NmCw9ML67rAmuCITqwdn70tB6w8hkSsv5aPVuwF23SEJLVGq+bNas26wbiQd6OBPcepIAEO7PxiRfzrACmiP5WxAc9dP4qY3oarqegzuNx+cTqnHT4LvVRNs7nWYzOKBngkHtpL6siVZJR/1nZy9peMmWseXXcPQ+PjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415427; c=relaxed/simple;
	bh=Z3NrfmBTOP6veegEk74Aokh0nSmMY430APsDcsFuucM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k5GRI8uvhRJeQ+DXc1lN+C/019rxWckMPMEmr6oM3Nhzw1tkmUtYotA2ePvMKosJFHqmXpM0mFgB/WblMLWvjvxWsmM5RBlRa3aa7HGI6g8uaqxn8MsKoTFmo7wOTM1U+bJyv7jjWHCpPmch/W5CO1H+EPSWtp0JkLhD46r/Oe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksOV7y0R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991761F000E9;
	Tue,  7 Jul 2026 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783415425;
	bh=cxohN/bVJexVcJA1tYN7/Z6HpwohNZMDFbPUHK6Ujv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ksOV7y0RJTUAG/wkfwZliYwFXMmR2pOmikxSoXCwXidVrAklzs5z5ZZYjhlSR7b1V
	 J/aD40Qvri0uUxURZi23/GlkmW3KcOjMR3qDKZ+2XxEefwhJduDHn6JdE+SPWTPKWc
	 0G9gNxDNa1cpxqTEybB38xF1uBuRE2oMUAGowI7nxsLCk5qVowmkC57FxzX588/qgp
	 /8JLjp220LFeLBGefgsvIsfMo33+Y63u8ZzF9xnKZsTTuEAl/SFKM2aq2y5lQnHq7C
	 vWCeFzd4YdVk5jwKr0lixaPXaz/GQPUd8pbg6CtPRvZiN5sp0D6XAGvAqftuLF8woh
	 R+05iS15Ob0vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AAE3925466;
	Tue,  7 Jul 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/liquidio: drop cached VF pci_dev LUT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341540539.1444421.11911347104966088843.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 09:10:05 +0000
References: <20260701040847.1897845-1-dbgh9129@gmail.com>
In-Reply-To: <20260701040847.1897845-1-dbgh9129@gmail.com>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kory.maincent@bootlin.com, zilin@seu.edu.cn, arend.vanspriel@broadcom.com,
 marco.crivellari@suse.com, u.kleine-koenig@baylibre.com,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305359-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kory.maincent@bootlin.com,m:zilin@seu.edu.cn,m:arend.vanspriel@broadcom.com,m:marco.crivellari@suse.com,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AB04719B72

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 00:08:47 -0400 you wrote:
> The PF SR-IOV enable path caches VF pci_dev pointers in
> dpiring_to_vfpcidev_lut[] by iterating with pci_get_device(). Those
> entries do not own a reference, because the iterator drops the previous
> device reference on each step. The cached pointer is then dereferenced
> later when handling OCTEON_VF_FLR_REQUEST.
> 
> Replace the cached VF mapping with runtime lookup on the mailbox DPI
> ring: derive the VF index from q_no, resolve the VF via exported PCI
> IOV helpers, validate it with the PF pointer and VF ID, then issue
> pcie_flr() and drop the reference with pci_dev_put(). Remove the
> unused VF lookup table initialization and cleanup.
> 
> [...]

Here is the summary with links:
  - [v3] net/liquidio: drop cached VF pci_dev LUT
    https://git.kernel.org/netdev/net/c/5c0e3ba4f500

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



