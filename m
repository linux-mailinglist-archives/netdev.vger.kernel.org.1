Return-Path: <netdev+bounces-139722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C699B3E7E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09108283508
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F71E0B61;
	Mon, 28 Oct 2024 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SVtJPMUi"
X-Original-To: netdev@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F831925B3
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158381; cv=none; b=iG1usz4wGJivYDaGRnrh4+hgiO1g5tF5EU9sgc0s3dTcQuij3iT3Jd1rdvgotj61FGEWo8DBJ3CpOZ5lUC8R7FuyAn/iMYWIwF9nawbNWFYSpNQQM+ngsjjYyFFqYdKX+sd9PZD6KFqTYYMp+ddmWYfqXcbUm+1WOmqOUaBlhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158381; c=relaxed/simple;
	bh=RtCS7lHR0LRDRLoeU3O3Ly3LNOj3HoTC4oF3o/Mqe/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpfVk3mtqetsw8eBmJL3O3C5UP6gIsn+cXeDczs2FLvcS6ttvrfboQVLcrgmaZMdueCHTY0QhdbRRV5x71SZOQ3jHrHgDMI9zOTlzMfzXN6j7oPf2/m7VOZt+4nxhXTxh0UUBUjmlWRFz92Z/1DaiQUaH2sEX3SS5maZVoNSRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=SVtJPMUi; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id 5SAHtZm7Dg2lz5ZEItODA0; Mon, 28 Oct 2024 23:32:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5ZEHtlHwzqHCr5ZEHtQSIW; Mon, 28 Oct 2024 23:32:58 +0000
X-Authority-Analysis: v=2.4 cv=epvZzJpX c=1 sm=1 tr=0 ts=67201f2a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=GBAvCzrZPYQCsMOAwX0A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BIzwlyyyd/IYUg64cRhgHObYnnTGPOZvFSvdyRlz/Ig=; b=SVtJPMUiBkyxbEICXAGC1WB77p
	ltlT2bB8Q/ganOZ5rEZdsKIVRYAajBo+rWitxazaNLsiicProME8XyldZEhlbOEfTAhvxr9Ty5Xr+
	MdYrVdfm2e5zLVxV7We2F9dZA8nJlpfe9IDXqwIdATPXe3ljOGSeclUFtDV4WWLXaOaR8jwZ29U7h
	sbgARU7fiPbq/PlKddHCPh78nftlMb+nCx/dgHEsjGLA2FXcdYsEeMzBrJhdjSyYF2p9X43x+xMWd
	axWQJSIRJ+E0o2eTdMfFBEX5Qeda6iHvtlY6JINb4xVrYI4NqG9mnZqkT7EDCIgkZ6Ek5Kfia1SrI
	rOGBB56w==;
Received: from [201.172.173.7] (port=34890 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5ZEF-003rjt-36;
	Mon, 28 Oct 2024 18:32:56 -0500
Message-ID: <158eb222-d875-4f96-b027-83854e5f4275@embeddedor.com>
Date: Mon, 28 Oct 2024 17:32:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241028162131.39e280bd@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241028162131.39e280bd@kernel.org>
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
X-Exim-ID: 1t5ZEF-003rjt-36
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:34890
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM+XCiFQGWvJvSdvCIdLtqaKMndadgH0mYKlAZG6QXZ4gwNu9ZsXhHblIknjsQl2LzuNTD/mfwEReIe/3HW5k/eqH96KHb2OqZVmjC4ECN27uGdZbsyI
 WP4LZ6TSk1gwQywrGtRAP5pH6lYbkSGKr+PkLzNHznh/v9YHdoVgM8fBWs4LPF8iYaXSCDdWHczctoIjS5yoFItkyFzpR/7HaM4=



On 28/10/24 17:21, Jakub Kicinski wrote:
> On Mon, 21 Oct 2024 13:02:27 -0600 Gustavo A. R. Silva wrote:
>> Fix 3338 of the following -Wflex-array-member-not-at-end warnings:
>>
>> include/linux/ethtool.h:214:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> I don't see any change in the number of warnings with W=1:
> gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
> Is it only enabled with W=2?

-Wfamnae is not currently part of any upstream build. We are working
to have it enabled. So, these warnings are the ones I see in my local
build with the following patch applied:

diff --git a/Makefile b/Makefile
index d4a41c44e0fc..08d18b5d01f5 100644
--- a/Makefile
+++ b/Makefile
@@ -1002,6 +1002,9 @@ NOSTDINC_FLAGS += -nostdinc
  # perform bounds checking.
  KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)

+# Avoid flexible-array members not at the end of composite structure.
+KBUILD_CFLAGS += $(call cc-option, -Wflex-array-member-not-at-end)
+
  #Currently, disable -Wstringop-overflow for GCC 11, globally.
  KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) += $(call cc-option, -Wno-stringop-overflow)
  KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) += $(call cc-option, -Wstringop-overflow)


> 
>> Additionally, update the type of some variables in various functions
>> that don't access the flexible-array member, changing them to the
>> newly created `struct ethtool_link_settings_hdr`.
> 
> Why? Please avoid unnecessary code changes.

This is actually necessary. As the type of the conflicting middle members
changed, those instances that expect the type to be `struct ethtool_link_settings`
should be adjusted to the new type. Another option is to leave the type
unchanged and instead use container_of. See below.

So, instead of this:

-	struct ethtool_link_settings *base = &link_ksettings->base;
+	struct ethtool_link_settings_hdr *base = &link_ksettings->base;

we would do something like this:

-	struct ethtool_link_settings *base = &link_ksettings->base;
+	struct ethtool_link_settings *base = container_of(&link_ksettings->base,
+							  struct struct ethtool_link_settings, hdr);

I think that in this case, we could avoid using `container_of()`, but
if you prefer that, I can update the patch.


> 
>>   include/linux/ethtool.h                            |  2 +-
> 
> This is probably where most of the warnings come from.
> Please split the changes to this header file as a separate patch
> for ease of review / validation.
> 

Sure thing!

Thanks
--
Gustavo


