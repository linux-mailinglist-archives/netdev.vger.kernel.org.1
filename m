Return-Path: <netdev+bounces-278171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBILMB023Wl9agkAu9opvQ
	(envelope-from <netdev+bounces-278171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6453A3F20D3
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0808302077B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB73845AB;
	Mon, 13 Apr 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o44sVXLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA2366558;
	Mon, 13 Apr 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104952; cv=none; b=as1QjGYw8zPqkwvrFKg101neETCt7gSmFUn0zMMlvQS/Di+0Gg291vvjVmXOUGlO/63b0RGCB8axstCy9osL7VrVTcATeOht3xR/ApDNedBUpvLu0I5EZJ2SYcsSctORjQFkrJaZe743BnRjBDYHj4AWr2scNo7W7qXhD7mzFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104952; c=relaxed/simple;
	bh=3ul6pNpfIDYIoIgtbAHLVhrZyDiXJucBKhqtFXPWeuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VchXgQvHSF/NTDkJx32nYEz+AllYZVvrtdprkeRsWZzN98X6rxw/Rm2RQOl6xGPYM9YfFTFcHu7HkpiHNLy9VXKzY/yOkrXI7IiNC5lMTL0j8c6eRXlW/s1wfIqNkCoztLuY6nY5aEjPo2Wz2YRiNKXyyi6iKuHen48anzmORyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o44sVXLe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B07A4E42977;
	Mon, 13 Apr 2026 18:29:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40C755FFB9;
	Mon, 13 Apr 2026 18:29:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D5D4104504DF;
	Mon, 13 Apr 2026 20:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776104947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y5yh+jPLjYdbpM+lAMSIEbKZx9jBkdUNIqhhBJUSD7U=;
	b=o44sVXLepMBqSnOEDpzehWYEkyLJ277S4ZD0mX5x0/hGbON8nbocYIKweTKmZgSaODHeop
	Gk1QZ0KlMKDF6U1D/i7rG0MsPoJurHcz2wDn/C9O4mxht3VdU9u8za91gWE95CrtwzSa2w
	o2xxrib2bvulpRAYCkWrLZAtfAw9kTqQn74z1/EQj7LuL/TVuTGJM10yXYkNFUqAiZGL5L
	CMOT2PZnOSIQuXQLtFWLrdTzAkeZuuzxsF2HCU5UG2JVuExsPqUjNkFb/FdLta7lUaCx8Y
	XLZbAmvi9zcDbQVvjBohG/kgnUmIxAsfWXAYZsXwpmK2NQb3P7FKaD7qaDJQrQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 13 Apr 2026 20:28:43 +0200
Subject: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-kasan-v1-3-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278171-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6453A3F20D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
BPF programs, when both KASAN and JIT compiler are enabled. When
enabled, the JIT compiler will emit shadow memory checks before memory
loads and stores to detect use-after-free, out-of-bounds, and other
memory safety bugs at runtime. The option is gated behind
HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 kernel/bpf/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..28392adb3d7e 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
 config HAVE_EBPF_JIT
 	bool
 
+# KASAN support for JIT compiler
+config HAVE_EBPF_JIT_KASAN
+	bool
+
 # Used by archs to tell that they want the BPF JIT compiler enabled by
 # default for kernels that were compiled with BPF JIT support.
 config ARCH_WANT_DEFAULT_BPF_JIT
@@ -101,4 +105,9 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_JIT_KASAN
+	bool
+	depends on HAVE_EBPF_JIT_KASAN
+	default y if BPF_JIT && KASAN_GENERIC
+
 endmenu # "BPF subsystem"

-- 
2.53.0


