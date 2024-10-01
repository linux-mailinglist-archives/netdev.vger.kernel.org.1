Return-Path: <netdev+bounces-131076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9D98C830
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A21E285EB9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938721CEE80;
	Tue,  1 Oct 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ybKWwSjz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF811CBE86;
	Tue,  1 Oct 2024 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821472; cv=none; b=YoieKmihnjtfFmJ6pJ4j15e3bTFHOg2pYyG7lMG5JudjelTjI7rrZoEgfgpWQQeVmUD63QGKzN+zbpTyxHG+VaXtDWhGkiUm+zqm4crDssd7Q9DoV50kDpfT3UHDS1dPVFtkXlsuvkiEhI1KJBZAEaocemLtaOj0hizBHDp1bqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821472; c=relaxed/simple;
	bh=uc6Mp6kPUv3MmFOChXXDBolLcyb+hQcrEIvuBkYPYrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8th6yH6FCzj3hf8G1usL3/cNVI5OcCm+JzeQ2XidC3cB2zII+8F+k2vo3tVCCjrjI940sFRBTsVnlgauwfyhBlapUsUKc3RpPAwo/mzU7kgTX4p2N03JLIABb/Z+0a895vpZOaIRmJkUXMmjuKwL4mhhCEx3++9QCULAWBhJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ybKWwSjz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W5kS7flzgHmzQnvGcq4iqgSNYZpXcpeHPnbr1xLtZ/M=; b=ybKWwSjzkUhPiPHQrKGOE/01/C
	G9gKWel+utxOFn6gbCus1NZTwRKgZ+ti1ZST3NFBKAF9pUoHE6bVfb0uR/PYdhy6UDWSMd3vUQTPH
	aE2FseQ+jBRRLE6/NNF2I5889bNs+dgaFYYLFoZsZ2Paslp9KNoKyOfseYgqXMmWTKsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlI8-008mV4-7B; Wed, 02 Oct 2024 00:24:24 +0200
Date: Wed, 2 Oct 2024 00:24:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: Re: [PATCHv2 net-next 2/9] net: smsc911x: use devm_alloc_etherdev
Message-ID: <b5056d6d-ab14-493c-b29c-39eb95114965@lunn.ch>
References: <20241001182916.122259-1-rosenp@gmail.com>
 <20241001182916.122259-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001182916.122259-3-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:29:09AM -0700, Rosen Penev wrote:
> Allows removal of various gotos and manual frees.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

