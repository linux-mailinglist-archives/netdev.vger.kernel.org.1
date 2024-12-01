Return-Path: <netdev+bounces-147960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C69DF742
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AEB20DE9
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457A1D8A0A;
	Sun,  1 Dec 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="H3CJPGMm"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05981D88A4
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090892; cv=none; b=BmcYM9yrgPxjkLWktzNMvmUZtUShkZkdGz41+kt9mf+LXsCQ1dOjcy0YwlQTyapim7pE5YY6HvVLIW/+TT3S1B9OktpnKK7V9d0tUhuBSEB0t+rI66SdyZKFuygZ0bs2ExJNA7w1MqPZE7tWD4eVmuadJH8drqI2TZXmnMnQOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090892; c=relaxed/simple;
	bh=KEUSa3SiEoR9ODDCSX/P8QiseLknNgDRtIe131gVRtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwlNgRQWjURqx0DrgPEYTXJi9n2+qqlZT3DP2/QHszs5lyMnJPiBanaqbqTvoJABGVLs4G0H2ll9NWB7Cl6hPfwdsXZXs+cEyhuPQonI6n9TaT1dv3ruXx5xCqnZiZ48et7Bbn/9J+kPGUrOVp469B3oU8m5TY7XYrIQmngM76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=H3CJPGMm; arc=none smtp.client-ip=17.57.155.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1733090889; bh=HM/IKhF3wf0DGCw7jrIctJrCObDXfg1/ve97Sy/TSHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=H3CJPGMmyt1ty93tdfVBXSqWUSqNRMk6lJasTP2zhaBKM5sbQwjWBl3WSu2vWu6Dl
	 kZvh31S9tdYmLjCwPaRhqmhk4NvgSHwjQwN5+tvcDDqxFrWbpC+UgGO45RNBGhG0zw
	 cGS/DF9c5EwSu/7zQoz2c4ikHS++m5gKRtX6EEHqzlsn43u7pBn55khprvDPomgy17
	 ntPqAl9KDaNVh+BBNdSDO80WBuE9Z8lrMS1QMy+3IV1LUYvoWxVNjOYgJaRhR+mh39
	 FyFVfqDuySnOAumoyDcxtk41stwq6v4VOFlR7KRfdgeuAxugzDD7JT9stYt72oBVZ1
	 kiyi5QJozKOFw==
Received: from [192.168.40.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id 1A4A6198041F;
	Sun,  1 Dec 2024 22:08:06 +0000 (UTC)
Message-ID: <5be4f8f1-af40-4114-963e-76f645380081@pen.gy>
Date: Sun, 1 Dec 2024 23:08:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 1/6] usbnet: ipheth: break up NCM header size
 computation
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241123235432.821220-1-forst@pen.gy>
 <JWND33OD9jZkCkQRVDIgm48R2gSfUh7b4Nw6S466ykaeSzUfotQYvUYOxBMxaYy5D08n-dS8tvxRbidQPLPgpw==@protonmail.internalid>
 <551a761c-ebc3-423c-ac8d-865b429cf8b8@redhat.com>
From: Foster Snowhill <forst@pen.gy>
In-Reply-To: <551a761c-ebc3-423c-ac8d-865b429cf8b8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W150WLYc0v8EQJYy0De-PWzFg6REFOYk
X-Proofpoint-ORIG-GUID: W150WLYc0v8EQJYy0De-PWzFg6REFOYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-01_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 spamscore=1 bulkscore=0 adultscore=0
 mlxscore=1 phishscore=0 malwarescore=0 clxscore=1030 mlxlogscore=220
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412010192

On 2024-11-28 10:16, Paolo Abeni wrote:
> On 11/24/24 00:54, Foster Snowhill wrote:
>> Originally, the total NCM header size was computed as the sum of two
>> vaguely labelled constants. While accurate, it's not particularly clear
>> where they're coming from.
>>
>> Use sizes of existing NCM structs where available. Define the total
>> NDP16 size based on the maximum amount of DPEs that can fit into the
>> iOS-specific fixed-size header.
>>
>> Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
>> Signed-off-by: Foster Snowhill <forst@pen.gy>
> 
> This change is not addressing any real issue, it just makes the
> following ones simpler, right?
> 
> If so, I think it's better to drop the fixes tag here and add the above
> reasoning.

Correct, this doesn't fix any real issue. It has two purposes:

* Make it clearer for the reader where the numeric constants come from.
* Like you said, make subsequent changes simpler by introducing intermediate
constants that are used by subsequent patches.

Ack, will remove the "Fixes" tag and add the above description to justify
the change.

>> ---
>> Each individual patch in the v3 series tested with iPhone 15 Pro Max,
>> iOS 18.1.1: compiled cleanly, ran iperf3 between phone and computer,
>> observed no errors in either kernel log or interface statistics.
> 
> This should go in the cover letter (currently missing, please add it in
> the next iteration).

Agreed, will add a cover letter for v4. Depending on the outcome of the
comments/discussion on patch 4/6 in the series ("usbnet: ipheth: use static
NDP16 location in URB") will likely reiterate the explanation of why I
approached the changes the way I did. I think it provides important context,
and also points at a potential way to enhance the driver to make it more
flexible in case of possible future changes to iOS.


