Return-Path: <netdev+bounces-181869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A6A86AD4
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 06:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D1E1B84891
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 04:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7316DECB;
	Sat, 12 Apr 2025 04:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788F14658D
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744432025; cv=none; b=Vxx69rVgY89wWwZQ8Eb0TIvozNiyuwsXp0igeppTbzTijMVyJ/eNzrDoOPXohZduyeAktyCsWhttxjHpNJ3Nf8+SDUwM1vk4oJoxduXbrQ1toWZHBnX5c5CrB+QHdqYgLdCVcfOsF3kmZcRxCdLETWtiKG1HgsHbqFV6CNtAAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744432025; c=relaxed/simple;
	bh=C6cdviC61aa2UF4fNMReo3jePrr0+Qc5WWEzMrK5tNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E82jqguNAeVnIRYhQBAgW5SFEWb3rojTeUnmXtgdzUhmB+mcrFVOM62471zBjKe9Uwwx4uF89/4eml8w4PDEfLoRm420k/kGsNfoiFpri1/vyIhWq1h4S5VlXu/hA7Tvz57RDyMoqyzYk1KzfkgqkztcE3faaWaS/HdPlYnoJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com; spf=none smtp.mailfrom=hungry.com; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hungry.com
Received: from [2a02:fe1:180:7c00:3cca:aff:fe28:58e0] (helo=hjemme.reinholdtsen.name)
	by vuizook.err.no with smtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <pere@hungry.com>)
	id 1u3SSC-00DSc9-2D;
	Sat, 12 Apr 2025 04:26:57 +0000
Received: (nullmailer pid 2139554 invoked by uid 10001);
	Sat, 12 Apr 2025 04:26:46 -0000
From: Petter Reinholdtsen <pere@hungry.com>
To: netdev@vger.kernel.org
Cc: Daniel Rusek <asciiwolf@seznam.cz>, Salvatore Bonaccorso <carnil@debian.org>, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH ethtool] Set type property to console-application for
 provided AppStream metainfo XML
In-Reply-To: <Z_mKHHSNscT09VwJ@eldamar.lan>
References: <20250411141023.14356-2-carnil@debian.org>
 <Z_mKHHSNscT09VwJ@eldamar.lan>
Date: Sat, 12 Apr 2025 06:26:46 +0200
Message-ID: <sa65xjaromx.fsf@hjemme.reinholdtsen.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


You are definitely on the right track, but the proposal from Daniel is
to include a binary provides too to fill a field wanted for
console-application components, ie:

diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
index efe84c1..7cfacf2 100644
--- a/org.kernel.software.network.ethtool.metainfo.xml
+++ b/org.kernel.software.network.ethtool.metainfo.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<component type="desktop">
+<component type="console-application">
   <id>org.kernel.software.network.ethtool</id>
   <metadata_license>MIT</metadata_license>
   <name>ethtool</name>
@@ -11,6 +11,7 @@
   </description>
   <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
   <provides>
+    <binary>ethtool</binary>
     <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
   </provides>
 </component>

This look like a great proposal to me, and I have already tested the
change using 'appstreamcli validate-tree debian/ethtool' to check if
there are any issues with it.

The only minor information messages shown are these, which are not fatal
as far as I know:

  I: org.kernel.software.network.ethtool:6: summary-first-word-not-capitalized
  I: org.kernel.software.network.ethtool:~: content-rating-missing
  I: org.kernel.software.network.ethtool:~: developer-info-missing

-- 
Happy hacking
Petter Reinholdtsen

