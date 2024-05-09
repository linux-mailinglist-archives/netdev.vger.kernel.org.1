Return-Path: <netdev+bounces-95135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2848C17B2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6270F1F21ABE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0780043;
	Thu,  9 May 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GO1BDJ+8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA471BC4B;
	Thu,  9 May 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287178; cv=none; b=aQFniSc3HElRjzFAQUirn95ISjNrPi6jFgz9Qq2dUKlp8W2YqfG+AUzT/y4q97m0rWzQOQyXNp2cthaXF1iGB38SmSl6hu4r+7lY80V31n75/ecXQKQNM9Wci9xI3gZT6nUAQ+WL7InPVDCidlmtdNF9YvU3aDfMHlY9F1L6ijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287178; c=relaxed/simple;
	bh=Unk6TINaoXW1m22XIiXlyqJeSR2h34B7v7roKHZmXSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBFCJh+XRJfQKmsY0fG8Sa5pLR5NF0s7SERkQYhjz34Qe83xrEWrW8ZuofeejYM4i7OLnfOS/PuvquD6W3KsLcD5b/iAJ2N9ft/pDdCnEDB1+64yJRxtv49Rcxnyi0HfgVMSKHhuyadBwF3CbnUuzthDgHOzur6MCViCSSh/sxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GO1BDJ+8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8YzdbPc6Xemin327MHAKFJrmBQ2jFs5tWg4OYxNAVXQ=; b=GO1BDJ+8/8ERTKWx6Q3YbYQc/j
	FllvQRc5rCYfVIFZ9cOPp7Apf1xPacODWgf1aD1LUJZSACbJmDb1Q1CX4Ex92s6JINBchKXhdfdeF
	NoseCuqhrcfvuh8KY44tWNYuXsUNToClf2DFbLoFJeDl9NbrTR+/ADKyLYxxycqFjV6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5AXy-00F50G-Je; Thu, 09 May 2024 22:39:22 +0200
Date: Thu, 9 May 2024 22:39:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>

On Thu, May 09, 2024 at 01:04:52PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 08/05/24 10:34 pm, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> >> Yes. I tried this test. It works as expected.
> > 
> >>     Each LAN8651 received approximately 3Mbps with lot of "Receive buffer
> >> overflow error". I think it is expected as the single SPI master has to
> >> serve both LAN8651 at the same time and both LAN8651 will be receiving
> >> 10Mbps on each.
> > 
> > Thanks for testing this.
> > 
> > This also shows the "Receive buffer overflow error" needs to go away.
> > Either we don't care at all, and should not enable the interrupt, or
> > we do care and should increment a counter.
> Thanks for your comments. I think, I would go for your 2nd proposal 
> because having "Receive buffer overflow error" enabled will indicate the 
> cause of the poor performance.
> 
> Already we have,
> tc6->netdev->stats.rx_dropped++;
> to increment the rx dropped counter in case of receive buffer overflow.
> 
> May be we can remove the print,
> net_err_ratelimited("%s: Receive buffer overflow error\n", 
> tc6->netdev->name);
> as it might lead to additional poor performance by adding some delay.
> 
> Could you please provide your opinion on this?

This is your code. Ideally you should decide. I will only add review
comments if i think it is wrong. Any can decide between any correct
option.

	Andrew

