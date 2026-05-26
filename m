Return-Path: <netdev+bounces-291698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JriJm+hFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA3C5D694F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BFC43006173
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10EA3DF00D;
	Tue, 26 May 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Sa3Gxj9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238338424D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802125; cv=none; b=joytlso5xDgqlGFDpMluZv4v6jMdlP//E4FoUGa80uQv5cAbmOlKrATfM6ka4ZnTHoiPmtSy0Qx0aKgMypM0BDAW2/7ZZoObf69dEznVKP7oAn6U6DRFuPYr7AQokbnm5LprsBR7+AuRgin7epE4OZB8QH2t87HcQE5oI3Pi9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802125; c=relaxed/simple;
	bh=/tryWe3YGVmPy2bnscHQmtWVBpbnu81ctvwLdXdUsQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBS3dKmAwre1PAvyrqpeeY4DQ07j9wMnzaUArhCFYQ/jIPVPmXzYVkgkjVkFyqwEOFWJ/VBet/nzwcd+wNoeSEeP4r72hX2ZAgc3Vz3Oa2FQaO6T3ESlCkQRD4lR9ZFMveuxVdxfP/EoyrCqmqXL84fU461X8u0ySsuNviDSIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Sa3Gxj9N; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-449de065cb3so10340826f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779802123; x=1780406923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tryWe3YGVmPy2bnscHQmtWVBpbnu81ctvwLdXdUsQA=;
        b=Sa3Gxj9N4zYyVCeYM7RxRX5XlzQpApirGVszxxhw4ikjqhCT1Jce0EnGeiXi+OGSc2
         DDnkZlmZe5nZYF4plWmTKCMUh6zRb2bq+zDMs7zYD0pJ93ArgHVzoG5crSVgvunYy/Em
         TOhQr+itjfud0Dq0AyFKEFGNkxt0a8GjQzop29wN6HijhwpHghzVKaQD1bHF5yE2DnoA
         /UAnQ5mcMeQI9aTYWjHwQoH1l3k4l8tkCXBFco3HF5G8UnIViZ9DtGIqr5NCk7o+Muar
         DNtZRQPmsm1BNHgV0Okym7iyRrNqemwr1Z8fX3Fl18sU708/lxrl765OH+FOzcIkefw5
         cTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802123; x=1780406923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tryWe3YGVmPy2bnscHQmtWVBpbnu81ctvwLdXdUsQA=;
        b=PrHknjy49lSaPrVjqkHxqKg2TmDawuweEToFrC43DryVxA2YbMOALAScgA4VQqAIvH
         M+Im0Nz0446LMxqucAoUGpmprm094eX9VYfoiM80xxDO+rrRHMs9YINotFGqTa7KsDdC
         vu8BiDKfUc5PW/rGKu/NyrZuimd+fyrBthMGV1smMVwT8nyQS2AhXxYZTEvOwpMncx0m
         6nGfys920fknuV+wI7WpyGlqiURq4PsaTgJ2aINOo+n5hEjnFi+CSKH3LEUNx0VLGUAQ
         A/9fVw2F+07/jXbp8NI/+FvobHPfkErj6D9J8xxxPako3bXpiiotCCC2UiqrsrfFQl3t
         Csmw==
X-Gm-Message-State: AOJu0YwrfoeYXnzmrL+HV5by65+L3+/T2oIp4f/1T2JnX49gsukS4M2u
	GU9vWLwstFSvk/gQutebzqO2Mms8UV2nD1J6Yw5MJEcbTSdra4dhcBQWWWFmyJcWM20=
X-Gm-Gg: Acq92OH0tVbi2B2vAwjHfFmx0sfoz8DI14XYsHm5mNTbDP9yD7sX//j1qoqR8Q+oArP
	XPdxFQ5hfPg0+dEXXs1rg+Q08dRp6eZlWuJAn6foF5TUkhGgMiwOYGJNVVcBxA0iKw1E3Uj10+y
	5F0TREu8CAuYLw9PEZLV9ROZqjj6zUd/z4C0j02eHDM7mrFISClHlzTEesQPQ7pBrBrWque0IRG
	5Snbq6iGkwo43oRaGN1JfRYRttBmyDVZLrYp2JWD76BGSn6vyXcjoSLhlCkXqPgSh4mG1FjAJC2
	KPnTXXiXsIwlAc5SQ59TVFe6pMQxyEf85vDinWbOIilKhx9V94p2ahOHWKgmYuMYnptaGnG7RDQ
	tVBvvfY8+V6BYHWuQBxhWJ6lWDasuPZ92hQELw2DNhL8uc++RPfHpAicQxodOS+jl9VYxuwnT/Q
	HZ8O2xiTgtIlKB6PCPdyJ8GOyrT39X5bdV+fwAPxZm/SQ=
X-Received: by 2002:a05:6000:1a85:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45eb367fb35mr31350080f8f.17.1779802122476;
        Tue, 26 May 2026 06:28:42 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm37119736f8f.22.2026.05.26.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:28:42 -0700 (PDT)
Date: Tue, 26 May 2026 15:28:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v11 net-next 1/8] dpll: add generic DPLL type
Message-ID: <ahWgAPoysfluToIf@FV6GYCPJ69>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
 <20260526093419.639220-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526093419.639220-2-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291698-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0BA3C5D694F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 11:34:12AM +0200, grzegorz.nitka@intel.com wrote:
>Add DPLL_TYPE_GENERIC to represent DPLL devices which do not fit the
>existing PPS or EEC classes.
>
>The UAPI type is intentionally generic. During netdev discussion,
>maintainers pointed out that introducing identifiers tied to a specific
>placement or single design does not scale across ASICs and vendors.
>The role of a DPLL is already inferable from the spawning driver,
>bus device, and pin topology, without encoding additional
>purpose-specific taxonomy in the type name.
>
>Using a generic type keeps the UAPI extensible and avoids premature
>naming that may become incorrect as new hardware topologies are
>exposed through the DPLL subsystem.
>
>Expose the new type through UAPI and netlink specification as "generic".
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

