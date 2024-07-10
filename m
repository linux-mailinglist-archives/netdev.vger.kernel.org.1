Return-Path: <netdev+bounces-110591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A192D4E4
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B321F2142D
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614F194149;
	Wed, 10 Jul 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="o/+taerB"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB019413C
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625031; cv=none; b=U6NN3iHzUUD+GnRtjo2yOkFsgp9Svrp8B9ioFCU/BY1PvPNsgsObcWuwzNyWf2vWOJ8WKJjFrFijr0f1IHElo50Yga2vHVdb9bi3zP+ibEL+2wSggX7FKH3PasaFTE27QHFpxzSAnpq/WasgFA+aQmwueumjtKas5XXnUDrDRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625031; c=relaxed/simple;
	bh=1Ab3iBo7cg8lTqaXGcjMG0c1Jww3SM0LUctiRWPPpPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc4+LNxaiw/SUaHNUm7A76dPcu5G5DwbzB0P+wC407rCByi0HIOJNN/QSJB2h3KjVZad0VNT/byqOAey9jQ1ekPMD0KdKGf3WSoDJ8uAFDpTOBwkOEfJjB7plYj1Y/R3JC+DYwxIrYUZBauUgLtP7a/G1Uh3xSU86f7LVZIwazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=o/+taerB; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id 5CE2F2FE43C;
	Thu, 11 Jul 2024 00:23:56 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 5CE2F2FE43C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1720625036; bh=plrC9bvgSlzh6Uq0tjfPwoqFbMJOow2BfyMHQ++RgAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o/+taerBkPlTO3mck51y5nru5TR2XW0IY85JQ4Ije3hgve19RGNOj6q4R2tezz1Aq
	 AT7pGwBuAviVoKavxH/u8jDRnGlSh/ci9V4AjvzXQ7UO9VK3oPYEPsSkQs86NzTZ8K
	 yeWH2Bbk4ysiawDULnnipVz7GptONzq2b68uSNy4=
Message-ID: <5ee3ae6c-db4e-4cdf-bdc9-f3baea26cb4e@soulik.info>
Date: Wed, 10 Jul 2024 23:23:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tun: need an ioctl() cmd to get multi_queue index?
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <FABA3A61-3062-4AC6-94D8-7DF602E09EC3@soulik.info>
 <20240710081821.63b6f6d1@hermes.local>
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <20240710081821.63b6f6d1@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Stephen

On 2024/7/10 23:18, Stephen Hemminger wrote:
> On Wed, 10 Jul 2024 17:40:46 +0800
> ayaka <ayaka@soulik.info> wrote:
>
>> Hello All
>>
>> I have read some example that filter packet with tc qdisc. It could a very useful feature for dispatcher in a VPN program.
>> But I didn’t find an ioctl() to fetch the queue index, which I believe is the queue number used in tc qdisc.
>> There is an ioctl() which set the ifindex which would affect the queue_index storing in the same union. But I don’t think there is an ioctl() to fetch it.
>>
>> If I was right, could I add a new ioctl() cmd for that?
>>
>> Sincerely
>> Randy
> In the case of TUN, each queue is handled by a different file descriptor.

Yes, I know of that. But I think the argument that queue_mapping 
requires in tc is the index not the file descriptor.

Although I am not sure whether the filter would work as I expected, I 
would apply the filter in the reading from tun/tap side, which is the 
socket data passes through the tun device.


