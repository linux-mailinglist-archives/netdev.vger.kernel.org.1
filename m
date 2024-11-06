Return-Path: <netdev+bounces-142151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7959BDA7A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2741C22925
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358B44C8F;
	Wed,  6 Nov 2024 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/0YX+UX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E11F16B;
	Wed,  6 Nov 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853825; cv=none; b=bdBFZdShmMvWS9+97gZBEHCCgjuuNUxzy9fi51TZXeah1YuTqAYt7CQKSS3vE8Df+e0jxIXO7es2FbAfDJUkZTNcVDQ1yTncV3Z7uhpfkmZhnphUaIhAO0f8RqK3cI/7+tq+kuAxUD6PLQq8SqGpXruEj8t5p6ND70I0ys5DF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853825; c=relaxed/simple;
	bh=soDlcB0y4It8bgovUm+emXqLGYaqGudc3fapGnb2SbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ2a9laMkqK7kuui5YRBautICZ0dsrk47Bu8+/nBAYtNLMxq2YRLSDAxmTmhs3Rbr8eEik18Vpc5hv91blq0U20oGMh8VYWsoIpBm0mUdJeDmszb3YVeivQtGQNGgCV1UJCDg4i/FGHwJn7Ykp5X+OVKrr72hGVtQqNFXnk8UIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/0YX+UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D5C4CECF;
	Wed,  6 Nov 2024 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853824;
	bh=soDlcB0y4It8bgovUm+emXqLGYaqGudc3fapGnb2SbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/0YX+UXMuCr94mNaS6df8VyDlkKpE5dlfxn2Dnv0S5EK9ylJFOCqDFSeeZMHDp+u
	 gnt7KqoP0OxT0j28GMfVEaBO4n6SR6o+6F0YHmGYcS7wTqENGd74xCq/wVZvBj8w54
	 UjSWX1EGUVeJxmcCyJtRk0cT1WXSwZc03lg0Mr8OAZNRLQxtK3zkeJL5pb3iNLwW+B
	 z1o6CWIE0EQWvZ3d3tHEzi3TRNpecDnEbYeN1iQhwba17006GVl95NTQVHtxWYHMru
	 2zQ64nmrb+dxx6CorUuNJhONREMz8F2POAN99C9TKYM06nOH43sK/cHLEvC8cm67q9
	 U1+JA7vo/DT1A==
Date: Tue, 5 Nov 2024 16:43:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241105164342.19e4a11b@kernel.org>
In-Reply-To: <20241106002625.1857904-1-sanman.p211993@gmail.com>
References: <20241106002625.1857904-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 16:26:25 -0800 Sanman Pradhan wrote:
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index fec567c8fe4a..a8fedff48103 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -6,6 +6,7 @@
> 
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/netdevice.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>

Sorry, I somehow missed this in internal review, this chunk looks
unrelated to the rest of the patch, please drop it.
-- 
pw-bot: cr

