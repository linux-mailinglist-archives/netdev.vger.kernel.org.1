Return-Path: <netdev+bounces-244555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F224CB9BEA
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F51B30A5E9D
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BA30EF88;
	Fri, 12 Dec 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="rcQrJ1Uq"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF22DFA3A;
	Fri, 12 Dec 2025 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570380; cv=none; b=nD9iToPmw7sr+PRR8NfyMQSIXPK2UPknvRfzloBIgJakUqKbX/UqcJ1QS0EMM859yq/5alrJZPG8aKHs/hTW9kUcGAHxBtqa+bhZy3cOoOinIB/95Q960lAR1nI0wXvp8Zmef693KbK6FUwmXT93t22gf//l7chTGP0W7pAEn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570380; c=relaxed/simple;
	bh=v4FUhHFdi5ZXqVqGPGRtWuk27Ggt9EW1AEDL4D/CxK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5AQyjhmDrEeVIXO4uT1rHNLRuYIVSML91qIsfsFCSTVDluS79vQFPoVCuSX9nYOHtfXzze+LlinWXMk/fsoZON7oSunJxNPniFYaQMwAvE90/23DOId1qMPUBN0dPwbIlFuVtstnKOXURvxF3T/YIBTL7w71JlLv9MLTK1me54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=rcQrJ1Uq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xb-0087YP-88; Fri, 12 Dec 2025 20:37:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=4XbSLZvBmYJ9LzNNMyiNSXY8ll6ZHX2gvyxQipHU0mg=; b=rcQrJ1
	UqegrICDo4fAnkhXKRRqrV0O8Ls326sDv/JcKcAk6Al2todKLnhlDNHsWwE3AK6hL1vZSqmtNyNVE
	1OroZmCdGG07T7I6ydVzd/0k9mznWFvrss5MbAQmlkY6gfYbY6wdrXKKJTBvudku0zcOZrcX7kXs6
	MCA+d2s5ZzuEFiEIdof9pZd6Ezoxs68O7fatVUKHjvMLYTxCWcRixnBFSnf/aJwm0C9NJCGdMjTq5
	udguTWojDliIij6K8xW7LDs1g/RP381FYb0iKSH4SOcYfKKVbtxo46b/ul2fQTf3YFHb7+4Uta+sI
	pOo4poy5yN6CaWpipJVUCkx0WELQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xZ-00039D-A3; Fri, 12 Dec 2025 20:37:49 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xY-0030pR-Gm; Fri, 12 Dec 2025 20:37:48 +0100
From: david.laight.linux@gmail.com
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 0/16] bitfield: tidy up bitfield.h
Date: Fri, 12 Dec 2025 19:37:05 +0000
Message-Id: <20251212193721.740055-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

I noticed some very long (18KB) error messages from the compiler.
Turned out they were errors on lines that passed GENMASK() to FIELD_PREP().
Since most of the #defines are already statement functions the values
can be copied to locals so the actual parameters only get expanded once.

The 'bloat' is reduced further by using a simple test to ensure 'reg'
is large enough, slightly simplifying the test for constant 'val' and
only checking 'reg' and 'val' when the parameters are present.

The first two patches are slightly problematic.

drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c manages to use
a #define that should be an internal to bitfield.h, the changed file
is actually more similar to the previous version.

drivers/thunderbolt/tb.h passes a bifield to FIELD_GET(), these can't
be used with sizeof, typeof or __auto_type.
The existing FIELD_GET() uses _Generic(); gcc treats 'u32 foo:8' as
'unsigned char' and clang treats 'u32 foo:n' as 'unsigned int'.
So the code currentyly compiles 'by accident', pass 'u32 foo:6' and
gcc will error the attempt to use typeof with a bitfield.
For v2 fixed by changing the structure definition to use u8 for the
relevant field.

Both changes may need to to through the same tree as the header file changes.

The changes are based on 'next' and contain the addition of field_prep()
and field_get() for non-constant values.

I also know it is the merge window.
I expect to be generating a v3 in the new year (someone always has a comment).

Changes for v2:
- Change thunderbolt header (see above).
- Fix variable name re-use in FIELD_PREP_WM16()
- Use 'mask' (not _mask) in __BF_SHIFT().
The changes to bitfield.h have been split into multiple patches,
but the actual final file only has whitespace differences.

David Laight (16):
  nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG() wrapper
  thunderbolt: Don't pass a bitfield to FIELD_GET
  bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
  bitfield: Copy #define parameters to locals
  bitfield: Merge __field_prep/get() into field_prep/get()
  bitfield: Remove some pointless casts
  bitfield: FIELD_MODIFY: Only do a single read/write on  the target
  bitfield: Simplify __BF_FIELD_CHECK_REG()
  bitfield: Rename __FIELD_PREP/GET() to __BF_FIELD_PREP/GET()
  bitfield: Split the 'val' check out of __BF_FIELD_CHECK_MASK()
  bitfield: Common up validation of the mask parameter
  bitfield: Remove leading _ from #define formal parameter names
  bitfield: Reduce indentation
  bitfield: Add comment block for the host/fixed endian functions
  bitfield: Update comments for le/be functions
  build_bug.h; Remove __BUILD_BUG_ON_NOT_POWER_OF_2()

 .../netronome/nfp/nfpcore/nfp_nsp_eth.c       |  16 +-
 drivers/thunderbolt/tb_regs.h                 |  16 +-
 include/linux/bitfield.h                      | 278 ++++++++++--------
 include/linux/build_bug.h                     |   2 -
 include/linux/hw_bitfield.h                   |  21 +-
 5 files changed, 175 insertions(+), 158 deletions(-)

-- 
2.39.5


