Return-Path: <netdev+bounces-246419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BACEBAD1
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37753304C6C7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40E2D660E;
	Wed, 31 Dec 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aPb+y4Td"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AB31197A
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172685; cv=none; b=kCeBCweFRYyNs6yChK0o1TIPDDgQKD3/0EQxG6LO1FMqBAryZEx6MP120+kLoHWOrkpYZrWBxK8gkwTJOUulysp112ohtI6Jkj/IoEa0BUYm60qgiw8PpRgGxY0hv1NQ79yeShYrOcZw4GE+WqZw0FoTeSPREwI9R24kIDxxGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172685; c=relaxed/simple;
	bh=9rJhp+g1yfy3QOyrwi5lgNi7Q72EcEya9lrUQ0i1ZYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE92rvlOg3dsPyA6g/UKOqm2m8QW4ViOvAyphYpgeCWrH4bnCfPjTnjG8Scor/oo3MNYcg7vHwWz+OV0orkugHjpQI87pI1IOaCWh1hK+j8iLtaxcmQDrCa7bDDlCqgAmiVBvTaH/MtqS8+GnhbyTxRTm76Ia5vB0oF0F7pUKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aPb+y4Td; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cEDq4UUrr1dPuAqdPQ0wx3p0plA2OWEZASAD46DslKg=; b=aPb+y4TdU0+ElGlLpMSeSvEk4n
	R+3saTIXIOi+ld4Abfn5HvZsQdyUTRzgCFa/RNR9kXY50Jd+/oaMTFGR6LjTSA4uhnypsa+Qhhvz4
	+Rw3aRUCxVB/zfTRE1EGRO8PHTzpT+n0H2D5pmlknv4i0bTouRmk7NlqCpEIHhjdgQOE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vasLA-000wKK-0I; Wed, 31 Dec 2025 10:18:00 +0100
Date: Wed, 31 Dec 2025 10:17:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net
Subject: Re: [PATCH net-next] tls: TLS 1.3 hardware offload support
Message-ID: <8a1f2ee1-ef5d-4104-8659-40dcef26093f@lunn.ch>
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
 <20251230224137.3600355-2-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230224137.3600355-2-rjethwani@purestorage.com>

>  int __init tls_device_init(void)
>  {
> +	unsigned char *page_addr;
> +	int i;
>  	int err;

Reverse Christmas tree please.

	Andrew

