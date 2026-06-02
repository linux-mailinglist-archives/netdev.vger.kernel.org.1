Return-Path: <netdev+bounces-294373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V17HFs0sH2qfiQAAu9opvQ
	(envelope-from <netdev+bounces-294373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:19:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A44786315AA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ja1x9MBU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294373-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91BE13007CB2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835D3812F7;
	Tue,  2 Jun 2026 19:12:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511F326D51
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:12:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427569; cv=pass; b=hNPJqjUgcjrx8DNNbqRITAmeoN9NVAFY8kSVui3HUagiUNMWMlAnR8VqVaThDfoBptTuo1GtmITVtbTe1rUDXJNGnuVHzeJ3F/puG+CI529XEsu8AnBv0nNtsINbDPUot0xA6+rk1enxB8bHGsvqIB0Yb02BdvabaU5XlukMVYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427569; c=relaxed/simple;
	bh=o0KLcIMB1q5g7VGj3gHCG9gj2UyyvXNJ/pOxwflLCgg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KaLdGt+NnI51lJdfmMiVkRZoRT80V50f0wav7qxvr/tXO7Z8wwddda8X6bu5fujsYfAAA2gAOK6ocegtUF7F221vzeWTKHh6m4jJe2Jcxfy5ZD6qyjkUotlGU+YuHxmnu2r065s2AkPYXVytfeK+gNL/uqhQKd5Qk0LXwyoQuWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja1x9MBU; arc=pass smtp.client-ip=209.85.161.50
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69dead44101so4078282eaf.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780427567; cv=none;
        d=google.com; s=arc-20240605;
        b=W8Ol+HTPipyVsFQJMxjMy3GEKxRu4wI8HrHc/KgK9GrZQ/xKF/KVi96UBpnWN4mRNx
         D8XeStqldHW9Ar85zlr+anqmzqh73ohAWPSoFj3KleHy8Eixf5NsnuL4eggxCkbTLyIu
         XpH6Y/RILqKH8PxHRWbIZcu142B2YkX8gd0a0BCYnnCTcVdSvZMZHAg2V5MgbYtNrWoM
         sKx7EFStCdy3GGbvaj/iH1wvrk4YMqT4JNWQ4LVLt4cv5bkpqrW/noZpjHifml0R8sVD
         JD6JpE0H+f5T+jn5WmD/zUBpHOpo/SfLk9aCE/ug2VApDh4HzSjCRKrthehM9NVY6Kk0
         rWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hX/0DAg0UnVhxFAC8TYrK8rmWr1n65P7KNfnUICCOPQ=;
        fh=g1CydaXfqeOjg9HProhV2xTKD6hMlWW7ndsCIVeoNyc=;
        b=Z9n9o7aZ7jH1MQ6zFcR/ClcvCc7T2OJlv6yO1BzERd6/UyIoo9Ne+IuuU5Je8j85VL
         3/D8OeMVXu0pqoIgAKFcAMUEV1HP4FejqC7iW2+butrXlZ7m/Z6VzXnx8tMobU0ZagJY
         u3+CG8uCZ7+sl2hwtNRkIgok6Oi7Ad0i+eg2fTn3Wgg46uypNbjikois4hSTK53oWz8O
         jXMm+k8AKGosmgND0RVSDLcaFt8ZbbrZCMgDknx2n4OhQ7nEGxN9H1RYaH998ZwV44L+
         y49Pmae5nj9BhhPl5/xi+rymOVMyW8LZ63OBKMw5tM+pt9ckUsm0YuXLHBTAL8bDNqAK
         9FKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780427567; x=1781032367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hX/0DAg0UnVhxFAC8TYrK8rmWr1n65P7KNfnUICCOPQ=;
        b=ja1x9MBUM6a7nTwMbJcE/0VxAYDPDKThy8PLruj3R2LqEFhmmHqEAh1sac9IyL/t3g
         IvprT73M8bSGhOALYJhLprAm9MuA2wkSaClvtZd+qWjChqpXyIg17kUhLyLwOFSJauo0
         gsm1jvGK03mJSqqI/sO4v7YqxKEcSPzDhxLtBgGUQkdQs6cH8MrPloqIca13zitppp3J
         0J23dCKI07q4h/JWFrXq8wnG/fCEsWDGJJZQ36sHM8jIbHgxjpO/Y0bFMsAbEpo38294
         8gJdAjbN2LJ5cK5qNJlD6Is4UheNxQXo2BJn8s3Qjkh2TEZ1YLH69LnMm1OTkg2Bee0g
         kDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427567; x=1781032367;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX/0DAg0UnVhxFAC8TYrK8rmWr1n65P7KNfnUICCOPQ=;
        b=UNb55aaXhxJKIFuLaU4XERtCpY1TqytfqxyQ/QjR5kyiv12kuXl6bDnokoj/6Aqdpk
         M2EXRs77iGGeEv6xf08iGV7dpqFaxICMxUtupUE0W/gLp02y4DbrQ7Pz8N4D+7bvftIG
         5U9mNJ3DY6f6JYewYaHKtbvyPMEiJ65mqvlUc1V6K1ectYSqRdiHnuf7v5PW0IvZCaV8
         u63k81tHkTMeREu2Wpsdh87I6fpI8Nnwlxxh6/quTOcMHBm+E23cjMJf7nA6H3wNWleg
         4bf7fV86XhhHL4Xq/lwj6MNESLYNp+mKYDGgU7XorQ/T7fFlZa1ICqRs98AYK+YD7GbR
         sOqA==
X-Gm-Message-State: AOJu0Yz6/7lN8tV11rx8Nub26DT86++5G0lBTArQufYMXuY/r9T0jMko
	jsz70j+PMkdKERc3boCNW8a2h5dLDp+/4AOuOhxDVfD/BdzoV+YuWdPJ6nhqCIPiRisdteae10G
	dotl+/pEOA4gDe7eYMy/xRw6EbI0bf88=
X-Gm-Gg: Acq92OFSBue8G4XTpGtJFwz2prqh5icH3Lm42vdgnIgyEFu9xsYnH/t6ABwv9jw/b7V
	EJFX0pDACKcbOcozZAJhbtTZd31LwfB2o3WXAaGgJXMiqRExFIXpaWDlK5G37C8+gJ21rBKcc7v
	2nhf7Dz2M8zxVkWNK0YoDgmek+zgQSJ/Yv3a7M3EgdIzRZkCPW/TRi7YCBQ55xtvrdOhuNxHOKc
	YzE6ckFN6pxRsjEJyVQ4iWQQuT4ktA5t9B+YQG3Xq5JeaGIib4X9w6zdCEn36ptGhu0qPMN117z
	ovfHz/tFS6Whpu/pUrk=
X-Received: by 2002:a05:6820:8587:10b0:67e:3f0d:4235 with SMTP id
 006d021491bc7-69e47e661b6mr188633eaf.11.1780427567169; Tue, 02 Jun 2026
 12:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anirudh Gupta <anirudhrudr@gmail.com>
Date: Wed, 3 Jun 2026 00:42:34 +0530
X-Gm-Features: AVHnY4KjswBhE_E5QdnKGHs8Fqh64S5UnwjK8BbwTNDl8NR1_yQzBJBVKBpl-Cg
Message-ID: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
Subject: [BUG] net/sched: HFSC + fq_codel stall on 6.6.116 (qdisc_tree_reduce_backlog
 / qlen_notify)
To: "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Anirudh Gupta <Anirudh.gupta@sophos.com>
Content-Type: multipart/mixed; boundary="000000000000b0c55406534a1808"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[sh:text/x-sh];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-sh];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiyou.wangcong@gmail.com,m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:Anirudh.gupta@sophos.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,mojatatu.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[anirudhrudr@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudhrudr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294373-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A44786315AA

--000000000000b0c55406534a1808
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Linux 6.6.116 can permanently stall traffic under this qdisc tree on ifb0:
         HTB =E2=86=92 prio =E2=86=92 HFSC (class 1:a, RT 320Kbit) =E2=86=
=92 fq_codel

Symptom:
  tc -s shows hfsc/fq_codel backlog stucks while Sent byte/packet
counters do not increase for 30+ seconds. No kernel oops.

Steps to reproduce:
1) Use attached script =E2=80=98apply_tc_tree.sh=E2=80=99 to create the req=
uired tc qdisc tree.
2) Send bulk short lived tcp connections, on the interface whose
traffic is mirred to ifb0 interface for rate limiting.
3) Observe that the sent bytes in class statistics get stuck, while
the backlog counter keeps on increasing -


