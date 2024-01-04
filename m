Return-Path: <netdev+bounces-61429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A72823A71
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05C01F262C9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278D1859;
	Thu,  4 Jan 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ow/UutQ2"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A5523D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <820aeca6-1605-4413-2d97-0554443b3297@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704333735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8kduCbYQOl6J/3e1ntHCE7CtU7jNW9QWg2FRYJCYxg=;
	b=Ow/UutQ2S6Ez5cXEHt93hzSLA7XLoFlhQFdNTP9UX8HDLr45RQEVOwstQr36PG+n4IRoRp
	JwK7ftQrr3gtQnRlEir3rIFopzGaa2mRBetmiBOawUwBAocjXsivyR5QCNGBxBdBElQ4Iq
	eve4n+eevjFiVvFL9bW9V7zqcPYmc+I=
Date: Thu, 4 Jan 2024 10:02:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/2] net: phy: Use is_phy_driver() and
 is_phy_device()
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com, hkallweit1@gmail.com,
 przemyslaw.kitszel@intel.com, kabel@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20240103025334.541682-1-yajun.deng@linux.dev>
 <ZZVogCGYu9pIR620@shell.armlinux.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ZZVogCGYu9pIR620@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/3 22:00, Russell King (Oracle) wrote:
> On Wed, Jan 03, 2024 at 10:53:32AM +0800, Yajun Deng wrote:
>> There is only one flag that can be set in struct mdio_driver_common and
>> mdio_device. We can compare the probe of the driver or the type of the
>> device to implement it. Hence, these flags in struct mdio_driver_common
>> and mdio_device can be removed.
>>
>> Introduce is_phy_driver() and is_phy_device(). Use them test the driver
>> or device.
> It is not a good idea to post a new series while discussion of the first
> is still on-going, even if it has been 24 hours since you last posted a
> patch. If discussion is still going on, then we don't need the
> distraction of yet another series to duplicate the comments to.
>
> I remain completely unconvinced of the merit of these changes. IMHO,
> it is pure churn for churn's sake - there is no _real_ benefit. It
> doesn't fix a bug. It doesn't make the code easier to read. It only
> satisfies some ideological idea that all drivers should look the same.
>
> Unless a very good justification can be found, I am not in favour of
> changing these drivers.
>
> There _may_ be good merit in is_phy_driver() and is_phy_device(), and
> as Andrew says, that should be done _first_.
>
Ok, I got it, thanks!



