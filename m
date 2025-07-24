Return-Path: <netdev+bounces-209648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9513B1021E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DA417B18E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B725A323;
	Thu, 24 Jul 2025 07:42:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CCA2A1BB
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342937; cv=none; b=dIO11KK0guMnZcbGsQMfdA2ZqSX4u/xNM6toG2xQt4OLlZDDi2OW1cRWeQwVTW9JZZVQMwuetZPeCCUCRgPM0sz5yNnfrZ4Wn3GF2AKX1IaFwESGj1RxPWFjt9qq5l1xAanyHk0yXaombxsll0Ieh3t09oD2CmqWiWUxsVIk6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342937; c=relaxed/simple;
	bh=JMketO6cpOsU1tEp1XLGK3id3BqoiovgRmb0aRMW21w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiEzpu15ZGPdT5exzRSF7frdCBVAn4mbXnN94+GoYEN8HF7++lNIvpU9z3Lxud617LPEXBd/DqeVrC5hHXrU0fqnxkA4cPDRS1sQcsyZC0SmpMTbJAVRm8nCKK7bAlvkgOsHz4XKNPIPNItwchIgyGGuHfZAGfCx0rHEJfYEJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1753342852t054t42488
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.23.165])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6691219113993467394
To: "'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com> <20250721080103.30964-3-jiawenwu@trustnetic.com> <97f47ab9-638e-45e4-88be-b1bcd089c2c6@intel.com>
In-Reply-To: <97f47ab9-638e-45e4-88be-b1bcd089c2c6@intel.com>
Subject: RE: [PATCH net-next v2 2/3] net: wangxun: limit tx_max_coalesced_frames_irq
Date: Thu, 24 Jul 2025 15:40:40 +0800
Message-ID: <046601dbfc6e$41017be0$c30473a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQMOVi+96r7/jeT4bPen62fEkV838gDE+UH6AZ6GRL2xyRNacA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N17Koc4oSm0p9BI8XzFzG7dUJoPj41QqWkPpqxXGWi9jYJNGSDShZ8f9
	fAWtpavDPN4c6lfT70dFpKAXLlWAe3RGTLaJiR6OmNPH6BFe9g330OX0TJqEUH0dDuWCR7H
	B3wVUyw9Y1JOyleVyO0mtF454YmINKFO4quqB6RQK177xIuxoHdcYKZQvTc155Bb1h0iFUa
	C0tax8EXpWA9eidd1Rxxg7nrRFVIsLrx8FFO/hCtYf17XoNDQklz+Jt5iX6HhSQ5iQY0lDE
	BCCghbjQ7siPJ/6zM9QKKBgAadZwW/WLwHnd1dMoWKx9Y/Zrs4uNFGDki+VY4u/VM5F/pw4
	aKSW6xwzU+xA4qtjQXgK1uqv9CRBEZX2GrP1LC9fMmmdkRHvWuFjrd/Y4S+zGIX2cWiLRQr
	lH+9BjXP4HGJ9i5nqY51/OJ2IbePWm3wJD/GMnOL9ziwB8TDVg5B0OXt08vYJqpDTcM7wiu
	uERI1SkHdhog9AIqThKQHT9o6HPW9qF5zh1oP6kKlH0rMWCmMMimm7m3BHgHgvF6y6cugJG
	szdBsVK26EuJCGctnwUKrDZqoDyMfjH6zlgBqKZJ+MwfuOPOC0mvZ4SmE4k6BNiMzTcPR6G
	DsMBt6U6KEh5P+I86CkyfFwpVR+2I7Udq9ZEGtycHkEp3jsC3/BexGX8j4HfbtfUfgroQax
	pms2ecLGO8Q+fCRYwPJZPb8CBypLKTn5CzGsqOqDoVwxVA1S4yxi4uxeazmtjbCDvskTcES
	1zp7Rj1/lMHnx4MXbt6qfyy8wF0h915qrmIBf0rnc8iEX3cT2iF5Qt6+87PQG/u9CAN3lWK
	zF7dQtlNHU9lPJXZ0iK/jGuWSnRMj4l15tfIADjIh5aF/ZW1H2d9nt29CfICPtj1n5aE4z+
	HPJmzdIlEiqOGpDs1a3L8eD97Y+8zWYlHl9uU+5VM2fzejNXPsI4nKTjlSDsubhybaKJbln
	BTsP7fI44Rj6JNGxHkAqyQIUJPnyXmETiq1qUcwkdCcli4uplyn+JgckxCIdrRluSTQqIG7
	474FaMsB1DipxjhNwR1QZD0McXxT4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 7:57 AM, Jacob Keller wrote:
> On 7/21/2025 1:01 AM, Jiawen Wu wrote:
> > Add limitation on tx_max_coalesced_frames_irq as 0 ~ 65535.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> 
> Previously you accepted arbitrary values, and now its limited to the
> specified range of 0 through 65535. Seems reasonable. Might be good to
> explain why this particular limit is chosen.

Because 'wx->tx_work_limit' is a u16 member.

> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> >  drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 +++++--
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h    | 1 +
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> > index 85fb23b238d1..ebef99185bca 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> > @@ -334,8 +334,11 @@ int wx_set_coalesce(struct net_device *netdev,
> >  			return -EOPNOTSUPP;
> >  	}
> >
> > -	if (ec->tx_max_coalesced_frames_irq)
> > -		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
> > +	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||
> > +	    !ec->tx_max_coalesced_frames_irq)
> > +		return -EINVAL;
> > +
> > +	wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
> >
> >  	switch (wx->mac.type) {
> >  	case wx_mac_sp:
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > index 9d5d10f9e410..5c52a1db4024 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > @@ -411,6 +411,7 @@ enum WX_MSCA_CMD_value {
> >  #define WX_7K_ITR                    595
> >  #define WX_12K_ITR                   336
> >  #define WX_20K_ITR                   200
> > +#define WX_MAX_TX_WORK               65535
> >  #define WX_SP_MAX_EITR               0x00000FF8U
> >  #define WX_AML_MAX_EITR              0x00000FFFU
> >  #define WX_EM_MAX_EITR               0x00007FFCU



