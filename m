Return-Path: <netdev+bounces-224754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53293B892E8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032843BCF31
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913E30AD09;
	Fri, 19 Sep 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r++6Mea2"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84619D082
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279858; cv=none; b=u0H/ZG5nd4+yhCey949nCgTQYa6Ja6mKo5u+phWck6fdueBhySmqZQtFrdAeDQAbE7dyANmoOOsPduNvgjoH7gCqkGnDvfPDoHm+4zsTnQqgX6Ki309Lv/UetbbLUtSpb6WaveJb1D/urmWTr9FuNn98piu/dXK1r+zZBRdaGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279858; c=relaxed/simple;
	bh=YWnXA6t9LaL0b1VLR8m8zSuHArH0my8YbIDteErVoW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4EjLDvs+kdHmRsDH0u1YXmpYMEvlunvAqJGwqhvhBRq37ykgdSoMGq5uQRVcJY6CvLGJt6Os8bvpNOasysw9YBlV+MjLozyCSzVnqw+SC+NsBnAdA9co7TGAlOJT6vU0TJxZIYYfsSQR/oVOXibqxnpFEqmXPDOBdNNlxGErE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r++6Mea2; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7f9ef01-cd17-487a-ba07-0a11a70e51aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758279853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tY5eQDprekpDAybmx7qWheqB1cWoY0C2WUwy8+8jqU=;
	b=r++6Mea2wbHJlf3DXWTPcsLP3x0WoEjFRApbfOcFrujysPWt/wRn5/Q9xuL3nyHMEzwQkJ
	2HkO5kpmk+oD8Q5QXEwua4U8bfzbLSRrVcYBSEs4eOIuf7iXqDIsiPrk5JVlNMdKHCua1z
	wjfjx1Sm1UxI0M+Fg7dv25UVmFS4dfE=
Date: Fri, 19 Sep 2025 12:04:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 3/3] ptp: document behavior of PTP_STRICT_FLAGS
To: Jacob Keller <jacob.e.keller@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
 <20250918-jk-fix-bcm-phy-supported-flags-v1-3-747b60407c9c@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-3-747b60407c9c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/09/2025 01:33, Jacob Keller wrote:
> Commit 6138e687c7b6 ("ptp: Introduce strict checking of external time stamp
> options.") added the PTP_STRICT_FLAGS to the set of flags supported for the
> external timestamp request ioctl.
> 
> It is only supported by PTP_EXTTS_REQUEST2, as it was introduced the
> introduction of the new ioctls. Further, the kernel has always set this
> flag for PTP_EXTTS_REQUEST2 regardless of whether or not the user requested
> the behavior.
> 
> This effectively means that the flag is not useful for userspace. If the
> user issues a PTP_EXTTS_REQUEST ioctl, the flag is ignored due to not being
> supported on the old ioctl. If the user issues a PTP_EXTTS_REQUEST2 ioctl,
> the flag will be set by the kernel regardless of whether the user set the
> flag in their structure.
> 
> Add a comment documenting this behavior in the uAPI header file.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   include/uapi/linux/ptp_clock.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 18eefa6d93d6..2c3346e91dbe 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -37,6 +37,9 @@
>   
>   /*
>    * flag fields valid for the new PTP_EXTTS_REQUEST2 ioctl.
> + *
> + * Note: PTP_STRICT_FLAGS is always enabled by the kernel for
> + * PTP_EXTTS_REQUEST2 regardless of whether it is set by userspace.
>    */
>   #define PTP_EXTTS_VALID_FLAGS	(PTP_ENABLE_FEATURE |	\
>   				 PTP_RISING_EDGE |	\
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

