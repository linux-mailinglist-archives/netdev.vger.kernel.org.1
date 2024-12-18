Return-Path: <netdev+bounces-153068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0319F6B44
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B917A309C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31391F7570;
	Wed, 18 Dec 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ow0YXSgo"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F41F37C9;
	Wed, 18 Dec 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539705; cv=none; b=Jph2wrc2l9IoZdGw8im/yanDWeX1Cw9+Poq9Q9Kh5WKXZqLabmAQA9fJKCdDHh7SpC9A/K+rtuMvz0v81c+lCGwYMseyvEw1aWM2wrBcntQWZWn2A9F72E1eKwgdW0idrtnzB5olrYF0y6VO3tVUteVCTrBKnJfaIrBa76Zjzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539705; c=relaxed/simple;
	bh=x2D4Nlcz5LCOrVSznO54V4nFD7RwJd5yMkh3E71FkRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeCTetkToaEqwV0iPQKoWHfrQQjSwFocHzSVae3V0YEE6xT8anZkjpvyllLiw7jfQDXdxwb/jj1om3JH3vuOYNLR6ITNv1j718hFTRcxO5QpjYwkvjgEwMb3OU6lkB/9nwVT1I98swfmGlAkWipnn+NTXPfWPla+lyeDuPuuEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ow0YXSgo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=bueNXeOs7Bmf0KrFZDjJFgqSwAHQHlTYK4LaWi/JHYs=; b=ow0YXSgoEMqasBru
	Jhaf/z2bNxhIifjtv4TUgfPyz7+1YKc0g0QKtouc0OBDSKXlhlg/bzOTpuGOZQ+UjatRXgPnoj3Ou
	ZwAhjAiCn4O/bVGKeh05ZI5puT/sp7WRjVt0XC75CytMts8P2S0zJd2UHOITYTzkNIbQolZmKw719
	4akE2cu0lq7I5wb0oTlvxpMvIhk1CzVdUuo11PYE/Aecy+068zlkKWXSnkbXzc6kUnB83tbiw1ffn
	03HcP7DSMQd9N0qd2RLf9kLsUjffS/+GKu74RqLnisFR4qTRMjh38pkunysJzYx86DK3/dDSIA30I
	1ZxeQ5VwgPD3Z2P8HQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tNx0i-0068is-2s;
	Wed, 18 Dec 2024 16:34:56 +0000
Date: Wed, 18 Dec 2024 16:34:56 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: salil.mehta@huawei.com, shenjian15@huawei.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: hisilicon: hns: Remove unused
 hns_dsaf_roce_reset
Message-ID: <Z2L5sDPUyoJa2aXk@gallifrey>
References: <20241218005729.244987-1-linux@treblig.org>
 <20241218005729.244987-2-linux@treblig.org>
 <c350f32a-20f5-4bf3-bc30-36f44b4872a5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c350f32a-20f5-4bf3-bc30-36f44b4872a5@huawei.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:34:11 up 224 days,  3:48,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jijie Shao (shaojijie@huawei.com) wrote:
