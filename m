Return-Path: <netdev+bounces-126535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31B971AF1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3F62894CF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA071BA299;
	Mon,  9 Sep 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TVDOwMsS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C21BA291;
	Mon,  9 Sep 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888298; cv=none; b=DWUmujdPFlj2GOsCTYaze/jyRlnFNxfjlu7BiATRVUWaszJa3sHhIf8xNZQ6H9VLGuqlXCkRx+lhaLrQh62sw3ks/unul7Zv+8IjtWq9Yn0LhZ4MMi45jetuS1KO9HU1RKZg1ZPEA1pBKEtKX2R8IuwEwC/tp8NypYhxHhBjXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888298; c=relaxed/simple;
	bh=cWASmPJKYo9KaxiPt7WZoXrEl6Mjti954nwaDZDr8Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3XSyph98niVXwkUp05/QuBvqtZRW/wOO7/7C0xfCWZZ4KRTlB36/zEBUkXKPG4s3DjAwkuaidnEOXdUlpRgI4jPPZ1PrFRikKzkM59Iii4y9tcWVYgaMxvnMGhfLnD1Le/NkuXhZBrit6fnnxBVerWrxQDXLmRyvS0N2RblNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TVDOwMsS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GCr+2LselaK9VHQpuc9fzJDraSlRwYUwU9L2T2Mh7R0=; b=TVDOwMsSH9fRM7dEq4UYptFV8V
	CQzf1MXTOXKpd5qcyTRRdY/7nttaiFTgQIU8w2qYPqUKZTDQIs3RkF0vGq33IzmGq27rrdbmxF9Ox
	jlOLtQKrAEqjdOsip8jfvHTWoclt5rxnzTY9VGml2Ono7BoCoo/04pscMd8tRJNaILjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sneNt-0070f0-MG; Mon, 09 Sep 2024 15:24:49 +0200
Date: Mon, 9 Sep 2024 15:24:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohan.Prasad@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	shuah@kernel.org, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, horms@kernel.org,
	brett.creeley@amd.com, rosenp@gmail.com
Subject: Re: [PATCH net-next 0/3] lan743x: This series of patches are for
 lan743x driver testing
Message-ID: <98fcb7db-4b9d-4ee9-9840-fef43825353d@lunn.ch>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <7cbdcb2b-37d8-45b6-8b4e-2ab7e7850a38@lunn.ch>
 <DM6PR11MB4236D1B92E9FDF1A4640DA68839E2@DM6PR11MB4236.namprd11.prod.outlook.com>
 <96e017b8-3702-4b39-a44f-91c8b4ebec89@lunn.ch>
 <DM6PR11MB4236A76EB9FF90303153A83083992@DM6PR11MB4236.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4236A76EB9FF90303153A83083992@DM6PR11MB4236.namprd11.prod.outlook.com>

> I am currently working on this and would rework as soon as possible.
> The feedback that you provided is highly helpful and I will remodel the implementation with these points in mind.
> Hopefully you can see that in the next version.

Great.

Don't worry too much about link speeds you cannot test yourself. If
your tests happen to fail on a 10G card, i would expect the Maintainer
of the 10G card to debug if its the driver for the card or the test
which is broken, and then help fix the test if its the test.

	Andrew

