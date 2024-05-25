Return-Path: <netdev+bounces-98076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9418CF1E5
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA87281635
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 22:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D28127B60;
	Sat, 25 May 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NilA3JOO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DB22075;
	Sat, 25 May 2024 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716677056; cv=none; b=u+cZfwtru0l9PMwOToWG3nmuV6EWBBD9+QAgF95iNLN2GeOwvEw7lN014IAoQiPrUwu7oSlmBj45XFia6RIiF3Uaffrg6Q4l2/tbG62GRiMPvcSJJ+fqug2QL/gHlvcb54eUCOBGxAlmBp5ogSpqox4mQh0thrfX6tCd5CRH29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716677056; c=relaxed/simple;
	bh=F59Ce8RcTu23jzMytjJfPyYuy2fbrjAOQOqAGNaJSY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CseHQxydQMUClUSX57B++SOW4dn4xN0UG2auR1sIzLsLWzipZD4bS1ykA3dpkDk6rjMiUVNr9Tnn5Fy99U1Ey7ArIy/3Btc/gSTQMzgipH3PKQqwSq3TI0b1xeLeXutivBcBd9YQ3RUGotZxmWbc8rlwpdyKDMmOoZBnADMhyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NilA3JOO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o19fs6HMmZ1V8pDgoDn4UspMM2YEyH+2kahIoXod/HY=; b=NilA3JOOCVaARDvokbTynwJOCc
	8qQh11B9dzj24BfRy1QPUjRnt4U3IhUYERHwaCUxJgRu5shfyBqB6j9pxhX69v2iM8SoGhmZjTtpa
	Vho/mHFryvIs2CHnyq8iOQSj5y5bdhbeUHB2If8sb7INxCQ3pBH2Q3GGOxVSj97TIQQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sB07P-00G0oU-QT; Sun, 26 May 2024 00:44:03 +0200
Date: Sun, 26 May 2024 00:44:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Larry Chiu <larry.chiu@realtek.com>
Cc: Justin Lai <justinlai0215@realtek.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Message-ID: <eb543843-306f-42de-9fd1-6711753f007f@lunn.ch>
References: <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
 <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
 <5270598ca3fc4712ac46600fcc844d73@realtek.com>
 <0ec88b78-a9d3-4934-96cb-083b2abf7e2b@lunn.ch>
 <48072595c9c344fea9c268fd81e4d06e@realtek.com>
 <8c6ad434-ba3a-4acf-9b10-9dff8efd4ee5@lunn.ch>
 <6dfaf8a97a9a4689ae642e4f909c7704@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dfaf8a97a9a4689ae642e4f909c7704@realtek.com>

> Yes, STP, IGMP snooping, ... are working as you said. However, PTP may
> have other special design to synchronize time with the other ports, and I
> may not be able to explain in detail here.

So long as Linux only plays the roll of a normal leaf node, that
should be O.K. Since you don't have a PHY, you need this MAC driver to
do the time stamping of PTP packets received by this MAC using the
MACs PHC.

Linux cannot be involved in synchronisation between ports because it
has no knowledge there are ports. Switch firmware will need to
synchronize the switches PHC with the upstream source, and send PTP
messages out ports, including the port towards Linux.

      Andrew

