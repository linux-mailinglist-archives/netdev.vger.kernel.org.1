Return-Path: <netdev+bounces-140756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B09B7DB9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DC9281613
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8901A303E;
	Thu, 31 Oct 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3hMpARpK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295919F406;
	Thu, 31 Oct 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386960; cv=none; b=mVSHcxONg/J38233qfP6qdtOAOnr2e8qqie10CcvfY0ayS0E5UXDrkysDCUZjoamtB3gldhh7rjY8KxhURcWNeEloCKNtMiKZgfArVml+7eLVOYLJ4NXqrtiSMTTvWYGAxida9W5ZayMVipRQy6QXx29VSzBQ3xmZaNVtjjZf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386960; c=relaxed/simple;
	bh=vbUmqWI7JAbO+BDvKROW7X7Qx0zoh4xecP6/V3y0iNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7gPcW/+bxB+PXTD5OjBJwMTEN6RKr1xm4DIjZ/CuUvFQwuB5CaDbKkGB68w/5pvKL3dM3Zzx4a+4pnSEVTlb2EGe0V+b7gltrGjFNR5l1kjo5oQGF9ICuJ4ECrgpii+S0u+7PLvTU8d1frpPlxrZxhrz9179rP/rKlPguIg/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hMpARpK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R22eOld3HHRkg+3Pl3PxR0m2oHUBKxUm2voXqaP5CBw=; b=3hMpARpK8n/hpooMl83HU00jwK
	NBJ+Tl/a6iXPc2SkonBtnwFmz1URwAiWfuGApM4wkkcCHe7Dk+LgsNk5yWcvBvZWDQJl64fbZwJ3u
	b9VHoP5xMKgKyuHYrVlvgo8Eo/RId6KkYKXDHrs6DSuzV9ZeCZHKf0mWemISu15B8C0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6Wgu-00BnOs-NY; Thu, 31 Oct 2024 16:02:28 +0100
Date: Thu, 31 Oct 2024 16:02:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <ce1343e0-1206-4c40-8eb9-b2981e276c76@lunn.ch>
References: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
 <20241030103554.29218-2-SkyLake.Huang@mediatek.com>
 <cd2f249b-6257-4692-ac2f-93252534cff4@lunn.ch>
 <01ed46ea6898e40b89de370af1b8a31a384e0044.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ed46ea6898e40b89de370af1b8a31a384e0044.camel@mediatek.com>

> Thanks for the tip. Do I need to submit v2 to fix this to get merged?

Yes please.

    Andrew

