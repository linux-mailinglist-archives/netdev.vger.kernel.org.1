Return-Path: <netdev+bounces-138410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383149AD6B9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EFFB22835
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6BF171671;
	Wed, 23 Oct 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tA0gtF8F"
X-Original-To: netdev@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA915573D
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719038; cv=none; b=Nd69P9SPVImFub+oVoDu2YHOUp+uiGIB3YxIHEBNkjSWDVec6Nxs97wOKR5JYej7UHc+Qilg+MqBI/GY6SqLByF1gj4g99UlrkHE0RlhrezXv7axhWow/i/Q2+MF9yRglKKwdMjqNnzdGigRTAN8rClBQY1aBOADdqa1vZnRa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719038; c=relaxed/simple;
	bh=fPqUfh5O1P7kOgNYUDI+Fyksx0nelMxwaPjPhfGk3yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJm9aINHV2ysBoZLerGNqenurEFxxmN06bT73znTO+VncQxjnnlBRwbZv/pDkiZJr4+rdA1gAfAxGOXI6kXMztt4tUqep5HTZRjkgCqpTTFctWi9XMpak0l2pEht/NOzNqa7K5S71g45wYvY28OOlgPyFYWibyRp9nDboua8+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=tA0gtF8F; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id 3f1NtBNgfumtX3iw2tYIOb; Wed, 23 Oct 2024 21:30:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 3iw1ticjumNYj3iw1t3Vtn; Wed, 23 Oct 2024 21:30:30 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=67196af6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=8Fy0PtBgQ4eIbHuuQ40A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QltWdEL6XPLcPOOTcEu6Kid18we0qiV6s7ZY3NrfNII=; b=tA0gtF8FeXh015sRfJhtppXcJ0
	Ume2ncHkvHKQYzYPkSaV7zaNJQJutuV+LmS97twE/QxS+NyJN2Bzi8La/Mw/QDKVEe9zDD8Dmr+zw
	Degt3VmfD9nmLpJ0o1qguLaamjP2mf+7Ub4B6s7dOoQblA/defMf9OydkGj5DaJKJ4UcRjQoT4PtC
	seZLgcXNJOtF/mULIM+vm0vM/LzF8HfuE4XtoQ2vVVby/js+vfwo+IxGC1vEFY9v7YWT+QIRG2Djp
	pScvr7acqkenafKLWHKOI7CpY0d19N57soacNsUU6HI17+PwAYAFzjtWMv4/s7ZtqCKNY/7/UqVbO
	r5RS+diA==;
Received: from [201.172.173.7] (port=42804 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t3ivz-000XxR-13;
	Wed, 23 Oct 2024 16:30:27 -0500
Message-ID: <2b7e1535-2d7a-4c7c-9687-9ddd42392802@embeddedor.com>
Date: Wed, 23 Oct 2024 15:30:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][next] UAPI: ethtool: Use __struct_group() in struct
 ethtool_link_settings
To: Andrew Lunn <andrew@lunn.ch>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <e9ccb0cd7e490bfa270a7c20979e16ff84ac91e2.1729536776.git.gustavoars@kernel.org>
 <53721db6-f4b1-4394-ab2a-045f214bd2fa@lunn.ch>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <53721db6-f4b1-4394-ab2a-045f214bd2fa@lunn.ch>
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
X-Exim-ID: 1t3ivz-000XxR-13
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:42804
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAAUZc8gFmlVwzTT+DRMhxr5Tg/cJ+PVrfOkLkytSq/U7SbrJ2aAoO41XQ0AMxYJT8tapt6GYo0cuTMaRJptBxl0URCqB1/MQrRrFD86sPfNkAbRBQdg
 XxeOd4vmrLjUQLYo8qxpPwkqWBnSjw9t2an1shhpmKJV6jOo16641ySE3VGZYkMFmCujaXlGg5KgF2w3X5vBJLwZngXEDMxPnms=



On 21/10/24 14:11, Andrew Lunn wrote:
>>   struct ethtool_link_settings {
>> -	__u32	cmd;
>> -	__u32	speed;
>> -	__u8	duplex;
>> -	__u8	port;
>> -	__u8	phy_address;
>> -	__u8	autoneg;
>> -	__u8	mdio_support;
>> -	__u8	eth_tp_mdix;
>> -	__u8	eth_tp_mdix_ctrl;
>> -	__s8	link_mode_masks_nwords;
>> -	__u8	transceiver;
>> -	__u8	master_slave_cfg;
>> -	__u8	master_slave_state;
>> -	__u8	rate_matching;
>> -	__u32	reserved[7];
>> +	/* New members MUST be added within the __struct_group() macro below. */
>> +	__struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
>> +		__u32	cmd;
>> +		__u32	speed;
>> +		__u8	duplex;
>> +		__u8	port;
>> +		__u8	phy_address;
>> +		__u8	autoneg;
>> +		__u8	mdio_support;
>> +		__u8	eth_tp_mdix;
>> +		__u8	eth_tp_mdix_ctrl;
>> +		__s8	link_mode_masks_nwords;
>> +		__u8	transceiver;
>> +		__u8	master_slave_cfg;
>> +		__u8	master_slave_state;
>> +		__u8	rate_matching;
>> +		__u32	reserved[7];
>> +	);
>>   	__u32	link_mode_masks[];
> 
> Dumb C question. What are the padding rules for a union, compared to
> base types? Do we know for sure the compiler is not going pad this
> structure differently because of the union?

We've been using the struct_group() family of helpers in Linux for years,
and we haven't seen any issues with padding an alignment. So, it seems
to do its job just fine. :)

Thanks
--
Gustavo

> 
> It is however nicely constructed. The 12 __u8 making 3 32bit words, so
> we have a total of 12 32bit words, or 6 64bit words, before the
> link_mode_masks[], so i don't think padding is technically an issue,
> but it would be nice to know the C standard guarantees this.
> 
> 	Andrew

