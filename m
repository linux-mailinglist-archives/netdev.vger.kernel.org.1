Return-Path: <netdev+bounces-142465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8719BF452
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4ED1F22ECC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276D205E11;
	Wed,  6 Nov 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gcNKZ7i0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AF26AFA;
	Wed,  6 Nov 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914342; cv=none; b=Uf2ktlWi0RJKHjBXa/b8eEk92zqTgLu7WPGmZhe8vvZsRF+Bra8aMf7TC3skvJ/Anxr9lkCbYIGkRho26QSjI8h9gN3gljmP0tVy3EbUQtpkH5bXB6Zz24Kg/HIDJSB2hmJWjqcqfINeYCSvRDzK8t26R6ty8lafjptREy4DKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914342; c=relaxed/simple;
	bh=i+k9vjCFv3LU1RPAjVEeMMk8SXDWCo+j5ZaGAu7lfjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeFM7WSeH5Lellpnkk9ayycpQcqmX1Vg5Ns5LhwM5RW0tGp/cYHYraiOpOcAdaWaQ+ZQ8rsxrH+Bf8ja3nKusqYbC/siq4mw0r2JoAoWSUd3OkNi1+kGC465GqsVPhhAXS8JjlDLb4bDckXiIdMmcDHnQo1m6kDTD5aFGcJgjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gcNKZ7i0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yq9pHwwDX9h6c6DAIXavhiSq0K9iQ69fUsgE1qHT2I4=; b=gcNKZ7i0kN3GNPbf5drsTC3sgY
	M8LVxx5MMrxE8ZOH4Swmw664vphhFS4HJ1DE1khsCAt8X1RCAGjPkqFF2RB7ierelWo7eduKcjm8i
	Tul5WL+Gd8Xhh4gujqXAcaT84kGlm3d5H4FCVLAwAqrOcDygLnd7dSpoBcvo1JbYMPXc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8jsv-00CMVl-QN; Wed, 06 Nov 2024 18:32:01 +0100
Date: Wed, 6 Nov 2024 18:32:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <683c8ffd-6766-4ad3-8049-0defaff7295f@lunn.ch>
References: <20241106002625.1857904-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106002625.1857904-1-sanman.p211993@gmail.com>

> +struct fbnic_hw_stat {
> +	struct fbnic_stat_counter frames;
> +	struct fbnic_stat_counter bytes;
> +};

I don't think this belongs in this patch, since the PCIe counters
don't seem to have anything to do with frames or bytes.

	Andrew

