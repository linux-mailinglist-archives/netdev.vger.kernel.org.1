Return-Path: <netdev+bounces-133666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65458996A06
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C011F23D06
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DC194AE6;
	Wed,  9 Oct 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb0cz7bn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDA194A5A;
	Wed,  9 Oct 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477072; cv=none; b=tOZM2+QKgi2iV/TB/MEpVN36mMck0RaazzPKRVDngtq8RO6BAj/sB5DJ6RSSSL4o/vI4QLB5Gj8juXX/+Ilj9udTMDR5VQ/qWlAzFeVg9GyD4hZVozn6oCOf9AmIyziUKHr9wKGDtVfAswgF9eLbUXPNBZX2wTo+37H3RqOSToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477072; c=relaxed/simple;
	bh=sBOKIoQd3/OEh/cmcosa+6B5hMfs/jvCCmADiAiS/84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDxZy1jRDjktZfOVYyITNGiFr/rxrxiXFSnKdqKss82E9RGVFX3c9v2mo7FWDlLx/N/exPLUOLlOM2TJNRC8T6RTdXmpzY3i7uuGTgyfWSbjqsgW7sCPij2AKpa4H3J5smvCkWUypprOsg7U0pF2pGWopfuqPIVGIp77PEXpLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb0cz7bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AB9C4CEC5;
	Wed,  9 Oct 2024 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728477072;
	bh=sBOKIoQd3/OEh/cmcosa+6B5hMfs/jvCCmADiAiS/84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb0cz7bn83zSrjY78J30KoCFUP3KW5fWnIOCW2P1OpeHlTw4GB6SjhKmWurEntID9
	 hljx4qorQ+SJ+xGPblm6wVEisCB1eGxdf4wx45juGnW7kmTbsBGT0X470etDpBJOX1
	 39W0Cvo1HMY2t2FhegTXrEznpXYNVIYFNY6TGWctIVDSkTEP74oodjogz4QEYS3SU0
	 2ywD/utV9OrJ7jneb3qSGA0KQK0q+w92FAet1+FWQjTsoN9fX+cS2+CqFC2tUWOLQX
	 LLaOoIWKk0NeuebOuLRnQDQ2zesFIDX4hmcdvETm8641sb4d6mcbNfAKBcd9pf22kt
	 NeZX6j40CwKvA==
Date: Wed, 9 Oct 2024 13:31:07 +0100
From: Simon Horman <horms@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v4] eth: fbnic: Add hardware monitoring support
 via HWMON interface
Message-ID: <20241009123107.GQ99782@kernel.org>
References: <20241008143212.2354554-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008143212.2354554-1-sanman.p211993@gmail.com>

On Tue, Oct 08, 2024 at 07:32:12AM -0700, Sanman Pradhan wrote:
> From: Sanman Pradhan <sanmanpradhan@meta.com>
> 
> This patch adds support for hardware monitoring to the fbnic driver,
> allowing for temperature and voltage sensor data to be exposed to
> userspace via the HWMON interface. The driver registers a HWMON device
> and provides callbacks for reading sensor data, enabling system
> admins to monitor the health and operating conditions of fbnic.
> 
> Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>

...

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index a4809fe0fc24..10b9573d829e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -289,9 +289,11 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>  	fbnic_devlink_register(fbd);
> 
> +	fbnic_hwmon_register(fbd);
> +
>  	if (!fbd->dsn) {
>  		dev_warn(&pdev->dev, "Reading serial number failed\n");
> -		goto init_failure_mode;
> +		goto hwmon_unregister;
>  	}
> 
>  	netdev = fbnic_netdev_alloc(fbd);

Hi Sanman,

The code immediately after the hunk above is:

	if (!netdev) {
		dev_err(&pdev->dev, "Netdev allocation failed\n");
		goto init_failure_mode;
	}

I think it's error-path needs to be update to goto hwmon_unregister
rather than init_failure_mode.

> @@ -310,6 +312,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>  ifm_free_netdev:
>  	fbnic_netdev_free(fbd);
> +hwmon_unregister:
> +	fbnic_hwmon_unregister(fbd);
>  init_failure_mode:
>  	dev_init_failure_modewarn(&pdev->dev, "Probe error encountered, entering init failure mode. Normal networking functionality will not be available.\n");
>  	 /* Always return 0 even on error so devlink is registered to allow

...

-- 
pw-bot: cr

