Return-Path: <netdev+bounces-62730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C8C828D0C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 20:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BF5B259AB
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA53C49D;
	Tue,  9 Jan 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xReElUxN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94F93C468
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t9D9jCUH5Yg4zcgZd2cX2tTU6OmTCsagvyq2J1PgxR4=; b=xReElUxNhCmIcYHKKHsWax5wVs
	IEwM/urVH86An2NnfO21ftEXGY4lv3k0CVH1x95w2TWTYPucyurKPadFVfMAIa04dMm8K8vmIPPYI
	Vo+9gELfFB1p+qOVtEk146eXcDzVfBD419sP26bVacuOiTGDEiogKwuGTY2YXubNHaDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNHLX-004rDs-G2; Tue, 09 Jan 2024 20:01:07 +0100
Date: Tue, 9 Jan 2024 20:01:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net 3/7] MAINTAINERS: eth: mvneta: move Thomas to CREDITS
Message-ID: <99fa44f0-fcd7-4732-b118-c52dfe1c482d@lunn.ch>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-4-kuba@kernel.org>
 <58364a9e-a191-4406-a186-ccd698b8df4b@lunn.ch>
 <CAHzn2R3ouzpsJySX50bVEdAeJ1g4kg726ztQ+8gFKULfAL335A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHzn2R3ouzpsJySX50bVEdAeJ1g4kg726ztQ+8gFKULfAL335A@mail.gmail.com>

> Albeit not asked, I'll respond. I've worked on neta for years and
> still have a HW - if you seek for volunteers, you can count me in :)

Hi Marcin

Please submit a patch to the Maintainers file.

Thanks
	Andrew

