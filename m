Return-Path: <netdev+bounces-58129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38681536A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4D1C20E54
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D613B133;
	Fri, 15 Dec 2023 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="gwrOo4wk"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC118EA1
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fVZJG3mhEagSsqlxRK9k0gXkHmgnke/9jn5Rm/kh4vw=; b=gwrOo4wk0Y/dWGx7Ao2ueGpZVG
	8mXVxkO5qRJuo5ZjvqH02qEKaiyF9pv1dUFC7VNzaJIm3ipAeVj7F3pwo8T9WtPkWMvtL78s65fgY
	4EAq82qQlLAYsUt7Bu5e0jxvuSVLAPHxOYe0PDxCAuNOyENVkTDc0+4NE1MEZMgZ+P9lGLKPK/jn0
	X8TnVGxDer++j2iINluAKBAAtvRkvyNP4Ue3C3mD+clppEEE0C+cNJny+kH4S+wn2uWWYd26tvrrJ
	QcZSsQdL3UzW2ane7ZjS0MgGS+Zq8GsGv4fIlKzu8rT5dErUTrQuZL2gIyBZN4HdlG76vu0weoRO6
	GoE7mi8w==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1rEGWk-0001nP-Qr; Fri, 15 Dec 2023 23:19:26 +0100
From: Phil Sutter <phil@nwl.cc>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Gioele Barabucci <gioele@svario.it>,
	netdev@vger.kernel.org
Subject: [iproute2 PATCH 2/2] man: Fix malformatted database file locations
Date: Fri, 15 Dec 2023 23:19:23 +0100
Message-ID: <20231215221923.24582-2-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221923.24582-1-phil@nwl.cc>
References: <20231215221923.24582-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .BR macro does not put spaces in between its arguments. Also it will
apply to all arguments.

Fixes: 0a0a8f12fa1b0 ("Read configuration files from /etc and /usr")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 man/man8/ip-address.8.in |  4 ++--
 man/man8/ip-link.8.in    |  7 +++----
 man/man8/ip-route.8.in   | 36 ++++++++++++++++++------------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index b9a476a5fc7f8..c35509fe5c4ed 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -209,8 +209,8 @@ The maximum allowed total length of label is 15 characters.
 .BI scope " SCOPE_VALUE"
 the scope of the area where this address is valid.
 The available scopes are listed in
-.BR "@SYSCONF_USR_DIR@/rt_scopes" or
-.BR "@SYSCONF_ETC_DIR@/rt_scopes" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_scopes " or " @SYSCONF_ETC_DIR@/rt_scopes
+(has precedence if exists).
 Predefined scope values are:
 
 .in +8
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e82b2dbb00706..97f75cca09bfd 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2261,8 +2261,8 @@ give the device a symbolic name for easy reference.
 .BI group " GROUP"
 specify the group the device belongs to.
 The available groups are listed in
-.BR "@SYSCONF_USR_DIR@/group" or
-.BR "@SYSCONF_ETC_DIR@/group" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/group " or " @SYSCONF_ETC_DIR@/group
+(has precedence if exists).
 
 .TP
 .BI vf " NUM"
@@ -2872,8 +2872,7 @@ specifies which help of link type to display.
 .SS
 .I GROUP
 may be a number or a string from
-.B @SYSCONF_USR_DIR@/group or
-.B @SYSCONF_ETC_DIR@/group
+.BR @SYSCONF_USR_DIR@/group " or " @SYSCONF_ETC_DIR@/group
 which can be manually filled and has precedence if exists.
 
 .SH "EXAMPLES"
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index f9ed4918cd1e8..10387bca66ff3 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -357,8 +357,8 @@ normal routing tables.
 .B Route tables:
 Linux-2.x can pack routes into several routing tables identified
 by a number in the range from 1 to 2^32-1 or by name from
-.B @SYSCONF_USR_DIR@/rt_tables or
-.B @SYSCONF_ETC_DIR@/rt_tables (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables
+(has precedence if exists).
 By default all normal routes are inserted into the
 .B main
 table (ID 254) and the kernel only uses this table when calculating routes.
@@ -421,8 +421,8 @@ may still match a route with a zero TOS.
 .I TOS
 is either an 8 bit hexadecimal number or an identifier
 from
-.BR "@SYSCONF_USR_DIR@/rt_dsfield" or
-.BR "@SYSCONF_ETC_DIR@/rt_dsfield" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_dsfield " or " @SYSCONF_ETC_DIR@/rt_dsfield
+(has precedence if exists).
 
 .TP
 .BI metric " NUMBER"
@@ -437,8 +437,8 @@ is an arbitrary 32bit number, where routes with lower values are preferred.
 the table to add this route to.
 .I TABLEID
 may be a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_tables" or
-.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables
+(has precedence if exists).
 If this parameter is omitted,
 .B ip
 assumes the
@@ -479,8 +479,8 @@ covered by the route prefix.
 the realm to which this route is assigned.
 .I REALMID
 may be a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_realms" or
-.BR "@SYSCONF_ETC_DIR@/rt_realms" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_realms " or " @SYSCONF_ETC_DIR@/rt_realms
+(has precedence if exists).
 
 .TP
 .BI mtu " MTU"
@@ -631,8 +631,8 @@ command.
 the scope of the destinations covered by the route prefix.
 .I SCOPE_VAL
 may be a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_scopes" or
-.BR "@SYSCONF_ETC_DIR@/rt_scopes" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_scopes " or " @SYSCONF_ETC_DIR@/rt_scopes
+(has precedence if exists).
 If this parameter is omitted,
 .B ip
 assumes scope
@@ -652,8 +652,8 @@ routes.
 the routing protocol identifier of this route.
 .I RTPROTO
 may be a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_protos" or
-.BR "@SYSCONF_ETC_DIR@/rt_protos" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_protos " or " @SYSCONF_ETC_DIR@/rt_protos
+(has precedence if exists).
 If the routing protocol ID is not given,
 .B ip assumes protocol
 .B boot
@@ -892,8 +892,8 @@ matching packets are dropped.
 specified lookup table.
 .I TABLEID
 is either a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_tables" or
-.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables
+(has precedence if exists).
 If
 .B vrftable
 is used, the argument must be a VRF device associated with
@@ -909,8 +909,8 @@ and an inner IPv6 packet. Other matching packets are dropped.
 specified lookup table.
 .I TABLEID
 is either a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_tables" or
-.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables
+(has precedence if exists).
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
@@ -923,8 +923,8 @@ at all, and an inner IPv4 packet. Other matching packets are dropped.
 to the specified lookup table.
 .I TABLEID
 is either a number or a string from
-.BR "@SYSCONF_USR_DIR@/rt_tables" or
-.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables
+(has precedence if exists).
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
-- 
2.43.0


