Return-Path: <netdev+bounces-275972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBzYN+bw1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5CD3ADFF9
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 389A430157DB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100A3B27C2;
	Tue,  7 Apr 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="sBOtbuUj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBD3B19B4
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562970; cv=none; b=HRBmsqFb1UJ8q4/DJheMpwDMW+34tPXplQrkB3HhodrlQkIUTErU+hfRo80sIl3E4cJE6gieLkok7oYK2Y9I2dWysQU26tlbhzKdcpTJlgLaxW1PMbRVlzCBx4lZwQ+uRTgjUiX25+2N6ePA0Ig1f/nfq1pEIkm2IRLb9dCVLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562970; c=relaxed/simple;
	bh=N8PlXAHLvJX6pJA75yhg5YbpIL02FJksrtVF9Cvs1uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXvD1aJPmLGUOhzjDf7YKn7rkkaj7t4pvGEBaFyz1pT1fj8g89MuaEk7dOheIf4bHg6nOeyrDiI+dn5Gb7BPQzn+P1L3gz/dMlbGelKO1vbXEHxPAq8mK/mb5s0FNLoFUvmhY+9NQeNHmjEb0RKksG3CQQ+eSIlK8VBgn0+mwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=sBOtbuUj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so31464935e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775562968; x=1776167768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8PlXAHLvJX6pJA75yhg5YbpIL02FJksrtVF9Cvs1uQ=;
        b=sBOtbuUjCRaeKtoTv2pevN+EHifKRaDzgdV9wCkcOvlQ6mameFS1KSLve2PA9JokNr
         BX2EZYoqWrNDbmResLiYBGpoOyEpEIM+ti3ujEGlJGPF90C4QhrhghOZHGrowG5kneEw
         lpMchClpyrFeB7xCSnl04qGkV9UTnUDB7t/IHcVJqov/9uiG1XozbQ72toDTV8SA13Ob
         skKFA4N8TTGgVf/bgAS8Ud0yGoRnE5R50KRgmnDRCDw3i9RRlv1nA8w//wLWTh7QZqDP
         GkUqWDrNKA+OMFmtt8f+g7wOuaxTrDHuOzmL/Uyh9/hh6ioHT73+LDoRnLkOTHQ/fHjI
         bYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562968; x=1776167768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8PlXAHLvJX6pJA75yhg5YbpIL02FJksrtVF9Cvs1uQ=;
        b=sFIP6JucWyBruBVejhx+cNy81waRJAd/Urixg8Gv+cj5E9Krwf6n24fESL+xVRSw1i
         SoxSmr09sc9PMOCuX5bXTOlSU5o8vvNsTvN0KUxyd+qa3GBZ/m8N0yGXyGO0KOp/0nNG
         SvJ+PJ4LHRFiJtukmkMYOxhcEogV1lzXZ/wlvYgnvD4paI5MsrYHvb4+O/yBA/xYsgZS
         3q+jyaMNk2tI/9EKfiTL2OQOBwvxLx2haM8Nxx6LC2G5N1VGsfKJ5bCJT4aaaKLZSKok
         mlnSSQxOkzwhlrC5LfB8b+EmaD5j62UNRuPaPsiUJqwng8UTpZ0LaoOICGJ0d0H5e89o
         +ncw==
X-Forwarded-Encrypted: i=1; AJvYcCU9BfWY0WCrokMlsuOGkRN6NFmJgEXaKzKlareKqsJZNLanTy7Tnqp5tYXGSpEq3ST4vnuPY2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6kRX7wBVS4lWuIO/dqW5yPbGbDrhxrYM8MYPIl3Jz3/55HDUj
	+A4GsO6BKd4vnON9USNgxq7ZaEFN87+ZAdzUPnhyUC3u+e4ptBn1hIqD871O2uAy5mQ=
X-Gm-Gg: AeBDiet8CPpDw6wvIWxsxDtPv8A81gcLb4q2w3Zb7wrPxRdQHfju7wBY6fTy80b8upG
	uGqNB5E9eMBnOD6qhJU+NkK8U0h8VPtQD9goibpW77m3+QSI8qyI0DRA4hLA6iABIB2Zl8Yvx0o
	NvwEkoftakTWjwcZgbklEl3v4VJ208ADqCZKixHYmbWCZHRh9PQKeTRPzmYfI8wWKB6VUhwCBai
	WPZmv+7RKEJFsrLRiPGA9SFCt0yhZ8bffhgfrzp/LcvjGkhu9lulRl7H1z0SXCwGF63I4U3NgXj
	0E0es0vN+8nyV+/EU8jz0LTkMWDnKbaxhD6Xkpp/oX0Q4ffkn1iUlP87N1XZ5D0zXpChxPTdAIU
	KtIISL1/RNXEEvQKsABwTTvZmn52fiW5iS1l+j324HMVxFwRTz0k/YXnLkwyBQskDMn3xmwVpdB
	TktPLpJP7OeQ13PXHzbrnKPhGqXm1KaCf6k8VV/oVjPA==
X-Received: by 2002:a05:6000:114e:b0:43d:30b4:1859 with SMTP id ffacd0b85a97d-43d30b418f8mr13397000f8f.7.1775562967514;
        Tue, 07 Apr 2026 04:56:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm44498145f8f.28.2026.04.07.04.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:56:07 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:56:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/10] net: team: Annotate reads and writes
 for mixed lock accessed values
Message-ID: <sytzifkabn4o5jhpmamswj5ujpusatp2kc6xnrwdu2uqpsx2ti@fq52ndia6eby>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406-teaming-driver-internal-v5-1-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-1-e8a3f348a1c5@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-275972-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B5CD3ADFF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:37AM +0200, marcharvey@google.com wrote:
>The team_port's "index" and the team's "en_port_count" are read in
>the hot transmit path, but are only written to when holding the rtnl
>lock.
>
>Use READ_ONCE() for all lockless reads of these values, and use
>WRITE_ONCE() for all writes.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>
>---
>Changes in v5:
>- None
>
>Changes in v4:
>- None
>
>Changes in v3:
>- None
>
>Changes in v2:
>- None

Nit: I don't think you need to add such record when there is no change.


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

