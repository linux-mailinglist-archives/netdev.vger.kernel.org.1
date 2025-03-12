Return-Path: <netdev+bounces-174150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6AA5D9C5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF1A3B157B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6023BF88;
	Wed, 12 Mar 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="fJH8tXUP"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-14.ptr.blmpb.com (va-1-14.ptr.blmpb.com [209.127.230.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156C23BD14
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772610; cv=none; b=IpPTfsYgzp43tWBP+c3paIwZT74cmNDQVq5UXOhwS+h2rxLxhvUSEGiqgq2l73nsycbRSdaE0nt6iEPm6e1uZsJoimtRsLGMJC2KdUS8W5wD7weprZAhatWA/h5ZhzxzOD0EJ0yM8IJr8ieVAfTBlJfFcBOcRuFCz9qRMuYpLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772610; c=relaxed/simple;
	bh=l8lJrRLQryu3Kp15FAj4PmZ5BaUk7ZBQJvr3ZE2o0JE=;
	h=To:Date:References:Message-Id:Mime-Version:Subject:Content-Type:
	 In-Reply-To:Cc:From; b=BRtKjkCkmgDvSRwjxz16G4uh2mX/e6QaGj2/F3I6FUyBxRdu5IxJ/Y4kP8eT5u9c2lODm5Hsd2hlYZq0+IcKwJ4KXhEzZwDSaUagrJdr3OIj6GeTk0h080esTG9tzm6LoHT758hyrPOK39+56WdQa3Oz21xhXY2fMw5c4OIBD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=fJH8tXUP; arc=none smtp.client-ip=209.127.230.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741772601; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=9cWO0O52USMisNA7y21qTu4m43///YkcscYh8nS0vNY=;
 b=fJH8tXUPJsRyi4QuPeFYgwCyETMT92e8Za1jYzLlCESc4YtBSs1ZtvE7Bui9rmMOmwGwZo
 RgHJX+S23dEMeuoWbe5/M/IbEc4CmUNoXT3wEwpCjcHr+6IYPsTgrCl6Q57e3RMMOzSTjJ
 LPorAnSBVeik6YmBebkhpNCfr5JoUgmOkGx30RKhxAH2OwRhRIniZe234M6NPtf7dbAIDk
 6a8DY3tVUIvWUq7Sf9aV0s3EFKK8FwHxZFB5AlnSt25OwtEEiixf0SRhTHvBiK+8pXjfkk
 3a7DtueH1h0thkfgjuiy9B+t/lszQ3e/kqt7JipvPgAL1SG+Doz0jI9e120aNg==
X-Lms-Return-Path: <lba+267d15737+9401c4+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
Date: Wed, 12 Mar 2025 17:43:17 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 12 Mar 2025 17:43:19 +0800
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100853.555320-13-tianx@yunsilicon.com> <2d5a6210-1565-4158-ad0c-432953f9268e@redhat.com>
User-Agent: Mozilla Thunderbird
Message-Id: <3ba8daec-0e7d-48a8-baf7-837161f9b8bc@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH net-next v8 12/14] xsc: Add ndo_start_xmit
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2d5a6210-1565-4158-ad0c-432953f9268e@redhat.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
From: "Xin Tian" <tianx@yunsilicon.com>

On 2025/3/11 23:18, Paolo Abeni wrote:
> On 3/7/25 11:08 AM, Xin Tian wrote:
>> +static u16 xsc_tx_get_gso_ihs(struct xsc_sq *sq, struct sk_buff *skb)
>> +{
>> +	u16 ihs;
>> +
>> +	if (skb->encapsulation) {
>> +		ihs = skb_inner_transport_offset(skb) + inner_tcp_hdrlen(skb);
>> +	} else {
>> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
>> +			ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
> You have quite a bit of code dealing with features that the driver
> currently does not support (tunnels, SKB_GSO_UDP_L4).
>
> It would be better either enabling such features or not including the
> unused code.
>
> Thanks,
>
> Paolo

Apologies for my oversight. I will thoroughly review and del those code 
in next version

Thanks,

Xin


