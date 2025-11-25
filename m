Return-Path: <netdev+bounces-241465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C5C84249
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 213E334C381
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69B2D9ECD;
	Tue, 25 Nov 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WcvL0bGL"
X-Original-To: netdev@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E949217736
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061673; cv=none; b=PeibXu+FUrVtyowOP7hcymbyMAA37hvzasvdkpkCTl4n2E+YC7sxMyggIXWWa7beAyc5x85YzpaALSjc15TwTLgkLvL7UrP0sT6sUOl6AYJ60fakson1sKaGV18sQMoOmz0eX/zuWdNPvvLsV4/F9fHCujSTmXFWZ8xxngYucW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061673; c=relaxed/simple;
	bh=xSbR5S/iLxMJGP0NhknpHThvijIg6oVzA980cnORheA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrQXhxYyrjiABGrCm1+9lkHiGyvEw28hMA0wv9DHYnV/zw5FiW5CkaIfC0GsPY5nPLnOxVxY+FHUlaGutttjUSo2TrEZjWzWIQMGUUNvj4IGADJk+ml2lOBw8byembD1G+Ey5bggfgMcFhNZvOqwgLxWFHDQGiSuH2AZ2TbQ0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WcvL0bGL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id NousvMq91KjfoNp1UvMwD3; Tue, 25 Nov 2025 09:07:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Np1SvwrsiK8vzNp1Tv1ihp; Tue, 25 Nov 2025 09:07:43 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=692571df
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Fy9zNX-n0jQFUyfwix0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=93h1aLlDOP9GpHRPrxBcJJ1XQTSpZm47tWtBTy4lHx0=; b=WcvL0bGL37SDAEDGa9NT/Py4aM
	/pRhTUddp9NA9FebfaLypBHyMlU8aqwm9yjfDI3BxFG/ShytIXmRGUBborUR3N3dinzIjWp5Ec5MG
	1Y3mK5T1zNnJ1BlriSj4LSHfRxpPiyj9uDkP+AktwaZQ5m+ZXGAfVl0Au/7pnCtizXBkPmQPFVynT
	VxhK/PQ4Y2elbT/RW3fRa6EzhpzjvGHGiqMZwoQrW1FRsuJVLuZs0ZKyapn1+ih2Sxz+Ml1tbhKZZ
	5FI2OYm40eizvJVBVYFHG7eGhTCL9T95TU7mwNQPPJI6EH08RXMf/NRY37DAus0CIJC1WZku+ttEV
	U14h+gYg==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:60834 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vNp1S-00000002IxR-18lv;
	Tue, 25 Nov 2025 03:07:42 -0600
Message-ID: <ce80cdaa-f21e-4894-ab90-b4b05d03381d@embeddedor.com>
Date: Tue, 25 Nov 2025 18:07:31 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aSUwOtiDMYA8aSC3@kspp>
 <CAFEp6-10WCGvGrRMh0q1DKYK+C+qm9yh-C7bGgdEFccM9TUbdA@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAFEp6-10WCGvGrRMh0q1DKYK+C+qm9yh-C7bGgdEFccM9TUbdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vNp1S-00000002IxR-18lv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.221.86.44]) [118.18.233.1]:60834
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFf5BEiBGOshfxcJ2FA3PCuYuI1khlAH6h9GGA7hYVsGY9fp0BSaWcCzz7IKqK/ArtKgkgO1HsRDXm4/22wk4OAQv+nctyXTV6jUt0ohA2xQ6C9CgcNp
 EuEvWnLrsCXKJHtEyq2bhFHYQ0LBxBpDCAhZgotW3EsuJIHtdLDyEAFiP54Bbds+hdBy/jXJSAg/A9e7WV/55W8bCWkHNRDs22k=



On 11/25/25 18:02, Loic Poulain wrote:
> On Tue, Nov 25, 2025 at 5:27 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> Use DEFINE_RAW_FLEX() to avoid a -Wflex-array-member-not-at-end warning.
>>
>> Remove fixed-size array struct usb_cdc_ncm_dpe16 dpe16[2]; from struct
>> mbim_tx_hdr, so that flex-array member struct mbim_tx_hdr::ndp16.dpe16[]
>> ends last in this structure.
>>
>> Compensate for this by using the DEFINE_RAW_FLEX() helper to declare the
>> on-stack struct instance that contains struct usb_cdc_ncm_ndp16 as a
>> member. Adjust the rest of the code, accordingly.
>>
>> So, with these changes fix the following warning:
>>
>> drivers/net/wwan/mhi_wwan_mbim.c:81:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I just noticed there’s a V2, so:
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Thanks, Loic. :)

-Gustavo

