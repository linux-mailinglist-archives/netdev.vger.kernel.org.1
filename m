Return-Path: <netdev+bounces-284403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCA4DA/w+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5434CE744
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 240CB30763FD
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC14611C9;
	Tue,  5 May 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Prs0G02Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267C365A00
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987423; cv=none; b=jfWqoQ/xPYxmjpRkbuW89fjWQ+WNuC8P/tjPPsvYCLfE/YaACcOOX0C4Uo1cysP5vpmEwwi0NCvwcDfuceZcki/we1oY5Vfhx7SAp5imJt714F3J/BzZiXn9Cwscwaa/dZ8GRlmBUWV1SBD2TqKBgQZdolzQI4i34tQlWRQkBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987423; c=relaxed/simple;
	bh=/kG1wx4qaj9dQAoeOb3tDMjSaARJs7inl5FGmRBAUHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9q3sOWvg4R3x0mZkHJjXxH61URMzaXJp/ER91cWl5JJDNk8KqEj3HNEWXj1UUY6TV7fpEdRKOvMOTz30di8EKWSlzDNh2i6ali1DujHJWBYiDGqNaDAv9U1/RVzIEhWNjlax1yYmSmBVeRYf9Xcd5UpRpLY9ePVOfnIbMvzPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Prs0G02Z; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C6CCD20719;
	Tue,  5 May 2026 15:23:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RJgpJu4bzkq; Tue,  5 May 2026 15:23:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 374EA206E9;
	Tue,  5 May 2026 15:23:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 374EA206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987418;
	bh=Xy8vcaLDljUIhQuGTbA7rFeE0c7S6dzGExrE4Z+RrkI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Prs0G02ZD8yLYz0oHyKPo4i7d3cYPGUUKDgR7w1LDrkBnG5Qcgvm/db2sMv592UKX
	 yB21KiJCNVTVUJT/TOLnTbMRoA8T8YWFFLi8zm3JyzczBOWuUgx1AUTGHmEiPYN0P9
	 Kxh+CKcIveWkim4V4k5f4ZdsBC9U9SAwFz2Tl2UIfjAmTLdVheARGCqf/o1eHv/858
	 0sFi3QDdYTFFs/hTnLGyd679iAXwprAx230swl/Wgxs5KHFzcURlwPFJRfLJTqYqNn
	 NDDGu0pA1xXvoW6QCLv80i1c8E7svLxLW9ZiWApScH+b6weoeirf6soSB5V0bAw/5l
	 KyaYr/+P/xNHQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:37 +0200
Received: (nullmailer pid 1364086 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/8] tools/selftests: Use a sensible timeout value for iperf3 client
Date: Tue, 5 May 2026 15:22:59 +0200
Message-ID: <20260505132326.1362733-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: BB5434CE744
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
	TAGGED_FROM(0.00)[bounces-284403-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Cosmin Ratiu <cratiu@nvidia.com>

The default timeout of cmd() is 5 seconds and Iperf3Runner requests the
iperf3 client to run for 10 seconds, which clearly doesn't work since
commit [1] enforced the timeout parameter.

Use a value derived from duration as timeout (+5 seconds for
startup/teardown/various other overhead).

[1] commit f0bd19316663 ("selftests: net: fix timeout passed as positional argument to communicate()")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 tools/testing/selftests/drivers/net/lib/py/load.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index f181fa2d38fc..e24660e5c27f 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -48,7 +48,10 @@ class Iperf3Runner:
         Starts the iperf3 client with the configured options.
         """
         cmdline = self._build_client(streams, duration, reverse)
-        return cmd(cmdline, background=background, host=self.env.remote)
+        kwargs = {"background": background, "host": self.env.remote}
+        if not background:
+            kwargs["timeout"] = duration + 5
+        return cmd(cmdline, **kwargs)
 
     def measure_bandwidth(self, reverse=False):
         """
-- 
2.43.0


