Return-Path: <netdev+bounces-268280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAGuBvpxuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7453F2A08E6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78593037915
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7C364059;
	Mon, 16 Mar 2026 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kge1sFTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED156363C4B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695473; cv=none; b=hPENmysfffOij2cilfn2UbIGVMPRh5iMlkfzQlAlaEmqxW6qVvxXj55IdQ5Jqdms0JXGMBT24CLLuU81kZI31kj+FULYHGhE/3p6eeyK8V0JuUapMcxhcUKAjxAdZmODIunxxqSa8QxKW6+SQiQAmavfWKKwNaWsA2VkHx+o/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695473; c=relaxed/simple;
	bh=LP1yTjJCYmJX/Qb0pJVCqjTxejEZ29Qbej1b+86KPL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBdjObVTM+7Qbt/blJDNk4oz1OI8TR/tAy076d5xN+C/TU7RXM7hHLSOB2iW4XHgRzWQCYo+0iAwxygVIZx52l4CtbOXuKANWeGLCKMNB4byoSipboM8baDVWFbV3fo3djrJq1L75X3tOYgwr8+xALwr49cIdW5hE2QWVB/fiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=kge1sFTu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89c5d795248so5960096d6.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773695471; x=1774300271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg+mzcurkRW/3R0O9EYZ+r/Yt99nB5ySaE+pg+ckKCo=;
        b=kge1sFTuBvUfdBvpsjyMvjd9gmpp6TOIVhl1Sv8aIx10sfGt2PHjiAbAZszC+btnCK
         vqwNTVMCmRkg0fmOoLgvXjmjfFyVdUxWDHJOFCFzQ7lSmf9XfXhP0X+T0tfABcBu7KZ+
         IgtzpAfKp8WhbExTEi0vQMR8atr/EfS+l4DFtf1DicV6yKSk0qQNtbMZreJXa2o/sk5Z
         p+Kf7Dhc07+LpguoIHCkO1PwBnCuqTTHQMzsshRJ3HmnBcIgS4492GDQF6B0FoRl7JC+
         7VpZp1Q5GVmTu1bVGfVyXpPFqd+1/eAfyAnEd8pQec6VOjIYHbuU4+z/h16RcYrS920g
         1GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695471; x=1774300271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tg+mzcurkRW/3R0O9EYZ+r/Yt99nB5ySaE+pg+ckKCo=;
        b=hgVEzFzphdAcPwHcCgsDNyemQJCqCIrQda30zMlqevywiUn63ro83MFKxpUp95w0yV
         EIINXpobFiRG4HwlaDToxebCI4gCtasihAjnCIhjmTLgdjTi+W6h/kIYPwAttEgDrTqR
         RpTEyMRUPRbTz5gOK12r6WWiJd/sQElEAFRi+5OnfDEzV0hoYPHAkucd8z4pzHA5/cEP
         SAzJ/ctilrIXWHXUq2NxpgU85xLosqd/WWXT5AZXv2PB1Ekxsyrvl4uBt+k5GoGmcxKL
         xGm1huYo5Kkqn6dRICVCZtl/2qVeL42q5KZ6c6xSwEhZLyxB0zAwXxxAN1DrUNfig9Jh
         +kvA==
X-Gm-Message-State: AOJu0YyX7zcxYidOvQhdr38aGxviMSTDlBCDqFK42pyaRksm+V8m8txq
	3RRW8eXJEBeZL+BD+5pInBvFNcnlhXrEeMjyP9A174Xh3FehYPrx/t9KtHHCm5NvP/SyN0R/i6V
	6huY=
