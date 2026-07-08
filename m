Return-Path: <netdev+bounces-305803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vwMNInBITmqDKAIAu9opvQ
	(envelope-from <netdev+bounces-305803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC02E7267C4
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:54:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b="igSeJC/y";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305803-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305803-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DC1B30770DE
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB04544D021;
	Wed,  8 Jul 2026 12:51:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster4-host1-snip4-10.eps.apple.com [57.103.69.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23343436BD3
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:51:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515118; cv=none; b=Na4AsI9ny56CLRvqiTV0BacHe4rotYqUVFAVubWgCJrVmKkg/BVjxUOhHDlqya6E2GU0YFLaHz+7FGk+FMcAgr5PPXWpp+RYR+NAa9tZPFLCiq3MwphUP9hxnu0085kxV4N9sVaUTV7Ub0PpEAR43GtaPMr7q3ux2dqSYHTDw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515118; c=relaxed/simple;
	bh=6mYHmLwbqFYeDIRM8O0HZW6mnDgqtUID8vI8kZ+/Dbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6Qmf6OXaWa3gic/2BSAdRVUdGyjCWBSY6a2Yr4nr2bNJ61twDYm+9z1GfQpWyv46ZndNgYyDPzcEk241RfePza/WThnlqt8f7fE0jQFRH/mct2P3UDyScd7PQwYXQ50Qx1yTjb/PnLi93caSUMlr7cDetEC6YlZbstxNKveBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=igSeJC/y; arc=none smtp.client-ip=57.103.69.201
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id D692E1801269;
	Wed, 08 Jul 2026 12:51:51 +0000 (UTC)
X-ICL-RepId: 019f41c8-e0b7-7dbc-b929-378bb9c86e8c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNDGRBWAVhWXQVNGlwYWQ8cHUtWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTFoXRQhFRQNHAUsGXANfB0UXH1oZGQ9XHFAKUgN3HVcCXRFQGRkMVU4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783515115; x=1786107115; bh=Vdtxtw3pbukTyLj+9wd9smqQqhdMezxfdvk4qQmvK2I=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=igSeJC/y8p98JrLi7ygnL29dABjlUl2cSISKzmxgDykKcp8gdT6GuMe1dPgOnQMqnskPHmQ+beqVNINxf5EjRCJ+mB5NWFfvpdi9Xqt0rhsFgJiBXZut7sBx1P79TJY3m0ZHpNH3H1ZDgLthangqZAyT7QBQTV1QgHLHNv+KayWPewcXSSpnXKs8Y5D5RRDVIvF9orMJ1GebwuQ3S3rCj7TN/jf/RAb92jsrYIL+KPMC9me+UDkKHqZla/642uY/VP/17vbiL1wfbuOd9+qq7L+iPNBs63QnMLWWGRhygdsZGt8tNSDXEhBwC6WFLnKohduk3xq4WqsfWOvVLNC7zQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id 176E71800095;
	Wed, 08 Jul 2026 12:51:47 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: lorenzo@kernel.org
Cc: sdf@fomichev.me,
	kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	sdf.kernel@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next 0/1] selftests: drv-net: XDP RX checksum metadata test
Date: Wed,  8 Jul 2026 15:51:43 +0300
Message-ID: <cover.1783514455.git.deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <akZ7QPfn83OUx5Vm@lore-desk>
References: <akZ7QPfn83OUx5Vm@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i0yUQV183GR8doiG7WnL10dtACYG5yuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyNSBTYWx0ZWRfX4OdgaQx72hbl
 SfycGooSeAILZL3tsPfMQtKvUo0Hr9sPz78yh88+H6G2ExTgVtMGrUQxZ6uPf44kfZCTMlEhnfq
 kmnaBqXMXTMrm25TX8kqU1853pfUPyMUP3RC4b4bNFQPQf2ZGn7kJnY64nMVZCJ7YgzdHJoji+Q
 QRo+m1zGiWLIZDBSS2dhfwXnyTSSMgug6xQShOX3d/JQeo5hx/hOOwv3oxUtc5SOXYOMNIYmMRd
 P0ybWeKsB1dn1wZB5NLC7ZF9fWQewH5m6dkFCfy0Tr98qyJ1OUm68w9IDH1i54ItFFLLYy/j5cN
 3t9wLHYbPUh9qJsroQZ
X-Proofpoint-GUID: i0yUQV183GR8doiG7WnL10dtACYG5yuW
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:sdf@fomichev.me,m:kuba@kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[fomichev.me,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,verdict.gg];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC02E7267C4

Hi Lorenzo,

Here is the driver selftest for your XDP RX checksum series, as
discussed. It is written against your b4/bpf-xdp-meta-rxcksum branch
(the bitmask ip_summed + cksum/cksum_level API) and applies on top of
it rebased onto net-next, since the drv-net xdp_metadata.py test it
extends only exists there. Feel free to pick it straight into v4.

It adds an xdp_rx_csum program to xdp_metadata.bpf.o and two cases
gated on the "checksum" xdp-rx-metadata feature (SKIP on devices
without it, e.g. netdevsim):

 - xdp_rx_csum_valid (tcp/udp variants): traffic with a correct
   checksum from the remote endpoint must be reported with a usable
   verdict (CHECKSUM_UNNECESSARY and/or CHECKSUM_COMPLETE);

 - xdp_rx_csum_invalid: UDP with a corrupted L4 checksum (net/lib
   csum -E) must not be reported as CHECKSUM_UNNECESSARY.


One question on the invalid case: I assert only that UNNECESSARY is not
set for a corrupted checksum (COMPLETE may still legitimately be
reported, since it carries the raw sum for wrong packets too). Is that
the documented expectation you and Jakub want the test to encode, or
should it be stricter?

Thanks,
Vladimir

Vladimir Vdovin (1):
  selftests: drv-net: add XDP RX checksum metadata tests

 .../selftests/drivers/net/hw/xdp_metadata.py  | 103 ++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++++--
 2 files changed, 202 insertions(+), 13 deletions(-)

-- 
2.47.0


