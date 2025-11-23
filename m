Return-Path: <netdev+bounces-241076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABDC7EA66
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 00:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737974E16CB
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 23:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A638254AE1;
	Sun, 23 Nov 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nys3wsm1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6F22A4F1;
	Sun, 23 Nov 2025 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763942279; cv=none; b=o25gCNhZ8lgcc0dgce0rIFuHNT4jIPI4QWOwZ5x/APUznVaPn7em3JZPFtPQ+WwKq0muEPhnkOWgv4cUA/bmfUw8YIhXTgvOAQjO4R2Ktnad78Kd7cApUq7VhOvOOCZOwXS3Dop6UlDbfozWVCh4KnhtPwKGuf7hO46gNSJRwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763942279; c=relaxed/simple;
	bh=7UCfFxy8Auezvw3B9C0wkhhM8Bbx/Q1s6ylHWZ/jSq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx/PQVO6Xyc3cWHz77untfGAQXe5TeexzlBaQE1RsEvrYXMejZsc6+DNKNj57NTMfu9N7ScA8WFXpkmvJgnlSUhlCHV39iIOOF1fMSn2eH7ND7non1HnokBymtGpzcdVJ8RN7J6nvxPsZDUxD9XzlDI1P1kFkfaHNf02mX9YjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nys3wsm1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jthjefMqhVTAdl+O208yxaCHZr3qm4aIoX0PlkKpCXA=; b=nys3wsm1cFL3+XxxinCbMvC1pE
	qeomwOiS9tqUIS7AJGi780MrwhVcP5oU43TXaizySHK97NbQUh4ssf+tOL/rjIICDIM0u8Y/RCdbc
	DcFcuvkSoXPHM6Ta0mJEaV1DY2AKYg8vFgdCltQ/ZGcrgMw0jv5QM2DLGygytgmvC4Ks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNJxj-00ErpD-J0; Mon, 24 Nov 2025 00:57:47 +0100
Date: Mon, 24 Nov 2025 00:57:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: mxl-gpy: add support for
 MxL86252 and MxL86282
Message-ID: <0b635e44-ab26-4559-aef3-0678a579512b@lunn.ch>
References: <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>
 <a6cd7fe461b011cec2b59dffaf34e9c8b0819059.1763818120.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6cd7fe461b011cec2b59dffaf34e9c8b0819059.1763818120.git.daniel@makrotopia.org>

On Sat, Nov 22, 2025 at 01:33:47PM +0000, Daniel Golle wrote:
> Add PHY driver support for Maxlinear MxL86252 and MxL86282 switches.
> The PHYs built-into those switches are just like any other GPY 2.5G PHYs
> with the exception of the temperature sensor data being encoded in a
> different way.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

