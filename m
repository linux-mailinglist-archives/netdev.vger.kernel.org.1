Return-Path: <netdev+bounces-301668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /qfJDqXlO2oGfAgAu9opvQ
	(envelope-from <netdev+bounces-301668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:11:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4346BEFB3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:11:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WlBIbT1l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301668-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301668-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8880530120FC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A043BCD2F;
	Wed, 24 Jun 2026 14:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2EF3BCD21
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:10:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310243; cv=pass; b=TXt8/QhoVkKgWRM02awaS6pCquk8zZ05qxLGaPgaldrt17tWIfBgadUl28cyjb9UQzA2SmzRAxuPrEPD61BjHMVzagpMgZgq3oJkVmvxOT5eWgCTq3I55+VQJHZVOneJRW9fUho5C6UqOaSH/5s0XWMTkknra6kBavtxiNJKtx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310243; c=relaxed/simple;
	bh=xPB/h/E/9FMrATp4NNi/hGvwATWRoiPM/TJuAIXYVGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6GwQqPlCDkxinz8cYU3fmvAHMuOSZTCpbBsICmcEwF0ZEZFgqsXTZuPJjV7AXMzrYRFFCq+YcuxuvxeFRIbOFzI0cCoqZRoyylqr3pf/M6POMZ8W8RiXXew8e7gjy3H9VvU2vrfpjhooEvxfbCa5Knrf2oawue4R4IElXuqG80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlBIbT1l; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-519f758bd33so8448421cf.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782310241; cv=none;
        d=google.com; s=arc-20240605;
        b=WuT7KS6wYsR6TiurEVUApVbsiwIYZnBmrSFdP9C237l0FKmFpISxtDkaYlryo4pNC2
         aZvMMMsR+NwC5sh5djE2lMzRFi6NLzl+oKmFbcFJlpznV7bcGnx+OICtGyoMDmSp2Y4L
         4pu360saIqbBvDwDtwKmd1ybqV0LwzlWDsJL3GtxLvN8ZnUV7qvsZeRRW2F6U57xC1Jm
         D/rLKPfuvMBLlBKilA7QYgXKZpcQG90FgtUncRW6a3t5ax4fpKGHxvbrXyveNjsTNqbe
         +STzVGJSNKKXsUCA86AqArFLL60inYCHRsWHWdozEetIpVsQ+Fl/Nb4/r6JjvwUYG/Vf
         XxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ca6tF7PMYQ5DU1HO/HesCxCYn5zEBsIyZUNEbzR7sfE=;
        fh=Kj0DhWugTUzfYlAmWbRV7WaN+9NDFQKP/RASXxKdujI=;
        b=h0dvE6aoece+/C9/pWG4kdUM2WyA8GE1TYF2eGpCzBISUGQ03clRBsw9pW1E4s+RVF
         llUhTeuJnF5XRRn2F/mxxUCKg25XKawd5EztfaipdY7yFEWFS5NIAWa+u4k/mre1pKtS
         LC9NGuMe7dEkQAVKW08so0q8s78SqPWON+l/LGyYt+mXXYLJOfVmcG53devb582X2q27
         EW24bZ3I7KGCPpVdJk8l21f3pg+KB2gizdU2pN7KSaSPinYPifK+6Ptxrff2p3Z1UNwD
         NYOjw+cqK1/6AerX2A6NTfDEAvkNgt5djrJfRhyCoeuLxYBSuEwqeEgfj6yIrhm1EWNQ
         fOfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782310241; x=1782915041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca6tF7PMYQ5DU1HO/HesCxCYn5zEBsIyZUNEbzR7sfE=;
        b=WlBIbT1loVDl8ApCc63TV4d6K8bJFnVilzr+iyQPEr2XUI8HgiliqxnhG375591GCE
         +OqtRipzHocw1HCcWWw25TMF/m8NdxdFxItlXLLbHr5vI43Ich7fTFODrAWZ70KhGfs+
         OX5425WeJ4U0oWh1UtwjYlQYDodqx4vDZ/iwCPjESMkir16w5SADvdEHvu1PTRZY9XQy
         H15yLENhUzDfvyaZ/Usa3jFfLmzKnpzL9LqGIkxWL9qBOFBFiUNCDmSyCt9vFkLu2EuH
         I4YfX5qbQf+riO3mA77+9iv8lAer+wF5+SqQ6cnOIK/74uh/TSNbQluo0tjHE1gwP6OD
         Jq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310241; x=1782915041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ca6tF7PMYQ5DU1HO/HesCxCYn5zEBsIyZUNEbzR7sfE=;
        b=stNpY5rnpC8o7N+BfoktfiRT0GmXM+rq9IG+v9Yf2b6LHHaIbxbDf+ZR3UJ8TbdFAt
         832oz2tYTh6EgeXs4FLFERskRJNnMkkGXhOn1IK9FJ7BO7MIqfg3LWjTCBDlZJBIFL3u
         qjEUoT6LnGpKTUkKI0K0mKcrD+PyoCuLLjb7yXYojrwesJsOYAKPPWbT/Zef68es9e2k
         bCa222rQ0ymsGJ++MVgBFURDhAWOEjJKAMKXTL3/EyEtV/gjW/K/zjm7nkJw+RyBuE3e
         G8MIE9ITj8o3CKVyiw5Znq3+Rd5ApRnKfDxug1pElDoUfNBr0+c73eGUvPZzYPVIr9Vc
         MSvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gtIIWXLueGWESSRt3HhtIf5sXLrYdfzMlfmgvartjNVaFH7Mddqggv881SDaTpDgUuZJPXEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8l5xlylUbiCH8Y/zjtIwMMYofnb3JeDHf8bBbrBfLyXQv8Bku
	9R9y9+JtL5BITAuG6BED5CKsqdYJPBHEVNv0+X4dDVX3lq+tqNtd+754bG5/3a8Nb78pLYAqqlm
	GtcSZjwdBwjiZdgJT67X0EPJx7eGsU0+6R2iXgKI8
X-Gm-Gg: AfdE7clYrN3fTb4BXGs45CCIRAiq1VzcTQf3/7Wq9IDS7tCqzPPU/egceFJwTsX4rJE
	L0a5KFnhbvEr0kc9CEFzaO/c5t64OXLW9C4G26h1rR5vtOuZT5VCm+6i93hQRLDZPHRD8d9LoIh
	ytHDUSspd12k/yrERK+OGzvAIg4vvSQl8ayxwmXgENR9UzvdZXABXid3r/K8MG7G0UBTxip+YNE
	olz4U3YJYx6kDxGfpmrRD1O9YOdJghzvlLcajtkr8J4y2EyJhRi7zGDewZsxTz4Wg6K9MAPDCX6
	YoDkKOo5r+KmG9edmonLwhHC+sFC4hZLap/d8mHtUPCGzJz0QoqnpL7qAp7GfeFkGcRVblgg6a7
	OnGx3mhzUsg==
X-Received: by 2002:a05:622a:8e03:b0:50e:a1aa:2cd9 with SMTP id
 d75a77b69052e-51a696e3e64mr11337521cf.15.1782310240693; Wed, 24 Jun 2026
 07:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
 <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
 <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com> <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com>
In-Reply-To: <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 07:10:29 -0700
X-Gm-Features: AVVi8CduIv7GaLxYEzWKzmdrjcIhTxiFuUW5-7NMgVDOneFpQYn3gwdYTgCNau8
Message-ID: <CANn89iKhPmbJW_6DA1_okSGsr_e_Jz47qns-nFcZpnQZ-nAUOA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:samsun1006219@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301668-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B4346BEFB3

On Wed, Jun 24, 2026 at 6:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:

> Oh well.
>
> u8 need_sync:1;
> u8 need_replay:1;
> u8 work_pending:1;
>
> These bitfields are not safe, obviously :/
>
> Time to convert them to atomic bit operations.

Can you try:

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..939d6f656bb71814718bc3bf84b=
e665adad27e4b
100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -30,9 +30,7 @@ struct udp_tunnel_nic_table_entry {
  * @work:      async work for talking to hardware from process context
  * @dev:       netdev pointer
  * @lock:      protects all fields
- * @need_sync: at least one port start changed
- * @need_replay: space was freed, we need a replay of all ports
- * @work_pending: @work is currently scheduled
+ * @flags:     sync, replay, pending flags
  * @n_tables:  number of tables under @entries
  * @missed:    bitmap of tables which overflown
  * @entries:   table of tables of ports currently offloaded
@@ -44,9 +42,10 @@ struct udp_tunnel_nic {

        struct mutex lock;

-       u8 need_sync:1;
-       u8 need_replay:1;
-       u8 work_pending:1;
+       unsigned long flags;
+#define UDP_TUNNEL_NIC_NEED_SYNC       0
+#define UDP_TUNNEL_NIC_NEED_REPLAY     1
+#define UDP_TUNNEL_NIC_WORK_PENDING    2

        unsigned int n_tables;
        unsigned long missed;
@@ -116,7 +115,7 @@ udp_tunnel_nic_entry_queue(struct udp_tunnel_nic *utn,
                           unsigned int flag)
 {
        entry->flags |=3D flag;
-       utn->need_sync =3D 1;
+       set_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 }

 static void
@@ -283,7 +282,7 @@ udp_tunnel_nic_device_sync_by_table(struct net_device *=
dev,
 static void
 __udp_tunnel_nic_device_sync(struct net_device *dev, struct
udp_tunnel_nic *utn)
 {
-       if (!utn->need_sync)
+       if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
                return;

        if (dev->udp_tunnel_nic_info->sync_table)
@@ -291,21 +290,24 @@ __udp_tunnel_nic_device_sync(struct net_device
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

+       set_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
        queue_work(udp_tunnel_nic_workqueue, &utn->work);
-       utn->work_pending =3D 1;
 }

 static bool
@@ -348,7 +350,7 @@ udp_tunnel_nic_has_collision(struct net_device
*dev, struct udp_tunnel_nic *utn,
                        if (!udp_tunnel_nic_entry_is_free(entry) &&
                            entry->port =3D=3D ti->port &&
                            entry->type !=3D ti->type) {
-                               __set_bit(i, &utn->missed);
+                               set_bit(i, &utn->missed);
                                return true;
                        }
                }
@@ -483,7 +485,7 @@ udp_tunnel_nic_add_new(struct net_device *dev,
struct udp_tunnel_nic *utn,
                 * are no devices currently which have multiple tables acce=
pting
                 * the same tunnel type, and false positives are okay.
                 */
-               __set_bit(i, &utn->missed);
+               set_bit(i, &utn->missed);
        }

        return false;
@@ -552,7 +554,7 @@ static void __udp_tunnel_nic_reset_ntf(struct
net_device *dev)

        mutex_lock(&utn->lock);

-       utn->need_sync =3D false;
+       clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
        for (i =3D 0; i < utn->n_tables; i++)
                for (j =3D 0; j < info->tables[i].n_entries; j++) {
                        struct udp_tunnel_nic_table_entry *entry;
@@ -696,8 +698,8 @@ udp_tunnel_nic_flush(struct net_device *dev,
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
@@ -713,8 +715,8 @@ udp_tunnel_nic_replay(struct net_device *dev,
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
@@ -736,10 +738,10 @@ static void
udp_tunnel_nic_device_sync_work(struct work_struct *work)
        rtnl_lock();
        mutex_lock(&utn->lock);

-       utn->work_pending =3D 0;
+       clear_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
        __udp_tunnel_nic_device_sync(utn->dev, utn);

-       if (utn->need_replay)
+       if (test_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags))
                udp_tunnel_nic_replay(utn->dev, utn);

        mutex_unlock(&utn->lock);
@@ -866,6 +868,11 @@ udp_tunnel_nic_unregister(struct net_device *dev,
struct udp_tunnel_nic *utn)

        udp_tunnel_nic_lock(dev);

+       if (test_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags)) {
+               udp_tunnel_nic_unlock(dev);
+               return;
+       }
+
        /* For a shared table remove this dev from the list of sharing devi=
ces
         * and if there are other devices just detach.
         */
@@ -901,12 +908,6 @@ udp_tunnel_nic_unregister(struct net_device *dev,
struct udp_tunnel_nic *utn)
        udp_tunnel_nic_flush(dev, utn);
        udp_tunnel_nic_unlock(dev);

-       /* Wait for the work to be done using the state, netdev core will
-        * retry unregister until we give up our reference on this device.
-        */
-       if (utn->work_pending)
-               return;
-
        udp_tunnel_nic_free(utn);
 release_dev:
        dev->udp_tunnel_nic =3D NULL;

