Return-Path: <netdev+bounces-251948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLA6ERf/cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6559E86
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A516AC6337
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F04A1397;
	Wed, 21 Jan 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="fYhnhJGM"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DA36C0B0
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007488; cv=none; b=R1dYuqwz+Yi38ls3IMZzEj1FS9TgyjQgDBkCbFN6QGN1XmOWomKv1La5Vtqu49Oo4CEmswybfCdxWt7/cDUjD9p01xXzSxeupypkHxzyWz3keBPwlb8CqiTNMEZVcg1FRgjDSVZNDsQk77T+ARZBp9lMjRW/uLebcW/9+U88Dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007488; c=relaxed/simple;
	bh=oUil1PSbpdW8l/EZqYUD6MgfudPMsJ/Dl/SlawdMFbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+phWhSU8PqcCOK64SjJgZqP4uX/h16iUYA5gacZy+/GIFv9B/4iTwBDVTCHu5Ww74xvtTYbGJY8usGdC0+1sPkmKa/PJEuLM2eF3ZbK8JMIM8niVikkzG242j7xQdKBIrTboQrdHWJb+T7ZrfDU5aVyHxMxszJcrZ4hzXmpdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=fYhnhJGM; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeU-008XBy-KV; Wed, 21 Jan 2026 15:57:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=d5psKbM9b9F92Ofu3J7qeNSznHQbQCDOEGVP2pI5G20=; b=fYhnhJ
	GMqFPmg2nUrlYgC52xGWlJaylWPExu9epLZHvNOlU5tDiklIf1PGlMr/0K8arr94upoOxgL5LI/h/
	q6YMHStKamdRlfViuz6rleLLPwhCrv3ljVDuamOWY0K55s7YRskGLYP2MhYZcJX3GRcvelnEGVJBX
	ejupS1Aekc3QGbBZentjc2QKPySIn0ekdWJFYcsI+JFhVFkSE0TRJ/Po/1EWQ6UWPEiYfijw+1jLj
	qZFzVnNF0h9st9eLMT7KsOMQ0KhmA12oDxw+TrCIcuYckXFS2CRkvC+WwvTaDrN9E2Fl05sFeNOd6
	QYV1pEZ1RgYdXyTQdv8+1Iya4sRg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeS-0006jd-RY; Wed, 21 Jan 2026 15:57:45 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeR-00GH6h-VK; Wed, 21 Jan 2026 15:57:44 +0100
From: david.laight.linux@gmail.com
To: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH next 00/14] bits: De-bloat expansion of GENMASK()
Date: Wed, 21 Jan 2026 14:57:17 +0000
Message-Id: <20260121145731.3623-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251948-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linutronix.de,infradead.org,efficios.com,arndb.de,vger.kernel.org,gmail.com,intel.com,wanadoo.fr,linux.intel.com,chromium.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,samsung.com,intel.com,davemloft.net,google.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B5D6559E86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Laight <david.laight.linux@gmail.com>

The expansion of GENMASK() is a few hundred bytes, this is often multiplied
when the value is passed to other #defines (eg FIELD_PREP).
Part of the size is due to the compile-type check (for reversed arguments),
the rest from the way the value is defined.

Nothing in these patches changes the code the compiler sees - just the
way the constants get defined.
Changing GENMASK(hi, lo) to (2 << hi) - (1 << lo) is left for further study.

I looked at getting the compiler to check for reversed arguments using
(0 >> (hi - lo)) instead of const_true(lo > hi). While checking that it
was always optimised away I discovered that you don't get an error message
if the values are only 'compile time constants', worse clang starts
throwing code away, generation an empty function for:
	int f(u32 x) {int n = 32; return x >> n; }
(Shifts by more than width are 'undefined behaviour', so what clang
does is technically valid - but not friendly or expected.)

So I added extra checks to both GENMASK() and BITxxx() to detect this
at compile time. But this bloats the output - the opposite of what I
was trying to achieve.
However these are all compile-time checks that are actually unlikely
to detect anything, they don't need to be done on every build.
I've mitigated this by adding W=c (cf W=[123e]) to the main Makefile
(adding -DKBUILD_EXTRA_WARNc) and defaulting to W=c for W=1 builds.

Adding checks to BIT() makes it no longer a pre-processor constant
so can no longer be used in #if statements (when W=c) is set.
This required minor changes to 3 files.

At some point the definition of BIT() was moved to vdso/bits.h
(followed by that for BIT_ULL()), but then the fixed size BIT_Unn()
were added to bits.h.
I've moved BIT_ULL() back to linux/bits.h and made the version of
BIT() in linux/bits.h be preferred if both files get included.
Note that the x86-64 allmodconfig build suceeds if vdso/bits.h
is empty - everything includes linux/bits.h first.

I found two non-vdso files that included vdso/bits.h and changed
them to use linux/bits.h.

GENMASK_U8() and BIT_U8() cast their result to (u8), this isn't
a good idea. While the 'type of the expression' is 'u8', integer
promotion makes the 'type of the value' 'signed int'.
This means that in code like:
	u64 v = BIT_U8(7) << 24;
the value is sign extended and all the high bits are set.
Instead change the type of the xxx_U8/U16 macros to 'unsigned int'
so that the sign extension cannot happen.
The compile-time check on the bit number is still present.

For assembler files where GENMASK() can be used for constants
the expansions from uapi/linux/bits.h were used.
However these contain BITS_PER_LONG and BITS_PER_LONG_LONG which
make no sense since the assembler doesn't have sized arithmetic.
Replace with GENMASK(hi, lo) (2 << (hi)) - (1 << (lo)) which has
the correct value without knowing the size of the integers.

The kunit tests all check compile-time values.
I've changed them to use BUILD_BUG_ON().

David Laight (14):
  overflow: Reduce expansion of __type_max()
  kbuild: Add W=c for additional compile time checks
  media: videobuf2-core: Use static_assert() for sanity check
  media: atomisp: Use static_assert() for sanity check
  ixgbevf: Use C test for PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
  asm-generic: include linux/bits.h not vdso/bits.h
  x86/tlb: include linux/bits.h not vdso/bits.h
  bits: simplify GENMASK_TYPE()
  bits: Change BIT_U8/16() and GENMASK_U8/16() to have unsigned values
  bits: Fix assmebler expansions of GENMASK_Uxx() and BIT_Uxx()
  bit: Strengthen compile-time tests in GENMASK() and BIT()
  bits: move the defitions of BIT() and BIT_ULL() back to linux/bits.h
  test_bits: Change all the tests to be compile-time tests
  test_bits: include some invalid input tests for GENMASK_INPUT_CHECK()

 arch/x86/include/asm/tlb.h                    |   2 +-
 .../media/common/videobuf2/videobuf2-core.c   |   6 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  17 +--
 .../fixedbds_1.0/ia_css_fixedbds_param.h      |   5 +-
 include/asm-generic/thread_info_tif.h         |   2 +-
 include/linux/bits.h                          |  88 ++++++++----
 include/linux/overflow.h                      |   2 +-
 include/vdso/bits.h                           |   2 +-
 lib/tests/test_bits.c                         | 130 +++++++++++-------
 scripts/Makefile.warn                         |  12 +-
 10 files changed, 162 insertions(+), 104 deletions(-)

-- 
2.39.5


