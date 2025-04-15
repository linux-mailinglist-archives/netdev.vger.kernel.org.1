Return-Path: <netdev+bounces-182554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D86A8913B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24373A6A3A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68E1EDA23;
	Tue, 15 Apr 2025 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y/hEhMwv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D73C463;
	Tue, 15 Apr 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680353; cv=none; b=g5KfBEQiNVZl7E1XsZzpYqo1Fx4IoihrUjIeju9aNMPS0FPqLWBA6F79BK0eTLF3AhX9JvOdQzwU4xAgx6Sso1BCVZ43W3gCJSOIKEuJiP3kmlUcDJwHvkmw2cC5MplybODDKO0ejmwDCE1v1Jqwt6lbe5NqDxKXn1RUokBE0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680353; c=relaxed/simple;
	bh=3L5DSr/anAjq8rWMjWVJIGggboFLg0bqXrEZBkvR1MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK2bCIE9cCIRkHsT3PF8KBKFBsmQSbYSioEjySIFfXd/cqpTf87+j06vXQFK+Qeca0B9eTwwdFm/nGLsfmCNurK40qGh27/mj7LzgttT1iYvQ41//Vq7uuRaOmCiM78+zq3n4PYXDVIwbh1KylFRMOZqznrZ+dN5PT1ZZx7UOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y/hEhMwv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UryYSTd8Isjnz2wM5TnUkjl6yKqC9KB3q5AYQ1Y23cM=; b=Y/hEhMwv5TlnUB65S7T+02PL1r
	mEBh2jgbsv81dWMrNkys99ti5SbA6ADPgDFOzUYctzoCClKOrRNPLnK4YX5LvdBc6TqpC4TzDblJ+
	VlANMlHYLwNdeqAqjR0s2yRuKtHdzijWPd568gdu88KQba7MtPUoMRFkKkJ2XPxGb7BM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4V3N-009Jnh-47; Tue, 15 Apr 2025 03:25:33 +0200
Date: Tue, 15 Apr 2025 03:25:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sander@svanheule.net, markus.stockhausen@gmx.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: Add RTL9300 MDIO driver
Message-ID: <80c5d0a4-e495-429f-9f8a-27be41e2318b@lunn.ch>
References: <20250409231554.3943115-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409231554.3943115-1-chris.packham@alliedtelesis.co.nz>

On Thu, Apr 10, 2025 at 11:15:54AM +1200, Chris Packham wrote:
> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> switches with integrated SoC. There are 4 physical SMI interfaces on the
> RTL9300 however access is done using the switch ports. The driver takes
> the MDIO bus hierarchy from the DTS and uses this to configure the
> switch ports so they are associated with the correct PHY. This mapping
> is also used when dealing with software requests from phylib.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

