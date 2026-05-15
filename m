Return-Path: <netdev+bounces-288162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cp1BmOJBmr0kQIAu9opvQ
	(envelope-from <netdev+bounces-288162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:48:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD9F548D4E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FB563018AC4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD823C65FF;
	Fri, 15 May 2026 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9L0B+bO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465D3C585C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778813274; cv=pass; b=hX1uWvlb1noLnLJAU0x39GdP1V2txkAyHQypRfFnITFQoDjO12D4S66AXzdb/NZ4Y9Wp0pUFvpu+J26G0jCH4GEFmkXhkIczoule4JoEujjq1/FuWkyZgePIb6o1c6GoHrct9Z0XmplAOIgxwh+sKzL6H3k8tVuyEUeZ+eO+kV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778813274; c=relaxed/simple;
	bh=m7D+WLPNFOqzKAJFVDB0kyUbGjmzpwEWKolpSndK1ng=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=elaohore/CCHtFpaOykEsQ2vGwB/mbSGiv6RFkyS4M4Z8MHMVuugL/n//8ufBGvAKaXaZ3LEownQq2woeDuxEqBB3Y1mlmHiIfUdwuNYL/wKeGrnk8oS11Adi7FjYrvlYMt8d1AhG+NmXk8lbE3A1CKmrFwgz2/VgLy2W1YDWvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9L0B+bO; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b9f8c2c950so4882635ad.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778813267; cv=none;
        d=google.com; s=arc-20240605;
        b=kk6QObxJFT9E5G9ltVtjePwhldwrw09hXD2TSPCdoVdv1eh4/krck6pLWX16/Ggqcp
         LotfupMVsE411aIVouI8JDh3W07xDpNSG8Qtx+69hdIAvcoKXfAJH0mN1BhXiPYx185+
         hBYri4av6w0aGUTsN9PZpR54IN8YNs3m906Wf3kl9bRSUbJxNeVaEieYIZCh8QwAxoE3
         Cg574Qc/SaSPG2MayxQmSqyKu2BhS+irECwYnEpVN09wU4G/5Hvl8J0Eqh+kT2xUzHZw
         We+pdDsV5vbMfkn9jIqqgoeVoBy6fMEzEtvGQb6qsQ+yEzhGAgOPbhYXBBTSzzHPvRdG
         5pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3n05qePGpQXvyL3I+8OmlAEyM9eFKP8k6z7DPQVZWDo=;
        fh=JoZIIv/sCXTMv1PCpGtqd8f4coae5SOf2U5L3oNmSb8=;
        b=hTrwZTzp6Btwudac/QKovtvwD6re3Lx6wUDdYjJelX76bWVoaLA8Ux0F1N63rPf+VZ
         WTQkbKXdHE9KlVnZ9FjD9gKdiocujWEqC8euqeMWLOlL9bv67tVXPpSWB+F7uVseBHCG
         J7qj6m1fvKlqu8xmcu7oAcxFRBnO4gAtQ06lrhFwPtuks8SBgEnik6YSxsLfSpJbwIn3
         oTzJ97qFZtckxN4OJj5pIYyft9HpzUDnwsAPkxlYBXz28GH2xEWt9twhdzqeNV9W0uiJ
         ytSATAhgXTkxzjE/TxiXn+pfx5UFMx0Xa5a6EcUECeZyO/WOGJjCaA05+GVA2RBpf9qX
         /oxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778813267; x=1779418067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3n05qePGpQXvyL3I+8OmlAEyM9eFKP8k6z7DPQVZWDo=;
        b=p9L0B+bOPhJbaLQU9Vg8SXvCCdPm4XUeJEOfcGZ0AXH2I4lYnxJApX0ukwKBycBYuU
         OXMd75xka38W3M0hdZjEuWOQAUtW+gZQJ4sKZW1hkifWDWx6p4gjpfCLPHrx/Lk/pBrk
         CHS/mQsT+BWkNIzhjwTM4D+r5X4AxH9ozwQmH7RM0wVEhdWN3ThHKcOF0AO7wL4XTpDK
         7E4Hue/rYM9ow7wB8RDbSRiAUBZqKUrLHEvfO7grKrPubNyWdWGIYwv4XVFSJVW/R/sd
         uEyYU+ZIM86pDaBafzjfGQ9+MEEA0YOQ9nSwhvQ8CnzIlwh0YJvizV4RZdbH16mjhLVY
         /oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778813267; x=1779418067;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n05qePGpQXvyL3I+8OmlAEyM9eFKP8k6z7DPQVZWDo=;
        b=qSbOPLj/Hnu/nYP0nkhFoN6FnRimZqd+zbyDIlGSyfhKbQ9b7q3YrmNXTDp9ZHWOSj
         wQfEfd+fDwEETUj6GuNrvtWWlIaGe+HYPvlKGwdx0B73Jyz7YsqROd7KF6bNN3GA92pZ
         p7r23fNpypMEgb6YVoqMUL6DKx7lmLgTxnmBvceTh06273gf1TI+0frWH3zB89Lqqkb/
         KiElizBZow/SpfYvGCgO3EaxAf8z8yC1jkoSeV/hXikd27+0caQnzOJmgrAFj0EvYZyP
         ecrnjVf00HAWJll3Q53lYBJ4dY+uRQs8St1pl5DEoe0JXg/D8vyFCQ/VIK9dklrw1op9
         cnoA==
X-Gm-Message-State: AOJu0YxMx8GzGYzd9UeADPfP1TOALDnp9koj4hIugyVQE9+G/eD2qXOM
	GXU0MnrSD31FciB2dYtrcXioWLMDU/JRrJcz1aB2kF3Pw0kAAErTsogTH6uvztywsnPNedq8Owy
	JibaLrMI/702A+Yiga7yOR/0CMhy9geXgRT+p2z9Xeoa/
X-Gm-Gg: Acq92OEH+VMhQUIhHO4og7f9IH/ngmZbaRw/kRkB6LSzTbgdfMqNoPQ0xpEyHi9R8qV
	sryMk+tEYPBdi8VzsHi/2fijw3ygCIt8pubCnz+VM++WaczKGTBl+y0WCed/VBbVhY5SXS4MkZu
	nIjBYZGCI+2LZRdgDvQfJHBX+7YwnxMg7CTfw5vFVum5eUBTIkhg24hb885GN2BjBbKbnikICbG
	Yi0GlDym5twafx/Qte1SdtHyHUsQeu1nJfhh5+1ZW2kgPwL8e2Q6s/fUlLJT20jD594EVUi/y6s
	icX9t/l7Mn8CDFu3rfA=
X-Received: by 2002:a17:903:1c3:b0:2b9:cd2d:6f16 with SMTP id
 d9443c01a7336-2bd7e7efea7mr11495675ad.1.1778813267224; Thu, 14 May 2026
 19:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 15 May 2026 10:47:36 +0800
X-Gm-Features: AVHnY4Kmh337JnX9zbvLpVtQtWMY0zsbjNfV49OTHUbhnwyOWRDzvMkBAzLqpBw
Message-ID: <CAH78GvtF5R1zn8mM+Nfva80=aww_ZAfdjsnFPZZXa0ZcBanYyQ@mail.gmail.com>
Subject: [REPORT] net/ncsi: possible RCU use-after-free in ncsi_vlan_rx_kill_vid()
To: netdev@vger.kernel.org
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1AD9F548D4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288162-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qhhackwinter@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi netdev maintainers,

I would like to report a potential RCU use-after-free in the NCSI VLAN
handling path.

Summary
-------
In net/ncsi/ncsi-manage.c, ncsi_vlan_rx_kill_vid() removes an entry from
ndp->vlan_vids using list_del_rcu(), then immediately frees it with kfree().

A concurrent reader in set_one_vid() traverses the same list under
rcu_read_lock() and dereferences vlan->vid.

This appears to violate RCU lifetime rules: list_del_rcu() requires deferring
free until after a grace period (e.g. kfree_rcu()/call_rcu()).

Affected code
-------------
Reader side:
  net/ncsi/ncsi-manage.c:set_one_vid()
    rcu_read_lock();
    list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
        vid = vlan->vid;
        ...
    }
    rcu_read_unlock();

