Return-Path: <netdev+bounces-289543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBiCDvScDGrujwUAu9opvQ
	(envelope-from <netdev+bounces-289543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364C58300C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D147D301051C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5160C3DB310;
	Tue, 19 May 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voIS98Gv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606F3DB307
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211060; cv=pass; b=ipxrxAw6PJ1krpmw9sfRgkvI/WJJM5aG5pGI6WpRDqMJK3UdTP4Cp2at6nIV3YVm/ak54L+sfZL67VmQlmiQHRAJs+skIWpcLGKyOJTNhRrK/sLN281BcMXdfIXCO/JjciVHGp4kn8OLih4qnLYCGQZWfsdno3euG0d25Y4NfP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211060; c=relaxed/simple;
	bh=fTFDtaTP/25LSteMB4dTEpVYINaA9iJdKOAHEYXY62Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qISx29UTC3rJ6WdAYTway5jQ0ta6/uyH0JTHN73Br66bfsOYyelnPb1z+rf3FPB3Tem5S4fBA3DCe/olVvFhsUDa0H1T3TDqlUDJxnNwoJXDPy+cOf95RsAACo0bL7fISAxq8Zcg3TL0TqGD2nRdPB7F256DnJBtuXCCUoV6eXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voIS98Gv; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5b55062fso34414321cf.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211057; cv=none;
        d=google.com; s=arc-20240605;
        b=bBcuNsfvHUj6shNxRLJcZDrdr24IbsLx2R52LNQO+7vKvWOwbS/blzGjc3Jl1ldnGT
         yzsYK89ZTJ5od1HD61DQjwLok46BflykmEsembwxKPLCktl/UV+TPEBsqjWZYfcNDZu/
         2m7j5s+XOkFAZWwEujm9X5t22TwhHo/9+anTWfdtSrlP7DRisPH2XnZLLXsuHKrIFOF8
         b5B5Zbhrff4tDbhvz2ZUqdu0bkqds9jwB2xq17+d7M4HAAxKcXBuyP6v84o5IxKv3cAX
         E46sBSl+m5UWo1wnVAvhUhJ/YpySonPA70FejmoRF5nlU373QFRqN5rtegwqqDrifaah
         NB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/aJuMJZqLMW7rPHXhUFaBPEXLHn0ifKZtdJbmFcqzQ=;
        fh=W+wXIrKarBUXTqdON43tYSKnOVrYywegs4BaNAZu22c=;
        b=O2b234Prj0AZoi5AvlUy+ZD7FMWjgSRxkP/sPS1Xeh5yHJbwbHd+axx9gGF2Ufaa2e
         sPhTRyZLQjGM9ru+u/fQKGJwpSY+AH5bOT63EPBbwVodYpOqSVStqXzJ7zzENgH2/xhh
         fQQSrfKdecZ6neeM+ms6c4nMDn4bQmrPIJCGjtjeGLAoa4HMXsmTIVnAPt2blOTCOWIR
         fmFCobVlCdqZblzjAH/BDVi+02ePp3aEnVxa+iX03uv00nqW9KAVF59jRurV6i1LZxr7
         7w5pEVC+4e/oKXPuhv3HYlGDOk4BqJ+PlHhXC/n62eKCNK+KTpZpnYqzWW0XpJsl2gPN
         2Lig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779211057; x=1779815857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/aJuMJZqLMW7rPHXhUFaBPEXLHn0ifKZtdJbmFcqzQ=;
        b=voIS98GvQqscR8ZBD3i+n1p2BnJ3jdqxtsvlZzLHhHGzSK2Eg9GWf6a2L1793QTrBX
         Y2LSLJ12RdPXI2AcVARU4SStBCO8GWPhPBaMcnAOSnFNsz7uO8nOdKLhlB1GWE9Y5hcm
         pvB5HISsJf6l6jTDxE3mGJAERrIuGkPUkFxkgJ7yP3b5jcjabfFfsGLO05+9ZmQlDAGo
         X8LOhH87qqMKrzfJ0auPVfarWFDNff0cdZej+f1A1n0Z/5drl+TOd/PWeoNIBzX3DtLt
         qsgNXDNiGlbLUL8NRI7Rd93H4+1XO8HkzbcwdoNPFIdBEiJLUGTLB2H3OEGg3LHRiWNS
         IqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211057; x=1779815857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/aJuMJZqLMW7rPHXhUFaBPEXLHn0ifKZtdJbmFcqzQ=;
        b=rXJ+cjMdsbVpUXI2NxtY7qJ+45E2ftBafEUr1V6WG+JC8eA7y/d21NoiTbHoPmnru3
         spsPOfawvtS9pVFrFTSX2pSTbbKF/agmuxQTrT6UrEmZdyNNrT5V9N59O2CFjcVeRS0j
         B2g1hVTyO0Ced/oJRXmHyGQsamCU5pgPcA8TAOdWbVNSAdnHnWOOefTZdA3k70eG63HJ
         8/OPC/MIPgJGSpUDM7HwC0qbBi10qj+dOpnFO/ymU1XPsyzmh7LR2ukebbOfJaDWBHkq
         DHhg6m4RH7MzHtwQgwyvYN3ZeH4z/XLxwbjUJw+L9pds13YXAo0lvOybH5OcGOOmMwS5
         WwEA==
X-Forwarded-Encrypted: i=1; AFNElJ8tEyma7/Kseernylz+s1ns/ybdtOby240TNuyT+LDZvSM+jIwM/pxsbtyRb8j5NFnQf619TdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcoVnTLpAuOk5MrrstGgAjmG0XnvgGdm9Qi6SQHvLcyE2c48Z
	flweU/KM7YIgFbP3gmMtcsapKdKNHGoI/Kchdkj6asAg/jAfaLFJfBaGFtQyGo/+xzazFkOcdjJ
	Rjv/7siuBwrnhVYd6d+AcfxBBj0TCiNiEvhSONyN4
X-Gm-Gg: Acq92OFJjzH2bde7z2Gsq3p5yK7WgzZtUrlY/GUVToTuZAwVzDCPAZdBOa3xAqGAXx7
	tlUPIKI0HMoxl4HPTmJ1Emi3sQJdt8GfvIiI6lYqXRTZ7DNM4duAtbPokfIG0ru1WG0+UmZ6Kc+
	P+i3VjJLb4TPRb81X9DIqcH6RY87UNDEyubK9UzyQFP5hN9n5FY4GwYUxizWCNRkrViMucA8vMC
	SfWa4Sf3nMSCjWRoy4osWbaU6YFwEI7uvxyl01ROxxalDXU2b1rLLMhTDgnGM6B82empowu/SCD
	eVgU+8+yxQL6zLjn5DxEUnhkALE1mwaoCi4PdfoaOFi9Q4uJ2DOVbtw8H58AuFRGgYwzzvHXcNC
	1gnpAWK4NixcqihVzD2RMDuAFvPAYifit6YH1ahdRCzynmmvWm4JiNANv2TIBsGs=
X-Received: by 2002:a05:622a:a78e:b0:50e:6135:f27d with SMTP id
 d75a77b69052e-5165a26a8dbmr215098151cf.53.1779211056616; Tue, 19 May 2026
 10:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519114355.2769474-1-edumazet@google.com> <20260519093701.582b820d@kernel.org>
In-Reply-To: <20260519093701.582b820d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 May 2026 10:17:25 -0700
X-Gm-Features: AVHnY4LuZw3yQ7YbX5eI6GqClEmSQv401uLgSi3uXLHLkhXgKR4bId40o81kOLI
Message-ID: <CANn89iLCFKFrRL72i_Jv7a4s+rQ+w8qdXn0WR+a_MaSA_4SkPg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/2] rtnetlink: RTNL avoidance in rtnl_getlink()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289543-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 7364C58300C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 19 May 2026 11:43:53 +0000 Eric Dumazet wrote:
> > Many shell scripts invoke iproute2 commands specifying a device by
> > its name.
> >
> > This series improves their performance avoiding RTNL acquisition
> > for their (repeated) name->index conversion.
>
> Hm.
>

