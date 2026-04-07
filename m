Return-Path: <netdev+bounces-275977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNz8Fbrx1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B423AE0E3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06883306E805
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1D3B2FEB;
	Tue,  7 Apr 2026 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="WWD0ZBkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400B3B3887
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563025; cv=none; b=IhZPyz+OO5DA4ACzIRdZsugVww7q0sEDw0JX+/F4dyeIU+4MEA5nsvRbtRkw5fI6v8/aV8Mz7cPo5F56NFuzQDft9X6QP5auUkEt5KTz4/nyaic4GIAyxACUGH9noGOoLvsDwmjkFrSN7UVy2YbqrmQG4YEOAUsz0fyP0DblQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563025; c=relaxed/simple;
	bh=xW1oQelSJEebLZHmbEvIR9VXRTnFxofuUfen+XobBRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqUuGkOR5gc3bJiojV5wgOwXEVdu507qGgE5xBnqtDhJLz9LW2kwSpyYX+1qPirO3oDkwq7qZ/O6n9R2a38tcBrvbX/RqBUbJFZNQ7nOMrsxJdoKVrm7LEhcZeM/ejPUPj8k/+KVKfqINw00atmUSOA+bqTg7kh3Z7S6zepUhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=WWD0ZBkV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f454be5bso62102555e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775563022; x=1776167822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xW1oQelSJEebLZHmbEvIR9VXRTnFxofuUfen+XobBRU=;
        b=WWD0ZBkVadGAYZjOaNHkGOE1H9Ad53aeOWrJZ+nvnriOgDqYyLGFktbnH2c431ayk7
         73N3Mfpd+qPOolHsTXptEVmk/at2zask83YhIvCDh+L4LEzewNWIAj2EHMhEU8n6CfIU
         z6lmyeB6HH2qeq2NGspuBRYafPjj3x0Xn6Ann9v1ETFVreFYLjyqBjx5HVLdh1H1IBYz
         1WTiyNLJRqoY/B31beEKzaisZJjGv09IpxanIW3X5KaK5mLhrr0HwYkVg+BaFKMeGicE
         fQ1Hyll+2xzpmzRcRiLJMUKGvM6ypdNY/uSXglEE75cHchAJu+77EFVVE8eq/h74iPI8
         0+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563022; x=1776167822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW1oQelSJEebLZHmbEvIR9VXRTnFxofuUfen+XobBRU=;
        b=FSXAcwx3/PBhBY/ZTpEwkJOGBuBx1V8/sZlqgr2NmcHZMSm/328ZrnfxtIfLhFH0Nc
         9Jt9K9xudwzunHIj28tfxoYqKDgADe1NYMRJXEPAZnpxkxyWt+DmQbTLK8hPuKQ5m2L6
         XKpWpkbjV4I1mRV+Fv77ezJuXJOBLvO+JLpTatVB9fDDyLWdSY4n2IPzh1vG61CbEDaz
         SNsBUlJ+Hei2qOOWTY4VfpJRdtqLUJle9eNAwEAfRSeoxBGmYj48H7/SvVixXlHkULMH
         4HnsaHgTegxugjDbGVU+Y1s/xqlyQvBbBJhlyi4+qi00fRhJ9hQXcOMrZXdplTtIbkhe
         u7vA==
X-Forwarded-Encrypted: i=1; AJvYcCUgWQzkOcSZA7Ahws9hOavK6NyxKNSeZO/Vpup74D6LCrsWasMScpF6xbQ5mh+oGoyYK73rzzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJhkNB1s69FFgtWih2Y4BWz/ARlrBTwkvHRp49gMWoZVAw8y3
	46t+6koFiMbIai39aLuxZs7PAQg3XYs0r6AI40dt8ZIXoZhl3YpHgRFvYJeU4ZfWJz8=
X-Gm-Gg: AeBDiet6yRzTcaLTGs00CoxOjpKv/5DM6/Vm58Agt6rbqLeNPpCdRp89g0DVDLnrXKQ
	AVvo/y1RRy9kSILWG68lLMKEmQu5dqIxlooroxQc9xLgjJ1f1eEpqnqVULqPIVL5bXRmVjmK8x5
	+EoE95uXXb7ia6uJO/AFM9L3YQD6kAjvVLxnL/6gmneXZqwPgWnLFc1QvNIJgY5rqVzq8m121Il
	J59b3hQf+N4DSuF+j3s05oiywzdPLm/79uVhAQfTYG7trkEhOxmR+WVQ33sBdJDKdmXcjPV8Njp
	BIo6ILMm8XiwkaRwV0EROEYYReS3NcliasVGBki2V939hnFh1KR7HNUUrP+MlgDxZ0/PyvDA8dh
	km38umYm0YIFKOAx2HKWSdfaA0DwKn4OzrBhphRT8JxIC3+MDt0BDqlZiWC4lG7DA+tZtpjheej
	pDJYGl2Ioei20ScFh0kko79D/1n+9faNFOh0HCbWTwrg==
X-Received: by 2002:a05:600c:c16f:b0:488:c239:d498 with SMTP id 5b1f17b1804b1-488c239d786mr9174875e9.8.1775563022032;
        Tue, 07 Apr 2026 04:57:02 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm352553545e9.8.2026.04.07.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:57:01 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:57:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/10] net: team: Add new rx_enabled team
 port option
Message-ID: <fbco4oaoyqr26y4e3dmdl63bosxm7nquurclagu24mwi3yc2e5@honrlddrowpa>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406-teaming-driver-internal-v5-8-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-8-e8a3f348a1c5@google.com>
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
	TAGGED_FROM(0.00)[bounces-275977-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 18B423AE0E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:44AM +0200, marcharvey@google.com wrote:
>Allow independent control over rx enablement via the rx_enabled option
>without affecting tx enablement. This affects the normal enabled
>option since a port is only considered enabled if both tx and rx are
>enabled.
>
>If this option is not used, then the enabled option will continue to
>behave exactly as it did before.
>
>Tested in a follow-up patch with a new selftest.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

