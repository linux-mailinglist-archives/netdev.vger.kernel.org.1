Return-Path: <netdev+bounces-276373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B85Bk8a1mkxBAgAu9opvQ
	(envelope-from <netdev+bounces-276373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:05:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 646F73B9942
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99BC302417E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8A39F18A;
	Wed,  8 Apr 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="gt//kcau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0F3AD510
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638980; cv=none; b=r5vZy20ku4DTBCDkVJhnuOMIKd31jm4My8ejdLGQ0f9qyzRzwaGMGSQ+sGer12aFw2XjggJLsTd4QZVpn589ZztgqJjFpgywpHi5EE+TLx30nbUBhZ1I/+MWnKB6VlAoMT68kekDtFWD6Rzp7sxNcx2chrezf30L2dCmGBUkgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638980; c=relaxed/simple;
	bh=5Wfzx0JvV5+lRKYwOJCGvqO/Gl5pYo/UtDK9cUzJ7/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4x4b9K1AIHYLeSkjrGxOGniMP20Ttnfz08mMT9x2IIgZP4BzG+LTI+OaE14vBdZK0w+WJzQNGskEUgYzY4LFMibZ/BXQOsEeGXvbThVj8xTRoTAznejP09M6a+WTHCUxNGZxPpTOl4syI7K4/FS4RiS52sgQpQG1n6maerR8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=gt//kcau; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so16259295e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775638974; x=1776243774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Wfzx0JvV5+lRKYwOJCGvqO/Gl5pYo/UtDK9cUzJ7/M=;
        b=gt//kcauhKw2s1EKOxKxq2VyaPN4u4GwCIj2H55QO7N5/zBkYHu2+rYp/sln4GhD7l
         DVr3Y854XD+k0H0MACpUOVlRqOso46HfSxnYpKPeJ8U1FpTey01lwXrgWBjmEv5tS2+Z
         I4cr3qYXqAcde+pClFgmTpmzufrzejdbYdnbtEVOhnLH6TMkfT0Y7hdP5yXyBrJ9mme1
         0iwLNYjXA4V+YHuECBhgGvJEEtP8ejTA58wqtk4TQLsW4lbNU1IQS7JOCnkZdgX4TWmr
         dcml+VWqrIO7ghkq0NgKg5uE+WeslivrwNvWu+JQt+TjT/BQrM01b18AWVNMpkmkTPTw
         cqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638974; x=1776243774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wfzx0JvV5+lRKYwOJCGvqO/Gl5pYo/UtDK9cUzJ7/M=;
        b=Cnt58QJtrqTlvGqvGN7m9p+7NTpyuJYxlzVfXeftyMoo+XJhhQxpuKkDtC60gbcQHe
         XBSaHhYeTCvnyGfKXwvkl1pY6Zo+Fn3Ysge26E0k2ccXfITbRBnko70gWN9N7YF/NiOa
         zDI6p0OdxuZpkkyjkkFn4NPoq8YoKmwZoFFp8p7PBWE8fowdyUBcA3feCROtYwgDSdm+
         5InsgkPNIqtmIH6kVwJd9HRKyLGR6YZFw5H2J45PCCjHU1jhYHaYvXZSQ6QocslwFX4z
         TEjJvqUezCI7IGVNj4Yd+Gs/kVoUBAYkMrzR3xrCXXnI/XEirxj8Pszwb7OBW7Wj5RxU
         jR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1REokipKK5KYneTq2y+LxkhtrQMewUuPAQz2JD7cju/JVW1iSrKZLAFW7BUgaYjQ+3nz/t+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ak+l1rD9Fj8nlg01/RGGFBaZiNJIMgDL5DMOc73NKhnIx7n+
	UBPs7JgiRqODhNLEP47KTYxef2LfvXjDp1RXPL6S8HX3Dy/Hu87oZoq1GkhF1/Rv/pg=
X-Gm-Gg: AeBDievWnjopUS1ZCZo6VeibQqElGRsSYpYj0xYQn6/uNnJ0KYRIkM0ipuGm5MzLVr/
	iSTEM+i7xhzTSuSXeNVgzssftUw1LPS/R4FO/5Fvm1aUHQ74hn6q5ZlFQyhMnQeBiexG6LtIdLX
	2HvlHyUSe1fcaTHauHCDAfmjzXFzwVpvSwcI7ITHn3alibSfnRoAtKOE4KdhDjMuFjNs5uGPK5a
	DsMuTm+ZcFMGO5RhALHIneKf0ie8uNaZXIpZVWnSDtzs/DsFMxWIa/lof/roNy2ujVNJs+SSo76
	92bDos673ugI6WXu5jELt8YUVSlvWNGbLj8j2ZUukIpxkI0u1s0k0rFl6n64qCqP/lXwBQfUtY/
	JrCnMtCgqeVc0el++c0f/SHfcB0mKkatG6SRx5MX29bU7vFcrsOnzZ1eMDRnI9GWmD9ppKpPmyP
	dCUOmLU9XgakyuZ4lr1nLko7ZwY8y8d+k=
X-Received: by 2002:a05:600c:64cd:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488996a1c9dmr293324265e9.6.1775638973594;
        Wed, 08 Apr 2026 02:02:53 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83e906sm700342285e9.8.2026.04.08.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:02:52 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:02:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 03/10] net: team: Rename port_disabled team
 mode op to port_tx_disabled
Message-ID: <6imn7whkj7rjg7ql57rlm6u2wv5bdt6a7oxihmyphfhtubht2u@yu7dubtqxy2a>
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
 <20260408-teaming-driver-internal-v6-3-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-teaming-driver-internal-v6-3-e5bcdcf72504@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 646F73B9942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Apr 08, 2026 at 04:52:22AM +0200, marcharvey@google.com wrote:
>This team mode op is only used by the load balance mode, and it only
>uses it in the tx path.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

