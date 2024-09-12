Return-Path: <netdev+bounces-127753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA997655C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859221F23249
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958E19E963;
	Thu, 12 Sep 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsuYZ6tB"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F919006A;
	Thu, 12 Sep 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132819; cv=none; b=JVfcjTl/+e72lUrVsW9UfPaOo4iE6V96MRJWJhaQ3tv5D85Fi+yqC6plNNeSy/cIwMse3E51M6sL5PbdMznqucl3VuiBBblAtUyemfWOI+LbFJcxjCpk6TpnY+FkquPSi1wRG5aYz7zhS4o6+Mvq0O8IRZ2ZMgmd/26bIh50kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132819; c=relaxed/simple;
	bh=gxWJLdsbUew7yDGM8C/C34DUSyBUoVzKhbTYo1x9fa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfP4B6fEc/EEBWOGXNICRexdr850x4w5P/aE/7EZ9zEFBDeLpt2ogTFyJ3GBtbEie/j/5EKV6yveEXCyclVNs5XKMPJqDlFyHPY13+SAbpp2gyWCKXWMMa7xEerbmXfOgmEydmKv++zGKx4gNvToN6gjCXl5mFi4/fRa6wqxGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsuYZ6tB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6C2320012;
	Thu, 12 Sep 2024 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726132815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhVnlUKOgIu5/UvU5Yq2KFQNf61+9gVyEs9J5wPnkG4=;
	b=hsuYZ6tB0IMs3nEpNIYRo7UIH6fV49gyLVgvmiWMlMk67gXLBqh2DbICJFlk5ErQ6RBXAo
	Vf+zJhCugcM+YTVHDD3vqvlLcrB42GaHVoDu0NT29gIl+htb547abrO8rszLcfTP0xzAGS
	0sof4ec/VnzCudOmSnExjDL7M/sgATgylIwWgz7m5/TpPf9zB9y2MKSOHbqhpaEqjb5nBk
	1YQCKE8rsqu0XFnXrmeJYb69ZHGTqmAzeV8ycClbSOXyoEMqK5DSLA8oPTEXKkj/jOEF3a
	SXaasu4X3zJHIZe1GLQjz3mj9nqNtMGkXIk6A4H5T/5dHqzIKlOn+VhY+mgFJw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 12 Sep 2024 11:20:03 +0200
Subject: [PATCH ethtool-next 2/3] ethtool.8: Fix small documentation nit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-feature_poe_power_cap-v1-2-499e3dd996d7@bootlin.com>
References: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
In-Reply-To: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Remove useless .RE macro call.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.8.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index bf8af57..3b4df42 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1809,7 +1809,6 @@ status depend on internal PSE state machine and automatic PD classification
 support. It corresponds to IEEE 802.3-2022 30.9.1.1.5
 (aPSEPowerDetectionStatus) with potential values being
 .B disabled, searching, delivering power, test, fault, other fault
-.RE
 
 .RE
 .TP

-- 
2.34.1


