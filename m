Return-Path: <netdev+bounces-244043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB5CAE591
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 23:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D4730BC964
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A332FD7BE;
	Mon,  8 Dec 2025 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="CDOcACpX"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3442FD7AE;
	Mon,  8 Dec 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765233803; cv=none; b=ffg2aMw8HoHHZ7pvo7feoPfM2MUdMvb2o+Z1HPZD4nDiYYqBApgVM45YFnfEMp7IK32JH6d62OjLgd3mSg5NLv0e53jrolFW+OBr7td9CmnNqOQYNrS2qtMkQ5kbKqXx8EZ8hpAyaKmfhEn+gr5Sk6KUSMaK0pzRoMz/yX3jtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765233803; c=relaxed/simple;
	bh=JXljNUIUvb4ts/wwRhSyRU1AftuVaAChwnxRwoh+f+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HBrZrh77ejug/wn1sGr5hjPvLjGxCil8Bb7FnfEkMPHGhyZ2pMepavsoYZ6NGaVzUB5ApaCZRXpNHb4r/NgxEwIhr+7NJ9FyILg8A3J2r6LRtPmI4w2zE6z4lC9BJJ9rJeLnuSciqiO6qfbtRjC3W2jRP0MjdlQtxYGnrqc0WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=CDOcACpX; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSjwj-00F31I-Kn; Mon, 08 Dec 2025 23:43:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=hwKjBAZQtWwFYTCLUqyg8JkLhg8C+yX0fo4ldavrNvM=; b=CDOcAC
	pXafDvTrVt8VOhumNaS6X9IiWkUCzDJI8+96GjAHKghUBeqWCyP8EOJM1nDl095owWL68GWTm2Jcd
	IBQIJ0zPFfCKydNBAq0Vka22gi0gDFL6FEPEAF26JxjLhGixgkKMAb8g56l2j1ehjXiMsx+V1bqyx
	fGgQfFzpm9ZG38OdjRFQzhYoxOk4DxWVX4dsa6/rGXb0thY+8sgo3rWfVbyGWGeazJC3gfYJ/3iX1
	tjBgyrpWO2eAHYWtGZfP+kjInLoHnlk5cHgmiHGyKhkdhu1uCK9iD7vzM32iDvlGfyB7bCmtqzhPL
	ut/jZtBYBSjjCWIr2O/GKIi8DVpA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSjwh-0003Co-Pl; Mon, 08 Dec 2025 23:43:07 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSjwf-00Ay0v-DG; Mon, 08 Dec 2025 23:43:05 +0100
From: david.laight.linux@gmail.com
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Laight <david.laight.linux@gmail.com>,
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
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH 0/9] bitfield: tidy up bitfield.h
Date: Mon,  8 Dec 2025 22:42:41 +0000
Message-Id: <20251208224250.536159-1-david.laight.linux@gmail.com>
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
be used with sizeof or __auto_type. The usual solution is to add zero,
but that can't be done in FIELD_GET() because it doesn't want the value
promoted to 'int' (no idea how _Generic() treated it.)
The fix is just to add zero at the call site.
(The bitfield seems to be in a structure rad from hardware - no idea
how that works on BE (or any LE that uses an unusual order for bitfields.)

Both changes may need to to through the same tree as the header file changes.

The changes are based on 'next' and contain the addition of field_prep()
and field_get() for non-constant values.

I also know it is the merge window.
I expect to be generating a v2 in the new year (someone always has a comment).

David Laight (9):
  nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG() wrapper
  thunderblot: Don't pass a bitfield to FIELD_GET
  bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
  bitfield: Copy #define parameters to locals
  bitfield: FIELD_MODIFY: Only do a single read/write on the target
  bitfield: Update sanity checks
  bitfield: Reduce indentation
  bitfield: Add comment block for the host/fixed endian functions
  bitfield: Update comments for le/be functions

 .../netronome/nfp/nfpcore/nfp_nsp_eth.c       |  16 +-
 drivers/thunderbolt/tb.h                      |   2 +-
 include/linux/bitfield.h                      | 278 ++++++++++--------
 include/linux/hw_bitfield.h                   |  17 +-
 4 files changed, 166 insertions(+), 147 deletions(-)

-- 
2.39.5


