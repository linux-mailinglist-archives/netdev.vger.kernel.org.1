Return-Path: <netdev+bounces-275971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA8BLKbw1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:55:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561A3ADFCC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DC12300C02F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84D3B0AE6;
	Tue,  7 Apr 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="0Z27UUxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8763AD51D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562915; cv=none; b=X23zU7c6ccPpiYGpvCVyFnRu5GYhcUU9Zu4uKN2TvzylJ4AOZ2vCjIzjaB7238973OCvuofboT676uWqX02iQti94rT67cOedWHV+g+fG6ntyX/Rc12xCmdHh+tUVT4z0jjgi+e7E16iqJQ/H8o96ffo/uzvzBBes76pHTFoeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562915; c=relaxed/simple;
	bh=2bt2Y+pPUyLZGB/JYZQHnTwvkzT2uXOXMCVVdOekqR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4DdWncEiUrOHGRFvH+KewrjiEBxH+vsh99abplA1Jssdgh3PiBld3oN/s3HIzQ3VrqUp2ws10sVZf77vq9gsMOC630cWW+BqXHYCfL+MVHkdnn7q5Orgh3ncuzonhb0yS/kqmGkEFHMdPjdv4oCJUwtU0jG4OJP8oypa0dBj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=0Z27UUxi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso26836345e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775562911; x=1776167711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bt2Y+pPUyLZGB/JYZQHnTwvkzT2uXOXMCVVdOekqR8=;
        b=0Z27UUxieZMaGB7NAYJtTldWlYFBjfLLOZlpQMitmm3BV2JggAKSDzeEelpPAWwaxc
         zmI+Z4UZ24O3xj2CbZ+Lua4fD2tUStRlLEiPqlm43R0tNGyoHdX68SAUnDNdgvecffYd
         gg6pbq3BrfRMhvkUBejyH0NDhBPn2LxrZFvYGOl5/6GiXsMTtabJzOEwSqKpRwcZ97+q
         3kTr+aCUIguZmb+kij+cgZsrHg0HCkqh9r3ywuHNNJjMTc5HKVUcomYtpV2ACyxeaXi6
         2rT0S5h389See0YZaMZ5KlfknLCFaYIPjDoTofcPSlLVxf7El2q1J8ys/hSezDijZ+wf
         ecPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562911; x=1776167711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bt2Y+pPUyLZGB/JYZQHnTwvkzT2uXOXMCVVdOekqR8=;
        b=EreuiSb/e2LXTZPxC8C82SacSbvYejK0u26bxyURqWjkTsj1nqy5QPYP+3XDmmfG4M
         zbPz6bvJWhkVnKKQAEkMuqcWWfBDfK28gbiUZptrpp0ql2pfNWy8K4gq+Vc7loAVIY9j
         rbkjK2hISok2arZHUrh3k5oPZpS4IpF1IfrTbnFrGsbPSvWLxqAs9uTSOM/R3O1A0qDA
         9Qr7NxNC2bkj8BfdKVrQ11c4SPGC/GMqiXDMDgP4/ulv30rC5ttym3tTP9JphTG9+j/z
         zH+krufYyJLd97Mc3dKSReuMfdSFDgSVDEeIzzPwtyN6N7ERCSiS0tSBhbLP6e2HXD8W
         IDNA==
X-Forwarded-Encrypted: i=1; AJvYcCW0trIt3SqwfvFDpOFFcWrKjpAyCaf+QSP7zVsI9DHFX2qgF8z1nrNKzJikGA2GBkRrJuaM5Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3CmMQaAP6uTSlpTlPYmgUX2/iDDOo1WIbrwLCgxmsasXbixq
	rUxuhe8nkVxix7TOGynBxHMftp7QmA87oRg2z2J8lWuV7v6Ec8Y/OMKFn1u0813+21E=
X-Gm-Gg: AeBDieuWQ2izRpBm5YAGvM+gUoFbtDMnggGbz4ebdO950zG+F2dQKPLzWJoT0BCIJD7
	4sfxLyQjO1BRSbBQH4OVtFOJezMPHNo3APyYu3pakKeIlx8Oaw4ghUS90DtPoZYdU0/BlfdKjSF
	Ftier0U+vrPrWqpwFP9pe4rBsiuahV2KFGxlPxlsUbKfK1Wg/4smpcMigie416lQ8L2z11z7BgB
	nC4ptrX3n28bzmp69+iyuknRgltMw7DgW0vgg03yfMs31Gwu/Ysc4p1Lr41YNX+uinCjgsPYXF9
	ywfcJRumt2NfGOW4Jngy8XIhoLMYCkIuPC34sXfTmhMRLVMC5cMc3Gqo+dPyQXt1CtzkhLmKeQ/
	9NCwOo16Rw5znfhypCTr+gatLEwf2u6SrBWiun+XBBO9ACyE2PPlKZ6+2fKsWPjU4PRffsk/dI5
	DpWdlFZrlDmB4UdQZDmSxEy4K6tmbzh0w=
X-Received: by 2002:a05:600c:c493:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488996da0e3mr222190755e9.4.1775562910849;
        Tue, 07 Apr 2026 04:55:10 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488bfc31418sm73008705e9.3.2026.04.07.04.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:55:10 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:55:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
Message-ID: <utlz3oebjyd4lqp5pd4qdbth2kywxo4hrlrnwcxsx3br76fwfg@vy3tx5f3lv32>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-275971-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0561A3ADFCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:36AM +0200, marcharvey@google.com wrote:
>Allow independent control over receive and transmit enablement states
>for aggregated ports in the team driver.
>
>The motivation is that IEE 802.3ad LACP "independent control" can't
>be implemented for the team driver currently. This was added to the
>bonding driver in commit 240fd405528b ("bonding: Add independent
>control state machine").
>
>This series also has a few patches that add tests to show that the old
>coupled enablement still works and that the new decoupled enablement
>works as intended (4, 5, and 10).
>
>There are three patches with small fixes as well, with the goal of
>making the final decoupling patch clearer (1, 2, and 3).

Looks fine to me now. Do you have libteam/teamd counterpart?

