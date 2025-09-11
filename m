Return-Path: <netdev+bounces-222160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FA7B53536
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C841BC8427
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6432ED4C;
	Thu, 11 Sep 2025 14:25:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AB320CC8;
	Thu, 11 Sep 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600713; cv=none; b=Mql2OMBlGphJovIO1CkJ3lwPbwF4IWqpTLBlcKRmpMtd+QrA6ve1sNMSLhHCaggYfPTQdihCZYv/xEo1hIutyNLeECmK5ndQ77Op7CVFjfSllVXxFMs/+9lq7zaXJjEwBJEjNaROeg4rXDi0LgyI+DPUSFllBZHsyjLQXraD2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600713; c=relaxed/simple;
	bh=9UeWB6bZ5lDg1XpQc/Nxdc04PAVXLyteB1n9d9VIS3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjEh/yZ1pQ6Ic96YaqezSVj/ASJaw7gp+Isrt3uabmGfyi4Ecf87gCbMbzV2iyuafZuNZ39om2xMlJtmD6iSamJeutyzmshCcJmQyFN7M//gAf8vh+MIEgNyfjr6ZYeXCClIv2l76YN/5NrJ18hhoQrIN9hTKAM9IyYR6UDRvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cN0DZ2rxmztTG7;
	Thu, 11 Sep 2025 22:24:14 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E259140156;
	Thu, 11 Sep 2025 22:25:09 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 22:25:07 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <jdamato@fastly.com>, <kuba@kernel.org>,
	<lee@trager.us>, <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <meny.yossefi@huawei.com>,
	<mpe@ellerman.id.au>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <vadim.fedorenko@linux.dev>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v05 12/14] hinic3: Add port management
Date: Thu, 11 Sep 2025 22:25:04 +0800
Message-ID: <20250911142504.2518-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20250911123324.GJ30363@horms.kernel.org>
References: <20250911123324.GJ30363@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 9/11/2025 8:33 PM, Simon Horman wrote:

> > +	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
> > +	if (!err && link_status_up)
> > +		netif_carrier_on(netdev);
> > +
> > +	return 0;
> > +
> > +err_flush_qps_res:
> > +	hinic3_flush_qps_res(nic_dev->hwdev);
> > +	/* wait to guarantee that no packets will be sent to host */
> > +	msleep(100);
> 
> I realise that Jakub's feedback on msleep() in his review of v3 was
> in a different code path. But I do wonder if there is a better way.

...

> > +	hinic3_flush_txqs(netdev);
> > +	/* wait to guarantee that no packets will be sent to host */
> > +	msleep(100);
> 
> Likewise, here.

Thanks for your review, Simon.

Firstly, The main issue on the code of Jakub's feedback on msleep() is
duplicate code function. The msleep() in hinic3_vport_down and
hinic3_free_hwdev is repetitive because of our oversight. So we removed
msleep() in hinic3_free_hwdev in v04 patch.

Secondly, there is no better way indeed. As our HW bad decision, HW 
didn't have an accurate way of checking if rq has been flushed. The
only way is to close the func & port . Then we wait for HW to process
the pkts and upload them to driver. 
The sleep time is determined through our testing. The two calls of
msleep() are the same issue.

Finally, we have received your reviews on other patches and we will
fix them soon in the next version.

