Return-Path: <netdev+bounces-162998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB7A28B9F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F5D7A2F0B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57513757F3;
	Wed,  5 Feb 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ijV5S+jG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47FA32
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762058; cv=none; b=ThRVR76bmUkDGPGcKtFU1wvjPFDO9fAkKIi+YSqdYaXsSgLEIKyX2jEKJqkYZV2D9YpP+DjlwRkdIUfZd4Vux77HWGjanBSCrfoc8YBSMTHvAUc56Oos4WOegqlaYl9W/+jWCEHa1vpfZAD6CBFM/8LGbXzeCsXLmPBFfIm2k88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762058; c=relaxed/simple;
	bh=Vo4cnXiBDUBPImuFFbKfMdQHW6DjrHpEgztEDffhZ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qPMswaTqRhmWhiglvf6aeOZKOf7LWnCRxPczDvaTz3dNMjduAmQbR32KVDznY5HRHFhT9wAvju+bY6W2e6CuMBNrkMQrd9pIzYcXGwpjybTWk2RubyazQG3O/90nlkvCfr0BQapxzmy04iwRJfdBATVvAPq2l7L3aHYnxrNFSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ijV5S+jG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mOzH6N5N8CxYb3sHLKiz2r68AolXAO89k1+za8HvcYY=; b=ijV5S+jGuPwrCPU3h/hKQ5UGrg
	wS5S8oyivMwyCebczIQHxWGtbS9AidZE6lOUoWXtP/v6s7gK1kVSxs14wbSatKINZYhkzQUsAbD2k
	2R2glTJYSFM23fG9UroFgjEsYw2R4hewXXGj5Hxzxl3rszvhXhz55TGsgBKQkv7NO1zVahz9PRbl/
	E2eDePhs//i0b6zjJayRTVG98b9j1S/G7ICZGzFU3IRCHVX3qSVhKMJo5udHqOAHVVp7plLPOfjO6
	4rXy8bjwH6i+UpmZMDjV1IH03tqvLEgQXqYlrrQLDq4AaYmiedOxX96ZtgmXj+5l4sl0V/vNWadDJ
	8LkgN0Fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tffRB-00076R-2m;
	Wed, 05 Feb 2025 13:27:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tffR8-0002RB-2u;
	Wed, 05 Feb 2025 13:27:26 +0000
Date: Wed, 5 Feb 2025 13:27:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support for
 KSZ9477
Message-ID: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series cleans up the TXGBE configuration for SGMII modes, and then
extends that for KSZ9477's "manual" mode. Finally, we add the necessary
settings for KSZ9477 to work with 1000BASE-X which should cause no
issues for other integrations.

Work for Microchip to do before this series can be merged:

1. work out how to identify their XPCS integration from other
   integrations, so allowing MAC_MANUAL SGMII mode to be selected.
2. verify where the requirement for setting the two bits for 1000BASE-X
   has come from (from what Jose has said, we don't believe it's from
   Synopsys.)

 drivers/net/pcs/pcs-xpcs.c | 64 ++++++++++++++++++++++++++++++++++------------
 drivers/net/pcs/pcs-xpcs.h | 28 ++++++++++++++++++++
 2 files changed, 75 insertions(+), 17 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