---captured output---
kabir@KABIR-CL-2:~$ date
Tue Jun  2 06:29:11 AM UTC 2026
kabir@KABIR-CL-2:~$ cat /proc/version
Linux version 6.6.116-0606116-generic (kernel@balboa)
(x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld
(GNU Binutils for Ubuntu) 2.42) #202511021338 SMP PREEMPT_DYNAMIC Sun
Nov  2 14:08:04 UTC 2025
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ uname -a
Linux KABIR-CL-2 6.6.116-0606116-generic #202511021338 SMP
PREEMPT_DYNAMIC Sun Nov  2 14:08:04 UTC 2025 x86_64 x86_64 x86_64
GNU/Linux
kabir@KABIR-CL-2:~$ tc -s qdisc show dev ifb0 | tee /tmp/stall-before.txt
qdisc htb fffe: root refcnt 2 r2q 10 default 0x1 direct_packets_stat 0
direct_qlen 32
 Sent 80337622 bytes 937086 pkt (dropped 4541, overlimits 4505 requeues 0)
 backlog 27760b 171p requeues 0
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 80338354 bytes 937034 pkt (dropped 4541, overlimits 0 requeues 0)
 backlog 27760b 171p requeues 0
  maxpacket 7570 drop_overlimit 0 new_flow_count 3438 ecn_mark 0
