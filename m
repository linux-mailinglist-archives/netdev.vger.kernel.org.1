Return-Path: <netdev+bounces-267168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN5NMuTzsmmLRAAAu9opvQ
	(envelope-from <netdev+bounces-267168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:12:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C436276698
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34222302FB00
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A693C8725;
	Thu, 12 Mar 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGGjbm4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6203603D2
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334686; cv=none; b=BbMXW4y5mUyCZg1Ves0wRLA9/wlyT9zodXJD53A3vG9W5bH4UcdrkK7Xj0GRZGo4RH+IsXzJwLDslaSpiK10RcQ9DOboSJ6zwK6y3UCeDlWImdGjx7IPZ8DtmyGzM9SwSIxU9l9PDg4fCzP5pLHVwdEUjvtWeXpY4GIBVoRYsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334686; c=relaxed/simple;
	bh=qtmraUB3Qs2ZOVkzEocVBMzelwIe4yAF7D+5xl3WjtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi3k9Ulfmhtpdk1oyZMfv4KJCrCBFV26w7uGYL6wicYK9lsF59ZVI+YTMZX8Ztx/2YEJ+llMTNeMeKBf0ykKUcd9eyXDW/Wb0qxXJ4De5+frD87fdfKTYq27XDdQH5rp1SHyqf1h59DRspOXrr4G5KRTXq04pHs32V2I+sucRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGGjbm4l; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a15b44c3cso164606b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334685; x=1773939485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIIGLD+BLldHOqSwok3QT/zDjtx5ptoLmduV+QqJNpg=;
        b=WGGjbm4lNX1ZPGcBGb/uHC9QN68VfOMcROG3b7UAVDyYii4qEByXc8Lij4U/Ggb9qX
         ocWlp+Q7XUKvohOGqr4gmWh5u36VkvRvewBlGv1jT+wpdclsuTowAZJ+E6zo1TaO/AC5
         Z+u3ESRexIjNot5Ko9+J4DYbgr5LpCEgXdTGWONhreU9Irp69kRvgAPOoQX9hziH+Bad
         ARqp7aocOfyyl6Z4g2Q+6/lp4Dt9JwXuZ2JjAwIR2dm4hiDcB1ZBYbKFI/IJLxGC1Kjs
         LV906u7hvtYFOlc5eM+D2Uw+TkRGb2tDOtCr1s7WslkwGIW5Inp4C52HLeU+WLnZKE34
         z4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334685; x=1773939485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIIGLD+BLldHOqSwok3QT/zDjtx5ptoLmduV+QqJNpg=;
        b=VanprLkPzm4p91wr+S563Jkca6D6cF41OoycP1r8kqzuBqDYtuuD8m1crISkpXcwc+
         vmGef9Kr1iPxNOrRgM0p+1/WT6PdXjJZBf/pcEcZ9mg+V2woumOR8UCcE9fYA/9S8x5Y
         emjVQ/NrC0zcMuLTyQLcuimbh9fgaTkL6GOjIMFb+34bajC3XgjPexleW7o59O3QArNe
         grVrrvrBjeDKOH34t+12hzhtnBiPiDFPnfO8QymxHf8wKVgQIJAlflXX10VXdpqkfxPP
         ssczTQRDrBUTeikzxwTUi4dS1G8cw5FKmEpUNT6A+e/sTcSvi6pQgG9aIJuLCA8B7d70
         H8Ew==
X-Gm-Message-State: AOJu0Yw40VQ9eSV9KBzL4flpsS5wMCfTOeRdqCbMP+yqfC6REq/zQagr
	gXXjbQ0+vZ1aQ2+M9P3HjXqqHqT/EBKNomIYsRpWTkffB6//OXO9+2Rn
X-Gm-Gg: ATEYQzxBHjQMcq80j5Q3mMVV9Fp5BJiByiNp6DfuS+ZcJXqMDwHCMkdkd72T56E9zJt
	zAsmchznEQAP7U6IWrKZQCax18hNurAF6ghasVoZq+bOUFrLW57YEjjNE6p1LG8Omz1vV6+HJEZ
	dml/SPL8GxP53IcKiGIps9y8X12spSN4ebk/37mR5AQX2qtHwbwQ6WMszYiVuwdFrpiIkX6rPeP
	N/qQMDrMdczJPiZH898s044Qktbkas3IKT1TJZLoSbAMHffn/gDh6/saNRIHtdkZn1IzUGk9Kbx
	l1nVWBvL6oKsjo7/Op22OhCQUBz4TtOOKnGOjaz6jFr6EdutCvzvgMqnS+2nQVLKLUKbrTUgvwJ
	0yltkJIqDneMiN/66n6kJyBk2FW32nSPFyB/3SI+vZEpJt6CmxewFZ0oH2VJ6+HBjXQ9p9izW4x
	PwT3Q8cGGijBpnVCA0
X-Received: by 2002:a05:6a00:3c8a:b0:829:822e:cdce with SMTP id d2e1a72fcca58-82a197041damr213872b3a.6.1773334684743;
        Thu, 12 Mar 2026 09:58:04 -0700 (PDT)
Received: from mingi ([175.125.103.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072414f8sm3625969b3a.4.2026.03.12.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:58:04 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:57:57 -0700
From: Mingi Cho <mgcho.minic@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	mincho@theori.io, victor@mojatatu.com
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to
 root qdisc
Message-ID: <20260312165757.GA3411905@mingi>
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
X-Spamd-Result: default: False [14.34 / 15.00];
	MW_SURBL_MULTI(7.50)[test:email];
	ABUSE_SURBL(5.00)[test:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	TAGGED_FROM(0.00)[bounces-267168-lists,netdev=lfdr.de];
	CT_SURBL(0.00)[test:email];
	GREYLIST(0.00)[pass,body];
	CRACKED_SURBL(0.00)[test:email];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	DM_SURBL(0.00)[test:email];
	TAGGED_RCPT(0.00)[netdev];
	PH_SURBL_MULTI(0.00)[test:email];
	FROM_NEQ_ENVFROM(0.00)[mgchominic@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.190];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,test:email]
X-Rspamd-Queue-Id: 6C436276698
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Tue, Jul 01, 2025 at 04:29:13PM -0700, Cong Wang wrote:
> This patchset attempts to move the GSO segmentation in Qdisc layer from
> child qdisc up to root qdisc. It fixes the complex handling of GSO
> segmentation logic and unifies the code in a generic way. The end result
> is cleaner (see the patch stat) and hopefully keeps the original logic
> of handling GSO.
> 
> This is an architectural change, hence I am sending it as an RFC. Please
> check each patch description for more details. Also note that although
> this patchset alone could fix the UAF reported by Mingi, the original
> UAF can also be fixed by Lion's patch [1], so this patchset is just an
> improvement for handling GSO segmentation.
> 
> TODO: Add some selftests.
> 
> 1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/
> 
> ---
> Cong Wang (2):
>   net_sched: Move GSO segmentation to root qdisc
>   net_sched: Propagate per-qdisc max_segment_size for GSO segmentation
> 
>  include/net/sch_generic.h |  4 +-
>  net/core/dev.c            | 52 +++++++++++++++++++---
>  net/sched/sch_api.c       | 14 ++++++
>  net/sched/sch_cake.c      | 93 +++++++++++++--------------------------
>  net/sched/sch_netem.c     | 32 +-------------
>  net/sched/sch_taprio.c    | 76 +++++++-------------------------
>  net/sched/sch_tbf.c       | 59 +++++--------------------
>  7 files changed, 123 insertions(+), 207 deletions(-)
> 
> -- 
> 2.34.1
> 

Hi Cong,

I tested the proposed patch and found that the reported bug was fixed. A qlen mismatch between Qdiscs can potentially cause UAF, so I believe this patch needs to be applied.

When executing the PoC on the latest kernel without the patch applied, a warning message occurs in drr_dequeue() as shown below.

Before applying the patch:

root@test:~# ./poc
qdisc drr 1: dev lo root refcnt 2
qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
[    7.588847] drr_dequeue: tbf qdisc 2: is non-work-conserving?

Testing after applying the patch to the v6.17 kernel shows that the warning message has disappeared.

After applying the patch:

root@test:~# ./poc
qdisc drr 1: dev lo root refcnt 2
qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p

I tested the patch and found that the bug was resolved, but I'm not sure if any other side effects occur.

The PoC used for testing is as follows.

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/udp.h>

#ifndef SOL_UDP
#define SOL_UDP 17 // UDP protocol value for setsockopt
#endif

void loopback_send (uint64_t size) {
    struct sockaddr iaddr = { AF_INET };
    char data[0x1000] = {0,};

    int inet_sock_fd = socket(PF_INET, SOCK_DGRAM, 0);

    int gso_size = 1300;

    setsockopt(inet_sock_fd, SOL_UDP, UDP_SEGMENT, &gso_size, sizeof(gso_size));

    connect(inet_sock_fd, &iaddr, sizeof(iaddr));

    write(inet_sock_fd, data, size);

    close(inet_sock_fd);
}

int main(int argc, char **argv) {
    system("ip link set dev lo up");
    system("ip link set dev lo mtu 1500");

    system("tc qdisc add dev lo root handle 1: drr");
    system("tc filter add dev lo parent 1: basic classid 1:1");
    system("tc class add dev lo parent 1: classid 1:1 drr");
    system("tc class add dev lo parent 1: classid 1:2 drr");

    system("tc qdisc add dev lo parent 1:1 handle 2: tbf rate 1Mbit
burst 1514 latency 50ms");

    system("tc qdisc add dev lo parent 2:1 handle 3: choke limit 2
bandwidth 1kbit min 1 max 2 burst 1");

    system("tc qdisc show");

    loopback_send(4000);

    system("tc class del dev lo classid 1:1");

    system("timeout 0.1 ping -c 1 -W0.01 localhost > /dev/null");
}

Thanks,
Mingi

