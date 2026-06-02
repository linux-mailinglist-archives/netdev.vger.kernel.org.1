Return-Path: <netdev+bounces-294328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hxfnErAdH2qaggAAu9opvQ
	(envelope-from <netdev+bounces-294328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:15:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B00630FB5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=lC62NuoY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294328-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D10303D35B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931F37CD48;
	Tue,  2 Jun 2026 18:14:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF738CFE1
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:14:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424079; cv=none; b=fGZckkaibMAqCYdiwtg5WZYctWZtHbMNmLwioidMiABC4l2RYUwjyqr0m/Q/N4izBqoEsARCYmpUvA7VBabXFsJpYocG5BHt/WhrM2AJULFObZc5+wV5qPSslhzhilEoTBuCP26fWRWiUIAIFgHhZDXEsIBYPsGR/jl8+V0pw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424079; c=relaxed/simple;
	bh=hh/lAbwHBhS1YSawkm/umA1sOZR28ueDNMwsw05hfUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcKS/hgfvw1v48MOzN6QeChO1s8S+inY6R6FMoeNZ2g+qhalxrxP8LDFYMnDf0Ly9pb14Nsp54U7Oi5fhv8Phyzh3oJANZo/kG2vzvtVNSO6jOw+HuO4JyNm2yeJojb580fgd3pCwxpTh4PNF/n1eHHLv3ft3nliMMUqxqB2zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lC62NuoY; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 652EQn5N1101939
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 11:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=3gJqr66erQ11XLwdrsV1w+OwfLmMn1H
	JYnol7DS7514=; b=lC62NuoYcjsTPnJ8gdyTPGuvgf1NYQs8NxD0vObQSzz7oJj
	ZYkTNRnSRaCnititJJFPKsGscoGi/qxUzO8FMP/3YLQuGLA1O9+j03TrW0YY4hAy
	ZvEG8Eb0sEFVR/yMyert6yiD6bXJooJtFjK4SHyiIsGMhJtXPXY2a5YT3JB+8pO9
	/vW7aprhmuvfLzfyS52YNvhaIzgfMLfhxhZJqk67traMghP+6ffEurVZiVOtz1VK
	EsKkGOYeb4QIZFwCuWceNcwCGP2YuV0licWU43Mvx6eKMdyEr7ob1f9p41hiaboW
	M/H5J/cSleo9T2Z50vRvLV2xY3/O0F6/6tSYjPg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ej0xp1mxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:14:31 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4865626337fso365508b6e.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424071; x=1781028871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gJqr66erQ11XLwdrsV1w+OwfLmMn1HJYnol7DS7514=;
        b=GDIHAGy8eHFMKEGAe7AhcktUPFi1Q6ZGKju+g5bJbnAGVRyEauWGcBPuO0+0PpQy6w
         tPigv2RAPsO6PFZN+5LRCDfK/BZOzkX3Cs/Velx5+JRjZZoWfu9yxpAa1IuwwHirbmhq
         62wO7b1V9khz6JvgkSFlktRCeO5A6PgujO2LtqLlVWmO6qehF5awO0P91FoZX/nl2Ab0
         +MPCmRGQbRWfk5ifIYSIb/1lyh6+bPbj/huFk9qsebaGFGNO+qfQkQZFHzO8ztZp3jAP
         xaCEgmFN063fMtu8bRrGsiXLx+wm1CjNDun+xyd0i7m/lNeQ27+AVIZEq455mbR1P3q8
         6w+Q==
X-Gm-Message-State: AOJu0YygI+OYINKF6MbHalfKJfXl9tQHUvjgB4xPFyfd+ucMAzAOB73l
	GtbcPmeTeO0pSIOv2pAgKr/TTnG62f4DzNgbWeSHJrtzK3Mb3pni1dKJnul3gvZhYatJxpthbLm
	brXtsIjcVguiqOJ+2s8bkuTfYtwwdX4jVSTzZgA828uKMm/kQsK+J+Ypj41P5tk4w2faTE3C7SD
	oaHQB5tZpsR0GIM53ThIqX0RF3NhfzWzNRuVqw
X-Gm-Gg: Acq92OEC6445iqGzBIZkFapmJGXD/vWHz6l288r2KfD4a8HrSgEUqmpZFUYNuyX6n+V
	r3qub2qsvyFXwM5r8fZ8dsZtYJHre5Udm0/Yaue14mtGxfSO2c2veHjkG5lqz49v1nG7nY+p/W+
	K5of3FIajkHwa9S2NIgRY7yLhFYj2D2kgEGg/r24pv9cuwSlSbbaikVxjLgor052ShUN0mc53yX
	e2rtlErmMXJBz2siETvdSu/ma8/v6uxt7/6Nm5ALHnTRgT1+nwGRV7ZeexRLcOocx1ZmOYARtC1
	3DzgsF+vlCo84qzW7VrrslKprHe0HtORZ9X0GwqM2LzmsWIrj88LFlV9xeJ5MKa9+0HH+UUpeK+
	z8HcdV+Ph4DQYc2kQ/8nCSg==
X-Received: by 2002:a05:6808:80b3:b0:47c:3733:255a with SMTP id 5614622812f47-48656ec7877mr630085b6e.16.1780424070812;
        Tue, 02 Jun 2026 11:14:30 -0700 (PDT)
X-Received: by 2002:a05:6808:80b3:b0:47c:3733:255a with SMTP id 5614622812f47-48656ec7877mr630046b6e.16.1780424070204;
        Tue, 02 Jun 2026 11:14:30 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e14b9sm51787a34.13.2026.06.02.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:14:29 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v11 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue,  2 Jun 2026 11:14:26 -0700
Message-ID: <20260602181428.2318919-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZPHnX37b c=1 sm=1 tr=0 ts=6a1f1d87 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=eOgIIEJ8Q39cyHai93oA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ai9a0o-j1WCqPDinVbECYrm5jGxQ4hni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3NiBTYWx0ZWRfX4D8xO0odyhZQ
 5rywgv33e94BUZGI+a0FK8sRJJTUyC6kqhsykSn5p8TfAH4IZOsuY67peY14mU3UB3f7N0GjAPq
 taiYM2QRGYzDdMIMOeYiAWC2uTkM2qf4AlBpP23rYGikrTHI6kRQRdR3lm6uNWBY1DeCezoT84W
 VDjUmn/lBkSHAMzKdrzQlGF1nvTmed9q7X386CaBycM5M/uGuep9hY/7UhBreKqmSxFHN5xRoaF
 k5fdGfgzU7e/1j49yg9C/kLRJPx7ztk30noq+CIfWyc42cAEtTFlMoE0uUZXDPwAZfhm2u1i0NA
 trWtO5fU/aeTENF9hgFlNKZSlxHsURHR19/OYhPNCsxfOAKyZL6qX7ybN1VKIFpMbSkIzk/VNFG
 gmPJvE+whLpbUeHZdJPxVAd3Ej1AFQKV6FU1xXRHhO2hzGkyWBEYK4VJJldw+ktVauj3Bibk6+6
 ehTnVCdgEqh+udBgwfg==
X-Proofpoint-ORIG-GUID: ai9a0o-j1WCqPDinVbECYrm5jGxQ4hni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294328-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:ntspring@meta.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,meta.com:mid,meta.com:from_mime,meta.com:dkim];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8B00630FB5

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection logic.  The cached
route is reused and fib6_select_path() is never re-invoked, so
the connection uses the same local ECMP decision.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path based on the (potentially re-rolled)
   hash.  This only applies to fib_multipath_hash_policy 0 (the
   default L3 policy).  Policy 0 is already asymmetric for TCP: with
   auto_flowlabels enabled (the default), each socket gets a per-socket
   flowlabel, so the hash is already per-connection and unidirectional.
   Policies 1-3 exist for operators who need deterministic symmetric
   hashing (e.g., for stateful middleboxes) and are left unchanged.

