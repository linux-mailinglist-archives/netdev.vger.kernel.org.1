Return-Path: <netdev+bounces-275958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K3zNFPr1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC43ADBD4
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09BCB3010DB5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9043738F24C;
	Tue,  7 Apr 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKXrgIo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AB38A737
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561546; cv=pass; b=D0kYJHV3oemlVFw1lZnCfqx+fKfYz3w830yHHs788rJf2FguA30Jm44EMuKg6vk6K5AM4Cd+pCOudhwkOnvgmBbHEqGK/7BvzLxoqphp/z1S6o5SP0aCapQ5ZOlcRhvZ8LBYelbEJH30uXlZPl0B167ZVE/pP9dBHS049NvtSKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561546; c=relaxed/simple;
	bh=o2qVAUVDT77vA236MxBSXYZk0KJsWKnLHWf7RENIqmI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cGEB9u3Yyyol5R8ZzUowegIwygglTLLrcDZlYQ6Xny0dBRqtmPY7HFh9krugqw2RvPsIcRbRyEsnkJ7uJmjatg/dyQhpwB2tPCEQgLnUzB3a14qgEhF4/dKcBg1eBFHHRMbvo1M3zvw7q/0zAfF7WmyHsZSGGG5ohOsJqYtoN2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKXrgIo0; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so9135444a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775561543; cv=none;
        d=google.com; s=arc-20240605;
        b=IaKOeop3ZRXd8XmdwlXUVgt7dQN9A61OyWmxEVAytzHx+ds1MBgiehw0Rx69+KtSIz
         wnu9PruEpsAVaLMrom03ZVPkDaD0R3q7Q9E2w6ia1dhoQ92YnrgkQJd5sm924sNZwMQo
         RwNj6xnvZAcO6MMpntfBt7buMgPL6XFQiQLI3aDrbXNv5dUGeouM6OP24fJNPQr6ji2D
         uuOyd8bd9qWgn8PdvJq6DxQ/GEMFQgq8HAwFcRgIhpOHfH+QzVmSUPBiCxneJHMX+sRr
         SdgpzmaFU35C4GtUnCLRzb1pKxyOmfO7kOWkcSZBrtyRTHZ2LV2hOy78Ib7U/aTaeUES
         bayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LAHbLk6yRhiF9a1SYl2iO6IUxWN8zhInOQnF6bw9i6s=;
        fh=QkNrtRv5/Vc77yyxhuleYI41X+Qst3W2s9JrOsrJxuA=;
        b=C7zprFFOtNIhkXgty/IIh7RZrQdUHDOwz0zeNfQwFxxPRWMuBUS5LhLrLIAHJZxLLg
         UAQhLOnY1mJ7wynEd06UGr+uM/CDN1P+qqfQVk6+FU8F/7kNvkPtet4+XJsfAh4myIUa
         /XKnO42oMMdE4T50PrTZlyoqpiG8+mOSQmfPtzT5O4KPksCL+zNFUdAg7Bf3xe0NBj9W
         6kNO1hElbL39gUWUfa0SrdSE09UUbgulaUykm+JtB1tAvuL2NtJXsvZcl9IDN3wRErF4
         /gcSbGvgy9c72swNhUp0Yal/mOMIpctxDoZS6uLtg6RxjCxAs/QsRFz7M2AXOAuYUryr
         WYFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775561543; x=1776166343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAHbLk6yRhiF9a1SYl2iO6IUxWN8zhInOQnF6bw9i6s=;
        b=bKXrgIo0MfYu01wjEXrr2amwOg8Dt/vu8QHrWtXkL4aYYDhsJc0pBQAAcaJvFaJO6q
         U68SiTQCD4KlcPostJzdt9sL0ghYcqrGeo0yhfp2F+bF7F8Qdw9k1VqwXHcYAHKDmP6g
         Glz1kp3g4yQM5uto4FJIW/EB/AB6cXxJ62KEJn3eII/i5RfhNFsJ+1yXZVu/3ycf0q4D
         UeX8reXJ+XsUlkbun0Z7bx7uNysePU2K8ZDflo5pC9WbA9OUxdkV8V5Rz9LaVLUZo/h8
         cAU7tiNAdD1Cbi0t6DO4YlqfVI9XwbYEHe1pz68J53rVRGRKzck8P4Rd+AKFxzcYoY0m
         E1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561543; x=1776166343;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAHbLk6yRhiF9a1SYl2iO6IUxWN8zhInOQnF6bw9i6s=;
        b=ZYME3ic/Ghk1vGugY6xj1kbS+CbeZZlFgNZ+gFHBKZgVLsiJTsc95D5bWAO0y+rwR5
         0jI3HVwsR4Ui+wpy1eZdI8vsAaDae8vfeqblnJ1+jAY9v68Mze5sF5vVgms0uLN5KLsS
         V7HGMpM0PZgBBSBlNo3S4pqO7ck8/is8rgBE3wZxYziZQVrjbCcgHutuawNC/jFh11yf
         E4CjhHVSxEPZMSdScsBwa3C6t1MQ0HN1ywnzOZ2HI+B9zRC5gm4tTpAqV9WyDVS1GWVs
         OCUQx1IyrMsvwtNJI4Elr387wA2WuwlQ4jF4VII1eaLTb8ob1db5Hkq0k5XFwbZwN3aR
         5i/Q==
