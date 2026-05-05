Return-Path: <netdev+bounces-284569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG55CTpH+mmOLwMAu9opvQ
	(envelope-from <netdev+bounces-284569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94A4D32A2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A210330465D0
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76F3CBE74;
	Tue,  5 May 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NrSofcGI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A23271441
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009909; cv=none; b=OlyRgHoPcAtZYGdcX81JYytmlmclqamfU9mXgmqxGhv6tLPruOOIAYM/pQZDBwys8IMhcMlrCCqgsMWsVkfdCQtIk/cujmyhr2DTS7aDTccT1+BNhGhPE7B81basWiElTwxRimWYSdkXaJSUCTT0ZAGWyRton+jXXomj9oOWF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009909; c=relaxed/simple;
	bh=AgYz1Ti4oS5DrEsXDizKRSUqjkq4nL83EFWJ7YmNWMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=givNpWqXFcQ9VsBkuuemjvtmeOmDg2WSr7Ua0ZklaCmsKEdrIXU8q79BTbbLSvwDU+Czq4UPxI2ksvoQEwbMtlmDwQuZsXAy22wQ2YdHcAudmkURmgX3nyzV6BZ62Y52FpG2q9mFMXkqP6y7K7nzKSAALJTjZ0aYQGLSxAQrwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NrSofcGI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFg2Q3782578
	for <netdev@vger.kernel.org>; Tue, 5 May 2026 12:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=w7UcPFLo2Fpgf5OGaRbL16PX9a9wwYT
	3m9p5sjRZuAs=; b=NrSofcGIhgr/QFTDpsTLSJYnxiyiwn2IRZ1O8OoXdnUxTn8
	FnHTV8PFJq8fGEViUAXHeUwFabeaL7MXrxyQIsVb3qlppAZv5SmpvUp0fZkRyU+W
	y6rLirhmylhdstOWDf9Dr3nhtxnq4p6RWXmmH7LNs2bhZKLw1OEQ6YOAphg7ss5b
	UCHDN5zQ29wa/y8YCUPwK5M/J2WwTfWzqg8+yYQpOHOLkEi8+pudxEie1FWCl5Kb
	VRR/qfidYvy+yigXIcpVbaXH6lEVFdfh0WYFe+V5qwkX2CACc2Ti8/3ljU4NPt+X
	SnEMcd9HWYZdnCarBmNaY7hx7LJZUYPtK03XyIQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx2uhqcmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:38:27 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-46fec31defdso567042b6e.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009906; x=1778614706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7UcPFLo2Fpgf5OGaRbL16PX9a9wwYT3m9p5sjRZuAs=;
        b=fo3KxsjH2fWn+mDxsXRyNJfFr1x+ztWZ/VKtLqqileG+Wg5uqNkbV9M2wpbA/7gAMQ
         Zz7K1h/TsiqAZPslNwYPn8g6Enypjk3m0oZ3874Cr5UpMP+UwA47K80OISaCK/eJxlAL
         qzB+KDsTdUKwJNhct5iOjIQVkoIpdbv+IDEnn4o+hnQiknYkca3MI+IbhLr344k4C2Sq
         5FR+s2MTU2mw/6U44sebeHmutWITzYHtulkKSz56er7AetjqR4e1X8j8yp7dU4Q2hmQ9
         hDhRdHtv2sNBcAYAFHyfpx7coJlxEZAEJ5RK6VJ5Vm1/KAvpOf6onWq+hbINM1b8u+I/
         VaAA==
X-Gm-Message-State: AOJu0YzCqwMu0090VbFr7eI1RRFM2sig/g2Dhj03rbOs3EweqPmRxS7A
	SltNBgD2CAOQfV8i9hWyO+x1hZ800cO3l2e0r4bDgSMr1MCutf7jScIrQ7lc/qD7XBaaIi9e/fG
	Mpxd8stv3pB94ziaDQYIDur3/n7cEv+sW27tXgDNdSmW74Ob/N3leYlmECzgb7FR8o3Z/+jRqjb
	LvQ3Wk6Eb3nf1ikIov204Q0ep7Pd15vmk9jNKT
X-Gm-Gg: AeBDietIw0ZkOpjLAZAI4yeUfX/Z9rpgzQLKY337cAV4NrmU0lxO9U23/2pcmAsy52w
	1cQWOZT6wY4iQ0j3xqkJogLYcTiVsrRDr/fkNPtypFFDI9AxPxp2yQhQrftqNIdL8K1cruXYCJO
	dBXg2wyW2yBpp+SoWXBFiBR1zdyIuGddwHwg4TQtkAfmB48qe9+eF0hWeLM08a/ne+9QSU4Z4Kf
	T6xhi/V+useihupzYwB9vX7I3qeVcfVE6IFOWlZaHbMbX6Ftiu7S9Sj6UNOVnBsq8Kl7HMdWZKG
	fn1ZPwSYfZpKAba3guvov/8aUvuqvSTZv3GWXAFuZ9bOpUW+XCr/h0xlIxATa5WTvb7zcpLSbyy
	0kpIIHdkgvI1OEEbBhg==
X-Received: by 2002:a05:6808:1917:b0:479:e96e:65b6 with SMTP id 5614622812f47-480428e14fdmr223874b6e.13.1778009905787;
        Tue, 05 May 2026 12:38:25 -0700 (PDT)
X-Received: by 2002:a05:6808:1917:b0:479:e96e:65b6 with SMTP id 5614622812f47-480428e14fdmr223858b6e.13.1778009905227;
        Tue, 05 May 2026 12:38:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b2ef3sm9262623b6e.2.2026.05.05.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:38:24 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
        ntspring@meta.com
Subject: [PATCH net-next v3 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue,  5 May 2026 12:38:22 -0700
Message-ID: <20260505193824.2791642-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P2nlxDGLKYXi6Z1ZvkmqfVpYq_uhan7m
X-Proofpoint-GUID: P2nlxDGLKYXi6Z1ZvkmqfVpYq_uhan7m
X-Authority-Analysis: v=2.4 cv=DtFmPm/+ c=1 sm=1 tr=0 ts=69fa4733 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=g8Q-s5m5DLHQX5cPw7MA:9 a=pF_qn-MSjDawc0seGVz6:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfXw7InYdTxZP7K
 2KRJ/uaDAMhBrfKQ+7YFIi7jSKLVJRVr6PQP72D8eD3guoJwm/oH6G4n3Je/+vrmopfA2Inz8jT
 isNCDiOkoy4jX2rxBslEpZperZG0WfcCipsDUJ9ZL4u9zCu8Z16Qpd7dGiLuFO7iOSBe2rMQO95
 b/3p26wDunoMWVlTi1f+pEsAuO6XdkYfOb/TL/4CuDXCVZMz2eYBpU7vmIvuBBSQposYPRbVklY
 vdm/DwVYOHpAqDC6JFXbaWhtL+JCyXduTTjEI8fKOZ+IVYknNQRpkoBMdy4Rx7fJ2uBSxCzE3M6
 MdWlrmu+t+W2RfPCvfbe871xGzZblBBb5XwgXt6HNaLl1j1soEaxqyOyyQw94vcZkeC8K1YmamL
 rzq9elD0lwxsv8YIDbL0dUGzvEW/YwnVKGlxCIxVSHko3A8grf/ywK6iQ4NEVNH/xYtXvszLHkR
 cSZqvh3m01Qj3rWu/9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 7C94A4D32A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284569-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,meta.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

Make TCP retransmission timeouts select a different ECMP path for IPv6.

Currently sk_rethink_txhash() changes the socket's txhash on RTO, but the
cached route is reused and the new hash is not propagated into the ECMP
path selection logic.  This series adds sk_dst_reset() alongside
sk_rethink_txhash() to force a fresh route lookup, and sets fl6->mp_hash
from sk_txhash so fib6_select_path() picks a path based on the new hash.

Five selftest scenarios verify the behavior across connection setup and
established flows, forward and reverse path failures, and PLB:

  - SYN retransmission (forward path blocked during setup)
  - SYN/ACK retransmission (reverse path blocked during setup)
  - Midstream RTO (forward path blocked on established connection)
  - Midstream ACK rehash (reverse path blocked on established connection)
  - PLB rehash (ECN-driven congestion on established connection)

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

 net/ipv4/tcp_input.c                       |   4 +-
 net/ipv4/tcp_plb.c                         |   1 +
 net/ipv4/tcp_timer.c                       |   1 +
 net/ipv6/af_inet6.c                        |   3 +
 net/ipv6/inet6_connection_sock.c           |   6 +
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 569 +++++++++++++++++++++
 7 files changed, 584 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.52.0


