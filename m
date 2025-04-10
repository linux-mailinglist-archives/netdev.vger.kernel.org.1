Return-Path: <netdev+bounces-180993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE584A835EB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2753BF69C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77DA1D63C0;
	Thu, 10 Apr 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOkxLR8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9433E1D5CE8
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249634; cv=none; b=SAgz5y14H/CrgvF2ds8KLRD0KaqHgs2NRgu6qqS4k7R+HMJQ9z/P2M7bjwFw3h5u9Oz3Kv7vTjWXrmfWUj38xJUpbUicDFj+cv6BHC5x+YU+NkODx17Ko1m09ALgT/k7IcJ+KDW/Uk2BUYqqYJgyjcqefnKEoCtxNcU2vEH0nTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249634; c=relaxed/simple;
	bh=jyhW6I8pxQle4ryZrwzr4wZ7MnNHbuWM49gFnl9Ot2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8A3BXjZ6F0V/Nxqi4qwow7TVDgvDtwvo8Q5kTtzjexvmN7SnsjkqznWd2gOxlEHMwuteLOOSfTQeZcXCk317bfmWCtQPLIqI+shRSzs2dGFV3Yvg7dfAUntkmecUM/Un8tknmfAorI0ecHAtDzoHX5Us1NvEYL0Nebgsyl2DUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOkxLR8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06B0C4CEE9;
	Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249634;
	bh=jyhW6I8pxQle4ryZrwzr4wZ7MnNHbuWM49gFnl9Ot2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOkxLR8TJgwYHUFgY0Vu5HaAqpIQauGyaq/qmll+3Vc7vO+Hx5G3caE/uSisfsEHl
	 DwgTY6W0+eq061GTrMPy2frI2jg1HfLHNsi/nF8eXgfJqNUylwRh4hs+4zPtnQkcAT
	 6aXTOTxHOzwhur6LYHZ+mhbB0XK/p6cXife1a/su2bfCxNabh3IliCmuJ3ROAU/fTn
	 WpgXzwY6BlLCtn5/o2Dc0qCMi+dVmHbuKjrezpW4B/cf8NCAPvOi37/BNh7h652Yg+
	 3O3ATnkJm5fFBzzm9ynuD8H69kmXDET8vNn9dKaB+7TbmegRLa8Mt8kgQ7iqvVbydL
	 7GtGb/ZE0Tz2Q==
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
Subject: [PATCH net-next v2 06/13] netlink: specs: rt-route: add C naming info
Date: Wed,  9 Apr 2025 18:46:51 -0700
Message-ID: <20250410014658.782120-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties needed for C codegen to match names with uAPI headers.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-route.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index c7c6f776ab2f..800f3a823d47 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -2,6 +2,7 @@
 
 name: rt-route
 protocol: netlink-raw
+uapi-header: linux/rtnetlink.h
 protonum: 0
 
 doc:
@@ -11,6 +12,7 @@ protonum: 0
   -
     name: rtm-type
     name-prefix: rtn-
+    enum-name:
     type: enum
     entries:
       - unspec
@@ -246,6 +248,7 @@ protonum: 0
 operations:
   enum-model: directional
   fixed-header: rtmsg
+  name-prefix: rtm-
   list:
     -
       name: getroute
-- 
2.49.0


