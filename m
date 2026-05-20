Return-Path: <netdev+bounces-289788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPaVL8ZYDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFA58852B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B0AD303F219
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89533F59C;
	Wed, 20 May 2026 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CDsO/xD+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADD33F5A3
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259398; cv=none; b=BzW7sVhkGJ5Ydnj8QzzpqBcv2CKwh4vRBxH4u9Hd3BMIjDdVQGBzoWQg9frjZOa68iz8oOoZKEg+IkZzudAb0IbeMAEXsHGcymI+veEVVk5YWOte+alCZ47P5lWOP/3oC+9k3jA5c1HitsgPVNdeSew5RnoBPsE/DNYD3obaphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259398; c=relaxed/simple;
	bh=5kXFiylQ90YK+HiJEYfaE/uD2O3c7z99rvu1iTHbCc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALcGgCQ0bU/8HcQI3IgyOpgJZcqC+qm6yvJ5w1CVTCKODzLSifhwFOzT6N54GxEqGmIVjSbQ6W3B3KyngIQ3JeKbq6yFw82kF1pz1tw0lKw9KuWv5nnG2/Kx6VdALn0atOWt2J/kMxad7C8NxX7tuB1i7U668ZrHL7XgC2Kpftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CDsO/xD+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JI5o7T2371713
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:43:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=O5ugIPBXVY+bSmVcPaqTjL75KVknqr+
	nsBD6NtKxUMk=; b=CDsO/xD+5l8X40ykp/bYF40BRflpEtmIDczsm+ITSA7ipUX
	LfPk/khiJmRtLA7V9iYjzZdNQWRcfiP8YLEr5C6p6Iyifv4nz/c5Tkur827afmP6
	SN8FszJmU+26qya26ycw44Krr8G9uWPd5EyeuhV6BbWOUxmFjmcljt6do6lJd8CT
	4qG3t/aNL68tcmskpnQz9wgAuvwPguUsYZ0GHfw5kfcS0UUXdAL+CeTeMKuM3b7N
	R7GEQe6WmnSM9CLnKtqhrsuSra8fDWFRdPzWcMQqS7mzwPpRUBBjNCaezPd7wCNt
	BTRy+MEDHknhgYIwOCy04SRyVRXES1M1vVnJRgA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8vucur71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:43:15 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4826dab501cso3556595b6e.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259394; x=1779864194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5ugIPBXVY+bSmVcPaqTjL75KVknqr+nsBD6NtKxUMk=;
        b=nrLpP08gnTNg+/1TY9LXf9LELjZcTnxWWc/7zl35Mbv79qm9/XL9uKeHCCY83iLR23
         8iBQurIuXb0nRsCIgHl0FNhukSfSp1nk+eEMNSNerUJ3YNVEIyXlZMraOYUECk0V/VSf
         pemOzkZdUU5nQPuZFyB2skD7jqCZxqzLfeiZXxDGG14I2DYG59xdxdbJzUByb5x+y7Eu
         /u8iSJlM1UIWFPQI8A7cdZgCtSXM33nTpo44Rwe7GZpC69owX3FBwdyw8Rs38Of00VVm
         wtjYQcLy9kZ6jmkmLjUArl+F5lnm7VujnYz/OjgcSI+suFMvnMsE2pM57OQ7/HYygwq0
         Knqw==
X-Gm-Message-State: AOJu0Yxxso3IH/40WT1fg3lNlKPbByJVNvuBtrM0Ac2pFs3Gez+D4yt8
	Z17mlDx33062I+bpAeHSB75hiD7uX5KsWeNrlahv2EWQ/X+DW+MDcwwVKOO0EngqHMmnFoDfFUP
	4jZgl5Qofp+5dj8rn0VJp3sDaQIFbpxI9G35Ch/aJ/sHl9Gpue5DhKZpEge0seZF8Ur9X0e1mlA
	sN0hsilAwHIIp4yrPMa5vUDYle3WCssv17FD1+
