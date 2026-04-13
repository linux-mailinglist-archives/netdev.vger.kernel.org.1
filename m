Return-Path: <netdev+bounces-278169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCrtBWA23Wl9agkAu9opvQ
	(envelope-from <netdev+bounces-278169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:30:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB713F2120
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D076930387FC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F3377EAF;
	Mon, 13 Apr 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A6txoxr1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618136308A;
	Mon, 13 Apr 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104946; cv=none; b=Myu/noP/P1I2Fd3z725iGyGtUhisOGeFjVGJikFwq3JtgLTYHhLT05Vl9TZI7xQV3yir8wkhGtdTbiH6Q7L7vkK8X+FbvpA5U47sHidNQJwwPAvkB0MiiipbJieqKGXdG2VYWAv+cqZ6CY0bU/gBzNvSUpjkJXplVpQ/PZ4T414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104946; c=relaxed/simple;
	bh=dzxaOJEmwlpem1g5yololK0LR/q75gbrWoy8EoVNT7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cAWKELqx+ttguAQ/29BjZKyKh7rXtczUx267RRs1mrP8aMyKPnp8Ycw3VI7iX1hJxU4SdrBD8TJacn7p3r4T7yIU2J+xtgfcPmWZk1v/pPaCatJHMbklyYEBExKPDlHo1d/uj+kqhaldqA1F0BHDG6iVLsbFuXBPEEtJPedaMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A6txoxr1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64B3C1A31EE;
	Mon, 13 Apr 2026 18:28:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24AAB5FFB9;
	Mon, 13 Apr 2026 18:28:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57AC3104504B7;
	Mon, 13 Apr 2026 20:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776104935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=8wwTbqAk1/v1m7wW2LqSmKK5iRKdfUxdCX7mcszWNIw=;
	b=A6txoxr1XcmG6tEbbCTyhur5lWgPF7QbN2kOqQ54tYUX88h9fiDrus4Hjzv6K1aTBvZ2CO
	bjdVtAPCZTUuxgjc6RPvbXX0F56K9Ade5XwS7muo/TOF1Tvpmck0wAWs4AVubunqSm+Ndd
	6f01OPXyrIg/4lsYV6IK/RMy3MjbBTauAl1B50TjTV2IxPVcJuSQrO4S+u7TZwMR/mU033
	FVILOV9EtBmoXp1r76CWS2aoAmzpBnQyc2Izig6DLjirZ630fRVBYFhCLMDQGNkhc32w4F
	Q3k01keahidyZQVCTHur9l743MSGM6UBhfKfPB0DM8ZaeCot7DW4hlmohhjJyw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH RFC bpf-next 0/8] bpf: add support for KASAN checks in
 JITed programs
Date: Mon, 13 Apr 2026 20:28:40 +0200
Message-Id: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMz3ezE4sQ83bTkFDOLNDOT5BTzJCWg2oKi1LTMCrA50UpBbs4gsaS
 CNN281IoSpdjaWgCGQM1aaAAAAA==
X-Change-ID: 20260126-kasan-fcd68f64cd7b
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 6FB713F2120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,
this series aims to bring basic support for KASAN checks to BPF JITed
programs. This follows the first RFC posted in [1].

KASAN allows to spot memory management mistakes by reserving a fraction
of memory as "shadow memory" that will map to the rest of the memory and
allow its monitoring. Each memory-accessing instruction is then
instrumented at build time to call some ASAN check function, that will
analyze the corresponding bits in shadow memory, and if it detects the
access as invalid, trigger a detailed report. The goal of this series is
to replicate this mechanism for BPF programs when they are being JITed
into native instructions: that's then the (runtime) JIT compiler who is
in charge of inserting calls to the corresponding kasan checks, when a
program is being loaded into the kernel. This task involves:
- identifying at program load time the instructions performing memory
  accesses
- identifying those accesses properties (size ? read or write ?) to
  define the relevant kasan check function to call
- just before the identified instructions:
  - perform the basic context saving (ie: saving registers)
  - inserting a call to the relevant kasan check function 
  - restore context
- whenever the instrumented program executes, if it performs an invalid
  access, it triggers a kasan report identical to those instrumented on
  kernel side at build time.

