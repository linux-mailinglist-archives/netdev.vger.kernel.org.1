Return-Path: <netdev+bounces-260554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJHbJ0e5nWntRQQAu9opvQ
	(envelope-from <netdev+bounces-260554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:44:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB67188976
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4A453055F62
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729538BF60;
	Tue, 24 Feb 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vWR8ZrZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037C2512C8
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944192; cv=none; b=AxIcoRQjL9+mZoxakM9fRnWQ409ZI5UceddBWnr/5pU/hHNBIMo/FlEp3hkD1yNwKSSt794i9M3xX5HOoRSJ8WjSe7b5h34+7IyHrygwCRnu+fJYHvmU+m8FC8F9X2kwb3kiQi+Fp5c9pfrHEaliLUBJXgx2bFQTDc8m4c6jeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944192; c=relaxed/simple;
	bh=gzUFtEoOLJfHbOL5ob9Fn09XSQNPAq7NZ7hNJ/S6TBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkXqWyMq9ZmGLuOCvFbinNgpJNesIZUexAYM+VYu7w/co0b5xnWQY3lYX/ALvoTB4Nc9/zPUBTQpzYqrBfokiQp2+Cfgi6Tyht2nsu8lRl3DQiyHwPBCSu3fSOkuGB6u30/j7fV5q9+cXF7cd1MrlCxEbvA67DXPOgSK2bGj6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vWR8ZrZT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480706554beso67683255e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771944185; x=1772548985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjtK1422xU+DjPdSSWaqSaRkXJEFa/RxzQWW6MAfRnY=;
        b=vWR8ZrZTQa9WWAfAjBtR68wyLNeSYLnCk4mNXhwZLRUs5am4iX8xW+QVH3LyYiMR0Q
         SU3Awt9USUFnDkxSYmwoZFV1huN3pzX4FgmQK+UzLfd2Ap/HCHRzAExHijcfFZumX/Mp
         1czY+GNS5hviTt9hlJg5By2r77yJR60Foz9YA+oBRxekKUWtbAQp0v9zzAzw4If2lObk
         xUcqN369TANZOmI9KKIPMuLM4Sk6J8o1R7sVi3Lk5uxhLsFArc+K/Ne1pKCewSJObquZ
         jtqwMM2s7vf6znPuHzHoHJ6b34W3MfsYO3L9yMxr36ovKZkbHREv2b5hy6KxrahT26pp
         fosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944185; x=1772548985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjtK1422xU+DjPdSSWaqSaRkXJEFa/RxzQWW6MAfRnY=;
        b=Z1IOlySPfYbNYl13KILRzuV2ZKw9IuJEehwsk6sTJkUVC/XaqXx1lhr2RRwQyWwumb
         7L4BZphNVAvi4WLaGvc9pLMxr5RKSMjqOChCQmTZEN3j0UfLJhSzaePrN2EP+IQ3rYD+
         kIwSi8x6uLEaxgoFlXzTVCsWsVVVsaK+gNBt+1npcaUmZp1Po7Lcs9dCsS58vS8WId9m
         vIF4FOzy08cSBoqAXt3sjzDpkYkASqWDSRBuXA1JFBp+cs8xt5d09tmBBszpj5dDtFiS
         o+bznF1NQK//xvimv4LPeQqLGzNJqHmqct3es5u7eawVuIvsyEKIbuF9+0053h4xSdax
         Ah+g==
X-Gm-Message-State: AOJu0Yyz39jA4Ph8zV3C3O8C9DQjdqiuIjO7D6AHxwg7XCVNs6aJ0GrH
	sb+QcdNC/G5aq+M7tPfVkbEqa46B+nZ0QlBJM8SGs29e2h3RUYN7jNnvJy6oQF1eKRMHdlIaPUq
	PjuUQ
X-Gm-Gg: AZuq6aJygmF11sBzVDnlvYUnz2rDVNxHyQnV+9KTIWG2QhHDCfMP4XL4Kr4y/eevh/Q
	qwu3Mm/dBjTELY2Yw9tUD/veMU97xPb6B06sxRpWgF/fBWmeel8ooabtpnqStzV0GNMCUWSvxvF
	+qxXawBPoK+Bc+oLaq9tyNtLCn/QzV0Fwqmw0v2wfP31UZ6L3BLUM3gv22a5Cn1b6orNV2gAQe4
	rlVya+JjDU8AzLkd2fkZ+tKr28AXvKcdcwOjWJOwqJhaH+s4r94CBCdmJUI5VDl/KxfS8m5wiee
	LpiQLVrgg3eqnBAgPWzTIl2rbhdl6sGq+H5dbVpqJmRYA+StrFv4lqedPgfoOLWjJ+auil/296k
	nL5iaMhR4ycETOTLpEC+mwQztOBXDf+pGWKdVmwSjIDKNJM1ZdLbcVY+2NkZdgyNGjbsKpyL0BK
	UBGJ8Mp3AgF15fqoKB5fatyw51jg==
X-Received: by 2002:a05:600c:4704:b0:483:6de6:37ad with SMTP id 5b1f17b1804b1-483a963d635mr197060505e9.34.1771944185441;
        Tue, 24 Feb 2026 06:43:05 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c60bsm26666122f8f.27.2026.02.24.06.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:43:04 -0800 (PST)
Date: Tue, 24 Feb 2026 15:43:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	penguin-kernel@i-love.sakura.ne.jp, stfomichev@gmail.com
Subject: Re: [PATCH net v3 2/2] selftests: team: Add a reference count leak
 test
Message-ID: <j3vwhecuahixqnlr6bwecbruejr2kpqsobzna22j3h3y6jg5cp@izpahtoq6a4b>
References: <20260224125709.317574-1-idosch@nvidia.com>
 <20260224125709.317574-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224125709.317574-3-idosch@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,i-love.sakura.ne.jp,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 9FB67188976
X-Rspamd-Action: no action

Tue, Feb 24, 2026 at 01:57:09PM +0100, idosch@nvidia.com wrote:
>Add a test for the issue that was fixed in "team: avoid NETDEV_CHANGEMTU
>event when unregistering slave".
>
>The test hangs due to a reference count leak without the fix:
>
> # make -C tools/testing/selftests TARGETS="drivers/net/team" TEST_PROGS=refleak.sh TEST_GEN_PROGS="" run_tests
> [...]
> TAP version 13
> 1..1
> # timeout set to 45
> # selftests: drivers/net/team: refleak.sh
> [   50.681299][  T496] unregister_netdevice: waiting for dummy1 to become free. Usage count = 3
> [   71.185325][  T496] unregister_netdevice: waiting for dummy1 to become free. Usage count = 3
>
>And passes with the fix:
>
> # make -C tools/testing/selftests TARGETS="drivers/net/team" TEST_PROGS=refleak.sh TEST_GEN_PROGS="" run_tests
> [...]
> TAP version 13
> 1..1
> # timeout set to 45
> # selftests: drivers/net/team: refleak.sh
> ok 1 selftests: drivers/net/team: refleak.sh
>
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

