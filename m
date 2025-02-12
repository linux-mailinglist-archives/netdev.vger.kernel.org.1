Return-Path: <netdev+bounces-165689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D18A33100
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1193A7619
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AE2010F6;
	Wed, 12 Feb 2025 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mC/dRw7x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5B1FFC62
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393202; cv=none; b=uzb2HhS0vqHssvcsYdM4qK2aVCMwhh5u/c0ERkqKQBvFFWEdQVHacmLL7S9yOOyIRiU1qSVJUZcztLQbDL7oJ6fp/+gOXQ1afQOzqZYAUs/9msderET1a0pFf56/SpIFnop3igBUdJWFqhXPLuD96PDOwS6lN0r4RDF2vTWTIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393202; c=relaxed/simple;
	bh=x2R+l8Rcf9Zt1RB6QbPTyn3JS3i/o0AT2JpyaRwxF5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/+aVXqDHoImyxskCkrD6YiLUR2iIeq2upnPj0MC+m5yV/MH12ktq3Cf892F/818IKK0B6TNvJ65Brbui/7pxzOkjG6g62wX24NzMUzIiKu76TY3X51cbHkhnhfBvRnEgIdjJnMcQlNnJik2YMIUriyJAykTMSycZ73ZH2hU79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mC/dRw7x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cBrTS27Z7B85wBeUAuERS149R8B1HJp5S4BYC7aYBqE=; b=mC/dRw7xPiZbwxTXVKF9y/rpw+
	P15hv/Q1zmx5M7dNIJ/QrragfJqK6lAZfInPdMbBFQ7yAe78s3J4ugWnS59pB54KsVABw9i8PnIqj
	8H3BOkjCXSgLsIYM6HhHbNx5E9Em4kO1VJA78HeA1jspw4wRSVecfsUmAst6cqkSsoA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiJcq-00DVef-VU; Wed, 12 Feb 2025 21:46:28 +0100
Date: Wed, 12 Feb 2025 21:46:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v6 6/7] net: selftests: Export
 net_test_phy_loopback_*
Message-ID: <c1229fd9-2f65-40dd-bbb5-9f0f3e3b2c2c@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-7-gerhard@engleder-embedded.com>
 <d6cb7957-1a54-4386-8e10-17cea49851df@lunn.ch>
 <b18971f2-0edf-4fa7-be1b-eec8392665f0@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18971f2-0edf-4fa7-be1b-eec8392665f0@engleder-embedded.com>

> Reusing the complete test set as extension is not feasible as the first
> test requires an existing link and for loopback test no link is
> necessary. But yes, I can do better and rework it to reusable tests.
> I'm not sure if I will use ethtool_test_flags as IMO ideally all tests
> run always to ensure easy use.

We try to ensure backwards/forwards compatibly between ethtool and the
kernel.

The point about ethtool_test_flags is that for older versions of
ethtool, you have no idea what the reserved field contains. Has it
always been set to zero? If there is a flag indicating reserved
contains a value, you then know it is safe to use it.

At some point, the API needs moving to netlink sockets. It then
becomes a lot easier to add extra parameters, as attributes.

There is also an interesting overlap here and:

https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-management-and-testing.html

What you are doing is not too dissimilar, although the PRBS is an
802.3 standard concept and typically part of the PCS. There needs to
be some sort of API for configuring the PRBS, maybe as part of ethtool
self tests? If so, the API is going to need extensions.

	Andrew

