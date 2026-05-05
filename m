Return-Path: <netdev+bounces-284401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF34HfLv+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A014CE721
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EB1A3067B38
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77A423A9C;
	Tue,  5 May 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JRg6o3tU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EC30B50C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987423; cv=none; b=c8wUMQeBwZgxRTer4nlFdUdutNN2btX+RaMD7g/nn8MtJuRp7MpgIklIVBozWvn0IpTuRo5XxbcTTFsF+aVP8KEWmiu/+aA41MFAf41/6PQ5fSH/Hazz2IC7gfRc7JZzqSHUI37Dpigj95CAXjgPOtT6P6d1EOQSh2p7uxAxQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987423; c=relaxed/simple;
	bh=+urY9G6Qvsi7lMQsxDY4J7yLdt3L1IfMo9POajoOpXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FmFC0wAEosyqL9bQAs/e4PVbv02pdtXGIlE3wpLB147aya0pPlPRN49lFzkHjuHmTwkUZQ9io4aicjRC3ncsCTEBSAUG6CA7yOnQViJDVj+RcwNYf2+kXWybXV9Ww3sfYEZk0yollshBDXUMhuAeY7ILkwINvVcVhu0/eKiWCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JRg6o3tU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A19082067A;
	Tue,  5 May 2026 15:23:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DZF9AteIrgRv; Tue,  5 May 2026 15:23:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 39C2A201CC;
	Tue,  5 May 2026 15:23:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 39C2A201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987412;
	bh=54Ht+tyk91Yp2V+KcAUa91dlbt37TCoj+3tBgXmNg/I=;
	h=From:To:CC:Subject:Date:From;
	b=JRg6o3tULq2DvdkIrnK6tbG3GDY7PxsdahRUxsDyDRVA7db8jbspCBJFWy/jO/RdT
	 AWuSMWaRPpGiv34hygGcVc5DjWmBH07BbsOpG/RRrOVnoMlVhIJGc0yskmjmsIFocD
	 DbaKS5lVfcGN/r3mbcM+CkWKEU+uZDd1nejxr1UrBFtPFqQvvOA9SV1NiKT3DNE+KL
	 sAomRrOuvN9hKkALEQlFPDWZqPSsA7a+sBLDATwT11U00MoQYC4GtS2HS2WPXNzp5V
	 ReD/TaWj1TYl7hL09Nx5GMgUvTmk28TrFtYbQn8MdkhAbFBfw8cnGRRXy6yQxSBnrb
	 yIWQ9GzkUCDfQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:31 +0200
Received: (nullmailer pid 1364076 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/8] pull request (net): ipsec 2026-05-05
Date: Tue, 5 May 2026 15:22:56 +0200
Message-ID: <20260505132326.1362733-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: F2A014CE721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

1. Fix an IPv6 encapsulation error path that leaked route references
   when UDPv6 ESP decapsulation resolved to an error route. 
   From Yilin Zhu.

2. Fix AH with ESN on async crypto paths by accounting for the extra
   high-order sequence number when reconstructing the temporary
   authentication layout in the completion callbacks.
   From Michael Bomarito.

3. Fix XFRM output so it does not overwrite already-correct inner header
   pointers when a tunnel layer such as VXLAN has already saved them.
   The fix comes with new selftests. From Cosmin Ratiu.

4. Add the missing native payload size entry for XFRM_MSG_MAPPING in the
   compat translation path. From Ruijie Li.

5. Harden __xfrm_state_delete() against repeated or inconsistent unhashing
   of state list nodes by keying the removal on actual list membership and
   using delete-and-init helpers. From Michal Kosiorek.

6. Prevent ESP from decrypting shared splice-backed skb fragments in place
   by marking UDP splice frags as shared and forcing copy-on-write in ESP
   input when needed. From Kuan-Ting Chen.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-05-05

for you to fetch changes up to f4c50a4034e62ab75f1d5cdd191dd5f9c77fdff4:

  xfrm: esp: avoid in-place decrypt on shared skb frags (2026-05-05 06:38:30 +0200)

----------------------------------------------------------------
ipsec-2026-05-05

----------------------------------------------------------------
Cosmin Ratiu (3):
      tools/selftests: Use a sensible timeout value for iperf3 client
      tools/selftests: Add a VXLAN+IPsec traffic test
      xfrm: Don't clobber inner headers when already set

Kuan-Ting Chen (1):
      xfrm: esp: avoid in-place decrypt on shared skb frags

Michael Bommarito (1):
      xfrm: ah: account for ESN high bits in async callbacks

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Ruijie Li (1):
      xfrm: provide message size for XFRM_MSG_MAPPING

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

 net/ipv4/ah4.c                                     |  14 +-
 net/ipv4/esp4.c                                    |   3 +-
 net/ipv4/ip_output.c                               |   2 +
 net/ipv6/ah6.c                                     |  14 +-
 net/ipv6/esp6.c                                    |   3 +-
 net/ipv6/ip6_output.c                              |   2 +
 net/ipv6/xfrm6_protocol.c                          |   4 +-
 net/xfrm/xfrm_output.c                             |  20 +-
 net/xfrm/xfrm_state.c                              |  12 +-
 net/xfrm/xfrm_user.c                               |   1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/config      |   5 +
 .../selftests/drivers/net/hw/ipsec_vxlan.py        | 204 +++++++++++++++++++++
 tools/testing/selftests/drivers/net/lib/py/load.py |   5 +-
 14 files changed, 270 insertions(+), 20 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py

