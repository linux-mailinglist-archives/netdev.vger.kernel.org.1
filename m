Return-Path: <netdev+bounces-188336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29359AAC3CF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE13B62A7
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC327FB16;
	Tue,  6 May 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lKI6Le0K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1C280030;
	Tue,  6 May 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534253; cv=none; b=tJD5uE1OlnQEWwYQaJjVdnwE3HkeZupdkuuXvNYn6XYTLgDPFDIlLiIWdT4Lc3zlDrQRIIAVnEdfYGoItREVVwWeCsexB5R//wpgeZu36sMjV3xnlJg58W/ef2TlnK/ZnSX1DJVmzQkjQJ8k+I8tz9Tpyfl1WHCLcSl9Com5g+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534253; c=relaxed/simple;
	bh=Pe/LD1R11v0r3nlohRwma2BBA+QuXERTLjiv7SMrDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6rrUC3h1zEOVTpXLVks7LqcSmChGkYjfrWNs2mx+ajEenEr72YbKvOL5A2Fuv6mrwMt2qYhaX8GRbjcJwpKnHUw5ON5dus7RBBLJITONfhZpg9Y3c4JWDQHhmRwwSBmh/Yuu2iY6/LvVStnabn1rLC8FkE9eD788f1UZD+ilh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lKI6Le0K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y94onA26ptuGt6ZZ1O0PWKBzwfWEx+cfBmv8M1gAVUg=; b=lKI6Le0KREcdNawRsk0CAI0W4h
	YKfzlKz5/1N0rCWNPOVlKunDUiZvVYlHZTDoCy+JhPcM/aoEkLpNFsCtYibgDU2HTjR2EFXS0+FJv
	DE7tlyBKVFtKuF5zA/ikUTG+MZr22NPuxbhEeRYNDG0B1LN6rYc+4+RAFPsE3ZJ6fARk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCHLA-00BlBI-0c; Tue, 06 May 2025 14:24:04 +0200
Date: Tue, 6 May 2025 14:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
Message-ID: <a9633874-a41c-4f62-9b80-33785c0eec10@lunn.ch>
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-3-wahrenst@gmx.net>
 <14326654-2573-4bb6-b7c0-eb73681caabd@lunn.ch>
 <e75cebaf-6119-4502-ae63-a8758d0dd9f5@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75cebaf-6119-4502-ae63-a8758d0dd9f5@gmx.net>

On Tue, May 06, 2025 at 10:38:53AM +0200, Stefan Wahren wrote:
> Hi Andrew,
> 
> Am 05.05.25 um 18:32 schrieb Andrew Lunn:
> > > +	if (!irq_data) {
> > > +		netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	switch (irqd_get_trigger_type(irq_data)) {
> > > +	case IRQ_TYPE_LEVEL_HIGH:
> > > +	case IRQ_TYPE_LEVEL_LOW:
> > > +		break;
> > > +	default:
> > > +		netdev_warn_once(ndev, "Only IRQ type level recommended, please update your firmware.\n");
> > I would probably put DT in there somewhere. firmware is rather
> > generic.
> I'm fine with changing it to DT. I slightly remember of a patch for a
> BCM2835 driver, which also had a warning to update the DT and a reviewer
> requested it to change it to firmware. I don't remember the reason behind
> it, maybe it's the fact that not all user know what a DT / devicetree is. A
> quick grep shows both variants (DT vs firmware).


The line gets long, but "Only IRQ type level recommended, please
update your device tree firmware.\n" is good for me.

	Andrew

