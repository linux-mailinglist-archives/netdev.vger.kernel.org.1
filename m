Return-Path: <netdev+bounces-152906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9E9F6477
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A05E160CEB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6914519CC11;
	Wed, 18 Dec 2024 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="XG48T+f1"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682217C219
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520405; cv=none; b=OrvHfbXPXDoYM/TawQvh4UA7wmjNk65Kdp6P1iY07sheEku4rlaoW8LjeBueTzsol+gXrScayNMTuKPdvFd7eQig83TAGOJbO+ywLO+V145P6Rfyz4arld5Mx9MJBzUuwatJ2LFvvcWwg6JtdL+hdUyKqpkqF08FlEEmNcg8akM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520405; c=relaxed/simple;
	bh=P8CRmk/GS41M3KdN6yLTqVUf5trG7Y3Vqhc8BwNBmCA=;
	h=Cc:From:Mime-Version:References:In-Reply-To:To:Subject:Date:
	 Message-Id:Content-Type; b=a2BV/7iAZU0OpPKRjLX80xSCraTBfVhLcfFtRzLO4us6ldfRMuIYRtDIXaayr8iI1Aq92ujfEE7GMA/qwLxSUEOONQmWID7cMJ+esM2UL8taD8OEIA449pyVQuig4RQA90jXj8i5gg8BFAlTZi13wgX9vrQWYEZ928kovlGNh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=XG48T+f1; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734520396; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=s1ZPVkdCevxxlWNS62y5l5RxPldthOEC2qxfQZeZhwg=;
 b=XG48T+f1N5kFWnlV2Z4shP5jF0tMj4dc7PykbsTzVTuI2T9XsOi+NJQ7vCvAGt8WD8+NvI
 8yshZmOdXku2C9u8Dzt9gH9JIHHZqjHTMwUaG5+NjtItL2f3N0Pq51/0HoIpOLiyppJWDE
 rzcMXlUfW4dSVaxS0hN6kk3wagibM6RwMsuSURexFUHE9laEofqzQqt2Srxm2XqUc+gFLo
 KFui0iaWW4CXGsk+pfTHDO87Q3jiTF63hUSe9+jdKh5m6DHHJ5JOMTfW4Vtywkc1iRFCTk
 PMf3zFhyIDBWCWNRF94Hh/X1VeuhEcey2Cz7e7SQ1w9RAt3zDPvCtstgP5U39A==
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <weihg@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209071101.3392590-10-tianx@yunsilicon.com> <902c3782-b562-457c-a610-91e4e53e2a19@lunn.ch>
X-Original-From: tianx <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 19:13:14 +0800
X-Lms-Return-Path: <lba+26762ae4a+ed2b97+vger.kernel.org+tianx@yunsilicon.com>
In-Reply-To: <902c3782-b562-457c-a610-91e4e53e2a19@lunn.ch>
To: "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH 09/16] net-next/yunsilicon: Init net device
Date: Wed, 18 Dec 2024 19:13:13 +0800
Message-Id: <e894983c-eb35-4496-9639-6cb065d456b2@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird

On 2024/12/9 21:47, Andrew Lunn wrote:
>> +#define SW_MIN_MTU		64
>> +#define SW_DEFAULT_MTU		1500
>> +#define SW_MAX_MTU		9600
> There are standard #defines for these. Please use them.
In v1 serious

64 replaced by ETH_MIN_MTU
1500 replaced by ETH_DATA_LEN

>> +#define XSC_ETH_HW_MTU_SEND	9800		/*need to obtain from hardware*/
>> +#define XSC_ETH_HW_MTU_RECV	9800		/*need to obtain from hardware*/
>> +#define XSC_SW2HW_MTU(mtu)	((mtu) + 14 + 4)
>> +#define XSC_SW2HW_FRAG_SIZE(mtu)	((mtu) + 14 + 8 + 4 + XSC_PPH_HEAD_LEN)
>> +#define XSC_SW2HW_RX_PKT_LEN(mtu)	((mtu) + 14 + 256)
> Please try to replace these magic numbers with #defines. Is 14 the
> Ethernet header?  ETH_HLEN?
>
> 	Andrew
Yes, 14 is ETH_HLEN, 4 is ETH_FCS_LEN, 8 is VLAN_HLEN * 2 and 256 is a 
remaining space needed by our hardware. This have been modified to 
MACROs in the v1 patch set. Thank you.

