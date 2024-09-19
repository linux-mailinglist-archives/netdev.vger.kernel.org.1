Return-Path: <netdev+bounces-128947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB64F97C896
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0818D1C2378C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131019D089;
	Thu, 19 Sep 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="D1Tb7bJu"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA019D075
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745237; cv=none; b=IY3Uz8GXvfdd/C7UanIXKFVrVJbTgS2xKxKfpCEZEZaig3XFiRX2FpnJH8aM/mWTavpZmcDcGBry3XVOYBaZNXrpLiUh7yDSqteickjpO/0jJgwhwPVDau5Q6cMHOMRs9+Ea55QfhDDjpk+/nY+AM8gdrluqnLz1ztWkApMBk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745237; c=relaxed/simple;
	bh=fgVpUcAySeIBeP8k8gsO91t2btH/xXxOVxiOXuh+m1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCB3njv+EuK7NMqX9gT2+kI5NLOKH05wu/wDD5ob/dkAJIaOGpGLSuNH7eBct2CgmaTNcjRR3s5cZ9YZv9OkWFt/1YXk3v9mZXyqPwJB7HRw2vewgrFbN5gQpYMXBMBLbfjsMdojm00JEcTmY1zuJ5oU0yhrnVdWvhq/mlJV6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=D1Tb7bJu; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726745235;
	bh=KdTvDYdRoGxP0L4oFQjsqH/WGJexNKEo7pYA5j9xk5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=D1Tb7bJu98fN+lzZqsHWZHZzF4uly7VEXIjKR+QB6Koljsz6pVl4XVP2TVn1jvvaK
	 OedVePhQ01AmvUXM8IKlq7nqcVYec5mn6ftTUsljra5n3MFBXRKYq16gw6hx+8dzxR
	 KArX3A/0/Qw2PyzOlo1SmHQQAcr+4OweDcwEpZSPsAZ4n6RN8f4QhusISYIqeEiXJj
	 TKViU8my938iLuUZbKNkmSAgC/1+iFSD9IRN8I2U348kB61d8RCaBbcsFWTfeCztiy
	 HIv39jKSCCRlIL+nzkkEE+G8kcjO+lIv+PXJuHQNDqENLpmsWFYHhdX5XMQP5KLAw2
	 AuOvNOJBsIixw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id E4C75D0032F;
	Thu, 19 Sep 2024 11:27:09 +0000 (UTC)
Message-ID: <f70ca3a8-2fe8-404c-8ead-7e7bc5417f52@icloud.com>
Date: Thu, 19 Sep 2024 19:27:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
 <9b668881-b933-4bae-a0da-a107d2b531e9@redhat.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <9b668881-b933-4bae-a0da-a107d2b531e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HNOrW86dCj3dHNWGypTol5F5ngsr9IqW
X-Proofpoint-ORIG-GUID: HNOrW86dCj3dHNWGypTol5F5ngsr9IqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_08,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409190074

On 2024/9/19 16:26, Paolo Abeni wrote:
> On 9/17/24 03:57, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>>         int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>>         int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but emac_sgmii_acpi_match(), as the old
>> API's match function, indeed modifies relevant match data, so it is
>> not suitable for the new API any more, solved by implementing the same
>> finding sgmii_ops function by correcting the function and using it
>> as parameter of device_for_each_child() instead of device_find_child().
>>
>> By the way, this commit does not change any existing logic.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.12 and therefore net-next is closed for new
> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
> 
> Please repost when net-next reopens after Sept 30th.
> 
> RFC patches sent for review only are obviously welcome at any time.
>

thanks for your remainder. will post it after merge window is opened again.

and always welcome code reviewers to give comments before that.

(^^).

> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


