Return-Path: <netdev+bounces-220684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41548B47C80
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF42D179BC2
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3EF280A5F;
	Sun,  7 Sep 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SiRhoxjz"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F381D6BB
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757264134; cv=none; b=AqEcHFdQTpng+sacZAt8RXwSgSEvggYXRPB+SjrouPhgoC3WkJaVPkhY5PKY6L5khwPHEXfa3B2OAVXrcM8TPKhslSBHHlv2LFDT69yn1BqMDMg8Ul5ApQRWGVkxiwX1zbJk6LKdje68ytuqALg23xyfEAfXW/tEO6cKyhW+tBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757264134; c=relaxed/simple;
	bh=hj/oyp4cEgcvL/1yElr6j76VlPObqr1h7l8aQw98mog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1BeZ2KeNMwG/P4+0kZDRsM3YjDPBWAL1u7ERIumRXSopUVq1IR/T3PP3To0FDsSb7bQKmOae9oL+KPIlLrGWVPqx8NsUHB92pTsHHhZ6CH2jKJXrHMLwW/teAt/475VTIqB21ByoaXaWubAGpsNbV0HKcPEIzLNuu4nA2qXT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SiRhoxjz; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00d37c64-f584-4846-b65c-76582601c30f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757264129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELddA0f2ttvGHdC8Ifs6ZhKF0YoIStSpLQZE8s5K2Hk=;
	b=SiRhoxjzpq/2GariF7snGksH/Pd5bDzzHTigFdy3aSAkiser8+ypa/adG+daV1Bk4oA1qh
	SWBT2+lOQdHsHT0hRRA3vKKs6Ss9Z6Go2J1T0gffzlYtP8tc42aa+KezEjCMfhR4xSiWVY
	57phi9DDi2EaPMzzkOi3DZ8+tOGFiYY=
Date: Sun, 7 Sep 2025 17:55:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v04 05/14] hinic3: Command Queue flush interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1757057860.git.zhuyikai1@h-partners.com>
 <be5378bb148410286bb319a82fd2e2f0c9044117.1757057860.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <be5378bb148410286bb319a82fd2e2f0c9044117.1757057860.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/09/2025 09:28, Fan Gong wrote:

[...]

> +struct comm_cmd_clear_doorbell {
> +	struct mgmt_msg_head head;
> +	u16                  func_id;
> +	u16                  rsvd1[3];
> +};
> +
> +struct comm_cmd_clear_resource {
> +	struct mgmt_msg_head head;
> +	u16                  func_id;
> +	u16                  rsvd1[3];
> +};

I don't see any difference in these 2 structures. And the code
implementation doesn't check types. Probably it's better to refactor
things and try to implement it using common thing.

[...]

> +void hinic3_enable_doorbell(struct hinic3_hwif *hwif)
> +{
> +	u32 addr, attr4;
> +
> +	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
> +	attr4 = hinic3_hwif_read_reg(hwif, addr);
> +
> +	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
> +	attr4 |= HINIC3_AF4_SET(ENABLE_DOORBELL, DOORBELL_CTRL);
> +
> +	hinic3_hwif_write_reg(hwif, addr, attr4);
> +}
> +
> +void hinic3_disable_doorbell(struct hinic3_hwif *hwif)
> +{
> +	u32 addr, attr4;
> +
> +	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
> +	attr4 = hinic3_hwif_read_reg(hwif, addr);
> +
> +	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
> +	attr4 |= HINIC3_AF4_SET(DISABLE_DOORBELL, DOORBELL_CTRL);
> +
> +	hinic3_hwif_write_reg(hwif, addr, attr4);
> +}

These 2 functions differ only in one bit. It might be better to
implement it once and use extra boolean parameter?



