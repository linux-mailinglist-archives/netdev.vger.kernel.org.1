Return-Path: <netdev+bounces-152905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C49F6444
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9DB164B20
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DB185E50;
	Wed, 18 Dec 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="JM9/opcc"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-32.ptr.blmpb.com (va-1-32.ptr.blmpb.com [209.127.230.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E327726
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519903; cv=none; b=UIkXkpr+AHIyDedYCSNm6ORLSjuXdgWVUPp3WO59GdCzAWkFlZnq/GF7eJdtY4Oj1sS/orn0FFKZSJRYNuTpg4V32MIJQK/wRnNt6e9P8zv+yTf/ny6gL0fdEX8jm8BMiJON/SD4MLwagSYYD1WBIZMG4b19N3Rzewa26vqUdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519903; c=relaxed/simple;
	bh=6PUyf+kY47gfXhw8kdVnNju8g7hueojKcssGKmn9G84=;
	h=Subject:Mime-Version:References:In-Reply-To:To:From:Message-Id:
	 Content-Type:Cc:Date; b=FvEamBOMrj7GF0OY7vdyuahEn6Ezdw1lSVOWsj3VfwwK9G18aCTGEoxJ91kzEw35X3PPXBiu4KNX8qHGCEEA1noL7DHn7j/6Q5vuwsXJ8YWySfBWpgKvImgcKmaEesQOhKJOoabd8lyOwAeLkAjqwYsQi5HCqbpVe3T6Dvc1ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=JM9/opcc; arc=none smtp.client-ip=209.127.230.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519890; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IUco7q+l9/P0w9U+w0RpwerDeqj6xMmP9O4uCaqNWOk=;
 b=JM9/opccJGulRh4lFAHD3HshhImnaPV1lIY7jNAQ+wqidvQm79/oMawFjnqsYk1gVVynsK
 VCu72X1gbkknXTdh4Q8BXFFK0Fx8WQZmZSSDeY6fAdhQNqf34HeBc4Ve2LLiWth7L3ekUm
 I1VKlOPt061kFHJLSxqazWYLgOg7a2uQKG+glSuFrPnrOYPJqiRVCXq8eed7o87pLhBxgT
 yBg4jrD5Yc1ADbVBCkoncy556UNdImB/oQOdyGRdxToxF8OvciQUdjDz+FFF4eGL4X5Nfv
 KHvFf7fHZjvBhccsENFdZPVJJ+dwEbB0I24VxsNFZ7y2ZShUFkzywZpjHOW6/Q==
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 19:04:47 +0800
X-Original-From: tianx <tianx@yunsilicon.com>
Subject: Re: [PATCH 09/16] net-next/yunsilicon: Init net device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209071101.3392590-10-tianx@yunsilicon.com> <3cd0f6da-6075-404a-a38d-71ee41846031@oss.qualcomm.com>
In-Reply-To: <3cd0f6da-6075-404a-a38d-71ee41846031@oss.qualcomm.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, <netdev@vger.kernel.org>, 
	<davem@davemloft.net>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26762ac50+39a50d+vger.kernel.org+tianx@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Message-Id: <7b2d057d-9d74-463d-832e-ac6b16f6225f@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Cc: <weihg@yunsilicon.com>
Date: Wed, 18 Dec 2024 19:04:46 +0800

MODULE_DESCRIPTION() have been added in the v1 patch series, thank you

On 2024/12/10 8:18, Jeff Johnson wrote:
> On 12/8/24 23:10, Tian Xin wrote:
> ...
>> @@ -133,3 +462,6 @@ static __exit void xsc_net_driver_exit(void)
>>   
>>   module_init(xsc_net_driver_init);
>>   module_exit(xsc_net_driver_exit);
>> +
>> +MODULE_LICENSE("GPL");
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
> to avoid this warning.
>
> My mechanism to flag these looks for patches with a MODULE_LICENSE()
> but not a MODULE_DESCRIPTION(). Since this is patching existing code,
> if there is already a MODULE_DESCRIPTION() present, please ignore this
> advice.
>
> /jeff
>

