Return-Path: <netdev+bounces-244091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C6CAF93C
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 703803013F19
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59A322C7F;
	Tue,  9 Dec 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mDF7JJRg"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54015322B72;
	Tue,  9 Dec 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274630; cv=none; b=hzqDjBAIPaLnYcUMp1O9NsTGHVVrld758MugNv2uK/K0oe2LNo+EPHvlqzEbj0TuUYS47DuX1VmS2eIN55q/hyDYf95298kR8AALDKOWW6gNOWb3OQw3fAm/fgzdJ4CfWQx8jlw8om+fRjUL2/4cnRo2KJSULohGM1StmgdSAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274630; c=relaxed/simple;
	bh=ElQoc6Q6ybtyS+Hep2dc9k8iOBrdGzj7Eg1MlmnxTac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WvlUSKDPcPikO38z4rvS28uMoxpasd82k7BVvUd/NwPUKQ87n//SE7s1yBnlq731a/CqLJLAklA2RuiFHhyTfGyATYXtNnCT2iAC+hkXp6i320NaVhYYDDHyMyVTuQ/1cOqNS7BUW2BrZPhDVFUgmfxPxQG2dLxdhfVBQ5Hg3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mDF7JJRg; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ8-00HD55-AE; Tue, 09 Dec 2025 11:03:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=9/ne1fM+49A5MdyQAccO5Q+S8uNSJksiax63cH+c4Rw=; b=mDF7JJ
	RggUJ2tyGz6PkVOXawBRxJO3wdiBWv7A+9DhopCTU4Sl5/xD4ts/SodvDSu3DFzZlAygQOgfYnnt/
	gceWzwBrHOC1hJb4cpEvnP2YgngCHx8x203PqjNTr/vfCkwDNYWZ571bYgYURjJjNg1pEDqbfSTYa
	2zht8lJI/SISneWYqm4J1xVLlbYOpCqv2z28pUj7jZW6c0i87z7hHB+O6a+q2xkCdRdrudeP4rQ+7
	DZ35ms99jpSjdXeMyYiYQsKECxN9pwGIHwzbsz2tcPxm/UHTI2tXz/RSGd3M1w/9bTctEo6WSrapV
	IAtmpdE2muFMyO3GIgF8vvJPKhig==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ7-000752-TU; Tue, 09 Dec 2025 11:03:30 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ0-00CND9-4z; Tue, 09 Dec 2025 11:03:22 +0100
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
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 0/9] bitfield: tidy up bitfield.h
Date: Tue,  9 Dec 2025 10:03:04 +0000
Message-Id: <20251209100313.2867-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Re-send with patches going to everyone.
(I'd forgotten I'd set 'ccCover = 0'.)

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