We probably miss this.

diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259d489159c7ab5a2b206d425110b3b..92f17c270da988ca46f4cfbb4ca=
67ebecd4e7e8e
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -398,7 +398,7 @@ static void netdev_name_node_alt_flush(struct
net_device *dev)
        struct netdev_name_node *name_node, *tmp;

        list_for_each_entry_safe(name_node, tmp, &dev->name_node->list, lis=
t) {
-               list_del(&name_node->list);
+               list_del_rcu(&name_node->list);
                netdev_name_node_alt_free(&name_node->rcu);
        }
 }


> [ 1414.868166][T10284] BUG: KASAN: slab-use-after-free in rtnl_fill_prop_=
list+0x5c0/0x620
> [ 1414.868291][T10284] Read of size 8 at addr ff11000001d2c150 by task (u=
dev-worker)/10284
> [ 1414.868404][T10284]
> [ 1414.868445][T10284] CPU: 2 UID: 0 PID: 10284 Comm: (udev-worker) Not t=
ainted 7.1.0-rc3-virtme #1 PREEMPT(full)
> [ 1414.868448][T10284] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 1414.868450][T10284] Call Trace:
> [ 1414.868452][T10284]  <TASK>
> [ 1414.868453][T10284]  dump_stack_lvl+0x6f/0xa0
> [ 1414.868459][T10284]  print_address_description.constprop.0+0x56/0x2d0
> [ 1414.868464][T10284]  print_report+0xfc/0x1fa
> [ 1414.868466][T10284]  ? __virt_addr_valid+0x102/0x440
> [ 1414.868470][T10284]  ? __virt_addr_valid+0x1da/0x440
> [ 1414.868472][T10284]  kasan_report+0x108/0x130
> [ 1414.868475][T10284]  ? rtnl_fill_prop_list+0x5c0/0x620
> [ 1414.868477][T10284]  ? rtnl_fill_prop_list+0x5c0/0x620
> [ 1414.868479][T10284]  rtnl_fill_prop_list+0x5c0/0x620
> [ 1414.868480][T10284]  ? __asan_memcpy+0x3c/0x60
> [ 1414.868482][T10284]  rtnl_fill_ifinfo.isra.0+0x3d6/0x2c90
> [ 1414.868484][T10284]  ? rcu_read_lock_any_held+0x3c/0x90
> [ 1414.868487][T10284]  ? validate_chain+0x38b/0xc20
> [ 1414.868490][T10284]  ? rtnl_fill_vf+0x460/0x460
> [ 1414.868491][T10284]  ? lockdep_hardirqs_on_prepare.part.0+0x9a/0x160
> [ 1414.868493][T10284]  ? lockdep_hardirqs_on+0x8c/0x130
> [ 1414.868496][T10284]  ? __lock_acquire+0x508/0xc10
> [ 1414.868498][T10284]  ? lock_acquire.part.0+0xbc/0x260
> [ 1414.868499][T10284]  ? find_held_lock+0x2b/0x80
> [ 1414.868502][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
> [ 1414.868504][T10284]  ? mark_held_locks+0x40/0x70
> [ 1414.868505][T10284]  ? lockdep_hardirqs_on_prepare.part.0+0x9a/0x160
> [ 1414.868507][T10284]  ? lockdep_hardirqs_on+0x8c/0x130
> [ 1414.868508][T10284]  ? _raw_spin_unlock_irqrestore+0x53/0x80
> [ 1414.868510][T10284]  rtnl_getlink+0xa48/0xe50
> [ 1414.868513][T10284]  ? find_held_lock+0x2b/0x80
> [ 1414.868515][T10284]  ? rtnl_dump_ifinfo+0xfb0/0xfb0
> [ 1414.868516][T10284]  ? mark_usage+0x61/0x170
> [ 1414.868517][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
> [ 1414.868518][T10284]  ? __lock_acquire+0x508/0xc10
> [ 1414.868525][T10284]  ? lock_acquire.part.0+0xbc/0x260
> [ 1414.868526][T10284]  ? find_held_lock+0x2b/0x80
> [ 1414.868529][T10284]  ? mark_usage+0x61/0x170
> [ 1414.868530][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
> [ 1414.868531][T10284]  ? __lock_acquire+0x508/0xc10
> [ 1414.868532][T10284]  ? bpf_address_lookup+0x232/0x290
> [ 1414.868536][T10284]  ? lock_acquire.part.0+0xbc/0x260
> [ 1414.868537][T10284]  ? find_held_lock+0x2b/0x80
> [ 1414.868539][T10284]  ? rtnl_dump_ifinfo+0xfb0/0xfb0
> [ 1414.868540][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
> [ 1414.868542][T10284]  ? rtnl_dump_ifinfo+0xfb0/0xfb0
> [ 1414.868543][T10284]  rtnetlink_rcv_msg+0x6fd/0xbd0
> [ 1414.868545][T10284]  ? validate_chain+0x38b/0xc20
> [ 1414.868546][T10284]  ? rtnl_link_fill+0x920/0x920
> [ 1414.868547][T10284]  ? __lock_acquire+0x508/0xc10
> [ 1414.868549][T10284]  ? lock_acquire.part.0+0xbc/0x260
> [ 1414.868551][T10284]  ? find_held_lock+0x2b/0x80
> [ 1414.868553][T10284]  netlink_rcv_skb+0x14e/0x3a0
> [ 1414.868556][T10284]  ? rtnl_link_fill+0x920/0x920
> [ 1414.868558][T10284]  ? netlink_ack+0xce0/0xce0
> [ 1414.868560][T10284]  ? netlink_deliver_tap+0xc5/0x330
> [ 1414.868562][T10284]  ? netlink_deliver_tap+0x13c/0x330
> [ 1414.868564][T10284]  netlink_unicast+0x47c/0x740
> [ 1414.868566][T10284]  ? netlink_attachskb+0x800/0x800
> [ 1414.868568][T10284]  ? __lock_acquire+0x508/0xc10
> [ 1414.868570][T10284]  netlink_sendmsg+0x735/0xc60
> [ 1414.868572][T10284]  ? netlink_unicast+0x740/0x740
> [ 1414.868574][T10284]  ? __might_fault+0x97/0x140
> [ 1414.868577][T10284]  ? __might_fault+0x97/0x140
> [ 1414.868579][T10284]  __sys_sendto+0x2c9/0x400
> [ 1414.868582][T10284]  ? __ia32_sys_getpeername+0xd0/0xd0
> [ 1414.868586][T10284]  ? fput_close_sync+0xde/0x1b0
> [ 1414.868589][T10284]  ? alloc_file_clone+0xe0/0xe0
> [ 1414.868591][T10284]  __x64_sys_sendto+0xe4/0x1f0
> [ 1414.868593][T10284]  ? trace_irq_enable.constprop.0+0x9b/0x180
> [ 1414.868596][T10284]  ? lockdep_hardirqs_on+0x8c/0x130
> [ 1414.868597][T10284]  ? do_syscall_64+0x82/0xfc0
> [ 1414.868599][T10284]  do_syscall_64+0x117/0xfc0
> [ 1414.868600][T10284]  ? trace_hardirqs_off+0xd/0x30
> [ 1414.868602][T10284]  ? exc_page_fault+0xee/0x100
> [ 1414.868604][T10284]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1414.868606][T10284] RIP: 0033:0x7fcd4191e08e
> [ 1414.868609][T10284] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93=
 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10=
 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
> [ 1414.868611][T10284] RSP: 002b:00007ffc4c8b41c0 EFLAGS: 00000202 ORIG_R=
AX: 000000000000002c
> [ 1414.868614][T10284] RAX: ffffffffffffffda RBX: 0000557d5eaaee20 RCX: 0=
0007fcd4191e08e
> [ 1414.868615][T10284] RDX: 0000000000000020 RSI: 0000557d5eaa98e0 RDI: 0=
000000000000012
> [ 1414.868616][T10284] RBP: 00007ffc4c8b41d0 R08: 00007ffc4c8b4220 R09: 0=
000000000000080
> [ 1414.868617][T10284] R10: 0000000000000000 R11: 0000000000000202 R12: 0=
000557d5ec08060
> [ 1414.868618][T10284] R13: 00007ffc4c8b4304 R14: 0000000000000000 R15: 0=
0007ffc4c8b43a0
> [ 1414.868621][T10284]  </TASK>
> [ 1414.868621][T10284]
> [ 1414.876011][T10284] Allocated by task 10304:
> [ 1414.876091][T10284]  kasan_save_stack+0x2f/0x50
> [ 1414.876205][T10284]  kasan_save_track+0x14/0x30
> [ 1414.876286][T10284]  __kasan_kmalloc+0x7b/0x90
> [ 1414.876399][T10284]  register_netdevice+0x48b/0x1bc0
> [ 1414.876477][T10284]  geneve_configure+0x6c3/0xcf0 [geneve]
> [ 1414.876591][T10284]  geneve_newlink+0x189/0x220 [geneve]
> [ 1414.876669][T10284]  rtnl_newlink_create+0x2da/0x8c0
> [ 1414.876747][T10284]  __rtnl_newlink+0x22b/0xa50
> [ 1414.876858][T10284]  rtnl_newlink+0x8d1/0xef0
> [ 1414.876973][T10284]  rtnetlink_rcv_msg+0x6fd/0xbd0
> [ 1414.877049][T10284]  netlink_rcv_skb+0x14e/0x3a0
> [ 1414.877128][T10284]  netlink_unicast+0x47c/0x740
> [ 1414.877204][T10284]  netlink_sendmsg+0x735/0xc60
> [ 1414.877280][T10284]  __sys_sendto+0x2c9/0x400
> [ 1414.877392][T10284]  __x64_sys_sendto+0xe4/0x1f0
> [ 1414.877470][T10284]  do_syscall_64+0x117/0xfc0
> [ 1414.877547][T10284]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1414.877680][T10284]
> [ 1414.877719][T10284] Freed by task 10304:
> [ 1414.877818][T10284]  kasan_save_stack+0x2f/0x50
> [ 1414.877894][T10284]  kasan_save_track+0x14/0x30
> [ 1414.877968][T10284]  kasan_save_free_info+0x3b/0x60
> [ 1414.878084][T10284]  __kasan_slab_free+0x43/0x70
> [ 1414.878161][T10284]  kfree+0x123/0x5a0
> [ 1414.878218][T10284]  unregister_netdevice_many_notify+0xf0d/0x1f20
> [ 1414.878313][T10284]  rtnl_dellink+0x4a0/0xae0
> [ 1414.878425][T10284]  rtnetlink_rcv_msg+0x6fd/0xbd0
> [ 1414.878499][T10284]  netlink_rcv_skb+0x14e/0x3a0
> [ 1414.878577][T10284]  netlink_unicast+0x47c/0x740
> [ 1414.878657][T10284]  netlink_sendmsg+0x735/0xc60
> [ 1414.878778][T10284]  __sys_sendto+0x2c9/0x400
> [ 1414.878853][T10284]  __x64_sys_sendto+0xe4/0x1f0
> [ 1414.878928][T10284]  do_syscall_64+0x117/0xfc0
> [ 1414.879004][T10284]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1414.879098][T10284]
> [ 1414.879148][T10284] The buggy address belongs to the object at ff11000=
001d2c140
> [ 1414.879148][T10284]  which belongs to the cache kmalloc-64 of size 64
> [ 1414.879339][T10284] The buggy address is located 16 bytes inside of
> [ 1414.879339][T10284]  freed 64-byte region [ff11000001d2c140, ff1100000=
1d2c180)
> [ 1414.879521][T10284]
> [ 1414.879559][T10284] The buggy address belongs to the physical page:
> [ 1414.879689][T10284] page: refcount:0 mapcount:0 mapping:00000000000000=
00 index:0x0 pfn:0x1d2c
> [ 1414.879910][T10284] flags: 0x80000000000000(node=3D0|zone=3D1)
> [ 1414.879992][T10284] page_type: f5(slab)
> [ 1414.880053][T10284] raw: 0080000000000000 ff1100000103cac0 ffd40000002=
3ac90 ffd4000000074c90
> [ 1414.880232][T10284] raw: 0000000000000000 0000000000100010 00000000f50=
00000 0000000000000000
> [ 1414.880365][T10284] page dumped because: kasan: bad access detected
> [ 1414.880495][T10284]
> [ 1414.880534][T10284] Memory state around the buggy address:
> [ 1414.880609][T10284]  ff11000001d2c000: fc fc fc fc fc fc fc fc fa fb f=
b fb fb fb fb fb
> [ 1414.880726][T10284]  ff11000001d2c080: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
> [ 1414.880837][T10284] >ff11000001d2c100: fc fc fc fc fc fc fc fc fa fb f=
b fb fb fb fb fb
> [ 1414.880948][T10284]                                                  ^
> [ 1414.881042][T10284]  ff11000001d2c180: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
> [ 1414.881190][T10284]  ff11000001d2c200: fc fc fc fc fc fc fc fc fa fb f=
b fb fb fb fb fb
>
> decoded: https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/6=
53382/vm-crash-thr0-0

