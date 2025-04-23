Return-Path: <netdev+bounces-185129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F5CA989D7
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E9316610E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910C21770B;
	Wed, 23 Apr 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aXlRr6ij"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145E21A445
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411649; cv=none; b=loXPaQVG4dxzW6lL3zLspbc3ddPqK6WbRT6E8/9GGE+A6LRBIaA/F67o6b+FOLhymEv4nvBznr1s47C8zvp0LmK9fhhBtAJ7nnmZJT35lbETX8N5KP0cf2ExHjIX1iDkMfvx5FvF0Hfy1zeIg3j/2QLUSSzmZr3ntmJ7asP4XkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411649; c=relaxed/simple;
	bh=GmUd7JkjXZnCgzcXByq82ijMTKmfUlAAzsW3W6PVSMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyCUJAtGyc+eqBMSvaTOyUo0EK1vXj6T9WtjJQhabYfbXSiZZZ5S3kVydmLK8S1f8CHS/ELf/vrdXSsbRvmweV57uD6ZOnrcjWE5vQJXWli6psEwbg4tX/frfy0KVJwjO9eelkNXNtN54JzjnP3jVEfFGmLmyFs4r663AdW3gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aXlRr6ij; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mZcVtjxFegrM6dbcFtssvf6c4nIJqw6D4EsrjB0RgDo=; b=aXlRr6ijQxpFXBlXySoxRaVDPR
	2eoPIm6MB6Rqt5rNpdtKKytqfQjIVjQR9a3Sif8QftLJwG4iXnjqbxe250W/yPWvniFgb4+nxe7kY
	a3c8Yw+CuhWRstpfMtvzmp6ct6aPjnrYlhs9Rps7fk4grpHO49nreQM7lGuPAeDEQxbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7ZIi-00AKxZ-M6; Wed, 23 Apr 2025 14:34:04 +0200
Date: Wed, 23 Apr 2025 14:34:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David George <dgeorgester@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	jasowang@redhat.com
Subject: Re: Supporting out of tree custom vhost target modules
Message-ID: <ff6106ce-f0c9-4dc8-9e97-14c44b0b1036@lunn.ch>
References: <CA+Lg+WFYqXdNUJ2ZQ0=TY58T+Pyay4ONT=8z3LASQXSqN3A0VA@mail.gmail.com>
 <20250423060040-mutt-send-email-mst@kernel.org>
 <CA+Lg+WFSwHD5UMC=vQRGm+x3oG69nDFkJqkbzJy61mOJ+VTteQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Lg+WFSwHD5UMC=vQRGm+x3oG69nDFkJqkbzJy61mOJ+VTteQ@mail.gmail.com>


On Wed, Apr 23, 2025 at 12:48:59PM +0200, David George wrote:
> Thanks for the response Michael.
> 
> And apologies for the earlier html content.
> 
> > See no good reason for that, that header is there so modules outside
> > of vhost don't use it by mistake.
> 
> I suppose what I would really be suggesting is adding the possibility
> of a driver outside of vhost/ being able to include _something_,
> enough for it to implement its own vhost target.

Putting the header somewhere private is a design feature to stop the
internal API from being abused.

Now, you are creating an out of tree module, you can abuse anything
how you want, nobody cares. You can simply say your driver needs to be
built against the kernel sources, not just the includes, and you can
extend the include path to go deep into the tree.

	Andrew

