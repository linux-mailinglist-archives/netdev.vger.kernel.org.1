Return-Path: <netdev+bounces-296439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yUjoFZ2OJmrNYgIAu9opvQ
	(envelope-from <netdev+bounces-296439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:42:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B80654B00
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:42:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296439-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296439-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96F3730160C5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E03955C8;
	Mon,  8 Jun 2026 09:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0B3A5E6C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:41:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911702; cv=none; b=MZWHGzSuZU7LYmsDeNqsdyJHPg0GKQSKBoVrq+FYSjK4Vx36bB3FTD6/iYfEJeHe56HcCJDc9yK6qc9KthSFz/khZ/Iw/2YXbet9UIiUtFTNI4s4JlLeuSuZVLyiAHU/OdvCAqivmBm626u2aGumDu/81OdBgsE5vAm5YKn0r9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911702; c=relaxed/simple;
	bh=hxOJB95RPFMrsIw+XhzBYvCQTt00VWyn4pWJ9zKhFSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MQF6LfeUhp3SkzuNTOlrS0nG1cAi0frWXSCUB47kikrhH0itVDNSzD01/v8S34f+pUTSpC653+XYSWDNqbjQlt6r1TtTalrsi0UZKTdFE09geWOeo1PQ3cooLazukxEH2RnfabG95EwKYZnc/fD8owYjOCxgVg5MPoQcha8A8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b9318997so29584345e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 02:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911699; x=1781516499;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwxjOozLbsXWexosbR1qxKK1J54ucoEooJd0V8vXWck=;
        b=mvAjY+ZOxU0VqlKsfYuJQFLa6XQ+wfnXE99mSuSl6o2riwFzpcXybl2GSThkB9cb9o
         tL1QVT1S7xymVQDx465RnN8VYpS3JJqhqNnMmeT7XuTx+Q8FMjuluVw4RYVfYWIbx6Qt
         V0tTa5JgI+RFSWyLZfsODOCiqQyel8MUTXPY2uvHjFdrzlDuGmCa+ixI7v4YyuJFiAMO
         n0+ihIxAD6Z5EP5if2e5GFMXPWcp+i92R4P0Gn3bC8wes9KpeB2PeqnMuZddYchJCTco
         Bdq2iuH4OyzE9AG2PpP7e0ZX9UKpT5kE6yARhwhDwHUknm2E5WEPmuSLXzCWZT8gHqGh
         uNrA==
X-Forwarded-Encrypted: i=1; AFNElJ9QGrjQZO3hRDI+furDtSoFBMjxXHOtYxZSuylfO1wshiIHvZm/jJG1SK0F9Qhjw9RUB1L12ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58x2RLYX/FQDiyKXOz2nRAAjL1r5/94Cw6EsGoItMtVjf0/D9
	Qo+aSlVNGcYNxk5+SY7NY86Rzi9XZSXuWuLN30jGBHdhHZCOw31bn3Tt2y9MUS33
X-Gm-Gg: Acq92OEVZVcyOT6Ur8TQvYW2fWfxtVltuYS2M15kIavIokiuSJJ1t44ivrDdSMsQing
	qlB3J5OAzg+hZhwkJP/ksgperARpqWZA6ORQChGrWeJj5uq27vq7IgI9KWgShygbwxEc40nYHgl
	SBqeo5zTJCit5gcjCxuopLeMYiGnbJgFJR4AlYwmCGK1tMvkfFdMAz5J2wJKWADnnQfi0JaKokd
	rEMcKa/WlbnzYTSQo4/m1S3loxMPnVfQq2yqWJDzvVG/WrUqjRwS9NP3eO/TXabZNI3z5y6ewJ5
	ki38LGe5jZTKHcuGfdSb7eIJnuMTQ4FwqQIPPHickSsdZnXkljF/RP8n7XHKvCyn9wjGHR2BYX4
	5K+1nDZh42AocmdXSi9q9dx5BaaVBkySXL57vuklrie8YadOAj4X3y7i/e640LFyx2QSrKgs/Rv
	Ufw0qKGZBVWuMM9KV0f4DCUWPRuaAiDwYV4gwsFNVl3jz+WKzAOPD4uiam/kH6b2Oiug==
X-Received: by 2002:a05:600c:8712:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490c25f17dfmr262633275e9.17.1780911699363;
        Mon, 08 Jun 2026 02:41:39 -0700 (PDT)
Received: from [192.168.88.241] (89-24-35-102.nat.epc.tmcz.cz. [89.24.35.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm387695335e9.7.2026.06.08.02.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:41:38 -0700 (PDT)
Message-ID: <18972686-936d-4fb0-850f-7e212c48ab97@ovn.org>
Date: Mon, 8 Jun 2026 11:41:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from
 geneve_xmit()
To: Johan Thomsen <write@ownrisk.dk>, netdev@vger.kernel.org,
 dev@openvswitch.org
References: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Cc: i.maximets@ovn.org, Kees Cook <kees@kernel.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296439-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS(0.00)[m:write@ownrisk.dk,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:i.maximets@ovn.org,m:kees@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ovn.org:from_mime,ovn.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4B80654B00

On 6/8/26 10:25 AM, Johan Thomsen wrote:
> Hello,
> 
> I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
> transmit path on a Talos Linux node running Kube-ovn with Geneve
> overlay and KubeVirt VM traffic.
> 
> Environment:
> 
> Kernel: 6.18.33-talos
> Distro: Talos v1.13.3
> 
> Compiler/config:
> 
> CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
> CONFIG_CC_IS_CLANG=y
> CONFIG_LTO=y
> CONFIG_LTO_CLANG=y
> CONFIG_LTO_CLANG_THIN=y
> CONFIG_FORTIFY_SOURCE=y
> 
> Hardware: HPE ProLiant DL325 Gen11, AMD EPYC
> 
> NIC driver: bnxt_en
> 
> Workload/network:
> 
> Kube-OVN, Geneve overlay
> Open vSwitch datapath
> KubeVirt/QEMU VM traffic via vhost/tap
> 
> Relevant console output:
> 
> [  648.742603] memcpy: detected buffer overflow: 104 byte write of
> buffer size 96
> [  648.749907] WARNING: CPU: 61 PID: 27020 at
> lib/string_helpers.c:1036 __fortify_report+0x45/0x60
> [  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
> nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
> nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
> [  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
> tainted 6.18.29-talos #1 PREEMPT(none)
> [  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
> Gen11, BIOS 2.84 11/05/2025
> [  648.890478]  skb_tunnel_info_unclone+0x179/0x190
> [  648.895152]  geneve_xmit+0x7fe/0xe00
> [  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
> [  648.911479]  __dev_queue_xmit+0x864/0xf40
> [  648.919688]  do_execute_actions+0x9b9/0x1be0
> [  648.927727]  ovs_execute_actions+0x58/0x170
> [  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
> [  648.936370]  ovs_vport_receive+0x90/0x100
> [  648.940428]  netdev_frame_hook+0x146/0x1a0
> [  648.954093]  __netif_receive_skb+0x3f/0x160
> [  648.958324]  process_backlog+0x10c/0x210
> [  648.962295]  __napi_poll+0x2f/0x190
> [  648.965832]  net_rx_action+0x2e3/0x500
> [  648.969632]  handle_softirqs+0xe7/0x310
> [  648.985387]  tun_get_user+0x137e/0x1510
> [  649.005878]  handle_tx+0x41f/0xd30
> [  649.029014]  vhost_run_work_list+0x52/0x90
> [  649.033162]  vhost_task_fn+0xc2/0x140
> [  649.064145] ---[ end trace 0000000000000000 ]---
> [  649.068820] ------------[ cut here ]------------
> [  649.073489] kernel BUG at lib/string_helpers.c:1043!
> 
> I don't know whether this is a real overflow or a FORTIFY false-positive.

Looks like a false-positive from the __counted_by fortification.

I'd guess something like this would fit it:

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f9..e51c3795da474 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -164,6 +164,7 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 	if (!new_md)
 		return ERR_PTR(-ENOMEM);
 
+	new_md->u.tun_info.options_len = md_size;
 	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
 	       sizeof(struct ip_tunnel_info) + md_size);
 #ifdef CONFIG_DST_CACHE
---

Johan, could you try this in your setup?

The memory was actually allocated for the options, but the structure
is zeroed out on allocation, so the __counted_by check doesn't work
properly for the initial initialization copy.

But the operation in the diff above is kind of pointless as the memcpy
itself will copy the value again.  So, I'm not sure if that's the right
solution here.

Alternative might be to revert the kmalloc_flex back to the simple
kmalloc in metadata_dst_alloc.

CC: Kees

Best regards, Ilya Maximets.

> 
> I cannot reproduce the issue on Talos v1.12.X which uses a gcc built
> kernel, whereas the affected kernel is built with clang. Don't know
> whether this is relevant here.
> 
> I am currently trying to make a reliable reproducer, but I can almost
> always trigger the issue when iperf stressing the VM-network.
> 
> Please let me know if this should go to a more specific
> maintainer/list or further info is needed. I am able to test candidate
> patches if provided.
> 
> Downstream bug reports:
> https://github.com/siderolabs/talos/issues/13440
> https://github.com/kubeovn/kube-ovn/issues/6767
> 
> Thanks,
> Johan


