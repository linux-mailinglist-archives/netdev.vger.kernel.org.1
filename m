Return-Path: <netdev+bounces-296987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eYSkDMzVJ2pr3AIAu9opvQ
	(envelope-from <netdev+bounces-296987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AC365E073
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=dUGBYemy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296987-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296987-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4F323126E87
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238333F0AB7;
	Tue,  9 Jun 2026 08:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A23F20ED
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:51:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995094; cv=none; b=QPxWkuIKXCYs1lgiLSmppR6tV+e4nNM2GFxhEW0vCrWVmgn852VmW6dc4l+YgbwNtsxCJlee8KvqTb6ERFNrFfr3I1pFWTZj/qNA4hxtZm7OilOqeQcNRNUrql10vuPFA71D2bLkPR9+5rJZt6DWth3+jYOuxTTZKlrloE6Am3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995094; c=relaxed/simple;
	bh=HshGsHVWsL9nPVEdLHbLiu1Ynue3C+BZiCe7vQL6KeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4sLLf3rhgmae50uuN3vuOWPNNvuTtYUCwNM0RS1JdX+N9Pf8cdsehkk+DOr7IvIxMludbTj6N1rLffdJgB2+iA4FuHtlhhRHzwdo/dKzuHDDiCiEvH1NSwutzFrE/OAmvEqhk6RrIdoDGOubJ7WjcXSvLyA2WMGn6RpOd9lh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=dUGBYemy; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef5146b56so3970324f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780995089; x=1781599889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr+31Sfm09aNOC25qiVPZ3TlgSQqWOQ0BRBHz/7MOnI=;
        b=dUGBYemyOD8pDXQtxhaHgKuUNYalctE7T43N4z5EAukJkMI1NYAiAHQ4WRvNtvil5p
         qWojNixUJ6fS5FOQNqIARsyefVMofDyJKN1aDJArT41hMNliSrq+9oCsl4D1Zi3+QEz+
         k/vGaJ7MWdRpmEpMUBvrjsDsvLoMxjbwNDzbzfyudpJ/yFPgsWJNTEeQHrfM42NNjjVg
         ssstODAzLS3fwnu4R9kFh8wqnneVkJg+bv407Opp8dMZhyNSSlcrerzw4qsWMC5Mf+Yu
         OMTuCDU8WuUU5BeijiZE34ZqetnDeM8JfYIdcaiUcY6UbnPT5v6F0rbbbrfDB9kq1poH
         hk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995089; x=1781599889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr+31Sfm09aNOC25qiVPZ3TlgSQqWOQ0BRBHz/7MOnI=;
        b=ksqkXP6zMa1ncq0ou3e/gicqyhYKXan/C5q7S1E9iGWiTl/TSM3KK2Up6mOZ43dvWy
         MZhD/msAfjXxqkZDLbDR5Lo67R7qREvbuBaE7ziX9AFd8eFVY7p6z8BP6l936HOktwlt
         HknbHhEdQWIkOD+hl8MsGNo+sSNPXQifujrdyunLEEP+prUGsXYLTFUsIFQ9AniHfhfu
         fPDkLk8Gs5H6YozyYITCUC5tT/qem+1Y4jkxyhij2ztaePxbxhuz2YyqizW2OVzJtK4T
         9zYDMtG0losaooG7aOHaIyjBgMUILbjdRscU15/lBWITCLTrbAse8yIEcWLwqCU2DDPj
         Z5UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uzZcq/RxgEEi+wWza32MnsnLXTikwaVkQQsBHvMzNaVwNEglulkXB3pXcSvujwRKQ2XXtMyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY40ByY42eK8wu+mlF4nNdqv5UZW+UCjHtdWd0V2/b68bvUMIj
	HiqaSHzJS2LznwYwF6eUHCKP8nVqwVkCuQMMA05+KRuW3+lV1n4fGpi+ftxRrDp0jI0=
X-Gm-Gg: Acq92OEdmgCoPYE4A/u/KcNW33sO6pUO3TkEa7+/tS+z9X0vfMxAZkIICy+Z0TAMBGp
	icHKlxhliDlbkqJsrfuTt9wsMMO+dH+f94ZacL10BnGpoYkvysMPrvaIzXLx4Pb+4jFEfky3adX
	4rYsx6XIGy1b/KZnlNbycGlKaMaOjh7AWj7QF5bAI+W0+oV/rKGDrGgnU09emTCbniqbrUAmtyb
	xC4K8atK/VwfN7guG7u8OZBf/YZmuxfAL+lCWw5f7atbpf2jXlegqD04eJU0XW0JgZIgGwLYQtp
	7S4eGVigD70epF+QVvc6bMkmtY8USbt9WR7Ax40cVG8ihIhCFKTTLZjL0F+ufAaEUxwmOTx7ztg
	MI+GzLdTpgbMG6q5Rlh+5sZAbWC0A2Lj3CTgpp8Rw1ZEYaJD3Jl3WvhAQs8EdhA7sb0J53JIqQz
	mpmY9IctRqwPsRbbzBYvbB5CM5NfTFNlxphbUQXxnnGpaLIXL37IZuLg==
X-Received: by 2002:a05:6000:220f:b0:45e:8526:7dcb with SMTP id ffacd0b85a97d-46032b7355amr27267912f8f.7.1780995088811;
        Tue, 09 Jun 2026 01:51:28 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm59031002f8f.26.2026.06.09.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:51:28 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:51:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Vecera, Ivan" <ivecera@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Schmidt, Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Vaananen, Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Message-ID: <aifTFMZtWBgLzhCS@FV6GYCPJ69>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-296987-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,microchip.com,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95AC365E073

Mon, Jun 08, 2026 at 07:03:46PM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Ivan Vecera <ivecera@redhat.com>
>>Sent: Monday, June 8, 2026 5:48 PM
>>
>>On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>> Sent: Sunday, May 31, 2026 9:44 PM
>>>> ...
>>>>        -
>>>>          name: gnss
>>>>          doc: GNSS recovered clock
>>>> +      -
>>>> +        name: int-nco
>>>> +        doc: |
>>>> +          Device internal numerically controlled oscillator.
>>>> +          When connected as a DPLL input, the DPLL enters NCO mode
>>>> +          where the output frequency is adjusted by the host via
>>>> +          the PTP clock interface.
>>>
>>> Hi Ivan!
>>>
>>> How would you control this in case of automatic mode dpll?
>>> Automatic mode DPLL shall be controlled on HW level, such pin brakes
>>> that rule and requires some driver magic to show it is higher
>>> priority then the rest of the pins?
>>
>>The NCO pin can be connected only in manual mode. In other words a DPLL
>>in automatic mode cannot select NCO pin (switch to NCO mode) by its own.
>>
>
>Being picky on DPLL_MODE for enabling feature is not something we can
>allow if it is not related to HW limitation, is it?
>Could you please elaborate why it is not possible for AUTOMATIC mode?

In automatic mode, the pin selection logic is defined upon prio. I can
imagine that if NCO pin has the highest prio of the available ones,
it gets picked. I would be aligned 100% with automatic mode behaviour.
Is there a real usecase for it?

[..]

