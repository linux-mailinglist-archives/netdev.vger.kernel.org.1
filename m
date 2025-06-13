Return-Path: <netdev+bounces-197590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E163AAD9450
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122041BC2C27
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B522CBFE;
	Fri, 13 Jun 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MIcFN5Qh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B11BEF8C;
	Fri, 13 Jun 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838849; cv=none; b=lM5VlzJYs56A9YevqAKgar0aleOFVKy5tSmlXRA6TteTlban7X5uqoXEjpMHyGE3A+QLXsDftAvYhiNMjdorrvMepJSU4ulzmnuMnHTTqPpCO2/9nhqe0yhvlmXLlYRPs/JcxOE+NGh/kY/kvIeZEXDatD8HaYogWuQJKdMIw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838849; c=relaxed/simple;
	bh=/aRcQHvCDeXy5ITDLTeAMIMFQZLyhCB4RFViN1tqojI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFyw5SCgM9QxbcFuNWx08EmqMbEMveveqyYe04ZzYe4bJvT1aX54TIo1B7fTDunzBSAbHmfjC1BCLATVtb3VNxNTIc3y1NKevrNPisHCu27/hkq0/YPpQG8CHulbJE4LPNdHsuQQ5a9my8z4dX6HTbk2n8Ll/ghedkapPis/M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MIcFN5Qh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yXuJm80wk0zdthKYpOIbl/aCp7aaEporSjZhZbrM6vY=; b=MIcFN5QhLUSQKLTfBlaQJMJwss
	0P/f8RRbEc0d+sxDVt9PA0jmfhi3jysbZiYEysetVLc00/ECa9Jx04HvsKn9U2z+rl4sERuArs6Zk
	OJzQuQ/NVwTYi1ftrond7PDMtpAt2B+agO0eAIPqg/pcR3RgD3aLHeMemqCxYEFwOpe4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ90t-00FkoI-R3; Fri, 13 Jun 2025 20:20:27 +0200
Date: Fri, 13 Jun 2025 20:20:27 +0200
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
Subject: Re: [PATCH net-next v2 01/10] net: fec: fix typos found by codespell
Message-ID: <fe2bfd09-fa7e-40f3-84e1-c7bc88df466f@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-1-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-1-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:15:54PM +0200, Marc Kleine-Budde wrote:
> codespell has found some typos in the comments, fix them.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

