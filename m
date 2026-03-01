Return-Path: <netdev+bounces-262458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOezN6O/pGmPqgUAu9opvQ
	(envelope-from <netdev+bounces-262458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:37:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484241D1E2B
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42503011760
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583331ED83;
	Sun,  1 Mar 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunyoo-cc.20200929.dkim.larksuite.com header.i=@yunyoo-cc.20200929.dkim.larksuite.com header.b="ReklLlYs"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220030EF92
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772404612; cv=none; b=L2LvPh3phaZM3r2cnyOOQYdCu8BqSM+xTz2rUh0jNYDHYIEvkRitdx8Sq9OWKYmxyQDUydwj+vLEGj4Cf3lsjz8gl8+ZwnbUjNJurJ++kmz6KYa7nfrB/tgZovL7oJ2InYEirsnUYPf2pO+iRVAZJc+B5wVKXBc0gn9WH9ggYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772404612; c=relaxed/simple;
	bh=HGNPxjZdXQ0CIKGWXj8Xf/gkL80A5tRaqqvffEvQZ9U=;
	h=Content-Type:Date:Cc:From:Message-Id:To:Subject:Mime-Version; b=n/tv0+95I/pigdUoKHrtvuFM8BIQQ9gWaa7LUfVj2cd4WZycxHU2k5fFjILaKraSrWmoTqJdAhcdKh/8H3sO8l4JLx5l7hc4rH154LQsWblbAq/nr1r7ty6p74tQSWugkYACGwyf8/Ki88VYaUZm0zIDxqEIOXkqpTlZosuxmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunyoo.cc; spf=pass smtp.mailfrom=yunyoo.cc; dkim=pass (2048-bit key) header.d=yunyoo-cc.20200929.dkim.larksuite.com header.i=@yunyoo-cc.20200929.dkim.larksuite.com header.b=ReklLlYs; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunyoo.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunyoo.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=yunyoo-cc.20200929.dkim.larksuite.com; t=1772404600;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HGNPxjZdXQ0CIKGWXj8Xf/gkL80A5tRaqqvffEvQZ9U=;
 b=ReklLlYsZq6N9rHbN+UvjY1WVz0sgfHqhTapusMtOqRGvw98ox/BbZVDww2mDt7wZLYkmq
 HP+9/590d4yIHvdVlVcUKUcQr3LJQ/6zlZkg77HwPfb0lj1dLiZ56XKlUEtbpsJhXagWwd
 fXhOePiHbPuQ/vOg023YLLTjjSuV486OSZehQwQ0i0PvXBRhyeg7yCbfhCYupL0eiFAysA
 Bz0Fnlsp9Mb/95GHj2TNRbUHwS2AscwtRw0d/EwvnBvUgLVFRR5rO11wkWW9t7msuY/GGg
 wfmO9hi0lkDR1uj4PDhUhyVR+qtE1tKV7lL5TUpRcD7Xm/tgQFpt6fB0px5RSQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Mar 2026 22:36:39 +0000
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
From: "ShuangYu" <shuangyu@yunyoo.cc>
X-Lms-Return-Path: <lba+169a4bf77+b50de7+vger.kernel.org+shuangyu@yunyoo.cc>
Message-Id: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
To: "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: [BUG] vhost_net: livelock in handle_rx() when GRO packet exceeds virtqueue capacity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[yunyoo-cc.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[yunyoo.cc];
	TAGGED_FROM(0.00)[bounces-262458-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangyu@yunyoo.cc,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yunyoo-cc.20200929.dkim.larksuite.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 484241D1E2B
X-Rspamd-Action: no action

Hi,

We have hit a severe livelock in vhost_net on 6.18.x. The vhost
kernel thread spins at 100% CPU indefinitely in handle_rx(), and
QEMU becomes unkillable (stuck in D state).
[This is a text/plain messages]

Environment
-----------
=C2=A0 Kernel:=C2=A0 6.18.10-1.el8.elrepo.x86_64
=C2=A0 QEMU: =C2=A0=C2=A0 7.2.19
=C2=A0 Virtio:=C2=A0 VIRTIO_F_IN_ORDER is negotiated
=C2=A0 Backend: vhost (kernel)

Symptoms
--------
=C2=A0 - vhost-<pid> kernel thread at 100% CPU (R state, never yields)
=C2=A0 - QEMU stuck in D state at vhost_dev_flush() after receiving SIGTERM
=C2=A0 - kill -9 has no effect on the QEMU process
=C2=A0 - libvirt management plane deadlocks ("cannot acquire state change l=
ock")

Root Cause
----------
The livelock is triggered when a GRO-merged packet on the host TAP
interface (e.g., ~60KB) exceeds the remaining free capacity of the
guest's RX virtqueue (e.g., ~40KB of available buffers).

The loop in handle_rx() (drivers/vhost/net.c) proceeds as follows:

=C2=A0 1. get_rx_bufs() calls vhost_get_vq_desc_n() to fetch descriptors.
=C2=A0=C2=A0=C2=A0 It advances vq->last_avail_idx and vq->next_avail_head a=
s it
=C2=A0=C2=A0=C2=A0 consumes buffers, but runs out before satisfying datalen=
.

=C2=A0 2. get_rx_bufs() jumps to err: and calls
=C2=A0=C2=A0=C2=A0 vhost_discard_vq_desc(vq, headcount, n), which rolls bac=
k
=C2=A0=C2=A0=C2=A0 vq->last_avail_idx and vq->next_avail_head.

=C2=A0=C2=A0=C2=A0 Critically, vq->avail_idx (the cached copy of the guest'=
s
=C2=A0=C2=A0=C2=A0 avail->idx) is NOT rolled back. This is correct behavior=
 in
=C2=A0=C2=A0=C2=A0 isolation, but creates a persistent mismatch:

=C2=A0=C2=A0 =C2=A0=C2=A0 vq->avail_idx =C2=A0 =C2=A0=C2=A0 =3D 108=C2=A0 (=
cached, unchanged)
=C2=A0=C2=A0 =C2=A0=C2=A0 vq->last_avail_idx =3D 104=C2=A0 (rolled back)

=C2=A0 3. handle_rx() sees headcount =3D=3D 0 and calls vhost_enable_notify=
().
=C2=A0=C2=A0=C2=A0 Inside, vhost_get_avail_idx() finds:

=C2=A0=C2=A0 =C2=A0=C2=A0 vq->avail_idx (108) !=3D vq->last_avail_idx (104)

=C2=A0=C2=A0=C2=A0 It returns 1 (true), indicating "new buffers available."
=C2=A0=C2=A0=C2=A0 But these are the SAME buffers that were just discarded.

=C2=A0 4. handle_rx() hits `continue`, restarting the loop.

=C2=A0 5. In the next iteration, vhost_get_vq_desc_n() checks:

=C2=A0=C2=A0 =C2=A0=C2=A0 if (vq->avail_idx =3D=3D vq->last_avail_idx)

=C2=A0=C2=A0=C2=A0 This is FALSE (108 !=3D 104), so it skips re-reading the=
 guest's
=C2=A0=C2=A0=C2=A0 actual avail->idx and directly fetches the same descript=
ors.

=C2=A0 6. The exact same sequence repeats: fetch -> too small -> discard
=C2=A0=C2=A0=C2=A0 -> rollback -> "new buffers!" -> continue. Indefinitely.

This appears to be a regression introduced by the VIRTIO_F_IN_ORDER
support, which added vhost_get_vq_desc_n() with the cached avail_idx
short-circuit check, and the two-argument vhost_discard_vq_desc()
with next_avail_head rollback. The mismatch between the rollback
scope (last_avail_idx, next_avail_head) and the check scope
(avail_idx vs last_avail_idx) was not present before this change.

bpftrace Evidence
-----------------
During the 100% CPU lockup, we traced:

=C2=A0 @get_rx_ret[0]: =C2=A0 =C2=A0=C2=A0 4468052 =C2=A0 // get_rx_bufs() =
returns 0 every time
=C2=A0 @peek_ret[60366]: =C2=A0=C2=A0 4385533 =C2=A0 // same 60KB packet se=
en every iteration
=C2=A0 @sock_err[recvmsg]: =C2=A0 =C2=A0 =C2=A0=C2=A0 0 =C2=A0 // tun_recvm=
sg() is never reached

vhost_get_vq_desc_n() was observed iterating over the exact same 11
descriptor addresses millions of times per second.

Workaround
----------
Either of the following avoids the livelock:

=C2=A0 - Disable GRO/GSO on the TAP interface:
=C2=A0=C2=A0 =C2=A0 ethtool -K <tap> gro off gso off

=C2=A0 - Switch from kernel vhost to userspace QEMU backend:
=C2=A0=C2=A0 =C2=A0 <driver name=3D'qemu'/> in libvirt XML

Bisect
------
We have not yet completed a full git bisect, but the issue does not
occur on 6.17.x kernels which lack the VIRTIO_F_IN_ORDER vhost
support. We will follow up with a Fixes: tag if we can identify the
exact commit.

Suggested Fix Direction
-----------------------
In handle_rx(), when get_rx_bufs() returns 0 (headcount =3D=3D 0) due to
insufficient buffers (not because the queue is truly empty), the code
should break out of the loop rather than relying on
vhost_enable_notify() to make that determination. For example, when
get_rx_bufs() returns r =3D=3D 0 with datalen still > 0, this indicates a
"packet too large" condition, not a "queue empty" condition, and
should be handled differently.

Thanks,
ShuangYu

