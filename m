Return-Path: <netdev+bounces-147959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281679DF73F
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 22:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67E8B21333
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4981D9320;
	Sun,  1 Dec 2024 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="lIYeGHwz"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1241D90AC
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090333; cv=none; b=Wa4diEYi6nYTfKZOhmHar2fBQSNFxBY07GJTgcumSeAurs1vELO+2p61F+iu7TjTXlqta+RGuaAKWoH5FgA/NRmZMhjUayeX53J+WPxmPymfBZw/x2u6K6kchxNud9hEQwfXNNOCMqhSIAXqC9UW27S6VObmD1+S4qJ7B5i4Zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090333; c=relaxed/simple;
	bh=on3Fc3OSZwZF0ybMblX5YiwCbVQEMM9UnQrkmuE7Ed4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/D+c83G/K2w+lUacrlxZ+fUWUlo864xVHXZ/fnvojiyR4JytmNfCJ6DPztVM73v+6indJKHcgHda2Yex30Xm/zL4XFRW2M3WZLWkWKP21J84eWajcQpG9NuGCvx4LgWmn5A4j1o3lopzCO/xLPqE5qoEvTicztWupm6YHhiMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=lIYeGHwz; arc=none smtp.client-ip=17.57.155.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1733090330; bh=CUzBTTQ4wq8egtzdf77GszLmBghzZW7Rr4Rt+JvQgwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=lIYeGHwzoBS5wzumCUrLazYs3AJPkGMhqwiz5QOYHEEH3RyGcTd1GX2l1K0zMJZWX
	 UfyuTDoaa1Wt56jndPoiWsIN9Xmo7l5apNWNwFy/onjnQx3PqM2dpDSbSBwhBodlfi
	 rV3UH1xXMqJTi68DGafKcd4BAM4WepCSNeQfbBt9+g0byak/ms6P8ZaD6lOPu9+IOW
	 qP692xdwXxbF5ypS+F8SGXPaeN+aPEbXZmUGglLOKWiPt8XCqodo4OOXx+XFciU4aB
	 WqJlF92OKhB0xNyqFsEFz6anFpoTTLrlHFeELnHMHU7dtRtJ5ub8j4zZU35vDBCwxU
	 TRSaWEiHYiPdQ==
Received: from [192.168.40.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id 1653A1680312;
	Sun,  1 Dec 2024 21:58:48 +0000 (UTC)
Message-ID: <6c3be3fc-433d-4e06-b15a-cb9960a8df69@pen.gy>
Date: Sun, 1 Dec 2024 22:58:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 5/6] usbnet: ipheth: refactor NCM datagram loop,
 fix DPE OoB read
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241123235432.821220-1-forst@pen.gy>
 <20241123235432.821220-5-forst@pen.gy>
 <aytplsCmq3m0EIQF7KBGCA9dLsPwHJP3aOEpXiMZsJtp2M2l8US0rKaOSz9S-t4F5vjyVNYOctO8yzzLD91xxQ==@protonmail.internalid>
 <db62a6ad-b96a-403a-9b70-9223dc6a3856@redhat.com>
From: Foster Snowhill <forst@pen.gy>
In-Reply-To: <db62a6ad-b96a-403a-9b70-9223dc6a3856@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OPIEfwN9Nff5i-rlkyfm8wMhWZbMtEJB
X-Proofpoint-ORIG-GUID: OPIEfwN9Nff5i-rlkyfm8wMhWZbMtEJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-01_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 bulkscore=0 mlxscore=1 clxscore=1030
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=222
 spamscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412010191

On 2024-11-28 10:10, Paolo Abeni wrote:
> On 11/24/24 00:54, Foster Snowhill wrote:
>> Introduce an rx_error label to reduce repetitions in the header signature
>> checks.
>>
>> Store wDatagramIndex and wDatagramLength after endianness conversion to
>> avoid repeated le16_to_cpu() calls.
>>
>> Rewrite the loop to return on a null trailing DPE, which is required
>> by the CDC NCM spec. In case it is missing, fall through to rx_error.
>>
>> Fix an out-of-bounds DPE read, limit the number of processed DPEs to
>> the amount that fits into the fixed-size NDP16 header.
> 
> It looks like this patch is doing 2 quite unrelated things, please split
> it in 2 separate patch:
> 
> patch 1 refactors the code introducing the rx_error label
> patch 2 fixes the out-of-bounds

Agreed, will do in v4, thank you!

