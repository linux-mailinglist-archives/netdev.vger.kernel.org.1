Return-Path: <netdev+bounces-105426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C549111CD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BCC1F22516
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5E51B9AA6;
	Thu, 20 Jun 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s61ae4OH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC551B4C49;
	Thu, 20 Jun 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910480; cv=none; b=JToqsbTbTKt7ZS+3MH7LpE0wGIvbZw4KSXYg32VYd0MOuOtapEaH6K7GB2qSepq/KFWlIMdxkGll3c5XgQk/iVtNOp3B3aolgIrQG+gLfhV28QuNXxMHqZ28C3xzdgJRjOwTOG0r6Y184UpL9omNG7Ol5uaR3+lDIcUM9PRXXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910480; c=relaxed/simple;
	bh=OlW1ENdHOss0z8nNJ15klT0SY+H8fX2HhCFFX6R+pxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvDqp16NcB/EIY1SPd4lQSqNhXO+O7IB2fbqcCfDwfzjYQMHRbZU5unKesqOJllbI6GpuMkg1iZrmeKLueibHQ/pZVdvqk7zPYLU7wD2XhgerqQ+bXS1ApGefrLa5800EvyDZk6y1Ja7J6PWdQdIlIVk+L+Zi3Ispck53EmcgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s61ae4OH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=boBhRkarly8ZE6oMIXDojVXH9X+JWz1/G/QNZB6kvSo=; b=s6
	1ae4OH7mlesu/KJYSI0D8C5P+4/FtwDVp39UI0QlMjEcix/BENml1kDQ0C1vlYjixV8Df1ib+zDA7
	1WH9SZgTraWOASwXb120hu3RlYXMIGU8XEg2ZBuDwB+ZBLy6sqJi1k7NJsoaresMOQKnyGEGv7Z6n
	t7KOjcS4o58FH74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKN8N-000bJC-NJ; Thu, 20 Jun 2024 21:07:47 +0200
Date: Thu, 20 Jun 2024 21:07:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, trivial@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 resub 1/2] net: include: mii: Refactor: Define LPA_*
 in terms of ADVERTISE_*
Message-ID: <c82256a5-6385-4205-ba74-ab102396abb6@lunn.ch>
References: <20240619124622.2798613-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619124622.2798613-1-csokas.bence@prolan.hu>

On Wed, Jun 19, 2024 at 02:46:22PM +0200, Csókás, Bence wrote:
> Ethernet specification mandates that these bits will be equal.
> To reduce the amount of magix hex'es in the code, just define
> them in terms of each other.

I have a quick email exchange with other PHY maintainers, and we
agree. We will reject these changes, they are just churn and bring no
real benefit.

NACK

    Andrew