X-Gm-Gg: Acq92OFJXHpX8y4SpCmM9qJqeUZc6Roo8K/VUUns3Oxz1yPFRbcWQypLbSOq0n7DGal
	RLJYjXON300sH3tZJvHrlnMr0iF8Vn9EBV/M7DXQz6g15hti7shvDnkeiL5cPNFS0AjCAXau8Ai
	dMKKloVoBMjrb1lYU9sVCLF95qd5dFV9sSrUJ79berAkEORD2EXgGA46hzCUGAcgw5TAelzL5Fc
	KilrCv/3rVjH+33bRxgFPfiOVecWg1BqCBJcNIG9qRS9eVMoXE3iNkQZWJPr7qDjtA6s1SlI7ts
	KOfn6gPKTAc/6+0nndbI/svZxVxe0okKW22ejKrl/RI7kafEv1i1MlLqKEmhob9nNxHSQvZGX7b
	r6gNLZaiPZg==
X-Received: by 2002:a05:6808:1c06:b0:484:d5a3:9966 with SMTP id 5614622812f47-484d5a3a304mr8250498b6e.15.1779259394410;
        Tue, 19 May 2026 23:43:14 -0700 (PDT)
X-Received: by 2002:a05:6808:1c06:b0:484:d5a3:9966 with SMTP id 5614622812f47-484d5a3a304mr8250472b6e.15.1779259393898;
        Tue, 19 May 2026 23:43:13 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee5349a5sm7982344b6e.15.2026.05.19.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:43:12 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v7 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue, 19 May 2026 23:43:08 -0700
Message-ID: <20260520064310.4154268-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zDQD4W4ZJz4M53ajmfFpDD96rvHdOHDo
X-Proofpoint-GUID: zDQD4W4ZJz4M53ajmfFpDD96rvHdOHDo
X-Authority-Analysis: v=2.4 cv=Xp/K/1F9 c=1 sm=1 tr=0 ts=6a0d5803 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=FjrsIhHQ_oyyAy4d2L8A:9 a=efpaJB4zofY2dbm2aIRb:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MiBTYWx0ZWRfXyj5CWr34v29r
 vDCIC173Cubw38ntq8DleuNm4HpWJjUSxR27m3/uNlW5W6oTsYXuO9C5O/huOa1kOISt6sDN6ol
 uxZf4aLRWIEc87WscXKvH+y430YrdGDLmu4Z+cYkzL/GhNyE1i0dHR7eP1f7w8vZIMhPvFuXTzy
 vEIJG60WTpc4Kl2Z/5IiLLspEiXNeI8oYA9bcKvv8fhhbOo0NJPfkcLks+INJUuWqpLwblVamsi
 DyxnhIq/uo4WmkLFa0NgSTf1JRSFjo0M4lUIMn5osO+Z2fIqXsQWmsglj9voqH9sxVmM7TD68sa
 Z3QojoaUo8ILnWG1wIxsbbs94YHu5nWrtyjDFr+7BSUrLb/eLAnR+t91x8VGIuT/KXXqqn2Yfez
 gvlfgShGt1AQD3n5tdM7ZiUj04in2EEZZF9JdsRIuGMUE7Nw8x5orm5yygt8g9zdMMDjqV+2B/b
 XrNv8pE8XpGrTvTLWbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289788-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 64BFA58852B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection logic.  The cached
route is reused and fib6_select_path() is never re-invoked, so
the connection stays on the same ECMP path.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path based on the (potentially re-rolled)
   hash.  This is conditioned on fib_multipath_hash_policy == 0 (L3)
   because policies 1-3 compute a deterministic hash from the flow
   keys which must not be overridden.

Patch 1 is the kernel change; patch 2 adds selftests covering SYN
rehash, SYN/ACK rehash, midstream RTO rehash, midstream ACK rehash
(spurious retransmission), PLB rehash, a policy 1 negative test,
a flowlabel leak regression test, and two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes.

Changes since v6: https://lore.kernel.org/netdev/20260517174522.2232057-1-ntspring@meta.com/
- Guard mp_hash assignment with txhash != 0 so that non-TCP callers
  of inet6_csk_route_socket() (e.g., L2TP) fall through to the
  default rt6_multipath_hash() instead of forcing mp_hash to 1
- Initialize txhash in bpf_sk_assign_tcp_reqsk() to avoid reading
  uninitialized slab memory in inet6_csk_route_req()
- Check post-rebuild busywait return status to avoid silent false pass

Changes since v5: https://lore.kernel.org/netdev/20260513204048.2721843-1-ntspring@meta.com/
- Improve selftest reliability: suppress __dst_negative_advice() via
  tcp_retries1=255 in dst rebuild tests so a real RTO cannot trigger
  an unintended rehash; add internal retry to midstream and ACK
  rehash tests to tolerate probabilistic ECMP path selection; fix
  midstream baseline capture to account for packets that bypass tc
  filters during the prio qdisc's TCQ_F_CAN_BYPASS window
