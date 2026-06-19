Return-Path: <netdev+bounces-300745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B03RDl6fNWp91gYAu9opvQ
	(envelope-from <netdev+bounces-300745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:58:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52C6A7970
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=icloud.com header.s=1a1hai header.b=pzsmMuwm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300745-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=icloud.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17519304E413
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CA342526;
	Fri, 19 Jun 2026 19:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2005k-snip4-4.eps.apple.com [57.103.66.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96232BF41
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899094; cv=none; b=J0/dun/Wzc846mTHFSp1+auooI33s1RmeLpRj8lh0dRH3CaSvboxUeaAXIOwCmNgLy5NteB4t8DzuYkmpOWKrTxX4oUKAogGqT3tmGF8BO9sJBCJbCXxykNrxhZX4Tl0HnNon7+2yoY/hBwDHhUQOmcdpNK0ko+HkGpcQgGZeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899094; c=relaxed/simple;
	bh=iXOV0asxCccyrJebaDoN3IQP5ubOpi/8P+XBmE4OYxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKVonj3QAE5HDwjrSMFugX4mnlUCzjdUrfKNVPmxBg7Qa7jRMlUkvhAfCc4fX1beJp+ck+VBcU+iP9E0G4BlZYGH9RpmuqBU6j6wjCoZXJCtV8ewsDX3XPI/s78+Q12whvg+gHCAl4LiRN5Qh4XuPPTOntN+kHuyRyyAfonBRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pzsmMuwm; arc=none smtp.client-ip=57.103.66.215
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id 673EA1800204;
	Fri, 19 Jun 2026 19:58:10 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYEWBcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUCXRcDVxxWRVwYQwldBVccHR1BRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUF4IXh9MHB0OWAYSHVAcDlEFWwBGCU4CVAZSB0cMQR1ZBlkHRBRJHh5eD1YYWApHBVQCUBl5EVABWB5WXloXXlMXH0sAXEVaDlsERxQ=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781899092; x=1784491092; bh=sygBzNXjACQ2HHrw6dFTVMIDduwGR6Qd+HQII4kdHrE=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=pzsmMuwm5z02wfqWeG6D1llpmBZubmssWuoM7SckvCW4my7OkP5NOk2Wddk+5+O/RV5sWgElVAb7r878wPbRR+gxZX/dvMJm5hkYH+uEgrQ0HII2qUkv3d2c21HS+ihJI+QxJgE2BsNZ1TJ7pagNLDwrLZA01H7NyncRW5LxDzPpOua4SXj7rK1BpDqZA917fyVA67xSOiFgM9zxu7AFh+5bD3gF+o/Doe3P5F+/R9pkSE7Fzi4994nMWbvRyA/9y+v/wg7aq/Rp/VN921UOHrAGAdmrTL0C2+bzUWYOFxR9EIM9VhYWCmrP6epeVVPHfV8JhONg7mEbRezt7W/hag==
Received: from cibi (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id D140818001B6;
	Fri, 19 Jun 2026 19:58:06 +0000 (UTC)
From: Siddharth_Cibi <siddharthcibi@icloud.com>
To: ast@kernel.org
Cc: Siddharth_Cibi <siddharthcibi@icloud.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: 
Date: Fri, 19 Jun 2026 19:57:56 +0000
Message-ID: <20260619195759.41254-1-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VZbJ9_7P6w0G_odWh_e7W5cgdlYCTZv6
X-Proofpoint-GUID: VZbJ9_7P6w0G_odWh_e7W5cgdlYCTZv6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5MSBTYWx0ZWRfXzHWYE+hGpTkC
 MZlSqHWhOna5nBjCkCXWXvtedfRBzQgZX5PwUK/QV4cutm/WWyaZvIxGuUjr4jyj2Dk70+j3gRe
 XsStHuP1CKWzmcxsnn36ICa8PhREK1IIrFjn7HGzTwyneeSIhB/6d+2v37AXMdbNvhHvDuKJrBG
 rzt9r0Q9vxE9HtCG4s91K3JpTj7yelPy8kffgNqYcfe+uhqruUoaoLeP33NwtC9PqbSMPx6VDEO
 GevFxGnJpnKUC4eVZ/tIiFKTqgOicSIuSqBn2uO1R1IGKKVF8D9VMl+8tb/L8ht2tE+3nAbMx8r
 F0zXhyvKZqFK+TW5G2n
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	EMPTY_SUBJECT(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[icloud.com,iogearbox.net,davemloft.net,kernel.org,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:siddharthcibi@icloud.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300745-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:mid,icloud.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF52C6A7970

Subject: [PATCH 0/2] preserve rx_queue_index across XDP redirects

XDP programs executed after redirect through cpumap and devmap
currently lose ingress RX queue information because rx_queue_index
is not preserved across xdp_buff to xdp_frame conversion.

Preserve rx_queue_index in struct xdp_frame and restore it when
rebuilding xdp_rxq_info for redirected execution paths.

Add a selftest validating that ctx->rx_queue_index remains available
through xdp_metadata after redirect.

Testing:

* Built modified kernel objects
* Ran tools/testing/selftests/bpf/test_progs -t xdp_metadata -v
* Verified xdp_metadata passes
* Added explicit rx_queue_index assertion

Siddharth C (1):
  bpf: preserve rx_queue_index across XDP redirects

Siddharth_Cibi (1):
  selftests/bpf: validate rx_queue_index in xdp_metadata

 include/net/xdp.h                                     | 2 ++
 kernel/bpf/cpumap.c                                   | 2 +-
 kernel/bpf/devmap.c                                   | 5 ++++-
 net/core/xdp.c                                        | 1 +
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 1 +
 7 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.53.0


