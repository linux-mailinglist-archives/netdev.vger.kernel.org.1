Return-Path: <netdev+bounces-129331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351A97EE4E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E88B21AA9
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA05C2C6;
	Mon, 23 Sep 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I9eoKh52"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960258821
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105819; cv=none; b=mD3DkfWhcLHnf5luaWf/3l3bfJB5agAwmw8p5AoEeF5J4BvyJbFaYXKCfgGd+FT+oJAN9L9fvekdynofSSsbz+wK8QoVo8XJ0cKKUKAdeu5aBULukMzFUfB5QPsxx8ooAqlpghVdR8qmLFT1clrj549nzzRsMbt8GDTJIYfNBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105819; c=relaxed/simple;
	bh=4lTAOuwBHq46azOtMOQO7wls5HxPKfySqOKQczPAGjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8quM2Gr2bT1vFFLfJCmFeZNSr04Jb2eneshThJ1iizASVtUmNJJ/FNGUmSbSJ6TKTeehfpjU5aEX0oZDQgPMq4SCuxuTZILx0KVYPW0nGIqrtMh7Vqrq/sXZ7GIWiGjCc3gPpAlGMXsn1C7/6RW0A7US/IxnhvTS76uxCcHQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I9eoKh52; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A4207C25DD;
	Mon, 23 Sep 2024 15:32:07 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C15221C0003;
	Mon, 23 Sep 2024 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727105520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgcIaZUzT4e5oyrsYb0ExYf+Rg84n+4eNeaJmj6l15I=;
	b=I9eoKh52IOqqI7M6bROafC7TXkwbjvMvq1kRnWRLLMDqPWjKg/Ff8Hx7MC0+/llLhx07SU
	6RS0ZQve+uXvdFj5NBERt0Y3EVH4LyfvVpLyLQxUH0W1hS1yOnKtLkqpynFUQY36CNZXcu
	+MqhUDMmlr0Ua6TZRXJd92/hWuBSf6jhh458PFoYKOGRCJLKwdcT4rq7qpSS1hbgxxp6Qj
	ympwplqJSAZjGlBuBvr4nVMD5Lrkq/d2hzzhZtqDCTV/NwxfII4GreCgzM5Qp+KXhgo0Ds
	n3MQT1rdvtAThVnV+QyZP4GuWHLWNNZ0XFuDL49u5QhUI5+o41VJvHZqGzL2Ww==
Date: Mon, 23 Sep 2024 17:31:58 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 cc=linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_common.c
Message-ID: <20240923173158.54bb1f46@fedora.home>
In-Reply-To: <20240923110633.3782-1-kdipendra88@gmail.com>
References: <20240923110633.3782-1-kdipendra88@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon, 23 Sep 2024 11:06:32 +0000
Dipendra Khadka <kdipendra88@gmail.com> wrote:

> Add error pointer check after calling otx2_mbox_get_rsp().

As this is a fix, you need a Fixes: tag.

> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 87d5776e3b88..6e5f1b2e8c52 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1838,6 +1838,11 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
>  		rsp = (struct nix_hw_info *)
>  		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
>  
> +		if (IS_ERR(rsp)) {
> +			mutex_unlock(&pfvf->mbox.lock);
> +			return PTR_ERR(rsp);
> +		}

You're returning an error code as the max MTU, which will be propagated
to netdev->max_mtu, that's not correct. There's already an error path in
this function that you can use.

Thanks,

Maxime