X-Gm-Gg: ATEYQzzcSoZbxIkJR+DqhKuNR5BRgRa591y+RWDN9mKBl2CHY43p4+gdXkqbYBldtby
	/t8bJV/FkucrB7Ey9qY8KOMhFMQ3dexc1vwjwIrdPuKPmUbyZ26G0mg0whXQzKBeaN2yLqhtGD3
	3qwJxgaFEbK1WGplQlXzg/NkZ2za/q+yHRNAyMEnefRbr83fDJ5HmSr3QMXn0DfA9AyoCjWUJiy
	m/Pf970hVku9DM+LWitPQXdYLRa8N0ECMM5vLRH//RX4BNdHLrjvfaB1x66hj3a+1zBZK/WLLF/
	uzCMDboyjG+DHPtm/lwLRVGKemwB2T7mJM0oYZ55VY1tRiX6EcJZ9daZvZXwt/42o1kALvG+L2e
	TyHFf6IvyZbWeoqRcpW5+rAN1N/6SHxj+PqyzlL2kfE1xwR7ICsUh5Jlh+3aM6PIb4B0TKBn7ZW
	VriMMCgpX1EcpTUNOLI0xECjA=
X-Received: by 2002:a05:6214:1254:b0:89a:9ef:1922 with SMTP id 6a1803df08f44-89a81f72f57mr220305906d6.40.1773695470538;
        Mon, 16 Mar 2026 14:11:10 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c53374573sm27356266d6.7.2026.03.16.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:11:09 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	savy@syst3mfailure.io,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/6] net: Introduce skb ttl field to track packet loops
Date: Mon, 16 Mar 2026 17:10:47 -0400
Message-Id: <20260316211052.332383-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316211052.332383-1-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268280-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7453F2A08E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to keep track of loops across the stack we need to _remember the global
loop state in the skb_.
We introduce a 2 bit per-skb ttl field to keep track of this state.
The following shows the before and after pahole diff:

pahole before(-) and after (+) diff looks like:
   __u8       slow_gro:1;           /*   132: 3  1 */
   __u8       csum_not_inet:1;      /*   132: 4  1 */
   __u8       unreadable:1;         /*   132: 5  1 */
 + __u8       ttl:2;                /*   132: 6  1 */

 - /* XXX 2 bits hole, try to pack */
   /* XXX 1 byte hole, try to pack */

   __u16      tc_index;             /*   134     2 */

There used to be a ttl field removed as part of tc_verd in commit aec745e2c520
("net-tc: remove unused tc_verd fields"). It was already unused by
that time removed earlier in commit c19ae86a510c ("tc: remove unused redirect
ttl").

An existing per-cpu loop count, MIRRED_NEST_LIMIT, exists; however, this
count assumes a single call stack assumption and suffers from two challenges:
1)if we queue the packet somewhere and then restart processing later the
per-cpu state is lost (example, it gets wiped out the moment we go
egress->ingress and queue the packet in the backlog and later packets
are being pulled from backlog)
2) If we have X/RPS where a packet came in one CPU but may end up on a
different CPU.

Our first attempt was to "liberate" the skb->from_ingress bit into the skb->cb
field (v1) and after a lot of deeper reviews found that it does get trampled in
case of hardware offload via the mlnx driver.
Our second attempt (which we didnt post) was to "liberate" the
skb->tc_skip_classify bit into the skb->cb - but that led us to a path of making
changes that are sensitive such as making mods to dev queue xmit.

This is our third attempt.

Use cases:
1) Mirred increments the ttl whenever it sees an skb. This in combination with
MIRRED_NEST_LIMIT helps us resolve both challenges mentioned above.
This is ilustrated in patch #2.

2) netem increments the ttl when using the "duplicate" feature and catches it
when it sees the packet the second time.
This is ilustrated in patch #5.

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index daa4e4944ce3..f1326c4b4bcc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -848,6 +848,7 @@ enum skb_tstamp_type {
  *		CHECKSUM_UNNECESSARY (max 3)
  *	@unreadable: indicates that at least 1 of the fragments in this skb is
  *		unreadable.
+ *	@ttl: time to live counter for packet loops.
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
@@ -1030,6 +1031,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+	__u8			ttl:2;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
-- 
2.34.1


