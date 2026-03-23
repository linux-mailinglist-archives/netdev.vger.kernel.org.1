Return-Path: <netdev+bounces-270361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BH/Fv3MwGkgLQQAu9opvQ
	(envelope-from <netdev+bounces-270361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:17:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B372EC9C8
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF3F302206E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 05:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCC15665C;
	Mon, 23 Mar 2026 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHV+rjR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EBE158535
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243042; cv=none; b=beva8v5LhyjZKzoOoDyVH6dDACjgFr0xJNTI6LXhZjOa/vJVGPGsC2NVJxE7Ng/BEs0289w/kDjqPHtoCO44HrQRKovIHX8OSsm8rYVAjocm3kSSK2YbmUu7WwBoHmLqxTh1dFgBso3UVLqxneOjenS3WNmY7D3Zfzg+78YcwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243042; c=relaxed/simple;
	bh=pfWTJZqaVhDCbFG2fAE5ptgG+qJ6NN4y7N0S/smJD24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUK59TTG4noOKCKGpGr+3LB0jM0jLdMypWE3e21cTN9nTbzjmmDvfajcTrgj7llDuZlgnDjC7BvpkusxBrOpfQ+m5aG/0ynPelA04pr99JTEun1RZrsy49IBceMWk6B0iZL1VjkjCjhe8VRlDEahz8kQvQnAX778HxM1C9vzm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHV+rjR4; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c107ef474fso4641787eec.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 22:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774243040; x=1774847840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jpqkfz7hZUs+vzaN1OQd+jtBYhuxG1ZULSLXTe38VI=;
        b=EHV+rjR4uLE2ZpVupR6/bntiSBDG/Xjb5SHch7GJZGBpnXq0cb0REaAR7geSu29UrM
         5f7t+R/0xF+JpLTTxsRPkKNtbN5eM8qEbd4VFKyaleEqyJikeXu6Jo0Prtqc8vp7xc/+
         JZjpYHmWQ7uVLX5Uy69gei695XxH3x3uxRYV4PI1+Hws9GTFcZEpcbxO1OQ+0VWXOSJI
         QvyMOrDYlCOKfEIk0027i5KQzPvZdtfnNYZ/+sUgcToiU//PpSTneYASnyag4K2jlN0w
         dg5tUScdeD8qJJP9nS3Hgo41ImVOdp1BcNJh+4vCwLNwQU7ByFppk+DuOcGxk/LHItOp
         eSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774243040; x=1774847840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jpqkfz7hZUs+vzaN1OQd+jtBYhuxG1ZULSLXTe38VI=;
        b=X/2zqmHLTiU34I6RTUR+gSUdKr4unFHQeL9AzqCLZLYhupJXLzA7VGgyfxlZM3oxiO
         EtaznMMCkRHf8I4UZfoIu+MqIM+UFb7XncKJE4C/sUczy7EKoVkdtqtOYuK5m2njT9fX
         f8/MhDW+VCVburVpHxVnfNGcx2qQvkdg2crS8qWqY2PQ8t5zaeFHCeMauQ/KQ5rbWGQB
         zo1NOfjJe9YYJdKM/h+n2/bX6HUWnal9vzo05f7iLwiYcCj2KNaoKjMR2yFOdam7om2s
         l3vCbUw7hTEAAbmkn0mc/Jqd0MrL5M+zYctDtkCZec4iPNsbMZD6c79oRNiU8soqNKHV
         bz+A==
X-Forwarded-Encrypted: i=1; AJvYcCVwKF8dIYMBQUias/qCRUosa/rIdQhb2CV0QyBGpwf7RdPLm2NV0OkESV1+7dT6wKyxRyO3CTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUoaRnScDuEtAh7njklxXQ3OIMselollJSmtZxn5X5O6zmVmX
	E2NKbek7wFo90uMGJIZinXxyHOVbpoef1kJSJbFt0g1W+hEzykE4JwTs
X-Gm-Gg: ATEYQzxabMrP2N13XNAoKHTpXMJgx0HfOSQv0oDujLjyEJcQLoKNzhsB+2JKEjIUUMc
	BY6tI+SFEm2nBOb4XyGklcLu6htOYk2xfRylSwyyH+mGCuDhybCQcTkMdPZMD2dtfVWidkOAlxj
	ivcvKyAvvqg/b8+9hlGnN7F8AQohC7Aey6GCyU61PqqUjza6UoyDr+w3QH37nCNjmzyoDFf4RAy
	gg7yJLouRO5sYrk3mG/or5sNhW6V9k0plK1kc5N+yWQCKJZAH+PU+ql/LNhczscVCWCo4cTIQHx
	Qwh79HC6E/NDBhy6xcSNq/PvuFOTOFtHb6KI9Jr04mbfBxUVwrJdEu3RiqrxQ8W4pv/m5nUqY2i
	Baw9bsYzJOp/VJ9uW/2o11HE/RuHarwtS/EpH0lWcXKjkT19zRPDwbej4WgcZHRtotq4McY0uHx
	iNw7b+jzKMKf6BpNcRIofW+EK03HOTVUljGCLQj4eeASZHKvpd9Mpv/ltMI/bdY2U/
X-Received: by 2002:a05:7301:4198:b0:2c0:c775:a46b with SMTP id 5a478bee46e88-2c10961ef1bmr5539127eec.8.1774243040114;
        Sun, 22 Mar 2026 22:17:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm13470084eec.24.2026.03.22.22.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:17:18 -0700 (PDT)
Date: Sun, 22 Mar 2026 22:17:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Tom Rix <trix@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acDLzK8vpptTUMf1@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05B372EC9C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > +					of_fwnode_handle(mdio_bus_np));
> 
> When you look at this, why is it better?

I think we should move as much as possible towards firmware-agnostic
APIs and use fwnode_handle instead of device_node or software_node or
ACPI companion. To discourage this I think we better remove
firmware-specific APIs where we have firmware-agnostic ones and
eventually clean up drivers that use OF- or ACPI-specific APIs.

Thanks.

-- 
Dmitry

