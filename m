Return-Path: <netdev+bounces-181487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7506FA85214
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6742B460C1B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5571E5B70;
	Fri, 11 Apr 2025 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="D+hvMeNO"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A135947
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342627; cv=none; b=r6QO2s3Q5F2p7b1Sy1rIkvoVrJ5wkM+TOjKh2xC0N2pHoW0KYn5eFfHBJ/MJabIvRcSXYWMKWnlcGq5zIdp9Rtl1s6BCql7FQ2ypfXBe7TuAStGPgUsJBA6b9xELsFHcDWcz8Mo+BjVRpgjkHPeyX1H1NvGn6BtfZugtmiBF8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342627; c=relaxed/simple;
	bh=6dw0WMY/fCuz1+MV3EqioJ2412m0tS+jrLmrxOrDYBY=;
	h=From:In-Reply-To:Subject:Date:Content-Type:References:Cc:
	 Message-Id:Mime-Version:To; b=datQO8n+GTebGlZIZKQ3U7qfDp7OPeOe9tXvUf2sG2xaJfXzIBpZkNXraVwHlfen9UCwHm9/U+lOqljTVFR7S5rcEQFEh6uwZsq2TsQRi3KafohMHZgB3KxVOTlwJ7BSDRaammPAWqJOibhgLNKp5J3i6Cnsa7m7+Eo/ZUQIa2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=D+hvMeNO; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744342611; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=z+4MqunYrYp67frE51aDf0GOWwGoOsvtlCQhh6rhSeI=;
 b=D+hvMeNOjYHsYSaEaW6EnT6GNQvcoAQ4T1SM3EsgO234SL+rFg5jT6xN/ubsbrmXAILfLQ
 Pi3jig29F6anbGKMvj4gt1zaoSq3vNjryxzEAdGVHv/YU6ErrxpGZZh3Sf7CHGIs7pt7Sb
 KVBS125oeevb8mIAGReL8CISkt1EY/piTZWEVGD5gwEhPHuimjq3BpWylYAR4TRV/gaRKP
 4CG+DWrBtMdwacdgvsAf+PgeRhpmQGGIEwH4f/DqqTyhVE4aaRtcO7Sj8N138UckmlX0hk
 TmVp0+k3MCfzi3q9ETnl5+IzD6QKgVtt+/1QAN2bLpl5KqbOo9mLgjt9Vx7jPw==
From: "Xin Tian" <tianx@yunsilicon.com>
In-Reply-To: <20250410160801.029ca354@kernel.org>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/14] xsc: ADD Yunsilicon XSC Ethernet Driver
Date: Fri, 11 Apr 2025 11:36:46 +0800
Content-Type: text/plain; charset=UTF-8
References: <20250409095552.2027686-1-tianx@yunsilicon.com> <20250410160801.029ca354@kernel.org>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <geert@linux-m68k.org>
Message-Id: <200cb4c1-d58f-4439-9861-dd15b05d1626@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [127.0.0.1] ([218.1.139.198]) by smtp.feishu.cn with ESMTPS; Fri, 11 Apr 2025 11:36:48 +0800
To: "Jakub Kicinski" <kuba@kernel.org>
X-Lms-Return-Path: <lba+267f88e51+fbc6cd+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit

On 2025/4/11 7:08, Jakub Kicinski wrote:
> On Wed, 09 Apr 2025 17:56:39 +0800 Xin Tian wrote:
>> The patch series adds the xsc driver, which will support the YunSilicon
>> MS/MC/MV series of network cards. These network cards offer support for
>> high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.
> Does not apply, unfortunately. Please rebase & repost.
>
> Failed to apply patch:
> Applying: xsc: Add xsc driver basic framework
> Using index info to reconstruct a base tree...
> M	MAINTAINERS
> M	drivers/net/ethernet/Kconfig
> M	drivers/net/ethernet/Makefile
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/ethernet/Makefile
> Auto-merging drivers/net/ethernet/Kconfig
> Auto-merging MAINTAINERS
> CONFLICT (content): Merge conflict in MAINTAINERS
> Recorded preimage for 'MAINTAINERS'
> error: Failed to merge in the changes.
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Patch failed at 0001 xsc: Add xsc driver basic framework

Well, time to update my kernel code now. I'll repost later...

Thanks

