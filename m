Return-Path: <netdev+bounces-305068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1RmNky1S2rVYwEAu9opvQ
	(envelope-from <netdev+bounces-305068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC8711A75
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:01:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="K9MrIY9/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305068-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305068-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67F6D3106397
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C41231F988;
	Mon,  6 Jul 2026 13:45:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537325B0AC
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:45:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345524; cv=pass; b=X37ma0gJMP6PpUaYAizrKYL/UgJWf0r5YczLv1u33f7f9Z2TqfuoR31X6eOfkuIcs3U741JeoT84nd766Sope9bvFLLCl/2a5clUjNtzf+PZO5w8oLpZd9k7V1WqdaNBDP4t7zpJySifnwz+5/tAODGAcHkzvs64oXZZDEJ8SOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345524; c=relaxed/simple;
	bh=k+LUwcYgwzSdPoecmMFD8iUrE3asaMgqhj52EUNSuNc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sF98pMzLeF88FYIalSxdb32NBY8UTY5HWncBkdLzzcOneBBrPXtrJmBie2ZWHNGe+y2Qu4cSwwQeEKJAkkfV1yp/vEZAhs5wsv3570OgZpeiY6C7Nn6Mv4DXgFTKGfcGXj985SooGOyZLM0qXISJEYItpJamosFbRnsYkXJd0gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9MrIY9/; arc=pass smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c12620ed112so412383166b.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783345519; cv=none;
        d=google.com; s=arc-20260327;
        b=QKAzATyRz1jlVTIA3h6HGRE7jg29oUgp2vmNwRBjQDmLF+TCUVsrqn48WvouFINK+g
         CJPyJFzp7F6Pp40f4UgnoV3N3c0BNnwyp1kFJJqltMf3dPIELPqR+qcQXSkO5JID15i+
         3o/1/RHiR+fl7pu7MU1bVsKN15m7KkU2PuNeKUJ9IrF3sjZa0m7U+S3eYT/CPh6UTrdG
         s1YkCr/uUOOajRPG5fv/mdqiuUJDkWGyhmqWte7PnS5/8YKWgwAQuqePrdl7Uj7s49Pp
         ZrlJQUoNLwQCVL74x7eSRHq2YC+rTDBB3w7Gq/68Y63GVKcSGMIzePI4q2hojdx0SJ58
         RcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JaMkP3/Yvn0tE4bv5skgBf8rRsLRrinEUX+P2tXawRA=;
        fh=e7pmY3zjEa2I1zk8N8U5at4A2ZLvlhOpVGbtmkJloBc=;
        b=mKoB/L1wuB7UxZM4LVVJRgpqbu7bp2KAkKUFaPnK3QIsTNK7+bmiUj2xXH7GW/Ia6f
         nBAccne5Gy5FjW50xaDrIs4UgAv5ujX5H5sDhQkQPKKbeL7R7hJe/ebBIESLuY4k0F2j
         aRut4JkdUXbynDE5R6QXInnD+qtKGEKi2jgtYfNni7x3/CLXF61SWkpbaCyBE3n8DdC5
         1Ab+wZ3UFzhMlLDMExB/sm7VCS23JEafXW1pRigSMOJ2pTzma3KD+g2MjO2tz3KQtyVb
         OnP1tYX1F0WuyAD2chKkaQ6imcj1nkFYw/0qwXe6hix/CBO+3z0AqyoyV0ByavKwi+Re
         txjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345519; x=1783950319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JaMkP3/Yvn0tE4bv5skgBf8rRsLRrinEUX+P2tXawRA=;
        b=K9MrIY9/YfNIuAxIksPprbXShRqxHcz1mqaQOZOG+jKQMm1OUekkY4XrUBfK93uqcT
         WC4Q/fOJWhA8nAFJ7VE1Ux2/0jSAnO5lyhQ43kf8zErto8CjjXoCRr32fvpsmNYpradn
         rxz9jIBAKxS8MnuPNcFuEPt8doQ2kLL/XlRr/FTJcqqHYF79ZNN3c3zAmrSsKPOfr3Fo
         KB6wA9IewbuaUm7M+LwczxAIIMroMhYqbsRC8K5//ovBhtgaveaupzIg8snlgO6Do0iO
         NS3f4wu/PcKY4HfqNvCB02gfZQTv7pnr50B/n6L9PgBVG6DX4v8Rf8PpRrqZRDBID9OQ
         HB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345519; x=1783950319;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaMkP3/Yvn0tE4bv5skgBf8rRsLRrinEUX+P2tXawRA=;
        b=mnxHOpDCHIcZaoLs1VF/dQIceUkC4N5sLkDWWU6hF/pm2+MDdKcQUibRyA0DvJXQql
         YSRm8r+RYOkzjP+Qf5DX1pNbmbRL/01IvF1o7l5aI9gEiblo124J270TsJi6JhlqgW7V
         JZ5GfqWJ78dld9bAqtNjxhgKKmnJVSR55zwtNWrPBnCbHBDAmc0lVkpyoGoITGgNQ+er
         SIOZU/pa4sk4Vyz4AIJG9nOZBIICgCUCsqHDqJ4XwK+KHf0H+ZFtpP/Qla2yEOFnTgMS
         Nk8spXUsnRbOC1S3VzyVGyZdX+tw5GznKe/7Py+kc15GJ4/j72qQY/0x/+1OB8fo07O/
         s7JA==
X-Gm-Message-State: AOJu0YyRjU9pLWvOGO1XBWGvbVaklygvrbrIpf39mJfPpayEgCetfWHZ
	KYjpHkRln72gmKbTpoqp9xfPVDFyhIaaGICeLIbKugwNb+jqCMqNdmX9nmXMBofn69Yk62GpMpf
	LxuLJErIH5CMq7b8r4DLJdY6T9J/wFkRaQUEd
X-Gm-Gg: AfdE7cm1C3oV3kAcFppRwgbKKPK7NtrsfiKUhWeFlzNO3q83QVw8yQ6fY4KYkrxk8P2
	wsqHqVPqImgMPSeR+2K5AhuRbPcOWzzf1m8HQ93ev8RoqsC+27m0xMvZAskzFMO1MVPOjjszAxW
	c1ddVAf9fkv/1zjHhy3iIH4c7n3okJVq+1/3LmYAznNCw0kpC+R6xdzrMT0EBS6IhVzVN1ndbQG
	QJm8kUE/9qWLCNXmHEB+10HQpPnedYQABZoaytLB/ZSqlhGJVQbeJzm7FoDpkgeYXi4lHxQFw==
X-Received: by 2002:a17:906:a406:b0:c12:ac7b:97f6 with SMTP id
 a640c23a62f3a-c15a68c5a96mr23478566b.35.1783345518351; Mon, 06 Jul 2026
 06:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Mon, 6 Jul 2026 15:45:06 +0200
X-Gm-Features: AVVi8CfqSooGXdYAr4MfPpW4MuqJciGMKGy5DzlQCpBHXg70jR6jlEagZgEIImE
Message-ID: <CALC2ApggM++j_U2HyuPqo3OArdQrqd+N0ftfUdVSaHhhRcB00A@mail.gmail.com>
Subject: net: airoha: PPE SRAM stale L2 entries survive TC flower destroy on
 station roam
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305068-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:upstream@airoha.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21BC8711A75

Hi,

I spent the last few days debugging a WiFi throughput regression on an
Airoha AN7581 router (Quantum Fiber W1700K, OpenWrt, acting as a dumb AP
with bridger [1] doing TC flower-based L2 hardware offload). The symptom
is that when a WiFi station switches from one radio to another, throughput
drops to ~1 Mbit/s until something nudges the PPE out of its stale state.

I want to share what I found in case it helps identify a driver or firmware
issue, and ask a few questions for the Airoha folks.

The setup: bridger installs skip_sw TC flower filters on bridge member
interfaces to push L2 forwarding into the PPE.  For a station on phy0.2-ap0:

    phy0.2-ap0 ingress: src=STATION dst=GW  ->  redirect lan2
    lan2 ingress:       src=GW dst=STATION  ->  redirect phy0.2-ap0

When the station moves to phy0.1-ap0, bridger tears down the old filters
(RTM_DELTFILTER) and installs new ones (RTM_NEWTFILTER) for phy0.1-ap0.
The kernel and driver both report success. But the PPE keeps sending
downlink traffic to phy0.2-ap0, where the station is no longer associated,
so every frame is dropped. iw dev phy0.1-ap0 station get a few minutes
after the band switch:

    tx retries: 3429
    tx failed:  3435
    rx bitrate: 6.0 MBit/s (link rate degraded by retransmission backoff)

Meanwhile tc filter show lan2 ingress correctly shows redirect to phy0.1-ap0.
The kernel's view of the world is right; the PPE's isn't.

Bridger improvements along the way
==================================

During the investigation I made several improvements to bridger - better
handling of port mismatches, FDB migration ordering, and the DELNEIGH/NEWNEIGH
race during band switch - all in main-bridger-v4 [2]. These helped narrow
down the problem but in the end were not enough to fully resolve the issue on
their own, which is what led us to the PPE SRAM behaviour described below.

Root issue - PPE SRAM consistency
=================================

Even after the bridger fixes, there's a residual window where the PPE SRAM
has the old redirect in place. The sequence from the kernel's side looks
correct:

    RTM_DELTFILTER  ->  flow_offload_destroy()  ->  "flow_table entry
removed OK"
    RTM_NEWTFILTER  ->  flow_offload_add()      ->  success

But the hardware continues forwarding on the old SRAM entry.

While adding debug logging to bridger's nl.c to trace every RTM_DELTFILTER
and its outcome (patch c1a5f49 in the same branch), I observed two things
that suggest the SRAM management is not entirely consistent.

First, RTM_DELTFILTER frequently returns ENOENT even for filters that were
successfully installed earlier:

    flow offload del on ifindex 8 handle 0xf521a056: FAILED kernel error -2

The reason is that the PPE firmware proactively evicts idle flows from SRAM
on its own schedule, notifying the driver via flow_offload_destroy(), which
causes the kernel to remove the TC flower filter before bridger's idle timer
fires. So bridger's delete arrives late, after the filter is already gone.
In isolation this is harmless - ENOENT just means the hardware already did the
cleanup - but it does mean there's a window between the PPE evicting the entry
and bridger learning about it where the state is unclear.

Second, dmesg occasionally shows the same cookie receiving multiple DESTROY
notifications in rapid succession:

    airoha_eth: PPE: TC DESTROY cookie ffffff8017ee1000: flow_table
entry removed OK (TC filter will be deleted)
    airoha_eth: PPE: TC DESTROY cookie ffffff8017ee1000 NOT in
flow_table (already removed or never offloaded)
    airoha_eth: PPE: TC DESTROY cookie ffffff8017ee1000 NOT in
flow_table (already removed or never offloaded)

Same cookie, three notifications within milliseconds. The first removes the
entry cleanly; the next two find nothing. This looks like the NPU firmware
can fire DESTROY more than once for the same SRAM slot, possibly because the
invalidation commit to the hardware is not atomic from the firmware's
perspective.

The practical consequence: when bridger installs a new TC flower for the same
MAC pair on a different port (RTM_NEWTFILTER for phy0.1-ap0 after
RTM_DELTFILTER for phy0.2-ap0), there is apparently a window where the old
SRAM entry is not yet fully invalidated. If the new flow_offload_add() runs
into that window, the new SRAM entry either doesn't land or coexists with the
old one in a way that lets the hardware continue using the old redirect.

Workaround
==========

I tried a kernel-side workaround [3]: register a switchdev notifier for
SWITCHDEV_FDB_ADD_TO_DEVICE / SWITCHDEV_FDB_DEL_TO_DEVICE and, on each
event, walk the driver's flow_table and l2_flows and flush all PPE entries
matching the affected MAC.

Two things that flush handles:

  - Removing the flow_table entry makes airoha_ppe_flow_offload_destroy()
    return -ENOENT on RTM_DELTFILTER, which causes the TC layer to remove
    the software filter state cleanly.

  - Removing the l2_flows entry prevents airoha_ppe_foe_insert_entry() from
    re-learning the stale redirect direction after the BIND entry ages out.
    Without this, even after the SRAM entry expires, the old l2_flows parent
    is still around and the PPE re-establishes hardware offload in the wrong
    direction the next time traffic flows.

This fixed the symptom completely. I held off upstreaming it because it
felt like compensating for something the driver or firmware should handle
correctly - if RTM_DELTFILTER reliably invalidated the SRAM entry and
l2_flows were tied to the lifetime of the station's bridge port association,
the switchdev flush wouldn't be needed.

Questions for Airoha
====================

Is the NPU firmware's SRAM invalidation atomic? When flow_offload_destroy()
returns, can the driver guarantee the hardware has stopped using that entry,
or is there a commit pipeline that takes additional time?

Is it expected that the firmware can send multiple DESTROY notifications for
the same slot? The double-NOT-in-flow_table pattern in dmesg suggests so.

When flow_offload_add() is called for a MAC pair that may still have a
partially-invalidated SRAM entry from a previous flow, does the NPU guarantee
the new entry takes precedence immediately? Or is there a recommended
sequence (e.g. explicit invalidate, barrier, then add)?

Is there a flush or barrier call in the NPU firmware interface that the driver
could expose, so a switchdev handler or similar could ensure SRAM consistency
without needing to walk the entire flow_table?

Happy to run more tests, capture more dmesg, or share the full debug log
from bridger if it would help.

Regards,
Dan


Some info:
Kernel: 6.18.37, arm64
Platform: Airoha AN7581 (tested on Quantum Fiber W1700K)

[1] https://github.com/nbd168/bridger
[2] https://github.com/danpawlik/bridger/commits/main-bridger-v4
[3] Local branch -
https://github.com/danpawlik/openwrt/tree/airoha-npu-kernel-mailinglist
    commit: https://github.com/openwrt/openwrt/commit/7373faf11f4ad14a3cb16f33e51fbc4dccc85ca4

