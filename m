Return-Path: <netdev+bounces-254113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG8hDeioeWl/yQEAu9opvQ
	(envelope-from <netdev+bounces-254113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:12:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEA99D5A5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8873009FA0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48463358B2;
	Wed, 28 Jan 2026 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RIoyvAFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAD3164CD
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580772; cv=none; b=UR+yEcnmZpz1e271OqNlb44PWqOTKEiErFYoZC+d/YGXNyo1MP9V7yV0+AisRpvSAn/zlPDw2Q3hOppwGzzbuYJUIxKsWGw/jPmoORhrLv6p5tIXvIXl1f7xlN/jQdIEUCccdEY7F4W8lnjwfWNBqMv5z250fiybMhBE1JvSqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580772; c=relaxed/simple;
	bh=YLUHJd0pr/gCbRjHRGDjub5z3iJQrwi+JnrgPOc0y/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW9OUpGQwKJWVgS/4mTDmC5K8OyDg+YZHP+wmMlgWBznc5Gu7T59TWm6XmN908duJV+Haa2Xnerlu27k4w8hBwh3NnartQEBvtXsGPQzqjIyW9bxhC1vHy10Vk2Ze8c7pVure9wbymAFLq3Ebb1/54/sThwFUIZHmP53FAD9dHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RIoyvAFc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0fe77d141so37583915ad.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769580771; x=1770185571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3WEC8RD1aMs9IUB6uoRFQEPs+F4nQiduogoltfPveY=;
        b=RIoyvAFcKuWcG09cU5sO04zff2J3qDgZ8UuUiZG0G8jmNv/2phjL3Twv7PyD8H+T19
         ThWxC+p1mi3HWpZdvP/3VPsPT7nHgBEk/xbqo82EbJv6jczn1RwQl0Cqv2HAFl04aTwi
         +J8S0tBXuEmqF02SopUZatoltR0j2AxWejJRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769580771; x=1770185571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3WEC8RD1aMs9IUB6uoRFQEPs+F4nQiduogoltfPveY=;
        b=GHLAVLVZMa95TeewEermidCniPRLb9l7cn91RwqCfa0MmE8dZrrPo1n/NBs/29MMwN
         EgbOREil4P/VUa3IRRHg/2u7+Wg0UGdsefHLRGrUJP93a+L85kmnOz8E1DkbVmeTdrpM
         uhA7iacLkC4kgagP9rwtlEZnhHHJjNrRecxEaD3xMTF58H2UBCOfH/WyPv4wk6axuhxZ
         Qk/v+r7zr/gd0uFbuwOl50O5MiUD/HF6/3Jk5rBlBxCuIMsTS9po6k9ZKOdeCS6rE8IJ
         Re2VOEe+jUKfgXSBjTA+zZSzMP+/I4azqF5C/FAqcT5qD33+JxdZmc9BbvAkE/01tCPA
         89zQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+6u75XbN8qz5BiihVRjaQOeK0AUAYZHLtFYfRuhsFKuZCFEwV3ZAtlYfjgolOopj1znKfamw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7eK1Wq5cuF3kYyWSbrPAx0BdlxWp/Tmsbo1WSqyzJ1Y7Ci6c
	unaUOo+7M2ZXWj3p7KwRBjZbsjag8EvDwxtyCUuSVOIIB6NJuQCpuFcnFdqjjtNZqg==
X-Gm-Gg: AZuq6aLs5bM6Xvzuu0+RIpeykDC5/IC2nuGW79vdre6btuCFUUWItvgkQFM4g1YwSyp
	gelx9Ej+SLlEbGAEYuoIszCM25SNAZnjVA94z1Z885t/uGbxtol1PyLLdVkACB+RktQ6KxfwntU
	PKCwVsdWG472viaeUv6Ed+qSzlugazEM6rQBNULcU7Uz73/VT0q/RH1q3UpQcEAquJar34jEz0O
	v0q4CF21yH510xc2Gsuni3QsGNuRLH9fp/fbsq9hpEdVnd2no3ktAaYf73I/0/1DTxlo8wlUyY3
	nvVhuUQZ45cSKdk3/HoFjYGdpw0q0r+N3jBB8XDxyk9z+QXgFNYR0VdMEweC7NdYp20M2glG23y
	e8/B0op7IYIiipSt8bIeOPvXJLZ7lHq8WXI/njxRMoYr507g16GVQ0pfm9P6wusR2qlC0lKhfVS
	c0IbYGicVley2ffGK/Cj2hB1dhjJHhB6ie1A0AIcRkqZaEIrXPkQ==
X-Received: by 2002:a17:903:384c:b0:29b:e512:752e with SMTP id d9443c01a7336-2a870dedf9cmr49345775ad.47.1769580770701;
        Tue, 27 Jan 2026 22:12:50 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:bf24:413d:1e8a:6aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6efc1bsm11206955ad.74.2026.01.27.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:12:49 -0800 (PST)
Date: Wed, 28 Jan 2026 15:12:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>, 
	Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: net: usb: r8152: resume-reset deadlock
Message-ID: <fnvkmao3cfavr6gijb53h77wtk2nixjjhczx5wxnu7baypbdmg@elrzevwou7dd>
References: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
 <13903eae-7a61-44d6-8e54-1d3f85799f58@redhat.com>
 <whsdw44eikzzbzgzobfxxnbt2yibsqbm6o2dhrgmrbvr5srmkr@ic5em5ck5mcz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <whsdw44eikzzbzgzobfxxnbt2yibsqbm6o2dhrgmrbvr5srmkr@ic5em5ck5mcz>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254113-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 7CEA99D5A5
X-Rspamd-Action: no action

On (26/01/28 14:58), Sergey Senozhatsky wrote:
> Something like this?
> 
> ---
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 30f937527cd2..0a570b8ac7dd 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8542,14 +8542,9 @@ static int rtl8152_system_resume(struct r8152 *tp)
>  	 * reset. This is important because the usb_lock_device_for_reset()
>  	 * that happens as a result of usb_queue_reset_device() will silently
>  	 * fail if the device was suspended or if too much time passed.
> -	 *
> -	 * NOTE: The device is locked here so we can directly do the reset.
> -	 * We don't need usb_lock_device_for_reset() because that's just a
> -	 * wrapper over device_lock() and device_resume() (which calls us)
> -	 * does that for us.
>  	 */
>  	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -		usb_reset_device(tp->udev);
> +		return -ENODEV;
>  
>  	return 0;
>  }
> @@ -8674,6 +8669,14 @@ static int rtl8152_resume(struct usb_interface *intf)
>  
>  	mutex_unlock(&tp->control);
>  
> +	/*
> +	 * This only happens for !SELECTIVE_SUSPEND and RTL8152_INACCESSIBLE,
> +	 * drop tp->control, because reset path can re-acquire it (e.g. for
> +	 * MAC address/policy update).
> +	 */
> +	if (ret == -ENODEV)
> +		ret = usb_reset_device(tp->udev);
> +
>  	return ret;
>  }

