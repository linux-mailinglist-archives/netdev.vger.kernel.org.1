Return-Path: <netdev+bounces-180526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA7A81999
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782514C6D4E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F71EEF9;
	Wed,  9 Apr 2025 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlhB4KOM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80051CF96
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157065; cv=none; b=QBHEQisWpzNCHNLGlP0a7jI5bWGbFnp6awQCayeAwqQcPPt+vESmsGvapGci+mmH5158Lvr0MB6e0W3oksY6N/cLMxeoM5Kz+2gKQpER1xueiHPwBDPa8OCEpuqFvDzUnwVrhz+WudO3vSbE81QLet5MboG+kkbpB9KFsjAuBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157065; c=relaxed/simple;
	bh=UdGeeRqCWl5uieOfgGtgmU7tvXzIzwoeQ+rDu0Q/AGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJFjHlesgAztAnu1WZMcSx/4A3FUmLGOoEsn3jm8DqCj8bFykoCLXDGtpoBswlSBpbae25XZmUqzQNQZo0ArxLxAQL2p2wcGJzkAWIZoIDYJDKc8Sq5yMlPgSD7AcG7NPEZ5WkH3sDutKTUDdxtReq2A659eyCLgK360FXHS6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlhB4KOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F47C4CEE9;
	Wed,  9 Apr 2025 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157065;
	bh=UdGeeRqCWl5uieOfgGtgmU7tvXzIzwoeQ+rDu0Q/AGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlhB4KOMzL6dF5Lr4hF7RaOMxgqcvDiuXkzFwGmG8WNWsdWCLWHNjKitwArHBKYNb
	 wHl8XK8CV6y/AKn53fvdXg8FYWVJSMl4WP//DtzcYsTJ4rN7c1ddfYuAL1O7UvOCBj
	 M7CJeFpBAqX1U0A4tMwrO0n4EfCdl5ZhhMAow0HNUOJ3nUfYHp71rCQmKdlkABNn09
	 Abu9e5kC2kFrd4HsHP08Lo6qY0Lpzk6df/RlYjoqmcIc7pRuKN7/g8GYgQCIMqph/R
	 nZm2cydUchUE8/bM6B7LceN713Cxq4KfOKfbnEyREWxuYeTdgpo77vUEka/rmrd7jI
	 SgqR+Rlwyqsgg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/13] netlink: specs: rt-addr: add C naming info
Date: Tue,  8 Apr 2025 17:03:52 -0700
Message-ID: <20250409000400.492371-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties needed for C codegen to match names with uAPI headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-addr.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0488ce87506c..4f86aa1075da 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -2,6 +2,7 @@
 
 name: rt-addr
 protocol: netlink-raw
+uapi-header: linux/rtnetlink.h
 protonum: 0
 
 doc:
@@ -49,6 +50,8 @@ protonum: 0
   -
     name: ifa-flags
     type: flags
+    name-prefix: ifa-f-
+    enum-name:
     entries:
       -
         name: secondary
@@ -124,6 +127,7 @@ protonum: 0
 operations:
   fixed-header: ifaddrmsg
   enum-model: directional
+  name-prefix: rtm-
   list:
     -
       name: newaddr
-- 
2.49.0


