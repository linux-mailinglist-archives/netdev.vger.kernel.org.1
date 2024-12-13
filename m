Return-Path: <netdev+bounces-151692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063669F0A0D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198F816567A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D11C1F29;
	Fri, 13 Dec 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="c9bKyVtN"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BC1C07F0
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087063; cv=none; b=TaXdglmTbrCcJvRjg9RuQDztWnlw9g9pS4H8ttZ8V6VRN5kYmSryDiqDRWOrLf3tfJ6yuoaUXIeM2UA28HnVg8qCcMjFEYVJL5z0MK3YZdYvmKreU1/ynfFqqwJDaSdZP2UhRBul1RsEuWoWNFez7OOa+9wvVjZjU0EVIuM0c5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087063; c=relaxed/simple;
	bh=z0iXpoNb4O/AXMoJ113xZe5lMIUsxk1J8XGPhZijSK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvHLaI4okTn6OYwQYWX7yYsJy886QW82fQCV5mhhXN/r6en7avoyg1qFMuAqZBGpMGdrjwyJ2R+9oNO9KU5jHSXH4M8QOTMrjLqJJYo2h1P3bhGLJQaIYlgA4ODj6s5X/68sNhOQxcLqAKx9LpRvzf9kr6/bJwMYgD1j1Dr78MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=c9bKyVtN; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734087061;
	bh=K4LFQWPW7szczQxv+lJdGb4IxngOT+WcKY1uNekNjGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=c9bKyVtNHrmkkh/4lM0GW3fyK49HYdqywdGrW5a12y2qIRmNdC3NmRgK+53jYLoVG
	 dCMuWhLnwiWWFQQeOS5kGCg6bWMBclDJioobcRtmGTA4757aeH+dceKwOd9Vz4NV5p
	 Q78Rchh1e5wH0SooT9XibtlSSFNEGkP/a0L7jWBp05rWjpAlUGOPwncozFrxWgQy6d
	 O1HzxXxew7LtypdOpBx+n1B3Ulqu0xTdGH9Q3fLBP8OHTLEUfvJzEWPO6o2/Mtl/TJ
	 n92FzVEvPEXAP8tqkWZpHuKqk08CdbnjYAhPi5PeZQfn4HB/3BqsX16jQrjNadj4p/
	 RkfXaufLUc3jQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id DE6E480108;
	Fri, 13 Dec 2024 10:50:56 +0000 (UTC)
Message-ID: <34d1ccdf-f4dd-44c0-afb5-fe1c7fe49a61@icloud.com>
Date: Fri, 13 Dec 2024 18:50:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: Fix 2 OF device node refcount leakage issues
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
 <20241212163317.5e6829ec@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241212163317.5e6829ec@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: a6lKxkS-OUGyU397s7wp3R5cr1qbysVN
X-Proofpoint-GUID: a6lKxkS-OUGyU397s7wp3R5cr1qbysVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412130075

On 2024/12/12 23:33, Kory Maincent wrote:
> On Thu, 12 Dec 2024 23:06:53 +0800
> Zijun Hu <zijun_hu@icloud.com> wrote:
> 
>> This patch series is to fix 2 OF device node refcount leakage issues.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Zijun Hu (2):
>>       net: pse-pd: tps23881: Fix device node refcount leakage in
>> tps23881_get_of_channels() net: bcmasp: Fix device node refcount leakage in
>> bcmasp_probe()
> 
> Thanks for the patch. This fix was already sent by Zhang Zekun:
> https://lore.kernel.org/netdev/20241024015909.58654-1-zhangzekun11@huawei.com/
> 
thank you for sharing this info.

> net maintainers would prefer to have the API changed as calling of_node_get
> before of_find_node_by_name is not intuitive.
> 

agree.

> Still, don't know if we should fix it until the API is changed?  
> 

(^^)
> Regards,


