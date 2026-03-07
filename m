Return-Path: <netdev+bounces-265158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHYyCVJfrGmlpAEAu9opvQ
	(envelope-from <netdev+bounces-265158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:24:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0222CF44
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85C6302263A
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0F30BB8D;
	Sat,  7 Mar 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxq2E/Ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37E3126B1
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904169; cv=none; b=VsEp6V0kS/gjxJcVMGqNVwUQJI4Xr6p9DuVM179gbrnzHdFSLgpyqPjxWqTMEiMUiQzeifR/lrA7uaVqGiZsmkSazId2xJ4TMqW8fGEgd70WXuZciSAYbdrehLsS40BpsRhobSAgPtW+9Fea8IzuY2SeYu9EK1xpVjog3z6giGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904169; c=relaxed/simple;
	bh=af7QvQqLrNQGcNWAKt5yRmHfomNzCzPFycDxS5z3ArQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o2mfYc2Zpe5/rSg0AWvtJ4TGjfdyZYigyNQac41Wfys0WpEiEeyHflxLWDW2WxYYFqKL7iTDzxR5vTm4QbzLOXE34LirHV5PoItYrdemxeHWJ2oIi6SzKt28k06jvXfT51nUx/CYBF+vvGZS5vDKYEXwZ+Qx9xMIxeV8Y8Ut2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxq2E/Ng; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae4816912so68473695ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772904167; x=1773508967; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/s+tATAf/2u9KLzGsf7EeCvRNOfmb2hGQnSLlFzDyM=;
        b=Yxq2E/Ng8dk/Um+5cEyn8+MgTJ+F+4fLj0bDmU+nimOaMRT9DCEgkEcwwlbVVdAldF
         w7/30eo8XGknEjJn22LT9lBgzeSdxWA0luWL/A9o9EwZLwRoZLCN/xAAvo2cNVCunk5Z
         l+md1KmZTQlxQCRlWjbRnZBjSxzAh6NIAoBnp+6HNXcv4lhCrGtRMEcISqDuKjuZB/F5
         U18RGnVyj7BGhhmHdfjasOPvmh0uCb0b5khI18yynKpwUgyp9WIiUrns0Wx+2AZSiTmM
         BPdC4pfmvluNM0PmLE8H8gJiPnf5x1rouZQ7wdz9M0i44YlVUnROLdBn130jrnbtkbOv
         YyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904167; x=1773508967;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/s+tATAf/2u9KLzGsf7EeCvRNOfmb2hGQnSLlFzDyM=;
        b=blXSQE99UzugNFLBgoyMes8zIFUYHED14JpMO1BRHrm0FPwZ697bhLKHu3xfhxDIRx
         0eau6QwreAZad9Udqxt948Lrhue85ijK7vwsLYLC/qU29qUncFhFJs7IWf7xYHupeJbS
         WGd4SZSIBe22HPRdKg/dGGXyWjJyrn1CDNFcSNZTNtWCV3giUk4aMVAx3Ik2tpErbGkN
         ig30ZuRitYfB7GXRIUfbLgyXsoR80fkAqfM9DWJ6m26thvzL1EFAPFdVNgssdPon/nxA
         mpJE8yS1pDrdKp7/5/wzCg1GHeVptKO1V1fWyBjm7Mbwg0d0/MRy+OcIBqey7XmTkLiR
         VTxg==
X-Forwarded-Encrypted: i=1; AJvYcCUiuJ+ai4Iy9LoDSPemclT0vo5VwtpqcqdOkW3/hRxePYZdSo7SbDwSwfLkv7f6EKYpTTmaBDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybkOWjYQuhyWvHm3KqlwvTtQzKpPtvZPOSVfAZ3cDT622/cp47
	b//YeEyTONyLgFWmSaf6vvHit6tvx0VykZfEU7IkhCOHai9Jz77SifnQ
X-Gm-Gg: ATEYQzwjp/9phJe0Rf2ypxKujJmDEzvetZi9RV6UEa3w0UJ1cb7rDryteTviu6H7Ox2
	K90VpD5EiZbO+IHPPn2Vo2uLEZPS2XcI50XQcoku8b6e56q6p5Lx0WQ7YAoDsjGRvy0xMSSkEli
	Nt2v3+oLYrtd0e69NTF6YJJ7xTFSlJK2LIxKM6lOasgh++Xpd5GPmxNGo/j8Xqt1MqlzXDveTKO
	9f1QVfsh44RQLcdaFHTOCP27hUhoN511MbfXzeBbmBJPo+i2d+V3DrFz+6+CW0zHXxZpsJBFIjD
	w/sQapXhpZ4Prqv5N6NJxO0DpUWPcDIFElKBoTtepa5xg7i605JBh0KNoLajO45XbuPq1OT3r4L
	kXm6YsZL9/n2skZwFY8T+Gj00VtwvJZdxA4LtOxrFW3yRLiLxuHuGsSJWkJyHiCBtncXi2CczeG
	dSaxNMJZJsEz0VgrJmlTEioFd20MXcWks3w7Om7SmPZA==
X-Received: by 2002:a17:903:3510:b0:2ae:4732:2859 with SMTP id d9443c01a7336-2ae82367aeemr63309625ad.3.1772904167005;
        Sat, 07 Mar 2026 09:22:47 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7837bsm55983555ad.48.2026.03.07.09.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 09:22:46 -0800 (PST)
Date: Sun, 8 Mar 2026 02:22:43 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] netfilter: nf_conntrack_sctp: validate state value in
 nlattr_to_sctp()
Message-ID: <aaxe43_A7rqHezJz@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: C2E0222CF44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265158-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.946];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

