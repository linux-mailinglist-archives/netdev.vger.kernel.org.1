Return-Path: <netdev+bounces-126271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471097047A
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 01:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97AE282BA1
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6116727B;
	Sat,  7 Sep 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="NiOkNjPe"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882015CD58
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725751285; cv=none; b=HuO8qeWScC3qkArjqsOj5StXQmQtueXsGRW0/VS+5xeKtAT0dIE+mHhnbtNs2NRBQtbMECHwgRbxAQuFRST/95hQoy903v6zosHDrN313+dNhGH5UhZOze4PWoFd0zUBd1STWRUcRFxVgQ6Pu4ucs+TtEaHyee+/qjgiwwC/hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725751285; c=relaxed/simple;
	bh=6ZSkvFLZf5b3HKHpcNYmQ62hczi1BIkCzMhnyLUF7Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9Wm5svKrlCH3Mx2FQebvV8f3hWW72yvoi0dQxE0LqZqgEUjtvczpfWlrY1C7L4J3UYrI6x49BUxHnsmpuxIqWr7wVMfIJ4eNgokmHANJBFcaK2jykXKj7vsey/2KLoMsxVM/UcX7qk7pZloFi6uTe0bU895/yheC/AACEI18jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=NiOkNjPe; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1725751283; bh=ZIoZb8zOiSuBl4OMCio4mHtYJAp1BE6Kz2Hf+e/qxgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=NiOkNjPeK07qG0RyjYH70i7R0zOQmkOs1cWU7EuSJWquem763KQSZG06cCXCav3sq
	 a2GG3VqJYO/wyxXL3VRMRzzcSZBuNA+YwGyhNp0wlFFOoMAbjzlizsJ69CewvNUWmw
	 U7yfMYXa4IfXmnv8BfP/Tb3cXV2uA+vM7OtgEtUlbL8zQ2fE8vweGshxkLydw//Bb5
	 bjZATJ09Z1VYEBhJmRVwQysHPUaL7ghYLGu/o5Qh+9JdT/m1X+Zmt+n3o5eVuu3KuM
	 atiWJPafg0Pk7EStXFcsMFDl93FxhMh8Kqez4JbRd/7hJGFsFTCW16J7+/amSfVRAx
	 rbwsFqEebaGoQ==
Received: from [192.168.40.3] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id BFE3F802E3;
	Sat,  7 Sep 2024 23:21:20 +0000 (UTC)
Message-ID: <4730d2a2-00ee-4b80-a251-7591967b5f90@pen.gy>
Date: Sun, 8 Sep 2024 01:21:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 2/5] usbnet: ipheth: remove extraneous rx URB
 length check
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Georgi Valkov <gvalkov@gmail.com>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20240806172809.675044-1-forst@pen.gy>
 <20240806172809.675044-2-forst@pen.gy>
 <n6E0amSPUC4I6p-Xg062-XrSvsNWyH_I1xFzFq00lw_nNUf-2lNPHe5QceV9Bw2aDGx5eocXn0AEQ-JVuiFYrg==@protonmail.internalid>
 <20240809101612.GJ3075665@kernel.org>
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
In-Reply-To: <20240809101612.GJ3075665@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nCP9FqJMyqaY_xo5XyY7nJzH8r4VBEhK
X-Proofpoint-GUID: nCP9FqJMyqaY_xo5XyY7nJzH8r4VBEhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_12,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=522 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409070194

Hello Simon,

Thank you very much for the feedback, and apologies for the delay.

On 2024-08-09 12:16, Simon Horman wrote:
> I am slightly concerned what happens if a frame that does not match the
> slightly stricter check in this patch, is now passed to
> dev->rcvbulk_callback().
> 
> I see that observations have been made that this does not happen.  But is
> there no was to inject malicious packets, or for something to malfunction?

Specifically for this patchset, in my opinion it shouldn't have had any
effect on dev->rcvbulk_callback(). The first thing that both of the
callbacks do is check the length of the incoming URB, to make sure they fit
the padding (for legacy callback) or the entirety of NTH16+NDP16 (for NCM).

However your message did prompt me to look at the code again with fresh
eyes, especially at the NCM implementation, and there is definitely need
for improvement in handling malicious URBs. I've submitted a patch a few
minutes ago [1] to address the issues I noticed.

What I think happened is I had two conflicting ideas in my head, one was
"make this generic enough to support arbitrary NCM header length and
location", and on the other hand "iOS has a very specific header size,
don't reimplement CDC NCM which already has a proper driver in cdc_ncm".
The implementation ended up somewhere in between, and resulted in code
that is susceptible to being negatively affected by malicious URBs.

With the latest patch [1] I decided that I should limit the NCM
implementation in ipheth to the iOS-specific URB payload format, and error
on anything else to be on the safe side. If there is ever need to make it
more generic (e.g. if iOS suddenly changes the URB payload structure),
a better idea could be to somehow reuse the existing code in the cdc_ncm
driver, which is a lot more careful in parsing incoming data. That would
possibly involve converting ipheth to use the usbnet framework.

[1]: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/

Cheers,
Foster.


