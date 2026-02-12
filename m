Return-Path: <netdev+bounces-258507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB1TEiZAjmlTBQEAu9opvQ
	(envelope-from <netdev+bounces-258507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:03:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C471B1311CF
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A613178671
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C07032C31D;
	Thu, 12 Feb 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyyOebaX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F332C31A
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930020; cv=none; b=EXtdt3/QjosDLIAaJ9HA+WZnqb2RM52aO4ObDOs135shUGOXD2WUkqLjPvKpT1qwbNOBSXPiUse82uCpGSPsw3BzhvMKdJKPCYgkQ0tBC7pfa1lxlPNZduZYXOficWnaup9fyfTnowsinxZDPAG1MFl7idkD/w5GvPPbQ52EUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930020; c=relaxed/simple;
	bh=aaE1KRdXIdYiNBsEC1LLonMgcfm5pyUvYhv0fyJFMME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF4+H8UxwlqFYWBolHi/X4i7OdwnhugtjqW+ftvGxDTPBNXl24h/CyGdN9/qGMMqsre2/6rBpefu5ur5zsz/x+XxFhyzWby51Yo3pSGAUA30FTFCjLfLq1kR2EeNMlTRiiWbvk8qu8a8Zsz0xTTqw9q0xmTP/gclYl0HD95ZxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyyOebaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13828C19421;
	Thu, 12 Feb 2026 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770930020;
	bh=aaE1KRdXIdYiNBsEC1LLonMgcfm5pyUvYhv0fyJFMME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyyOebaXvwQVs+VyVwmUXJxAv9GCHN9hZgvK2FMm4UiHrOy90vyIQqgIGVbnVKsTj
	 83FAWSDzABZLqa3v0ZLZIny9wOBvlsqV3nzACgStkKM28Jbud0UTJ3sPEqIAZ7QaKp
	 zr9pfYARSb8s8mMaNkjAicxEs25zaVZpv9tCjo4wuss1Y2+ibntXNlWj126hfUmE9a
	 wAPRBVU08PaGIKYHJF3q2+czSFuoHUnlLq/BOXJghrayw8oogGqDKkNO6vzW2eCCbi
	 eQbxP7eFBWjA2nZosnznLt9krzMVNlyWXVD7DmRYf+wtRL32n1EplWHeGnY+Rtakrs
	 vHx5cKaMAt/vw==
Date: Thu, 12 Feb 2026 21:00:17 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] libie: don't unroll if fwlog isn't supported
Message-ID: <aY4_Yau83X1TxEop@horms.kernel.org>
References: <20260211091140.236389-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211091140.236389-1-michal.swiatkowski@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258507-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Queue-Id: C471B1311CF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:11:40AM +0100, Michal Swiatkowski wrote:
> The libie_fwlog_deinit() function can be called during driver unload
> even when firmware logging was never properly initialized. This led to call
> trace:
> 
> [  148.576156] Oops: Oops: 0000 [#1] SMP NOPTI
> [  148.576167] CPU: 80 UID: 0 PID: 12843 Comm: rmmod Kdump: loaded Not tainted 6.17.0-rc7next-queue-3oct-01915-g06d79d51cf51 #1 PREEMPT(full)
> [  148.576177] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 07/18/2020
> [  148.576182] RIP: 0010:__dev_printk+0x16/0x70
> [  148.576196] Code: 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 49 89 d4 55 48 89 fd 53 48 85 f6 74 3c <4c> 8b 6e 50 48 89 f3 4d 85 ed 75 03 4c 8b 2e 48 89 df e8 f3 27 98
> [  148.576204] RSP: 0018:ffffd2fd7ea17a48 EFLAGS: 00010202
> [  148.576211] RAX: ffffd2fd7ea17aa0 RBX: ffff8eb288ae2000 RCX: 0000000000000000
> [  148.576217] RDX: ffffd2fd7ea17a70 RSI: 00000000000000c8 RDI: ffffffffb68d3d88
> [  148.576222] RBP: ffffffffb68d3d88 R08: 0000000000000000 R09: 0000000000000000
> [  148.576227] R10: 00000000000000c8 R11: ffff8eb2b1a49400 R12: ffffd2fd7ea17a70
> [  148.576231] R13: ffff8eb3141fb000 R14: ffffffffc1215b48 R15: ffffffffc1215bd8
> [  148.576236] FS:  00007f5666ba6740(0000) GS:ffff8eb2472b9000(0000) knlGS:0000000000000000
> [  148.576242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  148.576247] CR2: 0000000000000118 CR3: 000000011ad17000 CR4: 0000000000350ef0
> [  148.576252] Call Trace:
> [  148.576258]  <TASK>
> [  148.576269]  _dev_warn+0x7c/0x96
> [  148.576290]  libie_fwlog_deinit+0x112/0x117 [libie_fwlog]
> [  148.576303]  ixgbe_remove+0x63/0x290 [ixgbe]
> [  148.576342]  pci_device_remove+0x42/0xb0
> [  148.576354]  device_release_driver_internal+0x19c/0x200
> [  148.576365]  driver_detach+0x48/0x90
> [  148.576372]  bus_remove_driver+0x6d/0xf0
> [  148.576383]  pci_unregister_driver+0x2e/0xb0
> [  148.576393]  ixgbe_exit_module+0x1c/0xd50 [ixgbe]
> [  148.576430]  __do_sys_delete_module.isra.0+0x1bc/0x2e0
> [  148.576446]  do_syscall_64+0x7f/0x980
> 
> It can be reproduced by trying to unload ixgbe driver in recovery mode.
> 
> Fix that by checking if fwlog is supported before doing unroll.
> 
> Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


