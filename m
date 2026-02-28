Return-Path: <netdev+bounces-262019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAKlEno2omnR0wQAu9opvQ
	(envelope-from <netdev+bounces-262019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B31BF6B0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0953D308D3EB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1821FFC59;
	Sat, 28 Feb 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GALhNOVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD686323
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238453; cv=none; b=uvPssVOkfoxZUyo8syRi8CTv4jCg4SDA01BhX64HTK5J+idXihamCNn+vVwHKdJQY3ALlutTC7a1GpFlGxKWnQX6+wJ3eeVD7BlHgZrEfmejpIfHqhjH5MsgUbfd0ozU4uqT2tFJqvSw2VlTOarV+6cFVab8EvKx8qRJEcdE0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238453; c=relaxed/simple;
	bh=EJLNUZUd1RjIbNDJzrY9X1s0R5Jtn3KoNca39h1mVPc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cj5HjQZ4fpUMsHoZ8viJsdypWd/r3NozzU8XvIZWQ57FVdYkOI0U3TwmlhxhoHVyTVGTHvehxIbyxE9KDyYG2W9xWKhqe7JNu59DKPkfW9Pzosxf21WK+nkeP7nMHPe96QYP8l4qYeemH4gPs4zcsmNOl0kfmkfB42rRCJSnkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GALhNOVC; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1772238441; x=1772497641;
	bh=nM8WD4CMP39EXn9VOjHOEAAawS4J+Pk+3g1qQAnK1ls=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GALhNOVCVzvPUi6VJjTY2W/OiTOHLWiTZIYdrIYIylQBnVvrUtF15j1TuJOqamIit
	 PfpVlUt2D1/c39g6TBiEpTZlxrx6G8+ARP7sz5UR5oNfqhrI+WzSZhYmX8PYhS5ceu
	 1XjUa313DCmDout8iLwns7cA6qJGY1PSoxDzu5uyomjAsuIRXfPjAQTm6KjJak59y7
	 gZ90l37gFaCGeZGED0csG+gReabJyZ3lvYoUZV9DTX33iqlKCTROCKoyrjBbNgcoSc
	 KxgZPQMK6VLyRh7zEBk3qjESNyKGmzGK3jQrUiEtRVnho98Pu/0g7zcahM9Li6hFay
	 w2pGlQZ6jPrhw==
Date: Sat, 28 Feb 2026 00:27:18 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Melissa Romanus <melissa.romanus@proton.me>
Cc: "mromanus@lbl.gov" <mromanus@lbl.gov>
Subject: ixgbe/X550: kernel NULL pointer dereference following Malicious event on VF after upgrade to 6.17.7
Message-ID: <bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me>
Feedback-ID: 184535756:user:proton
X-Pm-Message-ID: 31119ba8438a56112291d4cf3218419eb5b45a2f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-262019-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[proton.me:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[melissa.romanus@proton.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 838B31BF6B0
X-Rspamd-Action: no action

Hi netdev,

After a recent Fedora CoreOS upgrade at the beginning of February, we are e=
xperiencing several kernel crashes on multiple nodes of the same style hard=
ware, which are pointing to an issue with the ixgbe driver.

The affected nodes reboot following a kernel NULL pointer dereference immed=
iately after an ixgbe "Malicious event on VF" message.

Feb 27 21:34:34 d8-r11-c8-n3 kernel: ixgbe 0000:21:00.0: Malicious event on=
 VF 3 tx:80000 rx:0
Feb 27 21:34:34 d8-r11-c8-n3 kernel: BUG: kernel NULL pointer dereference, =
address: 0000000000000304

Different node in another chassis (identical hardware):

Feb 13 10:42:49 d8-r11-c9-n2 kernel: ixgbe 0000:21:00.0: Malicious event on=
 VF 12 tx:80000 rx:0
Feb 13 10:42:49 d8-r11-c9-n2 kernel: BUG: kernel NULL pointer dereference, =
address: 0000000000000b2c

This has occurred on at least five separate nodes since our FCOS upgrade ma=
intenance on February 3. After reboot, nodes return to normal operation unt=
il the next occurrence. Currently for each of these systems, the journal al=
ways truncates after the BUG line. I will increase the panic delay and capt=
ure settings and update if we happen to catch a more meaningful trace befor=
e the reboot triggers.

Here's some relevant info pertaining to our environment:

- Linux kernel: 6.17.7-300.fc43.x86_64
- OS: Fedora CoreOS 43.20251110.3.1

Hardware Info:

- Gigabyte MZ62-HD0 nodes (H262-Z62 chassis) -- happening across multiple n=
odes in multiple chassis in the stack (i.e., not isolated to a single chass=
is)
- CPU is AMD EPYC 7302
- The NIC causing issues is: Intel X550 (rev 01) dual-port 10GBASE-T
-- Bonded interfaces (802.3ad) to redundant leaf switches

Driver/mod Info:

- driver: ixgbe
- version: 6.17.7-300.fc43.x86_64
- firmware-version: 0x80000c67, 1.1276.0

From the modinfo:
- filename:       /lib/modules/6.17.7-300.fc43.x86_64/kernel/drivers/net/et=
hernet/intel/ixgbe/ixgbe.ko.xz
- description:    Intel(R) 10 Gigabit PCI Express Network Driver
- rhelversion:    10.99

The SR-IOV capability is present on the X550 adapter, however no VFs are co=
nfigured:

/sys/class/net/enp33s0f0/device/sriov_numvfs =3D 0

/sys/module/ixgbe/parameters/ has only allow_unsupported_sfp =3D N

Also, no VF PCI devices appear in lspci output.

In checking the priv flags, I noticed there's one for mdd-disable-vf. I can=
 try to set mdd-disable-vf to on after sending to see if that helps as a po=
tential mitigation, but the nondeterministic nature of this issue means it =
will take some time for us to know whether this change restores stability:

Private flags for enp33s0f0:
- legacy-rx     : off
- vf-ipsec      : off
- mdd-disable-vf: off

I'm wondering if this is a known issue in recent kernels affecting ixgbe/X5=
50 devices when MDD events are triggered without SR-IOV VFs configured? I c=
ould not find anything recent in my searches, so I thought I would reach ou=
t to report the behavior and see if there's anything I might be missing.

Thanks for your time,

Melissa Romanus
Lawrence Berkeley National Lab

