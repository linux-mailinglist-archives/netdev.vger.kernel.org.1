Return-Path: <netdev+bounces-285411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AiqMfu2/GkNTAAAu9opvQ
	(envelope-from <netdev+bounces-285411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:59:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459364EBB61
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9289D30F0250
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30544CF4A;
	Thu,  7 May 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FVziDCaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE148449EB2
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169116; cv=none; b=seTQyLR1kxDtVjRiaKOaWRxgI7O0B57robg2RnAVcjYTtd0fgs20MWI1BfAQnydyrECj468qSjblpoG6vDo04DmsGpbTAiSLmg4GRNwUV+Wn6J3cVJGg/fBIQviXIeSyaOAA+KAieU0tidGNX0VK2fGu0CZSj4NUNL4/WkYGU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169116; c=relaxed/simple;
	bh=N/c5QH2LpQTCnVMZjv55xEfP1S6t/HG0AX5pqSkBqBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD88bFrleMJwde27Yib726k5KrlTGjPr4N4hqFOpEx4K9qr37VC/dmf72vtOEbMYEXTw8I7UHAAoEz0Y6XPpvW5zyT/TBxor+MIrk2wRXBdV9zdeuabqeSqfdG4au7EE2o21+kzlFM/9nUP7qjoXZqiSrHMmcNyT/KhPcQ27FeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FVziDCaZ; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8aca6a68de3so1305036d6.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169114; x=1778773914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gej9rC0V5wj21YK/OT0tP6dMq4zLV0oZtuZHtg6JDU=;
        b=LRlh048yoOPNkKrfReA4HkJ8guHFzMrJCDeb5nq+aW9h5mE+rTltsE/AVEDrkZAZkR
         mzOmEshFqKJzQ+J/jgFOgDBVSYJ4AmauoBlmLL76Rb+ZaD+lgt59JDfy/yfwAYOYXpKy
         jLzynu0AHd3wgopsdSrdyLISMWW0IHctkT2Xm9+uJnppSw6GUDAD5vH8v7hqKH/QSX34
         291NVYSol0IGc6yIRfoV6HPNAUydVkPdfdRIuGZCWDz/r8i0enQhqKQ8RWnjQdpB5Pc8
         ILkZ8NnkU3GaCrZrgh7Cado+DGsCx0tNkZZx2Wzc4pXYUp4Tw1x1Dh6Jsl5SHgMbSPNj
         b9LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kWWGiNckQkbzHFgoXwxDXsG3DcWg++L/v+kxSBLDqCP7iEWKjOguZtgEfv5PCkJC7szpeRAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69atwPZFFrTWjX2JfC6Ok5a5lnxST7LpqYdWjI6pp53PMSzTl
	Oo+AFhNyJVgvt6Bkbn8zKwcjmgyLgE4yiw64I2txJZA+5HKavjDGYQVRqy2KEGQfQq09fkscVtn
	YRlwpH3/xwey0W+T2mWe+FmcTZgVemui26IW3Ak82N0uYpZ4K1FA3/wzjzlk3ZJikjXmwRtC3Ej
	P4Ws03xVJ5IrFtzgTKm0lsGcLnIFbiwaz7RidQ4ov2XD2m7Y/bNYyUSETTbOh8qRbIFW2VEQWNU
	fShF/9juQC7Dw4=
X-Gm-Gg: AeBDietwfYRJyIiAcZEPKApGTi3DDquroDGYBck5Im58NrSJxl+uwEpJIbkMHfXDPlG
	XVQm95CLdF/ISZFjfkK6TmnCOXjGsRDuTSmyevvYmTmSopiU8mY9pyv/di6NlzUcbFzN81JCfgj
	nkM1Wxs8bkzLTOAOXLT+sJY5zlxPBQOOChcdXQxD7Uu+AF8pngdOn5RLfatmEahgkZ9iUnDpSzy
	qrBBWbqRpZ2w9UXM2WEdj/3EBupI8rjdikYOunMfz1rEZmN5iVgbs8BJrZ4szmokTcIbkuKCQRd
	8g76i3h4Q6fC6yGpCxCb21MexvIPuCDdSL2qkFsnxs0+qpPSdsEjdcjtm9occ+MwO0I7uJFKqb6
	26PCJ3gpL5bIvLe3JQkjzz0WHo0HRtuBSUKRGJY/pN5r/p8rkhuvfBhX+VC16pknTZ3QdI07cK5
	JMhjgkM/fkMJZzQlCX1WEXzw1wTqjAhF+7MNujBnoaAsT2So8h6aaDcRSaQ0DlyEagTvHL
X-Received: by 2002:ad4:5ecb:0:b0:8ae:65b7:1b0a with SMTP id 6a1803df08f44-8bc42f54d50mr84919686d6.2.1778169113753;
        Thu, 07 May 2026 08:51:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b5393d4cedsm16908546d6.12.2026.05.07.08.51.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2026 08:51:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8eab57f0e8bso27614385a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778169113; x=1778773913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gej9rC0V5wj21YK/OT0tP6dMq4zLV0oZtuZHtg6JDU=;
        b=FVziDCaZt9A7Icol0tsQQITtIfwOK/o7xP5yLgiX2GJVx+0cqGOBw+GuDXuJGQJiPx
         yLRqm5IoYHFUSl/29gYTFci8pnlywIs463JIHfdb5x2n6OI313D+T26Qcy/Kt5XeCm1W
         XI+SffGrUPe3r470jHOz0HeKFKa+dRG0IgMTw=
X-Forwarded-Encrypted: i=1; AFNElJ+xXSHA4oAXFwZUo/ciLdQR/EwHnrr5m57uH6hrk1GAdol/pq/1elASViCCZdZ9mcEKwWZW2iQ=@vger.kernel.org
X-Received: by 2002:a05:620a:3195:b0:8ea:c7a8:5065 with SMTP id af79cd13be357-904d4392205mr887326885a.2.1778169112836;
        Thu, 07 May 2026 08:51:52 -0700 (PDT)
X-Received: by 2002:a05:620a:3195:b0:8ea:c7a8:5065 with SMTP id af79cd13be357-904d4392205mr887320985a.2.1778169112144;
        Thu, 07 May 2026 08:51:52 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90642b76d39sm240711885a.2.2026.05.07.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:51:51 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH net v3 2/2] selftests/net: add packetdrill test for locked SO_RCVBUF SWS
