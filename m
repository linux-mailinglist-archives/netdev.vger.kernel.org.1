Return-Path: <netdev+bounces-131086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4B98C85F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7CF1C22880
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717F1CCEE6;
	Tue,  1 Oct 2024 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DYTpGHb3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CE1BD034;
	Tue,  1 Oct 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823099; cv=none; b=oOsZ0FSjOyRXmmukWWvoWk0PK2ii8L2O41uOfFCu5gto6fb849Dgtkk7TvCBvJg78/WF3u+k3d0oxZ7WzBUvyffWqAp98wHYsfhY6V7iq7PjDe95t+yVXuBFFyhp5Ae59mB5uVZwilf+a7wn0zAbtRjTiKw/7EnaGOvrv4hA9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823099; c=relaxed/simple;
	bh=Z69HaACIO8mM6vKo2IbfqVhisIgOdNK0vCsBHexvWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T73supn5yRPD3o+ddmUXL3xkOKut0XTVM8YO6aPBZZHPSakIslNdGn5rvYaThMHFbuP6Sw2N1yp2v68Fla0U+orwXzIzqu9hjtnaL+DGgQIqogS7GYWXoO0jeiUbriexxZDHyjaajqQ72xiDxZ+nd05/FQnx6fBQI1tiP5y0PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DYTpGHb3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4EwAmtyAZo4xblAF43oBlLKK+Nv9dn9BFqz1yX0+dQM=; b=DYTpGHb3Oqm0us24PqV85I+PwR
	uMGNIAv0WCOD0P3XfTwRqgWtYOb2lj3v3L8XS0u6fnm+daNallfeq9t/Jcpy5qU4IwBLB9d4+tL73
	qCIWLAlZkvocIF7xjp3TEYACMbtJOw6z2DAOjc/1kDu3l58IPNQpgT46wth6M/AGHP7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svliL-008mdj-Vb; Wed, 02 Oct 2024 00:51:29 +0200
Date: Wed, 2 Oct 2024 00:51:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	olek2@wp.pl, shannon.nelson@amd.com
Subject: Re: [PATCHv2 net-next 04/10] net: lantiq_etop: use devm for mdiobus
Message-ID: <9700b135-d546-4b84-8205-00ff19c70d3d@lunn.ch>
References: <20241001184607.193461-1-rosenp@gmail.com>
 <20241001184607.193461-5-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001184607.193461-5-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:46:01AM -0700, Rosen Penev wrote:
> Allows removing ltq_etop_mdio_cleanup. Kept the phy_disconnect in the
> remove function just in case.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

