Return-Path: <netdev+bounces-147958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E489DF73C
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583F6162A81
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D21D88DB;
	Sun,  1 Dec 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="MSSvRnxs"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01071901.me.com (qs51p00im-qukt01071901.me.com [17.57.155.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568718AEA
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090262; cv=none; b=ayqO5lPph0wOWuxXeHOBAwNqeuZxW5Abkc/HwXWUNNG2ZVkzFTq6j7eij65Pbn0NJD+Hh4SWHMW0QX1ObdzIl9Km3Om3a9bxJMsw6MwYhel/910HD0mTZ1vaxpCli3cU6dx5Vdm3YppFdfolk01Yop7TVW5gy/VrCPTTY/bTq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090262; c=relaxed/simple;
	bh=5ejI8qRyQnF8Rsja0qD9sju8XG2hrWPyxiO64CuBeqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0WWmuoP7u8HOUMnbXrE6VpFdml+8D09MHeVHewUOBFB5SNsBOcOVn4wYuds283wWWHF8a+qg4LbbBcbS5ICaFwKWyvErXH96kfD9Ms09pUxWak3CHoQSHG/qboZlcIGYlcZ6rdQh2kQPun4LgkB4Q8TitGvoxqKl3o39JZwV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=MSSvRnxs; arc=none smtp.client-ip=17.57.155.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1733090259; bh=ABrBciAwBhUunaBQ7WqL823Ola3lFqYqfmIalqO+ivU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=MSSvRnxsvpzQfCZR9mjOcCvQyDZ6NBNINHXqaW11t5Do2a2urOkMJSvAyYSct99xF
	 yM8BC0uFxztQMuxJzN7GpGxz3UxW7O+eEbF1XLFrEotjnrHgbkIzuf21LzLEhWbwoR
	 di0O9WzFXHQE9OYVfqiekPjshqhw8QG3rADOzdBOPd1XpXRtFdRU4rqd2xTNkCMGZB
	 3EXSMIF0//PJaxHw9SBPIZvFoLilD2ysckpFd+VNVYKkWIMr1tCrLYlfhBe1pqaTtc
	 rYlNNbJPpLPUrJf/VnvYTmS62qSWm99UObo00a9oeYZZ5VM6qGjt/RqohDcef0rgXj
	 D5jHfSogbFvuQ==
Received: from [192.168.40.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071901.me.com (Postfix) with ESMTPSA id E70CB6280352;
	Sun,  1 Dec 2024 21:57:35 +0000 (UTC)
Message-ID: <b0052319-dd9f-40e3-a969-4cf6c57dad12@pen.gy>
Date: Sun, 1 Dec 2024 22:57:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 4/6] usbnet: ipheth: use static NDP16 location in
 URB
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241123235432.821220-1-forst@pen.gy>
 <20241123235432.821220-4-forst@pen.gy>
 <kMEBlTaAnz-Ity7mnkhpkSez5G8SW3G5yOsqCErjGdKWgJweOsifjnxY3cHtkiHqMXzMoE8qjDXdkZuEJ4cf8g==@protonmail.internalid>
 <f3657bf6-7980-4c5f-8c82-66c68beb96e4@redhat.com>
Content-Language: en-GB
From: Foster Snowhill <forst@pen.gy>
In-Reply-To: <f3657bf6-7980-4c5f-8c82-66c68beb96e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kNsGRrFycfYpqSc9dkqnnStCtw_76o90
X-Proofpoint-GUID: kNsGRrFycfYpqSc9dkqnnStCtw_76o90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-01_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1030
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412010191

Hello Paolo,

On 2024-11-28 10:08, Paolo Abeni wrote:
>> On iOS devices, the NDP16 header always directly follows NTH16. Rely on
>> and check for this specific format.
>> <snip>
> 
> This choice looks fragile. What if the next iOS version moves around
> such header?

This is a valid concern, and something I've been pondering myself
for a while. My thinking so far can be summed up as follows:

"iOS devices aren't fully compliant with NCM for regular tethering (missing
necessary descriptors, computer->phone not encapsulated at all), so it can't
be handled by the existing fully-featured spec-compliant `cdc_ncm` driver.
The `cdc_ncm` driver includes the functionality I need to parse incoming
NCM data, but I don't see an easy way for me to call that code from `ipheth`.
I don't want to mess with the `cdc_ncm` driver's code. So I'll approach this
by implementing the bare minimum of the NCM spec in `ipheth` just to parse
incoming NCM URBs, relying on the specific URB format that iOS devices have."

I didn't want to reimplement more than I absolutely had to, because that work
had already been done in `cdc_ncm`. I relied on the specific URB format of
iOS devices that hasn't changed since the NCM mode was introduced there.

You're right, the URB format can change, without warning. If/when that
happens, it would be a good time to re-think the approach, and maybe figure
out a way to make use of the parsing code in `cdc_ncm`.

For now I wanted to limit the scope of changes to "let's make it work with
the assumptions that hold to this day".

> I think you should add least validate the assumption in the actual URB
> payload.

This is already validated by checking that ncm0->dwSignature matches
the four-byte constant defined in the NCM 1.0 spec. However I think you're
right that it may not be enough, if by some random chance the initial four
bytes right after NTH16 are set to the desired constant, yet aren't part
of a real NDP16 header. The condition below should cover it:

	ncmh->wNdpIndex == cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16))

I'll add it in v4.

>> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
>> index 48c79e69bb7b..3f9ea6546720 100644
>> --- a/drivers/net/usb/ipheth.c
>> +++ b/drivers/net/usb/ipheth.c
>> @@ -236,16 +236,14 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
>>  	}
>>
>>  	ncmh = urb->transfer_buffer;
>> -	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
>> -	    le16_to_cpu(ncmh->wNdpIndex) >= urb->actual_length) {
>> +	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
>>  		dev->net->stats.rx_errors++;
>>  		return retval;
>>  	}
> 
> The URB length is never checked, why it's safe to access (a lot of)
> bytes inside the URB without any check?

There is a length check right above this hunk, starting with:

	if (urb->actual_length < IPHETH_NCM_HEADER_SIZE) {

IPHETH_NCM_HEADER_SIZE is defined in such a way that it covers NTH16,
the fixed-size NDP16 part plus up to 22 DPEs. This is described in the
commit message.


Thank you,
Foster.

