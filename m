Return-Path: <netdev+bounces-240531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7DC75DE8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75A1734C59A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5F8351FDB;
	Thu, 20 Nov 2025 18:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE95334385
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662381; cv=none; b=jisxNUmBqsGjIpRMgB2/YVyIT7FEWEqlaylIOknvCR4EpnYPX1m/LyX7AICkwC3jPcPf1uk1nhWnDNnyRPfUL6SK9bGVEAXKOTd6hN0SOvfCp1n6TYhfsYCTyBUFwTKWvnCANlWDkIGA8gHqIQtlNtgIOKgCKrgbotrCr8C9WKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662381; c=relaxed/simple;
	bh=Bpb91mLMg9VxI+05UZC/8AXORGa0NShWS5w+jSVLnQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O5hkJjy3ZXVJyLo7OCxZtqhMegRf2Z9Qs0kuFm4Vf5n+7vB5nXlrp1NoJKwZqKZp4utWc92k6LedpraaQNuazVFyrCUC4VrkAVUmZ4haHkzm3aM3zM+ljNoIV/7gp2ESZZ4DohcqEZ+/emeewMHTDkMANHpckCLFwH6chFi9CeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5zT5fmxzHnGdT;
	Fri, 21 Nov 2025 02:12:21 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id F38941402EF;
	Fri, 21 Nov 2025 02:12:56 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 21:12:56 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH v2 net-next 0/3] support for l2macnat in ip-util
Date: Thu, 20 Nov 2025 21:12:45 +0300
Message-ID: <20251120181248.3834304-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Support mode l2macnat in ip-util for link type
ipvlan/ipvtap

Diff from v1:
- Implemented helper functions for ipvlan_mode <-> string
conversions
- Wrote a section in man-page about ipvlan/ipvtap and
extended it with l2macnat mode

Dmitry Skorodumov (3):
  helper funcs for ipvlan_mode <-> string conversion
  Provide man section for IPVLAN and IPVTAP Type Support
  Support l2macnat in ip util

 include/uapi/linux/if_link.h |  1 +
 ip/iplink_ipvlan.c           | 51 ++++++++++++++++++++--------
 man/man8/ip-link.8.in        | 65 ++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.25.1


