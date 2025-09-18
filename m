Return-Path: <netdev+bounces-224596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB7B869F9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546886269B6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248227F4D5;
	Thu, 18 Sep 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q0vrB/TN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF049281375
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222504; cv=none; b=VZydlAwZ2n8lb/exN74mvcH/hvGSrioH8JGFNtZKfRVQlmRmN7MJAo5EtE5Q80kjN8pDptGBxlrNkpz5eEO2HEvXqFLXZMLftWiTAy3QC6Svxn71JVbUkys3uj8ARXqqjmEn6/I6rOaYYfgaUL9FSEkPjMf+7emogIjVE3EsotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222504; c=relaxed/simple;
	bh=5Ily49FCamyxGmkH9L8kTBOuDKXCTRNUzK6Q6V8ZCCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5NM1MhrXV0Gq4iTSWQe+uAlXtuyPS3sgxmWnozyG20W3OqOuOAy8hJ+/TlRFnPoqneCm06qzZPF8s7Orf8nO9za6MQ4T5RmPPOEtgh983iyojbY65cqeMYWuz6hYmvuDR5te2PnfgsV5ZDuIvXsPO/DVwbaG45oFdqQiI0XRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q0vrB/TN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fvalrn7IGNfQiqmB2yIvxqI8D5FVWvl4H9VnHfFrO94=; b=Q0vrB/TN7KMSJRV2SNPdYyaMtC
	ohdBdwtIS8B1NyITqZt4p/bVuSReBdVLNd3bjjLhkNuR3WsT2AF8kYTRY68DIBeWcBjtmGXASWYF+
	0iNppOA53joZPO+JicgdseP8h7zQHEL9ZitF99AyAX9KiCGe+yAITVlDLEHuCMovBsln8jwUAZ50r
	GGXuH1O1GTXSyAUXbgazHwxSWFAKtGCFmuXucc43lTLFm1pS0Eg7vmqjoaeR/ueTgi8jmg+0BZDTy
	RlT6i3zFqQt/4g7kH+nZ6rapUiH5SOl7JR7x0Quj09mZ5Cmo7HC4HNjg1vjvIGOdfOz2pxtoNDCpt
	ShFFSLsg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzJzO-000000001t1-2bHk;
	Thu, 18 Sep 2025 20:08:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzJzL-000000001RJ-2CE3;
	Thu, 18 Sep 2025 20:08:15 +0100
Date: Thu, 18 Sep 2025 20:08:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next] net: phy: micrel: use %pe in print format
Message-ID: <aMxYn6NlhPybqAQn@shell.armlinux.org.uk>
References: <20250918183119.2396019-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918183119.2396019-1-kuba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 18, 2025 at 11:31:19AM -0700, Jakub Kicinski wrote:
> New cocci check complains:
> 
>   drivers/net/phy/micrel.c:4308:6-13: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/net/phy/micrel.c:5742:6-13: WARNING: Consider using %pe to print PTR_ERR()

Yay, more human readable error output!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

