Return-Path: <netdev+bounces-254507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LUmKua5emkr9gEAu9opvQ
	(envelope-from <netdev+bounces-254507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:37:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FBFAAD36
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA29C300A39D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94FE1A5B8A;
	Thu, 29 Jan 2026 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXNQnXuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9B38D;
	Thu, 29 Jan 2026 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650659; cv=none; b=qBnubqx7i1osmiLRvQhXrR8cf1VYlT6EO8iKur0JywNwrVTL9djnUomvXJPO01UXot+/r/rGM5NcJutXsVGFMoEsTgTKU3Yah5gXNqWI7VXX+I728qfsZAf1RzPPaOyip4V7P8vmJ8njm5pXl0ja+ewFyU4YS3v3ZebYCz2XGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650659; c=relaxed/simple;
	bh=UpefWZnsINPXuje56adpAAgvFDVZXVdOcJunh4vFuDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLPBhHh7EzC2XeT0W4QmiE/sko1BkD2eJqTI3tG0vDpyEc5dNf2Cz7wdBr8xl0gZkq7Fz7oApjJt+9HFFaFf0ox8xQ/gjWvC6cXYLVFOoV5CqVrAbwPNyqZbmx8Tot7sj5rE8DzLknuuSaNzeoYc1fxfXLsuQQn/lWqqiDyDuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXNQnXuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0AAC4CEF1;
	Thu, 29 Jan 2026 01:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769650659;
	bh=UpefWZnsINPXuje56adpAAgvFDVZXVdOcJunh4vFuDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kXNQnXucGx6WZDfTkLtX+vh7nvqAyG993qtHQAu4i4OY9iovNXjm5Y/CUR/Pec5PQ
	 vcQwBNiO0jHQqWLX1aXnS+aw6fOWPkNnBHtpy2LaBTZvzXE2l8Y3DLTSj1jQbCSFCD
	 GSuhizGny5tfyZDArLzjAtsw91xJZ1C50zQCuLhZsV2yY1toVRBjuGoU0n0cXsK9SR
	 TnGs4jIC0Fgnc6YQt5c1x+ylaPkINDv+Q844jt/O57AQ1k1I42vvSWTcVByp5DmlgH
	 dzsKJyruIlRUwC5xB+AebocQbB/JD55ey9SCWEcKBQ/0Cub0pLPQtLWdWLHXyhCF93
	 rVqtra0u8k6qg==
Date: Wed, 28 Jan 2026 17:37:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Wei
 <dw@davidwei.uk>, <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/2] virtio_net: add page_pool support
Message-ID: <20260128173737.04277eeb@kernel.org>
In-Reply-To: <20260128212031.1431746-1-vishs@meta.com>
References: <20260128212031.1431746-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 09FBFAAD36
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 13:20:29 -0800 Vishwanath Seshagiri wrote:
> Introduce page_pool support in virtio_net driver to enable page recycling
> in RX buffer allocation and avoid repeated page allocator calls. This
> applies to mergeable and small buffer modes.
> 
> Beyond performance improvements, this patch is a prerequisite for enabling
> memory provider-based zero-copy features in virtio_net, specifically devmem
> TCP and io_uring ZCRX, which require drivers to use page_pool for buffer
> management.

Struggles to boot in the CI:

[   11.424197][    C0] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
[   11.424454][    C0] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   11.424606][    C0] CPU: 0 UID: 0 PID: 271 Comm: ip Not tainted 6.19.0-rc6-virtme #1 PREEMPT(full) 
[   11.424784][    C0] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   11.424913][    C0] RIP: 0010:page_pool_alloc_frag_netmem+0x34/0x8e0
[   11.425054][    C0] Code: b8 00 00 00 00 00 fc ff df 41 57 41 89 c8 41 56 41 55 41 89 d5 48 89 fa 41 54 48 c1 ea 03 49 89 f4 55 53 48 89 fb 48 83 ec 30 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 32 05 00 00 8b 0b 83 f9 3f 0f
[   11.425413][    C0] RSP: 0018:ffa0000000007a00 EFLAGS: 00010286
[   11.425544][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000820
[   11.425697][    C0] RDX: 0000000000000000 RSI: ffa0000000007ac0 RDI: 0000000000000000
[   11.425846][    C0] RBP: 1ff4000000000f54 R08: 0000000000000820 R09: fff3fc0000000f8f
[   11.426000][    C0] R10: fff3fc0000000f90 R11: 0000000000000001 R12: ffa0000000007ac0
[   11.426156][    C0] R13: 0000000000000600 R14: ff11000008719d00 R15: ff1100000926de00
[   11.426308][    C0] FS:  00007f4db5334400(0000) GS:ff110000786fe000(0000) knlGS:0000000000000000
[   11.426487][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.426617][    C0] CR2: 00000000004e5e60 CR3: 000000000b9da001 CR4: 0000000000771ef0
[   11.426768][    C0] PKRU: 55555554
[   11.426846][    C0] Call Trace:
[   11.426927][    C0]  <IRQ>
[   11.426981][    C0]  ? alloc_chain_hlocks+0x1e5/0x5c0
[   11.427085][    C0]  ? buf_to_xdp.isra.0+0x2f0/0x2f0
[   11.427190][    C0]  page_pool_alloc_frag+0xe/0x20
[   11.427289][    C0]  add_recvbuf_mergeable+0x1e0/0x940
[   11.427392][    C0]  ? page_to_skb+0x760/0x760
[   11.427497][    C0]  ? lock_acquire.part.0+0xbc/0x260
[   11.427597][    C0]  ? find_held_lock+0x2b/0x80
[   11.427696][    C0]  try_fill_recv+0x180/0x240
[   11.427794][    C0]  virtnet_poll+0xc79/0x1450
[   11.427901][    C0]  ? receive_buf+0x690/0x690
[   11.428005][    C0]  ? virtnet_xdp_handler+0x900/0x900
[   11.428109][    C0]  ? do_raw_spin_unlock+0x59/0x250
[   11.428208][    C0]  ? rcu_is_watching+0x15/0xd0
[   11.428310][    C0]  __napi_poll.constprop.0+0x97/0x390
[   11.428415][    C0]  net_rx_action+0x4f6/0xed0
[   11.428517][    C0]  ? run_backlog_napi+0x90/0x90
[   11.428617][    C0]  ? sched_balance_domains+0x270/0xd40
[   11.428721][    C0]  ? lockdep_hardirqs_on_prepare.part.0+0x9a/0x160
[   11.428844][    C0]  ? lockdep_hardirqs_on+0x84/0x130
[   11.428949][    C0]  ? sched_balance_update_blocked_averages+0x137/0x1a0
[   11.429073][    C0]  ? mark_held_locks+0x40/0x70
[   11.429172][    C0]  handle_softirqs+0x1d7/0x840
[   11.429271][    C0]  ? _local_bh_enable+0xd0/0xd0
[   11.429371][    C0]  ? __flush_smp_call_function_queue+0x449/0x6d0
[   11.429497][    C0]  ? rcu_is_watching+0x15/0xd0
[   11.429597][    C0]  do_softirq+0xa9/0xe0

https://netdev-ctrl.bots.linux.dev/logs/vmksft/virtio/results/494081/1-basic-features-sh/stderr
-- 
pw-bot: cr

