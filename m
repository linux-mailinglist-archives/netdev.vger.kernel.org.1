Return-Path: <netdev+bounces-222054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB889B52EE3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63051B26EB9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE781DED77;
	Thu, 11 Sep 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y+CwFyLr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C3288DB
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587570; cv=none; b=fgL9tyAx1FrbpIXZbxpXLrUr6hiAsDaD3CyQZvS9mgvhICdCFAKzOdQnMqR0EOw/0wAJpxHItVWwbOHWo4YlQLm9UZxczYMAOA3TXQEjOzx/1L+O4Qw/LeBOSQjonTrES14irGxKp2Taf3u6icHG2/zD1FbIFzk/HQXVJ0eULFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587570; c=relaxed/simple;
	bh=NL64vX0D3up+otsPGbGAYfyEVyLGlVBHwEZCYPCkbsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=klQMIzqhkD6QlYGEv4O1/ekMu+PBmHr1TCaKyYVBckqlkyB2u10nwhHWJKBy0oDB7mvAl2Jc5cF3G76Iyy+bohZvyrN5zzrbiIcfyzP4mPGfqcQJt7IwFhAoHCaCIXiOCsPpyTH3C3MGK1Ek7cDnCqSpD7tRc4yl9rls0VYqqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y+CwFyLr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hf/mDYxEsjx164N97i5P7Au6KHHEfORnhAPs8S6ufw0=; b=Y+CwFyLrzYErHDTI/iUrw6AK0+
	Nhtc5WtijOPQjakvwN3iBCrA3cVnhStQ9s7mKOAt0NZliLqZ5NUwkkgqFChPmq4WPRDks7g1LDrCO
	hpC9LpMtIGXEYt2OCCOMZbpJ5AvdyT9MVTItQwid50Pdp0gU3iv8jYrkhTVMTBid/MoU2jtwrXzRA
	BBDDVbMRaGfLt6d7cF+1QEEWMqxyp7yAhTYM58q2o+UxLvKmlD2oH0OOT81UpQQ64GcqMDJmGd8AZ
	TD5ppNL3d7zM/+4D0Fh4H+OD/cgawK5XGqWJZBDBO/w4Ec5cyHhWPIKO0vFMGLdiwf5KrR2EAdRZi
	U8/VoScg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uweoQ-000000002pA-21xc;
	Thu, 11 Sep 2025 11:45:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uweoN-000000002I5-3ae5;
	Thu, 11 Sep 2025 11:45:55 +0100
Date: Thu, 11 Sep 2025 11:45:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 0/4] net: dsa: mv88e6xxx: remove redundant
 ptp/timestamping code
Message-ID: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

mv88e6xxx as accumulated some unused data structures and code over the
years. This series removes it and simplifies the code. See the patches
for each change.

v2: fix evap_config typo, remove MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG
definitio

 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.h |  2 --
 drivers/net/dsa/mv88e6xxx/ptp.c  | 55 ++++++----------------------------------
 drivers/net/dsa/mv88e6xxx/ptp.h  |  3 --
 4 files changed, 9 insertions(+), 53 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

