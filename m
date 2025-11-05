Return-Path: <netdev+bounces-235679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F29C33B35
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E4189C5C7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D815539A;
	Wed,  5 Nov 2025 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyvjL6xd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86F7261C;
	Wed,  5 Nov 2025 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307361; cv=none; b=hE3TPO7IbFI89Z/svVCitjwu6Gu3uOicOhN1uoEYdvuj8dG+FCGe0VfGmw5rODojfHSwSzOcTTGj7lrmOcvERRIJtnU716W57Bc5WxCLJI0NIGkvHhAMtVnAUi477RVsodhOREYbB873Vn8Lvs3HfTK8ziJ1JTzX2HE748TTZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307361; c=relaxed/simple;
	bh=Z2pZbp5fXiJxe9QlrAns581IRa8xMOQNcSRwjw/CoOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ikdue0ZENjkXV8dngdfK7btwG0IJM0QUTy9XE59sNSachQ+KfpaOtZM0iBYfAuwZ89cD9eU2UB+xY3IsYZg+PC9rgXa0qJmEWsOKudCPCJI6gUSQffP27IjZEALcctB+/dfFD3WeYxAp0S13Tsc5OAYKWCJseyWSLa8Efq061Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyvjL6xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FECFC4CEF7;
	Wed,  5 Nov 2025 01:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762307360;
	bh=Z2pZbp5fXiJxe9QlrAns581IRa8xMOQNcSRwjw/CoOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iyvjL6xd7rJgUp16UJjIsuO1aaj7pu436mcGgLlyOAyXqBzaIXXoKpMIzxLvzT+aY
	 jbkoxMNbpVIG1pIXlSsL5FacdAAI4ZlzHubf3rZFJ1fMdne7ea/ovq+6JlWH8f3oC5
	 IbxGNCGudXRyuOwrTgOti+qcwzNAy5J9pFzE7GjgU7YLL2nF7rXn5U9SnFejF/M5c9
	 3yzQ9w5ugH5pCX5wLJuBtE4xls+tOjoedH72J8Lwe3lTTO4jAgC6pLAoBDibHJ29Bv
	 bbblwIYVnddOmZBcrWaG18oI1VYn1Xe2FWGupX+E5rYWvK5lh6+q33AD1o6LCXUfGs
	 i9b3XuCkYy57g==
Date: Tue, 4 Nov 2025 17:49:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: herve.codina@bootlin.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: wan: framer: pef2256: Switch to
 devm_mfd_add_devices()
Message-ID: <20251104174919.5fc6eb00@kernel.org>
In-Reply-To: <20251103123741.721-1-vulab@iscas.ac.cn>
References: <20251103111844.271-1-vulab@iscas.ac.cn>
	<20251103123741.721-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 20:37:41 +0800 Haotian Zhang wrote:
> The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
> in error paths after successful MFD device registration and in the remove
> function. This leads to resource leaks where MFD child devices are not
> properly unregistered.
> 
> Replace mfd_add_devices with devm_mfd_add_devices to automatically
> manage the device resources.
> 
> Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")

This commit has another call to mfd_add_devices()
please add an explanation of why that one is fine as is.

> Suggested-by: Herve Codina<herve.codina@bootlin.com>

missing space between name and address

> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
>   - Use devm_mfd_add_devices() instead of manual cleanup
> ---
>  drivers/net/wan/framer/pef2256/pef2256.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
> index 1e4c8e85d598..4f4433560964 100644
> --- a/drivers/net/wan/framer/pef2256/pef2256.c
> +++ b/drivers/net/wan/framer/pef2256/pef2256.c
> @@ -812,7 +812,7 @@ static int pef2256_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pef2256);
>  
> -	ret = mfd_add_devices(pef2256->dev, 0, pef2256_devs,
> +	ret = devm_mfd_add_devices(pef2256->dev, 0, pef2256_devs,
>  			      ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);

please adjust the continuation line so that it aligns with the opening
bracket
-- 
pw-bot: cr

