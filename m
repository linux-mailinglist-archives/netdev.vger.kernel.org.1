Return-Path: <netdev+bounces-239128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FCCC64666
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93B93365D5F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7008332ED7;
	Mon, 17 Nov 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bUMGmjsw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CE330324;
	Mon, 17 Nov 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386146; cv=none; b=sQHeKa/qhWyyKFcEhpBzrScsHkS2V+X3drniQAtycoaN6lHygwPDkyiHAUBbhTcozISz8uoqh/5kJtbCKDcIeIUE5c/Y4TSv0jMZajHWvIgSY6NYfC1v4a3cLkjkci4c/qLpNuY3057jfNv22ZGNo/X3KpjUjO13th6tIg+sGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386146; c=relaxed/simple;
	bh=r0mT2qQ0b3k2TZklBcbxQxGJldXI7F0tS8ZouuXPOBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9IXSb+G5w9VeqJ7OvlP1IhzEDsU9eRs8kxW8FTxEW4fl3alKFLshR5aWXOn8krFBNmRwk3Wd+zp/lOsxUNdT87YBUNtZny6yqL7nTqKyRFvSF0A+OFg9ITvuTQelkJrQqYNjokdKND2fF+r0+BksmrfNiq0gJPzHq+G7ds+ADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bUMGmjsw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A86QsamHKtu4PAbqkMwXXYKtkpb5hxUQyesNI8ffJ3o=; b=bUMGmjswKa3gjoXHxI8k8cBNqA
	UPNpzgkBrLzcyaXKTWAXWNQe1VJzr6yX1qs4tM32ea1CvdkD96wYMEpwXphCugDIZtwTYdKdD13It
	A1C9iZvPAUB+P2IhxZJ1cqNwGocWzEV/YYCeumvLnG8vDuabIBNmNzCCuSqrPCUPum+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKzHr-00EF8b-36; Mon, 17 Nov 2025 14:28:55 +0100
Date: Mon, 17 Nov 2025 14:28:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Peter Enderborg <peterend@axis.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for net-next] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
Message-ID: <7000f777-d082-4b06-88dd-67f947c85d2a@lunn.ch>
References: <20251114135935.2710873-1-peterend@axis.com>
 <3feaff7a-fcec-49d9-a738-fa2e00439b28@lunn.ch>
 <5a7f0105-801d-41d9-850c-03783d76f3e1@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7f0105-801d-41d9-850c-03783d76f3e1@axis.com>

On Mon, Nov 17, 2025 at 10:02:05AM +0100, Peter Enderborg wrote:
> (resend due to html bounce)
> On 11/15/25 21:41, Andrew Lunn wrote:
> > On Fri, Nov 14, 2025 at 02:59:36PM +0100, Peter Enderborg wrote:
> > > Ref https://standards-oui.ieee.org/ethertype/eth.txt
> > > 
> > > 
> > Is this actually registered with IANA?
> 
> No.
> 
> > https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml
> > 
> > Does not list it. Please keep the "NOT AN OFFICIALLY REGISTERED ID" if
> > it is not.

> IEEE is the official source to use for ethertype number assignment.

What i want to make clear is, if IEEE officially allocate this to
something else, this is an unofficial allocation, and the official use
can replace it. We have a few ID like this, and never had a collision
yet, but it could happen.

	Andrew