- Increase ECMP_REBUILD_ROUNDS default to 10 for reliable regression
  detection with 2-way ECMP; replace sleep with busywait
- Use tcp_allowed_congestion_control instead of changing the host's
  default congestion control for PLB test
- Use (txhash >> 1) ?: 1 to guarantee non-zero mp_hash, since zero
  falls back to rt6_multipath_hash()

Changes since v4: https://lore.kernel.org/netdev/20260507171319.1259115-1-ntspring@meta.com/
- Condition fl6->mp_hash on fib_multipath_hash_policy == 0 to preserve
  deterministic hash policies 1-3 (e.g., symmetric 5-tuple for policy 1)
- Set fl6->mp_hash in tcp_v6_connect() and cookie_v6_check() for
  initial route lookup consistency; move sk_set_txhash() earlier
  (Jakub Kicinski)
- Add policy 1 negative test; improve sysctl save/restore
- Add flowlabel leak test confirming mp_hash does not alter the
  on-wire IPv6 flow label
- Add dst rebuild consistency tests (normal and syncookie) verifying
  that route table changes do not cause unintended ECMP path changes

Changes since v3: https://lore.kernel.org/netdev/20260505193824.2791642-1-ntspring@meta.com/
- Use __sk_dst_reset() instead of sk_dst_reset() since the socket lock
  is held in all three call sites (Eric Dumazet)
- Guard __sk_dst_reset() with sk->sk_family == AF_INET6 since IPv4 ECMP
  does not use sk_txhash for path selection
- Guard __sk_dst_reset() in tcp_plb_check_rehash() with the return value
  of sk_rethink_txhash()
- Move tcp_rsk(req)->txhash initialization before route_req() in
  tcp_conn_request() to avoid reading uninitialized memory
- Add CONFIG_TCP_CONG_DCTCP=m to selftests/net/config for PLB test
- Skip PLB test gracefully if DCTCP is not available
- Save and restore original congestion control algorithm in PLB test
- Default get_netstat_counter() to 0 when counter is not found
- Skip all tests if tcp_syn_linear_timeouts is not available
- Replace bash/pipe data sources with socat OPEN:/dev/zero for
  cleaner process cleanup
- Fix shellcheck warnings

Changes since v2: https://lore.kernel.org/netdev/20260408070514.1840227-1-ntspring@meta.com/
- Retitle "ECMP" to "local ECMP" to distinguish from remote ECMP
  (Neal Cardwell)
- Add fl6->mp_hash propagation in inet6_sk_rebuild_header() (af_inet6.c),
  covering the dst rebuild path used on established sockets
- Remove incorrect ir_iif update from tcp_check_req() in tcp_minisocks.c;
  the SYN/ACK rehash is already handled by tcp_rtx_synack() re-rolling
  txhash which feeds into inet6_csk_route_req()'s mp_hash
  (Eric Dumazet)
- Add ACK rehash and PLB rehash selftests
- Improve selftest reliability

Changes since v1: https://lore.kernel.org/netdev/20260408002802.2448424-1-ntspring@meta.com/
- Use tcp_rsk(req)->txhash instead of jhash_1word(req->num_retrans, ...)
  for ECMP path selection in inet6_csk_route_req(), making the request
  socket path consistent with the established socket path (Eric Dumazet)
- Add comments explaining the >> 1 shift for 31-bit mp_hash range
- Use socat -u (unidirectional) in selftest to avoid SIGPIPE race
- Increase tcp_syn_retries and tcp_syn_linear_timeouts to 25 for
  better rehash coverage

Neil Spring (2):
  tcp: rehash onto different local ECMP path on retransmit timeout
  selftests: net: add local ECMP rehash test

 net/core/filter.c                          |   1 +
 net/ipv4/tcp_input.c                       |   6 +-
 net/ipv4/tcp_plb.c                         |   7 +-
 net/ipv4/tcp_timer.c                       |   4 +
 net/ipv6/af_inet6.c                        |   3 +
 net/ipv6/inet6_connection_sock.c           |   7 +
 net/ipv6/syncookies.c                      |   4 +
 net/ipv6/tcp_ipv6.c                        |  13 +-
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 933 +++++++++++++++++++++
 11 files changed, 975 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta


