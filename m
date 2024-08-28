Return-Path: <netdev+bounces-122804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A649629CB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815B4286136
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342418950B;
	Wed, 28 Aug 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6byQ/wbC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337818786F;
	Wed, 28 Aug 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854058; cv=none; b=O82OX0RFOpGK1v+YMzztfDWYQZdcZgz9X1ynB4QAfuQ4xctu6s8pBlJoXIOJw0l1M1XKN3qYaZZFNPW5ySimwHqKwHj4R2V+FpaFudLjNJ4EsNgfb++aEnToyYYVLDa4gRzDvovy3GvQIOqpTmXwCJ2R3DYXwmmxa+5Q3ZPXxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854058; c=relaxed/simple;
	bh=Bd2Wxt6zHJwlx4sPJaTHqzex9WFh//rgwLGxTuqWQ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLeqflCJefYCVrGfLHLHAVYMf/ugSoyw2dw7asWCN0kv3F/h1BY5iT05UWlnRXfGFJjY1c6sAXw3qSggEq7Lg84EEWdaxmLJhtlK67CW/Xggn5HkNp9OLM1pcW3dt7NNABVCQN1KHbj1CfoQFpUWAoF/0/bbmqcDtbhEi4UKnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6byQ/wbC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wpfyIY3nZ/Sx2OxvbMJNMrQWF8Mem+SaqGMgbnAyKng=; b=6byQ/wbCCzwkVpi2R6ZRmtdCsT
	PSbkV+60RMmYyLb79fpKZ3M+I4ZpIj34Gc7k5rWTVGyljHZWo643VupvpvdvUgV28I9ZSVgAC3Jtq
	QAP4BeWVw8k/Z7sakKczGZ+zROvPUfBmd4HhsRGVke6v8AeGi7bYJutpCNpRXVvEWJJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjJKT-005wMg-Kn; Wed, 28 Aug 2024 16:07:21 +0200
Date: Wed, 28 Aug 2024 16:07:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Modify register address from decimal
 to hexadecimal
Message-ID: <a0dfe854-c479-4165-a16e-4e4a1b2a6200@lunn.ch>
References: <20240828125932.3478-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828125932.3478-1-yajun.deng@linux.dev>

On Wed, Aug 28, 2024 at 08:59:32PM +0800, Yajun Deng wrote:
> Most datasheets will use hexadecimal for register address, modify it
> and make it fit the datasheet better.

802.3 uses decimal. Since these are all 802.3 registers, that is what
you should mostly be looking at. You only need the datasheet when the
device breaks the standard.

This is just pointless churn, so NACK.

In a driver, when there are proprietary registers, feel free to use
hex.

	Andrew

