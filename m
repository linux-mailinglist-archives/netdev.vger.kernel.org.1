Return-Path: <netdev+bounces-175663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBFFA670BB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366F7189C1DD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7062054F1;
	Tue, 18 Mar 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="afjgRjJ+"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-32.ptr.blmpb.com (va-2-32.ptr.blmpb.com [209.127.231.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB542066EF
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292390; cv=none; b=ozuHGFuTyPxLr7jT4mOZbdvWB2oIGhYhWHhy0n5mPp+WXDgM6LZ5C42RjidEshIzq6SDrqVTVBOuSM+Amlukf6LsoctZOtG3ckcuueel+N3RHr26LpsvIWfnx6ObwBY+02o7VArNquJIY4vCElI2VeSDgq+WM08uPSsmGMRbMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292390; c=relaxed/simple;
	bh=3aByyzzlxQntWJLvDI57KkWkxrdgOCicA+69JTcAhB8=;
	h=Content-Type:From:In-Reply-To:Date:Cc:Subject:Message-Id:
	 Mime-Version:References:To; b=mRTb78DSS//8n3IPLGgh90tI1N5DCIN1HrhVhJ7z9+RlLF0zVtm/FusfftZkM5rT7crx7thdpjdB+5nZ0gpGj3EhBZ1UGgIXbUZnQd8K7w6qOG7Cq6YF7BOr8fu7QU+UeSRfmhcl+tf3vyQr5Aj9NCTf1D1706k+cfMLjk9JWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=afjgRjJ+; arc=none smtp.client-ip=209.127.231.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742292372; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Hgw4pyhV9IXk0fgTMKvvY5d8ZlCtr9DdunGzDDslLKo=;
 b=afjgRjJ+uABHd7mF1VTHbnneitDupGTRgD+7XGcHaZ/Dw/DHreyrw14Wt/4vTJg6mEmLRn
 KKZS6vwvv7hrF3UKMUNeRzSK/+cgGs8A+8ar8C5PnDJ1Ox85c4sPPCkUlPo6ULqAAUCrJc
 coL7AkrPrF37fiXisQf8glVV7KrDLvrhn9efOKJiwR/6nJJpSb3L3esn0YC9LApgfjl6oN
 LzGy3NEG4iMnEtcQJkABoy4oRtBaxWH9hl8jf77zKXrg3KcsOBxPCsFl9di7F1tNWtcPAH
 gA8WrouC0wkykLqqS3ilVjbLSImU7V2lmfYivbp5PvECIREKDBW4VDvRtmuXdA==
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+267d94592+5e1e26+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 18:06:09 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <69c322e0-7e38-4ac6-b390-7a9b294261b3@yunsilicon.com>
Date: Tue, 18 Mar 2025 18:06:07 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
Message-Id: <c94717a8-0d96-4914-8e24-9eb2959aa193@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100827.555320-3-tianx@yunsilicon.com> <20250310063429.GF4159220@kernel.org> <69c322e0-7e38-4ac6-b390-7a9b294261b3@yunsilicon.com>
To: "Simon Horman" <horms@kernel.org>

On 2025/3/12 17:17, Xin Tian wrote:
> On 2025/3/10 14:34, Simon Horman wrote:
>> On Fri, Mar 07, 2025 at 06:08:29PM +0800, Xin Tian wrote:
>>> The command queue is a hardware channel for sending
>>> commands between the driver and the firmware.
>>> xsc_cmd.h defines the command protocol structures.
>>> The logic for command allocation, sending,
>>> completion handling, and error handling is implemented
>>> in cmdq.c.
>>>
>>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> Hi Xin,
>>
>> Some minor feedback from my side.
>>
>> ...
>>
>>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
>> ...
>>
>>> +static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, int size)
>>> +{
>>> +	struct xsc_cmd_prot_block *block;
>>> +	struct xsc_cmd_mailbox *next;
>>> +	int copy;
>>> +
>>> +	if (!to || !from)
>>> +		return -ENOMEM;
>>> +
>>> +	copy = min_t(int, size, sizeof(to->first.data));
>> nit: I expect that using min() is sufficient here...
> Ack

min(size, sizeof(to->first.data)) will lead to a compile warning.
size is int and sizeof(to->first.data) is size_t.
So I kept this in v9

Thanks,
Xin