nlattr_to_sctp() assigns the user-supplied CTA_PROTOINFO_SCTP_STATE
value directly to ct->proto.sctp.state without checking that it is
within the valid range.  The state value is later used as an array index
in sctp_print_conntrack() (sctp_conntrack_names[state]) and
sctp_new_state() (sctp_conntracks[dir][i][state]), causing
global-out-of-bounds reads.

This is the same class of bug that was fixed for DCCP in CVE-2023-39197,
but the SCTP counterpart was missed.

Add a range check against SCTP_CONNTRACK_MAX, consistent with the
existing validation in nlattr_to_tcp() for TCP conntrack state.

KASAN report:

[    1.101351] BUG: KASAN: global-out-of-bounds in sctp_print_conntrack+0x30/0x50
[    1.101574] Read of size 8 at addr ffffffff847a5770 by task poc_sctp/131
[    1.101770]
[    1.101824] CPU: 1 UID: 0 PID: 131 Comm: poc_sctp Not tainted 7.0.0-rc2+ #6 PREEMPTLAZY
[    1.101827] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    1.101829] Call Trace:
[    1.101833]  <TASK>
[    1.101834]  dump_stack_lvl+0x64/0x80
[    1.101844]  print_report+0xce/0x660
[    1.101849]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    1.101857]  ? __virt_addr_valid+0xef/0x1a0
[    1.101863]  ? sctp_print_conntrack+0x30/0x50
[    1.101866]  kasan_report+0xce/0x100
[    1.101868]  ? sctp_print_conntrack+0x30/0x50
[    1.101870]  sctp_print_conntrack+0x30/0x50
[    1.101874]  ct_seq_show+0x392/0x7f0
[    1.101878]  ? __pfx_ct_seq_show+0x10/0x10
[    1.101880]  ? __kasan_kmalloc+0x8f/0xa0
[    1.101884]  ? ktime_get_with_offset+0xa3/0x140
[    1.101889]  ? ct_get_next+0x14e/0x190
[    1.101892]  seq_read_iter+0x292/0x7d0
[    1.101897]  seq_read+0x214/0x290
[    1.101901]  ? __pfx_seq_read+0x10/0x10
[    1.101903]  ? apparmor_file_permission+0x114/0x340
[    1.101911]  proc_reg_read+0xe4/0x140
[    1.101916]  vfs_read+0x141/0x570
[    1.101919]  ? kmem_cache_free+0x100/0x440
[    1.101924]  ? __pfx_vfs_read+0x10/0x10
[    1.101926]  ? do_sys_openat2+0xed/0x150
[    1.101930]  ? __pfx_do_sys_openat2+0x10/0x10
[    1.101932]  ksys_read+0xcc/0x160
[    1.101934]  ? __pfx_ksys_read+0x10/0x10
[    1.101936]  do_syscall_64+0xc3/0x6e0
[    1.101940]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.101944] RIP: 0033:0x41b301
[    1.101949] Code: f7 d8 64 89 02 b8 ff ff ff ff eb ba e8 e8 16 00 00 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 5d 8d 09 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[    1.101951] RSP: 002b:00007ffca1da7f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[    1.101957] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000041b301
[    1.101958] RDX: 0000000000001fff RSI: 00007ffca1da7f10 RDI: 0000000000000004
[    1.101959] RBP: 00007ffca1da7f10 R08: 0000000000000000 R09: 0000000000000000
[    1.101962] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffca1daa820
[    1.101963] R13: 00007ffca1dab988 R14: 0000000000000003 R15: 00007ffca1da9f84
[    1.101965]  </TASK>
[    1.101966]
[    1.107833] The buggy address belongs to the variable:
[    1.107977]  sctp_conntrack_names+0x50/0xc0
[    1.108107]
[    1.108155] The buggy address belongs to the physical page:
[    1.108309] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47a5
[    1.108536] flags: 0x100000000002000(reserved|node=0|zone=1)
[    1.108702] raw: 0100000000002000 ffffea000011e948 ffffea000011e948 0000000000000000
[    1.108916] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[    1.109132] page dumped because: kasan: bad access detected
[    1.109288]
[    1.109337] Memory state around the buggy address:
[    1.109476]  ffffffff847a5600: f9 f9 f9 f9 00 06 f9 f9 f9 f9 f9 f9 00 06 f9 f9
[    1.109690]  ffffffff847a5680: f9 f9 f9 f9 00 00 02 f9 f9 f9 f9 f9 00 07 f9 f9
[    1.109910] >ffffffff847a5700: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 f9 f9 f9
[    1.110118]                                                              ^
[    1.110309]  ffffffff847a5780: f9 f9 f9 f9 00 00 00 07 f9 f9 f9 f9 00 00 00 00
[    1.110515]  ffffffff847a5800: 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
[    1.110720] ==================================================================

Fixes: a258860e01b8 ("netfilter: ctnetlink: add full support for SCTP to ctnetlink")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 7c6f7c9f7332..cbee99be7b5e 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -612,6 +612,9 @@ static int nlattr_to_sctp(struct nlattr *cda[], struct nf_conn *ct)
 	    !tb[CTA_PROTOINFO_SCTP_VTAG_REPLY])
 		return -EINVAL;
 
+	if (nla_get_u8(tb[CTA_PROTOINFO_SCTP_STATE]) >= SCTP_CONNTRACK_MAX)
+		return -EINVAL;
+
 	spin_lock_bh(&ct->lock);
 	ct->proto.sctp.state = nla_get_u8(tb[CTA_PROTOINFO_SCTP_STATE]);
 	ct->proto.sctp.vtag[IP_CT_DIR_ORIGINAL] =
-- 
2.43.0