Sorry, sent it too early.  Something like instead perhaps:

---

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30f937527cd2..c9406b89bb12 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8538,20 +8538,18 @@ static int rtl8152_system_resume(struct r8152 *tp)
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	}
 
+	if (!test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return 0;
+
 	/* If the device is RTL8152_INACCESSIBLE here then we should do a
 	 * reset. This is important because the usb_lock_device_for_reset()
 	 * that happens as a result of usb_queue_reset_device() will silently
 	 * fail if the device was suspended or if too much time passed.
-	 *
-	 * NOTE: The device is locked here so we can directly do the reset.
-	 * We don't need usb_lock_device_for_reset() because that's just a
-	 * wrapper over device_lock() and device_resume() (which calls us)
-	 * does that for us.
 	 */
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		usb_reset_device(tp->udev);
+	if (test_bit(SELECTIVE_SUSPEND, &tp->flags))
+		return usb_reset_device(tp->udev);
 
-	return 0;
+	return -ENODEV;
 }
 
 static int rtl8152_runtime_suspend(struct r8152 *tp)
@@ -8674,6 +8672,14 @@ static int rtl8152_resume(struct usb_interface *intf)
 
 	mutex_unlock(&tp->control);
 
+	/*
+	 * This only happens for !SELECTIVE_SUSPEND and RTL8152_INACCESSIBLE,
+	 * drop tp->control, becuase reset can re-acquire it (e.g. from
+	 * max address reset)
+	 */
+	if (ret == -ENODEV)
+		ret = usb_reset_device(tp->udev);
+
 	return ret;
 }

