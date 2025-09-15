Return-Path: <netdev+bounces-223054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E4B57C4F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406231646B3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8E302153;
	Mon, 15 Sep 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iw5HepY6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807F28506D
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941570; cv=none; b=Q0bW13n3TWE1qsv6ddCVz/m9GhBU1tjKg/x1DdEZhYwNxvRH6P1cECjLhaeRJ9KSW+7moAn1csbhJJyIA4c6UIngf672nr/x0V/SboZas1NK9VyhrrrsO73A5g2DfFtj9AstiYn7BrwBKM7Au9zO2ZE+FYbNnvm7m+uG0fq0Jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941570; c=relaxed/simple;
	bh=ExulcWFm47eTOdZNtwRbp1jfRbp4N4LCNDZOrGIzBec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dOgvF016LRd8GcPyvuWOQVV96RDRAq6setiB42ynlBDdYhRFiw+UP1QTSrxnOFrUYfp8FCKrHj7OKaULk+Mx+Q3eRw7L/j8dAGFN6EMT9u0x2Nb9dB3sDtzuQgSgr+Iwo1tO0bdpscWYBeTlVu3ZUTEKV1lW3sv+7ojuo57LMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iw5HepY6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pPerPm1S+gF96q3St3IiPcW2ffvnuAfAvNiJb2DgBfg=; b=iw5HepY6A/RsKvz1e8+3VLHgFm
	FH06clVdkCoMo/1wXOr4DqgEYGLWvHS8QjpvlaVFP4ACpU/c2IpFI69tfnjCKh10/nUp9wa9pD6wA
	EHJR0bn6pKfiorleDLyaKGYbjcs9QMwMifntBiDuZkzS1+yVFPNJFnegJOmBmByrmoS1DOZ9BOkEX
	Vsx/Q4YjQHSgnOzQIATC+3u0W0yugeZmsW+iWiuTRqmJV1cJilcC9xh/EpDXfrcSA981ID76kZx70
	AmTSbLkl25PlafQOVxZzwp+Bkfn1X9J9iv+vqahQrfpsxkEkgK4+kUqPImFGvEezMMBhmNNi0wWL+
	9oGQKpzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36372)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uy8uA-000000000DW-2yRe;
	Mon, 15 Sep 2025 14:06:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uy8u8-000000006g0-0Pfj;
	Mon, 15 Sep 2025 14:06:00 +0100
Date: Mon, 15 Sep 2025 14:05:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 0/5] net: dsa: mv88e6xxx: further PTP-related
 cleanups
Message-ID: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
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

Further mv88e6xxx PTP-related cleanups, mostly centred around the
register definitions, but also moving one function prototype to a
more logical header.

These do not conflict with "net: dsa: mv88e6xxx: clean up PTP clock
during setup failure" sent earlier today.

 drivers/net/dsa/mv88e6xxx/hwtstamp.c |   2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |   1 +
 drivers/net/dsa/mv88e6xxx/ptp.c      |  24 +++----
 drivers/net/dsa/mv88e6xxx/ptp.h      | 124 +++++++----------------------------
 4 files changed, 39 insertions(+), 112 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

