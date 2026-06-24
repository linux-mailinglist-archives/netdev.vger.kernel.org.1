Return-Path: <netdev+bounces-301687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HXWFDWD0O2qFgQgAu9opvQ
	(envelope-from <netdev+bounces-301687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:14:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A366BF87E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:14:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VNpGhCoQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301687-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B0231FA015
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF33DA5A1;
	Wed, 24 Jun 2026 15:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038953DA5AA
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:00:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313258; cv=pass; b=Uq+Ypcd64KjtjVeWw9UMwZqJR4UG6ajzC55Y5YWM3S5fkGKS3R9gPIf4jWtryVi7H33O3yTMV2Rcna72mfUSSh0YLagCBHLsn4neSt23qrmr53msjS4/FBxZwefo62CcFbBX/o3Jb+2jijBAgKEaWrf6xTJXhfG+923JAHlmPT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313258; c=relaxed/simple;
	bh=yXJKwqNMfqlXTEehPMa3xmHTsM3kCimS4CHrwbaTF/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyuToI2si6xnO6pfcYueqZC4eOASP8om9yWRaZf446odzhU3VqxLT8l2t3rS8UCKDbs4vsqmNjqee6RymV/ABHxcNWLgbPxIEOSjwq88FLusdGdSY+YlYeEg/Vr/dg63KKDPftuaFZ4ju+TDnBFG9QRVh0vQI2lPGVb4VuyGOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNpGhCoQ; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519eced8cbeso13643821cf.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782313254; cv=none;
        d=google.com; s=arc-20240605;
        b=XsP52hrVeSj+a17AydAYc3JGOp1H6wLA72NnPl6+bE/E3Lanms6J9D63u8Fbtqn4fE
         M5aVehR+o0gs1vu0uu16o9Q7dUeaIbOQW5X+Ax0M7Jx+8MfUBtu7AOqOhLpLJtfGmJU7
         zWGgeembClgZBHpUh7+ymUzmzQncF7Si5YugR5BubRcz7OKpVn4/A4hinUaXjjQj5zRd
         rU58Bp//ehT/r6ogtQU+A1CkH5BvaaBZEq7jQJ07CRjzRn9dFRQcdRzUEo7qwyhkQN8q
         y7ojuLj+WpkneyGtcPvmj2M4GTUYODHjJppJU1jJm9J88++m2DuJDw3dLIjHQgWNYO2G
         lYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+LWYaZe/QsFNM9ajMxRmRyFC8DqW6fUE6E4x7tqG89I=;
        fh=bLegC0pVaTjAe7zrcvf/lpMS633w8RqzZJu+adQWiFg=;
        b=S9rgQHePxI4Ps0BFPRU/ZbILwI0kihNAvppdyg47YtUw71ampzOz5OQrCGOo2+qZkc
         X5gu5ML3tQBnKvhI4GHz+cpuvmCnks3t6Ygq9MQ4ZroADwxPJK6lWZdZSOjF+wTmeNL9
         Pb5b3RnO0QmsOwEx17KKOPQPxGLCAAs3Nf/QSBW0icnY52OkQJzgMpGDu5vA7Vi9Mh+9
         3ZJrCuqGJJGGlskvDxnkMOHLLImM98FGYDleNYrk+kMWNwnUP/iCGO/UhLRVI8RA4BrO
         Sb1TzQhfQoRWlxPhGK2pT6BNrNPpQ1SeUT9nHka1pUVu9EB8488OHbR0FnlfcHeUtiN4
         4c9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782313254; x=1782918054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LWYaZe/QsFNM9ajMxRmRyFC8DqW6fUE6E4x7tqG89I=;
        b=VNpGhCoQU4BV+GSC07QiztoBC1rAfOtz+n4ZDhBPiKfTxWsymu3rX+PU0bqFdc7+iG
         wGCj1idf4SwGQ4e7nFlbwWv+z0zdNc60cUvchRG1PHPtMpVwdj35f8BOUtsgsxEdysU6
         yi1kAyRZ0rFUgbD1TBZ0lbS3rWUclCkbTBtMM1ODFsJl3ps+47ste5zidZqsoYmYn7qu
         5/1hlOfaX95YNjWtLSwT/Cl3tcTYY20HqN6NPFGUqaxr0z1w75wlg66drDeM3XYZaxB6
         APD/EYMnSgcvfjsVXDcMrHEh6AR8DtLZVWrDuOzNGWKd18Z0XA8LYBBXfwGtlwR7qR42
         IdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313254; x=1782918054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LWYaZe/QsFNM9ajMxRmRyFC8DqW6fUE6E4x7tqG89I=;
        b=mVa+UqekUEsPkwYTPddfgNiac9rxHMOQ2XNx6rvyuDMqLZteNP7/I/sHlYlVQ5fpm0
         hNlg0QP95UTAjeQHfe/U2KnkCeDAvf1+Gb98QJ31T06JyBxrlHQOTwRvQvdU7yBlPRUf
         cql+EKlIa2xD2L9+gKkGPXBYN7R6cnZiMsJbi6n3Tzkz/ToqaeP4Y8t5Azq+9NdH/bPt
         PNQ9ugXFB4foOfABiVI3VWnNGIL0TrzPLNT4Z8RoUmE/GdpJr0OtQXFT+D53KtLQT9Fu
         /cyUBN7zH3Q9TnS5+MaR5soyVR+0xemkiZcKc3BkpKSgY7d5bkuJFQizG/y933Bse5QR
         1B0g==
X-Forwarded-Encrypted: i=1; AFNElJ/5X54vLRT81/lsSdLubyT0TvKlSRlzM6Hkhf+9fIMgch8HCMKol13edWkshyc5vz2q2tOxbuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxW7pvpeIPiiCM/c5huhXPpbL8drIYIm8qtTPd33Pgo96v+Ua
	kUOsJA+bXc2krCWqTbr6Enp63nFXeSYYFUy9DmUJPTG7avAYsgwoTzI57gRuvAcCldH8Wyb7t5t
	9ydFaCz9byFA1pXdv1czlIhrF8Jb1GsKvLwDNP4/Y
X-Gm-Gg: AfdE7cm1J1bK/RqlARULiCcGSlwOylm9CpY4roR6Mj027xtQBnRtvyoz2Xjo91y5sYl
	T6P/Q565kOtjYXl4tWKOKLja0vFCqFZGbK5RACEWW3IwaJBqiK3ZmWId8UKuMAbl4NNEHCaK1eP
	Ha9PvUd444OEIp4PwD5hC5hxiy3LY4PQ/SpQrBufzt4UsGr4vONFu4P68PdftHwFVMSUb2AfUZO
	rQMe9gPOmMjpr0AvgfIsu83z8pjLVxj/d3hKHMSmRuL8ewgvz0ndqpgm4/4BtEqYts3JqTT8tkK
	0nlhXwpPK6dZ1PNpmnMPRpe/72LHPU11GQib281/gWfzNTeQ7HD5RBmAnHYe2HqyO06xsWUeAFL
	U7uVYk6jEhg==
X-Received: by 2002:a05:622a:1346:b0:50e:a1ab:67ea with SMTP id
 d75a77b69052e-51a61be5ac5mr54868501cf.40.1782313243049; Wed, 24 Jun 2026
 08:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
 <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
 <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
 <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com>
 <CANn89iKhPmbJW_6DA1_okSGsr_e_Jz47qns-nFcZpnQZ-nAUOA@mail.gmail.com> <CAEkJfYMXsNuJjKWJ5nvvw0afSP77F0WWT0gfj2-sQM3VyZ0brQ@mail.gmail.com>
In-Reply-To: <CAEkJfYMXsNuJjKWJ5nvvw0afSP77F0WWT0gfj2-sQM3VyZ0brQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 08:00:31 -0700
X-Gm-Features: AVVi8Ces5ZpLMCkCxPTh09-Yz-phHh6owhdU62A8gYT1CIbxmcmKLbiH0FeFMLQ
Message-ID: <CANn89iKgwNmTZ98MW92VVgC5zPqtQDBFBFspCphKpS-5i6+-7A@mail.gmail.com>
Subject: Re: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
To: Sam Sun <samsun1006219@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:samsun1006219@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301687-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71A366BF87E

On Wed, Jun 24, 2026 at 7:46=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> w=
rote:
>

> So we are still freeing struct udp_tunnel_nic while its embedded work_str=
uct
> is active. debugobjects catches this at kfree() before the active work ge=
ts a
> chance to run later and dereference the freed utn.
>
> My read is that the conversion from bitfields to atomic bitops removes th=
e
> plain bitfield data race, but UDP_TUNNEL_NIC_WORK_PENDING is still only o=
ne
> boolean state. It can represent "some work is pending", but it cannot
> distinguish between:
>   idle
>   queued
>   running
>   running and queued again
>
> In particular, the workqueue core clears WORK_STRUCT_PENDING before invok=
ing
> the worker. At that point the same work item can be queued again by
> udp_tunnel_nic_device_sync(). If an already running instance later execut=
es:
>
>   clear_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
>
> it can still clear the bit that was set for the requeued instance. Then
> udp_tunnel_nic_unregister() may observe UDP_TUNNEL_NIC_WORK_PENDING clear=
 and
> free utn, even though debugobjects still sees utn->work as active.
>

-ETOOMANYBUGS

Ok, we could try to convert pending bit to a refcount.

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..2e14686f35896cb0caba3f8f587=
ef8b369090fbf
100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -3,6 +3,7 @@

 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -30,9 +31,8 @@ struct udp_tunnel_nic_table_entry {
  * @work:      async work for talking to hardware from process context
  * @dev:       netdev pointer
  * @lock:      protects all fields
- * @need_sync: at least one port start changed
- * @need_replay: space was freed, we need a replay of all ports
- * @work_pending: @work is currently scheduled
+ * @flags:     sync, replay flags
+ * @refcnt:    reference count
  * @n_tables:  number of tables under @entries
  * @missed:    bitmap of tables which overflown
  * @entries:   table of tables of ports currently offloaded
@@ -44,9 +44,11 @@ struct udp_tunnel_nic {

        struct mutex lock;

-       u8 need_sync:1;
-       u8 need_replay:1;
-       u8 work_pending:1;
+       unsigned long flags;
+#define UDP_TUNNEL_NIC_NEED_SYNC       0
+#define UDP_TUNNEL_NIC_NEED_REPLAY     1
+
+       refcount_t refcnt;

        unsigned int n_tables;
        unsigned long missed;
@@ -116,7 +118,7 @@ udp_tunnel_nic_entry_queue(struct udp_tunnel_nic *utn,
                           unsigned int flag)
 {
        entry->flags |=3D flag;
-       utn->need_sync =3D 1;
+       set_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 }

 static void
@@ -283,7 +285,7 @@ udp_tunnel_nic_device_sync_by_table(struct net_device *=
dev,
 static void
 __udp_tunnel_nic_device_sync(struct net_device *dev, struct
udp_tunnel_nic *utn)
 {
-       if (!utn->need_sync)
+       if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
                return;

        if (dev->udp_tunnel_nic_info->sync_table)
@@ -291,21 +293,24 @@ __udp_tunnel_nic_device_sync(struct net_device
*dev, struct udp_tunnel_nic *utn)
        else
                udp_tunnel_nic_device_sync_by_port(dev, utn);

-       utn->need_sync =3D 0;
+       clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
        /* Can't replay directly here, in case we come from the tunnel driv=
er's
         * notification - trying to replay may deadlock inside tunnel drive=
r.
         */
-       utn->need_replay =3D udp_tunnel_nic_should_replay(dev, utn);
+       if (udp_tunnel_nic_should_replay(dev, utn))
+               set_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
+       else
+               clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 }

 static void
 udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *=
utn)
 {
-       if (!utn->need_sync)
+       if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
                return;

-       queue_work(udp_tunnel_nic_workqueue, &utn->work);
-       utn->work_pending =3D 1;
+       if (queue_work(udp_tunnel_nic_workqueue, &utn->work))
+               refcount_inc(&utn->refcnt);
 }

 static bool
@@ -348,7 +353,7 @@ udp_tunnel_nic_has_collision(struct net_device
*dev, struct udp_tunnel_nic *utn,
                        if (!udp_tunnel_nic_entry_is_free(entry) &&
                            entry->port =3D=3D ti->port &&
                            entry->type !=3D ti->type) {
-                               __set_bit(i, &utn->missed);
+                               set_bit(i, &utn->missed);
                                return true;
                        }
                }
@@ -483,7 +488,7 @@ udp_tunnel_nic_add_new(struct net_device *dev,
struct udp_tunnel_nic *utn,
                 * are no devices currently which have multiple tables acce=
pting
                 * the same tunnel type, and false positives are okay.
                 */
-               __set_bit(i, &utn->missed);
+               set_bit(i, &utn->missed);
        }

        return false;
@@ -552,7 +557,7 @@ static void __udp_tunnel_nic_reset_ntf(struct
net_device *dev)

        mutex_lock(&utn->lock);

-       utn->need_sync =3D false;
+       clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
        for (i =3D 0; i < utn->n_tables; i++)
                for (j =3D 0; j < info->tables[i].n_entries; j++) {
                        struct udp_tunnel_nic_table_entry *entry;
@@ -696,8 +701,8 @@ udp_tunnel_nic_flush(struct net_device *dev,
struct udp_tunnel_nic *utn)
        for (i =3D 0; i < utn->n_tables; i++)
                memset(utn->entries[i], 0, array_size(info->tables[i].n_ent=
ries,
                                                      sizeof(**utn->entries=
)));
-       WARN_ON(utn->need_sync);
-       utn->need_replay =3D 0;
+       WARN_ON(test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags));
+       clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 }

 static void
@@ -713,8 +718,8 @@ udp_tunnel_nic_replay(struct net_device *dev,
struct udp_tunnel_nic *utn)
        for (i =3D 0; i < utn->n_tables; i++)
                for (j =3D 0; j < info->tables[i].n_entries; j++)
                        udp_tunnel_nic_entry_freeze_used(&utn->entries[i][j=
]);
-       utn->missed =3D 0;
-       utn->need_replay =3D 0;
+       bitmap_zero(&utn->missed, UDP_TUNNEL_NIC_MAX_TABLES);
+       clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);

        if (!info->shared) {
                udp_tunnel_get_rx_info(dev);
@@ -728,6 +733,25 @@ udp_tunnel_nic_replay(struct net_device *dev,
struct udp_tunnel_nic *utn)
                        udp_tunnel_nic_entry_unfreeze(&utn->entries[i][j]);
 }

+static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < utn->n_tables; i++)
+               kfree(utn->entries[i]);
+
+       if (utn->dev)
+               dev_put(utn->dev);
+
+       kfree(utn);
+}
+
+static void udp_tunnel_nic_put(struct udp_tunnel_nic *utn)
+{
+       if (refcount_dec_and_test(&utn->refcnt))
+               udp_tunnel_nic_free(utn);
+}
+
 static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
 {
        struct udp_tunnel_nic *utn =3D
@@ -736,14 +760,15 @@ static void
udp_tunnel_nic_device_sync_work(struct work_struct *work)
        rtnl_lock();
        mutex_lock(&utn->lock);

-       utn->work_pending =3D 0;
        __udp_tunnel_nic_device_sync(utn->dev, utn);

-       if (utn->need_replay)
+       if (test_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags))
                udp_tunnel_nic_replay(utn->dev, utn);

        mutex_unlock(&utn->lock);
        rtnl_unlock();
