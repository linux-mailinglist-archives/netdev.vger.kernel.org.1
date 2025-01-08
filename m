Return-Path: <netdev+bounces-156373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C06A062F5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E4D3A7A6B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D71FF1A5;
	Wed,  8 Jan 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LiqIKbvF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919E18D;
	Wed,  8 Jan 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355844; cv=none; b=WV8AJe3po6lbhj8DzXZ180Z4cjTk4upgL0tshWA+CEo4Y/T/U/Dinm5MWxwMZD+DF4n0OEihh2q969MijHOAlD3lWtPj8wL3LJtoMuUenqStNSuGQW0F1jCi8HxmiAu7RXdYjKsmbLHXpZCW0nDIrMfJGNPaY1brLkWCOYAMDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355844; c=relaxed/simple;
	bh=3w9Wh8I5J/bKwu/vEDyku79vbSZeurgnglzCG9hcH58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV30zLdkO69MWiS9wBUObk3bunNsQPFUUNlhLGs47PzlOYFeJHGOI2+5ltBur7Ol7k/bSJ3MQyyK5s5qKZ3hVmA/8IBAXdaWeY6J6HXLEglWIeGtt8mh84knXF8Sa+u1uuJ/DxpNZYOqpJVttCYRmt38p9ymhhbFqyQOg7xwY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LiqIKbvF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wElwbqEqYtg6N83+A08t0RJt17oPW/Yout1Z5OV7l2E=; b=LiqIKbvF79gNnpe3mR8Pb6mhfW
	UUg2iHN3dn42PtoqQBxZLoknQuanz+p4cGI5ayiWZyNkAc2QBgNVh4tOsa0myHvQBxlYLd8yceTB9
	jpwfOz3xVK4dFJmDKSYzOwFtbFpKbQ9kkM+luWpmwlg41K2n0H7QiL1FgN7tkAf9DF7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVZSj-002dOZ-NO; Wed, 08 Jan 2025 18:03:21 +0100
Date: Wed, 8 Jan 2025 18:03:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-6-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108163640.1374680-6-ninad@linux.ibm.com>

On Wed, Jan 08, 2025 at 10:36:33AM -0600, Ninad Palsule wrote:
> system1 has 2 transceiver connected through the RGMII interfaces. Added
> device tree entry to enable RGMII support.
> 
> ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
> 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
> PHY chip.

You appear to if ignored my comment. Please don't do that. If you have
no idea about RGMII delays, please say so, so i can help you debug
what is wrong.

NACK

	Andrew

