Return-Path: <netdev+bounces-83657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDD893453
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901831C22E4C
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E815B56A;
	Sun, 31 Mar 2024 16:42:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AD15A4A4;
	Sun, 31 Mar 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903342; cv=fail; b=IthvP/DbQz4pfpZTC//KNdgX+yOs5d14B4Ni4ThS+91u74NvpUtZFTa9cFgfCx0ZUCKXym7VMddYsrdcyYPsLeSawPlXdxtYbjWQllDRI3Mj4o9UR6b4jq/heWvsk9jfnkjixB8TE8kCufMXb9hlLboy/hfBpwf9yZQBhzDMqNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903342; c=relaxed/simple;
	bh=6rB2zenkNiONAvljEnfSd8bG24wAyvBeKWA9FK4cabk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/6rEEN6EtmmOSRfcZoOLHFwzHGibymwMcTw9wQwfWfEwqdf/TRPfCuNtxj/IoE//c8OlSb8hIhz7WD3s9OoeJkxEw9qmL4aXJ2puQyXYTSYa+IdAQ0ucHXp9degMTxvq3pLslF/uIm+fNhEtVXYoP5eQoQEZdrPsIkUW6iD63g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=fail smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huaweicloud.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C3408208B2;
	Sun, 31 Mar 2024 18:41:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ItlOSB6j9osf; Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 56CF1208B7;
	Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 56CF1208B7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 485C580005E;
	Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:13 +0000
X-sender: <netdev+bounces-83574-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoA33YFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 14346
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83574-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3233C207D8
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876971; cv=none; b=hv2V0jigilROcK8EYto6mRFG8DmuWtzxXZdqHtz9fMG0J+dkwO3J41ISZ+hTRcRxWrMDvtPfqrGiOO2Pa5vS9Hw9hNW0+rcY8I0q3N1C1xYo9KnGofkVAWYNtZ045WxaXdk92DZrHEodFCKU10wDs2vIdFY6zGSn/djqvoiqa+0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876971; c=relaxed/simple;
	bh=NU/seP21mtWkdilB97nH/1Auom8uGHKorbHfj6W3x1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5VU4JM9HWfq6ydlfdq15M8AHsNevxb1HZ/WRW7e5KCGFbuynlYb35Qx1hbwhN8rTBK/vhMo3wMg6IQKk1cvjnlml0wLsB2fxmf42iOXZsYiZWVGRgHzQLCt/253/+2SOkeNOhmEUNNNocVPFZzGfHby5lZfh2NLhB8+aGYDVJ8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
From: Pu Lehui <pulehui@huaweicloud.com>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
	<pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 1/2] riscv, bpf: Add 12-argument support for RV64 bpf trampoline
Date: Sun, 31 Mar 2024 09:24:04 +0000
Message-ID: <20240331092405.822571-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331092405.822571-1-pulehui@huaweicloud.com>
References: <20240331092405.822571-1-pulehui@huaweicloud.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: gCh0CgCH2WtkKwlmesQWIw--.11467S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15Jw13Kr1kAF13Cr45ZFb_yoWxJr4Dpa
	1DKrsxAFyvqa17Xa97WF1UXF1aya1qva43CFW7Gas3uFWYqr98GayFkF4jyry5GryrAw1f
	AFs0vF98KF17GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
	=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Pu Lehui <pulehui@huawei.com>

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <=3D sizeof(u64) bytes
scalar arguments [0] and <=3D 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2=C3=97XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [=
0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [=
1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/downloa=
d/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 63 +++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 77ea306452d4..2aec69e4c116 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -14,6 +14,7 @@
 #include <asm/cfi.h>
 #include "bpf_jit.h"
=20
+#define RV_MAX_ARG_REGS 8
 #define RV_FENTRY_NINSNS 2
=20
 #define RV_REG_TCC RV_REG_A6
@@ -688,26 +689,43 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_t=
ype poke_type,
 	return ret;
 }
=20
-static void store_args(int nregs, int args_off, struct rv_jit_context *ctx=
)
+static void store_args(int nr_arg_slots, int args_off, struct rv_jit_conte=
xt *ctx)
 {
 	int i;
=20
-	for (i =3D 0; i < nregs; i++) {
-		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+	for (i =3D 0; i < nr_arg_slots; i++) {
+		if (i < RV_MAX_ARG_REGS) {
+			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+		} else {
+			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_ARG_REGS) * 8, RV_REG_FP, ctx);
+			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
+		}
 		args_off -=3D 8;
 	}
 }
=20
-static void restore_args(int nregs, int args_off, struct rv_jit_context *c=
tx)
+static void restore_args(int nr_args_reg, int args_off, struct rv_jit_cont=
ext *ctx)
 {
 	int i;
=20
-	for (i =3D 0; i < nregs; i++) {
+	for (i =3D 0; i < nr_args_reg; i++) {
 		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
 		args_off -=3D 8;
 	}
 }
=20
+static void restore_stack_args(int nr_args_stack, int args_off, int stk_ar=
g_off, struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i =3D 0; i < nr_args_stack; i++) {
+		emit_ld(RV_REG_T1, -(args_off - RV_MAX_ARG_REGS * 8), RV_REG_FP, ctx);
+		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
+		args_off -=3D 8;
+		stk_arg_off -=3D 8;
+	}
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int ret=
val_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -780,8 +798,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 {
 	int i, ret, offset;
 	int *branches_off =3D NULL;
-	int stack_size =3D 0, nregs =3D m->nr_args;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
+	int stack_size =3D 0, nr_arg_slots =3D 0;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_a=
rg_off;
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -827,20 +845,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
+	 *
+	 *		    [ stack_argN        ]
+	 *		    [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
=20
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
=20
-	/* extra regiters for struct arguments */
-	for (i =3D 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs +=3D round_up(m->arg_size[i], 8) / 8 - 1;
-
-	/* 8 arguments passed by registers */
-	if (nregs > 8)
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
=20
+	for (i =3D 0; i < m->nr_args; i++)
+		nr_arg_slots +=3D round_up(m->arg_size[i], 8) / 8;
+
 	/* room of trampoline frame to store return address and frame pointer */
 	stack_size +=3D 16;
=20
@@ -850,7 +869,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 		retval_off =3D stack_size;
 	}
=20
-	stack_size +=3D nregs * 8;
+	stack_size +=3D nr_arg_slots * 8;
 	args_off =3D stack_size;
=20
 	stack_size +=3D 8;
@@ -867,8 +886,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im,
 	stack_size +=3D 8;
 	sreg_off =3D stack_size;
=20
+	if (nr_arg_slots - RV_MAX_ARG_REGS > 0)
+		stack_size +=3D (nr_arg_slots - RV_MAX_ARG_REGS) * 8;
+
 	stack_size =3D round_up(stack_size, 16);
=20
+	stk_arg_off =3D stack_size;
+
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
 		 * the frame of traced function and the frame of
@@ -904,10 +928,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
 		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
 	}
=20
-	emit_li(RV_REG_T1, nregs, ctx);
+	emit_li(RV_REG_T1, nr_arg_slots, ctx);
 	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
=20
-	store_args(nregs, args_off, ctx);
+	store_args(nr_arg_slots, args_off, ctx);
=20
 	/* skip to actual body of traced function */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
@@ -947,7 +971,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARG_REGS), args_off, ctx);
+		restore_stack_args(nr_arg_slots - RV_MAX_ARG_REGS, args_off, stk_arg_off=
, ctx);
 		ret =3D emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
@@ -982,7 +1007,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARG_REGS), args_off, ctx);
=20
 	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
--=20
2.34.1



