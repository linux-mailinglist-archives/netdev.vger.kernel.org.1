Return-Path: <netdev+bounces-126536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD991971B3A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30253B23D3B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE81B86FE;
	Mon,  9 Sep 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="eNNEiTLT"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A21B81C7
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889153; cv=none; b=HHshzw5n0nPUi1KNehRkTLlZbMYM47WOu0tN9eISW5cNkt29Dcg+pA9ysZMT4xnjfXLhMg0hzadK97F44AHPcb4pMch7WcoIqId07DmosMSkyCFce/ACJ8x4Ow3IFZ6dTFbkGbZAu9qERUZKnaMKUcW3jVf2cLdfoCBjNFGpQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889153; c=relaxed/simple;
	bh=iGfiSH4xvhUsGH2AQrPyFir1nwWANrvDJ8bXRs8ajHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkL5v5pL6ssZPf1WZYx2LLn9N9UXjVn3P2zTdH77r9LbQN2aCyBWCnOjV3MYyrNUkoEi/omQIXECs59jYt2ZYdOgDaF4BEyIXQ+i6DBTGDuuAbcf/W5WXnKNlzdxlcxyMnFHYzuvMnfqXNr0XT399lyxWUU9phC7RweclXGC7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=eNNEiTLT; arc=none smtp.client-ip=17.58.23.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1725889151; bh=9eJjzXLhz6RaoqwWGrm1y8m3QlKHhDrD/xVa1TCe0u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=eNNEiTLTiXzKfpZVk2uQn3xcV98a7kNsl0iVN0A5jR1keUdzzvu9lh7WctIzLANy8
	 296hmf3zfhvBETHQsTsx+rl8bd8Kwnxk/gG1hR7/jSdalcSvEVgbCCPjnL1SkREXNd
	 5QElWTQNBzVFmPrre+mSCGWdpclEfXvJlnbToU2rx5JCIDkC611qaEQ7LBDYjjRBct
	 zwS11xMWbcX8er/yZfQd9Fkdz9lFmEjCg5AoAMUbC1PNZiCT2S8phnM2Yu4j6UgQSM
	 MX75ifn8vdn3Yitmth0kRCBz9AI1hXQIMN8w7irk0Nhm7pUoYakaP8Aw1t4gWGCf2n
	 WfCmZyXl7y/QA==
Received: from [192.168.40.3] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id 9FA43DA0220;
	Mon,  9 Sep 2024 13:39:07 +0000 (UTC)
Message-ID: <3d5a69be-2527-41cd-b3f2-28ae86084ee7@pen.gy>
Date: Mon, 9 Sep 2024 15:39:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] usbnet: ipheth: prevent OoB reads of NDP16
Content-Language: en-GB
To: Oliver Neukum <oneukum@suse.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240907230108.978355-1-forst@pen.gy>
 <mJ-iCj-W_ES_nck94l7PueyUQpXxmgDdxq78OHP889JitvF0zcid_IBg1HhgEDh-YKlYjtmXt-xwqrZRDACrJA==@protonmail.internalid>
 <8510a98e-f950-4349-99bc-9d36febe94d3@suse.com>
 <4be673c9-b06a-4c2d-8b27-a1e91150df94@pen.gy>
 <6BnH4O2XKc10y5baGCbmsK5bvKjVwAwL1qcdUy2GYc06i5huflew3Mx9mf34yv4GUipEkyvF5kCYDT8WMaZ3xg==@protonmail.internalid>
 <d15bc43b-f130-4fd1-a758-b19b2dc99d46@suse.com>
