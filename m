Return-Path: <netdev+bounces-276794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLg7BdcT12kSKwgAu9opvQ
	(envelope-from <netdev+bounces-276794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF783C5B20
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14BE5300E2B1
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E736215B;
	Thu,  9 Apr 2026 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iq8fWhmz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MvCZIK0y"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35423AE62;
	Thu,  9 Apr 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702994; cv=none; b=dtEkRYaudX7R8P+aiAvwzSBGjkRWCvxMcDOEVflmNbWQq/4vXiaqrUdmn5OIFvK/GQsIQSPNvTreMx2H8aKur1hmOhedGyogf/t7YEu2bNYvNYcRlVmqRwBMCoIj8TuNE3OYUbUhZ3af7M32S9Awu3jvczvPYLHow2KZKZv+Ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702994; c=relaxed/simple;
	bh=VDpg76iMCzf4+gMtwmFt572TNM9cHILHN8eYLf+KWc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jupg6iY30+hR4h1FFHLeUtFgsgTweA0D50qlGbAAYCx57404jYnM3xY1ZmS0GMoSKMo3PQz//s3Gr8batmVEfz1bsIEenmRK802e8W32cTQVFnI6ASfLR4z1/2A3R3MsiSDlzXgkjuIE6i04nsZylsot9rprUs9lki0+09POm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iq8fWhmz; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MvCZIK0y; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frktP41GVzB14V;
	Thu,  9 Apr 2026 04:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775702989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1kwRhqJY6Ur/GoyreVcZna5Az/OPx7qJRntuWs9ETY=;
	b=iq8fWhmzD4gCQir0nWRweA4iY4pWdtI2cwk4SjUx2wT2Yq7OP9S7YKWtnbAe25ltvybnsJ
	u40Z8gjU7vmx0souqfHjpFUO3/twNhLdcivAsaiavWJnEv69BsJPpnH2GVWUkFBT7L6toR
	itkiLOqNHimlKhG1072XuQk6J6hkxLySdcMNMiRm36y6Ryv8wHR8EXxbkLqRyAyo/xsvid
	yGVJb0rfOT7HMZWB3hCu0WUH+pUUjw++Qn/QYB0yI7gNp0iVmE3ey8Ej+pWez2ldlXsMHm
	6E1pJ8UsC7OF+fiMxldt6n7KOEW6P7H82tk1uYpZWCrsCd1lWqCilFgtY5Iu3A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MvCZIK0y;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775702988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1kwRhqJY6Ur/GoyreVcZna5Az/OPx7qJRntuWs9ETY=;
	b=MvCZIK0ymvWQN5Q0zpUSZ2cKOQGtfJ2pi/J2UVfBTcc/S9BZT8U21SxwN+lEQL4Xr7yP31
	kfjUTdbAT4ZrWN3kTUAmNHo2kXfy5ZxlO+ctQMPkhByNTgX98PUCqgYHjaC/7kWGhboh5A
	aLcfzwGzYcYdeVe44cbYhlV3bJScZwykFauAAnpBJC1Hefb9rFnpQmPffwh3HzSLknV+p0
	Vst+kqg+ckUglfzpUBmATqb+Aoj842ReIc5XiomI+o8nIZlrmzLNnMk8brVsbVehBMwqQZ
	eM+bMdJj41VXTTJBvVRiLMfLkl+Q38IsrWHLRgrN/CB9zMQzaIGzXLdY8FgXeg==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH v2 net 0/2] net: hamradio: fix missing input validation in bpqether and scc
Date: Thu,  9 Apr 2026 10:49:25 +0800
Message-ID: <20260409024927.24397-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uodpcbght8arxobjmodwb7iisesdkh9e
X-MBO-RS-ID: 8b14f452c988ab37bc4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276794-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Queue-Id: AEF783C5B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two missing input validation bugs in the hamradio
drivers. Both patches were reviewed by Joerg Reuter (hamradio
maintainer).

v2 changes:
- bpqether: no code change; add Acked-by: Joerg Reuter
- scc: drop the upper bound of 4096 per reviewer feedback;
  only enforce the minimum of 16

Mashiro Chen (2):
  net: hamradio: bpqether: validate frame length in bpq_rcv()
  net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl

 drivers/net/hamradio/bpqether.c | 3 +++
 drivers/net/hamradio/scc.c      | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.53.0


