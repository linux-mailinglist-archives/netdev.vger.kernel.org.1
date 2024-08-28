Return-Path: <netdev+bounces-122766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855489627B7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B56B285796
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BAC179956;
	Wed, 28 Aug 2024 12:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBE115ADBC;
	Wed, 28 Aug 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849429; cv=none; b=dGlTzgaKbWqfEMnfVTP9bY2vQFUrIHMWVD9xXWmRaXpJwzdkfyYfMaYyiiXLxezlEn8yTQUXnSfsNswtm8j6/I+CnWOj0R5ktSUj7pTP2FVA/9nkzbSSfER8jdoIoa+GMPULEhO6vKqeKkXDxw1yHfUKCbnNRSJmEj1ni6tPWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849429; c=relaxed/simple;
	bh=ZziwDkHVvvQUO6Ix148uGBxsk3bDYW0cw5kn9BpbUzc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emCQfga5XysCRn5Fk6jU3pZi9DgbYFOJyxzYcsWmTKumrRJQjJWsh0JckU53FI/YPUmGtbufunfe1miLY639d6eFim2wh9mWd0hErNy5/5VAFf6QUIXDzaeyHpmdFBj2TO1hOpTMdq4ZDf/p4154Cn8xxvrYBoe8d2u/hBmWLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv41T1pbfz6H7XM;
	Wed, 28 Aug 2024 20:47:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A5EA1400D4;
	Wed, 28 Aug 2024 20:50:25 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:50:24 +0100
Date: Wed, 28 Aug 2024 13:50:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
Subject: Re: [PATCH net-next v2 10/13] net: dsa: microchip: Use scoped
 function to simplfy code
Message-ID: <20240828135023.00006db0@Huawei.com>
In-Reply-To: <20240828032343.1218749-11-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
	<20240828032343.1218749-11-ruanjinjie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 11:23:40 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Avoids the need for manual cleanup of_node_put() in early exits
> from the loop by using for_each_available_child_of_node_scoped().
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