From: Foster Snowhill <forst@pen.gy>
Autocrypt: addr=forst@pen.gy; keydata=
 xjMEYB86GRYJKwYBBAHaRw8BAQdAx9dMHkOUP+X9nop8IPJ1RNiEzf20Tw4HQCV4bFSITB7N
 G2ZvcnN0QHBlbi5neSA8Zm9yc3RAcGVuLmd5PsKPBBAWCgAgBQJgHzoZBgsJBwgDAgQVCAoC
 BBYCAQACGQECGwMCHgEAIQkQfZTG0T8MQtgWIQTYzKaDAhzR7WvpGD59lMbRPwxC2EQWAP9M
 XyO82yS1VO/DWKLlwOH4I87JE1wyUoNuYSLdATuWvwD8DRbeVIaCiSPZtnwDKmqMLC5sAddw
 1kDc4FtMJ5R88w7OOARgHzoZEgorBgEEAZdVAQUBAQdARX7DpC/YwQVQLTUGBaN0QuMwx9/W
 0WFYWmLGrrm6CioDAQgHwngEGBYIAAkFAmAfOhkCGwwAIQkQfZTG0T8MQtgWIQTYzKaDAhzR
 7WvpGD59lMbRPwxC2BqxAQDWMSnhYyJTji9Twic7n+vnady9mQIy3hdB8Dy1yDj0MgEA0DZf
 OsjaMQ1hmGPmss4e3lOGsmfmJ49io6ornUzJTQ0=
In-Reply-To: <d15bc43b-f130-4fd1-a758-b19b2dc99d46@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NHYTpL-O_r4V_u_FisTlk8ukUbAVehsM
X-Proofpoint-ORIG-GUID: NHYTpL-O_r4V_u_FisTlk8ukUbAVehsM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1030 mlxlogscore=596 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409090110

Hi,

I think you already got the idea, but just in case, a more concise
explanation for Apple's tethering implementation would be "they just
happened to use NCM encapsulation for RX, everything else about it
has nothing to do with CDC NCM".

On 2024-09-09 13:04, Oliver Neukum wrote:
> May I suggest a reformulation of the
> commit message. It reads like this patch is intended for generic CDC-NCM.

No problem, does the commit message below read better? Suggestions are
absolutely welcome.

For one, I added a paragraph closer to the beginning that's explicit
about the intentions of this driver: it doesn't aim to be and can't be
a generic spec-compliant implementation. I can't avoid naming "CDC NCM"
completely, but I only use it in the first paragraph to clarify the
difference. There was one subsequent mention of it, and I replaced it
with a more generic "NCM mode".

If this is good, I'll give v1 a day or two more for any more feedback,
and then resubmit v2 with the updated commit message.

Cheers,
Foster

---

usbnet: ipheth: prevent OoB reads of NDP16

In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
tethering (handled by the `cdc_ncm` driver), regular tethering is not
compliant with the CDC NCM spec, as the device is missing the necessary
descriptors, and TX (computer->phone) traffic is not encapsulated
at all. Thus `ipheth` implements a very limited subset of the spec with
the sole purpose of parsing RX URBs.

In the first iteration of the NCM mode implementation, there were a few
potential out of bounds reads when processing malformed URBs received
from a connected device:

* Only the start of NDP16 (wNdpIndex) was checked to fit in the URB
  buffer.
* Datagram length check as part of DPEs could overflow.
* DPEs could be read past the end of NDP16 and even end of URB buffer
  if a trailer DPE wasn't encountered.

The above is not expected to happen in normal device operation.

To address the above issues for iOS devices in NCM mode, rely on
and check for a specific fixed format of incoming URBs expected from
an iOS device:

* 12-byte NTH16
* 96-byte NDP16, allowing up to 22 DPEs (up to 21 datagrams + trailer)

On iOS, NDP16 directly follows NTH16, and its length is constant
regardless of the DPE count.

The format above was observed on all iOS versions starting with iOS 16,
where NCM mode was introduced, up until the latest stable iOS release,
which is iOS 17.6.1 at the moment of writing.

Adapt the driver to use the fixed URB format. Set an upper bound for
the DPE count based on the expected header size. Always expect a null
trailer DPE.

The minimal URB length of 108 bytes (IPHETH_NCM_HEADER_SIZE) in NCM mode
is already enforced in ipheth since introduction of NCM mode support.

