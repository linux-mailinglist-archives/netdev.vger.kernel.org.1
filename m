Return-Path: <netdev+bounces-226224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF7B9E49B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2A74234D8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DAD27FD56;
	Thu, 25 Sep 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMCNdc5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411A27AC59
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792140; cv=none; b=hlrfvYifgop4CvwL/fNrI9e3IWW4zHRUWAbTFwgi8vWvywayrE4gKR3eT1lQjbzbkJBz5WH79X9ki8k/UZhhue8Bg79HPAhBuOP4lUA2xCu9KPfac3LO8YcNBh6FPUC8Z1lbKUn9NUdVsiAsxJmjFV248M1hRoUJWstOG92Dxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792140; c=relaxed/simple;
	bh=tQoctSrBU34S/s3Kxr3YuuBx9v8nMMLw/+m8rIvm8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8HhJCz1kvuOyWLitEB3ePEgPuZbDCmAeQXYCaM2VuXlhNjqNVXIw05shuo5Z3lQhFx5JxdEiFd0XKRz/kYoHRD2rZDp9Uv0gKOLnKfytrWG85/3xf9wnj9gfpXwgcHCe7b5RUjEIO3xZe6Yy/FXLt9jebh0xZhxa9P2b9SHv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMCNdc5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8F2C4CEF0;
	Thu, 25 Sep 2025 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792139;
	bh=tQoctSrBU34S/s3Kxr3YuuBx9v8nMMLw/+m8rIvm8z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMCNdc5TFZFqh24I/9AJHvso3wbaPAcvfDvvXO9vJ2Gc4420jsCLH+dBfaAjM/IkI
	 KVlnIYSHIAc+c+5+N96mXblw8xBNvlGQHHIlUdWiZybSP0fVKMNpU5uS3yjDX3cIRY
	 o95150MrNL1CARMFBc3R1bbhBRhYPYuQmqR4nUiF6//LTlaZGsr8sHiPD8D7wwSYiH
	 Pe7DjpS+tSHPkDQrRN08VtbGRDqnBe+je7I/yQVB24Pa8ME4mlj5HjnaZ8kcRF7Um/
	 ZELSwsiMSkeW1mNMkDDM1Jd5sShlgyOWy4XARmzhL3eXXaP2WQTvJCK7QMIYAbIoeW
	 OB/HieRDmDhNQ==
Date: Thu, 25 Sep 2025 10:22:16 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@trustnetic.com
Subject: Re: [PATCH net-next] Wangxun: vf: Implement some ethtool apis for
 get_xxx
Message-ID: <20250925092216.GA836419@horms.kernel.org>
References: <20250924082140.41612-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924082140.41612-1-mengyuanlou@net-swift.com>

On Wed, Sep 24, 2025 at 04:21:40PM +0800, Mengyuan Lou wrote:
> Implement some ethtool interfaces for obtaining the status of
> Wangxun Virtual Function Ethernet.
> Just like connection status, version information, queue depth and so on.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Hi Mengyuan Lou,

To my mind this patch, although small is doing quite a few things.

1. Adding ethtool code to libwx
2. Using 1 in two drivers
3. Adding a wx_get_fw_version_vf() call to two drivers

To be honest I would probably have split this up a bit.
Especially 3. But perhaps that is just me.

Also, I think that, as things stand, "net: wangxun: " would be a more
appropriate prefix for the title of the patch.

So if you do decide to re-spin, please consider the above.

But regardless, the code looks fine to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

