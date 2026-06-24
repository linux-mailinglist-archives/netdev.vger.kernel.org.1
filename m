Return-Path: <netdev+bounces-301601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YAgaEBurO2pJbAgAu9opvQ
	(envelope-from <netdev+bounces-301601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:02:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0F6BD288
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=n62s9mBU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301601-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301601-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A135F3003827
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D7258EF3;
	Wed, 24 Jun 2026 10:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4F2F1FE3
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:01:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295289; cv=pass; b=nkUAudbdRdoCI/T85AOxYPfVweR7CsPYWwJziIKdoz68g1oHCkNt7b+cWbEPL83f7s6Kwt964xHq4snr2D51bVTuGtERzUalVE6yArSNLntDDJxRwtPQExLF45llrv4V43QwMHmQ63XFM/uc2s6gdAb7fh5AzUyq5FMtLXfqF70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295289; c=relaxed/simple;
	bh=lgvozL3AL/CqJKA/D/C1TAp8M44/N8ufUjVFRQElJsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkSNncZrtsUb+T93J4BDQ+emSCPskPEcHMqUmz+6AqUrjzEzFMzNFoJW+JFXCvQRp9QBjZtJ04nksUajnmZt4EkGOniOOBaWNVUgerKKO92+QXr0d4h/9Et0DAntRHhTOoEo+ON1h4z3lw93Z0v+SA3PIsghWLamDt9UtJkk4JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n62s9mBU; arc=pass smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157b949fc7so81017985a.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 03:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782295287; cv=none;
        d=google.com; s=arc-20240605;
        b=jnQs/bQEnhsV+pt3O06PJ5aIMqPbtd6D9zc6KI1j2hr0ZhdGkXMdRj8MQ3k20EM11w
         5GqP6+8o0DFxT4Y8C83IjD/GJIYiGDyEoem1MjafZOXpSFfnKjoC0FmeLIGhf3B0kQJi
         jGDhsI0JSN6/Gp4WHOiclFo1Ut0/U4oNm7MQIxC+HRJjaSW0c254DKplVBDEY0PS7ZEY
         wGnk1lGlisYZ0IkEuD1VrgtwjisehNCXNxZ5LCuM06Og2iuB/NSZ5Z4UWmVsEO305CS7
         1r2CUUqDA4RuHPdZkkA1bol16QblXBxwuW3SJOsK4XuySU3n+xQlRNYkQurfrY/g9wr1
         J7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WF9rIgAhDmPKPEQxYijzUCxIXmPIr8nHRirezEH6n2c=;
        fh=NoDPXHxuW+mARAXqA/whCOjJrf1pCnsjdYV/VtkaLn4=;
        b=HACKL7V3uFHAlRmlOOeGWZW0smk0Cyrd9c+ksHqynjq/854HFHDA5j34SC4MsLteLP
         D/BYV04+8CsTsMYG0hwhvFAvaj/C8UFgjr44Wdym3FwpxRHNnJFjFtSNl2MDxjr8t/A5
         4iiKY4g8I2OkVN+Z3iOKiDL75dwowzlHy0QvPiWczfN1L1/y4Rq6IbvoTuIBBsQMhPuq
         oqWBPMl21tF1uBvVOV4JnDAu5VOqD81VHUKIx7Cy36+I9e0N69h2piyLFS3GyH+VB/pl
         GWijFpRXWxKPC2UuCFeJO4a/GLDCfFLDwTbkvEVuTh302/JE6R3tMPCMS3jFC7/qYUpc
         UH8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782295287; x=1782900087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF9rIgAhDmPKPEQxYijzUCxIXmPIr8nHRirezEH6n2c=;
        b=n62s9mBUh39yrs1bmkfPnmNNeedICMan4hBuv64/+J5cH5va+psfTGVIiGH/ahsp/G
         DWn8rqB042A/taoMN8lGKZkgILST5ZD2fvmIkGjLhIw22mtplKuPoUdk2YeSYTSReaXx
         8z+0eAz2CHDHM5Em2Y7ixaxTnOKIUk8Ji3HhrCka55tDsby1MDkM2xM0K9IazEJSJbbW
         N8X4VySeN6B04F7zJdeOu3bwyMBP3bdY1rjYN91IIIZumEkGahZ6xePnKwye4tLMlPgJ
         L94fpv2ubDC1Y1MCUwdFWZADxbsbtQ/9dUCpAOWVFGC6p9vj9yVHvckwkGo6KkUmrq8R
         0RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295287; x=1782900087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WF9rIgAhDmPKPEQxYijzUCxIXmPIr8nHRirezEH6n2c=;
        b=luvgfn1qXZ3QwRFmTX+3OvAsB9gaacKv1s2M+yStyZlIRFKcIOJ9NnU+/bdEXzUPE9
         T55Os1i08H3xgSJFsMvnZcegdDfWWFhkJgz8hCTERoANjBZ+qPl1nHJdEBhJLGriYgCs
         2+cdY7BrNQkER55bdt89lJVX/zEPQCucQAFPuc9vWiTHXjNNxFfiM2Czfavv6+GaqAoO
         Y5mV7yxtM8A6UJgqN3snPmOyNsny1E7ImU9hb0YH5Xkjp4JeNAQfLoLHgfXs2S1fH06D
         DxZyb6O0+E6wc+/K5w7U/3tHHtxmwAUfMUMRd3pF9QjTWI9O6IqfdMd+nvKvwOcsa9py
         4Pcw==
X-Forwarded-Encrypted: i=1; AFNElJ+JZssHXKD7VDQt423LaPgt5oPgKVGTMpvLB+Ue4cCMTsTcvUNVNAoMI0+G3KJo7LRedXHWexk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ZuR5SKOgga6dMI37yyxqLo+5y7ITInmwgKWB9lKQWHzvko1k
	JFkXv3lE3MerTrtFf4rZjksXCkfj84lSFNXx3+TKHBlT+/ffzdRTzJ1CejfNCME2tE70kiEsTxT
	EKbG5BJOpZCK6wZfCkkc3WO/eiHdfCKsCsLiQVsSF
X-Gm-Gg: AfdE7ckWmrCq0liNLuo6YExalQ3QjLyIcEINJIzzTBsWaHznkEk1KFWB2jgnjV2QG4h
	bgr7ZRWTxEZ12C6hnyy4IahnH9Y1l4XvoiGlQ1qUUybvJdRG2eN5qKemYb5kSXPncpvEANypeno
	60HkKk94kFrv3+VDTq8p/n6ax2ZvbFVt4mn8KQSfzUtPia+eybTxmVE7VzsrDhxLEpKt2p6rNxe
	OpuaO9in+wObzJh2r2qbe6zfpG2oi9qobY79Paeb5VpBUn4mfdgrQSaqM5G6jT0WnFpEGwWjPF4
	UFQr/fLgX/6YrM4UmKh+Gp9RHkmRMMUIhK5LRwY/icrZWQvKUTEHmboS23sbjnT9k8Xcf2Tf0vj
	wkk58savk
X-Received: by 2002:a05:620a:19a8:b0:915:c4de:7ada with SMTP id
 af79cd13be357-921d29f75demr2745314185a.27.1782295279563; Wed, 24 Jun 2026
 03:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
In-Reply-To: <20260624090135.95763-1-samsun1006219@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 03:01:07 -0700
X-Gm-Features: AVVi8CfU9POL6E8q4FxG5_3bQNxeCG6Jq-h718d5-dzl909b9xk3HUFcfjzwKmo
Message-ID: <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
Subject: Re: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
To: Yue Sun <samsun1006219@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-301601-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CE0F6BD288

On Wed, Jun 24, 2026 at 2:01=E2=80=AFAM Yue Sun <samsun1006219@gmail.com> w=
rote:
>
> Hello,
>
> I hit a reproducible use-after-free in the UDP tunnel NIC offload work it=
em.
> The original local crash was reported by KFENCE as:
>
>   KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
>
> On current mainline, the C reproducer below triggers the same lifetime bu=
g,
> reported by KASAN before KFENCE samples the object:
>
>   BUG: KASAN: slab-use-after-free in __mutex_lock
>   Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
>
> Tested kernel:
>
>   840ef6c78e6a ("Merge tag 'nfs-for-7.2-1' of git://git.linux-nfs.org/pro=
jects/anna/linux-nfs")
>   Linux 7.1.0-11240-g840ef6c78e6a #31 SMP PREEMPT_DYNAMIC
>


Thanks or the report.

Can you test the following patch?

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..c5f8d2f9d325de8f4d2247ddaa5=
2e33378851857
100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -304,8 +304,8 @@ udp_tunnel_nic_device_sync(struct net_device *dev,
struct udp_tunnel_nic *utn)
        if (!utn->need_sync)
                return;

-       queue_work(udp_tunnel_nic_workqueue, &utn->work);
        utn->work_pending =3D 1;
+       queue_work(udp_tunnel_nic_workqueue, &utn->work);
 }

 static bool
@@ -866,6 +866,11 @@ udp_tunnel_nic_unregister(struct net_device *dev,
struct udp_tunnel_nic *utn)

        udp_tunnel_nic_lock(dev);

+       if (utn->work_pending) {
+               udp_tunnel_nic_unlock(dev);
+               return;
+       }
+
        /* For a shared table remove this dev from the list of sharing devi=
ces
         * and if there are other devices just detach.
         */
@@ -901,12 +906,6 @@ udp_tunnel_nic_unregister(struct net_device *dev,
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