Writer side:
  net/ncsi/ncsi-manage.c:ncsi_vlan_rx_kill_vid()
    list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
        if (vlan->vid == vid) {
            list_del_rcu(&vlan->list);
            kfree(vlan);
        }

Why this looks unsafe
---------------------
- Reader and writer do not share a common lock for ndp->vlan_vids lifetime.
- Reader uses RCU traversal.
- Writer removes with list_del_rcu() but frees immediately with kfree().
- No synchronize_rcu()/call_rcu()/kfree_rcu() is visible before free.

Privilege / trigger model
-------------------------
The write-side trigger (VLAN deletion reaching ncsi_vlan_rx_kill_vid()) is
typically restricted to CAP_NET_ADMIN (in the relevant network namespace).
The read side runs asynchronously in kernel workqueue context.

Therefore, this is not a pure unprivileged trigger: a privileged actor (or a
delegated container admin with CAP_NET_ADMIN) is generally required to drive
the write-side race window.

Impact
------
Potential UAF read on struct vlan_vid during concurrent VLAN deletion and
NCSI workqueue configuration path. At minimum this is a kernel memory-safety
violation; practical exploitability depends on timing and allocator reuse.

Environment / reproduction status
---------------------------------
I validated this as a code-level issue on Linux 7.1.0-rc3 source.
I was not able to reliably reproduce a KASAN crash in my QEMU virtio-net setup,
likely because NCSI runtime path is hardware/driver dependent in this
environment.

Suggested fix direction
-----------------------
Use RCU-delayed free for vlan entries removed from ndp->vlan_vids, e.g.
kfree_rcu(vlan, rcu) (or call_rcu()) and ensure struct vlan_vid carries the
required deferred-reclamation field.

Thanks,
Qihang

