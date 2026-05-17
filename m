Return-Path: <netdev+bounces-288698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG1zBih6CWprbwQAu9opvQ
	(envelope-from <netdev+bounces-288698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:19:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A289855FEFA
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EA6330054E7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E32750FB;
	Sun, 17 May 2026 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="mYsmm/8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26F625
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005988; cv=none; b=LuiJc/mJhm5UMRoEx7vr0J0JtDJJVslhMYNA4T3a4ZWUG/ZXkTo9HyzaWzuYJ8E/RfJ40zyB0hhUf2q/lc9AhWcUwGl5ksEyu4mxy+xwvEssFhNmFMNnMn3hKG56UUm5SCPRL+AjxTABQvoxMxGaP03OHFjS6eHXxBUdLRRl0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005988; c=relaxed/simple;
	bh=N6fWHb5p4zbzpCZQr8P3lN6oCjeNwsq8Y9bOXKi6He0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNLBd17Fm+KeRJO+1P9diR/Ksiju30EJrhZ30F3Y0aVWah4WRiTBEHD95NMmXkaaKjZVKvuUcQ/wwWxqKdIzHdmBDdnmVSzpMFVd+lu0QeCrzcXnf+OpYoLY7wDVjYXR+p8VYeelJC/dhXrUdxMRI0Kf0kj37zoCp/l5STyqS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=mYsmm/8s; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso7761125e9.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779005983; x=1779610783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lI0Ih1lcIED5pPJyT9mHyteKDm9V9TUdfoTG0MsY6E=;
        b=mYsmm/8sKTm5ZArj37TNCDtkIBBFulKo+SF9QZ3oG+gJCLTJRb1qNGheahMGtUixQB
         fbN2wByLtcV8YukRy8+eDcN3KZkUoQqlNo68nht6tDaVLp+czfqRx24Dq7Vu79P5FwL1
         dHNwVnCWjyjOfOOMe7v0scw4TbK7zdmNCpfN6GncGu6qPh9cNcTd+10qBCnjxsim61Es
         R2Fi9W6TQZfuKsg9Tl+ejpnzDJoh+u9A+LCAqQLYDN7C8AO4jMcxWtoo3SqNvNXQwgX5
         zlKXONLDsdGGVd66ABc7Dpwol7YyGyFV/KCOEPIB2YDrEPv1u6N94aG7KQatMHVbvKfJ
         yzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779005983; x=1779610783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lI0Ih1lcIED5pPJyT9mHyteKDm9V9TUdfoTG0MsY6E=;
        b=XyjyUtrLXgPIARYXih1PT5L8DPcO3vQN6opGvhpDUzrwHBvobM6W/yrXF4zpqOuYyd
         J8ywy+ynlYwkBRPFYtL1RLFl90BFGml34bghzIAA2J+XaVDgt8/hABEaDj0LpVvVOqf2
         yTAHWj+uwCURMUT+HYv61wZ7xGqqhxVH7ddlRs6wm7RUOHIiHdg8pdBJfR88a8b5OVYD
         Nyq/dPFbG+K10/WkPxKvz9XmQ5+ITpfuRt0SpZzeqMMYe2QqWsYLKxAC/bIrBo0bXwjA
         5lUt9Ju3V1TZckPTElgMOTsHNb1Qe553gC0HcutTKIEmvEq4wqjCJwtmwU7Ecdez0B1r
         3kSw==
X-Gm-Message-State: AOJu0YyCHECmdfZQMYz+jZRJJTpzhvmHtg2SetDKU9Zwx+C/h7blij4h
	DKOWLlzWXBfqSuWrn+CenT+Y2ddOmXo6+b9dV/Ml4arVLDBYkE60CA8ZIerpwppaAEw=
X-Gm-Gg: Acq92OGwMoAecKMJV16O5AIus5Tq+ALMwNbcKln2ecgICgmSMMTo7FLQv0r6LEmBDPT
	40jUp5QgAG4junMFtByjQML/zJJDjLzY5xuFESIUA/0sTCJvXwVKa1SXcu1PA2M2Xvjlm6mFPFN
	FBH274rEKmo7//eElU/YSrhokSeMaH9ZFvBqV8Rlj+ysHGaWoAVKKsLLg84E2deSCXgNmMFY+5X
	MxiU/m2k5hiq5EbJ42OUEEeNEjJzo8RYzyc85ccUofeoqqiv7dp5/8V8h17l/OY4ZB8jBDBkhQH
	iflPZI9XBoqyv6fKDkVfd5uShJKPLnRB9sC7/MIDr5MRyi+g8XLlE+y3yKUnu7XrTbiwbuANUH6
	7VNbQwsFNDR1P0jN1o5pxhGQkCS4BFaIS3/JRcsDZsF0NukkRqMQvMMj0r4lALwCJBZSC6EcoDa
	9I7pZZhoTo4CXeSO7iDkgKo9Wj9I7WW3Thk6ibSoi1Qv0=
X-Received: by 2002:a05:600c:34cc:b0:48f:d1c0:5cd3 with SMTP id 5b1f17b1804b1-48fe60d868cmr160709295e9.13.1779005982649;
        Sun, 17 May 2026 01:19:42 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:7168:3127:200b:5d86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm57663675e9.4.2026.05.17.01.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:19:41 -0700 (PDT)
Date: Sun, 17 May 2026 10:19:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>, 
	Petr Oros <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Simon Horman <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Message-ID: <agl6B8gojgnsjVhr@FV6GYCPJ69>
References: <20260516175744.26749-1-ivecera@redhat.com>
 <20260516175744.26749-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516175744.26749-2-ivecera@redhat.com>
X-Rspamd-Queue-Id: A289855FEFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288698-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,kernel.org,redhat.com,microchip.com,linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Action: no action

Sat, May 16, 2026 at 07:57:43PM +0200, ivecera@redhat.com wrote:
>Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
>the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
>enters NCO mode where the output frequency is adjusted by the host
>via the PTP clock interface.
>
>Update the fractional-frequency-offset and fractional-frequency-
>offset-ppt attribute documentation to note that for INT_NCO pins
>these attributes represent the DPLL's current output frequency
>offset from its nominal frequency.
>
>---
>v2:
>  - Clarify int-nco pin type documentation to describe frequency
>    control via the PTP clock interface instead of generic "controlled
>    by the host".
>  - Tighten FFO attribute documentation for INT_NCO pins to describe
>    the DPLL's output frequency offset from nominal frequency.
>  - Mention both fractional-frequency-offset (PPM) and
>    fractional-frequency-offset-ppt attributes in the commit message.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Like it!

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

