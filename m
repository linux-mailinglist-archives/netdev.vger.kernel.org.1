Return-Path: <netdev+bounces-255646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kANzNRR+f2khsAIAu9opvQ
	(envelope-from <netdev+bounces-255646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:23:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A834C679E
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9C383004C6A
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A62265629;
	Sun,  1 Feb 2026 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pe0dJo3f"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4A261B8F;
	Sun,  1 Feb 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769963025; cv=none; b=MvD8javF5OxbMPtKLvhSNzTgpFnqzAnKRn+YPlME3UzbxJXHqUPw3BgcXfYH71RjDCdw3kd0EbtT3gVJ2v3T5IBKMPchXg/VWPhyJRqeSdA5Sv8GNPRT+SOYmU0yD6Ju7DcExPN1FzCm/3IhaEUvuigTcB+dmBtharo9M+hv+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769963025; c=relaxed/simple;
	bh=8Lgp/LuJGrbVcthaVAZkdgVt5sGv5K0RUp7GfkqM8ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqzwOHwFkd9mXih9jnxGYyXixLdRKE1LcuPjIqV4kjeabZ+zjdr0u3Z5ueAcLrx4AzJEg3MbqtWWHDIiLbtTMXo31Mz1QELAMm0ubpVo+6LVtYesb1GEzJA2+n9X3QEncTPdnyapBhtFJd1UmUGxxyK0RZjBz7kd35HXHs9ypfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pe0dJo3f; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sptY+Vec9i6BrPBhci8RbFua9miGnc4R4xyvrvF5GdM=; b=pe0dJo3fMl4t0zWsHJr7fzy+2H
	PucZBaMJTJAMBz7WJ7wdXuV2JugecBc5oEFdCNbcJ5+A2XbWun4cWKNfo8GKpAJAyEDbgLX2QIGN2
	GRJyYB2H7QrO+Wye+n5SeIyanEcAJUsjn2U2tuwvT2i8p1wQIibqH6VAN1mkyceWD7xXO8cIEfF7Z
	0uHaBsGrHc6nWYri/9h0jhmtAEKmatsDQ2hqj6Tuff/9SYAPvwoUb9qcLZ2yH7wuZZjc1apVz6kwk
	nnulVR/84NHlFNmWukI6kB+OgneohJXN308kWKIYwlhY+HCbAPUcL7CjbdmIIOiTHc7AFX7L0xEcz
	ox3vQgyQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vmaEI-003Oqv-64; Sun, 01 Feb 2026 16:23:18 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 28902BE2EE7; Sun, 01 Feb 2026 17:23:17 +0100 (CET)
Date: Sun, 1 Feb 2026 17:23:17 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jon Penn <jpenn@bentonvillek12.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: 1126499@bugs.debian.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
Message-ID: <176996279620.3109699.15382994681575380467@eldamar.lan>
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
X-Debian-User: carnil
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A834C679E
X-Rspamd-Action: no action

Control: forwarded -1 https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan

Hi Antonio and all,

In Debian we got the following report from Jon Penn using ovpn,
reported at https://bugs.debian.org/1126499

On Tue, Jan 27, 2026 at 10:37:40AM -0600, Jon Penn wrote:
> Package: src:linux
> Version: 6.17.13-1
> Severity: normal
> 
> Dear Maintainer,
> 
> This is an OpenVPN server serving primarially TCP clients (but also some UDP
> clients). As I write this there are 1161 TCP clients and 74 UDP clients. It
> is running debian testing in order to have ovpn-dco-offload functionality
> for TCP connections. We observe that under hevy load (in terms of
> connections count, not really under much load in terms of bandwidth) this
> server will become locked up from time to time and the graphical console
> will become completely non-responsive. When this happens we reset the VM and
> things continue running normally. I attempted to monitor the system using
> dmesg and notice that I am getting some interesting messages about "BUG:
> kernel NULL pointer dereference" that mention the ovpn module, leading me to
> believe that this is a kernel bug in that module. Unfortunatly this issue
> only occours when the server has many connections, and that is only
> happening because most of my users are working from home today due to
> weather. This gives me a rather small window of reproducability but if there
> is any additional information I can provide let me know.
> -- Package-specific info:
> ** Version:
> Linux version 6.17.13+deb14-amd64 (debian-kernel@lists.debian.org)
> (x86_64-linux-gnu-gcc-15 (Debian 15.2.0-12) 15.2.0, GNU ld (GNU Binutils for
> Debian) 2.45.50.20251209) #1 SMP PREEMPT_DYNAMIC Debian 6.17.13-1
> (2025-12-20)
> 
> ** Command line:
> BOOT_IMAGE=/boot/vmlinuz-6.17.13+deb14-amd64
> root=UUID=f00f1200-b8d8-4432-bb0b-593a5ab9075a ro quiet
> 
> ** Tainted: D (128)
> * kernel died recently, i.e. there was an OOPS or BUG
> 
> ** Kernel log:
> [ 709.018150] tun1: deleting peer with id 719, reason 1
> [ 709.056997] tun1: deleting peer with id 1055, reason 1
> [ 711.054524] tun1: deleting peer with id 201, reason 2
> [ 711.055070] BUG: kernel NULL pointer dereference, address:
> 0000000000000020
> [ 711.055096] #PF: supervisor write access in kernel mode
> [ 711.055429] #PF: error_code(0x0002) - not-present page
> [ 711.055656] PGD 0 P4D 0
> [ 711.055824] Oops: Oops: 0002 [#1] SMP NOPTI
> [ 711.055991] CPU: 12 UID: 0 PID: 527 Comm: kworker/12:2 Not tainted
> 6.17.13+deb14-amd64 #1 PREEMPT(lazy) Debian 6.17.13-1
> [ 711.056154] Hardware name: Red Hat KVM, BIOS
> edk2-20221207gitfff6d81270b5-9.el9_2 12/07/2022
> [ 711.056333] Workqueue: events ovpn_peer_keepalive_work [ovpn]
> [ 711.056524] RIP: 0010:ovpn_tcp_socket_detach+0x61/0x80 [ovpn]
> [ 711.056695] Code: 01 00 00 48 8b 83 b8 01 00 00 48 89 85 c0 02 00 00 48 8b
> 83 c0 01 00 00 48 89 45 28 48 8b 85 20 01 00 00 48 8b 93 c8 01 00 00 <48> 89
> 50 20 48 c7 85 98 02 00 00 00 00 00 00 5b 5d c3 cc cc cc cc
> [ 711.056986] RSP: 0018:ffffd3988153fdb8 EFLAGS: 00010246
> [ 711.057136] RAX: 0000000000000000 RBX: ffff8e65873a5400 RCX:
> 0000000000000004
> [ 711.057314] RDX: ffffffff92d6d660 RSI: 0000000000000068 RDI:
> ffff8e65873a5568
> [ 711.057475] RBP: ffff8e6590fb4280 R08: 0000000000000000 R09:
> 0000000000000101
> [ 711.057644] R10: 0000000000000000 R11: ffffffff93a080e0 R12:
> 000000006978de32
> [ 711.057794] R13: 0000000000000001 R14: ffff8e65839c1aa8 R15:
> 0000000000000000
> [ 711.057940] FS: 0000000000000000(0000) GS:ffff8e695b708000(0000)
> knlGS:0000000000000000
> [ 711.058087] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 711.058246] CR2: 0000000000000020 CR3: 000000010862d001 CR4:
> 00000000007726f0
> [ 711.058412] PKRU: 55555554
> [ 711.058584] Call Trace:
> [ 711.058739] <TASK>
> [ 711.058892] ovpn_socket_release+0x165/0x1a0 [ovpn]
> [ 711.059048] unlock_ovpn+0x48/0x80 [ovpn]
> [ 711.059199] ovpn_peer_keepalive_work+0xf3/0x1b0 [ovpn]
> [ 711.059360] ? __schedule+0x464/0xd20
> [ 711.059557] process_one_work+0x18f/0x350
> [ 711.059740] worker_thread+0x25a/0x3a0
> [ 711.059889] ? __pfx_worker_thread+0x10/0x10
> [ 711.060046] kthread+0xfc/0x240
> [ 711.060203] ? __pfx_kthread+0x10/0x10
> [ 711.060358] ? __pfx_kthread+0x10/0x10
> [ 711.060559] ret_from_fork+0x194/0x1c0
> [ 711.060801] ? __pfx_kthread+0x10/0x10
> [ 711.061019] ret_from_fork_asm+0x1a/0x30
> [ 711.061269] </TASK>
> [ 711.061494] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common isst_if_mbox_msr isst_if_common ovpn
> ip6_udp_tunnel udp_tunnel skx_edac_common nfit libnvdimm kvm_intel kvm
> binfmt_misc irqbypass ghash_clmulni_intel aesni_intel rapl nls_ascii
> nls_cp437 vfat fat qxl drm_ttm_helper ttm drm_exec pcspkr drm_client_lib sg
> drm_kms_helper button evdev joydev drm configfs efi_pstore nfnetlink
> vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport
> vsock vmw_vmci efivarfs qemu_fw_cfg autofs4 ext4 crc16 mbcache jbd2
> crc32c_cryptoapi hid_generic usbhid hid sr_mod sd_mod cdrom ahci libahci
> xhci_pci libata xhci_hcd iTCO_wdt intel_pmc_bxt iTCO_vendor_support watchdog
> psmouse usbcore scsi_mod e1000 serio_raw i2c_i801 lpc_ich scsi_common
> usb_common i2c_smbus
> [ 711.062827] CR2: 0000000000000020
> [ 711.063051] ---[ end trace 0000000000000000 ]---
> [ 711.600092] RIP: 0010:ovpn_tcp_socket_detach+0x61/0x80 [ovpn]
> [ 711.602044] Code: 01 00 00 48 8b 83 b8 01 00 00 48 89 85 c0 02 00 00 48 8b
> 83 c0 01 00 00 48 89 45 28 48 8b 85 20 01 00 00 48 8b 93 c8 01 00 00 <48> 89
> 50 20 48 c7 85 98 02 00 00 00 00 00 00 5b 5d c3 cc cc cc cc
> [ 711.602680] RSP: 0018:ffffd3988153fdb8 EFLAGS: 00010246
> [ 711.602951] RAX: 0000000000000000 RBX: ffff8e65873a5400 RCX:
> 0000000000000004
> [ 711.603218] RDX: ffffffff92d6d660 RSI: 0000000000000068 RDI:
> ffff8e65873a5568
> [ 711.603487] RBP: ffff8e6590fb4280 R08: 0000000000000000 R09:
> 0000000000000101
> [ 711.603739] R10: 0000000000000000 R11: ffffffff93a080e0 R12:
> 000000006978de32
> [ 711.603990] R13: 0000000000000001 R14: ffff8e65839c1aa8 R15:
> 0000000000000000
> [ 711.604231] FS: 0000000000000000(0000) GS:ffff8e695b708000(0000)
> knlGS:0000000000000000
> [ 711.604483] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 711.604723] CR2: 0000000000000020 CR3: 000000019ce2c006 CR4:
> 00000000007726f0
> [ 711.604958] PKRU: 55555554
> [ 711.605202] note: kworker/12:2[527] exited with irqs disabled
> [ 711.967459] tun1: deleting peer with id 201, reason 1
> [ 718.617453] tun1: deleting peer with id 1057, reason 1
> [ 719.779198] tun1: deleting peer with id 176, reason 1
> [ 733.398723] tun1: deleting peer with id 1059, reason 1
> [ 733.926421] tun1: deleting peer with id 154, reason 1

Is there anything Jon can do providing more information help
indentifying the problem?

FWIW, I have not asked Jon yet to test mainline or 6.18.8-1 (but
afaics there were no relevant changes since to drivers/net/ovpn/).
John in Debian you should soon available 6.18.8-1 and please do test
as well 6.19~rc6-1~exp1 from experimental (or 6.19~rc7-1~exp1 once it
passes).

Regards,
Salvatore

