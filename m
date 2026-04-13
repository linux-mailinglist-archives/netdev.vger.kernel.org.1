Return-Path: <netdev+bounces-278172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBkQLrc23WkmawkAu9opvQ
	(envelope-from <netdev+bounces-278172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3103F2156
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E61A30206C1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A237C105;
	Mon, 13 Apr 2026 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tU3LuWoK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28B371D1E;
	Mon, 13 Apr 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104957; cv=none; b=pHrHMdglKN8XuSLxAJCm6+QERxVmbkWzjesdRdpid68xUhT2qZ18y0f1r4VOoUHU6D1INRvjRET4cylrfxO1zkoJBdArJ4J7KEVZAP8oKv7eS2UU2M/8CF5dgYV2qEmf/He6OSvVbIIxgrM//SGu1tDYWh+9FLTOjLP3xpUWa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104957; c=relaxed/simple;
	bh=mq3W97fLxJrTDqDLRHxtzgRhpRr1N8IqnlHahE9Mo/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKkixxTBJJV+bOBLJYe22pNjBXMiNFQlqkQZdvsXTYKUAbFVo7N3HsmRLhbTDW3eNdeLpuqgtSADm5lOiZmgTyxzoMjcT+A73GjHFeGYiLxViCK52+rxlJHlBjYj525QZLoYE448siRqeXqBm25KKvsvARMfLAav00fodP5F4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tU3LuWoK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 40AB54E4296B;
	Mon, 13 Apr 2026 18:29:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12D465FFB9;
	Mon, 13 Apr 2026 18:29:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1BDD104504FF;
	Mon, 13 Apr 2026 20:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776104951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EZ9QNHVh4+uhbJNai/qeDRTtUjcNGDJs+CZJDfExdHo=;
	b=tU3LuWoKhbTd/7Bxp1dXOKmfzCbIyM/apO7e06VCsD1jAsO4aLusD9iNvmTwRoTGhYfuwa
	wQZ7Rhbfb4u6sA8kE0gRYqT1AsgMWfuInBNGDoegkt/sWjx5ENCvIIXWwTgo20otsCojZP
	qrlqmy/FI1dRvldQRHMleciN+IrFbLo2xJNLYZvURj2eGuPQxDXbJc0BXHvub1UsIRBf4H
	mkvyg1Tslg616M4ELISPPqoHcW+Kxr1M5uTSiYfx3ITKBUuAg1vOl/i9+jSYHNNg73X48w
	ntFV2SF9Jnvw+i/JAmppuCLNjEJUuRSS7aTexPw9lUZ3mBum9FcJl9syieudEg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 13 Apr 2026 20:28:44 +0200
Subject: [PATCH RFC bpf-next 4/8] bpf, x86: add helper to emit kasan checks
 in x86 JITed programs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-kasan-v1-4-1a5831230821@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278172-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: AB3103F2156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the emit_kasan_check() function that emits KASAN shadow memory
checks before memory accesses in JIT-compiled BPF programs. The
implementation relies on the existing __asan_{load,store}X functions
from KASAN subsystem. The helper:
- ensures that the kasan instrumention is actually needed: if the
  instruction being processed accesses the program stack, we skip the
  instrumentation, as those accesses are already protected with page
  guards
- saves registers. This includes caller-saved registers, but also
  temporary registers, as those were possibly used by the
  affected program
- computes the accessed address and stores it in %rdi
- calls the relevant function, depending on the instruction being a load
  or a store, and the size of the access.
- restores registeres

The special care needed when inserting this instrumentation comes at the
cost of a non negligeable increase in JITed code size. For example, a
bare

  mov 	0x0(%si),rbx # Load in rbx content at address stored in rsi

becomes

  push    %rax
  push    %rcx
  push    %rdx
  push    %rsi
  push    %rdi
  push    %r8
  push    %r9
  push    %r10
  push    %r11
  sub     $0x8,%rsp
  mov     %rsi,%rdi
  call    0xffffffff81da0a60 <__asan_load8>
  add     $0x8,%rsp
  pop     %r11
  pop     %r10
  pop     %r9
  pop     %r8
  pop     %rdi
  pop     %rsi
  pop     %rdx
  pop     %rcx
  pop     %rax
  mov     0x0(%rsi),rbx

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/x86/net/bpf_jit_comp.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..b90103bd0080 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -20,6 +20,10 @@
 #include <asm/unwind.h>
 #include <asm/cfi.h>
 
+#ifdef CONFIG_BPF_JIT_KASAN
+#include <linux/kasan.h>
+#endif
+
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
@@ -1301,6 +1305,95 @@ static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64
 	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
 }
 
