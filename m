Return-Path: <netdev+bounces-280493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMn3HCv46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB0448B39
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4C5316FA5A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2738A706;
	Wed, 22 Apr 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SxQ4fz7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EA37FF68;
	Wed, 22 Apr 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874845; cv=none; b=XQYBXSdp52fI54k1gqfjxtRf06Cb83mpZm+oO58EkIDErXCpn7P1ut8r8GGGwWacEtSJAJ/EhOG+Ho2u7BxMu6GQjD9sNOln8v22iWMhVRwiUa0V3PwWzwx9aggkVAMScFpx7yd534+goU48WsTFx73h1Vt0BaMW2prpjjnZiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874845; c=relaxed/simple;
	bh=6/OMqD+59TuORkuwHoA/SFCxiAHmkdbLz9aAfiTuwLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnHN4hAXcIzDbQg1qlLpYSsAa17zlGsiKQKgenAKjPiHT6Z9LFoqOSz94GAXFn9LPV0oDtiTInqgbEokTgr3Chg5OVo7MCQHH/eHhLDcVtGvdrfR99cz6Qe2in5hEOGCCCvhE0M1zPzbqvUcG+uW+7T0M+47kbnuflmAKeCs6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SxQ4fz7N; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8A769C5B1AC;
	Wed, 22 Apr 2026 16:21:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA25B5FA8F;
	Wed, 22 Apr 2026 16:20:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE355104608C5;
	Wed, 22 Apr 2026 18:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776874841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/OeQaPHqgxOT0nI16nQdUnS3gmk63KqT0dFXD3w7yZ4=;
	b=SxQ4fz7NUAZBTDtaJecUlJqQlga5tLD/ljcSe5zjWI5wSxT9J1Pr30P4/cmBUoHC1PDeos
	hFuh89yrE01a0HKZU8ypIWnpZelBMyRJt+ZxbMahAaKh3Cak+EtZ7q+LKE937zxgIkhLXW
	ogqG4r+UnxGqYSSB0CWXoYnFHPyHZzvkCzKEkbx2Yc+WMqj3tSlP0b/Fe+McayUlaGcx0o
	H8gIK1ApmgRXlGHRwLc4roq3t9OyU1jcOn5H2eU2sYad8Wdp1P7plboL0BrsJ4n0EqDR/l
	BfX3ZPlmoGBi8BxkoZMHqCSKg9MTMsluUogtn2RbEmRic1YeRGoDTo17AUcKDg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 22 Apr 2026 18:20:24 +0200
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: make btf_dump use xdp_dummy
 rather than xdping_kern
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260422-xdping-v2-1-c0f8ccedcf91@bootlin.com>
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
In-Reply-To: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280493-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8EB0448B39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to prepare xdping tool removal from the BPF selftests
directory, make the btf_dump test use another BPF program for the btf
datasec dump test. Use xdp_dummy.bpf.o, as it is already used by various
other tests.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index f1642794f70e..9f1b50e07a29 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -1027,8 +1027,8 @@ static void test_btf_dump_datasec_data(char *str)
 	char license[4] = "GPL";
 	struct btf_dump *d;
 
-	btf = btf__parse("xdping_kern.bpf.o", NULL);
-	if (!ASSERT_OK_PTR(btf, "xdping_kern.bpf.o BTF not found"))
+	btf = btf__parse("xdp_dummy.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(btf, "xdp_dummy.bpf.o BTF not found"))
 		return;
 
 	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);

-- 
2.53.0


