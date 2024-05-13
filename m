Return-Path: <netdev+bounces-96156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787F8C482D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151811C20CA5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A807E575;
	Mon, 13 May 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yRKjcqLT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87857AE5D;
	Mon, 13 May 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632005; cv=none; b=kamyyPNcz9n9lyCm7gdxL0k4v67AdLD7Q+VBtBhAz8bbla7uxljFukhQ52kr1EqRNQ5OgX5hp7goljZZ/2/D0IJUKmi2ifQYalyLvAoZJxtSGiFAktSYfrKa85HLbPxDTuJ8DGVjyBsn+tjfsPw6GBH5rShB6FkOf/s8bkD5EIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632005; c=relaxed/simple;
	bh=VNEzvjA8rLwZG4zn5sjyLB2KhundQsyggo28iU3zm20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRp6gD8kzWnKBO7MpThUH0iyA2h+60cwqst6CHpvPl2uTQiaJYMkqkM8sUd3zxkQeP8NDMHBsEl7XF9X28FT2mMLaqeZU3GRfTjWxsQPMAvjfrTjD0rRC0soEWlmu/ExTeLu/cMUXjD4JWBx81ojFvYR4oVSox3sFVJW0l8a894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yRKjcqLT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gcTnuspTzcXG4upolGwGV93OP3g/85J3TNVtbNWq9DA=; b=yRKjcqLTVCPpyMC1N/BQilmMAg
	6JeUvm+AXURNc8QMCO3JmUx2ERzhMAmu+1o+lNWCVhtT+Iy6XOnEzivqSizTVZu9D9A2DDRZ9uWxI
	SXXGG0/NhdjUErhNKAHRd2OIrSN3qwSienA3orbizr5k1d45PnHDGs/6LJ0zsdgYZZ8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6cFh-00FKm1-My; Mon, 13 May 2024 22:26:29 +0200
Date: Mon, 13 May 2024 22:26:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: admiyo@os.amperecomputing.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mctp pcc: RFC Check before sending MCTP PCC response
 ACK
Message-ID: <9e893038-e78e-43d9-82b3-c95cd7b51f18@lunn.ch>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240513173546.679061-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513173546.679061-4-admiyo@os.amperecomputing.com>

On Mon, May 13, 2024 at 01:35:46PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Type 4 PCC channels have an option to send back a response
> to the platform when they are done processing the request.
> The flag to indicate whether or not to respond is inside
> the message body, and thus is not available to the pcc
> mailbox.  Since only one message can be processed at once per
> channel, the value of this flag is checked during message processing
> and passed back via the channels global structure.
> 
> Ideally, the mailbox callback function would return a value
> indicating whether the message requires an ACK, but that
> would be a change to the mailbox API.  That would involve
> some change to all of the mailbox based drivers.

How many mailbox drivers are there?

Generally, taking the path of least resistance will cost more in the
long run. It is better to do it properly from the start.

    Andrew

