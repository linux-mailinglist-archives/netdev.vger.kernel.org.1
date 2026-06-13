Return-Path: <netdev+bounces-299100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y4SxNMrsLWprmwQAu9opvQ
	(envelope-from <netdev+bounces-299100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:50:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592A6800F7
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:50:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bawuZ1fD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299100-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 793573003D31
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1D234752F;
	Sat, 13 Jun 2026 23:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151233C194
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:50:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394630; cv=none; b=bgKxU2Ls7PhxxnPT3Hdoo2ucWNUFWt+hSAspoRwmseJD9NRwkQKNyA4/bg6ExGxnJ9x9eO3KAt5oL98NvnkE5YRaS1RdlKa3A4Z++hTCh7FHCLFrdkxutNnkg293Nca4t+wyxI//enh/r1i//k/ykBdg8EcvO4Nt/bQU0PbdAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394630; c=relaxed/simple;
	bh=4Edk9f5P2qF37JuhJUHLlXD0xKSpnhPtY7l1IZcobXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnmoE38phE7Lp1f3AOH6B1fSpGuZFAMZ+xv/5t4UQo6Wa3j5RE7Io7wD41UTr5uEHFF8X/eYxfpZW3Y1ZMratOjBmP9UtbAyaQvVzVeCwGojXUzIeVokGbuCB0TTzdwnGdyuTXx2KoLtG6IkjjoJ64nW7cWzghhhOO/0pLrKmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bawuZ1fD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C32E1F000E9;
	Sat, 13 Jun 2026 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781394629;
	bh=k7pjZDD/KTnqLCY+5tgQyiC/Zbt9dmKewKNvRzSmR6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bawuZ1fD/lMg9bFtXsQiXJe6rxv2O5HT1YbUgJ5h49f2y5WzwirsJTe/qJZ9AXtI3
	 szzLMkBdkvS9CrkBC9GiRsj31sP4s7SArMalqlIZM7/Ymqiz21Age9Asc4ps/77jUy
	 zldxTCPTEs+5T4txFXxYp2SsaJcy9N6MUnzXCdmTAVNr1IbNxjmRPx1tyTZKKpeLjE
	 A0nIXcVJ0TL/se8z7uK65KBP1xqmw4efZyDX0GVDm7Wr7tPii27U1X6d/J+Aq1AkE/
	 4fFoRA8rSzabh/N4W6g2uiAjgWP0viSpXKFsNemQPu55FmrzLHCQrxt4jA2t+GDspg
	 wZdhm7lQWsbrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B743A54A32;
	Sat, 13 Jun 2026 23:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver
 Updates
 2026-06-09 (idpf, ice, i40e, iavf, ixgbe, igc, igb, e1000e, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139462489.1629661.15143442026278079817.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 23:50:24 +0000
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299100-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6592A6800F7

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 14:35:41 -0700 you wrote:
> Marco Crivellari replaces obsolete use of system_unbound_wq to
> system_dfl_wq for idpf.
> 
> Natalia removes redundant PTP checks on ice.
> 
> Corinna Vinschen removes redundant MAC address check on iavf.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] idpf: Replace use of system_unbound_wq with system_dfl_wq
    https://git.kernel.org/netdev/net-next/c/711bdf0b7879
  - [net-next,02/15] ice: remove redundant checks from PTP init
    https://git.kernel.org/netdev/net-next/c/e5652e6d37fe
  - [net-next,03/15] iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test
    https://git.kernel.org/netdev/net-next/c/8538aaea10e1
  - [net-next,04/15] net/intel: Replace manual array size calculation with ARRAY_SIZE
    https://git.kernel.org/netdev/net-next/c/48d588dc9f26
  - [net-next,05/15] ixgbe: e610: remove redundant assignment
    https://git.kernel.org/netdev/net-next/c/06be82a0d9d7
  - [net-next,06/15] igb: Retrieve Tx timestamp from BH workqueue
    (no matching commit)
  - [net-next,07/15] igb: use ktime_get_real helpers in igb_ptp_reset()
    https://git.kernel.org/netdev/net-next/c/2040b8ba371b
  - [net-next,08/15] e1000e: use ktime_get_real_ns() in e1000e_systim_reset()
    https://git.kernel.org/netdev/net-next/c/1b4558e0b4e8
  - [net-next,09/15] igb: use napi_schedule_irqoff() instead of napi_schedule()
    https://git.kernel.org/netdev/net-next/c/ef298ba0f9ed
  - [net-next,10/15] igc: use napi_schedule_irqoff() instead of napi_schedule()
    https://git.kernel.org/netdev/net-next/c/046100cdeb98
  - [net-next,11/15] e1000e: Use __napi_schedule_irqoff()
    https://git.kernel.org/netdev/net-next/c/4d9508d97b7b
  - [net-next,12/15] e1000: limit endianness conversion to boundary words
    https://git.kernel.org/netdev/net-next/c/4cc8566ae0d1
  - [net-next,13/15] e1000e: limit endianness conversion to boundary words
    https://git.kernel.org/netdev/net-next/c/a5ecafcfb27b
  - [net-next,14/15] igb: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/2904b67ba2f1
  - [net-next,15/15] igc: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/d4e035b3a517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



