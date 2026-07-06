Return-Path: <netdev+bounces-305230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1c4BC4AlTGqJgwEAu9opvQ
	(envelope-from <netdev+bounces-305230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:00:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245D715DC9
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=TuADPFGL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305230-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305230-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E75C63025097
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D891230BD9;
	Mon,  6 Jul 2026 22:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11B1A9FB0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 22:00:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375227; cv=none; b=kh+8V7RL8tWBqT21UPFEFHlK7Joq03GySL8nORWqXcVO4u0U0SRoNWdcozVNYQywEAdOLn6Bxw0hqluUF1+FJPHF8VTKkG5EaVwySfR6tpgq9SvsRZty9pZZyvjSf55vSADS7KLDOgoh6dQSxFKYEKj4UHEwXgXIAXjt2KitYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375227; c=relaxed/simple;
	bh=r0JK7xaiF19k/tDxV4+raUI0cKiYgeChTrYADNUxJ/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ip6injDM2ujxqbbdRiXA5JlN5tT4nfmm63ZHr3gFfNB7gXKJ41ZGWWaLUC03jXGdbwaO5MWPbQMgUfy/bXiJHJiEbebAYg7kbvXB640po0fdg1cTltaZpE28Lixbsaw6yUzSK93+9eiuds9AB+nZZHmzPnFRFgmWrjnRpiAXUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuADPFGL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB051F000E9;
	Mon,  6 Jul 2026 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783375226;
	bh=DjMqWMd+5h6THtBBW/vMmvengJ17wWvk89tUuMxvISc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TuADPFGLGncNshnOM1vsq6fZJzfeeXpuLaLoZ2DzndYPIhDfSIySZ4iEvv+V/BG/S
	 PWb8MFzTlppV8jdnXNbVIk81l+fWaEnGUW0UizsfnJ7uM4wxQckUjnC0djfhLixMi8
	 Z5NBiiTOKMSJ3orL5SXZAuMBv7PC5MqzQTILiiE/9Kitmq8F3C6dpkm4tPadPe78Xx
	 itxnh6YirKqRnEHIshQsPEGxJ8KXvCQBJmSpStv4HzWg8eBrjZqEDi62FWSwK9H/Yj
	 YXpTWyGoUWq1E2acHs1QfjyveR2J25TXOUV1pchkhJoGcHbkWFP/Gb6xZF+DsXdmkm
	 XLWsLSEwxm+NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B273925F71;
	Mon,  6 Jul 2026 22:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 ethtool] man: ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178337520638.1223576.17680136243635201029.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 22:00:06 +0000
References: <20260703102004.1111597-1-siddaraju.dh@intel.com>
In-Reply-To: <20260703102004.1111597-1-siddaraju.dh@intel.com>
To: D@codeaurora.org, H@codeaurora.org,
	Siddaraju <siddaraju.dh@intel.com>
Cc: mkubecek@suse.cz, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, Shubham.Das@intel.com,
 balaji.chintalapalle@intel.com, vijay.srinivasan@intel.com,
 magnus.k.lindberg@ericsson.com, niklas.damberg@ericsson.com,
 jonas.wirandi@ericsson.com, siddarajudh@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305230-lists,netdev=lfdr.de,netdevbpf];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FREEMAIL_CC(0.00)[suse.cz,lunn.ch,bootlin.com,vger.kernel.org,intel.com,ericsson.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:D@codeaurora.org,m:H@codeaurora.org,m:siddaraju.dh@intel.com,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:Shubham.Das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7245D715DC9

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Fri,  3 Jul 2026 15:50:04 +0530 you wrote:
> Annotate the 10000baseCR entry in the advertise mask table so users
> understand what physical media this mode it actually represents.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> [...]

Here is the summary with links:
  - [v2,ethtool] man: ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=b0d4a0d60471

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