+static int emit_kasan_check(u8 **pprog, u32 addr_reg, struct bpf_insn *insn,
+			    u8 *ip, bool accesses_stack)
+{
+#ifdef CONFIG_BPF_JIT_KASAN
+	bool is_write = BPF_CLASS(insn->code) == BPF_STX;
+	u32 bpf_size = BPF_SIZE(insn->code);
+	s32 off = insn->off;
+	u8 *prog = *pprog;
+	void *kasan_func;
+
+	if (accesses_stack)
+		return 0;
+
+	/* Derive KASAN check function from access type and size */
+	switch (bpf_size) {
+	case BPF_B:
+		kasan_func = is_write ? __asan_store1 : __asan_load1;
+		break;
+	case BPF_H:
+		kasan_func = is_write ? __asan_store2 : __asan_load2;
+		break;
+	case BPF_W:
+		kasan_func = is_write ? __asan_store4 : __asan_load4;
+		break;
+	case BPF_DW:
+		kasan_func = is_write ? __asan_store8 : __asan_load8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Save rax */
+	EMIT1(0x50);
+	/* Save rcx */
+	EMIT1(0x51);
+	/* Save rdx */
+	EMIT1(0x52);
+	/* Save rsi */
+	EMIT1(0x56);
+	/* Save rdi */
+	EMIT1(0x57);
+	/* Save r8 */
+	EMIT2(0x41, 0x50);
+	/* Save r9 */
+	EMIT2(0x41, 0x51);
+	/* Save r10 */
+	EMIT2(0x41, 0x52);
+	/* Save r11 */
+	EMIT2(0x41, 0x53);
+	/* We have pushed 72 bytes, realign stack to 16 bytes: sub rsp, 8 */
+	EMIT4(0x48, 0x83, 0xEC, 8);
+
+	/* mov rdi, addr_reg */
+	EMIT_mov(BPF_REG_1, addr_reg);
+
+	/* add rdi, off (if offset is non-zero) */
+	if (off) {
+		if (is_imm8(off)) {
+			/* add rdi, imm8 */
+			EMIT4(0x48, 0x83, 0xC7, (u8)off);
+		} else {
+			/* add rdi, imm32 */
+			EMIT3_off32(0x48, 0x81, 0xC7, off);
+		}
+	}
+
+	/* Adjust ip to account for the instrumentation generated so far */
+	ip += (prog - *pprog);
+	/* call kasan_func */
+	if (emit_call(&prog, kasan_func, ip))
+		return -ERANGE;
+
+	/* Restore registers */
+	EMIT4(0x48, 0x83, 0xC4, 8);
+	EMIT2(0x41, 0x5B);
+	EMIT2(0x41, 0x5A);
+	EMIT2(0x41, 0x59);
+	EMIT2(0x41, 0x58);
+	EMIT1(0x5F);
+	EMIT1(0x5E);
+	EMIT1(0x5A);
+	EMIT1(0x59);
+	EMIT1(0x58);
+
+	*pprog = prog;
+#endif /* CONFIG_BPF_JIT_KASAN */
+	return 0;
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {

-- 
2.53.0


