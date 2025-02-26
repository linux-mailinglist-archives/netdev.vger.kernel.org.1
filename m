Return-Path: <netdev+bounces-170026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81818A46EA1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625E316BACB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6041E1DEC;
	Wed, 26 Feb 2025 22:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD225D8EA
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609206; cv=none; b=QaFw+64KFqZOgEMiTiJVeW0eoy7PZExsgCxFcuDVZB8PnL2EJxEeaysx7MMv1LxbvO6R90Gi/cr4U1RI8ANNws/v+siwjGQyqNgaYEx9pjRLFMjhWy9HM9EXnwZjqzg0AlR7CJtchPNjvG1HZh7mgXUQhvIaeH618JLSUl+Gtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609206; c=relaxed/simple;
	bh=INQPxkyTWE0Nu+i4dRTJknUgW7BYJfSPmWxAgpWNkfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mTan9nmGpI+4T0aDp+zslSYLPPANdgeX9Ad7/DIyHCHh1/HwopXIu/xziXr2f0GeVI0ucG1H1a+G0WS57xk6X9gDodROEJU63TTbnm27UF2R8FdcSc+jVhkzjnyLsUaYm/Nb/7B5XdlIIed5mYZaCL5xxRFpoPFcvtjmEJVjIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com; spf=none smtp.mailfrom=hungry.com; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hungry.com
Received: from [2a02:fe1:180:7c00:3cca:aff:fe28:58e0] (helo=hjemme.reinholdtsen.name)
	by vuizook.err.no with smtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <pere@hungry.com>)
	id 1tnPSW-00CQsF-1e;
	Wed, 26 Feb 2025 22:00:56 +0000
Received: (nullmailer pid 79194 invoked by uid 10001);
	Wed, 26 Feb 2025 22:00:45 -0000
From: Petter Reinholdtsen <pere@hungry.com>
To: netdev@vger.kernel.org
Cc: Salvatore Bonaccorso <carnil@debian.org>, Ben Hutchings <benh@debian.org>
Subject: [PATCH ethtool] Add AppStream metainfo XML with modalias documented
 supported
In-Reply-To: <Z7hoqCjls4wD88_S@eldamar.lan>
References: <sa6ikx0igr9.fsf@hjemme.reinholdtsen.name>
 <Z5R2sK8ehCUGxm35@hjemme.reinholdtsen.name>
 <sa6ikx0igr9.fsf@hjemme.reinholdtsen.name>
 <Z7hizPKGcnF3fBcW@hjemme.reinholdtsen.name> <Z7hoqCjls4wD88_S@eldamar.lan>
Date: Wed, 26 Feb 2025 23:00:45 +0100
Message-ID: <sa67c5cl62a.fsf@hjemme.reinholdtsen.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I am not used to submitting patches like this, and hope I do not make
too many mistakes.  Please forgive me if I did.  This patch was
initially submitted to Debian as <URL: https://bugs.debian.org/1076629 >.

Here is the 'git format-patch' for it.

From 81e64589dd2ebdc194c8198165aa093361682e89 Mon Sep 17 00:00:00 2001
From: Petter Reinholdtsen <pere@debian.org>
Date: Wed, 26 Feb 2025 22:36:03 +0100
Subject: [PATCH] Add AppStream metainfo XML with modalias documented supported
 hardware.

This ensure all Linux distributions supporting AppStream share
AppStream information for ethtool.

Hardware mappings allow AppStream clients like isenkram to propose
this package when supported hardware (ethernet card) is present.

Appstream is documented on
<URL: https://www.freedesktop.org/wiki/Distributions/AppStream/ >.
---
 Makefile.am                                      |  6 +++++-
 org.kernel.software.network.ethtool.metainfo.xml | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 org.kernel.software.network.ethtool.metainfo.xml

diff --git a/Makefile.am b/Makefile.am
index 862886b..8d50ef6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,7 +3,11 @@ AM_CPPFLAGS = -I$(top_srcdir)/uapi
 LDADD = -lm
 
 man_MANS = ethtool.8
-EXTRA_DIST = LICENSE ethtool.8 ethtool.spec.in aclocal.m4 ChangeLog autogen.sh
+EXTRA_DIST = LICENSE ethtool.8 ethtool.spec.in aclocal.m4 ChangeLog autogen.sh \
+             org.kernel.software.network.ethtool.metainfo.xml
+
+dist_metainfo_DATA = org.kernel.software.network.ethtool.metainfo.xml
+metainfodir = $(datarootdir)/metainfo
 
 sbin_PROGRAMS = ethtool
 ethtool_SOURCES = ethtool.c uapi/linux/const.h uapi/linux/ethtool.h internal.h \
diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
new file mode 100644
index 0000000..efe84c1
--- /dev/null
+++ b/org.kernel.software.network.ethtool.metainfo.xml
@@ -0,0 +1,16 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<component type="desktop">
+  <id>org.kernel.software.network.ethtool</id>
+  <metadata_license>MIT</metadata_license>
+  <name>ethtool</name>
+  <summary>display or change Ethernet device settings</summary>
+  <description>
+    <p>ethtool can be used to query and change settings such as speed,
+    auto- negotiation and checksum offload on many network devices,
+    especially Ethernet devices.</p>
+  </description>
+  <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
+  <provides>
+    <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
+  </provides>
+</component>
-- 
2.39.5

-- 
Happy hacking
Petter Reinholdtsen

