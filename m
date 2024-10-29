Return-Path: <netdev+bounces-140142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA09B5585
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1884F1F24079
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D720A5E8;
	Tue, 29 Oct 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mDhZ6G08"
X-Original-To: netdev@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B04DA03
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239600; cv=none; b=TSW40M+SgmYLG9SiTicoIWI3c+Whfk1EqsjfbuaTjPODij7wkv7xSpmkGR+zxRBj1ctmwIrj1oYYI2pBZH8+/3SW2Ig1OB8Ks2nwex6jewt2TT2iC4lDlYbKwHpZIo41aAMpm7kLOPAdyBHWs2Cxh4GLTzesWuQ4Vs18sL6CZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239600; c=relaxed/simple;
	bh=0Ca0V1ws4795fSTg7KFpAQp2Jl/PZej2hJconM1caII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vcv1Pi3Vl3uFP/6fhQ3R5Ll4a8J81v7WE/dB5zRPhp4OEi6QCjIXXzJMojcHxkAaUhJTr0HvYCNSm8kX8xT5nomQBdzD26kELn8GXhymhGkMt6WPn9+FvCNnDq5TrcnTHB+sEuWEuttfTL3XqTezwWtcz/L4o3CeHZM3B8fiE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mDhZ6G08; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 5p9at5kNbVpzp5uMHtmKDr; Tue, 29 Oct 2024 22:06:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5uMGt7ic7O7uS5uMGtxGzR; Tue, 29 Oct 2024 22:06:36 +0000
X-Authority-Analysis: v=2.4 cv=Acy3HWXG c=1 sm=1 tr=0 ts=67215c6c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=OsCCmNDR8YvOshWSOX0A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6L+AIcYL+JV6LkgiKpAQ9hPCFlnYrwwAjkUBVpKsqzE=; b=mDhZ6G08GrgtBbrU6BszzojsOs
	v/KCa3SLb70XlJX8cgbn0ZGcs2HPOA3SviPyFcF7uRPjHJIVb1Ngq98AgbyJZxVGkV9AGcJ8dRwA8
	Pd66dfVTO9iQN3xLEcp7skaNX35xrQbR/lwcsNd/yTJV9ifn699WDzKjxmDzHtgqMRspmmUBww3oh
	Fx+qPITJiOFyhimwgKFrMyimk9iIdFclmwoBTKsx9rbbbXxLRTOhgJQR0vQxUf/UP8kHT5nvRiUag
	NfTY9LFJ7hmwCoow9SAX6Fug++pknvvWTpd2PXHuzh15HB2urHeMkOWcczeHRqmYxL6vPVLocy4Kx
	gANRIC2Q==;
Received: from [201.172.173.7] (port=41778 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5uME-003llc-16;
	Tue, 29 Oct 2024 17:06:34 -0500
Message-ID: <318a0d4f-7f47-44db-93a1-aa1659d160ef@embeddedor.com>
Date: Tue, 29 Oct 2024 16:06:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241029065824.670f14fc@kernel.org>
 <f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
 <20241029110845.0f9bb1cc@kernel.org>
 <7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
 <20241029113955.145d2a2f@kernel.org>
 <26d37815-c652-418c-99b0-9d3e6ab78893@embeddedor.com>
 <20241029115426.3b0fcaff@kernel.org>
 <5aa93a65-e325-4c77-aaa8-5ef04f3b9697@embeddedor.com>
 <20241029130037.2c7e96c7@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241029130037.2c7e96c7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5uME-003llc-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:41778
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAChcT1m+YDnMhHN70qJhyBa3s2eDbb3QugZrWAD5aoeCtOWwgA5uZktYPEGAiCGM+Kc9dEAFywQZ2nla7O99JZRPNroMdVcqkk0dxrwGxEx8zZ2jwZ1
 j0wf6iiuzs6DKCDhxohEnVDIb0VIgRhzKsehMKDeQALZQ4pTm2Pi/LrzGTQe8GO357M8JC363QamJAcqQGr2ol/xYKyOxiK4M2g=



On 29/10/24 14:00, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 13:18:56 -0600 Gustavo A. R. Silva wrote:
>> By priority I mean if preserving the reverse xmas tree is a most
>> after any changes that mess in some way with it. As in the case below,
>> where things were already messed up:
>>
>> +       const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
>>           struct bnxt *bp = netdev_priv(dev);
>>           struct bnxt_link_info *link_info = &bp->link_info;
>> -       const struct ethtool_link_settings *base = &lk_ksettings->base;
>>           bool set_pause = false;
>>           u32 speed, lanes = 0;
>>           int rc = 0;
>>
>> Should I leave the rest as-is, or should I now have to rearrange the whole
>> thing to accommodate for the convention?
> 
> Don't rearrange the rest. The point is that if you touch a line you end
> up with a delete and an add. So you can as well move it to get it closer
> to the convention. But that's just nice to have, I brought the entire
> thing up because of the net/ethtool/ code which previously followed the
> convention and after changes it wouldn't.
> 
>> How I see this, we can take a couple of directions:
>>
>> a) when things are already messed up, just implement your changes and leave
>> the rest as-is.
> 
> This is acceptable, moving things closer to convention is nice to have.
> 
>> b) when your changes mess things up, clean it up and accommodate for the
>> convention.
> 
> Yes, if by "your changes mess things up" you mean that the code follows
> the convention exactly for a given function - then yes, the changes must
> remain complaint. Not sure why you say "clean it up", if the code is
> complaint you shouldn't break it. No touching of pre-existing code
> (other than modified lines) should be necessary.

Gotcha. Hopefully, this v2 is just fine:

https://lore.kernel.org/linux-hardening/cover.1730238285.git.gustavoars@kernel.org/

Thanks!
-Gustavo

> 
>> extra option:
>>
>> c) this is probably going to be a case by case thing and we may ask you
>>      to do more changes as we see fit.
>>
>> To be clear, I have no issue with c) (because it's basically how things
>> usually work), as long as maintainers don't expect v1 of any patch to
>> be in pristine form. In any other case, I would really like to be crystal
>> clear about what's expected and what's not.


