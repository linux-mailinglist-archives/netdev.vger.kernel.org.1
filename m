Return-Path: <netdev+bounces-291697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPxJHeGfFWr9WgcAu9opvQ
	(envelope-from <netdev+bounces-291697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:28:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F24295D677B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4BDB30117B9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A463ECBF9;
	Tue, 26 May 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="HBaRLyxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A63DD86E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802077; cv=none; b=JTSt0kPCffUE9kw49M//OqZhVR/oj+6GxmiHDspt9/9VXsE3/31rwj0f9wj4DS2Vvie07jBTlssv6IwRgejadMIc8PLec0JEg63y5dRf5iA/EXqNmK+BatDhqU/63BawRo5CM12Wr1p/ItSsAi/SViMcE2WHhZ6v/zvkHdTggHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802077; c=relaxed/simple;
	bh=AF9tJ1amhlOtaGqlNAAzlZV5h8kKDyKt4veK2cMLXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STfTFQqD922Rl21M4nFi8zF+B8q9PWYUHQyf6OEM0wlxW6tl5Ff1/MtTqcdiqaLHIJZN2C0hYq25X781kZP+Pa8ytMri6fGl96FYHWVCXTtGPgbn+ne4aiOlcZNPmWr3g7GAEPLTRDCQGjwg6ssyfy6/RSUz8DtP3/fOYEINQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=HBaRLyxj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so56144595e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779802074; x=1780406874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AF9tJ1amhlOtaGqlNAAzlZV5h8kKDyKt4veK2cMLXSI=;
        b=HBaRLyxjsk7oX4LbiLb9W999vqrijrauxMeckZV0VurpePTiRVimPMI07awDRiEsRC
         0XctatJoPWKkufRNLwIfApuji12tyL5KUL4xzCooR5JHAxzxMlSvAdGYipjN1n360Clm
         fQ6FiucmsJvMepzIivy6ZXYsE4DSMa3kR+6FEE8hlSMs3/J52Uaq6f2tZxpZCtceczka
         vbo0aooDPZ2+adfF1CpmfKy+38ns5Aj9DRHZFkNh288y+b4sewpCIHI1A/FRKmAc/VVP
         Bu+Xm5PKnRXaqoSRsWCB2QSmneLMKwBWPfX0J0GfGu03KeL/sQNF0ACs5C/TQ7g4t8kG
         H8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802074; x=1780406874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF9tJ1amhlOtaGqlNAAzlZV5h8kKDyKt4veK2cMLXSI=;
        b=DJhehzMAo5sROvBk9WjC1k2ydj7M+oq4jW1ZH1ua4VZywJ41u8bZ6r5tg5p6FGZmRr
         PNf9wnD2vThCQCpKtMcaolv0kBZr7VsNWAPGaoopscwAzOQR01V/Ma6UiB/ohPm7EDp3
         yUc1jxTMGZcJIzno3emDJoMUZvSkkhf4aSdA56xlUwombpk/ivqEB2Yg9U0gSrLP5XXI
         914Nxyq+wZNv28IsPW5Ueg9K+kAFVvk6xunQ4PharzyyjPb7NkCR/afAoCKW7fr/mMuA
         hjKPnTvMMWjZrd1XE544PzqVt4E/ggJ9YLui5e/cW9pdN1M8dqNA5SPv03JwpyK/iKnN
         VS6g==
X-Gm-Message-State: AOJu0Yz9AZcD/OdiDEAf7NML1rprjxdKnca0gmykxzsOFBE07ua0fTiy
	zvAc7J8L9YW1QkrU8lzUiah1DCGvWFamPAy+aEz+DFbbihPavFALo9WFErtPYQuruIY=
X-Gm-Gg: Acq92OE9DHeCX1gutSxYjtg4OdgSlgZ/CMwLgAcnr44J34d64kVk48p9tiYeFfd+lLT
	yNNEZGoLYsvc6BNVitor5g1638z3VG6q+2cRtrFAAz4RC13jBAKpEbixvBpYGbDQP5W+PUJCbgF
	r9NPDH5MF8xk4iuLfhDCIMjeQI03herlKBr0Eq1tzYv2rj+epMohbLvDb/ea2B+2nbvZs9Hs6aP
	sBgYeX0ssjxuyImG/ztzbii+7toHZyeW0e3kMMXc4REnrDEyT8k38V91fCLiNOrdJU2Ka/enhxM
	f6atwO3HBqx75Wr9td/FSBlD6/0wnfQgvuakib0CbGmAlrpY4C+D8o4ghvdbrBgs0vR49macuf2
	IskPOsJWH01S240PmMODKBqOA/ulC9YvK2tl93wL1OXcSyUUkf2RzIcP2F+E/fsAaw8Ub2fY2Qb
	jsHYySH+CF5BMzHm8/3Omu+NR9FGjbYqz19A4Rr2J2Bv0=
X-Received: by 2002:a05:600d:4448:20b0:48f:d620:c27f with SMTP id 5b1f17b1804b1-490422687c3mr189986545e9.4.1779802073553;
        Tue, 26 May 2026 06:27:53 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045284855sm330056955e9.0.2026.05.26.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:27:53 -0700 (PDT)
Date: Tue, 26 May 2026 15:27:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v11 net-next 4/8] dpll: allow fwnode pins to attempt
 state change without capability bit
Message-ID: <ahWf0HAr3sRfXw0Q@FV6GYCPJ69>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
 <20260526093419.639220-5-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526093419.639220-5-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291697-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:server fail,nvidia.com:server fail,sto.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F24295D677B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 11:34:15AM +0200, grzegorz.nitka@intel.com wrote:
>Pins registered with an fwnode may have .state_on_dpll_set implemented
>without advertising DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE upfront.
>Requiring the bit for fwnode pins ties firmware description to driver
>implementation details unnecessarily.
>
>Relax the capability check in dpll_pin_state_set() and
>dpll_pin_on_pin_state_set(): when a pin has an associated fwnode, bypass
>the capability gate and let the ops layer decide, returning -EOPNOTSUPP
>if .state_on_dpll_set is absent. Non-fwnode pins retain the original
>strict behavior.
>
>This is used later in the series by the SyncE_Ref output pin, which
>relies on the fwnode path for state control.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

