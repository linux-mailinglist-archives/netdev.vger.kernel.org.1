Return-Path: <netdev+bounces-248294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05462D069BE
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC433302FBE1
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939571C5D5E;
	Fri,  9 Jan 2026 00:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C61C3C08;
	Fri,  9 Jan 2026 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767918426; cv=none; b=m30WVoB2G6tXrMwGn6s0pBJOGyzNyHdS3EiJqhDndrQturf1WdQfdc9qcJjVRVIWpu+kZSmRN4HxB3Zb3h+cgqSvmFfG6eY3sGZKR3jV3hUyC4dTO1FcLjNw4lyV4ZtrzPqLAJA9x94s+xnIxl7Xl8ZM4IWGmMxLYSI7TBSZNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767918426; c=relaxed/simple;
	bh=4iiPCQDJVG61ZYiJ0w+mgpL0MH7y3Q/osONS0y+x33c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXBiYwVNb+6xuAmpqTVnRpRQY/Bku75IPwlp0TdGO3iX1WBAOWsuvjq4zy7lTJ17yfQz8vZ+8OE0AHGo+QlNvrZKhQgA/NBuwDsSCWt95JNhie2ltCOSTuebwUxH2TkH4bZ9eYaTbDmx5234mnmjSlpr/oe7bWZki7CYnzgemFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Jan 2026 09:27:02 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id F064F20695EB;
	Fri,  9 Jan 2026 09:27:01 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 9 Jan 2026 09:27:01 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 951C610A00D;
	Fri,  9 Jan 2026 09:27:01 +0900 (JST)
Message-ID: <34aaa094-daff-4045-b830-1687488c3e8e@socionext.com>
Date: Fri, 9 Jan 2026 09:27:03 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ethernet: ave: Remove unnecessary 'out of
 memory' message
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
 <81841486-b0c2-4f12-b4d5-08fe214f18d9@lunn.ch>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <81841486-b0c2-4f12-b4d5-08fe214f18d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2026/01/09 3:32, Andrew Lunn wrote:
> On Thu, Jan 08, 2026 at 03:46:40PM +0900, Kunihiko Hayashi wrote:
>> Follow the warning from checkpatch.pl and remove 'out of memory'
> message.
>>
>>      WARNING: Possible unnecessary 'out of memory' message
>>      #590: FILE: drivers/net/ethernet/socionext/sni_ave.c:590:
>>      +               if (!skb) {
>>      +                       netdev_err(ndev, "can't allocate skb for
> Rx\n");
> 
> Please take a read of
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> You tagged this for net, not net-next. I would say this is not a fix.

Thank you for pointing out.
I thought this was a "fix" for the warning, however, it's not a logical
fix. So I'll repost it as net-next.

Thank you,

---
Best Regards
Kunihiko Hayashi