> 
> on 2024/12/18 8:57, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > hns_dsaf_roce_reset() has been unused since 2021's
> > commit 38d220882426 ("RDMA/hns: Remove support for HIP06")
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >   .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 109 ------------------
> >   .../ethernet/hisilicon/hns/hns_dsaf_main.h    |   2 -
> >   2 files changed, 111 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> > index 851490346261..6b6ced37e490 100644
> > --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> > +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> > @@ -3019,115 +3019,6 @@ static struct platform_driver g_dsaf_driver = {
> >   module_platform_driver(g_dsaf_driver);
> > -/**
> > - * hns_dsaf_roce_reset - reset dsaf and roce
> > - * @dsaf_fwnode: Pointer to framework node for the dasf
> > - * @dereset: false - request reset , true - drop reset
> > - * return 0 - success , negative -fail
> > - */
> > -int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
> > -{
> > -	struct dsaf_device *dsaf_dev;
> > -	struct platform_device *pdev;
> > -	u32 mp;
> > -	u32 sl;
> > -	u32 credit;
> > -	int i;
> > -	static const u32 port_map[DSAF_ROCE_CREDIT_CHN][DSAF_ROCE_CHAN_MODE_NUM] = {
> > -		{DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0},
> 
> It would be better to delete these roce-related definitions together:
> DSAF_ROCE_PORT_1, DSAF_ROCE_SL_0,DSAF_ROCE_6PORT_MODE and so on

Ah OK, I've sent a V2 with an extra patch to delete those.

> Thanks,

Thanks for the review!

Dave

> Jijie Shao
> 
> > -		{DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0},
> > -		{DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0},
> > -		{DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0},
> > -		{DSAF_ROCE_PORT_4, DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1},
> > -		{DSAF_ROCE_PORT_4, DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1},
> > -		{DSAF_ROCE_PORT_5, DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1},
> > -		{DSAF_ROCE_PORT_5, DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1},
> > -	};
> > -	static const u32 sl_map[DSAF_ROCE_CREDIT_CHN][DSAF_ROCE_CHAN_MODE_NUM] = {
> > -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_0},
> > -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_1, DSAF_ROCE_SL_1},
> > -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_2},
> > -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_1, DSAF_ROCE_SL_3},
> > -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_0},
> > -		{DSAF_ROCE_SL_1, DSAF_ROCE_SL_1, DSAF_ROCE_SL_1},
> > -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_2},
> > -		{DSAF_ROCE_SL_1, DSAF_ROCE_SL_1, DSAF_ROCE_SL_3},
> > -	};
> > -
> > -	/* find the platform device corresponding to fwnode */
> > -	if (is_of_node(dsaf_fwnode)) {
> > -		pdev = of_find_device_by_node(to_of_node(dsaf_fwnode));
> > -	} else if (is_acpi_device_node(dsaf_fwnode)) {
> > -		pdev = hns_dsaf_find_platform_device(dsaf_fwnode);
> > -	} else {
> > -		pr_err("fwnode is neither OF or ACPI type\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* check if we were a success in fetching pdev */
> > -	if (!pdev) {
> > -		pr_err("couldn't find platform device for node\n");
> > -		return -ENODEV;
> > -	}
> > -
> > -	/* retrieve the dsaf_device from the driver data */
> > -	dsaf_dev = dev_get_drvdata(&pdev->dev);
> > -	if (!dsaf_dev) {
> > -		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
> > -		put_device(&pdev->dev);
> > -		return -ENODEV;
> > -	}
> > -
> > -	/* now, make sure we are running on compatible SoC */
> > -	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
> > -		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
> > -			dsaf_dev->ae_dev.name);
> > -		put_device(&pdev->dev);
> > -		return -ENODEV;
> > -	}
> > -
> > -	/* do reset or de-reset according to the flag */
> > -	if (!dereset) {
> > -		/* reset rocee-channels in dsaf and rocee */
> > -		dsaf_dev->misc_op->hns_dsaf_srst_chns(dsaf_dev, DSAF_CHNS_MASK,
> > -						      false);
> > -		dsaf_dev->misc_op->hns_dsaf_roce_srst(dsaf_dev, false);
> > -	} else {
> > -		/* configure dsaf tx roce correspond to port map and sl map */
> > -		mp = dsaf_read_dev(dsaf_dev, DSAF_ROCE_PORT_MAP_REG);
> > -		for (i = 0; i < DSAF_ROCE_CREDIT_CHN; i++)
> > -			dsaf_set_field(mp, 7 << i * 3, i * 3,
> > -				       port_map[i][DSAF_ROCE_6PORT_MODE]);
> > -		dsaf_set_field(mp, 3 << i * 3, i * 3, 0);
> > -		dsaf_write_dev(dsaf_dev, DSAF_ROCE_PORT_MAP_REG, mp);
> > -
> > -		sl = dsaf_read_dev(dsaf_dev, DSAF_ROCE_SL_MAP_REG);
> > -		for (i = 0; i < DSAF_ROCE_CREDIT_CHN; i++)
> > -			dsaf_set_field(sl, 3 << i * 2, i * 2,
> > -				       sl_map[i][DSAF_ROCE_6PORT_MODE]);
> > -		dsaf_write_dev(dsaf_dev, DSAF_ROCE_SL_MAP_REG, sl);
> > -
> > -		/* de-reset rocee-channels in dsaf and rocee */
> > -		dsaf_dev->misc_op->hns_dsaf_srst_chns(dsaf_dev, DSAF_CHNS_MASK,
> > -						      true);
> > -		msleep(SRST_TIME_INTERVAL);
> > -		dsaf_dev->misc_op->hns_dsaf_roce_srst(dsaf_dev, true);
> > -
> > -		/* enable dsaf channel rocee credit */
> > -		credit = dsaf_read_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG);
> > -		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 0);
> > -		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
> > -
> > -		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 1);
> > -		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
> > -	}
> > -
> > -	put_device(&pdev->dev);
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL(hns_dsaf_roce_reset);
> > -
> >   MODULE_LICENSE("GPL");
> >   MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
> >   MODULE_DESCRIPTION("HNS DSAF driver");
> > diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> > index 0eb03dff1a8b..c90f41c75500 100644
> > --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> > +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> > @@ -463,6 +463,4 @@ int hns_dsaf_clr_mac_mc_port(struct dsaf_device *dsaf_dev,
> >   			     u8 mac_id, u8 port_num);
> >   int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port);
> > -int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset);
> > -
> >   #endif /* __HNS_DSAF_MAIN_H__ */
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

