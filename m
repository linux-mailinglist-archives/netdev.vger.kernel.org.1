Return-Path: <netdev+bounces-103808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9968909916
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A95C1F2212B
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0749656;
	Sat, 15 Jun 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hiQOM69u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527F2E40E;
	Sat, 15 Jun 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718470811; cv=none; b=iEyHceiZL8owXJ7VV+PYCgkGEDcXeI078CS8ZAPAuDCeyw+8NOG+nAoOJHBWFEu41E4TsxuicuJAR88/QGMBKOCbn7uTUDmc2yP37GuxTAdS6QZwRnDXhKPgGSkeu21Fcd/VN01tNFfza9Vo/kJWmblLXuTO4vx5fkEkn02ZUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718470811; c=relaxed/simple;
	bh=qPF1/OwfQhKdvkx3zxh32aqPDUxcsGhv8/DRvBq/Z8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULyBZ0PtOxGtzcH/5bGXtfLQCXkjf5hnFXkz1UVgGR59Qr8tL/iEGPY+mlKXJLL2UoAQZw1bGGpg4fSshCpyZmkSRDSgOF2rUh/Pxsuf0ByMmOMU+M4WAAlPlKZLmqDnQMMHtqe5p7yCWE+30TU9ukmCS5pmfNnkQvpHDfPMJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hiQOM69u; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id INU5s0lg7j7S3INU5s5aIM; Sat, 15 Jun 2024 09:05:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718435158;
	bh=PTZjlzNRSwP9GntpvKn6bnVzhdAKr24YVJ985FiFhsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hiQOM69uCw/4OOKrtOqV2oIo8U6AdvxY7BuahOK40hMk/5CITfzQutK1lzLjBsj8K
	 DwE94Gehm/4ieAwlJYcJpisB1VSrJgBcg3bIgU8H9xlBTsNNddaoBsYZ9jT0plJT2s
	 2tgNiVCAYfv8S5OM4bBG46YwASXZ+7v5OeqmNCF0SFyTcGMMNQguewxWxadNTc9+rH
	 C3gC/DycKNTYATsBdGzyALAPH8di6KGLminlk8I7PXapHzYjq8ntvoAMCDQDbg1FN+
	 L66sz0S4W1AIDkFCbTr2yVm86kbhoxo9RsYFfwtr/gSSVM3VExyB/ieF12LFFxu1mU
	 lWT7k4FnAHuZg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Jun 2024 09:05:58 +0200
X-ME-IP: 86.243.222.230
Message-ID: <3946b327-5e89-43d3-9dc3-10dd10bd41bc@wanadoo.fr>
Date: Sat, 15 Jun 2024 09:05:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ptp: fix integer overflow in max_vclocks_store
To: Dan Carpenter <dan.carpenter@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <d094ecbe-8b14-45cc-8cd8-f70fdeca55d8@moroto.mountain>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <d094ecbe-8b14-45cc-8cd8-f70fdeca55d8@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/06/2024 à 19:31, Dan Carpenter a écrit :
> On 32bit systems, the "4 * max" multiply can overflow.  Use size_mul()
> to fix this.
> 
> Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/ptp/ptp_sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index a15460aaa03b..bc1562fcd6c9 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -296,7 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
>   	if (max < ptp->n_vclocks)
>   		goto out;
>   
> -	size = sizeof(int) * max;
> +	size = size_mul(sizeof(int), max);
>   	vclock_index = kzalloc(size, GFP_KERNEL);

kcalloc() maybe?

>   	if (!vclock_index) {
>   		err = -ENOMEM;


Unrelated but, a few lines above, should the:
	if (max == ptp->max_vclocks)
		return count;

be after:
	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
		return -ERESTARTSYS;

as done in n_vclocks_store()?

CJ

