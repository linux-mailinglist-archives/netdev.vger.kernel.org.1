Return-Path: <netdev+bounces-165453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2DDA321DD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 10:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D57A19D5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450CB2054EC;
	Wed, 12 Feb 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lc/11+AA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CE1EF0BC;
	Wed, 12 Feb 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351766; cv=none; b=ZKMWvFQPVznA4OdUHrVBFYljfo9fnxQRpj1SAlmW64tkJ1VKEIRwwQ2TvgN9G4M8VimPRb7R5oLYQAm1uq1nIRdTAEJJ68ll9LwSt5AMChmDtcze/Yhwpz3QoJ2/31Rvd30Mjt/3B2Xb+txDWCa6kvYmV3JNxmwN/yD7zbKleoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351766; c=relaxed/simple;
	bh=586BzYlk+Ygs9JfrWVlD0JG3qFFy+8RrRzgbZRazOq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn5ZXmP5ExhY5vc3vD/JRUQhPBQloYa4nnodvJVHLJ9rFaesm/Li7cvr95i6Ug1e1fjChv8umfm9mrp/iiVMrZvWPBLeWHTdQEGXYgbzMFWw4Hb4saYxEvxfvRMGpzSDScmGGLvjbL0KbWZkJb5qncjM0AOXecumPEGMo3utEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lc/11+AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC868C4CEDF;
	Wed, 12 Feb 2025 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739351765;
	bh=586BzYlk+Ygs9JfrWVlD0JG3qFFy+8RrRzgbZRazOq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lc/11+AAksnYQFMkVCEPipEVinpyH3Q1FStBJ42OJJqKzVTDCgZoy22d9/C+tl+zW
	 fOIGghIU9nYrZxnh4+qn7L0PKNhcUtk9J4apl1ZwXrDg0DtnvJAp4pib+qoG8uYhpE
	 rbc+5nF9laDV4czP2FF1c2rNf/dKRPcQuKhpO2HQ=
Date: Wed, 12 Feb 2025 10:15:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next v2 1/2] usb: Add base USB MCTP definitions
Message-ID: <2025021240-perplexed-hurt-2adb@gregkh>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
 <20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>

On Wed, Feb 12, 2025 at 10:46:50AM +0800, Jeremy Kerr wrote:
> Upcoming changes will add a USB host (and later gadget) driver for the
> MCTP-over-USB protocol. Add a header that provides common definitions
> for protocol support: the packet header format and a few framing
> definitions. Add a define for the MCTP class code, as per
> https://usb.org/defined-class-codes.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---
> v2:
>  - add reference & URL to DSP0283
>  - update copyright year
> ---
>  MAINTAINERS                  |  1 +
>  include/linux/usb/mctp-usb.h | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/usb/ch9.h |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67665d9dd536873e94afffc00393c2fe2e8c2797..e7b326dba9a9e6f50c3beeb172d93641841f6242 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13903,6 +13903,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/networking/mctp.rst
>  F:	drivers/net/mctp/
> +F:	include/linux/usb/mctp-usb.h
>  F:	include/net/mctp.h
>  F:	include/net/mctpdevice.h
>  F:	include/net/netns/mctp.h
> diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..b19392aa29310eda504f65bd098c849bd02dc0a1
> --- /dev/null
> +++ b/include/linux/usb/mctp-usb.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

I missed this the last time, sorry, but I have to ask, do you really
mean v2 or later?  If so, that's fine, just want to make sure.

Whichever you pick is fine with me, so:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

