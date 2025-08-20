Return-Path: <netdev+bounces-215315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2AB2E111
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F9F1CC336C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603A326D4A;
	Wed, 20 Aug 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH1PwNQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA92DFA32;
	Wed, 20 Aug 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703042; cv=none; b=JKpt+bAJmL4Lj0cFPFKR5SuyZpIBsC4ViI/+ClCkfQX6ZNvtm5/L8nPorolq0gxVvwc4LCwoaDoh3PMYRwCOk8XqqTU1lla/Xyyr9/uZqyhxBf6wStmItYWsioFNj/qD2u2JkuOhhG9cHLKcp47x15xxySz5j++3DYMNcsiBb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703042; c=relaxed/simple;
	bh=3xBUF+BWwJM7qSsKwpiul03BoYr/LpWrwpzsBn6ACwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfxHniXdqaz3naAf1YnYNQ/ZXaCmjPguj73i4KtlbT0xVlgcL9KIuFfVr5P82LvpLrAbCzysYMIVIV21iA3yFk3L99c5fa1evwiiH5fNXeWqhja3NWx2zgQiEne0xz9Y6f0NzyzF2RIRCYGRMUF/+1d71hTdRx/STjiokErIBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH1PwNQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314CBC4CEE7;
	Wed, 20 Aug 2025 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755703040;
	bh=3xBUF+BWwJM7qSsKwpiul03BoYr/LpWrwpzsBn6ACwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VH1PwNQGT00FXG2CXvfg2tHTLwPZXUcMLOvrJZ235B2QpffjjZCe14A/xHRMZP2eQ
	 BlwCBH4RbBCnPPlSJHkE5hlIB+sEYnJWPZaNnqptlC4KaGgvu3Pe1rd0vwX3oH2wbf
	 E3KqOtxcCspCqh/k18uMbkQa9JHyqSa8I00UQFgCZ+qoNllYA4pmC3LLwtv46cdLZH
	 UoNiESFusfexcC18UrOUYeplng2tnbkhJ7peQNu0bcw8hNY8qSS+oW/4Ckmt/1BUXx
	 WkYJXRDZ8erBsmxrwGTOGSfQPW8ClaoliCH883+r1ibbChjMfD/9rxbuKM+8yaa3mf
	 cjzYlLvglvz8w==
Date: Wed, 20 Aug 2025 08:17:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
 andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, robh
 <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, conor+dt
 <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, richardcochran
 <richardcochran@gmail.com>, m-malladi <m-malladi@ti.com>, s hauer
 <s.hauer@pengutronix.de>, afd <afd@ti.com>, jacob e keller
 <jacob.e.keller@intel.com>, horms <horms@kernel.org>, johan
 <johan@kernel.org>, m-karicheri2 <m-karicheri2@ti.com>, s-anna
 <s-anna@ti.com>, glaroque <glaroque@baylibre.com>, saikrishnag
 <saikrishnag@marvell.com>, kory maincent <kory.maincent@bootlin.com>, diogo
 ivo <diogo.ivo@siemens.com>, javier carrasco cruz
 <javier.carrasco.cruz@gmail.com>, basharath <basharath@couthit.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, pratheesh
 <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, praneeth <praneeth@ti.com>, srk <srk@ti.com>, rogerq
 <rogerq@ti.com>, krishna <krishna@couthit.com>, pmohan
 <pmohan@couthit.com>, mohan <mohan@couthit.com>
Subject: Re: [PATCH net-next v13 4/5] net: ti: prueth: Adds link detection,
 RX and TX support.
Message-ID: <20250820081713.2d243c55@kernel.org>
In-Reply-To: <1714979234.207867.1755695297667.JavaMail.zimbra@couthit.local>
References: <20250812110723.4116929-1-parvathi@couthit.com>
	<20250812133534.4119053-5-parvathi@couthit.com>
	<20250815115956.0f36ae06@kernel.org>
	<1969814282.190581.1755522577590.JavaMail.zimbra@couthit.local>
	<20250818084020.378678a7@kernel.org>
	<1714979234.207867.1755695297667.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 18:38:17 +0530 (IST) Parvathi Pudi wrote:
> > On Mon, 18 Aug 2025 18:39:37 +0530 (IST) Parvathi Pudi wrote:  
> >> +       if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
> >>                 enable_irq(emac->rx_irq);
> >> -       }
> >>  
> >>         return num_rx_packets;
> >>  }
> >> 
> >> We will address this in the next version.  
> > 
> > Ideally:
> > 
> >	if (num_rx < budget && napi_complete_done()) {
> >		enable_irq();
> >		return num_rx;
> >	}
> > 
> > 	return budget;  
> 
> However, if num_rx < budget and if napi_complete_done() is false, then
> instead of returning the num_rx the above code will return budget.
> 
> So, unless I am missing something, the previous logic seems correct to me.
> Please let me know otherwise.

IIRC either way is fine, as long as num_rx doesn't go over budget.

