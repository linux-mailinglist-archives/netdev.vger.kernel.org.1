Return-Path: <netdev+bounces-281399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uILWGz+E72klCAEAu9opvQ
	(envelope-from <netdev+bounces-281399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:43:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E922E47570A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7812531C9942
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D15351C2A;
	Mon, 27 Apr 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FZpTr2Kx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80273370EB
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303907; cv=none; b=tPKEpEhiW9rvIAekO7wTpJE1CHUNAs3xyqYLm8Ve6UYqCobbu+5vPqwL37ynokr0C3LkVqGgut1GpfPQdsBJYfs9C2H24yal2U+MojfDnyRJXTfuq7th96pjvg8hlC1sLPKN5HPbhW2DwUfWYJa5stl5+iyn3EN0Lh7N2g8vdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303907; c=relaxed/simple;
	bh=f0Wiy+TGct6uE/9Igrbb6fvX2X++EbFqcLIALxPFAYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCD+TdywCWmgXHi2TvEMIffY9bpsEnSjYKmSx2Z3QN3UZ4IMc8wVDmtdm0sw0PIuovGaBSehPUrYwkuGtDiM4Mm1R1rKBiZwuhTFTwdL5ovtZt2JsHtkxxneNpsLEH/bRCbdJPf7mHbwHcE3l+55FE4agOwl/PUFQL6CRyaCQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FZpTr2Kx; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-82f1fbe6899so399034b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303905; x=1777908705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vik7X9JGccLkKKz3/pSkLmm87Qrp4z5SxtaHa4HWROw=;
        b=UqLmB8H5iEU88oyoMjEbNN7Y8GtuRwPUU1F29plrhumV1oDMJm2Inm8CzI5mKKMO1V
         6JhuKnrCqQEKJ0c03yn9/D2y33rnrxSi+zzjcZEax45YvB3LYfMn7Ecs2pmwUMAs5bcQ
         Am1/Vstg0alPmY8qj5EPAMXC0nvc98I7ctxhGBhducyDNqwYFdC5zzC2mYb7UDpU3Pkw
         ApzY1mHkmM2OsdhEsFbZA8rnTm/ijzRcJv8KEpvvpYzL0dw/UhMbL6Lnz2yGLTR/1m/6
         0nrGF4ZsvsU3YQ2eLsVDeOVsk/mNPAOvp9F53Jj3d6lQbpH6ztPja4xbZbWaZ6VxT/Qo
         kX3w==
X-Gm-Message-State: AOJu0Yz6JfzPTdfVkAbWfFfB/qlJ8wC5wr9+bl5bvFN1rsQHZoVXvMfd
	73g3OP050paWAk0zgO6U85lxCG/i41S6Rpq31T0empSMlkpLwmVPKQHm+hmgvH7QEcGoydd5M7Z
	/8p/HHQBU5aWOvW3E9U119BhpWXOEGX6XnpZZeCHA/v9Q6fxjZO+zjX7UYzvmeMPJVCRYNOiIGz
	8TZ2p/Uo/gI96b23V2D4f+lGcNB8XPL3s2/oXFlTka9k88DqjHnWmx5l6Qdju1JBY9XMI+FKW1q
	PEzO0hite2zkLY=
X-Gm-Gg: AeBDieugTuYlo6NFoEHwfVovOJYocrDzLQm24n0hzUlrwBAMix0BIpT8FbZAG20pXuW
	kgWdAqmakM6KB9+Z8HIBTH+X+fbGZFvOGqn2eNZ7qm7NahAWHpyTfgG6ghbU5+zZiDxwL0Rhoab
	ScFWl78kuX773lhCBNKNq6vj6B5RIHJMN5T6GAoZd/2Fb9POQAlY3hFD789DptR6RPv6Lq7BjjR
	IWEoCTOigaJGcFmoschsk/VKUmCvCmiVzSB1p1Tx9Vwwr59ZwJbchvAalMj7T9wYr4WlUrKImRL
	XupKvcFFYCgVRXTn4xSX9JrmYatAfFU7s/O1MjoQH6B4Tcg09zoZPXEThK7nnsTTxlPio0SbQaY
	EbPAek3UekhYl7PRrEDx2B+I0pR9voiyDcrSaxOeF8itR83cge/T9qXn13ae+DGUnt6aD/PFnt3
	mI80ZrpKCZ8cFviayDZ4YvbSl9LjP1IijAHcKMWzdsMZgtPMMABuxM3K/57E+illZVWX5h
X-Received: by 2002:a05:6a00:90a5:b0:82c:dfeb:2aee with SMTP id d2e1a72fcca58-82f8c8f8ab5mr23154711b3a.5.1777303904871;
        Mon, 27 Apr 2026 08:31:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82f8eaa4361sm2462228b3a.4.2026.04.27.08.31.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2026 08:31:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7962fe1eddeso25258817b3.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777303903; x=1777908703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vik7X9JGccLkKKz3/pSkLmm87Qrp4z5SxtaHa4HWROw=;
        b=FZpTr2KxurxE7WVv/B4QY5ybNsJZ6LkBcRmnZAc0H4ijEHj44t53+W0q5y6dh1IDfB
         pgSlBSffIXsML6bTFXrupJULteN1FXOkhVapzbml8clERPA4BPdTQGq5YGTy40cnB0IV
         U/2zq/iYdkIoEnhRUqLNJuBFCIod4A7JABE68=
X-Received: by 2002:a05:690c:6c91:b0:79e:631e:67b with SMTP id 00721157ae682-7b9ecfc22a0mr275661507b3.4.1777303902604;
        Mon, 27 Apr 2026 08:31:42 -0700 (PDT)
X-Received: by 2002:a05:690c:6c91:b0:79e:631e:67b with SMTP id 00721157ae682-7b9ecfc22a0mr275660897b3.4.1777303901665;
        Mon, 27 Apr 2026 08:31:41 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69abee3sm2590486585a.17.2026.04.27.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:31:41 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	quic_stranche@quicinc.com,
	quic_subashab@quicinc.com
Cc: linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
Date: Mon, 27 Apr 2026 15:27:55 +0000
Message-ID: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: E922E47570A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281399-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

When an application explicitly sets SO_RCVBUF, the window clamp should
not be dynamically recalculated based on the memory scaling_ratio.

Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
down when it sees a poor skb->len to skb->truesize ratio. If the
application explicitly locked the buffer via SO_RCVBUF, this
recalculation causes the advertised window to drop severely.

If the window drops below the interface MSS, it triggers Silly Window
Syndrome (SWS) avoidance on the sender. The sender defers transmission
and drops the connection into a perpetual 200ms PROBE0 timer loop,
drastically reducing throughput.

This is highly reproducible on loopback interfaces (MTU 65536) using
Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
to 32K or 64K. The bloated loopback truesize forces the scaling ratio
to drop, crushing the window clamp to ~26K, instantly triggering SWS
stalls and causing gigabyte transfers to take minutes instead of
milliseconds.

Since the application locked the buffer, the kernel should respect the
clamp boundary and not dynamically crush it based on runtime ratios.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Cc: stable@vger.kernel.org
Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
Note to reviewers:

Testing Context:
- The SWS deadlock was successfully reproduced on the latest netdev/net 
  tree (v7.1-rc1) using the actual enterprise Java workload.
- Applying this patch completely resolves the 504 Timeouts and restores 
  loopback throughput.
- Baseline iperf3 auto-tuning remains unaffected by this patch.

For context, here is the exact sequence of events that triggers the 
recalculation flaw, illustrated in a packetdrill-style flow. 
Unpatched kernels aggressively crush the window at step 3, triggering SWS.

// 1. Tomcat creates socket and hardcodes the buffer to 32K
0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [32768]) = 0
+0 bind(3, ..., ...) = 0
+0 listen(3, 1) = 0

// 2. GemFire connects over loopback (simulating Jumbo MSS of 65496)
+0 < S 0:0(0) win 65535 <mss 65496, sackOK, TS val 100 ecr 0, nop, wscale 8>
+0 > S. 0:0(0) ack 1 <...>
+0 < . 1:1(0) ack 1 win 65535 <TS val 200 ecr 1>
+0 accept(3, ..., ...) = 4

// 3. GemFire sends a 20KB packet, dropping the scaling_ratio.
// Without the patch, tcp_measure_rcv_mss() crushes the window_clamp here.
+0.1 < . 1:20001(20000) ack 1 win 65535 <TS val 300 ecr 1>
+0.1 read(4, ..., 20000) = 20000

// 4. Assert window did not crush
// WITH the patch, the kernel respects the SOCK_RCVBUF_LOCK.
+0 > . 1:1(0) ack 20001 win 65535
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9..c1cb9d3ed 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -248,7 +248,8 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 			do_div(val, skb->truesize);
 			tcp_sk(sk)->scaling_ratio = val ? val : 1;
 
-			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
+			if (old_ratio != tcp_sk(sk)->scaling_ratio &&
+			    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
 				struct tcp_sock *tp = tcp_sk(sk);
 
 				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
-- 
2.53.0