memory_used 639744
  new_flows_len 7 old_flows_len 1
qdisc prio fffd: parent fffe:1 bands 8 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0
 Sent 80337622 bytes 937086 pkt (dropped 4541, overlimits 0 requeues 0)
 backlog 27760b 171p requeues 0
qdisc hfsc 1: parent fffd:1 default fffc
 Sent 80337622 bytes 937086 pkt (dropped 4541, overlimits 1879582 requeues =
0)
 backlog 27760b 171p requeues 0
qdisc fq_codel 9: parent 1:9 limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
  maxpacket 0 drop_overlimit 0 new_flow_count 0 ecn_mark 0
  new_flows_len 0 old_flows_len 0
qdisc fq_codel fffc: parent 1:fffc limit 10240p flows 1024 quantum
1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 2296 bytes 54 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
  maxpacket 70 drop_overlimit 0 new_flow_count 2 ecn_mark 0
  new_flows_len 0 old_flows_len 2
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ tc -s class show dev ifb0 | grep -A6 "hfsc 1:a" |
tee /tmp/stall-class-before.txt
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 80335326 bytes 937032 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 27760b 171p requeues 0
 period 7484 work 80335326 bytes rtwork 53590324 bytes level 0
class hfsc 1:fffc parent 1:1 leaf fffc: rt m1 0bit d 0us m2 8Kbit ls
m1 0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 800Mbit
 Sent 2296 bytes 54 pkt (dropped 0, overlimits 0 requeues 0)
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ sleep 30
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ date
Tue Jun  2 06:30:39 AM UTC 2026
kabir@KABIR-CL-2:~$ tc -s qdisc show dev ifb0 | tee /tmp/stall-after.txt
qdisc htb fffe: root refcnt 2 r2q 10 default 0x1 direct_packets_stat 0
direct_qlen 32
 Sent 80337748 bytes 937089 pkt (dropped 4541, overlimits 4505 requeues 0)
 backlog 28204b 177p requeues 0
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 80338354 bytes 937034 pkt (dropped 4541, overlimits 0 requeues 0)
 backlog 28204b 177p requeues 0
  maxpacket 7570 drop_overlimit 0 new_flow_count 3438 ecn_mark 0
memory_used 669696
  new_flows_len 7 old_flows_len 1
qdisc prio fffd: parent fffe:1 bands 8 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0
 Sent 80337748 bytes 937089 pkt (dropped 4541, overlimits 0 requeues 0)
 backlog 28204b 177p requeues 0
qdisc hfsc 1: parent fffd:1 default fffc
 Sent 80337748 bytes 937089 pkt (dropped 4541, overlimits 1879731 requeues =
0)
 backlog 28204b 177p requeues 0