Patch 1 is the kernel change; patch 2 adds selftests covering SYN
rehash, SYN/ACK rehash, midstream RTO rehash, midstream ACK rehash
(spurious retransmission), PLB rehash, a policy 1 negative test,
a flowlabel leak regression test, two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes, and a
syncookie server path consistency test verifying that the SYN-ACK
and post-cookie ACKs use the same ECMP nexthop.

Changes since v10: https://lore.kernel.org/netdev/20260529160136.1010064-1-ntspring@meta.com/
Patch 1:
- Fix build without CONFIG_SYN_COOKIES
- Leave IPv4 syncookie txhash unmodified (`net_tx_rndhash()`)
- Document the IPv6 TCP policy 0 behavior change in ip-sysctl.rst
Patch 2:
- Correct runtime estimate from ~15s to ~60s
- Build DCTCP as `=y` instead of `=m` to avoid module load races
- Fix false failure of the midstream ACK test by limiting the send
  buffer to avoid a closed receive window; window probes do not
  cause rehash

Changes since v9: https://lore.kernel.org/netdev/20260526203403.3517607-1-ntspring@meta.com/
Patch 1:
- Split cookie_init_sequence() into pure computation and a new
  cookie_record_sent() helper for the side effects; call
  cookie_record_sent() after route_req() succeeds so the overflow
  timestamp and SYNCOOKIESSENT counter are not bumped when no
  SYN-ACK is sent
Patch 2:
- Make midstream ACK rehash test more reliable by blocking the unused
  path first
- Fix port overlap when ECMP_REBUILD_ROUNDS exceeds the default

Changes since v8: https://lore.kernel.org/netdev/20260522215733.929238-1-ntspring@meta.com/
Patch 1:
- Fix REPFLOW flowlabel reflection for syncookie SYN-ACKs: pass 0 as
  tw_isn to route_req() so tcp_v6_init_req() saves ireq->pktopts
Patch 2:
- Give midstream and ACK rehash attempt helpers distinct failure
  messages (no TX activity vs no data on alternate path vs counter
  not incrementing) instead of a single generic error
- Drop unused ns_server parameter from ecmp_dst_rebuild_check()
- Clean up server socat before break on setup failure in the dst
  rebuild loop

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

 Documentation/networking/ip-sysctl.rst     |    5 +-
 include/net/tcp.h                          |   20 +-
 net/core/filter.c                          |    1 +
 net/ipv4/syncookies.c                      |   11 +-
 net/ipv4/tcp_input.c                       |   15 +-
 net/ipv4/tcp_plb.c                         |    5 +-
 net/ipv4/tcp_timer.c                       |    2 +
 net/ipv6/af_inet6.c                        |    3 +
 net/ipv6/inet6_connection_sock.c           |    8 +
 net/ipv6/syncookies.c                      |    4 +
 net/ipv6/tcp_ipv6.c                        |   13 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1066 ++++++++++++++++++++
 14 files changed, 1140 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh


base-commit: c1e5127b577c6b88fa48e532616932ae978528d5
--
2.53.0-Meta


