Return-Path: <netdev+bounces-116107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642A9491D3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0EC1F24311
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD01D2F74;
	Tue,  6 Aug 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vJ+Ta7uF"
X-Original-To: netdev@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDB1D2F65
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951753; cv=none; b=AhmYDIu4PCzmxD4AjWqPaREcW83pUpetFT5o4GOzaHf1BCPRnWPfljkj9dc960I0YfH/R1RKdXgKL2rmXu/wN6zuEcc+51xG5j6GEWlUZRjMYN2KQ6qj4/KiyP8axmE6p7lQ4jqX4LP6OOet+6eMFd1HlNbxx7DxbPUkrkY8U0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951753; c=relaxed/simple;
	bh=n7HWtJ2Q5oFAz2w27Cnx+HGUSNBLUy2DLPoYOD+2aZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuECiZQjCrDxTQa1tOY2ZYrUHlCTDtUA+zbooUOh/ElAC04bOeqn952S1ORAeZlL3JeTdNFrKoBVabJEQUG19H5jLdT6B+XPcPbPomEySXQabOQmtkXknT2A6ruFcMmvACQplXqa9MHzKUxj4z+jCz1GtZ1KFnPglXd9PV7Q1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=vJ+Ta7uF; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id b7cRsazAUumtXbKSHstAUf; Tue, 06 Aug 2024 13:42:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id bKSFsdOR3eieBbKSGs0xN9; Tue, 06 Aug 2024 13:42:24 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=66b22840
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=dkpxNnpPgF_yB_CXFPwA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3t1+IP/qL/b1YIZ9yGD29vrZYQYidH1DMEuJE91dz9Y=; b=vJ+Ta7uF7VP9ifckAl/LUmNjo1
	cVOgXpSfoMNe5WP3GUeuh7vcP5G0vBy2WtE32lx1Crdb31GMqyjNglYjsQ2JzEnOr54gQp9HuYYSt
	J54F52l/Uu7INvGnj/HGgW3WRm4xbmrFKY2SnFv/LBl/+yNZWIFWlPgaTGHm4bk7FqOJdfUfM8EHt
	T9L3lm7PfNyhde40L4E/hn3dz7EPEioVJGoXIqZfk+6u1b6rTSWj0TpRzjtg3YT+/+zBgxcI+E+Xt
	idkKM/faKzyq7XtdwmKlB9MnfHe0M1Gthfnypt8zStNUyjH3J0sGmhMTXeej+UHkPQex3ewoPQ+ko
	6ssNuk0w==;
Received: from [201.172.173.139] (port=56644 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sbKSF-003FWx-1G;
	Tue, 06 Aug 2024 08:42:23 -0500
Message-ID: <8e19df11-a64b-4fae-863a-c141612a3d36@embeddedor.com>
Date: Tue, 6 Aug 2024 07:42:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH][next] net: atlantic: Aavoid
 -Wflex-array-member-not-at-end warnings
To: Igor Russkikh <irusskikh@marvell.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZrDwoVKH8d6TdVxn@cute>
 <0d0a030c-b1ba-77a7-71f5-55448f6797f6@marvell.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <0d0a030c-b1ba-77a7-71f5-55448f6797f6@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sbKSF-003FWx-1G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:56644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKZEmHrsihtuwblAAEjSs95UW/voghJHPb72LLcysV3P9Esc4SNtoo1IvBp+ePtbUslIin+iAXpzR9ROOHxwgC/h2LQnMZtkP/XBj2Rm+P4GGOZHT1SW
 igBW/a4sknkPiYu9rHm2XWi/7nzIqMKRc/XcsDq9U+0B4Pz0IQcsEnKDjsctaDp1ggWtlL2Loho7Up1RQsmMSpEDsdgOSIIUXKA=



On 06/08/24 03:42, Igor Russkikh wrote:
> 
> 
> On 8/5/2024 5:32 PM, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally. Move the conflicting declaration to
>> the end of the structure. Notice that `struct hw_atl_utils_fw_rpc` ends in
>> a flexible-array member
>>
>> Fix the following warnings:
>>
>> drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure
>> containing a flexible array member is not at the end of another structure
>> [-Wflex-array-member-not-at-end]
>>
>> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning:
>> structure containing a flexible array member is not at the end of another
>> structure [-Wflex-array-member-not-at-end]
> 
> Hi Gustavo!
> 
> I was abit curious about this variable length structure, because it looks strange and not actually used by driver.
> 
> I've cross checked, and its really some outdated declaration. The structure is never used as as a flex sized struct.

Oh, this is great to know. Thanks for looking into this!

> 
> So better would be to do just this:
> 
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
> @@ -226,7 +226,6 @@ struct __packed offload_info {
>          struct offload_port_info ports;
>          struct offload_ka_info kas;
>          struct offload_rr_info rrs;
> -       u8 buf[];
>   };
> 
> Let me know if you want to submit this, or I can do this as well.
> 

Feel free to send a patch if you wish. :)

Thanks!
--
Gustavo

