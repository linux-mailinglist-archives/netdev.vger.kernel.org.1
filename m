Return-Path: <netdev+bounces-152909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8E9F64B3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DEB166F63
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB919DFA7;
	Wed, 18 Dec 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="DE6liuZE"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A019E7D1
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520784; cv=none; b=STrB56MqTLqOBIce8p3LPm58uLDmsB/bGxvrKx43+RJ4xIn2bIX8/DuZruX2rdwHVsbzkQfs5pFcqvw1z9hZVNhAjpe9IKQ07iiWMsdQzrxgJZONSyrXcvbVOrWvzeLUAvmxOKpjgI8xAfdad7fxphPFegNwqDw2i9fQ1IQv+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520784; c=relaxed/simple;
	bh=1qLm6JPgKPZO9muCEuvJxTVCIXxa4+WAPicAbLW+iv8=;
	h=From:Mime-Version:Content-Type:In-Reply-To:Subject:Date:To:Cc:
	 Message-Id:References; b=Kq7E+1hXNKU76Bi774M17emXJjxXVhUv2jZMANQcCCH+Vw5eRas0Y0oeGYkJLAC+24uyEmmluWdM39BHB0xnoVGZhjYU7ryN83VSJIKnMpH/uJfo8MFKo1SRqo/nECRd4l5NcqVAjNVZ/stsuQNciif3oqdHi1O0MOFQJtXphjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=DE6liuZE; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734520776; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xGslPPde6YE6gZGLLgXP+XJIr7j+Ka8aO4C2zSmkP0g=;
 b=DE6liuZE0BOCUzyHkzn3exDRf0GMCFhhHt1bpDEmwHxzBdIMvFnMPAvU3J4yPBlswleKlQ
 ryj76q09S137y8jLaXSt4NxyaWdoOoI21RSxVVG01xZLxxcy1AfV0zNZpgU1JUlbJkQGKC
 K1/75VPBg3hOC+rSuKf3zG1ybhPlGWyAaOrU9lFdN+IUrVEDy43KSzEi1PHGZO30ruSR22
 zh/8T1e4hXh3k1O+Gvx678pxu4eAMPKmUGT3B9kmonAYl55mMVHVHYKe8vkQvCWUqaaGcr
 zVsDFsJAP109cFUV5qi1IEawBcj9RKfwajVL87Y0XcUDvQPSZsM7aK0vhrLG6Q==
X-Lms-Return-Path: <lba+26762afc6+8c6a49+vger.kernel.org+tianx@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <e1b54362-7156-4515-af54-e71aabd6c198@lunn.ch>
Subject: Re: [PATCH 14/16] net-next/yunsilicon: add ndo_get_stats64
Date: Wed, 18 Dec 2024 19:19:32 +0800
X-Original-From: tianx <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <weihg@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 19:19:33 +0800
Message-Id: <e9959d98-f46d-4562-9c8e-ac48859e8e45@yunsilicon.com>
References: <20241209071101.3392590-15-tianx@yunsilicon.com> <e1b54362-7156-4515-af54-e71aabd6c198@lunn.ch>

Agreed, probe code doesn't need that level of attention. This have been 
modified in v1 code. Thanks for the reminder!


On 2024/12/9 21:53, Andrew Lunn wrote:
>> +	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
>> +	if (unlikely(!adapter->stats))
>> +		goto err_detach;
>> +
> Please only use unlikely() in the hot path, handling packets.
>
> Does it really matter if you save a couple of cycles during probe?
>
>       Andrew

