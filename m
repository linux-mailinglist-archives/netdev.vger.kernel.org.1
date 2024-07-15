Return-Path: <netdev+bounces-111444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C793112C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD473B2235E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B9186E2C;
	Mon, 15 Jul 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMVFmjLq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC496AC0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035687; cv=none; b=rcly+6e2DOqZqWQgCp2xRyQkW16NuSXUD+SIpckf//nRcURe2qGazKZEShmrz6tqjBzTYE6E4ZmjxhgkhB9bVGu72JumagF/9OwGe0IUA13OX3n6fx+WRAx2q3A9NvYts2WSlFAxiDd4NlhHYu3F4aNpXTSnKcnExHbnXFfyIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035687; c=relaxed/simple;
	bh=eO011eoGaZndwiK+xkDlGZOwq3KkyIs0tE99i8JD2+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeIesbIsj6GAxbI5TwxvjKDaU4XHIw6MkkVHbu+4XRop+Jgl01MXUbkYZRgdkZA+mCYo0i9rGXd+NYUchk9tIJ0LOE+qyedLkmL0abPvS5wSeDEflEU+NvLtYNe+04BGd1iBhnPww5n9tZApcrs/9uLwKn0ZtPxRkpmGcKpmPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMVFmjLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E2EC32782;
	Mon, 15 Jul 2024 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035687;
	bh=eO011eoGaZndwiK+xkDlGZOwq3KkyIs0tE99i8JD2+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMVFmjLqoahnMrEBgDixtfM6KaKhkWq9DGBRolmRjV0X836BtQQ+iQFZ+rkrZ/T3u
	 bpSIaJnnn5ddQt56NnqXupEcde6+EonQikN55Txx6IyCP5J2lu0wR7ISFCdvwEcFbV
	 crGG9Ndgp+EwAj/rspLfb+emoAsVnT9qOs07gSEUtMLDmqLOriOqh30/bnX7mvBzpe
	 1WggPtYfGHnMhyLklOE4UjozQpud5z5idFItj5rkAjbLgk/oes9eU4N3vl3gZIxxEE
	 V6DJ7vKLYNwSeWTpWJTLoghqLVVZK47E4LnpkxWpH1vqAnZVi23rymFdJnXIn9hfbK
	 EhbAAVojar6Mw==
Date: Mon, 15 Jul 2024 10:28:02 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 4/9] bnxt_en: Deprecate support for legacy INTX
 mode
Message-ID: <20240715092802.GE8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-5-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:34PM -0700, Michael Chan wrote:
> Firmware has deprecated support for legacy INTX in 2022 and INTX hasn't
> been tested for many years before that.  If MSIX capability is not
> found in probe, abort.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Hi Hongguang Gao, all,

The minor problem flagged below not withstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> @@ -15743,8 +15714,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (BNXT_PF(bp))
>  		SET_NETDEV_DEVLINK_PORT(dev, &bp->dl_port);
>  
> -	if (pdev->msix_cap)
> -		bp->flags |= BNXT_FLAG_MSIX_CAP;
> +	if (!pdev->msix_cap) {
> +		dev_err(&pdev->dev, "MSIX capability not found, aborting\n");
> +		return -ENODEV;
> +	}

Given where we are in the release cycle, perhaps this can be addressed
as a follow-up. But it appears that the above leaks dev.

Flagged by Smatch

>  
>  	rc = bnxt_init_board(pdev, dev);
>  	if (rc < 0)


...