qdisc fq_codel 9: parent 1:9 limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
  maxpacket 0 drop_overlimit 0 new_flow_count 0 ecn_mark 0
  new_flows_len 0 old_flows_len 0
qdisc fq_codel fffc: parent 1:fffc limit 10240p flows 1024 quantum
1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 2422 bytes 57 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
  maxpacket 70 drop_overlimit 0 new_flow_count 2 ecn_mark 0
  new_flows_len 0 old_flows_len 2
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ tc -s class show dev ifb0 | grep -A6 "hfsc 1:a" |
tee /tmp/stall-class-after.txt
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 80335326 bytes 937032 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 28204b 177p requeues 0
 period 7484 work 80335326 bytes rtwork 53590324 bytes level 0
class hfsc 1:fffc parent 1:1 leaf fffc: rt m1 0bit d 0us m2 8Kbit ls
m1 0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 800Mbit
 Sent 2422 bytes 57 pkt (dropped 0, overlimits 0 requeues 0)
kabir@KABIR-CL-2:~$
---captured output end ---

Notice that, only backlog increased for class hfsc 1:a from 'backlog
27760b' to 'backlog 28204b', however, sent bytes remained stuck at
'Sent 80335326 bytes 937032 pkt'
Existing connections get stalled, and new connections never get established=
.

This was working fine till v6.6.49, and I started to notice it once I
moved to v6.6.116.
Suspected commits introduced in 6.6.49..6.6.116:
    2f9761a94bae codel: remove sch->q.qlen check before
qdisc_tree_reduce_backlog()
    f680a4643c6f net/sched: Always pass notifications when child class
becomes empty

Analysis: fq_codel calls qdisc_tree_reduce_backlog() when child qlen=3D=3D0
  after codel drops; hfsc_qlen_notify() removes class from eltree while HFS=
C
  still has queued packets; subsequent enqueues do not re-activate the clas=
s.

Workaround: reverting commit 2f9761a94bae
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?i=
d=3D2f9761a94bae)
alone fixes the stall on the same repro steps.

Regards
Anirudh Gupta

--000000000000b0c55406534a1808
Content-Type: text/x-sh; charset="UTF-8"; name="apply_tc_tree.sh"
Content-Disposition: attachment; filename="apply_tc_tree.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mpx0ah9p0>
X-Attachment-Id: f_mpx0ah9p0

