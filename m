Return-Path: <netdev+bounces-150324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4D9E9DEC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095602834C2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C57155325;
	Mon,  9 Dec 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X0jlHCNJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230A146A63;
	Mon,  9 Dec 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768308; cv=none; b=q0OfJAb7CMGCp/rqhQnvGnxVum1CoMm1JbFhjy5btvIb3YWN+eh0doY4PVZ7bC3KpNqg0mFT35HIhclm1P2lBDk0OwT/gj7XJ/8nB6EzEBEv8HlMlystF4jRcN1r0L0fHXMr73wdwpUYCXM3aW4Sk1n1lomcHHmdHMLP6Ef4xu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768308; c=relaxed/simple;
	bh=hQWwJZvCHZ1fjq+iunv+2IF24HIubF4NUtlb9W3UYqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guzYcUMvOWgzCW4Un2oTM/bFva6xcgRaCdrqbagH6F+3N9xRQ3+URIuoB701YeSzxsvf4+fMOq/d29KhpDVS1paH+jNkpG9m4qQhNIUVAvZIlgqzp0r0ez+Lok0+yhaSEabRYnSC/wVTa0MOZzG2yHlq+gg2+Fx8zxx1rv6frvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X0jlHCNJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U1f1R4UQUo/1xKrAQLvIckcOBM37rVenaV8lQc3Npeo=; b=X0jlHCNJyTEMgRD7CZcEGzt5zx
	hMvSZXB5Q3TMc/n9neYvA7a50UFIkKf9SmQugpxcaCqtPmBORNoU3u0R/KymJDL9Hs3YnWyJlQqCT
	WQDZx3nJ8bLnbi1Yf7ss2W/tninWrieCA1QUY0Bt0n2F1P7cSUx7mMAPgHQ/DeO1bkB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKiKi-00Fhr1-S3; Mon, 09 Dec 2024 19:18:12 +0100
Date: Mon, 9 Dec 2024 19:18:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next] net: phy: dp83822: Replace DP83822_DEVADDR with
 MDIO_MMD_VEND2
Message-ID: <5d9d8b8b-9e24-4516-ae4b-a42c37128b1b@lunn.ch>
References: <20241209-dp83822-mdio-mmd-vend2-v1-1-4473c7284b94@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-dp83822-mdio-mmd-vend2-v1-1-4473c7284b94@liebherr.com>

On Mon, Dec 09, 2024 at 06:50:42PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Instead of using DP83822_DEVADDR which is locally defined use
> MDIO_MMD_VEND2.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

