Return-Path: <netdev+bounces-177919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB87A72E50
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F583B7A66
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE820FA93;
	Thu, 27 Mar 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NbCsH+Kd"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AA20F08A;
	Thu, 27 Mar 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073225; cv=none; b=KKKxWvwpdgCONs8gJUKQFswLRya/+PtCFPpWaJIll67PLjxWOWQYaE6kQQYYzEmSVDstlFBPZ0pvBerWtfOF7kacH017zM7RSsodmPiI+LALUCuV08ZYa+wVDZhAEIV3TYIVx2Mkv6OLI857ZU+1aLHnuClfizBR2UqL/qsxEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073225; c=relaxed/simple;
	bh=w3JYCOGpygoGJ3y123UWwPLBHs+WM8VCObC2NhViTlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeibdIwZUpCP5xeax8fR2hMch0utG9TVDRWPd2HvBAAjvwCseaQn+sPjvDGxlyLE6ORXPw98mn/2mwIAas0JW0SBJyIVfAcXDXBI5BeL0Q7uoT/2E9nxH+fhFR3AozvxFLBxg8P5z+KLKwTyv5xBBdEXvrWxAbhHZzEqzZEWLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NbCsH+Kd; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA89D44398;
	Thu, 27 Mar 2025 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743073215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/QfWDYrwMkLZJOOtnbfBEwGvUQZ+rFNZUyw4fZaJqEA=;
	b=NbCsH+KdjKpUhgit17/yawha+DWXowPoQ0nKI24bkOdE2voj0r0LzKXv50ukDDRjngzPbZ
	8URO7qvWwcIP1h54a7KmiGjhtUoCQYG+D6HWr0sOBY1h+33paqem+UYYo741b7Y+p8X2BF
	qWI2BZGGjkalc0nddixNHVtQlJXuelzt7EcKxlYo2ofteJLSEqsNmhQyqNk30GbroG6EoZ
	44a4w+WlmFOIC5sJaQhQjosFtCj/9Ci2tSr490CNQANO9eCu5FKkYw1kTD9v4wIYGl9AQ8
	CulovQAYsIYYfMi/v1b1NagcBxuPPCDErbXDpe7DetvRt+xTscigBXls/lzxQg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH RESEND net] MAINTAINERS: Add dedicated entries for phy_link_topology
Date: Thu, 27 Mar 2025 12:00:12 +0100
Message-ID: <20250327110013.106865-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtheeufeeutdekudelfedvfefgieduveetveeuhffgffekkeehueffueehhfeunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

The infrastructure to handle multi-phy devices is fairly standalone.
Add myself as maintainer for that part as well as the netlink uAPI
that exposes it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Re-sending the patch to target net instead of net-next, and aggregated
the acks/reviews from Andrew and Jakub

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd25139cc58..36511ed5bf6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16577,6 +16577,13 @@ F:	net/ethtool/mm.c
 F:	tools/testing/selftests/drivers/net/hw/ethtool_mm.sh
 K:	ethtool_mm
 
+NETWORKING [ETHTOOL PHY TOPOLOGY]
+M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
+F:	Documentation/networking/phy-link-topology.rst
+F:	drivers/net/phy/phy_link_topology.c
+F:	include/linux/phy_link_topology.h
+F:	net/ethtool/phy.c
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1


