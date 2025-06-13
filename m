Return-Path: <netdev+bounces-197591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D01EAD9452
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D56B1E479F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DD822A4E9;
	Fri, 13 Jun 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZN1elzUs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5241BEF8C;
	Fri, 13 Jun 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838906; cv=none; b=PO9wj5GsexH2QHH7IhSchCUsZxQKgH7RHIfrFSI1ZBjiDHuH2GRt7H4F1WFNykM+OIABxy0ozn8FbsJNwVh4MeiolUJQpHGi6If995i4K5mCsKwPUgKcYQkCny+XuV6Uz6QTr0gJAGATxyPJXs+9ELPa+4uVcqxFbye4BHWCBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838906; c=relaxed/simple;
	bh=vAtV7ikW5tcJZwdm/Cb1YO8EYEej+nCVNSEfvVwc+lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7lS0SC00MA3wDU9hvc9ylJclzsa/edz+0L/19p+t/Edj7pD+suhDLKVik6ZVIZVIkQro3NMyBUTu5vpkDEQwjcLuxrSy8vcK0ylIzN4RM+9Eak6Cw91TXtJFRvRM8jPWq17zuj8cOYwRL54RFBojB8eJJZkKulDXnlTCAhlLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZN1elzUs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RHytfg0Q7NhA5XEV7W+it0U6RvqSCKp78LX18G8sBoQ=; b=ZN1elzUsRvQKhRL066iraF6S1C
	iCQ5JuSXeCh6nVmVK3tu/Ayiz2+nyK90yh3CC0cYfkP8713yVE1PJ36Fm2VUq4v7eGtGW5FcvrI8w
	rYUWvMjCNddJ8olJ0hZ0WQ5RoEmFFfiprfRisBSPvDYqNrX844V2Pa5CciN2jZZXw7j0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ922-00FkpP-54; Fri, 13 Jun 2025 20:21:38 +0200
Date: Fri, 13 Jun 2025 20:21:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH net-next v2 02/10] net: fec: struct fec_enet_private:
 remove obsolete comment
Message-ID: <fc595d0a-619b-4121-b61f-25f6abee98fe@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-2-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-2-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:15:55PM +0200, Marc Kleine-Budde wrote:
> In commit 4d494cdc92b3 ("net: fec: change data structure to support
> multiqueue") the data structures were changed, so that the comment about
> the sent-in-place skb doesn't apply any more. Remove it.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

