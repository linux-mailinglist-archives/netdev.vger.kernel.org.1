Return-Path: <netdev+bounces-262217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNKlCGFjo2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:51:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB461C94C7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD12307D7F2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB87239E80;
	Sat, 28 Feb 2026 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="I12d5RjU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B31175A95
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311753; cv=none; b=tykoioz9mfh+fQdWGKjR1jU5w2IH3SG13lPcWEs9QJcEEqvrkeqadr7RCrVRZ1Ahkiu3KEXduzADjoVm+eKS+Kx3oBn33mcheNzx0b9Z1RzeSiVIEquq4UKSHc6SXLD6zffGYgNbPXFuJKmg/jkKcV9Dv6Tco/sY+jOQzWxlRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311753; c=relaxed/simple;
	bh=oOrd7m5maUyr91rkDk9NOQJ9VmJga+RtJUaT4CuUAVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huTJNAk4t5Dbw+A7M6MgELqsV8VrbtWmRkH5SWs3lImwh5aB9o83JK53m4xbbG6Hesz2cMLe8hNrG4BofPWwcuygai3feUXvdMlT2sgaUQ5Ooyo0UPjw9SpWXOb1p3c/5GaWsJ9NuDnEI2vhfRHhyUD3kkjTGQOVGaP/IVkybkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=I12d5RjU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4807068eacbso25964015e9.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 12:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772311750; x=1772916550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m8aFjrq4Z9gP7U0OtaEBLU+GXlSbE4VANyvNxpUgHDI=;
        b=I12d5RjUPAY8GGpQI5uwV4yHvzVYtQyE8opCMkQbJEeDhBydKtBYrZQuitYWcNzT8x
         MYCFXpb+MVnRoYHAmfRVj447Y9TnpI0ZftJ00RiHR0UOuue9FQPPCCwAnEtLuOwbfABn
         DZSYYUtG6BgJk2svJoufKAn8s+s/MKjbKibVK3Y/QAvKYqV7WZk/FyJu7UG2aUjJPLdJ
         bT2gxp4hlmLRjxkc4oJpSmCLGCOVjhYcofVfZt060OzL2i74NObmaNtr9PX4daeSZCkG
         /1jLI4fyjZiErUCghyYTWlLFxdTEgm5gsOnaKpTxFecovn3xjZm9FZrEGjo0d266gB8I
         l7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772311750; x=1772916550;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8aFjrq4Z9gP7U0OtaEBLU+GXlSbE4VANyvNxpUgHDI=;
        b=APkITno8U4s6JD/eScDSMOg2lw87tHtj9fXZ1uqVZg3qiIfTs158+uCrKSki/oqX9f
         hzTtqykDBa2ZkF2EpUsVynLbBFATjE8Sv0QVR86Hv2ib+SmkrZ8xrHJUEoLsvjioYG8k
         k88M4qsi3iD+GKEhp3Ncb5xRg0EXat3LmnyFknfsQx1cfmx6AIPyLW45Qbt0iLg5Ekhh
         jDoDCcy728nrXHjq7C96wBoI3K+qVorCeWJLUbrPZ6+nCC3j+g/fyuG4E0qIn+frtReH
         LcQqGzVA93LBDndzBfhDyazLL3P7fV9Ul341ZUnlZe56CzlmiQlj6jiOKIgWDevXlKH7
         SYXQ==
X-Gm-Message-State: AOJu0Yzr1O0Oph7rrk54Ba44VpLcOKlNbjKRQ8cdSMrDs83IJS0OJnor
	JOCYP/AWNOGsommeEmves+Dqazf53aR0yVylYcnv+8GXtBpWKqkWvZMiMLk6B6JZl1cDjZl8EYO
	jBrfg03c85fDR5FXNSdgSmLkJC083XtcUynRovRLbIRMxfe5GaaaW7AcoeNqpDrkn
X-Gm-Gg: ATEYQzyUaUCmvVYco1bYocBiPWX1lhSkidFpoqHqeJer9Lbv523p/dPcCwbjas0dCJ8
	eLudMGhkSdHpYbNct2QoJ2QZV92nLDovfQxX4w8m46uwkck59j5Sntdr6VgtjASrO/7/2tajm7w
	2YGlRvFhf1Mw6LccgeO5O2tM56OfWSKQPvNQWNcMYIqk6do9fx5RRv+J1p/yHaCosfCrNpedICn
	18W7mVGyevrpejoQ5siXbG+7qA1682umPs1SDU1tA8ZOw/jL0PSxT6pzX7y+FTImzeEM+hvsHy6
	ge/Bex9CkgChKUJIreNZGsFjIH1WAP7eLYhJaPSqEArCyNuXWQTkvHSAM5clGUUI/U6a7TUZXot
	iFPluWms+ay9oP8gJkda7BKpHrZmFM/4C8eI0jcWUfBgblM+yydzBeqwxvUzBAcqQCFc5NuCqsJ
	hkFBve9JrMMDIYYKaYtdaIEMY657yM6+f1lmk3BrtMfxGvLq3/fZN3qivdJSzPAA==
X-Received: by 2002:a05:600c:8108:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-483c9ba5fe4mr117605985e9.1.1772311749859;
        Sat, 28 Feb 2026 12:49:09 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:aa64:3310:9912:766f? ([2001:67c:2fbc:1:aa64:3310:9912:766f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439af926c53sm1746154f8f.8.2026.02.28.12.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 12:49:09 -0800 (PST)
Message-ID: <433139b8-3aea-4db1-8ed6-959ac445cd27@openvpn.net>
Date: Sat, 28 Feb 2026 21:49:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-02-28
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260227235955.660-1-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-262217-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AB461C94C7
X-Rspamd-Action: no action

On 28/02/2026 00:59, Antonio Quartulli wrote:
> Hello netdev team!
> Here is our first batch of new features for ovpn.

Please drop this PR.

The automatic checks on patchwork have highlighted a few things worth 
fixing (and the AI even found a real bug in the selftest Makefile!).

Will resend the PR after fixing all issues.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


