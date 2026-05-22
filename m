Return-Path: <netdev+bounces-290929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN2fDljREGpyeAYAu9opvQ
	(envelope-from <netdev+bounces-290929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B125BAD35
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BD3F300B462
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058538F633;
	Fri, 22 May 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FTEQ8CZr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99805374E6C
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487059; cv=none; b=a4aKaemsVtGpnxh07H9hdpn3ylcwhU56fcZTlf57MPTnvryCjBA2YCJO2/Xlpcerkk+PNNPk8I/kJ5bnwM0F2Yon4ntP22aPptII2APFVtMR8kLOsVsvbuvv57A8XPtaieLOZcfVCb/i2WKXFXIXNtyRzf5yBbCgKlon4a/ZxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487059; c=relaxed/simple;
	bh=juil23xToy9CQ8hrlNcwOM0/VzXLtL5uef1zMIkRi/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSnUARac+TAikyzV/k6Gt/JXAc/cjND7VzGTpWdpm/ytcZtTJ8KjPJchks1G0BklTQ2H5mS+MRqA4c+AahNOM5VH9WPRxz+WSNimacMUOva7qqqPKIyRGbAcOmTWBdXahxdRX+jQbjqI4ntWc2igYxHA209Itl9BUqWB/00HPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FTEQ8CZr; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M4tD7n2977785
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:57:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=WsnLCyDet0IE96jpLaIya/EHaqC1Px4
	MftDg7/35Ods=; b=FTEQ8CZr/b9qCpAOtn3KwkTAeF94NaXvfPHTHdk4nP4opY6
	uqItIZtIISQTeClTnHMbdq7DyaoyjIET/0YBZdEslniMy3fWE1hjl3/4gVWBepCM
	cd1xRZikNg/vAEoGd6SH3C1GEQCQkSCpEH7MsdK8iGBxSOcXnY6YCT3Y7BC4KdcS
	51OhpY9Z/knNWIJ0gxpcNLtx3cgjBPs/qviJdMg6w/buqQt76NvVaTZJh7KZ2gSm
	VYUEMP9Iseec+DYzdewXFZnAb6dh3riPbUTzlQqZSKm39yLMpT4UuMVaIaGbFCYL
	HKAv3Zp+1TnCrizUmowANNfNCQ4u+imONKNbwbQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e9yy1kd03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:57:36 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4346755f7dcso14165100fac.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487056; x=1780091856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsnLCyDet0IE96jpLaIya/EHaqC1Px4MftDg7/35Ods=;
        b=JxcxF4Wkwx/zTxBz8J5+W1llZVWVLANWwhZUUYIxxWvxfwugkoz+DXFrpUVFfVpVss
         +1ud0MfHBdOSrEEMvn2jDO6sMGkHcsUDPxIenpqFNEwbxwdJX0yrMbSrPH4yKkzw61Qo
         27+pdHeUdsuB7b62eGUajzy5BeFfW8b1s52G1nnaSvlhuqeSTwpiEp5t7IOzZ0dmhAto
         RMuWMuFiLFifqgROpaQfzc9ad8zx2QWIoVw9+9I2MBlmhcS7vQaZaS51b6GW0kyG0x1i
         Va7Io2fbfIzrJ5n7+vE2IQPvJ0nIwK8fKUKq288gRCtE0vJoeoeJGdkeqnlpFbPYgD0Z
         ifHw==
X-Gm-Message-State: AOJu0YyEy3Q7spZHJxjlcOXj2uijDdg7mb3QcMfsaEnBlAJPj+W170dC
	HdSyAeiLM3YsmaxpQtElcdCRx5Vl0gfIeODh9ehYbvQq/XBraiTQ4v1SZAuPOqBvF6gg3+6QUyp
	nGe07VGVll6+CDepwdk+TA3xTBL0ULNqkVksH2eMCMnMZXiHz5I47q9sUnsOb8dT0SKSCd6/EsD
	982NhwYFHt3UyKWePFJYqybiOIVTth/wB0RMGt
X-Gm-Gg: Acq92OFUuhCP6j8V78UE/g5kWcnCk8+MX2mb2LUwOVFlcLkBypVrLBTtNIZ+L4O6pba
	IpiYUDxULZqHb8vx8ekDoDlTh09NjmPMRKUys81ZXZZXL5PckZuxTfR0Bp62jtv/SY2SyXs6kh0
	q3xJ4EOOk1qKXkZgssadWi+0nSCMleSn+073+4pk4n/Q0kLgkSEnJakr7aRamUWkz4Qc5M1FhsN
	jHwvQsGXZYIo8AjTw3GNy0wOFPZdICXAaixkuWQ+LnLW5//cvRcze7k44zerDLHKGNld1E2R2qd
	Q0KRtgcsgIztTuKTCEfFP15FEqeHm/huHYtTPI7uiLuzfcP/YfqZEJvo35ftWZHFyxsNUw19trm
	u1tCo4Rkm9Q==
X-Received: by 2002:a05:6820:8c6:b0:696:8325:f7eb with SMTP id 006d021491bc7-69d7ecd0c9amr2823572eaf.45.1779487055523;
        Fri, 22 May 2026 14:57:35 -0700 (PDT)
X-Received: by 2002:a05:6820:8c6:b0:696:8325:f7eb with SMTP id 006d021491bc7-69d7ecd0c9amr2823549eaf.45.1779487054977;
        Fri, 22 May 2026 14:57:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83a4db17sm1485917eaf.9.2026.05.22.14.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:57:34 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v8 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Fri, 22 May 2026 14:57:31 -0700
Message-ID: <20260522215733.929238-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxOCBTYWx0ZWRfX0xO6ZHbzgpZm
 J4LCK5sDzRPkS8Z3RIgc0GRmvEkq3J4/IrjTRLkw6qYLQrphntrkFAVtsujHkK4wVYbfeZ4qjfX
 ApurrVH2qIQFF918R/JVKAt9Li3wJGbp1Ah2fgOmRKWgMfJu+vsI7/ZsQRUauJ38RMGNnhNbWYc
 Ev0AStd10UKLVjH2ynxr2IekmEm886OmvKR86uv+87oa1Avy+lCGpjYRqTcllvQbeNv+S6UlIlw
 7GII4Wr/JAU7fWuv1o8TtV/3mvhCCtr5cCgF9pUgz7c56BHvqqvi3Gd9trKVtxa/IQWXN5iMr5q
 +FuU1Eox0jTXYHztw+HZNgd5DQQb4rMyqWs2cIIk4Ht1xrpFaZ/p1RKDUMSFYLqNLV1QCvcjOJ1
 dINggtDjovYjYs8j+sxafSQGikssEHw8HIl7syKoek9qo+O3Ju3OTuNpnrkN14F3lRQekPjRbBJ
 XI2qwajc1nSFTy1B/FA==
X-Proofpoint-ORIG-GUID: rrC6HO2amfe1lK_3Tu3j3stEyHiXc9Su
X-Authority-Analysis: v=2.4 cv=c5Cbhx9l c=1 sm=1 tr=0 ts=6a10d150 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=Tm2zCBzp3FQG0QxiXacA:9 a=1zu1i0D7hVQfj8NKfPKu:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: rrC6HO2amfe1lK_3Tu3j3stEyHiXc9Su
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290929-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C4B125BAD35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection logic.  The cached
route is reused and fib6_select_path() is never re-invoked, so
so the connection uses the same local ECMP decision.

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
a flowlabel leak regression test, two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes, and a
syncookie server path consistency test verifying that the SYN-ACK
and post-cookie ACKs use the same ECMP nexthop.

I'd like guidance on whether to use the ISN as txhash when using
syncookies; it keeps the SYN-ACK and subsequent data path consistent,
but one could argue that this consistency doesn't matter because no
reordering is possible.

Changes since v7: https://lore.kernel.org/netdev/20260520064310.4154268-1-ntspring@meta.com/
Patch 1:
- Remove #if IS_ENABLED(CONFIG_IPV6) guards around __sk_dst_reset()
  in tcp_plb.c and tcp_timer.c (Eric Dumazet)
- Guard mp_hash in inet6_csk_route_socket() on sk_protocol == IPPROTO_TCP
  instead of txhash != 0, since non-TCP callers like L2TP set sk_txhash
  in __ip6_datagram_connect() and should retain flow-key-based ECMP
- Use the syncookie (ISN) as txhash for both the SYN-ACK route lookup
  and cookie_v6_check() socket creation, so the server's ECMP selection is
  consistent across the stateless SYN-ACK and the subsequent full socket.
  Move cookie_init_sequence() before route_req() in tcp_conn_request()
  so the SYN-ACK dst is computed with the cookie-derived txhash; derive
  txhash from snt_isn in cookie_tcp_reqsk_init() to match
Patch 2:
- Invalidate dst via dummy route add/del instead of route replace to
  avoid a transient single-nexthop state during multipath replacement
- Add syncookie server path consistency test verifying the SYN-ACK and
  post-cookie ACKs use the same ECMP path
- Strengthen policy 1 negative test to wait for multiple rehash attempts
  and verify SYNs landed on exactly one interface

Changes since v6: https://lore.kernel.org/netdev/20260517174522.2232057-1-ntspring@meta.com/
- Guard mp_hash assignment so that non-TCP callers of
  inet6_csk_route_socket() fall through to rt6_multipath_hash()
  (superseded in v8 by sk_protocol == IPPROTO_TCP guard)
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
 net/ipv4/tcp_plb.c                         |   5 +-
 net/ipv4/tcp_timer.c                       |   2 +
 net/ipv6/af_inet6.c                        |   3 +
 net/ipv6/inet6_connection_sock.c           |   7 +
 net/ipv6/syncookies.c                      |   4 +
 net/ipv6/tcp_ipv6.c                        |  13 +-
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 952 +++++++++++++++++++++
 11 files changed, 990 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta


