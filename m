Return-Path: <netdev+bounces-216289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385EB32E6D
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99CD243B1E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C425E813;
	Sun, 24 Aug 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MIm4Exg5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70725A340;
	Sun, 24 Aug 2025 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025001; cv=none; b=hTnGnVh4DBtLsnoEzsFgRjHLZrAh9sQxQ3j1tSKCRlv5+NbuY9TnARO4s0b6ksrhzSe+Xsjht7UwP4DnPanduIRXdJvYeImC3nVXvoSQFJ4c8dJ/HTVIdTsl7/daPzNPRgDr/JpC45loZzj1mDQw3HcOAJ4DtqK2Qzj7BFoItAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025001; c=relaxed/simple;
	bh=vSxAFtggVdS09PKLJWzVe0Ddlp1IcLwi1e9VZWb84ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBh20jdInR6+x77bBixDTEBytGfCI/VWxUmb/yhRv8EEAhYuHrYauKBR1sSrEexiBKhVbJ2eslN/BgbYk0waBthLZ+TzHy9K0aFNtdn4Ko0Li49NGJ9I+v1m8TK//Gw4vB4cFSrmGXeFZYGKY1hK6pECtR8kLcutqdnZ6JUuCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MIm4Exg5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=akD49lOplOEy9VI3qrujO7oHQJJdrk4R6IO12Dxa/SI=; b=MIm4Exg5TejsGQM1Zz+P6wClV8
	wQmYJG9KVa4xCsV+QTan94tKbv6TTFE/xTGvyaUnQMsEay74ROe0TQnK2skqX7I3xsOhfvjFHKGhA
	SaNV31xAmhooPfdsC8zEdoRpdJU+hIlatzuemj8kulspjyo6frwm2uCEAd8OOksXFI8JzAr4Sap0M
	cjAHyboP+GWReMbsKC/rvEcd+zTWJvtVX4+uPDfTeteO5ejlwbkzPwyrsXm/SKleQCxbFxiQkO+4/
	ZD5wRGWyEhRO9/ayLvAtxLeNGHwkXKWhLnmomONdPb8yynJyZruYi2MnahlyiaJnyk1hpFjnBo3w0
	d3kev6Bg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59678)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uq6Jp-000000005OF-3Vn0;
	Sun, 24 Aug 2025 09:43:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uq6Jo-000000006pf-3Cmc;
	Sun, 24 Aug 2025 09:43:16 +0100
Date: Sun, 24 Aug 2025 09:43:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: remove stale an_enabled from doc
Message-ID: <aKrQpNEZFzQaAII6@shell.armlinux.org.uk>
References: <20250824013009.2443580-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824013009.2443580-1-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Aug 24, 2025 at 09:30:03AM +0800, David Yang wrote:
> state->an_enabled was removed before, but is left in mac_config() doc,
> so clean it.
> 
> Fixes: 4ee9b0dcf09f ("net: phylink: remove an_enabled")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

