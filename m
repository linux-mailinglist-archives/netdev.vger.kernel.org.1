Return-Path: <netdev+bounces-124910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75D96B5F1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08861285CFE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6831A3032;
	Wed,  4 Sep 2024 09:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7047198A2F;
	Wed,  4 Sep 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440742; cv=none; b=fcbtEG8UaopuEdor8Spqpg3Pn5DdFw5VWYzZM77fp6LbSOxzYEMtYMnDNtRVI1STuY6yoPau37VvtKzyak6876mEV3clMYn+d6DXs/TZ3DvNxlMO3P6I6Lx00xSLMLbGqzmFayWteYPhwkoHdVofOvqD1LbYrTPMwGw/qaN9LjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440742; c=relaxed/simple;
	bh=AFpo7HiH9ftZoefuBlAkjCTfx16yzx3W0d1chllEpL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+BHmyGmKQ9kFHRUwip7NNAPnwfrvNfb3x/9rLyFcjGh1of6nCN5o9bo5+lReFtxKBwrRmas1THwU2GrxP2HgK1wNsiPSJ2TXZrpgEEJSEEf+4r4EkgQVM/QH8WdQyNpVK98litg8kpasPKylIdsFTwjbOMr6JMIDB9A5ad5P7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sllx9-000000004Br-3pNB;
	Wed, 04 Sep 2024 09:05:28 +0000
Date: Wed, 4 Sep 2024 11:02:11 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v10 11/13] net: phy: add driver for built-in
 2.5G ethernet PHY on MT7988
Message-ID: <ZtgiE64iusrjPKSp@pidgin.makrotopia.org>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
 <20240701105417.19941-12-SkyLake.Huang@mediatek.com>
 <ebeb75a3-a6b1-46b3-b1e8-7d8448eb23f6@lunn.ch>
 <c21fe0db83dd665d4725ffedc51db9063dbe2f3d.camel@mediatek.com>
 <38189661f30032715783e8860318fe9e50258e47.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38189661f30032715783e8860318fe9e50258e47.camel@mediatek.com>

Hi SkyLake,


On Wed, Sep 04, 2024 at 08:49:50AM +0000, SkyLake Huang (黃啟澤) wrote:
> 
> Gentle ping.
>

Please see issue reported related to your patch
"net: phy: mediatek: Extend 1G TX/RX link pulse time"

https://github.com/openwrt/openwrt/issues/16281

Using the newly introduced .read_status function apparently breaks things.

Maybe we can apply the rest of this series first and then discuss the
problematic patch (which may need fixing) after that.


