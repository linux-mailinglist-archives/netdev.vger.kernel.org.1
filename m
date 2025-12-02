Return-Path: <netdev+bounces-243335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA0C9D505
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 00:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5599C34896F
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 23:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55E25F7BF;
	Tue,  2 Dec 2025 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g2ETMRDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EB42AA6
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717340; cv=none; b=UhB1clxvBq4iMJoYstjd+R3cbU/AoCs5q4jG+QiAtkv5HQiGiBO15AI0FtKGhHTPCcReIBLvrJcJ17NsWnnI7ymtxS42pHAKC2UCRUVB6OnCKW+Ct6bdjbPNYUZZARW/mq9TVMQg4FUQPYOxtxDUeFTf9pvLS5X2gbdtbeAVX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717340; c=relaxed/simple;
	bh=Rx64nhyR10Xd4pInukw1CUV7TFV7x+DUojL3NAqd5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY74SRIsyk9Rnn2TjgQKhBJgSXWbQPIOXnfP9uRFRt0DhudweL7O+ZN+iHyr5LgRmElfyQgwy8jtqKmO5yFhOk0b/59bofxk4yKkCyvNWeo4Cd+bEdSJE9rZxHMbWzVRyqkKXpoLZlwH6SlC3cPipPTqzoV62OXw/Xdpsg3REKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g2ETMRDd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12ABA1A1ED0;
	Tue,  2 Dec 2025 23:15:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7F71606D6;
	Tue,  2 Dec 2025 23:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C669103C8BE6;
	Wed,  3 Dec 2025 00:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764717334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QVCEtMPxUMzXVw1tyOYFZnZkE2dG16ZIPwRsI86PDIw=;
	b=g2ETMRDd1PtRSkP2sPHrCCQihw5ErXT3zmAqujO2QXqemb5zcQzwwqP0OB1XOI6Ev1Pi9b
	t+Du3clnlXw0scsQsz7HylEf7VfZAk7Do79jbMfpt14tYXKRVspzWZYiOX+e/ayF9ff8NZ
	8ctyciOlNEJCjygCVEoFhzAcMkR60Lnr9+WaqTSp3LUXBZxk3P5gkq1ndW0W7UIKACZbSB
	THM/j0KyWTTsemu5E8P4AUCLZNhr+8eTUrS+o3bLjmXMVwa0Eo1deR3wIeRhUT1qCOrgiR
	767CUqLtnWn6lm2mq/ZRDtEntUIhsjQ3vk08dDq4lcV0t2PgK5rieR9whGBO0Q==
Date: Wed, 3 Dec 2025 00:15:26 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-i3c@lists.infradead.org
Subject: Re: [PATCH 4/4] i3c: drop i3c_priv_xfer and
 i3c_device_do_priv_xfers()
Message-ID: <2025120223152613f1586a@mail.local>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
 <20251028-lm75-v1-4-9bf88989c49c@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-lm75-v1-4-9bf88989c49c@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Frank,

You'll have to rebase this patch.

On 28/10/2025 10:57:55-0400, Frank Li wrote:
> Drop i3c_priv_xfer and i3c_device_do_priv_xfers() after all driver switch
> to use new API.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> This patch need be applied after all other patches applied.
> ---
>  include/linux/i3c/device.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index ae0662d9d77eb3fa0c976de1803e9c2ff9547451..47e6c95d87f9494d48c5b0463544916f26923501 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -25,7 +25,7 @@
>   * @I3C_ERROR_M2: M2 error
>   *
>   * These are the standard error codes as defined by the I3C specification.
> - * When -EIO is returned by the i3c_device_do_priv_xfers() or
> + * When -EIO is returned by the i3c_device_do_i3c_xfers() or
>   * i3c_device_send_hdr_cmds() one can check the error code in
>   * &struct_i3c_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
>   * what went wrong.
> @@ -79,9 +79,6 @@ struct i3c_xfer {
>  	enum i3c_error_code err;
>  };
>  
> -/* keep back compatible */
> -#define i3c_priv_xfer i3c_xfer
> -
>  /**
>   * enum i3c_dcr - I3C DCR values
>   * @I3C_DCR_GENERIC_DEVICE: generic I3C device
> @@ -311,13 +308,6 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
>  int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
>  			int nxfers, enum i3c_xfer_mode mode);
>  
> -static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
> -					   struct i3c_xfer *xfers,
> -					   int nxfers)
> -{
> -	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
> -}
> -
>  int i3c_device_do_setdasa(struct i3c_device *dev);
>  
>  void i3c_device_get_info(const struct i3c_device *dev, struct i3c_device_info *info);
> 
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

