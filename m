Return-Path: <netdev+bounces-242193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17DC8D3F4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952BF4E8215
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C124322C6D;
	Thu, 27 Nov 2025 07:49:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056E3C1F;
	Thu, 27 Nov 2025 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229753; cv=none; b=fOtmfctzSIHzZHPvfarsgxWA0w02r2ptZHov3Xqc8SVZAmLOakfiZSa7QJpV/eiXDQRkZ4zEbRk0+aDY/ywnxGQBUdaTW6P/+nzuMMK25neH62eVL+/l8y6Ajc9zDu6vYCJ9iQx6AUfQWOMeD+2qixPcO7fIvNMVotCqu0G+SR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229753; c=relaxed/simple;
	bh=9rDSsaySxkHTQ0Hf10T3KvNcmo01cLMa8DeeWqEfwq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCT8wGTi66gUlEaX9rdIFHOszeoIdfbb3pB16GPcmLvEs47Ln9ReghrSJGt9Z+PC+tq+CgGAkdO78oasab6xzIiQnoWDD/WOoODkkP34Wphk+T4VNapb5JwFe/B6SSSE8yuSjnrNgPdX4nPQNaqWF0maqxNEDgZSH+MXa569wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.216] (p5dc559e2.dip0.t-ipconnect.de [93.197.89.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2BB3161B48447;
	Thu, 27 Nov 2025 08:48:04 +0100 (CET)
Message-ID: <0655232d-cb7e-4059-9a12-5d5df0425e8c@molgen.mpg.de>
Date: Thu, 27 Nov 2025 08:48:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 1/1] idpf: Fix kernel-doc
 descriptions to avoid warnings
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251127074516.2385922-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251127074516.2385922-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,


Thank you for your patch.

Am 27.11.25 um 08:44 schrieb Andy Shevchenko:
> In many functions the Return section is missing. Fix kernel-doc
> descriptions to address that and other warnings.
> 
> Before the change:
> 
> $ scripts/kernel-doc -none -Wreturn drivers/net/ethernet/intel/idpf/idpf_txrx.c 2>&1 | wc -l
> 85
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: collected tags
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 96 +++++++++++++--------
>   1 file changed, 59 insertions(+), 37 deletions(-)

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

