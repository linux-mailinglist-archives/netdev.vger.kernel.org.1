Return-Path: <netdev+bounces-265580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IgMFdfermm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:53:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88423AF40
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07B38304D1D2
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B73D5227;
	Mon,  9 Mar 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYpwCd57"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9A3B8BB1;
	Mon,  9 Mar 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067680; cv=none; b=IbEAtYp90lBvqEzvx8vzhpmXj3KG9Wk1pKSVgxdrIvU73fl888KjlHHsMPdyMfcd2M3DfYzFS4aVMMOfY2ll4wOjIKrm3PCayoICvT9BLqhhEOzYrMAMayeejTgrAY7ADVjH3GVT48BpVnDjb7dMr1f7cxHtf5MAnhqVEpNFX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067680; c=relaxed/simple;
	bh=vIxCfjaSCeI9F5QY0cC1oSOFnke/OxOSBQ+umP92cxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpaxaqZoX2kMtAidYXDE8k30rs0KXZ+k1X/bO4jtQCpXYIBP5TIymeb+3sGZN/8GW2pXUy1CeRXp8CMFxaCJXb1YbLU6moOr5zShk18WwkImOybFD7UWIVhDit2b/NkRuvlv8+vbHztZ7CrJmv2kCqqQ715oK2abWdbkJNotdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYpwCd57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF667C4CEF7;
	Mon,  9 Mar 2026 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773067680;
	bh=vIxCfjaSCeI9F5QY0cC1oSOFnke/OxOSBQ+umP92cxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RYpwCd57zj3UdmYPRYBua7Cs4UobsHavW22Kw2Hh0sYa9tfwIOqcEIVKIwyi2CQJi
	 jtGZe3kvWJQ9dicB/Nm5OfcAyDBRD0vr1SiUzAt/cTGaOiE21HU/vMBlQx9mbFAhc4
	 gzftjGyUwJ0r23OGIgMTYYz+MrtL7N2bIkdGIKBY8ERFWI0cnYAMvf/ONlCef3UtY4
	 ovmBOeP30UqmY4wJMH6QSUTLhFZ/Okvv74iI/6J2XdobjdquruG+k/OIFow5OJUnYd
	 ffWHcWj/0WRRgbON+uP3sV3TOpUixKT/ogRNDdQ6pDXnZyK/9lknkHrWaltDHSFV2M
	 gNXWofbeUzY9Q==
Date: Mon, 9 Mar 2026 07:47:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260309074758.0ea95a18@kernel.org>
In-Reply-To: <20260309022013.5199-1-fmancera@suse.de>
References: <20260309022013.5199-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CF88423AF40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-265580-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 03:19:33 +0100 Fernando Fernandez Mancera wrote:
> Historically, the Linux kernel has supported compiling the IPv6 stack as
> a loadable module. While this made sense in the early days of IPv6
> adoption, modern deployments and distributions overwhelmingly either
> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
> no practical benefit today.

Have you tested this? Every single VM config we have in CI dies with:

[    0.774671][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000187: 0000 [#1] SMP KASAN
[    0.775165][    T1] KASAN: null-ptr-deref in range [0x0000000000000c38-0x0000000000000c3f]
[    0.775165][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc2-virtme #1 PREEMPT(full) 
[    0.775165][    T1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    0.775165][    T1] RIP: 0010:ipv6_add_dev+0x32/0x1e0
[    0.775165][    T1] Code: fb 48 83 ec 08 e8 0e 48 a8 ff 85 c0 0f 84 65 01 00 00 48 8d bb 39 0c 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 54 01 00 00
[    0.775165][    T1] RSP: 0018:ffa0000000017d10 EFLAGS: 00010216
[    0.775165][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
[    0.775165][    T1] RDX: 0000000000000187 RSI: 0000000000000008 RDI: 0000000000000c39
[    0.775165][    T1] RBP: 0000000000000100 R08: ffffffffa3eed8dc R09: fffffbfff4f10288
[    0.775165][    T1] R10: fffffbfff4f10289 R11: 0000000000000001 R12: dffffc0000000000
[    0.775165][    T1] R13: dffffc0000000000 R14: ff11000001f1cc00 R15: ffffffffa8216a90
[    0.775165][    T1] FS:  0000000000000000(0000) GS:ff1100008707a000(0000) knlGS:0000000000000000
[    0.775165][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.775165][    T1] CR2: ff11000036a1e000 CR3: 000000003453b001 CR4: 0000000000771ef0
[    0.775165][    T1] PKRU: 55555554
[    0.775165][    T1] Call Trace:
[    0.775165][    T1]  <TASK>
[    0.775165][    T1]  addrconf_init+0xa9/0x160
[    0.775165][    T1]  inet6_init+0x287/0x410
[    0.775165][    T1]  do_one_initcall+0xd7/0x4a0
[    0.775165][    T1]  ? trace_event_raw_event_initcall_level+0x210/0x210
[    0.775165][    T1]  ? __kmalloc_noprof+0x2c5/0x730
[    0.775165][    T1]  kernel_init_freeable+0x57d/0x620
[    0.775165][    T1]  ? rest_init+0x200/0x200
[    0.775165][    T1]  kernel_init+0x1e/0x170
[    0.775165][    T1]  ? _raw_spin_unlock_irq+0x33/0x50
[    0.775165][    T1]  ret_from_fork+0x472/0x6b0
[    0.775165][    T1]  ? arch_exit_to_user_mode_prepare.isra.0+0x140/0x140
[    0.775165][    T1]  ? __switch_to+0x538/0xcf0
[    0.775165][    T1]  ? rest_init+0x200/0x200
[    0.775165][    T1]  ret_from_fork_asm+0x11/0x20
[    0.775165][    T1]  </TASK>
[    0.775165][    T1] Modules linked in:
[    0.816998][    T1] ---[ end trace 0000000000000000 ]---
[    0.818082][    T1] RIP: 0010:ipv6_add_dev+0x32/0x1e0
[    0.819103][    T1] Code: fb 48 83 ec 08 e8 0e 48 a8 ff 85 c0 0f 84 65 01 00 00 48 8d bb 39 0c 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 54 01 00 00
[    0.822985][    T1] RSP: 0018:ffa0000000017d10 EFLAGS: 00010216
[    0.824176][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
[    0.825749][    T1] RDX: 0000000000000187 RSI: 0000000000000008 RDI: 0000000000000c39
[    0.827317][    T1] RBP: 0000000000000100 R08: ffffffffa3eed8dc R09: fffffbfff4f10288
[    0.828892][    T1] R10: fffffbfff4f10289 R11: 0000000000000001 R12: dffffc0000000000
[    0.830460][    T1] R13: dffffc0000000000 R14: ff11000001f1cc00 R15: ffffffffa8216a90
[    0.832037][    T1] FS:  0000000000000000(0000) GS:ff1100008707a000(0000) knlGS:0000000000000000
[    0.833800][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.835095][    T1] CR2: ff11000036a1e000 CR3: 000000003453b001 CR4: 0000000000771ef0
[    0.836670][    T1] PKRU: 55555554
[    0.837358][    T1] Kernel panic - not syncing: Fatal exception
[    0.838351][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---

