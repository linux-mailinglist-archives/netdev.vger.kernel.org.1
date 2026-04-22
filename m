Return-Path: <netdev+bounces-280492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C/pG0v26Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:24:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77987448921
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B825A3049E19
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BB384252;
	Wed, 22 Apr 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="epuFpuUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E97381B1F;
	Wed, 22 Apr 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874844; cv=none; b=iAQrZqugL13N53p8yC3deBbMTS5mp6J5GtUXF5niqXdIBMN4CA/y3if6O226CJLSMzMQJZi+390BrVBOuod/GkS3m3HBe9a2Cp0wBmam4/QqxigxqIoPjmJHniNrSw+htwVFRdR1/5QrBXUIeUNEIHcSpAYnPZEfLSxhDn8//F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874844; c=relaxed/simple;
	bh=ExMb8tPfJaxiXp7EK5rVlIce8SGOms3XQd1VKKJnWp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I3a21t2oKTrv9vGkXuQ6/Gj87rT6Iw0tn0gN60YM1GhNCSmn9nijIPqMpcuRFr+elbZWQLSly8YdgA9H61msYBpEtZCnoC+uaMvdyOCyLJkWZPJttk1cZdWBRoWGzUkyBdFnecZ33388CIjP7QkZELQTOOihdFUy7Ihudiq96F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=epuFpuUM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6A6FEC5C1A5;
	Wed, 22 Apr 2026 16:21:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C9415FA8F;
	Wed, 22 Apr 2026 16:20:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 850F8104609C6;
	Wed, 22 Apr 2026 18:20:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776874839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SGggjXuf/8yJ4S+r8+IzMPFkAtuvtsjqGUGqH58wndw=;
	b=epuFpuUMRUqS+/m9b6NMb0OYCedrKngThlXBA1bQaAsebyBe7DUKwLvscvkvp39097afSi
	LeVJLo2JzL3vtVuQ2C3tHFOSt6CclJeO4YW68hDo/U6HMTrgvVo1AONHnKSYdVBq0yzlFu
	2ULzFH8a1e/6Fyf91x5TLS69l783q8wXrwt8f1CVkBHbt6XiM1BZ/eU7udr06PpZ9U1xwK
	o4vOoPXbqaVFxt2XFZ5PISuNnuKdiThXGumVqOmdGYgOexSuqUxk9I+E8tsL/Z78Qbjr/T
	btUOuHu241ipSqb7vusQD4E3QMoeSQNA54iRlIx9zmcg0dutSvWGpcL//PoQ/Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: drop xdping tool
Date: Wed, 22 Apr 2026 18:20:23 +0200
Message-Id: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBREf4XctTVtlefK/zAsaLmFa7Rt2kowh
 H8XcOdyMmfOLBAxEEZosgUCThTJ2S3IUwZ67OyAjPotg+Sy4FdRsrn3ZAeWa4km74pLVdewwT6
 gofkQ3UF5wyzOCdpfE9/qgTrtnp0dKSYXPsfnJI7Fv34STLBacY0cy6431U05l55kz9q9oF3X9
 Qv93sXDugAAAA==
X-Change-ID: 20260417-xdping-5c2ef5a63899
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
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280492-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,iogearbox.net:email]
X-Rspamd-Queue-Id: 77987448921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this is the v2 of the small series dropping xdping tool. This removal is
part of the larger effort aiming to tidy the bpf selftests directory.
This new revision updates btf_dump test to make it use another bpf
program rather than xdping_kern so that we can drop it as well.

---
Changes in v2:
- make btf_dump use xdp_dummy rather than xdping_kern
- and so, drop xdping_kern at the same time as the xdping tool
- collect Alan's RB
- Link to v1: https://patch.msgid.link/20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Shuah Khan <shuah@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: make btf_dump use xdp_dummy rather than xdping_kern
      selftests/bpf: drop xdping tool

 tools/testing/selftests/bpf/.gitignore            |   1 -
 tools/testing/selftests/bpf/Makefile              |   3 -
 tools/testing/selftests/bpf/prog_tests/btf_dump.c |   4 +-
 tools/testing/selftests/bpf/progs/xdping_kern.c   | 183 ----------------
 tools/testing/selftests/bpf/test_xdping.sh        | 103 ---------
 tools/testing/selftests/bpf/xdping.c              | 254 ----------------------
 tools/testing/selftests/bpf/xdping.h              |  13 --
 7 files changed, 2 insertions(+), 559 deletions(-)
---
base-commit: b7fb68124aa80db90394236a9a4a6add12f4425d
change-id: 20260417-xdping-5c2ef5a63899

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


