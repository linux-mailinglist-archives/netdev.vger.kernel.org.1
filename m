Return-Path: <netdev+bounces-59089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807788194C3
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 00:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11C0B2367A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14B3EA7D;
	Tue, 19 Dec 2023 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XF0psh0q"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689B3D3A0;
	Tue, 19 Dec 2023 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2DE6E2E5;
	Tue, 19 Dec 2023 23:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2DE6E2E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703029873; bh=QDHuHcjPbAEzrE9RHuknoM9QEOx2FrXu/2JTRq9S4Ss=;
	h=From:To:Cc:Subject:Date:From;
	b=XF0psh0qXs4vrysvRvsggaaIgnLkLnw4HddaOhA5r/oXvAbxkDI34aPZM8XukAw2r
	 Dkn4gZBioNQwEDQP0JGYV934qH9Un0KSqCgQHm274dfLlSoCpDyDsRegjqiU9T1MeB
	 TbzJ6F9fdTUEj/CHS/FE8xiVPpp99TijP8tM/a1Sdg8EpLGCAlyznJ4deH+ZgdJn7F
	 4QKYXqvj1NbZCQBf+uraDk+2HbU04e4i+kMny9ceRQ/NhvUM0qUXW5FJwf7nKhFTY6
	 wQWP62jMlcDJ4iezS3w/vnEB/+cUgKoDOm9fHRubllmaL+WNClmUK4sLp60mJSi2Vv
	 t0/qWtTieudUw==
From: Jonathan Corbet <corbet@lwn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sock: remove excess structure-member documentation
Date: Tue, 19 Dec 2023 16:51:12 -0700
Message-ID: <874jgdhhu7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remove a couple of kerneldoc entries for struct members that do not exist,
addressing these warnings:

  ./include/net/sock.h:548: warning: Excess struct member '__sk_flags_offset' description in 'sock'
  ./include/net/sock.h:548: warning: Excess struct member 'sk_padding' description in 'sock'

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/net/sock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3..bee854b477b2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -277,8 +277,6 @@ struct sk_filter;
   *	@sk_pacing_status: Pacing status (requested, handled by sch_fq)
   *	@sk_max_pacing_rate: Maximum pacing rate (%SO_MAX_PACING_RATE)
   *	@sk_sndbuf: size of send buffer in bytes
-  *	@__sk_flags_offset: empty field used to determine location of bitfield
-  *	@sk_padding: unused element for alignment
   *	@sk_no_check_tx: %SO_NO_CHECK setting, set checksum in TX packets
   *	@sk_no_check_rx: allow zero checksum in RX packets
   *	@sk_route_caps: route capabilities (e.g. %NETIF_F_TSO)
-- 
2.43.0


