Return-Path: <netdev+bounces-258502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKz4LrM8jmnaBAEAu9opvQ
	(envelope-from <netdev+bounces-258502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:48:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298121310C1
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19164300863A
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AF226CFE;
	Thu, 12 Feb 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWrmeR/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF611EDA2B
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929325; cv=none; b=uOiJHGabAFRo06S62sQP39QwIzjbGRnANaoRIMtbNPHs1jez7YvpbwEHA/kvxUercuydhadA+j9fzCFKFBERNewd4ePhTJwsqe23NRUJzvAMefaFzHMcQ52Zuc/UZwu7/j6cG3pjCMEJdLjWYw0sIF4T27Mmmy442HhOJqpKVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929325; c=relaxed/simple;
	bh=F7yhD+mVO2Br3s+whVRfIfAvP1hOE0RqxEZq3O1HHC4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AGRDmlgluTGD22oDHBMPdRos1MEWnuqX8z7NgM/iUzzbLxoAXt46tPHEOWLWG8mMNVV3PVLRiSmqeHGv0l1VUkbHtwDWqzT03I+Uds57DQex5e0hrWbvoG1Nz2TC1I0Sr/rZxOkyq6kSqGYGlO9s+JgCmyxLRu1Y+nzuR8iSYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWrmeR/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ED4C4CEF7
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770929324;
	bh=F7yhD+mVO2Br3s+whVRfIfAvP1hOE0RqxEZq3O1HHC4=;
	h=Date:From:To:Subject:From;
	b=CWrmeR/PELg0dIIS8sX0aBIlb8XWdTbISYqeqarc2moCm6lxBQtvTKte1nevAyzrP
	 KCtpUcoxhbIpFc9noCru/+xrkFW3MqeIPR1Ibd2F53s31LmPrSLNbG7hHxqLSLtJwF
	 /BmNmyeeWADejszgkKedcsCadAN+92kzboFPsAZ3E8XuAS7PktWUWmt83XA4lXPOFV
	 Vmp31zr+gVpXU2SjaCAKT4gcMt8jQ40MFMfVWlJGq4icGRrN+HOhHBkat4k37CKc9p
	 T9zi98vhJJPlyK5xBW0qjOh4z0Q6kVg2p7EXSyrTnfNuvjwXH6E+2p3QFXGR9MmwKI
	 +nKHMrEzpF2VA==
Date: Thu, 12 Feb 2026 12:48:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Feb 10th
Message-ID: <20260212124843.7fbbb3fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 298121310C1
X-Rspamd-Action: no action

Present: Andrew, Eric, Paolo, Simon, Willem, Johannes, Jakub

NIPA maintenance help (MoU)
 - Simon: proposal submitted to the board, not yet voted on
 - question from the board:
   - are we coordinating with K and LF on similar efforts (yes)

PHY SoW
 - signed, minor delays on trivial contracting matters

Lab stage 2 HW
 - delay on 2nd machine. Due to RAM supply issues
 - current delivery data in Nov - will follow up with the supplier
 - need to source a 10G cable as well due to shipping error

Patchwork
 - discussing possible contract work via LF
 - Jakub to write up a full proposal for the board

Lab admin
 - Paolo: could not log into some machines on Monday
 - Ansible needs some attention
 - plan to document how to maintain lab to allow load to be shared
 - Monday issues tracked down to linux.dev DNS outage

NetConf
 - discussed location options: Netdev Conference; LPC; Kernel Recipes

Research grants
 - plan to create RFP

