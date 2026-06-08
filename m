Return-Path: <netdev+bounces-296413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id phVqJNx8Jmo1XQIAu9opvQ
	(envelope-from <netdev+bounces-296413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:27:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B2654056
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:27:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownrisk-dk.20251104.gappssmtp.com header.s=20251104 header.b=IV1DIX8g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296413-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296413-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFD12300827B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF333AC0C0;
	Mon,  8 Jun 2026 08:25:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3338888F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:25:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907154; cv=pass; b=Wd5ewn6zTz+sv+u18XjNrJ0Yv/PRdB1FJ6n4bwrmH6zjRMdLIjAcrVq73lbGNmxzA2+dM/mTHUACS1aCDa/Y8mO0yyDO62JtsKe9Qes7zqrTSndxb9KflZ/gSCgsNvXOe8z80A4BPbUd3d1D2fC0cX1KjlrH62uTNMepKM8rbP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907154; c=relaxed/simple;
	bh=z5nt8eKiVetZfIfLo4ExtHmB4orzc6e86FnQlvra7E4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jdTGBTw+k/5x0A1VAgvGlysyyG7WqNHWRM64gS7jNT6jWPkLrMRv/xUTumWbKlnvsL0mnXScN0Ggiqspr5fw5FZNgkJgezXnr+5JWxVFZ/+ANu7Ek+lRzjqMvuupfnCneLb028kfzikmKuhQLjTxaJADiN6V95DGhpzSHLOuTzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ownrisk.dk; spf=none smtp.mailfrom=ownrisk.dk; dkim=pass (2048-bit key) header.d=ownrisk-dk.20251104.gappssmtp.com header.i=@ownrisk-dk.20251104.gappssmtp.com header.b=IV1DIX8g; arc=pass smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccf01ba514so34575146d6.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 01:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780907151; cv=none;
        d=google.com; s=arc-20240605;
        b=UVGdnvC2jWFYGuuISyJxgodQ156I306sv92P1vVx4HbhxDDq7AGnkHojPzass8PU5i
         wE1YtjqJHxe3YFmRMbu1wPOEr8dB2Th/1Veg2lOupkCZlGhWb+DiMoBaZVZH42rAjl0l
         F5LJmgCYpMSu28tSDt6umEUC7NUlEgeHk3FaJt01OeNVeSlzWqn37JSlfxNEL77STGWY
         ISamS3x+pPwSm3hcSqtvFXLwjbkTc7FWOdqeVlIRXNkTQIN+KsFyts75jZod6dWS0dNh
         bJkhU9MxHP8gMU6ZpvAz5vHK/14y2D46hILThYWOlVjQGC7Jsy5kOLmtYA4VKjVDeJAU
         qPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YaFy5esnyok8WqnLe4Ih8u4DSt7NadOjtLhgcBogIYE=;
        fh=UBZvj+18aN7kijGQQRitedK8SDTWlPjUHIcCKBaYuxM=;
        b=PIskoYwc/NMUnwIhoaHYNlbgIc8QgQgkTIPZvR1poLTXMvYT1UqFRHkkntqIgfPVy9
         53WQ9OyfrxJRmCbsP3cB85IesKawjen+3ERFewFACTp8kOziI0ag5dU7mguuRmSAyAUH
         Tm+Xzv4bft7tpCFnErgTyNXaZ6tJLMNdTYxuLQkzez9EZdq85iJWiYRjfJL9bPHKVOet
         Q47HGGGr9YjdVJ4FgPebqNZiKHKYL0jTu5AG04YHpDVrsVbolkg4WNPRlEW+fKLH2WLR
         jAshcnDbYOX5g4+QPvGfbrWqabLqC/bdBJm7Ij+WsBKlTIgCt1lVumBlTkjbJgKZlg8u
         1mcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ownrisk-dk.20251104.gappssmtp.com; s=20251104; t=1780907151; x=1781511951; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YaFy5esnyok8WqnLe4Ih8u4DSt7NadOjtLhgcBogIYE=;
        b=IV1DIX8gZaCMQ32NRDnvJBOBHDGmOA66SEuwdJJczGaELfYooUlp4ez6LhwYw7rYzE
         lXH8P6RdceUBrdSfAyttuBZzsHYAoOs66v3I7bWcl1RZXrUi1O9Ktn6wCkxmB6P8qSSP
         WcVMh60EjOTBTeQ+GAySmiq0rDjzfKsZUu5PNzPlNub0qktC2oC3OV4GE5Ko2ZkIt8wO
         4lStkzsldo6etagIlexIux0J1g4uxQRXHlxJNsw4xZ6DXSkrlDbdpGOT8fB/lQpyZHCk
         WqxEwpxzKi/rcnRHpCma8zV2FGBb3JLvCIhaeXzrni7YndSvykkYKocKQPBn35DcdFff
         rDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907151; x=1781511951;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaFy5esnyok8WqnLe4Ih8u4DSt7NadOjtLhgcBogIYE=;
        b=N2KEFDC5r9qeJrOE0+Iy1BS2DPqHTGzLpxfdVQMespz1magT5Yz6cc5NEcbOp1YAqU
         H5EVN0kWVphpFVwu/D7isgfc8BYuqFtQR2PCfNz7wzDOMTRjgsZxQhAfRBs4E3JdkEEm
         QhIkchb0KGE17tLvc4T2o5gaIy5cFlhUuRKqFmXERea0rs16T9t/s+I0+WyhJiiqEpUM
         mAyUVolh3BiE9Dzg6t1yiJvL7V0fNv1ipDUr4fH6196EbzJ+sH0zQZglXEZDIYN6GXmO
         0L+4yD2dUQbpd0XE10hmSiwFWXH1mFjo6wApLBtP6mc+RgyE3hwOboVxYJc1JY288ssz
         OJiA==
X-Gm-Message-State: AOJu0YyAIybjnioWjWh3pos+f5AwwIw925iF63LTLUmAHyGnl+lZRKqd
	2ukBa1g2ViQomk5EuRmy4lrl30vxXFpitQBL9F9twjKYxg/TApYlYtUVnsEwjPB13fMdpAmQw2/
	Gku47g3arwHaaaa0Xg2zbNGkn6wWR7WjFKp/8Ao3VFs89LTlJxiywxOM=
X-Gm-Gg: Acq92OHDLbHu2bmkAkAbtCnguc3shFmpfIGuc005WxUMW/KohoXRVfJe80Y+kUvQmkV
	6ZAaN1yt3vAci3ndPjCb1swMoM/XuwBWAM1BjkW+DzWbxyuWSqgJJqnONnYcD1BfRqaleOs9Oke
	lgTq/Yoy++kfpBuJvEbP/uvzthJKwLdldbZQh00ognegWNfVfFxpYLSCqfL+4+DL/3mIJ1nPBJt
	TMmVm57Cc5PAR2X5FCGQjakpdW9n7ZaNloxw9fKj2LXMfNYhRJgDxBcNEOZerfVx6eCdcBER1fO
	JxGMAxr2yD989j4f/A1XViAsxQa2W9u248shpuMMr6eDMSTi
X-Received: by 2002:a0c:cdc8:0:b0:8ce:b132:5089 with SMTP id
 6a1803df08f44-8cee6023208mr152940096d6.24.1780907150834; Mon, 08 Jun 2026
 01:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Johan Thomsen <write@ownrisk.dk>
Date: Mon, 8 Jun 2026 10:25:39 +0200
X-Gm-Features: AVVi8Cc18J1dRa2h8TdwSuestEztloH2cNGiXgQdeVMY_y9ufi2hNwhQQKnzt2U
Message-ID: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
Subject: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from geneve_xmit()
To: netdev@vger.kernel.org, dev@openvswitch.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownrisk-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dev@openvswitch.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296413-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ownrisk.dk];
	FORGED_SENDER(0.00)[write@ownrisk.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ownrisk-dk.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[write@ownrisk.dk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ownrisk-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 237B2654056

Hello,

I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
transmit path on a Talos Linux node running Kube-ovn with Geneve
overlay and KubeVirt VM traffic.

Environment:

Kernel: 6.18.33-talos
Distro: Talos v1.13.3

Compiler/config:

CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
CONFIG_CC_IS_CLANG=y
CONFIG_LTO=y
CONFIG_LTO_CLANG=y
CONFIG_LTO_CLANG_THIN=y
CONFIG_FORTIFY_SOURCE=y

Hardware: HPE ProLiant DL325 Gen11, AMD EPYC

NIC driver: bnxt_en

Workload/network:

Kube-OVN, Geneve overlay
Open vSwitch datapath
KubeVirt/QEMU VM traffic via vhost/tap

Relevant console output:

[  648.742603] memcpy: detected buffer overflow: 104 byte write of
buffer size 96
[  648.749907] WARNING: CPU: 61 PID: 27020 at
lib/string_helpers.c:1036 __fortify_report+0x45/0x60
[  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
[  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
tainted 6.18.29-talos #1 PREEMPT(none)
[  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
Gen11, BIOS 2.84 11/05/2025
[  648.890478]  skb_tunnel_info_unclone+0x179/0x190
[  648.895152]  geneve_xmit+0x7fe/0xe00
[  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
[  648.911479]  __dev_queue_xmit+0x864/0xf40
[  648.919688]  do_execute_actions+0x9b9/0x1be0
[  648.927727]  ovs_execute_actions+0x58/0x170
[  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
[  648.936370]  ovs_vport_receive+0x90/0x100
[  648.940428]  netdev_frame_hook+0x146/0x1a0
[  648.954093]  __netif_receive_skb+0x3f/0x160
[  648.958324]  process_backlog+0x10c/0x210
[  648.962295]  __napi_poll+0x2f/0x190
[  648.965832]  net_rx_action+0x2e3/0x500
[  648.969632]  handle_softirqs+0xe7/0x310
[  648.985387]  tun_get_user+0x137e/0x1510
[  649.005878]  handle_tx+0x41f/0xd30
[  649.029014]  vhost_run_work_list+0x52/0x90
[  649.033162]  vhost_task_fn+0xc2/0x140
[  649.064145] ---[ end trace 0000000000000000 ]---
[  649.068820] ------------[ cut here ]------------
[  649.073489] kernel BUG at lib/string_helpers.c:1043!

I don't know whether this is a real overflow or a FORTIFY false-positive.

I cannot reproduce the issue on Talos v1.12.X which uses a gcc built
kernel, whereas the affected kernel is built with clang. Don't know
whether this is relevant here.

I am currently trying to make a reliable reproducer, but I can almost
always trigger the issue when iperf stressing the VM-network.

Please let me know if this should go to a more specific
maintainer/list or further info is needed. I am able to test candidate
patches if provided.

Downstream bug reports:
https://github.com/siderolabs/talos/issues/13440
https://github.com/kubeovn/kube-ovn/issues/6767

Thanks,
Johan

