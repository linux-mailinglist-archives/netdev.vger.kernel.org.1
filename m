Return-Path: <netdev+bounces-211126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83932B16BA9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 07:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B114E84CC
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 05:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4C198E81;
	Thu, 31 Jul 2025 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="lelaJpMI"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F311D63DD
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940736; cv=none; b=HjTD6K/VxdBQPZpV1ldDcbd+7jM/bSCv05spatw4/boUUjfLMHBvC5n2S/W29F40Vu18qY3fduhvMMS4sWXgQ2hq8cAuH1wE1DSc/hvaybfv6yQtDJrlCMrglP+HBXJT29X2hxCVRjk3R/a1HDFFo0dWCqdDnQY0fGcEchlRv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940736; c=relaxed/simple;
	bh=WgocSOUoxr1xtN/4x0z6AOnsdRZFvVxZpjZDb7Kw970=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=cg+zUPZtQueO9n5berNBeoTBgG9/gEy32JiyMUHHkhoFjGTxnX7d+VrN9eEIwI4NPMrqsXQ2WuYy/QorXrJMjJsOqQV+1qURisiJM0v2lcjMhceYbovjLIQJJNW+5C3EmLdsZRRU0uc0Dz89bRfre8s8LL5MzYcwbnDEVEiAyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=lelaJpMI; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 56V5ZvYB025982
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 06:35:59 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 56V5ZvYB025982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1753940160; bh=4t3YDexOIbx5+U9nHkTOd9N9pvBxEfdlQity+Ts6+E0=;
	h=From:Subject:Date:To:From;
	b=lelaJpMIPbVoAPOgfQnKpOpZAbEhII/7m3p4w+XzgEoerNo+DtgpUAEZujhYgz/IC
	 m1+9U3O5WjRyDZpWkEWiTfCicxL6ycPh5u3z7pQ2bkisklQttgXoSxqdQ9fBPpeDe0
	 iMzoNDZ1afGi7wIU7IwSHlQvyFJ8nGLN9tk37Vdf/qMorJS935pFotQKcds6QQjMKH
	 HNGW/ACyc70eu5qmg3xN2lKJpP63sKnlennxn5S5Mlc3ZiGl8ktdpr1WwECq312ZMl
	 gq3ThRYoJHWau1PAd/hs9WXe85qZgahdxmNUgJYrUmsQtHiVzTuBPTzYArS4/vnY+n
	 hxyukQ1GEqnJg==
From: Luke Howard <lukeh@padl.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [PATCH net] net: dsa: validate source trunk against lags_len
Message-Id: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
Date: Thu, 31 Jul 2025 15:35:34 +1000
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

A DSA frame with an invalid source trunk ID could cause an out-of-bounds =
read
access of dst->lags.

This patch adds a check to dsa_lag_by_id() to validate the LAG ID is not =
zero,
and is less than or equal to dst->lags_len. (The LAG ID is derived by =
adding
one to the source trunk ID.)

Note: this is in the fast path for any frames within a trunk.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 include/net/dsa.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 2e148823c366c..67672c5ff22e5 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -180,6 +180,9 @@ struct dsa_switch_tree {
 static inline struct dsa_lag *dsa_lag_by_id(struct dsa_switch_tree =
*dst,
 					    unsigned int id)
 {
+	if (unlikely(id =3D=3D 0 || id > dst->lags_len))
+		return NULL;
+
 	/* DSA LAG IDs are one-based, dst->lags is zero-based */
 	return dst->lags[id - 1];
 }
--=20
2.43.0=

