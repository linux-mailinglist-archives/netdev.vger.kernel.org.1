Return-Path: <netdev+bounces-171497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4739DA4D32A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 06:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8DA170D0D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077601F4624;
	Tue,  4 Mar 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="gYsSfp9N"
X-Original-To: netdev@vger.kernel.org
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AE158868
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067719; cv=none; b=i8HDcho46x8u1YNhzatw7a7Dp1tenWCWP+vtXtu626Y28Affgla+BdYtxrqWGgjeM07Fcta5/PvIORc2AqXngCmQiaoLxoKpS5EeHFMzgWYh2hfe0Yi3wptqJW40H+tKL/jI4jisaPdjISujzK1/WapS/fQjNx+svxpkPoDXRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067719; c=relaxed/simple;
	bh=TGEvfwPs0JW8HAQI03Tc5WPxsyXCR7IIotUNAiJTF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQR3eaRpJIGbTPO16XrAi+2JdGvwajcb/c8fHNPqBPmSy+xNqZvWpnLBY+4I4aFOzMNFKDmNK/OAFTeXHM0Lxfx9RsYz8Nvy4i4raLYk7/i2V/D3ZL9sKOFilgm2x1mCQOk/YQMHLDJk9yic8EAjrXY3HPYZD8SdjnffB9iPJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=gYsSfp9N; arc=none smtp.client-ip=81.19.149.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BG6G0QAs416ABSjxTgRSPjNgdwSP+dDPdh+JIuJB1v4=; b=gYsSfp9NzKqwqqQztUZ0dy0Zrg
	YNsCRc6rHzooakOsUiANrtrT/TohI7RzmaSntIC9CqZX3FYY5ahrmsxsX9G1o26W8jqZhTZqrth4m
	6jbSmmfV+DxF7jESJXXqMmETsN8jmiBiSFllLGFPjkZh/7ZyOKNJOFBQu6zAlRFOVT0c=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tpLF8-0000000050U-0oXE;
	Tue, 04 Mar 2025 06:55:02 +0100
Message-ID: <36e2c2b6-e8d2-4304-87d9-8dc79e4e5482@engleder-embedded.com>
Date: Tue, 4 Mar 2025 06:55:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/8] net: selftests: Support selftest sets
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
 <20250227203138.60420-7-gerhard@engleder-embedded.com>
 <20250303174129.21aa5f88@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250303174129.21aa5f88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 04.03.25 02:41, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 21:31:36 +0100 Gerhard Engleder wrote:
>> +/**
>> + * enum net_selftest - selftest set ID
>> + * @NET_SELFTEST_LOOPBACK_CARRIER: Loopback tests based on carrier speed
> 
> why are these "tests based on carrier speed"?
> these tests use default parameters AFAICT, I'm not seeing the relevance
> of carrier.. Maybe you can explain.

genphy_loopback() and most PHY specific loopback implementations
use the speed of the current carrier to determine the speed of
the to be configured loopback mode. Therefore, a carrier/linkup is
required to execute these tests successfully and I assume that's why
the already existing test set checks for carrier first.

I will enrich the comment of this test set.

> 
>> + */
>> +enum net_selftest {
>> +	NET_SELFTEST_LOOPBACK_CARRIER = 0,
>> +};
> 
>> diff --git a/net/core/selftests.c b/net/core/selftests.c
>> index e99ae983fca9..ec9bb149a378 100644
>> --- a/net/core/selftests.c
>> +++ b/net/core/selftests.c
>> @@ -14,6 +14,10 @@
>>   #include <net/tcp.h>
>>   #include <net/udp.h>
>>   
>> +struct net_test_ctx {
>> +	u8 next_id;
>> +};
>> +
>>   struct net_packet_attrs {
>>   	const unsigned char *src;
>>   	const unsigned char *dst;
>> @@ -44,14 +48,13 @@ struct netsfhdr {
>>   	u8 id;
>>   } __packed;
>>   
>> -static u8 net_test_next_id;
> 
> The removal of the global state seems loosely connected to the rest,
> the global state is okay because we hold RTNL across, AFAIU, which
> will still be true for tests varying speed. Not using global state
> is a worthwhile cleanup IMO, but I think you should split this patch
> in 2.

I will split this into a separate commit.

Thank you for the review!

Gerhard