As discussed in [1], this series is based on some choices and
assumptions:
- it focuses on x86_64 for now, and so only on KASAN_GENERIC
- not all memory accessing BPF instructions are being instrumented:
  - it focuses on STX/LDX instructions
  - it discards instructions accessing BPF program stack (already
    monitored by page guards)
  - it discards possibly faulting instructions, like BPF_PROBE_MEM or
    BPF_PROBE_ATOMIC insns

The series is marked and sent as RFC:
- to allow collecting feedback early and make sure that it goes into the
  right direction
- because it depends on Xu's work to pass data between the verifier and
  JIT compilers. This work is not merged yet, see [2]. I have been
  tracking the various revisions he sent on the ML and based my local
  branch on his work
- because tests brought by this series currently can't run on BPF CI:
  they expect kasan multishot to be enabled, otherwise the first test
  will make all other kasan-related tests fail.
- because some cases like atomic loads/stores are not instrumented yet
  (and are still making me scratch my head)
- because it will hopefully provide a good basis to discuss the topic at
  LSFMMBPF (see [3])

Despite this series not being ready for integration yet, anyone
interested in running it locally can perform the following steps to run
the JITed KASAN instrumentation selftests:
- rebasing locally this series on [2]
- building and running the corresponding kernel with kasan_multi_shot
  enabled
- running `test_progs -a kasan`

And should get a variety of KASAN tests executed for BPF programs:

  #162/1   kasan/bpf_kasan_uaf_read_1:OK
  #162/2   kasan/bpf_kasan_uaf_read_2:OK
  #162/3   kasan/bpf_kasan_uaf_read_4:OK
  #162/4   kasan/bpf_kasan_uaf_read_8:OK
  #162/5   kasan/bpf_kasan_uaf_write_1:OK
  #162/6   kasan/bpf_kasan_uaf_write_2:OK
  #162/7   kasan/bpf_kasan_uaf_write_4:OK
  #162/8   kasan/bpf_kasan_uaf_write_8:OK
  #162/9   kasan/bpf_kasan_oob_read_1:OK
  #162/10  kasan/bpf_kasan_oob_read_2:OK
  #162/11  kasan/bpf_kasan_oob_read_4:OK
  #162/12  kasan/bpf_kasan_oob_read_8:OK
  #162/13  kasan/bpf_kasan_oob_write_1:OK
  #162/14  kasan/bpf_kasan_oob_write_2:OK
  #162/15  kasan/bpf_kasan_oob_write_4:OK
  #162/16  kasan/bpf_kasan_oob_write_8:OK
  #162     kasan:OK
  Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED

[1] https://lore.kernel.org/bpf/DG7UG112AVBC.JKYISDTAM30T@bootlin.com/
[2] https://lore.kernel.org/bpf/cover.1776062885.git.xukuohai@hotmail.com/
[3] https://lore.kernel.org/bpf/DGGNCXX79H8O.2P6K8L1QW1M8K@bootlin.com/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (8):
      kasan: expose generic kasan helpers
      bpf: mark instructions accessing program stack
      bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
      bpf, x86: add helper to emit kasan checks in x86 JITed programs
      bpf, x86: emit KASAN checks into x86 JITed programs
      selftests/bpf: do not run verifier JIT tests when BPF_JIT_KASAN is enabled
      bpf, x86: enable KASAN for JITed programs on x86
      selftests/bpf: add tests to validate KASAN on JIT programs

 arch/x86/Kconfig                                   |   1 +
 arch/x86/net/bpf_jit_comp.c                        | 106 +++++++++++++
 include/linux/bpf.h                                |   2 +
 include/linux/bpf_verifier.h                       |   2 +
 include/linux/kasan.h                              |  13 ++
 kernel/bpf/Kconfig                                 |   9 ++
 kernel/bpf/core.c                                  |  10 ++
 kernel/bpf/verifier.c                              |   7 +
 mm/kasan/kasan.h                                   |  10 --
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 165 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 146 ++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  79 ++++++++++
 tools/testing/selftests/bpf/test_loader.c          |   5 +
 tools/testing/selftests/bpf/unpriv_helpers.c       |   5 +
 tools/testing/selftests/bpf/unpriv_helpers.h       |   1 +
 15 files changed, 551 insertions(+), 10 deletions(-)
---
base-commit: 7990a071b32887a1a883952e8cf60134b6d6fea0
change-id: 20260126-kasan-fcd68f64cd7b

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


