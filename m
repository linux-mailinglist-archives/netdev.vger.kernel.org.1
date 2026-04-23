Return-Path: <netdev+bounces-280564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XW76NXtl6WntYQIAu9opvQ
	(envelope-from <netdev+bounces-280564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FEB44BE7B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DA33046E99
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85C1C861D;
	Thu, 23 Apr 2026 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/bm0I+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CF7081E
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776903545; cv=pass; b=uDfoQaeWEtYLKor7JIKHNcq9Wx/3yzr6fTp4Nksp9xd+ZwdoqJsb5x8+C2ErgmW2foLAal2/coNixOk3CNnIwqksbyI3HO4jgpxj+IxweZImCfLvoACFQE1MTL9HkQV9juTRBr2PQ6e0CP+LJgfD4SnyzyscFFHmIiOVntS/fkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776903545; c=relaxed/simple;
	bh=xPfQX7ecCwHamDgt9lbkH6i+H0zd7nFxoAPuF2akeBM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bGbs/HBZqRcYkzE+MJaZbp/CHa2douj2AQVFJJf4JC48u3/pJEETwFEb5C5TR366cwTYxH59Y+97QwVKoiVGeD8fxW0RZOrOwiUo2x2cncAyo1oaSta1DUZlwt2KfTJD2vr/fiNUMspp5HatNSXbaSlaw8OwWBqztLnafB/MPig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/bm0I+5; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so103867a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 17:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776903541; cv=none;
        d=google.com; s=arc-20240605;
        b=FkGlV5zIVuUvHVH0Wfukfj8SoivizGRB2t2ZMiQywQnjnPeKj2fQ9mrjfcR57jFrMb
         CF3sNiYKratAsheQykt5rxbDXod0HnioiVhjeTDkPmI+3g87CzlpcpL5soZg62xqwfAo
         kQkNQ534+oGYoCZ+kLwwEwGL/Whvp70njV61pBk3ClYqi0PNoTjm8RNerF+FYPTqY81Q
         yzlhqzhXm7XqkCGRbRXwChln1Pice8C7P5NKKMWRe/MRQoC8/otG32qmjE8ld9fBu3r3
         3Y/fCf3RLcZ3MNaWJTOW/hfjcNPbusLzlDef0QRtxRGf6uitPBIrtBjuegRlNna4PG2R
         RMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2wUS8p2B2jX85ZQaunMPh/qwUIK9gI9JANs6k6oiuqo=;
        fh=WqH0sgpNbWJQtMRd0PIoIRs6h6SREJuOGsN0K1LJnsA=;
        b=JTvDjtB9/0OiGDub9UjlYv14fkjH8RxD6TVk8LyTju47nIjB8bukWAPhsrzZaB405i
         ToG80Wo5yIYiy9h6F1Wz92PXKmAOTda/8VlhJ1WkesI/Pe0y9CyigKZMaK5fLPzrT2GS
         dQgGtjSaevUA6ZjABtLHc+/JWEDiAXDA6kNfjnNQIB3hoZPL2QZxPHHPcydYd/QmoO6Q
         uBsvxzAS3/UylxkJhOZOjSlTR9cfZE9JrplyIhPHI1T8pooFpHzwq8e9TiDfPBn88iKE
         cN25J4l6a2wEpggVIk5GZe/ZsSGtfuh2Hm72wiuc9mZ5Se/0EuYA7O/bGvj+0e5e0WWn
         Z7lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776903541; x=1777508341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2wUS8p2B2jX85ZQaunMPh/qwUIK9gI9JANs6k6oiuqo=;
        b=d/bm0I+5TbhqL0WGiEIeKdscTV6BdI9QfACpfU9wREUKAchNsY8hMHyry+QsLm+pWm
         p7gFYnNf3zxUpDexdMuBEJLQdqKgQSL+V7uX9iidc+A58D+N9aOVwTjyaYFj/5CpfWh2
         bjGj/z4VkY2tsR1pAeZ9ai2nevi2PjcJbSaXG/TsnDvVITuBxa3dAgcPpuh5SbyWmBU+
         sqrvu8p0TzaZYNHHY2R53cZfVz8OIxmkf8bttf9V51lQw/NqSqfzuUf9yhNkf1zdiHau
         4jT4Dn4P8mSCBkIQ4mn5BYNu33XKBJ9GJAvw1CPgNRe2q+/XvTfXYOCNeT3YlUEYNOsq
         egWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776903541; x=1777508341;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wUS8p2B2jX85ZQaunMPh/qwUIK9gI9JANs6k6oiuqo=;
        b=l3Pbbdu7jejGesPHMKoSaartAOt/zgXS+u4uncK/kMikrSwIntXuxa2xmmjurvwbiv
         oX6WGdPp1iDQCJjNsiottvuL5Imu9I1Dk5JKk5qB+J7XQCvlrpVcCNWwrGTGViJRjMM4
         axi6R7q3YMNC22pL1LJ67nFJ4wExNJDnDFWOLCBSLIqwExkLEKn1ncEfNB/0Gc7Rensr
         aea1iznFM6Yt0W04fLZ6IY0JavUyarELW6LxT0EgQ1D/8mtPwrRDLTYwK4drdH5xW2NN
         VqEIdN/KrdsVcwd5C5sSF/QwWuNUa0vB0ek4R4tijGIObpLUT161Q+26wfQdzWhRleWr
         iRsw==
X-Gm-Message-State: AOJu0Yx9xtNopJhSVaBvf4cUor1djBg6qGasiuAsxNLxTZ1hLZqdZrIk
	cyUMTWyaLbZejsYjeQ8frsp6UjNkjJcQ0gZY9v1bdtHiQuf7Vd8kHHTx+1J1RCjuysnF7x03m1R
	kGmgjYFzLwTddWvpk561QAnu7XgzcgVvIS6cH
X-Gm-Gg: AeBDiet/tmtRTlde6ek4/RrVHuvM4sua66H3uAeiDcDsCZPl53XPTl3Nn0Gxi7+SHYr
	6LND8ddqo10wxhhH89aJVeFL43fWjaR0BdCpz4zqNW2uBiMVG23cAirSVqaz4ZaFEaxRlIStog2
	usMfo3JhJLd1V1gzlGyKmmv9uYIuX3Iuhtw3O1F3daUER9tzle+VbNc6GcACYm56DB1qa8DEn2d
	S1UXOSBR5x5m53lcMpSsRqwoBGMST77XAwJMbHUH6kwyKF35DtXooEYBZXhdnyfTFTDloXVXhcO
	Nqnn37bcFOdHE/RJh7lUxnPO8KjeFkbHFsJknrVVBi8IBQnZv1ZWJQQuCg==
X-Received: by 2002:a05:6402:46d6:b0:671:d016:df0f with SMTP id
 4fb4d7f45d1cf-672c128176dmr9860566a12.4.1776903541221; Wed, 22 Apr 2026
 17:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Thu, 23 Apr 2026 10:18:49 +1000
X-Gm-Features: AQROBzBKTN6o-3-mZKKNokAuQc8QL5I1tojTBkpn-NBUowigxUF9OS89D90GjJQ
Message-ID: <CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com>
Subject: CL37 autonegotiation not working on amd-xgbe
To: netdev@vger.kernel.org
Cc: Shyam-sundar.S-k@amd.com, Raju.Rangoju@amd.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280564-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patrickoppenlander@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 32FEB44BE7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

A recent change [1] stopped CL37 autonegotiation from working on
amd-xgbe hardware.

The driver thinks autonegotiation is succeeding, but no data is able
to transfer across the link. Here's an mdio/phy debug log showing the
link coming up successfully in the broken state:

amd-xgbe 0000:07:00.2 control-sfp: phy powered off
amd-xgbe 0000:07:00.2 control-sfp: CL73 AN disabled
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN disabled
amd-xgbe 0000:07:00.2 control-sfp: starting PHY
amd-xgbe 0000:07:00.2 control-sfp: 10GbE SFI mode set
amd-xgbe 0000:07:00.2 control-sfp: 1GbE X mode set
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN (BaseX) initialized
amd-xgbe 0000:07:00.2 control-sfp: AN PHY configuration
amd-xgbe 0000:07:00.2 control-sfp: CL73 AN disabled
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN disabled
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN (BaseX) initialized
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN enabled/restarted
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN Complete
amd-xgbe 0000:07:00.2 control-sfp: Auto negotiation successful
amd-xgbe 0000:07:00.2 control-sfp: CL37 AN result: Complete
amd-xgbe 0000:07:00.2 control-sfp: Link is Up - 1Gbps/Full - flow control off

I've tried SFP modules and switches from multiple vendors, and no
combination of hardware successfully autonegotiates after the change.

Unfortunately there appears to be no public documentation available
for amd-xgbe, so it's basically impossible for me to debug any
further. I've included a patch which "fixes" the issue, but given the
lack of documentation I have no idea what it really does.

If there's any more information I can provide to help diagnose the
issue, please let me know.

Patrick

[1] https://patch.msgid.link/20250630192636.3838291-1-Raju.Rangoju@amd.com

-- >8 --

From d17b2e685cc0e389f9c62b6cae735b2ef7d8c49b Mon Sep 17 00:00:00 2001
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Thu, 23 Apr 2026 09:37:51 +1000
Subject: [PATCH] amd-xgbe: fix CL37 autonegotiation

Broken after 42fd432fe6d320323215ebdf4de4d0d7e56e6792.

I can't find any documentation for this hardware, so this change really
just reverts the part of the commit which made autonegotation stop
working.
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index e4334c12b3e15..7639961db0af4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -377,10 +377,6 @@ static void xgbe_an37_set(struct xgbe_prv_data
*pdata, bool enable,
         reg |= MDIO_VEND2_CTRL1_AN_RESTART;

     XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
-
-    reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
-    reg |= XGBE_VEND2_MAC_AUTO_SW;
-    XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
 }

 static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
-- 
2.53.0

