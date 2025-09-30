Return-Path: <netdev+bounces-227300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F44BAC16C
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727127A4D4B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBF2F3C16;
	Tue, 30 Sep 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2Up8o/k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA024886E;
	Tue, 30 Sep 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221528; cv=none; b=rGa3sQvH/51vjn+lMPbrIxtaDdCUA4t4hxgPrs+x2hxyqJuSBHw+H7dz/KsWIWLw0gSxvjLbV28hVomlMsnkaYznEbGHtqNZGzK5fsRT/zBh1P1ucaGUTySOuEQKc4Tys8Z3XTIO3K7iY4X9zvCPtoL5nBMF5yXyuCyQPYAuEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221528; c=relaxed/simple;
	bh=i8U4v7ypNhaRmdleLGcOrI52VmPy5E3oCpIsxZaMkZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr5eDyMwyliUJV4BXeaz1U71G+guzSghc1HrsRufwxfBgho0kAwk0K9sKddQ2maecmDC7NniXctGJUNo8z19eRhDVD1A33wW6In5KlaNHkFeIq2VKZH1HO5vK0KNS9y7iROTZzog60BgKhsudw0tFBbx4Cf/WqpzwqVDXs5p/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A2Up8o/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CD7C4CEF0;
	Tue, 30 Sep 2025 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759221528;
	bh=i8U4v7ypNhaRmdleLGcOrI52VmPy5E3oCpIsxZaMkZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2Up8o/kV5nz35rUGEWJ2borJIjVsxevCvz5VGbnawDamBqguKWbGeBS1DCi89vaX
	 UDmR1CeW4xC5UUxM1HGmszb8JCDFJ0Zm41S25IcQwKYVMlz7mfKVPW7J82o7vK8si5
	 wongbeNPU6zGsrWHYCZnRJNo0cML/Xz7M08CaEHU=
Date: Tue, 30 Sep 2025 10:38:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	marcan@marcan.st, netdev@vger.kernel.org, pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH v4 3/3] net: usb: ax88179_178a: add USB device driver for
 config selection
Message-ID: <2025093020-ripcord-dentist-e0d7@gregkh>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
 <20250930080709.3408463-1-yicongsrfy@163.com>
 <20250930080709.3408463-3-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930080709.3408463-3-yicongsrfy@163.com>

On Tue, Sep 30, 2025 at 04:07:09PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
> device driver for config selection"):
> Linux prioritizes probing non-vendor-specific configurations.
> 
> Referring to the implementation of this patch, cfgselect is also
> used for ax88179 to override the default configuration selection.
> 
> v2: fix warning from checkpatch
> 
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/usb/ax88179_178a.c | 70 ++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 29cbe9ddd610..f2e86b9256dc 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -14,6 +14,7 @@
>  #include <uapi/linux/mdio.h>
>  #include <linux/mdio.h>
>  
> +#define MODULENAME "ax88179_178a"

Please just use KBUILD_MODNAME

thanks,

greg k-h

