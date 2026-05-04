Return-Path: <netdev+bounces-283815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BpRJE4iQ+GlswgIAu9opvQ
	(envelope-from <netdev+bounces-283815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:26:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBBA4BCDD7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7D2930065CC
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CB3CF677;
	Mon,  4 May 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="FxZRCPzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CC313550
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897604; cv=none; b=p+Si/Mhacv6PdX9dcYUZw9l92c2r5ztbOY4JviAH1pVhffYt3Ardzru2HzJlseTArvtiVuxsBTBdrlpBB4sHIaAEq/NxBoFASLPMuJDNEIhbOx23Z6u0v+/oryreqFNGHZyPqarN+4Ystpv/ufQpBW1mHQQgfsWJ3rhhxJ4xS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897604; c=relaxed/simple;
	bh=GuKduAnAifjM+KgXSrO9TSTQq1fQjT1dMuJSNnmK2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtLDdSHgArITnr84YQ33WN+mQAki15PT+RGpUzuMRC7HmYSva5vLEEn64326rEzoJ1igX3H1kAALcFMIVlopNnyblgoDxOQt5CAtaoC+ZlTkNB1KNbstLemz2YhfMHCRyofRdsBImKiq9OPAe+JEJmVBYsX/CpSgjZ1IhzW26do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=FxZRCPzF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so36259285e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777897599; x=1778502399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djsbXCX96LzcDVFKY3N8T8f6fULjj9Xl7NUY8EOdjGw=;
        b=FxZRCPzFYRv2+F+2okSUuhTlDvhfok8708y2yAhiSK/6qikCv2BPPK2beb7Du2qKfm
         0Qri/7wtazK0S6qU4WpOGBqsSgG0nmkcTf8piFxbopGdzFSXuNC4N/n6VCttw8MWA2t2
         5oJ7vY9EtKgehzdQRnhHWFwoa0pEDqxgPyMTbWydWhe4d5Va587TWR6kkZQsy5zsZKv1
         3rnmsfMf69aqP0m+4z6h9NwQ5RoOBg0++bxncSL3SmdPrkpk1zkVk1bREXtm8+jYHev1
         Aq0MZEoJFUSB304hWU4KZsRjNIa+AWbkJr/nc1Gq0XOocorpsfYyC1No5vc4P3lQfkgb
         Mxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897599; x=1778502399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djsbXCX96LzcDVFKY3N8T8f6fULjj9Xl7NUY8EOdjGw=;
        b=kRmsKR+lZRZo3G3vHCLSjLXmBjWfGaUMcUfhAYLrVHvVR3bJaNT5CJelxAqqSK8djL
         Jo6UFgP5vcflmnBU2LCgEvQoOwedlY0nk6VjOX9wR9lil3oosT6D5hM1gGIM6+xbOudc
         1YqkTlXIqyVo5YPukxNxQ9xpeEWg68HADZr/YwKZajRKEu493jc9lgknub3Lc/GxZHBZ
         PnbY6mxl2lfd3vlVHqiHzfF8iR68gNAp54a75j9r0ssFnJL/n8oL10ccrloJOKjdpfmz
         IWVM5ufMDTjOYll8Z82t+LxQzr3YwXgEK8j3f8Ee+1wEjyCVpO0OMX15AMcZVYsvVQpN
         kNtQ==
X-Gm-Message-State: AOJu0YyhXyDe+559EGnP5bjNiV97tUHY2k5/G3AIhgzhRt7XGvhqBX7T
	Q5WejMFB0e7B0sc9iOeoTXe9ITKUX5sQ5McrgrrqO4QqOsyhI2UoftrdzVn0pX/x72s=
X-Gm-Gg: AeBDievb5xg9APxoYXLMB0SmNL81ONvcq4bNb3gnaC0/fWKF7pnnN3YBZapFP+lgzCC
	f59u7KaBhaKtd/MLHCKYM5sEWfxalq8himMVVvskt9HR1t2rs1ugDVHbHBUH+oaL6XjO3M5Zpmp
	cZ3NmElqjgxhneJCTReh6rxHwGwAJcWVjSMVXUtW1FTEivOAxEzA3k69ofrRXvFp8NzZF5suCUN
	y9m6j1bAwve2wrtMXlv4RMu8s7foO7ZE6G2cWbX9q3SqKJv6TkcDqq8R/iSkDLyhqYMocHjWTdp
	Xp+pRRG4FO74I3MHvC5JXm7S3uH5XVDKj7QVx3kOuF1/B8oEuddTBXFi9rlhlGsc5wtSqd8jPf2
	XU8AXGsz7dthGvoQQ4qxEt485feomhpxVJzBhHDAkAZqCfopQQrM9SkMsWKlN3/xsaljzDli4ZR
	lAJWDP9mlJmaVwMHlsm2SjZEvCd5gdW9U6qk/gJn83YNWE9g==
X-Received: by 2002:a05:600c:c058:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a98874de2mr121990565e9.8.1777897598760;
        Mon, 04 May 2026 05:26:38 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f7csm334623445e9.12.2026.05.04.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:26:38 -0700 (PDT)
Date: Mon, 4 May 2026 14:26:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: move
 fractional-frequency-offset-ppt under pin-parent-device
Message-ID: <afiQTPaMyAApbLRk@FV6GYCPJ69>
References: <20260430173611.3312596-1-ivecera@redhat.com>
 <20260430173611.3312596-2-ivecera@redhat.com>
 <afhdCnT0ns-PgZD8@FV6GYCPJ69>
 <290673a1-fb5b-4586-b44a-e109cc1a4629@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290673a1-fb5b-4586-b44a-e109cc1a4629@redhat.com>
X-Rspamd-Queue-Id: CDBBA4BCDD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

Mon, May 04, 2026 at 11:36:19AM +0200, ivecera@redhat.com wrote:
>Hi Jiri,
>
>On 5/4/26 10:48 AM, Jiri Pirko wrote:
>> Thu, Apr 30, 2026 at 07:36:10PM +0200, ivecera@redhat.com wrote:
>> > Move the fractional-frequency-offset-ppt attribute from the top-level
>> > pin attributes into the pin-parent-device nested attribute set. This
>> > makes it consistent with phase-offset which is already per-parent and
>> > clarifies that FFO PPT represents the frequency difference between
>> > a pin and its parent DPLL device.
>> > 
>> > The top-level fractional-frequency-offset attribute (in PPM) remains
>> > unchanged for backward compatibility.
>> 
>> That is odd. The ppt one was added just for higher precision but was
>> semantically the same. Now you change it. Could you still treat both the
>> same?
>> 
>WDYM?
>
>Keep fractional-frequency-offset-ppt at the top-level and add both
>fractional-frequency-offset and fractional-frequency-offset-ppt into
>pin-parent-device nested attribute set?

Since both are the same, only different unit, it would make sense to
treat them both the same. That prevents from user confusion, hopefully.

>
>Thanks,
>Ivan
>