Date: Thu,  7 May 2026 15:48:06 +0000
Message-ID: <20260507154806.18635-3-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507154806.18635-1-ankit-aj.jain@broadcom.com>
References: <20260507154806.18635-1-ankit-aj.jain@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 459364EBB61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285411-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a packetdrill test to verify that locked SO_RCVBUF sockets do not
suffer from scaling_ratio truesize penalties.

The test uses a standard 1460 MSS and sends medium-sized packets
(600, 700, 800 bytes) to trigger the recalculation logic. It checks
that the internal window clamp (tcpi_rcv_ssthresh) does not drop
unexpectedly.

Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
 .../net/packetdrill/tcp_locked_rcvbuf_sws.pkt | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt b/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt
new file mode 100644
index 000000000000..43e1d00d5f26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that TCP does not reduce scaling_ratio for locked SO_RCVBUF.
+
+0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [32768], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
+// Establish connection with standard MSS.
++0 < S 0:0(0) win 65535 <mss 1460,nop,wscale 8>
++0 > S. 0:0(0) ack 1 <...>
++0 < . 1:1(0) ack 1 win 65535
++0 accept(3, ..., ...) = 4
+
+// Inject varying payload sizes to force scaling_ratio recalculation.
++0.1 < P. 1:601(600) ack 1 win 65535
++0 > . 1:1(0) ack 601 <...>
+
++0.1 < P. 601:1301(700) ack 1 win 65535
++0 > . 1:1(0) ack 1301 <...>
+
++0.1 < P. 1301:2101(800) ack 1 win 65535
++0 > . 1:1(0) ack 2101 <...>
+
+// Check that truesize penalty did not reduce the window clamp.
+// On unpatched kernels, rcv_ssthresh drops to ~22K.
++0.1 %{
+assert tcpi_rcv_ssthresh > 28000, f"rcv_ssthresh dropped unexpectedly: {tcpi_rcv_ssthresh}"
+}%
-- 
2.53.0


