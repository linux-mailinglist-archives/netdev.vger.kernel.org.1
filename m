Return-Path: <netdev+bounces-249874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAABD2000B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ED5C30001A0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF453A0B16;
	Wed, 14 Jan 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tazNDxBv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDA36C593;
	Wed, 14 Jan 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406170; cv=none; b=aV9xGuypt0XzwrZMLpq66t4Met1BDojdXe6DvChlOVrcPBw/Uq4bkLxAsjn1EzIByCyDRFU9HAfISVFOcls4FFf1xWNIEFIJJ+NiacqylPOmtrGTA+qKN7dJM0b+4qyVhfy1hPAovdzwccEg2w5NYg+YwBZUkrsJZunfvJhJ0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406170; c=relaxed/simple;
	bh=Ae1ieq+fhLkuJ+oyltSTjOyNtG71Vuue9fYPvx9QIpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN2jc46xY7fiT4xn9fAWEqUxSWzN1RxLsMHlIBdUuhplGe3ZJZk6xyll5JJUpDZBjuVXrvDqSPqHYLwA343loMRktp48+wOvBKj7nX5JrQaHezh1R5A4iTjLTjsRil1aiebpJChT1q7DletxjASXgzfXDnD3nP01cVicVjiNhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tazNDxBv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HPhK4KjjnRqSs9b7v5hKWxDnIeNV27SBK22m7p5AFTc=; b=tazNDxBvsypyesjPwJzb3+PoQj
	S1+fjE9afh3Fm7eDFKgSWZSnz6l0FiNtvJ2DoNbLQPALi7MloHXcbj2qGjVl7zv8OXNEmYjZjQv/v
	/Bl9JUgwpdIIOerJq7150ZXOF867L7Z3nkoUb3Xbq8iivwWFNt8DRZPQgH7Sei/7gnug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vg3E2-002ocm-8m; Wed, 14 Jan 2026 16:56:02 +0100
Date: Wed, 14 Jan 2026 16:56:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>

> > Yes. What you plug into PCI is not a part of this hardware, so cannot be
> > part of the compatible.
> > 
> 
> Thanks for the quick response. Just to make sure Lorenzo doesn't get
> confused, I guess a v3 would be sending v1 again (firmware-names
> implementation series) with the review tag and we should be done with
> this.

Since this is a PCI device, you can ask it what it is, and then load
the correct firmware based on the PCI vendor:product. You don't need
to describe the hardware in DT because it is enumerable.

   Andrew

