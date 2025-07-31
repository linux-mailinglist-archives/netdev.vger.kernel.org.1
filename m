Return-Path: <netdev+bounces-211152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D0B16F0B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217165808AE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BB29CB52;
	Thu, 31 Jul 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="KivCzI3h"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8141F4616
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955816; cv=none; b=f0hKuFMiwfNqmP6O+BRA/l1JdlnuMGtyGp3YORL7HTx7gl283rFZEAXdOKNlC2m5dxqs2ZunNve0UuiB7vhbeJTeGNQhjXsKwcwQinHrvm7pSc8+JPM44vybefBiktpmrO598DQLzPpwJ3eco8pbtZ+9GfCAuiV1hMImvz+6m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955816; c=relaxed/simple;
	bh=Xx+7N6ZGxnOZKi6EUHjFH1Rsc0T5iD9FG44iGz1zapE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TJ1oMCgncdmpi37z0VZd1RqJveZOyEAVHbi7mqgME7c1q9BmzMFBTs+vp0ZSd2sFwXeG7aYHx6wlFUaQmMIRvBibsI5vjkQcl/X0Ge9/BIhQzqmHD4dVsihMAD0Xds3WatRoaS6fUeYODjkN1QVI1AmRPqci/7fT3UzjcGvtk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=KivCzI3h; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 56V9ulgg026031
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 31 Jul 2025 10:56:49 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 56V9ulgg026031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1753955811; bh=jI+fQs/bIW2fc4cjv/gC4mIKEgJN+ESm+YVbUdRttl4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=KivCzI3h7hurPDfVjYa1pMhqJo1FilqOrp+87/JYcFdA5IVBAringsBdeGuLfROfP
	 cJWAdk1QFCyCtAxrhyOhLzOce9C8HAwQjmyOdkYqd8X82Kb4AcBraFYxRnE1npZTBs
	 a1E9tzA71WWuMH3UWmoFOKM72jztog7ALD41glJNxtzOvbtYvE2RRHsd+6IOc2MTT/
	 q5PfanhlALPN4c3JsuihgX/Tmdpv2xNKmKN7DC1gTQfyBMoZCX0TeGrn5qwT8p+ugs
	 7tZO+6ZcE9ufJSDaQwh/VQNLZyfPPS5ueBU1lonQsiCqYoRpiSEHDSwE8DbgThXzFt
	 3udLYiRmG2izw==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2 net-next] net: dsa: validate source trunk against
 lags_len
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
Date: Thu, 31 Jul 2025 19:56:37 +1000
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Ryan Wilkins <Ryan.Wilkins@telosalliance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E37B372-015B-4B19-92E9-7212C33D59C5@padl.com>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

A DSA frame with an invalid source trunk ID could cause an out-of-bounds
read access of dst->lags.

Add a check to dsa_lag_by_id() to validate the LAG ID is not zero, and =
is
less than or equal to dst->lags_len. (The LAG ID is derived by adding =
one
to the source trunk ID.)

Note: this is in the fast path for any frames within a trunk.

Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets =
from LAG devices")
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

