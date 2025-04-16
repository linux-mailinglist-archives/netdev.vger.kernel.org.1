Return-Path: <netdev+bounces-183366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711FAA90831
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B54219E0ACC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6703188596;
	Wed, 16 Apr 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FqYd/Hol"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DD191
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819279; cv=none; b=LecKNGYAamH9krKEK0dWJE4YorbrbvtApHvC+4uNz11K9SNsXcPd3d9srC1w3j8R7u4/urWY3oAB9Aig/mfE5HQfdPPqEq2hb2osgUXXIHRdQotyUiSFEExpLA9b+uM8k8cnXd+pDKdZXKqzcHTT2pq8RRp9ggDAwT771KQLXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819279; c=relaxed/simple;
	bh=d01E0bLTofe6K57AiS2Mi1MBFuBDQCIzV6cTe8KJFyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8A+g1eASvkD//Nsjt/DtF4t9CjFdOpDYPedCsGgP6WqYB1hGNMvhSYcT9A37egqHCw3tWywD5Pz7rJ4NRH98uuggV/UmzpaKmVEW836MIB9IBVqHs2NiPdVJSQDCl6p9O4RoWfGJ3zuaWqmpUYqyRERvThjqALGObAlvHo/+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FqYd/Hol; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j5mDVNAmoCdKRWGtUvfdn9c9HuB+HG77LP79TJaol8o=; b=FqYd/HolRsF0CN0nkEwsYLq/3P
	VWTKGYY/yDxnuk/ldLZlskJhalweVEukzKUJXTy7N63oJKLxEoihEb5YqhZ4c28ET2zzRHEZW7/3q
	1Yx5tBbihyedgPYgzSz0x8NiS3DrXbOub2BDP0m2aAcpO/1cazSIMlQdOs6B7eQOVVSnvsaZv8sW/
	OEblhIJ1QOjqVuDleG/82Ak6ef3jxVYkXLHXC3yBNRaFDOf4+Uqf+GvkxpipLqq45fS1BGkPXRbwI
	gKsrwm3gOzeX55mFbNl/yXPiZms3/Na0mvuNNsBNaK29NN5swyMXHPDr+O+q053AzNg0pD1z6eGcF
	jsdFZLLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48410)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u55CJ-0001bI-33;
	Wed, 16 Apr 2025 17:01:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u55CH-0001WT-2Q;
	Wed, 16 Apr 2025 17:01:09 +0100
Date: Wed, 16 Apr 2025 17:01:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 2/2] net: phylink: Fix issues with link
 balancing w/ BMC present
Message-ID: <Z__URcfITnra19xy@shell.armlinux.org.uk>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 08:29:00AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> This change is meant to address the fact that there are link imbalances
> introduced when using phylink on a system with a BMC. Specifically there
> are two issues.
> 
> The first issue is that if we lose link after the first call to
> phylink_start but before it gets to the phylink_resolve we will end up with
> the phylink interface assuming the link was always down and not calling
> phylink_link_down resulting in a stuck interface.

That is intentional.

phylink strictly orders .mac_link_down and .mac_link_up, and starts from
an initial position that the link _will_ be considered to be down. So,
it is intentional that .mac_link_down will _never_ be called after
phylink_start().

> The second issue is that when a BMC is present we are currently forcing the
> link down. This results in us bouncing the link for a fraction of a second
> and that will result in dropped packets for the BMC.

... but you don't explain how that happens.

> The third issue is just an extra "Link Down" message that is seen when
> calling phylink_resume. This is addressed by identifying that the link
> isn't balanced and just not displaying the down message in such a case.

Hmm, this one is an error, but is not as simple as "don't print the
message" as it results in a violation of the rule I mentioned above.
We need phylink_suspend() to record the state of the link at that
point, and avoid calling phylink_link_down() if the link was down
prior to suspend.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

