Return-Path: <netdev+bounces-86064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CA89D6E1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0403D1F22111
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898980BE3;
	Tue,  9 Apr 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Yo9SF1UK"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77C83CB0
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658035; cv=none; b=cZlCV9YUXFUSgw6xAX+AJjWlrKoqt/Zqv44WtW7hQqWKwr/1r5HAgvKWkJrtDwdQXxKZi2QCVsSWU+WwEPnU3BN2XTX7wFb5AHv3aDzOuThQ2Gk9VXTH6bzLSMxMHoKuPaPCqau5HLERB7QXLAPUKjFuHyPJMuRb336byyZ0sWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658035; c=relaxed/simple;
	bh=CaT+cjloq34Q00EOO5ILAi1fb7VQDdoRvDKUi4PsZEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK1VZUgsIr26ROEQBybL0xD2sdyBfLwlXLJl3AnxPtl1YxG4ouFduHIWOC/3RwccvAkgbIXAjtqSeuxjXrCeze2k3dxxYXDb3kZNE03cZYT2CFxLo9UmiHPvgcu9ibsZBE6ZfiROZHYx69W8+hhU7pWLQ2zKTB8UBzGeOx1d61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Yo9SF1UK; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240409102022d9f289d65687ec7d12
        for <netdev@vger.kernel.org>;
        Tue, 09 Apr 2024 12:20:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=j63MEtqXECtXix4olcgXg2a7lMALxtuK8pCBS/su/UI=;
 b=Yo9SF1UKQfnzeHRF/q11v/cCHOZ9PmXyu0azHBUm7tY5yRS0bnNKlfkzJva/yWd8avu38j
 t0SG7A0DGX/IK4FaY6x/O6wOR+D/EuxG5pAENEiVApnDr9PL29NFjSJpgjau13BuJYUeAyho
 diLG5OGjVq22o6wuFDsXBuymjdweM=;
Message-ID: <e00f2f63-5917-47b4-a84d-075843af21a2@siemens.com>
Date: Tue, 9 Apr 2024 11:20:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 02/10] eth: Move IPv4/IPv6 multicast address
 bases to their own symbols
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch,
 danishanwar@ti.com, rogerq@kernel.org, vigneshr@ti.com,
 jan.kiszka@siemens.com
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
 <20240403104821.283832-3-diogo.ivo@siemens.com>
 <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 4/9/24 10:07 AM, Alexander Lobakin wrote:
> From: Diogo Ivo <diogo.ivo@siemens.com>
> Date: Wed,  3 Apr 2024 11:48:12 +0100
> 
>> As these addresses can be useful outside of checking if an address
>> is a multicast address (for example in device drivers) make them
>> accessible to users of etherdevice.h to avoid code duplication.
>>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Changes in v5:
>>   - Added Reviewed-by tag from Danish
>>
>>   include/linux/etherdevice.h | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
>> index 224645f17c33..8d6daf828427 100644
>> --- a/include/linux/etherdevice.h
>> +++ b/include/linux/etherdevice.h
>> @@ -71,6 +71,12 @@ static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
>>   { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
>>   #define eth_stp_addr eth_reserved_addr_base
>>   
>> +static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =
>> +{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
>> +
>> +static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
>> +{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
> 
> I see this is applied already, but I don't like static symbols in header
> files. This will make a local copy of every used symbol each time it's
> referenced.
> We usually make such symbols global consts and export them. Could you
> please send a follow-up?

I forgot to ask, should this exporting happen in 
include/linux/etherdevice.h?

Best regards,
Diogo


