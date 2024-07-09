Return-Path: <netdev+bounces-110080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4742192AEAB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E4FB225BB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604DC43AD5;
	Tue,  9 Jul 2024 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saLov+v1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E45B1E0
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495314; cv=none; b=sCVK61uVaCINDEdh8mncK4ob+SgjZMi2+HIXnPnqVqdRSGH4+65crdtv+BMM4c05l/RYVTQNQ/Gpf906EKn7MtsiIADks1PxlQbKnbxXtAFc07JTlBcque0dWQB9upnOopcsFomvfPcMA+3FFS3iMhqWTJaY4EiNj3n5SXvcRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495314; c=relaxed/simple;
	bh=wEp8EuEFPAeJiRrfv2sO9IVyq8L6Mxh8jgxdCYa52Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWLeMbT/wfMz9T+iuQlAfiV5GYG4L7EEcgJULP+AjFh+5CTjQvcxnu3lsB5pS5gSLkkQwzkahCNRTTD6bBTQdrk9k+5LSEFAi0eupA3Vq0og1BNToBplrkvIwhs63kB4AUd/VMds67PPF5xSSRV5wBTEehV5EdH7WoGHQ2hT8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saLov+v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47882C116B1;
	Tue,  9 Jul 2024 03:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720495313;
	bh=wEp8EuEFPAeJiRrfv2sO9IVyq8L6Mxh8jgxdCYa52Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=saLov+v1Ns5ikadyvHqSrFkZcjt28IDExpZSfk3z41X6o7MZ+kc4gjW8Ebh6EIiw7
	 +7tbYgD+taNlSEpXXCh1Q28PUwSykZTEyfaceeFryETMH8pdckBclSSPJSdk7DTsCl
	 4DmZ9ksVvRh5BDWMUg0oYHzcL+JQUXlZpGy3jEcNAiC2cHm495+eFwRmgjaNIh4GJn
	 3shIszUlAmlwiXQA40GrqciHZaj44q9OiWs7/knHs+/FF8jF+XYNgVVoIq++5mhQqi
	 Bo8ueRgaXfZIpKkcu1DzBT8p+yby2/5JDqOZL5pygKa2M2esGWvED0jfO/vUxIm5iY
	 LGytOideAasbw==
Date: Mon, 8 Jul 2024 20:21:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH] [PATCH net] net: wwan: t7xx: add support for Dell
 DW5933e
Message-ID: <20240708202152.56eb8e24@kernel.org>
In-Reply-To: <20240705091223.653749-1-wojackbb@gmail.com>
References: <20240705091223.653749-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 17:12:23 +0800 wojackbb@gmail.com wrote:
> Signed-off-by: jackbb_wu <wojackbb@gmail.com>

The sign-off has legal implications, please use your name.

> ---
>  drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index e0b1e7a616ca..7f3d0f51c350 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -852,6 +852,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
>  
>  static const struct pci_device_id t7xx_pci_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x4d75) },
> +	{ PCI_DEVICE(0x14c0, 0x4d75) },//Dell DW5933e

A space missing before and after //

Please make sure you CC right maintainers on v2.
-- 
pw-bot: cr