+
+       udp_tunnel_nic_put(utn);
 }

 static struct udp_tunnel_nic *
@@ -759,6 +784,7 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *=
info,
        utn->n_tables =3D n_tables;
        INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
        mutex_init(&utn->lock);
+       refcount_set(&utn->refcnt, 1);

        for (i =3D 0; i < n_tables; i++) {
                utn->entries[i] =3D kzalloc_objs(*utn->entries[i],
@@ -776,15 +802,6 @@ udp_tunnel_nic_alloc(const struct
udp_tunnel_nic_info *info,
        return NULL;
 }

-static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
-{
-       unsigned int i;
-
-       for (i =3D 0; i < utn->n_tables; i++)
-               kfree(utn->entries[i]);
-       kfree(utn);
-}
-
 static int udp_tunnel_nic_register(struct net_device *dev)
 {
        const struct udp_tunnel_nic_info *info =3D dev->udp_tunnel_nic_info=
;
@@ -863,6 +880,7 @@ static void
 udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *u=
tn)
 {
        const struct udp_tunnel_nic_info *info =3D dev->udp_tunnel_nic_info=
;
+       bool last =3D true;

        udp_tunnel_nic_lock(dev);

@@ -889,6 +907,7 @@ udp_tunnel_nic_unregister(struct net_device *dev,
struct udp_tunnel_nic *utn)
                        udp_tunnel_drop_rx_info(dev);
                        utn->dev =3D first->dev;
                        udp_tunnel_nic_unlock(dev);
+                       last =3D false;
                        goto release_dev;
                }

@@ -901,16 +920,11 @@ udp_tunnel_nic_unregister(struct net_device
*dev, struct udp_tunnel_nic *utn)
        udp_tunnel_nic_flush(dev, utn);
        udp_tunnel_nic_unlock(dev);

-       /* Wait for the work to be done using the state, netdev core will
-        * retry unregister until we give up our reference on this device.
-        */
-       if (utn->work_pending)
-               return;
-
-       udp_tunnel_nic_free(utn);
+       udp_tunnel_nic_put(utn);
 release_dev:
        dev->udp_tunnel_nic =3D NULL;
-       dev_put(dev);
+       if (!last)
+               dev_put(dev);
 }

 static int

