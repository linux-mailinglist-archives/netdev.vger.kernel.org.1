Return-Path: <netdev+bounces-153143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D59F6FEC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 23:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7FA7A2E10
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC841FC7E3;
	Wed, 18 Dec 2024 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n1yyk4+T"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAE198845;
	Wed, 18 Dec 2024 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560063; cv=none; b=Z2QxW/3xqxgONPrCLTXuq/mx4/8xXwhs9oaFuDt8v29zS3/wWLtfbVMfolqbikqT9/q3AauesqJ1JEueHYmYCiBDc7/ggYbxOuRCQrdotqEbCBBFJUgbCz6MI9vm3fURzAp556OVPWwlsT5FitCeEg8MyVl3Kpi0EAXBIXWl23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560063; c=relaxed/simple;
	bh=pBAjRf6/7ZtcePblB6Y/dqT4Irvg6nS6xuOSXcKuDkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+agBZ96kycxPh0u4na6Lo9M31o9yfYggrhT+8y8TMOdZzo30/tJfE6eB4u7+xNods8ElJH6yYDWsn3i2RGQySD6/giBsoIP2nzAuU7K1E9YFo8WdiSrEmfoANY/nBMXjeEUsr8hAJwc5oZ66sUGt0Hb2JefrhuYrXTG5y5ATFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n1yyk4+T; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=4NUia+wIcaKIZ7/rgsmAY6MfPqCs64GQoJNfdsBZX9Y=; b=n1yyk4+TeTHQ1VIX
	HHyBNxP4Tc2GXGbubEviAkmy2FfoG4Uk4SF1AvgWKxVoRkavTV3L1IXYxK0Pdxnh1JBpWoIRFqX69
	QR6V9xxfvjluirMgBPCAKcMrmwPlgJFPsg6h6bED3KDuuQPrKwIaeiuB1WPkJszbIbJ5wjzNL5EXc
	BXFdyiiSVo88QAK/eq0VQ2WtmASlHhgT7j7cbW0h52Dk1tC4AnI1vZqnKn6EirUPMEKyIdbLNgk1T
	1xq412Mw8DjDkWM3a/4WXpJNL59v7rXlUNM+gkfenX3K4xHlFEOiL3ellvkmH4GnUjHVMuH3dKyA6
	ln2OP9z45wJRfng7ZQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tO2J4-006BkG-25;
	Wed, 18 Dec 2024 22:14:14 +0000
Date: Wed, 18 Dec 2024 22:14:14 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove bouncing hippi list
Message-ID: <Z2NJNmoTV7sLC9Qw@gallifrey>
References: <20241216165605.63700-1-linux@treblig.org>
 <20241217105102.GR780307@kernel.org>
 <3500c9d7-2b81-41e0-985c-7a63bcb87723@trained-monkey.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3500c9d7-2b81-41e0-985c-7a63bcb87723@trained-monkey.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:13:38 up 224 days,  9:27,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jes Sorensen (jes@trained-monkey.org) wrote:
> On 12/17/24 5:51 AM, Simon Horman wrote:
> > On Mon, Dec 16, 2024 at 04:56:05PM +0000, linux@treblig.org wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>
> >> linux-hippi is bouncing with:
> >>
> >>  <linux-hippi@sunsite.dk>:
> >>  Sorry, no mailbox here by that name. (#5.1.1)
> >>
> >> Remove it.
> >>
> >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Thanks David,
> > 
> > I have no insight regarding how long this might have been the case.
> > But this seems entirely reasonable to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Yes sunsite.dk has been gone for at least a decade

Ah right, you might like to fix the Acenic driver entry as well.

> Acked-by: Jes Sorensen <jes@trained-monkey.org>

Thanks,

Dave
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

