Return-Path: <netdev+bounces-118024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220659504E2
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DAE282D0F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F9199398;
	Tue, 13 Aug 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="V/vvzXAl"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9368198A05;
	Tue, 13 Aug 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552058; cv=none; b=GBqZgx0IIo4EUieADfTzxTdj9uluvb8kXn7wSPynRx/QtnrBNeyWqWK4dDlxxbkBTkIwrUpIGbzkUxf+pRROgne3ioG4mf54xBypTezlNVUZHF6lh2srxA2Ty0kI3BxlfQaoalptcJetCDbyoRlzCZXKre9g0Vsi+2ah/XCwh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552058; c=relaxed/simple;
	bh=NS/g7JFl72rIt+Uynkoo4KCMSSt2k4x/CrfyJd+NLMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0EOSlVUBSd2OF4+IjOdCK8025Cwx7XlbDcqUN5ZxpOlit4239XmVVHIa0uZbp0YogIbhqyaFuosn2026DDFd+FpEr1vBcU9zBslWKBjhCQwJN5GyZmFb28NE1fYO1/78uEFR9sXJD/UAbIpCBBxAUseekwuqS78a/y/1xUXVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=V/vvzXAl; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id DE742200BBB9;
	Tue, 13 Aug 2024 14:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be DE742200BBB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723552054;
	bh=e44Fi0OsB/eZ0+qDnLUdXSGggpNzWesi5/5qUfCAHwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=V/vvzXAlgAov3GkpgAoJhfYJKQE6/V5B97mKDGcOcs8iMmjhiTBNMAS6z0fEWyZgo
	 lel4QFyXeNxQoblJQwzAIRGygbFPwqvh1nnPMgwwQhbnTh1VXhH+azQEBEz2Vvzjy5
	 EqWPThjcph3wHWG6fDGBiUZWV6oh3If/8EUfDYQyu5Tacf7V0pv9BWLFoUf5VL4O2G
	 y8xpe5HYO60wRGU5td0FmCz39Z1fnUWPMZ+7qkTqBAP9zHZRMXetMukVQHdTf9cGDP
	 wYIDkff6/pJWxtWHw3XRLynNpTL4Y41d3w/4x5WJ/cT/A0v/WJx69liIitmRzt/dl2
	 dDzFp0/YiRvCg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 0/2] net: ipv6: ioam6: introduce tunsrc
Date: Tue, 13 Aug 2024 14:27:21 +0200
Message-Id: <20240813122723.22169-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new feature called "tunsrc" (just like seg6
already does).

v2:
- add links to performance result figures (see patch#2 description)
- move the ipv6_addr_any() check out of the datapath

Justin Iurman (2):
  net: ipv6: ioam6: code alignment
  net: ipv6: ioam6: new feature tunsrc

 include/uapi/linux/ioam6_iptunnel.h |  7 +++
 net/ipv6/ioam6_iptunnel.c           | 66 +++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.34.1