I2xvYWQgcmVxdWlyZWQga2VybmVsIG1vZHVsZXMKc3VkbyBtb2Rwcm9iZSBpZmIgYWN0X21pcnJl
ZCBzY2hfaHRiIHNjaF9oZnNjIHNjaF9mcV9jb2RlbCBjbHNfdTMyIHNjaF9pbmdyZXNzCgpERVY9
ZW5YMgojIE1pcnJvciBhbGwgaW5ncmVzcyBvbiBERVYgdG8gaWZiMApzdWRvIHRjIHFkaXNjIGFk
ZCBkZXYgJERFViBoYW5kbGUgZmZmZjogaW5ncmVzcwpzdWRvIHRjIGZpbHRlciBhZGQgZGV2ICRE
RVYgcGFyZW50IGZmZmY6IHByb3RvY29sIGFsbCB1MzIgbWF0Y2ggdTMyIDAgMCBcCglhY3Rpb24g
bWlycmVkIGVncmVzcyByZWRpcmVjdCBkZXYgaWZiMAoKSUZCPWlmYjAKc3VkbyB0YyBxZGlzYyBk
ZWwgZGV2IGlmYjAgcm9vdCAyPi9kZXYvbnVsbAoKRlE9ImxpbWl0IDEwMjQwIGZsb3dzIDEwMjQg
cXVhbnR1bSAxNTE0IHRhcmdldCA1bXMgaW50ZXJ2YWwgMTAwbXMgbWVtb3J5X2xpbWl0IDMyTWIg
ZWNuIGRyb3BfYmF0Y2ggNjQiCgojIC0tLSBST09UIEhUQiBmZmZlOiAtLS0Kc3VkbyB0YyBxZGlz
YyBhZGQgZGV2ICRJRkIgcm9vdCBoYW5kbGUgZmZmZTogaHRiIGRlZmF1bHQgMSByMnEgMTAKc3Vk
byB0YyBjbGFzcyBhZGQgZGV2ICRJRkIgcGFyZW50IGZmZmU6IGNsYXNzaWQgZmZmZToxIFwKCWh0
YiByYXRlIDgwMG1iaXQgY2VpbCA4MDBtYml0IGJ1cnN0IDE2MDBiIGNidXJzdCAxNjAwYgoKIyAt
LS0gUFJJTyBmZmZkOiAtLS0Kc3VkbyB0YyBxZGlzYyByZXBsYWNlIGRldiAkSUZCIHBhcmVudCBm
ZmZlOjEgaGFuZGxlIGZmZmQ6IFwKCXByaW8gYmFuZHMgOCBwcmlvbWFwIDAgMCAwIDAgMCAwIDAg
MCAwIDAgMCAwIDAgMCAwIDAKIyAtLS0gQmFuZCAxIOKGkiBIRlNDIDE6IC0tLQpzdWRvIHRjIHFk
aXNjIGFkZCBkZXYgJElGQiBwYXJlbnQgZmZmZDoxIGhhbmRsZSAxOiBoZnNjIGRlZmF1bHQgZmZm
YwpzdWRvIHRjIGNsYXNzIGFkZCBkZXYgJElGQiBwYXJlbnQgMTogY2xhc3NpZCAxOjEgXAoJaGZz
YyBzYyByYXRlIDgwMG1iaXQgdWwgcmF0ZSA4MDBtYml0CnN1ZG8gdGMgY2xhc3MgYWRkIGRldiAk
SUZCIHBhcmVudCAxOjEgY2xhc3NpZCAxOjkgXAogICAgaGZzYyBydCBtMSAwYml0IGQgMHVzIG0y
IDQwOTZrYml0IGxzIG0xIDBiaXQgZCAwdXMgbTIgMWtiaXQgXAogICAgCXVsIG0xIDBiaXQgZCAw
dXMgbTIgODE5MmtiaXQKc3VkbyB0YyBjbGFzcyBhZGQgZGV2ICRJRkIgcGFyZW50IDE6MSBjbGFz
c2lkIDE6YSBcCgloZnNjIHJ0IG0xIDBiaXQgZCAwdXMgbTIgMzIwa2JpdCBscyBtMSAwYml0IGQg
MHVzIG0yIDFrYml0IFwKCQl1bCBtMSAwYml0IGQgMHVzIG0yIDQ4MGtiaXQKc3VkbyB0YyBjbGFz
cyBhZGQgZGV2ICRJRkIgcGFyZW50IDE6MSBjbGFzc2lkIDE6ZmZmYyBcCgloZnNjIHJ0IG0xIDBi
aXQgZCAwdXMgbTIgOGtiaXQgbHMgbTEgMGJpdCBkIDB1cyBtMiAxa2JpdCBcCgl1bCBtMSAwYml0
IGQgMHVzIG0yIDgwMG1iaXQKc3VkbyB0YyBxZGlzYyBhZGQgZGV2ICRJRkIgcGFyZW50IDE6OSAg
IGhhbmRsZSA5OiAgICBmcV9jb2RlbCAkRlEKc3VkbyB0YyBxZGlzYyBhZGQgZGV2ICRJRkIgcGFy
ZW50IDE6YSAgIGhhbmRsZSBhOiAgICBmcV9jb2RlbCAkRlEKc3VkbyB0YyBxZGlzYyBhZGQgZGV2
ICRJRkIgcGFyZW50IDE6ZmZmYyBoYW5kbGUgZmZmYzogZnFfY29kZWwgJEZRCiMgU2VuZCBhbGwg
SEZTQyB0cmFmZmljIHRvIGNsYXNzIDE6YSAodGhlIGNsYXNzIHRoYXQgc3RhbGxzKQpzdWRvIHRj
IGZpbHRlciBhZGQgZGV2ICRJRkIgcGFyZW50IDE6IHByb3RvY29sIGlwIHByaW8gMSB1MzIgXAoJ
bWF0Y2ggdTMyIDAgMCBmbG93aWQgMTph
--000000000000b0c55406534a1808--

