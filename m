Return-Path: <netdev+bounces-90664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BD8AF723
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704BE1C211B6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1513F452;
	Tue, 23 Apr 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C9SHu6Us"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09713E031
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899886; cv=none; b=CKBzIldm33xoT6SGyoN5KZjZi4XzYcgzFK4EGcZNtndOmyVBPJz+Z7+NO18xpVyWDZ6V3lj3/5qCC1pBLMfQ3ata7IS3lfZDFNrr7wIzU3JgNItjc6UwtL4BUua25TL2NAcfHAgNZx2+bklH02FTraHD2xBoGzPlbVnShzQf81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899886; c=relaxed/simple;
	bh=J1gwE3ArzGJPLwgyOV8E2+S3O/PWhAxNWNshHANmbkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuxynsRvzhAxZJVii6T1dE6AB6TFs7oeQ9waL/WujY43d+l+wf0UT0bQ7cuxBnkGKCSTboB8juKqnggUM4YIbQLI7S4ogifDomaoW5RSlMARAHPPt4facUti0TBo1XUD6nvvsHZJxJ+jOdyeEgAHKs1tHkk9WSDZ4F/k3vgq7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C9SHu6Us; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dfSdMNny5AYMkrMXXBGFzzIFLlcxmpXFSbv/CJ1J1OY=; b=C9
	SHu6UsK/CdxE9CDQ3sVLYKW1ZGRSMyPhrDeSoxszZaFt510NCVpRbIVPZekAbuw+4qYtqhh05fgID
	NYtYHb+d7l78UK6/GvFXooiQSt9bfnONsf2L1VWjCwzJcL6rOxx1AwzP8YduvQc+uwwi1QpKXkqj9
	gXAU0xs/01z3PcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzLeU-00DkEY-I4; Tue, 23 Apr 2024 21:18:02 +0200
Date: Tue, 23 Apr 2024 21:18:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Ping failing with DSA enumerated ports with macb driver
Message-ID: <cc2c436a-b9d1-4158-b000-e7a555256e33@lunn.ch>
References: <CAEFUPH0hr9jX0NCTu1vCGQvkCJ87DjLrcg8iCVO7A2vRhmfVgQ@mail.gmail.com>
 <3041e5a8-b3c9-450e-8b4a-b541cd9ffe64@lunn.ch>
 <CAEFUPH2q38O5-gHU--z4GRc2RziinwB1hs6vNQpvJZJ5QH9jyQ@mail.gmail.com>
 <CAEFUPH3+8u-hDT0y8cA+6eH48z2MqBPHih=bze0pkwej5-eVZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH3+8u-hDT0y8cA+6eH48z2MqBPHih=bze0pkwej5-eVZQ@mail.gmail.com>

On Tue, Apr 23, 2024 at 11:19:51AM -0700, SIMON BABY wrote:
> Hello Andrew,
> 
> 
> The RGMII interface does not seem to work. 

What is often a problem with RGMII is the delay configuration.

     Andrew

