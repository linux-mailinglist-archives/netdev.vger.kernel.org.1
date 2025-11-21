Return-Path: <netdev+bounces-240801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B657C7AAAD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4192D3A2D5B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1311345CB9;
	Fri, 21 Nov 2025 15:52:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0D2D8DAF
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740351; cv=none; b=e6OuZhyJSBj6A7iOFqqXel7dVk08cHeSJNqB8ogDx7/l2ZiHFKPGdM+juhQbVuliBpv9D33SM0vPTKB4zDN5ZWQnXh2Ogvs+V0iKgzBSMB84ZKZpcwYPs2jlPQjaecWoFlr4+IBX/9ieqTf7WD1Bw+3OLRX3ZoDKaGhDLt3cjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740351; c=relaxed/simple;
	bh=XAIzzq5CH6ekUYxWllJxId69/g85pr4OPF4n7cx5WQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7OAgk0foW8kcqcMTT2efLSJl2uKx0E8xH6izrjf1zjchky/9f0IcWZcY5XPs8KbkIwnU3mmELnxytvPTm6i/fUuIc0Gy0UQyBEJSefarX4WuLDfcvmNpg6olK5eZtKV9B6H4DdpcDS1AuPrEDghbAFn1jupF/FqReWjSbGOCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dCfpd03n4zJ467Z;
	Fri, 21 Nov 2025 23:51:37 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 568591402FF;
	Fri, 21 Nov 2025 23:52:24 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 18:52:23 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH v3 iproute2-next 0/3] support for l2macnat in ip-util
Date: Fri, 21 Nov 2025 18:52:09 +0300
Message-ID: <20251121155212.4182474-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Support mode l2macnat in ip-util for link type
ipvlan/ipvtap

Diff from v2:
- Fixed wrong patches tag. Should be iproute2-next.

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


