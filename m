Return-Path: <netdev+bounces-71775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93C8550B2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EB61F21731
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFDA126F32;
	Wed, 14 Feb 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NvB7UOVv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076A7C086;
	Wed, 14 Feb 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932869; cv=none; b=VlFooZJQzAanXuIxYhGmKbQBz30Q4vTjDtXFVmirKMvE1Pc6Lmttso/jIIFk+jNw3NOlVTHlj9ar3mzgLpMai8uNACcDJGVkVRowb9AgWk/tmaua2TdeypFAWtZNzFX0g2FGkLCuY335TcIuWk7tHWBd1n1JzX9pXJFhpIB4NwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932869; c=relaxed/simple;
	bh=KlUBQqK+6n3jqOyvX5qVxvbuW9H8Qor440P3GLbiFHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joIwv+rNF0BaFXav7diaZE681k0WX85XKSje4u/mB5Ftwzxry1Z7BSEtF9sa0gK7K147IZgxPPPPl+ZNeBbY3fkUF7NpvnPjOA6un9MBV3d3GfK2/s9sAnMaFfxIcW21GtlkqhX8wT30Yr7M6kV4KidXhZ5vggFluySHIRyA5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NvB7UOVv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4AgW43/ZPNVaqgHs/W1JnLiMLuTKT90hZrZhRANHsgY=; b=NvB7UOVvlodUdCe1w+BPn1pjlO
	avg7DROE34d4tfi5IoIFOGyhHZhRpNY4V5es2VAovOXNrPb2C7hTLqoxwHxnmHTbJlmjg0crw5PPe
	pY4svyrXh8+RBxDOFQ1iWItr0c/OU/sEAfBgUZ3bXVkaoWmW0FY/cKuKZFZIXEYLWhz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJMG-007oOH-Tp; Wed, 14 Feb 2024 18:47:44 +0100
Date: Wed, 14 Feb 2024 18:47:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David <david@davidv.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] net: make driver settling time configurable
Message-ID: <2619af18-257d-4673-b74b-206ed8b2527f@lunn.ch>
References: <20240208093722.246930-1-david@davidv.dev>
 <20240208095358.251381-1-david@davidv.dev>
 <20240209135944.265953be@kernel.org>
 <7485f0b2-93fe-4c82-95e8-5b0e10f9fa7a@lunn.ch>
 <ee37f457-3d2d-4c18-b22f-dfb315b3c078@davidv.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee37f457-3d2d-4c18-b22f-dfb315b3c078@davidv.dev>

> Would it make sense to move this to a build-time configuration flag?
> 
> I do not have a gut-feeling for which behaviors should be configurable
> 
> at build vs run time.

If it is build time, it becomes the distribution problem to pick a
value.

Might be best to just bite the bullet, set it to 0, and fixup whatever
breaks.

	Andrew

