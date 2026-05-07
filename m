Return-Path: <netdev+bounces-285438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGi9EkPI/Gn1TgAAu9opvQ
	(envelope-from <netdev+bounces-285438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:13:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCE4ECBDC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A92D63013028
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9C44D6B4;
	Thu,  7 May 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="oTppYpWH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1544E02A
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174013; cv=none; b=Hi2/L0fkxb00Lo7vRtEO8Tn18ztAUPIJnCA8b1MWStOHuzuqmX6WLermabITfal+giGug8iYH+CMKP58oHb2sM6lvpQmz795lv3WNg/tg3R+GbUSgE3d+va/20b2E1FBfNYt8J6viHUdJFj+arrgtMUrrNbQcnWrCFsEf3pI1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174013; c=relaxed/simple;
	bh=qyI8BjmsPESQ0kkpXf+Rmuvb0uNigO4MQQU/MatMW4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMn6dbXgjs+NbtqTfjhMBP3jO9EcFMp1u1eAivHOGjOcPhx2ajDPpGpVaGB5uKZIPyr96Y1+3vSs2Kx735wfIO+iOX5iC8flQS5mbvIwM6Hpb3UhEdTNz4M1y6S9fUdoVbcdOwRK32W+PkU/DM9CHqK/EcUiVWPYlt/qGUkx9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=oTppYpWH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647H3QUR1335254
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 10:13:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=6SsGNqa1TMaD0jKEC86Q7klJJ6lfLfw
	RiAZEPwK2SL0=; b=oTppYpWHXNhfaoRs49SZTA57IHpRr1Jgyl+SPnIvtEOLaMj
	Mk3SuYQyvSCaLAbrG3JY9tMVZMfwuf0zXPkDW+mvtdpMhNvwpLtjpLPB5o0L2kNE
	gvov+HDDP57YLpe55T2GCdG9gqX8olAg2l9CIsCWGN5PMJ6pKB60hdJcnEHl22Qu
	9EQj+1FagKkkXixGAVk+kLIMquKwCTPIio5du2T+T9QYY0fcaKCE3N31p83+NP6m
	2Hqe0VVjVjgxc03kLj69HPTd0CQk/pZlJK6Ij4+8f4Er9jkcg/69TEepgGJ8O+Jx
	Yso0pFZzys7rzEC7cmSviJd/VqNsQSuOHcNoJuw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx2uj5u98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:13:22 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69996a2944dso2315295eaf.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174001; x=1778778801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SsGNqa1TMaD0jKEC86Q7klJJ6lfLfwRiAZEPwK2SL0=;
        b=UFPSd5YwzcexfspRxKiz4Ja3J9d4GKK8K/G932mw0gKTrnLaAesyavwX6E6rQdDu97
         RVipHUTsqxmk7TfQn/r8UeIbC+X0WbQCrqwpNg5nnVoDs3DtRyQZmsgRhkDZ59iUpTv4
         uMhTstKiMw3IZnHXJyVdW2VZVSCOa4O5BcTLZcXnl6jAFk2a5OoVsh1oelVP6AsEJ4Ob
         tXu1w6WtCWWka8f+l4oqmKD5xsmC8ZtmbZ2FymLM7PDS7NA9Z0dAxa4xa9NVLcfoxnrF
         6+jFKL7LWRDR9Q4jXJK4wHNAp9x72KB4JrmGI74tLQJjECahqKQLneUziJu7wVpIskeP
         CYDA==
X-Gm-Message-State: AOJu0YzvLVCek4lZRv9nxZEM9r0NZzlG/HYL7WA44VhRqJ0V1kPqQ1X3
	gTT811WYoZEGmzWdD1Vn9KwOWiE2f1vL9JBSjQkXXzytrgLpkvH6qCPYtXJuDGKTsvAPH5beurN
	rjT5vbr9CWVCNfhGClycnA1bFKcwdiV0U93Q/TN1HcsqQ7qN5wlc7mz28mISVOP50efMO84oSKg
	v/kOsT8j+izs3c5x7c9GQrBgpp5ssnwl4zoL+q
X-Gm-Gg: AeBDietWGJBhojY9ZuFz66fGaw0JNgqaEoqL5fCXMNwxq8yu+PHcwMSX5NF9vVan599
	lq3wFttnnQ7bv+DDeTFJVJPrceb1t3CEBVKSyZddPF18L0PRCnXRZSNgFiu/M4apx//AbFNI3ge
	t7GleFjtEFv0wJ824et6XAqNn4xD5v5SkhDVdmp05lB2Q1ajX12NvCeiNvuBwdPJwgqKP9Y26Yj
	n29QtJqBJpA+69pDXr4x+fZkbwN7MY45jvEs5sTvtkndVHEIzUQ9F499RpOv9kpLn0RN7XpJDZ0
	MlINt7PHtedRXnBPjFPbfbAHpvFoY8rJghHRnsCzvrTj7waz4HOJ980i4t8wDiHHD0it1w13itG
	0e/84DsrDBw==
X-Received: by 2002:a05:6820:4b89:b0:695:c0e2:38e8 with SMTP id 006d021491bc7-69998d10104mr5019306eaf.32.1778174001374;
        Thu, 07 May 2026 10:13:21 -0700 (PDT)
X-Received: by 2002:a05:6820:4b89:b0:695:c0e2:38e8 with SMTP id 006d021491bc7-69998d10104mr5019272eaf.32.1778174000850;
        Thu, 07 May 2026 10:13:20 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4354b0bc35esm202600fac.2.2026.05.07.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:13:20 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v4 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Thu,  7 May 2026 10:13:17 -0700
Message-ID: <20260507171319.1259115-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T2oV5pf1VteNF7D5gvwAFjRsT4UVe-HN
X-Proofpoint-GUID: T2oV5pf1VteNF7D5gvwAFjRsT4UVe-HN
X-Authority-Analysis: v=2.4 cv=DtFmPm/+ c=1 sm=1 tr=0 ts=69fcc832 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=vURIu9es5igc0G7EWQkA:9 a=WZGXeFmKUf7gPmL3hEjn:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MyBTYWx0ZWRfX9XmZNcROoPLb
 UMkHR7SedS4/Wo27HI2mOXWHhnImIkAYa1m4jVeLMpCc4KiVFYbH3VQw1GW8FgB80QEWF6MFjKd
 4PSHcnS88iXObPgPKYJft+Hp2WoqoFqv1ePh7E6V3n/kKbLhJBzyUPPxyd4f2Z2bf66cIiY0RMj
 lWEq66Oa3xQnLn8znC5IZ9BpRcqIbTNSWWKx3rvO16LioXibr+5cgrjLMUq7EFulQvav4trblW8
 3sguUOiqJvu/7q0kEY4UqKk1uUnKmxlN4tWg2hcSi44hAx9uzs+iPZthE01tIq5wdFcv06iNEgq
 W1CQnzRYlnXD6XxTrZBZPa4j3g5VDpUNMJ1QIatFM+1nh9BC1ZlLyjZiG3cPfIyFDJOTmZr8KC6
 hSVQi6HCU77OttsbuWDTLf9N29u9mg+txvfcKFKCu5jA51/bwhvTJDCdjFouBvQjkhBbLyv3s1s
 tNIrfjXvRfPc5iGPpkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: CADCE4ECBDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285438-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Make TCP retransmission timeouts select a different ECMP path for IPv6.

Currently sk_rethink_txhash() changes the socket's txhash on RTO, but the
cached route is reused and the new hash is not propagated into the ECMP
path selection logic.  This series adds __sk_dst_reset() alongside
sk_rethink_txhash() to force a fresh route lookup, and sets fl6->mp_hash
from sk_txhash so fib6_select_path() picks a path based on the new hash.

Five selftest scenarios verify the behavior across connection setup and
established flows, forward and reverse path failures, and PLB:

  - SYN retransmission (forward path blocked during setup)
  - SYN/ACK retransmission (reverse path blocked during setup)
  - Midstream RTO (forward path blocked on established connection)
  - Midstream ACK rehash (reverse path blocked on established connection)
  - PLB rehash (ECN-driven congestion on established connection)

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
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 582 +++++++++++++++++++++
 8 files changed, 607 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.53.0-Meta


