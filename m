Return-Path: <netdev+bounces-282309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHSFG4vH8WnnkQEAu9opvQ
	(envelope-from <netdev+bounces-282309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:55:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C038949165E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C9E7300D710
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849983B0ADD;
	Wed, 29 Apr 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="lpLF3T7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E339DBCC
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452936; cv=none; b=lx7H/i9CO2ZUVth1zinBblw2SHdfqMkmGd/QXsMCgX0RC/TGGvk0ufsAkoM7dOqFmbMpT7CS2weOV/YAItQoLMwV2CPtaWX2NGdXMkD4sV7PZHEotlP/w+PohqQ0t2CMsGcHaJTt9e0GbvCPP7cMcQmOJ+GpSQq6WXdpi4CC1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452936; c=relaxed/simple;
	bh=zloadYk+FRxuCKY1pGkNPmHK8KQ4PABu8yyLAufBvZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N91jwDYhTXwv/9jYGe3ZT2/8tX7Vy3uhkuJzPeMCGUHZ+cXU9KD4EQocXxDdkrni3uU1mguiT01sHa4plJzz/bTcRsHB65dt5YIXptc+IkzU+T4/7oy9H/OVYhPSHesnH75FCpUKBxZnEoaKauDZ88ydtczQFOg3+IAnqkgJOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=lpLF3T7i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd832155so9006090f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777452931; x=1778057731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt4otsNZP+qM1RAgOCDcWAVXVHOwNcuga4GcWRLPXg4=;
        b=lpLF3T7i9Y/ZHbWCAqHJ+CGOhS9l6q/j5ghgUJQbOHiwie31KWrOUMLpFxkqPE1xUv
         97tZ0lndsgCxAflKz+tsV4PYoEG1a/Ru0g48wScK2vAgvghUzHgyWmR9wHbpYRgXne4W
         XKw6GyNFQRJUn7AZvMHJQmnUg7lW7YIN1F54YKMOWyV9HfinnwvkWyeiLYntrFEdcYR2
         atIrgFuumMTxRSxBcaN42QkiOE8SJidAwBJCWSrwJzpofAAYxEDUG4kKhmP9x2BgML97
         7ncCjHEBOGbfYsuagML107m0gAXY1Ge5OlCRBOqVlxy7RWWxTUvKBwiDqUjqiTCptuXs
         10Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777452931; x=1778057731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt4otsNZP+qM1RAgOCDcWAVXVHOwNcuga4GcWRLPXg4=;
        b=IGmEiKK5N8DzguqdOxld89Jz0uGgnBk7yAr1MeD7x3+57BsRxrx+F4Dt2SxXfwgV76
         8Xvzh6cIiji2K+FB8PzO65zR2inHAGrpOU1HO0jvG3I6J76xSmzu7mzLnj0YMg2VRHiX
         Mjb/C6vP/Ru8r25E7xw1WftOEDV111dRLVpDJiV1Pz7nUZa7MSw2/OrxSSeWmddfOGgw
         AbqjyNgPfqANipPpyR45SwOgC+q5D2jsSrKUDJL5k1kn8MWI/0ISlew+89hIoTxG0Wmc
         V8pJImN7CEAcvOooaq7JuPqHyXada79iCi2LT9J2DaBMUEBGgGWeH8pj/a0tkx7Qr/mr
         9uFg==
X-Gm-Message-State: AOJu0YxMN1Es9uXHtcxgSMUIXzbdCOyNXaRP94T37TrDzUTur0EoG3NC
	EIO82rKnrtCfZVCZYF1fumEIETbSzJOynmi/lnwGrfuq75WZN/s0cPePrfD0rTaE+PE=
X-Gm-Gg: AeBDieuH1JcArcGyAv1+XSKDrQd99enhNPi+NPIXM9fiOBrnwNfP1XPXMm041sG94gt
	2HVVcsHNLmpAdzRCy4OUWaXTdrjZwcjRejEoYLVlKuLsY8hvvwQ3L5JkJVlFqIkeUQNeeDUI1d1
	hz9inqqwAyE1KTVv9O0TmPIoi37pdmZW6OEqydKUk8ZJix6GCvf/nK74h4h88T37I8Lt1FkERiW
	54Ot/9S7GKdZYT2IJ8p3/+WU+WQ8ABpp09a4OqtjCgzROLl00M3KmDQf6oG17wlen7Z6WbV/c2Z
	RxkF2XiL83fvOyOGS9gA0MGQRAROU9fQSGj5Jhtyh8pHw5aLIOEg9YYboSHvam66xhlj7uCxcis
	oDU46CclZooUnesCRo09H4r5b290REB7vrOPGghvkl0EgFh2UaMIOyccIsSK3zZWKUjZBWM8lkJ
	wm8qz/7Xdo0UOWI7d0U2sczrAxtxBrkmgJbW/0jD5OTA==
X-Received: by 2002:a5d:5d11:0:b0:43e:b0f7:9ce9 with SMTP id ffacd0b85a97d-44647dd17c1mr11721926f8f.14.1777452931178;
        Wed, 29 Apr 2026 01:55:31 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7218622sm4257094f8f.21.2026.04.29.01.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 01:55:30 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:55:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpll: add pin operational state
Message-ID: <afHHb6UmK73yRXs-@FV6GYCPJ69>
References: <20260428154907.2820654-1-ivecera@redhat.com>
 <20260428154907.2820654-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428154907.2820654-2-ivecera@redhat.com>
X-Rspamd-Queue-Id: C038949165E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282309-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]

Tue, Apr 28, 2026 at 05:49:06PM +0200, ivecera@redhat.com wrote:
>Add pin-operstate enum and operstate_on_dpll_get callback to report
>the actual hardware status of a pin with respect to its parent DPLL
>device. Unlike pin-state (which reflects administrative intent set
>by the user), operstate reflects what the hardware is actually doing.
>
>Defined operational states:
>  - active: pin is qualified and actively used by the DPLL
>  - standby: pin is qualified but not actively used by the DPLL
>  - no-signal: pin does not have a valid signal
>  - qual-failed: pin signal failed qualification
>
>The operstate is reported inside the pin-parent-device nested
>attribute alongside the existing state and phase-offset attributes.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Looks great.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

