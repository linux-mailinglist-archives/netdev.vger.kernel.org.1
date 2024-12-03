Return-Path: <netdev+bounces-148330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAC9E120A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BDBB219B9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A231547CF;
	Tue,  3 Dec 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mdakY+5S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A12E64A;
	Tue,  3 Dec 2024 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198017; cv=none; b=i9B65EYPtTFNcmTB3TZ72TqmDbs3C5eoxH+cQT4KoOYV5XfCwrX38gd5mg1Wa49nFFt40MacDxGUmJmsWxNA3uDsnu/e5BDF9FjeP4Ymr3kSU4VCvPzhCIsbZ1xLM74Rwwh/8wQ5Havkws2XgNj/GZCqW+N6l+uT+BOu0QUBbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198017; c=relaxed/simple;
	bh=plrOIdrtojHTPWHNrBtBu8C/A+TcUmJZ2SoAitv31V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFPqA7sudbTH6k+SYuXtRgEkjtKF1lvzvnIcwyDBdIyMYGJ4PrnxjIKmZeZboLO6HuD4tD8NcNetYJaFwoJ6YeYYY6z20mpUfgCjqE0feu3bn4CcNEyxlAbWP+d4HKNpBvb9GdivDN7Q1h5LiqHvx0mPbrOKh0xUT3xd7+YFxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mdakY+5S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PWGZg7s4u/01cmJWIwzraciymGm24EHgFjJehOGRe6Q=; b=md
	akY+5SUPSXxxx7WqanI0Gfwfs6fnpFZOoIlel+Vpa2ejyl1ZtkiQA+7vPUp/6H9kfGGMTL2EgL5GW
	Ts+i9g0HpjAHZbAMEtKRXTn+zfDO1Cbl9hBf4vGVHL+a2r/UWT30gC6gz4gcFs1x4kR44PcnxmDjz
	drz03RDxIUlOfr0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIJye-00F2rs-QN; Tue, 03 Dec 2024 04:53:32 +0100
Date: Tue, 3 Dec 2024 04:53:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Subject: Re: [PATCH 1/2] net: phy: realtek: add combo mode support for
 RTL8211FS
Message-ID: <aa36e5a4-e7d2-4755-b2a1-58dc5a60af1c@lunn.ch>
References: <20241202195029.2045633-1-kmlinuxm@gmail.com>
 <690e556f-a486-41e3-99ef-c29cb0a26d83@lunn.ch>
 <CAHwZ4N3dn+jWG0Hbz2ptPRyA3i1SwCq1F7ipgMdwBaahntqkjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHwZ4N3dn+jWG0Hbz2ptPRyA3i1SwCq1F7ipgMdwBaahntqkjA@mail.gmail.com>

On Tue, Dec 03, 2024 at 11:08:22AM +0800, 万致远 wrote:
> On 2024/12/3 7:52, Andrew Lunn wrote:
> >> +static int rtl8211f_config_aneg(struct phy_device *phydev)
> >> +{
> >> +    int ret;
> >> +
> >> +    struct rtl821x_priv *priv = phydev->priv;
> >> +
> >> +    ret = genphy_read_abilities(phydev);
> >> +    if (ret < 0)
> >> +            return ret;
> >> +
> >> +    linkmode_copy(phydev->advertising, phydev->supported);
> >
> > This is all very unusual for config_aneg(). genphy_read_abilities()
> > will have been done very early on during phy_probe(). So why do it
> > now? And why overwrite how the user might of configured what is to be
> > advertised?
> >
> 
> These codes are migrated from Rockchip SDK and I'm not familiar with this part.
> 
> I will use `linkmode_and` instead of `linkmode_copy` in my next
> version of patch like Marvell does.

No, it needs a lot more work than just that. Spend some time to really
understand how the marvell driver handles either copper or fibre, and
assume the Rockchip SDK is poor quality code.

It might also be that the marvell scheme does not work. It will depend
on how the PHY actually works.

Andrew

