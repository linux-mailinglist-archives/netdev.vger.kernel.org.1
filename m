Return-Path: <netdev+bounces-225495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6DB94C38
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692651902634
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA724311C0C;
	Tue, 23 Sep 2025 07:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACE31197E;
	Tue, 23 Sep 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612397; cv=none; b=fXeq4HCez6ZUq2qBpGzEBHywzBgibDFbnUuX83nFThEM37C50k0yhkQ7d80kaGwn7LlpJWaoZ5EjRfVB66tTozf8KeAKR5UIXWMr5vEG7AumOL6/fuz/YNYBvp5oICnYaDqGDI6eya0p7CvR4f+vNpY524uLa6R1wKMPWQw3Ml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612397; c=relaxed/simple;
	bh=+70wkNx63x1jEVS7yy2WObjX8BK5ItnxD8o/AI8hzfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoIO9TT9I7MuBkorByPy4vj77JwAvL2c+vVW7GyKd/ENi1f+4N6bvr7mw/LQb1+CJl/gai0nmOSUJDWGUAAUpiH6iI5LrPX0P6d5+bqvlr281iber9ImSMU8ZJqlgVkvYPHd8/2TTbWlKZ5V2W4mSxQH5OGlF1ExEGyjN+6HpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cWBK006Hwz24hy2;
	Tue, 23 Sep 2025 15:23:00 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FCA21A0188;
	Tue, 23 Sep 2025 15:26:32 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 15:26:30 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <dan.carpenter@linaro.org>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<luoyang82@h-partners.com>, <meny.yossefi@huawei.com>, <mpe@ellerman.id.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <vadim.fedorenko@linux.dev>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v06 08/14] hinic3: Queue pair resource initialization
Date: Tue, 23 Sep 2025 15:26:05 +0800
Message-ID: <20250923072606.1178-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <aMu3E-wTfK-B18id@stanley.mountain>
References: <aMu3E-wTfK-B18id@stanley.mountain>
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

On 9/18/2025 3:38 PM, Dan Carpenter wrote:

> On Fri, Sep 12, 2025 at 02:28:25PM +0800, Fan Gong wrote:
>> @@ -102,6 +127,41 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
>>  	return i;
>>  }
>>  
>> +static u32 hinic3_alloc_rx_buffers(struct hinic3_dyna_rxq_res *rqres,
>> +				   u32 rq_depth, u16 buf_len)
>> +{
>> +	u32 free_wqebbs = rq_depth - 1;
>
> Why is there this "- 1" here.  Why do we not allocate the last page so
> it's 1 page for each rq_depth?
>
> regards,
> dan carpenter
>

Thanks for your comment. Sorry for replying so late.

This is queue design. PI means the next queue place that can be filled.
When PI equals to CI in HW, it means the queue is full.
"hinic3_alloc_rx_buffers" is to replenish rx buffer. Then driver informs
HW that there are new idle wqe HW can use instead of informing that the
queue is full. Although driver can allocate page of depth quantity(e.g.
depth is 1024, CI is equals to 0, we allocate 1024, then PI is also equals
to zero), driver allocates for one less to avoid triggering the "full"
situation mentioned above.

