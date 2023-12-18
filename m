Return-Path: <netdev+bounces-58589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF50817532
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C93A1F23579
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7CE3A1B6;
	Mon, 18 Dec 2023 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wDpkNIVo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A188200C0
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VnNMk0bUluQAleIzcIWSWUgm8MAocoUefn8viYkQdDU=; b=wDpkNIVoZL/m8WTS7AlxknkGzD
	WYzGMZYvQxrBw2OR8gT1en4oYCmA4PY9YNGa7VE4wncwC30c/sXXkyI+szF+IDpxD8qSfY6Tn6WCB
	gIbad8vXXy/nqDblKSpuJ2zr7phvQK+H1gaSX9mEI4/dkqt0eCnSppkgYLGZlCqwj3iCEtzrbqYc6
	f9uzC4DZLDDmN/JrzJEfXv3VPl0CPF/17VZuk4VI3nTtYIZSj+JM1Ee4QKc5glC2B/5GQ8KJMMbTJ
	FMx/VaH4028FMaO98co3bQw1Pa961HVqVoaZoCdSsjQeTn6DHmtHp5X9oaSQJysfAaRF3T+uX9ntl
	Hvs4Kadw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rFFWW-0005VF-1z;
	Mon, 18 Dec 2023 15:27:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rFFWZ-0006oc-0H; Mon, 18 Dec 2023 15:27:19 +0000
Date: Mon, 18 Dec 2023 15:27:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: rmk offline until after Christmas
Message-ID: <ZYBk1u0TmX3GCieY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

All,

To make it more plainly obvious to everyone, I will be offline from when
I send this email until the new year. This means I will not be reviewing
any patches or otherwise responding on the mailing lists.

This has happened earlier than anticipated as I have contracted Covid
last week and tested positive last night. Unfortunately, it does not
appear to be a mild case.

Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

