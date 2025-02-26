Return-Path: <netdev+bounces-169769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D866A45A6C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F916B858
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D12238153;
	Wed, 26 Feb 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="P6+krkY5"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59813238150
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562788; cv=none; b=FpBOunKhXOMOuKQanjd9eAsMiXHU4EYsfoL45P1XrEDPHOjDPhVqw1gjkXlJcP9LzdiJRkb2RXr9e/Rf/9xGJv8BnJuucYEH+LMkX2S8VXzAUzb/FGkdEDApPukDwXhb9mfR5C3zXGnZXtiQPCSwrhbBtarVRE2LLxUlyzTYYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562788; c=relaxed/simple;
	bh=UaguqqGvt+D5AsXKD3kvNrWFJcsLdTdaSsH8DoN3kuw=;
	h=Cc:Subject:Mime-Version:Content-Type:To:Date:Message-Id:From:
	 In-Reply-To:References; b=aVhe37HIc5y3e+g4eAUiQYVh2IMehbOGIU/zibvizFZ8D2GcXgBzbrQxF2GPIbyYJtGu20pQN8MMa3audX6EmVgJzEbTlIGsKnCRAU3Fr2FKJHbzNmI0DqZw52HROqmhZxFupoy5F8uHY5reusgc7ib2jKwChf87o2YZhyxhClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=P6+krkY5; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740562770; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QqjJG+8GIUXtUmeT1ngk+UmGKjddwmTixqOGo4vuayA=;
 b=P6+krkY5nHLfIF2DfMKtcw0hG+BJaK6xWsYtIyKhSVCqQJsDJhylqRnbXJknHSxUaWRDW9
 2k6Bbgko9SakPOgj3odM7g0hXw6hLacsKvMVH+DvjIk803aTONpl00+tsXp6DO0lV4pn62
 LW0iy6NCbHTymap9zQbPr5wo+kBWZaEco9kU1d0vNJWsmbQHdq8Wolaj++asW7ttrpaqQ0
 X7HHEsVPvaJLfaDjzBIpiwKE1BE6IsYiXxBXDOgul4AfxQlO49C2rQQVuO+szCsLIchZ2K
 5n7NMTZ1+GPn60y9PmCxpSlOAp1kGr7P692VR/to8lbm7dyKevsWNofGDbYcbQ==
User-Agent: Mozilla Thunderbird
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: Re: [PATCH net-next v5 07/14] xsc: Init auxiliary device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Jakub Kicinski" <kuba@kernel.org>
Date: Wed, 26 Feb 2025 17:39:27 +0800
Message-Id: <5fd46c35-8aca-4242-8128-67ca4f41eb3c@yunsilicon.com>
X-Lms-Return-Path: <lba+267bee150+d041ce+vger.kernel.org+tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 26 Feb 2025 17:39:27 +0800
In-Reply-To: <20250225171229.0721fabb@kernel.org>
References: <20250224172416.2455751-1-tianx@yunsilicon.com> <20250224172429.2455751-8-tianx@yunsilicon.com> <20250225171229.0721fabb@kernel.org>

On 2025/2/26 9:12, Jakub Kicinski wrote:
> On Tue, 25 Feb 2025 01:24:31 +0800 Xin Tian wrote:
>> Our device supports both Ethernet and RDMA functionalities, and
>> leveraging the auxiliary bus perfectly addresses our needs for
>> managing these distinct features. This patch utilizes auxiliary
>> device to handle the Ethernet functionality, while defining
>> xsc_adev_list to reserve expansion space for future RDMA
>> capabilities.
> drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:90:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>     90 |         if (adev_id < 0)
>        |             ^~~~~~~~~~~
> drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:104:9: note: uninitialized use occurs here
>    104 |         return ret;
>        |                ^~~
> drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:90:2: note: remove the 'if' if its condition is always false
>     90 |         if (adev_id < 0)
>        |         ^~~~~~~~~~~~~~~~
>     91 |                 goto err_free_adev_list;
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:82:9: note: initialize the variable 'ret' to silence this warning
>     82 |         int ret;
>        |                ^
>        |                 = 0
My bad, will fix.

