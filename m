Return-Path: <netdev+bounces-121627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50E95DC63
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB0E1F22709
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1548153BC7;
	Sat, 24 Aug 2024 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QAsAvBK0"
X-Original-To: netdev@vger.kernel.org
Received: from ms11p00im-hyfv17281201.me.com (ms11p00im-hyfv17281201.me.com [17.58.38.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976F43147
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724483478; cv=none; b=WetPb4UgF6X7WuExzO3XQkHq2G7FjG0T8hZDE8xHeoCA9zyrt0kycW9kt821jtd4UUmmcgGz81XTsdvbeAGnYF9oEFyrCUxEInnGrnJ5s/1Cx7+P9/e/N4CjFmVI+BD83A1SBhUMLcHrW+eLcXByk5j99PY9595FeBeQrImlBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724483478; c=relaxed/simple;
	bh=omL5xzG1t9UscQnTMq0/kHaQpxK6+Rzluf2x8wEqXXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnzBdcuzE15dvvvyxbK/2wSseVZOkTTnSAr+cQeGzL/UILOX9dLnlitZGJJe8Kh5PP9lsTxLxUapkyfh+u3usTdi1bNtBw6ng4ABlZrgq0GMOGXxJjdKVIbHafj8fCKa6KGR7a083Lo/zi4j2jteXIP8zCBDII0eCAoAfMcNLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QAsAvBK0; arc=none smtp.client-ip=17.58.38.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724483476;
	bh=lYAJZu7nJ9OlFCL+XhSBSj8o0ojB6jJJSzfvDpVjQhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=QAsAvBK0+9dvp/4zOOWPEBzkxa/TqvSKfFPu9fIWmy5U2xSmsGBV8gb8MQydQ7XPY
	 /SPUslApuZoFOOrOnAEj+O4Ky0pC+u59rt/LbZOt4BE4CTF8ngKY6Ek5zu5jgm2mDc
	 6sFad0qFHVKSetmiFoGauVGC/zOgEIiQKP56xvXAci0aciXPjaM5hRW6Vu/fkNRJ3J
	 i0SkvqntLZhUDtYbj6ayl9U1UcjuN6ToQMMxhv/HU84czz2Xaia1QDorSNIxuuvF0S
	 mFH64bNUvvf7nwhAt0A2NKOw2A3ZtVxw4jbQiEN9lQyB9WdtVk1Vc5/XV6ejzO2reB
	 013iIz/0EYlYg==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-hyfv17281201.me.com (Postfix) with ESMTPSA id 56C6CC8042F;
	Sat, 24 Aug 2024 07:11:10 +0000 (UTC)
Message-ID: <6691f94a-030a-4c76-8a1b-602620102a01@icloud.com>
Date: Sat, 24 Aug 2024 15:11:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net: qcom/emac: Prevent device_find_child() from
 modifying caller's match data
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-4-8316b87b8ff9@quicinc.com>
 <2024082415-platform-shriek-2810@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024082415-platform-shriek-2810@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nk62xV0h0PiFA08hn8OVndpPemz9k8ZH
X-Proofpoint-GUID: nk62xV0h0PiFA08hn8OVndpPemz9k8ZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_06,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408240040

On 2024/8/24 11:29, Greg Kroah-Hartman wrote:
> On Thu, Aug 15, 2024 at 10:58:05PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>> 		int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but emac_sgmii_acpi_match() as the old
>> API's match function indeed modifies relevant match data, so it is not
>> suitable for the new API any more, fixed by implementing a equivalent
>> emac_device_find_child() instead of the old API usage.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 36 +++++++++++++++++++++++--
>>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> Can you rewrite this based on the cxl change to make it a bit more less
> of a "wrap the logic in yet another layer" type of change like this one
> is?
> 
sure. will do it today.
> thanks,
> 
> greg k-h