X-Gm-Message-State: AOJu0YzoivPnrGJx9AJIMXb+24mofqqeA+/6a++48BFhJ0sSJP7sAsB9
	HSx0C2jgbMhCP6m3ma/c0GacVwwLnS44FHKVANV+7C85RCUruwtPRYSixyFq0fIxxhBB7IviQYx
	bTZLDjqtr3hC6cUEuHK3ehsSGDb/DWVisVHf6GWp9ow==
X-Gm-Gg: AeBDietXLZUrZkCTk4rKqWD1kPEK96mFhJe/x23kmBld4/mXpldtFvUlPur3irQDnR2
	f40pFiSJDVRdcGLHaUj249kaDbMqvuwi1V/84HJKOp4rUmvGcRfmNS7R6DM0cTlqor6i1XHCyL/
	lfeF9GgcMvqofRubOEkipAOe8f/24+BUQmI5CIsp1yzMPlzfK8qHf2whp0Y/oM9Ya/4Uqted2wa
	IxV9uOkNiwVLCMCkwLoVhBufc2rTBf2Ja7LUFn4ik7kX1DDwTudipEZAmn/BlSf92df4p0PhgxO
	ujrK5Uk+6uH7DXLnCjHcK8w7YjOrS94+9HIgToA5f3TV72ursBpJELTF7uLfmhlQkxJG0BCJdA=
	=
X-Received: by 2002:a05:6402:24c6:b0:66e:f7de:286f with SMTP id
 4fb4d7f45d1cf-66ef7de37efmr2433528a12.27.1775561541777; Tue, 07 Apr 2026
 04:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Tue, 7 Apr 2026 14:31:54 +0300
X-Gm-Features: AQROBzBP0-y_9tAX2Q43AtyXaqVCGXV8pBGKqr2yGy_nDD1svpdKJPoDhokJTIs
Message-ID: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
Subject: [PATCH net] net: rtnetlink: zero ifla_vf_broadcast to avoid stack
 infoleak in rtnl_fill_vfinfo
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275958-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37CC43ADBD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
without initialisation:

    struct ifla_vf_broadcast vf_broadcast;

The struct contains a single fixed 32-byte field:

    /* include/uapi/linux/if_link.h */
    struct ifla_vf_broadcast {
            __u8 broadcast[32];
    };

The function then copies dev->broadcast into it using dev->addr_len
as the length:

    memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);

On Ethernet devices (the overwhelming majority of SR-IOV NICs)
dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
written. The remaining 26 bytes retain whatever was previously on
the kernel stack. The full struct is then handed to userspace via:

    nla_put(skb, IFLA_VF_BROADCAST,
            sizeof(vf_broadcast), &vf_broadcast)

leaking up to 26 bytes of uninitialised kernel stack per VF per
RTM_GETLINK request, repeatable.

The other vf_* structs in the same function are explicitly zeroed
for exactly this reason - see the memset() calls for ivi,
vf_vlan_info, node_guid and port_guid a few lines above.
vf_broadcast was simply missed when it was added.

Reachability and impact
-----------------------

The leak is reachable by any unprivileged local process. AF_NETLINK
with NETLINK_ROUTE requires no capabilities. The only environmental
requirement is that the host has at least one SR-IOV-capable
interface present, which is the common case for cloud, datacenter
and HPC hosts.

Trigger: send RTM_GETLINK with an IFLA_EXT_MASK attribute whose
value has the RTEXT_FILTER_VF bit set. The kernel will then walk
each VF and emit IFLA_VFINFO_LIST, including IFLA_VF_BROADCAST,
which carries the 26 bytes of uninitialised stack per VF.

Stack residue at this call site can include return addresses
(useful as a KASLR / function-pointer disclosure primitive) and
transient sensitive data left over by whatever ran on the same
kernel stack just prior. KASAN with stack instrumentation, or
KMSAN, will flag the nla_put() when reproduced.

Reproducer (unprivileged):

    import socket, struct
    IFLA_EXT_MASK   = 29
    RTEXT_FILTER_VF = 1
    s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW,
                      socket.NETLINK_ROUTE)
    s.bind((0, 0))
    hdr  = struct.pack('=IHHII', 0, 18, 0x301, 0, 0)
    ifi  = struct.pack('=BxHiII', 0, 0, 0, 0, 0)
    attr = (struct.pack('=HH', 8, IFLA_EXT_MASK) +
            struct.pack('=I', RTEXT_FILTER_VF))
    msg  = hdr + ifi + attr
    msg  = struct.pack('=I', len(msg)) + msg[4:]
    s.send(msg)
    data = s.recv(65536)
    # Parse IFLA_VF_BROADCAST from the response. Bytes 7..32 of the
    # broadcast[] field are uninitialised kernel stack on Ethernet.

Fix
---

Zero the on-stack struct before the partial memcpy, matching the
existing pattern used for the other vf_* structs in the same
function.

Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1572,6 +1572,7 @@ static noinline_for_stack int
rtnl_fill_vfinfo(struct sk_buff *skb,
                port_guid.vf = ivi.vf;

        memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
+       memset(&vf_broadcast, 0, sizeof(vf_broadcast));
        memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
        vf_vlan.vlan = ivi.vlan;
        vf_vlan.qos = ivi.qos;
--
2.43.0

