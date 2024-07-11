Return-Path: <netdev+bounces-110923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8892EEE1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FF71C212F7
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6EE16DECA;
	Thu, 11 Jul 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ttVagQSo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F316DEAA;
	Thu, 11 Jul 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722532; cv=none; b=u2Rg54dKKnDCW9FYlkSz/MSwYbR7RZIV5el69XHK4wMm138HJEvf7pJDczoINR9lybjcm+KddVQhxPBbNqivOmB7VgOLJCM/SViGAvOMDNaPQ5OmRKEcLdIz0F92O07J3k1WSwzocyuzz2Mx/OO4KXybfhROTIoheRMTwMKL1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722532; c=relaxed/simple;
	bh=GHVxz7BGSe8wTmk5XDUcae0THJQ1o2Dl+851XljT4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TucCY3qE+a931N98OjNne1xLsazRBPdBgV/EeGEIpjwE3FlaXdCSb7quwFRIVst+KbXN1Un90AVY4VYGkF1bPBqjAN3W1n4CGs/dEuOpLuti70U5rrYKIaecFAORKwJ7TuLat93dP3rfeYCiGdhlxoCCa2q00vTQjELg0GQaGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ttVagQSo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=eFT51m+n7jEkYuIj30OEP6mKldwB0e31W9hIxIspLx8=; b=tt
	VagQSo7V/WCHxvOBneLoGyJDUzVQgCcElkAKqaLgYKkZEeHpDExWGv5u31c596bJfGdmFD5cuCpzO
	g3TVN1nlLg3HbJBnOfWXX5MdVzmLuXIpWIdfRw9joGzb17ExQ8ONh4wnTIV5KGip/DzD5cO9oeh4k
	Qc9JltIOVj39Eig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRyWz-002LKs-EM; Thu, 11 Jul 2024 20:28:37 +0200
Date: Thu, 11 Jul 2024 20:28:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] net: phy: bcm54811: New link mode for
 BroadR-Reach
Message-ID: <8f837625-e030-4c5e-a146-62aaf3fbefc9@lunn.ch>
References: <20240708102716.1246571-1-kamilh@axis.com>
 <20240708102716.1246571-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708102716.1246571-2-kamilh@axis.com>

On Mon, Jul 08, 2024 at 12:27:13PM +0200, Kamil Horák (2N) wrote:
> Introduce a new link mode necessary for 10 MBit single-pair
> connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
> This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
> terminology. Another link mode to be used is 1BR100 and it is already
> present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
> (IEEE 802.3bw).
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

