Return-Path: <netdev+bounces-152907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33D9F648A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAEE163767
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D919EEBD;
	Wed, 18 Dec 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="eDYwTyBu"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101719F103
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520522; cv=none; b=rlmLXkt2JNP5dyaoRE6cQ0fmpl8kt1MxVwqC1MkmkWiXZclg8yzON4GuGCL5k6nPC3a9G8+7smoH09rHIhLQD5MIDvDsw5qfqpfvjTsVL3uLCtoUMI4Zuu/d4xq4eOXc1SIXlXoAiCfWYzdEiNAHjxQKQ7ZuFP9KCknEYTEgve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520522; c=relaxed/simple;
	bh=YxlUgfosWoEIzovAoScRjewJa96tKumpRPIVJnX5myA=;
	h=To:From:Message-Id:Cc:Subject:Mime-Version:References:Date:
	 Content-Type:In-Reply-To; b=treO7XyuTL6JDsgyXL4bQidHXOqPEG4G4YjTyjvECI3clAthDhXEOHdGc2ZDuO3KHVTXktZG+0sQscLrHYxWLEUQVjyZ4P084V/P/WPorGvyYz/usLTwla9PMNwAi64hKwxR7/IcQofjs+RSLPU8PoDgavz6PKjYZedsYRIFS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=eDYwTyBu; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734520510; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=N5OnXUyZnvKQU2jyVAsg9qzwolvtk1Y6N8fRstEZaIQ=;
 b=eDYwTyBuFI00+7Ov3aS1ZrcmeFsJp+3mFL+YPyJaKNU9f83EP8g1lCXcA2P2BCwQR9zbBo
 2An9ST0XPE1sf5FcVp2YIdOf98/sUXK5E6eYId8WjQhxqCstiM8dg9Vu3CE4/qfjJymYoF
 T9FyeKBgU5WI95XdtagVjPpffnnCLHS6pJBcBGSsq4+4qOdVQqeJ2k1AipfKZgiEK0nDqw
 iHktlVDl1Yz8R0eZpPAt5e5D4sySnH1mSCkXLxomoeUXQWbB8jWp/E29OZnmflDYQ0Z8kC
 pXjMOq1BMP5Gxy2TC3prUoW2OPJyzxtP6Bc5fW4YdWdzwx1Qh6w9oU3V3poE8g==
To: "Andrew Lunn" <andrew@lunn.ch>
From: "tianx" <tianx@yunsilicon.com>
Message-Id: <fc27f43a-eed7-4834-b170-0ec8ba33aaa0@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <weihg@yunsilicon.com>
Subject: Re: [PATCH 15/16] net-next/yunsilicon: Add ndo_set_mac_address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <20241209071101.3392590-16-tianx@yunsilicon.com> <f84ad3c2-ef22-47b6-bc10-b7e8fdfb1ca0@lunn.ch>
Date: Wed, 18 Dec 2024 19:15:06 +0800
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
X-Original-From: tianx <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 19:15:07 +0800
In-Reply-To: <f84ad3c2-ef22-47b6-bc10-b7e8fdfb1ca0@lunn.ch>
X-Lms-Return-Path: <lba+26762aebc+ae805d+vger.kernel.org+tianx@yunsilicon.com>

Have been fixed in patch set v1, thank you

On 2024/12/9 21:55, Andrew Lunn wrote:
> On Mon, Dec 09, 2024 at 03:11:00PM +0800, Tian Xin wrote:
>> From: Xin Tian <tianx@yunsilicon.com>
>>
>> Add ndo_set_mac_address
>>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> ---
>>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |   4 +
>>   .../net/ethernet/yunsilicon/xsc/net/main.c    |  48 ++++-----
>>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
>>   .../net/ethernet/yunsilicon/xsc/pci/vport.c   | 102 ++++++++++++++++++
>>   4 files changed, 130 insertions(+), 26 deletions(-)
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
>>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> index 979e3b150..8da471f02 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> @@ -613,6 +613,10 @@ void xsc_core_frag_buf_free(struct xsc_core_device *xdev, struct xsc_frag_buf *b
>>   int xsc_register_interface(struct xsc_interface *intf);
>>   void xsc_unregister_interface(struct xsc_interface *intf);
>>   
>> +u8 xsc_core_query_vport_state(struct xsc_core_device *dev, u16 vport);
>> +int xsc_core_modify_nic_vport_mac_address(struct xsc_core_device *dev,
>> +					  u16 vport, u8 *addr, bool perm_mac);
>> +
>>   static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
>>   {
>>   	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
>> index a3b557cc5..1861b10a8 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
>> @@ -1349,37 +1349,13 @@ static void xsc_eth_sw_deinit(struct xsc_adapter *adapter)
>>   	return xsc_eth_close_channels(adapter);
>>   }
>>   
>> -static int _xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod,
>> -				  u16 vport, void *out, int outlen)
>> -{
>> -	struct xsc_query_vport_state_in in;
>> -
>> -	memset(&in, 0, sizeof(in));
>> -	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_VPORT_STATE);
>> -	in.vport_number = cpu_to_be16(vport);
>> -	if (vport)
>> -		in.other_vport = 1;
>> -
>> -	return xsc_cmd_exec(dev, &in, sizeof(in), out, outlen);
>> -}
>> -
>> -static u8 xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod, u16 vport)
>> -{
>> -	struct xsc_query_vport_state_out out;
>> -
>> -	memset(&out, 0, sizeof(out));
>> -	_xsc_query_vport_state(dev, opmod, vport, &out, sizeof(out));
>> -
>> -	return out.state;
>> -}
>> -
> More code which appears to of been added in the wrong place to start
> with, and now gets moved.
>
> 	Andrew

