Return-Path: <netdev+bounces-235211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0BC2D84C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758B33B3D62
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC9200113;
	Mon,  3 Nov 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rsey/Sbd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2C314D20
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191771; cv=none; b=SnvvNVYN7zH+TrrjMy49HDQZRW5rCBgBLL/06oH6svbifM3Pw5upJ0WWkd2+YNHhIJWrvY7Iw2T4WL8q0PtsLIMWWZejeSXoulN9s74tEzd6pkvwsTJU58Y2YEeiJ1uavtgYWqhgG2JppiS0bSTAnzbjS5j/4WAQCOrS1cZdUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191771; c=relaxed/simple;
	bh=N5no8eLsccSFkdr0v8WSmeYYmoSC0nA9Vc4fmPHrtos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9JpyMZoO+vQSv9aE2SZRQ4nia3qEVWJ2JXNnqrFP0awjr92zfRt7Uos1XhzQsq3b96FRa+d3yXXfpqUIKNinl3Lt+ncKzsltxF7IFH96jr7zpJgR+y1A1uJlcPm2PG34zojPDZ3xNIIsDhKytrT4R/RmWH8Cd+4n8YoELEcUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rsey/Sbd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GacqkKeVA83J2F7z/hqWmJ1ugX1qsFrCMSsZwQbcp2Q=; b=rsey/SbdHqOoVC6FCvCMR3dVuW
	iopm9uLbF2V9HFmN4LqVGPeDqUWDuBE5nmZkqLm5A50C92WY/q40TnyOOc/pt3ynWf5hB27LXjw/S
	pKxW5h/W/WxQMM45/qNv/rBz4AQm2UEnGWzlxanCIw0GLBNIjxxa/HhnFnkwcsxjKa46tkZwYgh32
	D3friYkdbz/kU/1udqQ7QvNse+crhLU+CczUcqpLGxUCUxr9Dy4/rYrgXzeYPWtsABGzg2aH0UK+8
	8tXGCi1sGhCkHQEDvR6RGX2vMyXAxpNrDdfFD8JyfSaBeyTzUFLgGbN00jEl7VGvJ/Z0T0zo6EOGI
	1WyleYmA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFyZo-000000001EN-3Ddd;
	Mon, 03 Nov 2025 17:42:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFyZm-000000003zD-2iYv;
	Mon, 03 Nov 2025 17:42:42 +0000
Date: Mon, 3 Nov 2025 17:42:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next PATCH v2 02/11] net: phy: Add support for 25G, 50G,
 and 100G interfaces to xpcs driver
Message-ID: <aQjpkpqpF2SgZkkx@shell.armlinux.org.uk>
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218920872.2759873.3935936327928788544.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176218920872.2759873.3935936327928788544.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Subject should be "net: pcs: xpcs: " to signify that it's for the
PCS net subsystem, and the xpcs driver. Please review

git log drivers/net/pcs/pcs-xpcs.c

to see the normal prefix used when modifying any particular driver.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

