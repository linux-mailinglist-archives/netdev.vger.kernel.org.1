Return-Path: <netdev+bounces-288760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHR+FuL+CWqqvwQAu9opvQ
	(envelope-from <netdev+bounces-288760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:46:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBF562C02
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97CD730053C7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313F33CAE7D;
	Sun, 17 May 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VQxBmEDw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9F83C457C
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039930; cv=none; b=eZX1WS6iGdfxSITDj6qlf574SaMLjspu9z6LAlNbYcNsFbnCa9A20VDinQ3LWCg8VF2uURuMpTea/V3SSWFl52qkOwTDcDJjPpxoPPx7/ukkpOQ2O23vLPg99ylTRWiKV3+Aa+vuxj3cLZ4OsqmDjLBW6oW+p4CU85oskyf7to8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039930; c=relaxed/simple;
	bh=kNkNI/8XynKLjIPo6Gtw2lmZjrLtzPz1LeOBAz58KHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIvuErmTLEheu5scc1ZXQbrm3VpPD1h0Knfew+uIaIiPIbxQszI2qEagZt9kGuzcxkS3UnC0fZq53PDoIfvNaM4VqeMxDZIxBh5Q2InP43dYn9JS1DtcufY+zGh0PU1Z6tDJf0Z3tqeXV2CXrqxJjDXjkn7xHiOSbanZsuk3lIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VQxBmEDw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64HHh4Pv1138889
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:45:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=XpCR9Cc4JL6ZGc1pX8ozjC9q6S7skyL
	22FrSAjt8B7M=; b=VQxBmEDweGj3zqz+XiN7Ew0W+qm7GrQ4OBvWlx9dDHm4hgN
	BrG6A/NFAe6z0wbvEWhHlLZMxsCN6JGktAGfGwiSzCvZjIBaxtsQdTspcTWTNEfl
	91fWokH1iNBQdIzeNJ2Use3PEaQxHyr5wOO1v7t6CS+D+B0LuIIjm75AhTJwSKJ3
	CqKtskIZ1TT/E0palpb8f9Bl+QfG9+qlqyzqkozuwNZpje6E3p8NuMJVxfNckHs8
	BNOwoUQYRgAtC4hURgy9MFhmAXwxfTVa8ipQ0eUsqC1wrVuFnBS54Y+nFNSqK2XE
	gXxaDkhL5npla9FryIYsHa3+K/wiXrFsvqgZHVg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by m0089730.ppops.net (PPS) with ESMTPS id 4e6m2nd7md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:45:27 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48270ee051dso2715011b6e.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039926; x=1779644726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpCR9Cc4JL6ZGc1pX8ozjC9q6S7skyL22FrSAjt8B7M=;
        b=jB5uxEGkUZLx1+wYWKNRr8S3ZD+9wxAOZ5QynH94yfKybpP07ktOhtQGJ6iNje+6ig
         CKFcgFqgh/2hQsF7t+MBajg1wiSYZiWQgKU8tFduMJYHc49FkPCqrC0lWTnheZq+3GIj
         rho9VXrkiJ+BCerW3Xyj4juA3HRJbKnSO2VAz6ad90rrzxEGrkQ1uZdJS23IrRWzrzxk
         Z1xXNghqbgrIb7K8fiSRoVaMeqwR6zOTEuKecpbFLyEpSu/KTJWOmNCA28YaAgt8sd0V
         VQqL4XW6TuF3dWh+MCZt9kI2+hx/PWfKCKLHzJ/Sqah02sT48GucN7Z63MidphjnuloC
         P5lw==
X-Gm-Message-State: AOJu0YwknQ8qN8a7jjMiPX8zTXlSy2n9uUWeUZg2Xsn28gsi9YIXS1Er
	jvwD4fk/Qffw6OFpFt0Ph7flzeAfWh3D23biGMCii90moM7YMuHkiGvVQL7a+FgH6owdOrak2bA
	3OOjATCgVLkcpukX1HbQgNXJn1ET0+KNbkJUjz9UbnVXM4Up46Tjs6yJMX7QMX+MEtGTS9G8/1v
	LlCfY63t8vWmBhS8zq5ZXWWBFmdOQ3tJjlfZAG
X-Gm-Gg: Acq92OFiNtto+jqpk7Fjc58exBmCUpxENG5Ci6IXTOijGD22CmrR3tCJVjYtq1rxVCi
	I7Zq2gtT4E+Y9osusxHZWO50ZVblpqEZQsFR8M7xNGSHewV3liRojeIOiYd8/aq0OHaNSvjgd6B
	ww8oly9z00pJ4kw5qM5YcW+YvQT6dFHfzNySuc9nA5dMBGHaBBsdwls1ImE6suoQbLlkv91lfm8
	/4pFudvmstEBvaz5azEc21uI6K1IjK24oEYn0t/Liv2tMr/5dLZppidedf/HldAZOanJdAOv+GH
	tpl/Mbrjxs0GsTeL4A7M0LF2h+8OtKN4mmKwYP0GlX5cdx6kT2RpV+cg3MAouJnn6IAvEzGLgZT
	4cASV3d4RZA==
X-Received: by 2002:a05:6808:1a07:b0:482:5bd1:d8e5 with SMTP id 5614622812f47-482e55afc67mr7658647b6e.9.1779039926019;
        Sun, 17 May 2026 10:45:26 -0700 (PDT)
X-Received: by 2002:a05:6808:1a07:b0:482:5bd1:d8e5 with SMTP id 5614622812f47-482e55afc67mr7658617b6e.9.1779039925448;
        Sun, 17 May 2026 10:45:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fd54desm2136691fac.8.2026.05.17.10.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:45:24 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v6 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Sun, 17 May 2026 10:45:20 -0700
Message-ID: <20260517174522.2232057-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MSBTYWx0ZWRfXy66vljRXKVfh
 g4zNshu98UdtLURIFgTTXJdbrOHqc7s+du4yjJLyBdFlhX2bNtGDmT14pVAg6LP6M7tbdNY67ML
 wjMBaxhyfggvpayOjfH8SuZvhTDoC71mk1IWJF8bg6cS6Mq6eER5vCkDE43sqG435ipOAJdFBOX
 Uw8THrlfM/FTKPBr3E2QkcZLZ6fCrTbwrJ0MXH+IC4eyKfUiSkAvTfGK87ghnGX1RifOyqsUU8P
 g3DKbf5JJSQBr1IFWFyKujTKA2pTgQvzrSamyIOOdUYZ07MvT5HUbj0quNcKQ7l2AX9VYg4WJsh
 q9fWHk8eXXlMRUnsgq2wHLqcdW7Lj3TScpiJGT5MtlAoTfcAhoFUKt+52VZNQMmcbSWXq7HlkuP
 UmvHwhbdCbIESviHY/Mvf1CS0x5WzM8R6GQFc8Wk4yulDT3JMATDYoyIuETN9/AVVZESUarafzN
 gyqrL1/GGTcNHhrl/MQ==
X-Proofpoint-GUID: wg71UPUs-mwQh0QgS8FHkGMJH6ujngyL
X-Authority-Analysis: v=2.4 cv=HJHz0Itv c=1 sm=1 tr=0 ts=6a09feb7 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=IdTnusCh2XOMSKVXdlMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: wg71UPUs-mwQh0QgS8FHkGMJH6ujngyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Rspamd-Queue-Id: EFEBF562C02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288760-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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

 net/ipv4/tcp_input.c                       |   6 +-
 net/ipv4/tcp_plb.c                         |   7 +-
 net/ipv4/tcp_timer.c                       |   4 +
 net/ipv6/af_inet6.c                        |   3 +
 net/ipv6/inet6_connection_sock.c           |   6 +
 net/ipv6/syncookies.c                      |   3 +
 net/ipv6/tcp_ipv6.c                        |  13 +-
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 923 +++++++++++++++++++++
 10 files changed, 962 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta


