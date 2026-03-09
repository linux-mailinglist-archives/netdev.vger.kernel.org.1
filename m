Return-Path: <netdev+bounces-265672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMFQA1UJr2lzMQIAu9opvQ
	(envelope-from <netdev+bounces-265672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C26023E015
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8A23028EF9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19F2FF169;
	Mon,  9 Mar 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="c5jLyZz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD026AE5
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078646; cv=none; b=C8okMZolq28gHP4hBU9vgOSZ8SXgQp17zuiCFpcaVj18K553hBElqjfa147iPXW0HETeNsFU+kyYq82YhAKeyOc4EU9otJeq879MKOOREiWuWLIYZKFFCfeYLmPG0NJVrOmvjoTkkaq0Byo350IRRBGgjJO6v7VrZr2fyPMfYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078646; c=relaxed/simple;
	bh=VshT7Vq3c5zGynCinrsS3vb7XLVkUIJLBqUJR7attjc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UKBo+Zx4Jekr+6w+8cb5lfvaHQTXzwgilDLS1SdcGgNi26Y+dF/XXZScyBdLqWkg8c8SScrNkaK8R4lkkZrO4I4IXinLOaB9ocv2kldA1Ys1JlFwtnf+Rux2qA50baiRqCdIzh+rGr5yBT43SOYohc7znVWwKKPjIa46IaE7wcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=c5jLyZz7; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1773078635; x=1773337835;
	bh=9griTMnJyaBpxwmATvAiBepoJAgeJ3ngdZVcHM4W3fA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=c5jLyZz7GkFMnnlYFTYt+f+nFXDjVf/cFr4YCSWmFh903CvXPjmaNeW9wtsmFeHSZ
	 ER6RWNVbJZeo3Cp/jZ5jMT12PBUXpBCPk0L2/ZXJLwsifKdqcpC6/hlZzfuSKM9eY2
	 tzfbeZREpxVHB3xDpIJctP8AisYUr3CWUGkTTMLYGribo0cZTadaON2it79zVxPnse
	 uo3SAsJVYBC14awpkUegfxxtWz5/z2cXeQhicadOnyaZT2Kf0z3/LQah+DcqW32QOu
	 Ua8jYqsZypu/QIsN+QuCny7UnMgP8p+M42H9B1YtOaT6Qpkid//kdPehibUoH16ThL
	 G9P8nCjhz1G0A==
Date: Mon, 09 Mar 2026 17:50:31 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Sachin Kumar <xcyfun@protonmail.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "haoluo@google.com" <haoluo@google.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, "puranjay@kernel.org" <puranjay@kernel.org>, "emil@etsalapatis.com" <emil@etsalapatis.com>
Subject: [PATCH bpf v3] bpf: fix constant blinding bypass for PROBE_MEM32 stores
Message-ID: <S17sb-p71I59mreLZe4X_OOMw-HYrBr5vgnqwkKot5DN69iGriLx77wet16-_Hy7FHXKoCPwjc0zAy3G7o1C0A3amEpSPwVStZOF7x9qaig=@protonmail.com>
Feedback-ID: 42070492:user:proton
X-Pm-Message-ID: 194f8e61108226c429f71594d66a8adb7671cdbc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a"; charset=utf-8
X-Rspamd-Queue-Id: 4C26023E015
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,vger.kernel.org,google.com,gmail.com,linux.dev,fomichev.me,etsalapatis.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[xcyfun@protonmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,etsalapatis.com:email,protonmail.com:dkim,protonmail.com:email,protonmail.com:mid]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a
Content-Type: multipart/mixed;boundary=---------------------c6870ddadfc9ab00f0b0b3e6ffacd203

-----------------------c6870ddadfc9ab00f0b0b3e6ffacd203
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
survive unblinded into JIT-compiled native code when bpf_jit_harden >=3D 1=
.

The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
before bpf_jit_blind_constants() runs during JIT compilation. The
blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
unblinded.

Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
load the blinded immediate into BPF_REG_AX via mov+xor, then convert
the immediate store to a register store (BPF_STX).

The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
the architecture JIT emits the correct arena addressing (R12-based on
x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
BPF_MEM mode; construct the instruction directly instead.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the ve=
rifier.")
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Sachin Kumar <xcyfun@protonmail.com>
---
v3: Use legal name in Signed-off-by per DCO requirement.
    Fix block comment style (trailing */ on separate line).
    Added Reviewed-by tags. CC all maintainers.
v2: Rebased onto current bpf tree (commit 56145d237385).
    v1 had a malformed diff header that caused CI to reject it.
---
 kernel/bpf/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55..bb2fa75de 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1422,6 +1422,25 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off)=
;
 		break;
+
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX,
+				      imm_rnd ^ from->imm);
+		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		/*
+		 * Cannot use BPF_STX_MEM() macro here as it
+		 * hardcodes BPF_MEM mode, losing PROBE_MEM32
+		 * and breaking arena addressing in the JIT.
+		 */
+		*to++ =3D (struct bpf_insn) {
+			.code  =3D BPF_STX | BPF_PROBE_MEM32 |
+				 BPF_SIZE(from->code),
+			.dst_reg =3D from->dst_reg,
+			.src_reg =3D BPF_REG_AX,
+			.off   =3D from->off,
+		};
+		break;
 	}
 out:
 	return to - to_buff;
--
2.53.0
-----------------------c6870ddadfc9ab00f0b0b3e6ffacd203--

--------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wroEARYKAG0FgmmvCFgJEDdFhOkF7h23RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmedqL3CgZ4ZUEXfoY6eDqehB1/GCnBVpLeLq1mU
zoJMBhYhBDNZauekw/1HTib39jdFhOkF7h23AAD1KAD/RDgb+FMiAUZ5/pwF
fjmEBBAzTfGjYBUg6ro2yAYXjQwA+NjoGO2hYnjb9nk/DX1g/5Jg9nzCFiKK
Upy67eJAmws=
=XdT+
-----END PGP SIGNATURE-----


--------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a--


