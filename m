Return-Path: <netdev+bounces-288544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBxiK8jFB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB3559B90
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A7C3028B2A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14A231A41;
	Sat, 16 May 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo14/EpM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE681222599;
	Sat, 16 May 2026 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894234; cv=none; b=nTAVsdrNB/6PrtMjmODE6YKqp2B1GtirIpgIdtcfEA2hM+ag5i3UDTYTzxoZWS6NaCbrOBHlunqpT/gLDLcs6TmIEhdwVebhHJvWkx6XhdcsRKpSBmEsGxfbPpcwzO54j83+0r8UcRWr01QJKmEwwLJ2uRXQ29SJ8vGHsGkttk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894234; c=relaxed/simple;
	bh=3elAjoussU/pfI+r6dny1eAQ8Un5g1h/amxkchXsiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbXAD9q763fTKgZwOZ3h8yD+59hey9Lk0z6XNtiJUNohn0E3EuTiY2F3TEM7tTK0rXgxjMQkxfhnWt79sn1yaK8MPeog6zDBDQkA9aP9jtfpQp0g0kJqpHBpoHO0gLnWlj+x9xvK0hZOqxx3c8yO+pjzrkvksGpgcn8IQIr46ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo14/EpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11705C2BCB0;
	Sat, 16 May 2026 01:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894233;
	bh=3elAjoussU/pfI+r6dny1eAQ8Un5g1h/amxkchXsiOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vo14/EpMPynC/Q+h49O+r7iTbu9hJSJBKJIG7qCFBPRWrpR1Hc4q/fVnT5KOYQc8F
	 tnG1KWI97xNHaMHINDvW3pDgwt+URUpeq4U3QDHZD1hA4e1TP2hHDDvn+MDHFbluMa
	 pyi+xfNshH7NACEfI89cnydSNBIXxZ6+TkdSAMqr54CCYXvcyG+Ps7Wj/NvmJSE2Mw
	 f/sAjnuu9akxt56ezefqhF/lZPqW76fUmjBK7U73YfKIKWZ8iZ43+uG+qB7rrj299H
	 9PRSsSZAPM6tr8GdtADEfyQkyUY+pOO+fRZ8WSapqbKpCLGU+3WRstKHHxJvbog+gF
	 y8smReGrjjaPg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 net-next 03/11] net/nebula-matrix: add chip related definitions
Date: Fri, 15 May 2026 18:17:12 -0700
Message-ID: <20260516011712.1863824-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-4-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-4-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15BB3559B90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288544-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add chip related definitions

This patch adds chip-related register definitions for the Leonis
hardware and introduces nbl_write_all_regs(), which programs a large
set of P4 configuration tables at chip initialization time.

> They also should not be moved into firmware files,
> as the software functionality is tightly coupled with these
> configurations.If they were moved to firmware,users could easily end up
> with mismatched versions of the firmware and the kernel driver module,
> leading to functional inconsistencies or system malfunctions.

Is it acceptable to bypass the standard request_firmware() API by embedding
these large configuration blobs directly in the C source?

Embedding large configuration blobs bloats the kernel image. Versioning
compatibility is typically handled through embedded firmware headers and
versioned file requests rather than static inclusion.

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h

[ ... ]

> union nbl_mailbox_qinfo_map_table_u {
> 	struct nbl_mailbox_qinfo_map_table {
> 		u32 function:3;
> 		u32 devid:5;
> 		u32 bus:8;
> 		u32 msix_idx:13;
> 		u32 msix_idx_valid:1;
> 		u32 rsv:2;
> 	} __packed info;
> 	u32 data;
> };

Can the use of C bitfields for hardware register formats cause endianness
portability regressions?

The memory layout and bit-packing direction of C bitfields are
compiler-defined and vary by CPU architecture endianness. On big-endian
systems, writing the 32-bit data representation to an MMIO register might
transmit the bits in reverse block order compared to a little-endian system.

[ ... ]

> #define NBL_FUNC_MSIX_MAP_DWLEN		3
> union nbl_function_msix_map_u {
> 	struct nbl_function_msix_map {
> 		u64 msix_map_base_addr;
> 		u32 function:3;
> 		u32 devid:5;
> 		u32 bus:8;
> 		u32 valid:1;
> 		u32 rsv0:15;
> 		u32 rsv1;
> 	} info;
> 	u32 data[NBL_FUNC_MSIX_MAP_DWLEN];
> };

Could this size mismatch lead to incorrect hardware register array strides?

The struct contains an 8-byte u64, 4 bytes of bitfields, and a 4-byte u32,
making the unpacked struct 16 bytes. However, NBL_FUNC_MSIX_MAP_DWLEN is 3,
making the u32 array 12 bytes long.

Because a union's size is determined by its largest member, the sizeof
evaluates to 16 bytes. The macro NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(i)
uses this sizeof to calculate hardware offsets, which might lead to writing
MSI-X configuration to the wrong PCIe offsets.

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c

[ ... ]

> #define NBL_SEC021_SIZE			1
> #define NBL_SEC021_ADDR			0x8c1f8
> #define NBL_SEC022_SIZE			256
> #define NBL_SEC022_ADDR			0x85f000
> #define NBL_SEC022_REGI(i)		(0x85f000 + NBL_BYTES_IN_REG * (i))
> #define NBL_SEC023_SIZE			128
> #define NBL_SEC023_ADDR			0x85f800

Could this NBL_SEC022_SIZE macro introduce a regression by truncating the
hardware initialization data?

The macro is defined as 256, which means only the first 256 elements of the
NBL_SEC022 block are written. However, the corresponding data array
nbl_sec022_data contains 512 elements, and the address gap between
NBL_SEC022_ADDR (0x85f000) and NBL_SEC023_ADDR (0x85f800) is exactly 0x800
bytes, which fits exactly 512 u32 registers.

