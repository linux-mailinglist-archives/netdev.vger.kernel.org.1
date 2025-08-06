Return-Path: <netdev+bounces-211878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3AB1C25F
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CC918842CD
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830C0289345;
	Wed,  6 Aug 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bE/+XvaY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A9288CBF;
	Wed,  6 Aug 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469910; cv=none; b=L3cGQ2jM2S+xUQvxVXHfae1CRb3bucbK6ssbOpTqp438mgkRPVlj5XZ92SL6X+1a/RsdkFwXu5y2Lj13Yuf/2pby16twbPlkBK7F/53xO5MlgKfi8/VaF67wTV7nBrAD2C1KKWoEX0iOnUP9DPA8qGcSVXwMaTtY/SNb4pqFLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469910; c=relaxed/simple;
	bh=3d9f4l7PO0vDDtyzHzbcGD08FIZfF4ZXjGWshLpX/GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYwFKPjhhIo0/PcUIN8ssX7n7utZNQSuSp+SAfZu//a6U+twhHBUUwnYSDZbSAdSv+6BjG/Ppv2Y0s4a0Jjk8wZWoNhmpBzYcEbS3gD6uC7WQmuZbk4/eu+wMB1fWQIfaaor4F/DfAYMJB5FW0LfqU9Donu8aVy81mPcO6Q5tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bE/+XvaY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=swHaUJ7AXoaoTt2usNQa3DarHLliNZPFDd/ULUkX7KI=; b=bE/+XvaYPli8pisc3yNyCb1OJC
	9FRTct6wopSk4Sz2zK0Xf0gAJU5DfHyhEpT9xESASlB93jcGtf5TSoQzR9vfJkLnWR2C09L/RYMd0
	Ywm0eYxMxCCB0dlA2KRUIW+aLjdNMH+UJ/tYJTnA3C/hUxX5D4S1U8YsYK69m4tRekQ6dRNtVv/dN
	DiUgsu5yHYZtPTMPSbcdS52JZdP+xtE4HR4a7Zt4Z50eHbC1jaXLnxwZx0sddzyqUDOBLVYAwLCAY
	7DpKU4XmiR4toZh/q3Z/HdzHlGRFJROXOQMdL4OM24WFUOSoWAhDocRx2tnemJIZyzMiaJZFdgafb
	yV6dJV3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48480)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujZlf-0004He-1d;
	Wed, 06 Aug 2025 09:45:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujZld-0006yA-1V;
	Wed, 06 Aug 2025 09:45:01 +0100
Date: Wed, 6 Aug 2025 09:45:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, o.rempel@pengutronix.de,
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806082931.3289134-1-xu.yang_2@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 06, 2025 at 04:29:31PM +0800, Xu Yang wrote:
> Not all phy devices have phy driver attached, so fix the NULL pointer
> dereference issue in phy_polling_mode() which was observed on USB net
> devices.

See my comments in response to your first posting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

