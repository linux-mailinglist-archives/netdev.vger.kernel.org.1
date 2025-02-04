Return-Path: <netdev+bounces-162768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416ABA27DEB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C63D3A06BF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E76219A9F;
	Tue,  4 Feb 2025 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfg39twm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0839207DED
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706254; cv=none; b=KOX1vFeLIe5nD0aHFmcTJfyQoFYifzqmqkd0M/RxRn6xUo+Sc83utEH9z8fQaoO2c9DxfTq8NDTDPvHKcsVX3eMhNeuy32zg+XJBLIaROauHglgKmoSlfC8WF/iUUu7A0tDv7KBzm1yQGNPKt8vte/vwQ+oUkD5X1AN4+iir9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706254; c=relaxed/simple;
	bh=7BnOfYYkePdnO2Hl5IqLJFKR843h5CAx5aFvODDVqZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbEbpZHeYrY1yd0qUR297QY66Wq+N7BmFf48ZlN2rhqqg0AztdqKI0e6yhJCli8YrY7dv7NhSRT7212CRAYeelhVdCJ0MyywIMF4LCUnptrMuwwYRnndLdRvGgCO4JJkmRdj65MZpD59EHJPoesDeWNhQUSEHdY0px/mZ7UpYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfg39twm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9555C4CEDF;
	Tue,  4 Feb 2025 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738706253;
	bh=7BnOfYYkePdnO2Hl5IqLJFKR843h5CAx5aFvODDVqZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=Wfg39twmeTe/2nkNh5Lh1R8mN09e5oW48bN5WeMoFSEzlPbpHKzjziKglQbhAc05a
	 BDppcrr4DmXcRQl2uPcw2wXSZUFopIvrFEUuqiJrL6fn+niYjyKZWMU+T/UPxYn3UF
	 y0SVjP8e9IabjKgTXSQywRMSdW6d5gjRdI8jt8xLcoXrAPgy5KQlLL3HPHhI2UipE9
	 zPHd0zKU2ifRtWRAvgzBjxUeSAic8J3+Akodhx0YOvgvFGte2x8TDNWTptmpaEmr4H
	 w3UVUL0qwlyuqQfWZWRNx0HgD9molwaGvt8gk7SsS4tbn5clLr4mo8Bqv3gEnqikfv
	 68XCHacgvlXpQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/2] MAINTAINERS: add entry for ethtool
Date: Tue,  4 Feb 2025 13:57:29 -0800
Message-ID: <20250204215729.168992-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal did an amazing job converting ethtool to Netlink, but never
added an entry to MAINTAINERS for himself. Create a formal entry
so that we can delegate (portions) of this code to folks.

Over the last 3 years majority of the reviews have been done by
Andrew and I. I suppose Michal didn't want to be on the receiving
end of the flood of patches.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74b09dad4662..20c8daf3ce62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16455,6 +16455,16 @@ F:	include/net/dsa.h
 F:	net/dsa/
 F:	tools/testing/selftests/drivers/net/dsa/
 
+NETWORKING [ETHTOOL]
+M:	Andrew Lunn <andrew@lunn.ch>
+M:	Jakub Kicinski <kuba@kernel.org>
+F:	Documentation/netlink/specs/ethtool.yaml
+F:	Documentation/networking/ethtool-netlink.rst
+F:	include/linux/ethtool*
+F:	include/uapi/linux/ethtool*
+F:	net/ethtool/
+F:	tools/testing/selftests/drivers/net/*/ethtool*
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1


