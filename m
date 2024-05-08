Return-Path: <netdev+bounces-94498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05688BFB2A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A0B21322
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2980C16;
	Wed,  8 May 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="gzcay2bz"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD48061B;
	Wed,  8 May 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164904; cv=none; b=NpLpJUVhXjvSKfOK7bc+3QHic0027xghbrRYjINGAWm0k5z1IoA6b0SUQ63uKop+YSJXi+x3EcpVjjhhcsbNlNQqFMii9z0iqrW2+18lTyby+fO4/tfYZBTZG14rTkU+erXElqvwOMgaCEBuK1/ASl3xBoXPoZMg3gDodlycdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164904; c=relaxed/simple;
	bh=ftk3LXm1KKRXyvUxh2iDxkdzjCVpvWqkwpfBuiUcmSo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RDm03PXYpB9TaItGBv0QQqNtY3OL3P3qjJ1iLEXqEVN0jpurdPxDDUimaqYFl/UjPT/CL8Ktx7EljdTrsd0tEcqilR+JA0GN2sRvq2uhxgEBsPXS6cck1KYcp8er0FsifCNUmWUjlatDc6xctaEgevkgXfCSpDY/6XM6A08CV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=gzcay2bz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 05876600A2;
	Wed,  8 May 2024 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715164897;
	bh=ftk3LXm1KKRXyvUxh2iDxkdzjCVpvWqkwpfBuiUcmSo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=gzcay2bzt3xz45WH2jyYMewfkSg1ICtKOW2N9S0+WfOikt+lrsXUROaKfCSuaRi6z
	 N0oGA8qEXfWeB8Ay7BS+CCtZU4WJeijpR87ZrTCEsRZT3RZ52e4k6aInJrRTiX5Egz
	 CyrNwC14kz6sN5oJfcYzN6eJzh3qc15xYJ4X+KNI0gT0vSZfaCzkUj7DFUdIUGBaCr
	 imigTrRd+/bKI4/ad+EVToUhBmi/bY7eHrXeEvj4ffiYlL3LdrLBEbyPKbkqczAV3Z
	 Hxnf7K5wGLtVd/78jSqhCxFKHha6KYNYBeeq35QqY24nRP+d6zXYs6K4fpiIbpllew
	 vohFQ7bp8Ve1Q==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id A2456201852;
	Wed, 08 May 2024 10:41:27 +0000 (UTC)
Message-ID: <f54e0ffb-4087-4e83-9953-122fc19f488b@fiberby.net>
Date: Wed, 8 May 2024 10:41:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Subject: Re: [PATCH net-next 01/14] net: qede: use extack in
 qede_flow_parse_ports()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org
References: <20240507104421.1628139-1-ast@fiberby.net>
 <20240507104421.1628139-2-ast@fiberby.net>
 <e3993bb2-3aac-4b07-8f8a-e537fa902af4@intel.com>
Content-Language: en-US
In-Reply-To: <e3993bb2-3aac-4b07-8f8a-e537fa902af4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Przemek,

Thank you for the review!

On 5/8/24 10:07 AM, Przemek Kitszel wrote:
> On 5/7/24 12:44, Asbjørn Sloth Tønnesen wrote:
>> Convert qede_flow_parse_ports to use extack,
>> and drop the edev argument.
>>
>> Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.
>>
>> In calls to qede_flow_parse_ports(), use NULL as extack
>> for now, until a subsequent patch makes extack available.
>>
>> Only compile tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   drivers/net/ethernet/qlogic/qede/qede_filter.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
>> index ded48523c383..3995baa2daa6 100644
>> --- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
>> +++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
>> @@ -1700,7 +1700,7 @@ static int qede_parse_actions(struct qede_dev *edev,
>>   }
>>   static int
>> -qede_flow_parse_ports(struct qede_dev *edev, struct flow_rule *rule,
>> +qede_flow_parse_ports(struct netlink_ext_ack *extack, struct flow_rule *rule,
>>                 struct qede_arfs_tuple *t)
> 
> there are ~40 cases in drivers/net/ethernet that have an extack param as
> not the last one, and over 1250 that have an extack as the last param.
> My grepping was very naive, and counted both forward declarations and
> implementations, but it's clear what is the preference.
> 
> Could you please convert the series to be that way?

Sure, will do that in v2.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

