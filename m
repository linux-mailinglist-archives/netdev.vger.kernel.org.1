Return-Path: <netdev+bounces-294683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F9F5K/vqH2qHsQAAu9opvQ
	(envelope-from <netdev+bounces-294683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A940635DEA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:51:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=Z4NfPU9P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294683-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294683-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 071853083EFD
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708A41B365;
	Wed,  3 Jun 2026 08:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAC38399B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:24:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475093; cv=pass; b=NS5DyNapsOHFxles7b+leyFxcggxKHEVRXBhyx1sO+IdtoO2C+/SiNHACp8nmQEaJ0ZFCxNDQ1/YvHxBZfc5VzbEpnzmwT+rwtGMNSHWEBmDUS/rOFBxgvnxZ6YIMfyQcwbTF5Sp7aysGHcTHQ9R7Bt0eQGTsQkxwzkWClDhjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475093; c=relaxed/simple;
	bh=WmS2dRcTi3iMV+pvAjFVj9qUbxO+ZRHW3bXCpYLdG5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Paef3IBRmGC6mYteMDZXYyXki+tx3uqWy3APctrdaxFC5ylSRSdc3mIahF7FgtHipAfq+zdgygLphQ9VhYsST/31cbPXWxJlpcTI9x0BjYWiqvnIMn/tDM44kMtVRlRcto09AYCwyFoNnWPNfDjNCr0/x04S1+0ozud1yoBxGgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Z4NfPU9P; arc=pass smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423b08b293so1505742b3a.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 01:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780475091; cv=none;
        d=google.com; s=arc-20240605;
        b=CuAIn+5I1xHmX9lLSBErFuO0pIZi1sn73u2EGkTmbCVWuG8Znn6YTteOkGzgMkGATR
         +TTA9bRUOFWdmTtG3w3MpyMFHNzFeWqNyv7l9wIuHHuf+FMUaWgigyepAJJ+LNMLwjxx
         MGeY0UDkp9tW/42uBinf60DurO9yVWArO3euRvkdJvGcsZYW63u1TnLw1JWGPW9w4R2X
         dSWfy/cerixDU6QgPH3Og/GrFShxoTueKPdfEVXtG0oWQ0/WBdeYSFzvn8HohNkPibiM
         HJFZBy8gi7JG6SzHG2IN6I5tFVZu1SsnDEW7Y3tPi9Jfhu79IfXDBTeguhdjV2E2VS2t
         QSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/DAvsSXfJEi3I1lBSq3kuZRsfa7fKGNmssgOv2Y58o=;
        fh=6/7L4Ce17rxOlSVcLbfenBz4vYjI/U3Ipf7o/fOH7tc=;
        b=f5reWEOjwYiXs+4X8yq0VcgqPPLELs6eiqkXpL8t6gNa/GTUA7yA6KoRL3NY3wcH9Z
         8ggSTCfO+BNIqb6dwaHxiFxHXtnlci9TKMhdtVZVKU4Pe1ZSBUhus05j4qJbzmvjK8LX
         AKPPqaZLNu8rseSSdlBITufj4cWHzRnPgYuqF5eJ9nvS7cX1jwDO97nwI82c/sX9qEpu
         LFxwJ/xqryHnn9RrmcQD5K7sVvWeVe3ClFM7pIu4pwLvNOnpcwz/1Un6/FJ6m64ofd+W
         2Sg387fGrYfkzqd0XITen7vOf1a2m9YyKr7VVJ9Kvi9aIkuxV5JSf9948FuiMxSMGw1V
         ZZ0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780475091; x=1781079891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/DAvsSXfJEi3I1lBSq3kuZRsfa7fKGNmssgOv2Y58o=;
        b=Z4NfPU9P2vkwu/LNtRB6lQTR833p/T3E1I2J1hWDdA/GQv5AGFD5EO+mP5GFIFxKKg
         m461QJVhtIGreKNr1k0u2P0S/HUQGeIxuX6LEfwsvY/mLHGvt0uIJGiMBgcuFyjKhd6X
         UyqolOfeoD82IDYmopHwb3pGazPghT+Xuqww4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780475091; x=1781079891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/DAvsSXfJEi3I1lBSq3kuZRsfa7fKGNmssgOv2Y58o=;
        b=ppdlNbXCzSj+XnPElwA/iJc5duEVJ41v0/yst1plNe3MDHKb0r/6rRN8eJffoSQwnz
         O6U2nL7p4u8S+f4H3KDJHvBNOAw091yisuYAlSOQyOs3GoUAGpMAHQJOumvZc4/0nx1m
         RwE6V+rGJE0np0/QHNSuwliHR1HNUe3n5woE55i2YtEuqK9W6NwfDcVT4T3WNUWtqG4T
         jBPj1W7eeXhaDFzxy6Q1H0DeL2d9Soi0Q95ykLED3QeQ9hICt8j2PuExeA+ruTFWC1Iv
         gmSOfJGFNfStAfK19Y4ro34MQZtKnFFfZdPGV6uU06o2tOFU4DnwEEOCRbOPHJ1Bo93t
         MxZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s5K3jR+hhgRj+hezPiadZiY776TXb8nBClnV3k0rTMHZonPJCvOe3nQwUbH94A3tNMLRKDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcLgMOXi2NUxZPs6AF+CnPVIOcEZdXupQXqmYgJ94tBp5ThOc
	9Dt/9Mz8thMMl7DCYDcO4t0mxVAAGYBrkeRpNIBp0H93pN1GVBeQL4DoLSCyzEKdxJUrOxB0XM7
	PZvrtD0FRjgNYilGVBBNvHE1IEOYOQ/2nyQnsuo2D
X-Gm-Gg: Acq92OECzG2kgK1hStJOay8JIja2JMtvl3dIEn8clJpV9aQIO25mYWDBimQNtqkIbP5
	bpHpcZmOmJZ/AL4uCR5G6CVbljrv06oowMhHXxxSKSMrfCaC37S0I3UQa7h+iu4rig1gLoH9yyE
	McNKUWJJZXh13+7EEXD2e0BWfh2KqBB+ailgEmsISGyL0hNzQADgNh64+rYANFK/x3gQ4rVrZhM
	V6/jCQl7yOuUXtdS1iBgw3SBoSHeQCNJkwW2xaVRYYgzkhYR4TQ1j/CGO/hAgRPA0PHtEEng6LP
	/509lM0TgJPzMJcUKa8=
X-Received: by 2002:a05:6a00:c84:b0:82a:7893:e14b with SMTP id
 d2e1a72fcca58-84284f373d2mr2313922b3a.38.1780475090554; Wed, 03 Jun 2026
 01:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
In-Reply-To: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 3 Jun 2026 04:24:39 -0400
X-Gm-Features: AVHnY4J6KNSRXKe7B3hHvGoZR8gyihsZrwMDHFF6g4EqgO8yA5vqJ86v3JPsTlQ
Message-ID: <CAM0EoM=Fs7bA9JdxUWkD=Yi8_cKBAsAhx5Rg=VAYOWpn-mR4GA@mail.gmail.com>
Subject: Re: [BUG] net/sched: HFSC + fq_codel stall on 6.6.116
 (qdisc_tree_reduce_backlog / qlen_notify)
To: Anirudh Gupta <anirudhrudr@gmail.com>
Cc: "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Anirudh Gupta <Anirudh.gupta@sophos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anirudhrudr@gmail.com,m:xiyou.wangcong@gmail.com,m:netdev@vger.kernel.org,m:Anirudh.gupta@sophos.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,sophos.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294683-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,mojatatu.com:from_mime,mojatatu.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A940635DEA

Hi Anirudh,

On Tue, Jun 2, 2026 at 3:12=E2=80=AFPM Anirudh Gupta <anirudhrudr@gmail.com=
> wrote:
>
> Hi,
>
> Linux 6.6.116 can permanently stall traffic under this qdisc tree on ifb0=
:
>          HTB =E2=86=92 prio =E2=86=92 HFSC (class 1:a, RT 320Kbit) =E2=86=
=92 fq_codel
>
> Symptom:
>   tc -s shows hfsc/fq_codel backlog stucks while Sent byte/packet
> counters do not increase for 30+ seconds. No kernel oops.
>
> Steps to reproduce:
> 1) Use attached script =E2=80=98apply_tc_tree.sh=E2=80=99 to create the r=
equired tc qdisc tree.
> 2) Send bulk short lived tcp connections, on the interface whose
> traffic is mirred to ifb0 interface for rate limiting.
> 3) Observe that the sent bytes in class statistics get stuck, while
> the backlog counter keeps on increasing -
>
>
> ---captured output---
> kabir@KABIR-CL-2:~$ date
> Tue Jun  2 06:29:11 AM UTC 2026
> kabir@KABIR-CL-2:~$ cat /proc/version
> Linux version 6.6.116-0606116-generic (kernel@balboa)
> (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld
> (GNU Binutils for Ubuntu) 2.42) #202511021338 SMP PREEMPT_DYNAMIC Sun
> Nov  2 14:08:04 UTC 2025
> kabir@KABIR-CL-2:~$
> kabir@KABIR-CL-2:~$ uname -a
> Linux KABIR-CL-2 6.6.116-0606116-generic #202511021338 SMP
> PREEMPT_DYNAMIC Sun Nov  2 14:08:04 UTC 2025 x86_64 x86_64 x86_64
> GNU/Linux
> kabir@KABIR-CL-2:~$ tc -s qdisc show dev ifb0 | tee /tmp/stall-before.txt
> qdisc htb fffe: root refcnt 2 r2q 10 default 0x1 direct_packets_stat 0
> direct_qlen 32
>  Sent 80337622 bytes 937086 pkt (dropped 4541, overlimits 4505 requeues 0=
)
>  backlog 27760b 171p requeues 0
> qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
> target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  Sent 80338354 bytes 937034 pkt (dropped 4541, overlimits 0 requeues 0)
>  backlog 27760b 171p requeues 0
>   maxpacket 7570 drop_overlimit 0 new_flow_count 3438 ecn_mark 0
> memory_used 639744
>   new_flows_len 7 old_flows_len 1
> qdisc prio fffd: parent fffe:1 bands 8 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0
>  Sent 80337622 bytes 937086 pkt (dropped 4541, overlimits 0 requeues 0)
>  backlog 27760b 171p requeues 0
> qdisc hfsc 1: parent fffd:1 default fffc
>  Sent 80337622 bytes 937086 pkt (dropped 4541, overlimits 1879582 requeue=
s 0)
>  backlog 27760b 171p requeues 0
> qdisc fq_codel 9: parent 1:9 limit 10240p flows 1024 quantum 1514
> target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>   maxpacket 0 drop_overlimit 0 new_flow_count 0 ecn_mark 0
>   new_flows_len 0 old_flows_len 0
> qdisc fq_codel fffc: parent 1:fffc limit 10240p flows 1024 quantum
> 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  Sent 2296 bytes 54 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>   maxpacket 70 drop_overlimit 0 new_flow_count 2 ecn_mark 0
>   new_flows_len 0 old_flows_len 2
> kabir@KABIR-CL-2:~$
> kabir@KABIR-CL-2:~$ tc -s class show dev ifb0 | grep -A6 "hfsc 1:a" |
> tee /tmp/stall-class-before.txt
> class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
> 0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
>  Sent 80335326 bytes 937032 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 27760b 171p requeues 0
>  period 7484 work 80335326 bytes rtwork 53590324 bytes level 0
> class hfsc 1:fffc parent 1:1 leaf fffc: rt m1 0bit d 0us m2 8Kbit ls
> m1 0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 800Mbit
>  Sent 2296 bytes 54 pkt (dropped 0, overlimits 0 requeues 0)
> kabir@KABIR-CL-2:~$
> kabir@KABIR-CL-2:~$ sleep 30
> kabir@KABIR-CL-2:~$
> kabir@KABIR-CL-2:~$ date
> Tue Jun  2 06:30:39 AM UTC 2026
> kabir@KABIR-CL-2:~$ tc -s qdisc show dev ifb0 | tee /tmp/stall-after.txt
> qdisc htb fffe: root refcnt 2 r2q 10 default 0x1 direct_packets_stat 0
> direct_qlen 32
>  Sent 80337748 bytes 937089 pkt (dropped 4541, overlimits 4505 requeues 0=
)
>  backlog 28204b 177p requeues 0
> qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
> target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  Sent 80338354 bytes 937034 pkt (dropped 4541, overlimits 0 requeues 0)
>  backlog 28204b 177p requeues 0
>   maxpacket 7570 drop_overlimit 0 new_flow_count 3438 ecn_mark 0
> memory_used 669696
>   new_flows_len 7 old_flows_len 1
> qdisc prio fffd: parent fffe:1 bands 8 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0
>  Sent 80337748 bytes 937089 pkt (dropped 4541, overlimits 0 requeues 0)
>  backlog 28204b 177p requeues 0
> qdisc hfsc 1: parent fffd:1 default fffc
>  Sent 80337748 bytes 937089 pkt (dropped 4541, overlimits 1879731 requeue=
s 0)
>  backlog 28204b 177p requeues 0
> qdisc fq_codel 9: parent 1:9 limit 10240p flows 1024 quantum 1514
> target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>   maxpacket 0 drop_overlimit 0 new_flow_count 0 ecn_mark 0
>   new_flows_len 0 old_flows_len 0
> qdisc fq_codel fffc: parent 1:fffc limit 10240p flows 1024 quantum
> 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  Sent 2422 bytes 57 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>   maxpacket 70 drop_overlimit 0 new_flow_count 2 ecn_mark 0
>   new_flows_len 0 old_flows_len 2
> kabir@KABIR-CL-2:~$
> kabir@KABIR-CL-2:~$ tc -s class show dev ifb0 | grep -A6 "hfsc 1:a" |
> tee /tmp/stall-class-after.txt
> class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
> 0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
>  Sent 80335326 bytes 937032 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 28204b 177p requeues 0
>  period 7484 work 80335326 bytes rtwork 53590324 bytes level 0
> class hfsc 1:fffc parent 1:1 leaf fffc: rt m1 0bit d 0us m2 8Kbit ls
> m1 0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 800Mbit
>  Sent 2422 bytes 57 pkt (dropped 0, overlimits 0 requeues 0)
> kabir@KABIR-CL-2:~$
> ---captured output end ---
>
> Notice that, only backlog increased for class hfsc 1:a from 'backlog
> 27760b' to 'backlog 28204b', however, sent bytes remained stuck at
> 'Sent 80335326 bytes 937032 pkt'
> Existing connections get stalled, and new connections never get establish=
ed.
>
> This was working fine till v6.6.49, and I started to notice it once I
> moved to v6.6.116.
> Suspected commits introduced in 6.6.49..6.6.116:
>     2f9761a94bae codel: remove sch->q.qlen check before
> qdisc_tree_reduce_backlog()
>     f680a4643c6f net/sched: Always pass notifications when child class
> becomes empty
>
> Analysis: fq_codel calls qdisc_tree_reduce_backlog() when child qlen=3D=
=3D0
>   after codel drops; hfsc_qlen_notify() removes class from eltree while H=
FSC
>   still has queued packets; subsequent enqueues do not re-activate the cl=
ass.
>
> Workaround: reverting commit 2f9761a94bae
> (https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/=
?id=3D2f9761a94bae)
> alone fixes the stall on the same repro steps.
>

Thanks for the excellent report.
Reverting is not a good option at this point - will look at it and see
how to address this.

cheers,
jamal

