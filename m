Return-Path: <netdev+bounces-140561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78E9B6FB5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 23:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1441F22014
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584911CF7BB;
	Wed, 30 Oct 2024 22:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BB1BD9DC
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326234; cv=none; b=AurajcNxxb/zH7pyr5Y32IhS143VaG7UI1mRppr2HKtFDvDdUmovb6I77PCkduQuXvl+R8JTKITEFPV8DjI8c/LW55S6mKtPt0pMUz6hESMKBJbM4xWMVvBl3d4GfE80xh87G641W9G2GnZjik3J2IhgEHRWIUTO+EC+UJRQ8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326234; c=relaxed/simple;
	bh=WdH+TAdRHqumVfw/fA8ZbJ0hs10NI2Ch5rbN3WE2XZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLi0FrehZ5DZca+/IYVKqjNNZ7HENp3bY+e8mqNhTqauJEEQHrkB/j6wDtPfKWzRGLn53uIC/ko/731N+HZLkOCsLfZ2o9lg9Q2+1ZHih11OUB8+5eBebqF2ULDqf0ie03h+Ovsj2p0Dng9skpXokgEes34dK8GP3dmuDwKRg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1t6GtW-00060z-Pf; Wed, 30 Oct 2024 23:10:26 +0100
Message-ID: <58d40a6c-7c42-4a46-8c9a-0da4a0c77380@pengutronix.de>
Date: Wed, 30 Oct 2024 23:10:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
 <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
Content-Language: de-DE, en-US
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

> For the second time(!), please CC maintainers because it's very easy to
> miss a patch. In addition to maintainers, please CC reviewers of previous
> versions as well.
Could you please tell me at which mail addresses I should send the patch?
You said that I should send it to "the bridge maintainers" as well, so I 
put "bridge@lists.linux-foundation.org" into the CC this time.

On 10/30/24 4:29 PM, Nikolay Aleksandrov wrote:
> On 30/10/2024 10:46, Fabian Pfitzner wrote:
>> Kernel support for dumping the multicast querier state was added in this
>> commit [1]. As some people might be interested to get this information
>> from userspace, this commit implements the necessary changes to show it
>> via
>>
>> ip -d link show [dev]
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2: refactor code
>>
>>   ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
> For the second time(!), please CC maintainers because it's very easy to
> miss a patch. In addition to maintainers, please CC reviewers of previous
> versions as well.
>
> Thank you,
>   Nik
>
>
>

