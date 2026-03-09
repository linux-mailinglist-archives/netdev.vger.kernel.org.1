Return-Path: <netdev+bounces-265585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SImzIOXjrmmsJwIAu9opvQ
	(envelope-from <netdev+bounces-265585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:14:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB823B778
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73467306E615
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48E73D75BB;
	Mon,  9 Mar 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vp6uUlqC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hM1kNg2n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vp6uUlqC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hM1kNg2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D03D412B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069041; cv=none; b=NNOOwjLm3aW/gJ6GPkw5ub3U4BRxCFy+kwQP4o2w9ky6MnxOIXH+bvQMg3n/Pv2MFxvmXKtNkEmGz8csE5h+FDvxyMAZMSM3GLUrKRasW0Oq7AzExUUkTm4ARbRlTAVV7yGLHK4CsrZnIrfXtfpU0JJ8tesC7/GrQWUvq0unoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069041; c=relaxed/simple;
	bh=FJ5QRyc0Mi7LX+9SN/owBTv48MK1EeTX/3eUuCRTMTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp3CJvgqn5Pf5FqGQbJG3A+SdTIKJVyWrt7dqKkI7cE5Rm2NV9gcI3iHw2w25oMqdZ6HRzWp4jiqoxr0N/8vNkN9UPB/S6C8n5cHtknZHdQ4HyQzU+I1rtpHhCCsbMeaPyziXZkzRlyaTr3qeB5zq+3fUtxi3kHCefWPMp1s9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vp6uUlqC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hM1kNg2n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vp6uUlqC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hM1kNg2n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAF814D231;
	Mon,  9 Mar 2026 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773069038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fhwnjjyyy0wyFYIZTD5wvdqT3pYi9L5F9iUpNgbxrc=;
	b=Vp6uUlqC1LYJS+tncQL7e2PFZGqa5At9PoRDEn19qZOkVEkW8gQaZul6PT8qPCopNn1li8
	oJ34idPrQnNDWHzxnBlKWzjeUe7YVMGSyZCMXgaeHk/ilLvAckO6zpOF/g3GY9AZe48swj
	wU0ZyXXT2OUDFADHOQY8TqNyOK2FBMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773069038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fhwnjjyyy0wyFYIZTD5wvdqT3pYi9L5F9iUpNgbxrc=;
	b=hM1kNg2nLWMGckaUFoxxPA/IikwK1PzGZ3ZuZON8UpgwgJNMdJKr8BIyvJGuagIz0terUD
	vIqMWjOpzqFGNpDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773069038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fhwnjjyyy0wyFYIZTD5wvdqT3pYi9L5F9iUpNgbxrc=;
	b=Vp6uUlqC1LYJS+tncQL7e2PFZGqa5At9PoRDEn19qZOkVEkW8gQaZul6PT8qPCopNn1li8
	oJ34idPrQnNDWHzxnBlKWzjeUe7YVMGSyZCMXgaeHk/ilLvAckO6zpOF/g3GY9AZe48swj
	wU0ZyXXT2OUDFADHOQY8TqNyOK2FBMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773069038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fhwnjjyyy0wyFYIZTD5wvdqT3pYi9L5F9iUpNgbxrc=;
	b=hM1kNg2nLWMGckaUFoxxPA/IikwK1PzGZ3ZuZON8UpgwgJNMdJKr8BIyvJGuagIz0terUD
	vIqMWjOpzqFGNpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2343B3EF6D;
	Mon,  9 Mar 2026 15:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id teXBBO7irmnudAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 15:10:38 +0000
Message-ID: <dc670a8c-1245-4949-bf7f-53e8a1c5070a@suse.de>
Date: Mon, 9 Mar 2026 16:10:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309074758.0ea95a18@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260309074758.0ea95a18@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EFAB823B778
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265585-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 3:47 PM, Jakub Kicinski wrote:
> On Mon,  9 Mar 2026 03:19:33 +0100 Fernando Fernandez Mancera wrote:
>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>> a loadable module. While this made sense in the early days of IPv6
>> adoption, modern deployments and distributions overwhelmingly either
>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
>> no practical benefit today.
> 
> Have you tested this? Every single VM config we have in CI dies with:
> 

Hi Jakub,

I did and I just booted a VM with the series. I just discovered that it 
dies with virtme-ng. Changing the fs_initcall() to device_initcall() 
fixes it so this is likely a race condition.. probably due to loopback?

Sorry about the noise. I do not understand why this didn't happen on my 
libvirt setup but it did happen on virtme-ng.

Well, if there is consensus that we want to go ahead with this, I will 
address this on the V2.

Thanks for letting me know.
Fernando.

> [    0.774671][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000187: 0000 [#1] SMP KASAN
> [    0.775165][    T1] KASAN: null-ptr-deref in range [0x0000000000000c38-0x0000000000000c3f]
> [    0.775165][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc2-virtme #1 PREEMPT(full)
> [    0.775165][    T1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [    0.775165][    T1] RIP: 0010:ipv6_add_dev+0x32/0x1e0
> [    0.775165][    T1] Code: fb 48 83 ec 08 e8 0e 48 a8 ff 85 c0 0f 84 65 01 00 00 48 8d bb 39 0c 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 54 01 00 00
> [    0.775165][    T1] RSP: 0018:ffa0000000017d10 EFLAGS: 00010216
> [    0.775165][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [    0.775165][    T1] RDX: 0000000000000187 RSI: 0000000000000008 RDI: 0000000000000c39
> [    0.775165][    T1] RBP: 0000000000000100 R08: ffffffffa3eed8dc R09: fffffbfff4f10288
> [    0.775165][    T1] R10: fffffbfff4f10289 R11: 0000000000000001 R12: dffffc0000000000
> [    0.775165][    T1] R13: dffffc0000000000 R14: ff11000001f1cc00 R15: ffffffffa8216a90
> [    0.775165][    T1] FS:  0000000000000000(0000) GS:ff1100008707a000(0000) knlGS:0000000000000000
> [    0.775165][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.775165][    T1] CR2: ff11000036a1e000 CR3: 000000003453b001 CR4: 0000000000771ef0
> [    0.775165][    T1] PKRU: 55555554
> [    0.775165][    T1] Call Trace:
> [    0.775165][    T1]  <TASK>
> [    0.775165][    T1]  addrconf_init+0xa9/0x160
> [    0.775165][    T1]  inet6_init+0x287/0x410
> [    0.775165][    T1]  do_one_initcall+0xd7/0x4a0
> [    0.775165][    T1]  ? trace_event_raw_event_initcall_level+0x210/0x210
> [    0.775165][    T1]  ? __kmalloc_noprof+0x2c5/0x730
> [    0.775165][    T1]  kernel_init_freeable+0x57d/0x620
> [    0.775165][    T1]  ? rest_init+0x200/0x200
> [    0.775165][    T1]  kernel_init+0x1e/0x170
> [    0.775165][    T1]  ? _raw_spin_unlock_irq+0x33/0x50
> [    0.775165][    T1]  ret_from_fork+0x472/0x6b0
> [    0.775165][    T1]  ? arch_exit_to_user_mode_prepare.isra.0+0x140/0x140
> [    0.775165][    T1]  ? __switch_to+0x538/0xcf0
> [    0.775165][    T1]  ? rest_init+0x200/0x200
> [    0.775165][    T1]  ret_from_fork_asm+0x11/0x20
> [    0.775165][    T1]  </TASK>
> [    0.775165][    T1] Modules linked in:
> [    0.816998][    T1] ---[ end trace 0000000000000000 ]---
> [    0.818082][    T1] RIP: 0010:ipv6_add_dev+0x32/0x1e0
> [    0.819103][    T1] Code: fb 48 83 ec 08 e8 0e 48 a8 ff 85 c0 0f 84 65 01 00 00 48 8d bb 39 0c 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 54 01 00 00
> [    0.822985][    T1] RSP: 0018:ffa0000000017d10 EFLAGS: 00010216
> [    0.824176][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [    0.825749][    T1] RDX: 0000000000000187 RSI: 0000000000000008 RDI: 0000000000000c39
> [    0.827317][    T1] RBP: 0000000000000100 R08: ffffffffa3eed8dc R09: fffffbfff4f10288
> [    0.828892][    T1] R10: fffffbfff4f10289 R11: 0000000000000001 R12: dffffc0000000000
> [    0.830460][    T1] R13: dffffc0000000000 R14: ff11000001f1cc00 R15: ffffffffa8216a90
> [    0.832037][    T1] FS:  0000000000000000(0000) GS:ff1100008707a000(0000) knlGS:0000000000000000
> [    0.833800][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.835095][    T1] CR2: ff11000036a1e000 CR3: 000000003453b001 CR4: 0000000000771ef0
> [    0.836670][    T1] PKRU: 55555554
> [    0.837358][    T1] Kernel panic - not syncing: Fatal exception
> [    0.838351][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---


