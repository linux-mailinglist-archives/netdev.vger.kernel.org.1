Return-Path: <netdev+bounces-288017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JDRBI/mBWp0dQIAu9opvQ
	(envelope-from <netdev+bounces-288017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:13:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FC543CBF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0BC03009394
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC58407599;
	Thu, 14 May 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="hiN4fwHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FF4014A3
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770846; cv=none; b=X1RZ5e3Q9yOSTXRduU7LdQ2x17WGkAgfvoNpYK+V0sl5mwqMUgfiy2paPMvIqgXvO5Tlo1WyDfsz3X3dRYA6qvgPORNBCYYJz2rPlpTww8Wm2V1uwQ88xKHveEu2QYtPPDkb98gqFOiAy+tJ/vrpA1aCv/bGaEwNQJTUmj8mXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770846; c=relaxed/simple;
	bh=4npBjrVvi1nAurHHYzboVrGuBiR8WxUCErtRQizkNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8KS742KE4xdxNI5Y3K2McOSLYmTISPdWm79zR1gaqLM6JstSxJByDxfUA0wO1gUrp1C8YYD4MqP0d8Pnur1VeNRYM/IaYW+BmnqDkOiCZctzHh5fxOz53r/oZsW/rmlZGipuvnn6G2aWAQFXt/ycZkI44K2E7ACn72meKHiWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=hiN4fwHB; arc=none smtp.client-ip=62.149.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.0.186] ([109.118.84.223])
	by Aruba SMTP with ESMTPSA
	id NXVFwERTUIfDkNXVGwiVvX; Thu, 14 May 2026 16:57:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1778770654; bh=4npBjrVvi1nAurHHYzboVrGuBiR8WxUCErtRQizkNhk=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=hiN4fwHBhYYDE9JYQeHobXzi2UWMQVw9DjmiwvHsevnQjETcT+YqtGY4PvISRLenC
	 yUbwKHkOJ2P9+NA+ja3o3V31kIPGqJN4jnZjxuwjL08xSV/1KxtOXNrljacbXTZ/4n
	 XYDWzpGuGUN8Da/hGv7C3pcChOceJJAYF+OW9sj/GQPHmDmt1XBiwGsMPRWHGPKjgH
	 iUuZtb1YaRfoWJgO8fyUWLNiJ7PuBtnhR83IucJzwc5qZY5pG3V4wivMEh71jYGdsa
	 Sp0SGdlZ2EOJB5qFtk9SADvINwkJcm88gDlx3u7/REaxAJjZnCVTOnOomYFZeCbtJw
	 Ed0CUS1tloFfw==
Message-ID: <13778ff3-70bb-48ee-9cec-0e6a092595ff@enneenne.com>
Date: Thu, 14 May 2026 16:57:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] pps: make number of PPS devices configurable
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJxannSbSFv8JfHqdn5JflYdVsY5/zxS4Sb9oUlAf4lLn8mARuyIpp4ScHyavJNY/IjiCCaDEKbn0CoRIpsT6rfs5VDfPcEwe/FTYdtsE8BPcbSmZa55
 nxlIesG/pEdg7XPvtQJKXR5IvzSLR399BmIxzHPPMdWrnCMto9YoM860xlsXj4cVsvH4GiLe+5TBH/OCCxCKJBNsbHjxzZ3GkPWmgxVyrQvZvCGlg5O0cywb
 wi9ozpmC/PZXHCtuBkVWS9b3Ojx4+Q8kxpJ3H07Hw0s9dHILMyWfSJ24V9vlEJkG6u0Yc2dWgzMlAzjoh32ouastYJBaL+H18GqIdWaH4vAlLwSe6udmPmhz
 /pAGB3gv
X-Rspamd-Queue-Id: 0E6FC543CBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[enneenne.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288017-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giometti@enneenne.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[aruba.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enneenne.com:email,enneenne.com:mid,linux.it:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,aruba.it:dkim]
X-Rspamd-Action: no action

On 5/14/26 13:26, Vadim Fedorenko wrote:
> Modern systems may have more than 16 PPS sources and current hard-coded
> limit breaks registration of some devices. Make the limit configurable
> via Kconfig, keep default value of 16 devices. UAPI has to be changed to
> support maximum possible number.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   drivers/pps/Kconfig      | 9 +++++++++
>   drivers/pps/pps.c        | 6 +++---
>   include/uapi/linux/pps.h | 2 +-
>   3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pps/Kconfig b/drivers/pps/Kconfig
> index e1651d51cfc9..166c157505fe 100644
> --- a/drivers/pps/Kconfig
> +++ b/drivers/pps/Kconfig
> @@ -22,6 +22,15 @@ menuconfig PPS
>   
>   if PPS
>   
> +config PPS_NR_SOURCES
> +	int "Maximum number of PPS devices"
> +	depends on PPS
> +	range 16 256
> +	default "16"
> +	help
> +	  Set this to the number of PPS devices you want the driver
> +	  to support.
> +
>   config PPS_DEBUG
>   	bool "PPS debugging messages"
>   	help
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index de1122bb69ea..d3eac77b4cb5 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -370,7 +370,7 @@ int pps_register_cdev(struct pps_device *pps)
>   	 * Get new ID for the new PPS source.  After idr_alloc() calling
>   	 * the new source will be freely available into the kernel.
>   	 */
> -	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
> +	err = idr_alloc(&pps_idr, pps, 0, CONFIG_PPS_NR_SOURCES, GFP_KERNEL);
>   	if (err < 0) {
>   		if (err == -ENOSPC) {
>   			pr_err("%s: too many PPS sources in the system\n",
> @@ -464,7 +464,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>   static void __exit pps_exit(void)
>   {
>   	class_unregister(&pps_class);
> -	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
> +	__unregister_chrdev(pps_major, 0, CONFIG_PPS_NR_SOURCES, "pps");
>   }
>   
>   static int __init pps_init(void)
> @@ -477,7 +477,7 @@ static int __init pps_init(void)
>   		return err;
>   	}
>   
> -	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
> +	pps_major = __register_chrdev(0, 0, CONFIG_PPS_NR_SOURCES, "pps",
>   				      &pps_cdev_fops);
>   	if (pps_major < 0) {
>   		pr_err("failed to allocate char device region\n");
> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
> index 009ebcd8ced5..1088dea65e12 100644
> --- a/include/uapi/linux/pps.h
> +++ b/include/uapi/linux/pps.h
> @@ -26,7 +26,7 @@
>   #include <linux/types.h>
>   
>   #define PPS_VERSION		"5.3.6"
> -#define PPS_MAX_SOURCES		16		/* should be enough... */
> +#define PPS_MAX_SOURCES		256		/* should be enough... */

Nak. Let's make everything configurable, or let's leave it constant. 256 is OK.

Ciao,

Rodolfo

>   /* Implementation note: the logical states ``assert'' and ``clear''
>    * are implemented in terms of the chip register, i.e. ``assert''


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

