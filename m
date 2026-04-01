Return-Path: <netdev+bounces-274263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AESVCEOOzWnIewYAu9opvQ
	(envelope-from <netdev+bounces-274263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:29:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD23809C8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01EF7302DE5C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B8385535;
	Wed,  1 Apr 2026 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlvuSRM1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3113806A9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078954; cv=none; b=pZSe2TmTUedFXGHh6ntjrm8MHewwW5Ju9o4/5x8acmwANOn7g/RAXT2DzBGOxkYQ8Btn9knUOHNDwzX5IcQllhfUbf5qz26bapSAvcDeSTKmUFe4JlWM807gzPRy2LNW1v5VYkqVDSgigtHiPnbOu7ElJFHrNPAG0XySco6nYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078954; c=relaxed/simple;
	bh=GHZCrvs/D2lnf1tNNwAY3tuDLJpJ1NRojRPOhXECYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/JIYrT1HtkTfbAojsECSDk605EAWBF36LvrTYNMTu8mGH6z2yM6d1+UWlQ2IXJieaVO/zEddgDMOKhCkRB9rCiIbL0CV5W3AimSKDkeI65zzwBnqIXj+Nr2drJwwffzNLz4DGzjmM9Kq+KSkOTjjXWIVXUVdSfZeO9JLo1N0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlvuSRM1; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271195d2a7so934628c88.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775078952; x=1775683752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bShaikocNKRsezTXMpZ0Yv/7QT9ffmKUjnagEWeH458=;
        b=DlvuSRM1g7OgVWwIEJ3PqBoR4u7VRs3z6gY7Pv74Iy/0URkYA7r7Cnta91eq8H2vYd
         7kklwlF1DcCA7KVng1AKfTNSzMs4Rx/oqVA5vH7UFT/EyCXDofPovx01DiYsZMq8ydLX
         rWchPPdiCMPU3IDE/a6JbzM5vvK5urCKYLPtqfyYGwmtJDI5FtF0o5j45sd558426YX+
         wm3GuD0JnW3JNziId99t7kRXyX/LzePR7O3kpWTNOLWek74wYWjhTDHcH0rDryL5+m3p
         ayKa+/J76c2Pc6jKdWsYm9WoyYD4qIR+rBwtqIbWcm4zn+fwDiIpaKu7+yfgTWUNljqk
         +0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078952; x=1775683752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bShaikocNKRsezTXMpZ0Yv/7QT9ffmKUjnagEWeH458=;
        b=Im54mXfh31jzP7Gp2FtSFL+y2mjRopKMGvE4ecGYFLFLJ44DCvMdzActTFullnIqOu
         5oegftZictkNmhi5wgpJwOzFEfhMGxPx6yDxBkUlGfTwYAeQ1UX126YLhvNXKAW4dpPK
         3Xsw9w3FyjXxaUXwFB+y24TkqRY3DoyYkWFnqcTfnRf5wZ4GQj//wQtwJdNTI627wDpt
         WS2tYYJip992+mIF8QVatOGlr8n25gmy+Coo+/FkkK0zov77Hdv+0YGwY6veXA7uE9dn
         7Ag8WYLpIzxEhcGpX2M2mftsTDIperB94/ej+IMab3uL/c7vCH2fi8V7PWyW1Cnz9dEz
         YTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUTT7TYqD18+I/uqf+HofHQkCl/ANSMAUuaVjh9/jQ44zHfcOjAcqcm6mPGeHD17oGivx3Jcvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8AW4SKXNx5Uhdk3pi3DS14zjxE07AYwnnGBvGKjimmfmrazl
	D+gOcUdvgJnEhHB+CTPKkDOxztqsj/7vfMm4gxCHuqf3OuGusBlurGw=
X-Gm-Gg: ATEYQzzDz6tgXELsph3K8RtKimZL6X4kEPJkpjNZ4MtO0gzIS71h72K7aIdZWE5LRaP
	qySaAHM6T+Fe4SB/gw6tpvFM8Ds1Nb1r1I7p+ghdAFaDNYf1+4naL7qv6Tm2djOFc1rC97BhiZN
	QGQfahdVsEYWhcZYxQfWMoGkg6ACN9ovYkwPawA9Vh919wr4HLRdGQguovsgIhRl/g5Yz5ScWb8
	3bG3rVD3g/9NCaC9NoHt8q+c6BSyaNzLDnimg80EWMm/9DVLCHi+NPEXHPcNygG3urBhuqq3GsZ
	M8TOhO98pDKKfnm9KZVs+GiLtqReqQCVvmpw5g+ZXX6jj688e4tys1OZNjD6JJLLTAiBFzUiM23
	UAxPHnkkem+7wqXCk2oMkTrMaGguIc0tY2bWjPGtjyykVs20dC24yBmdMFaR5TJJ0y8umKQVfyg
	QYOs5GL165WqlXPJ5mFCzmeY6mDZ/pyUndI08IdWgO/U3qL/G5I4A/yJZTrZG+5FVMCGa3e0TJ/
	rWE8OHHuRSAFlSygw==
X-Received: by 2002:a05:7300:ed0e:b0:2c4:ec89:be0 with SMTP id 5a478bee46e88-2c930e6bdd8mr3177283eec.9.1775078951786;
        Wed, 01 Apr 2026 14:29:11 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm880756eec.19.2026.04.01.14.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:29:11 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:29:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, petrm@nvidia.com, willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: py: color the basics in the
 output
Message-ID: <ac2OJvW8ZfzDFtHr@mini-arch>
References: <20260401183309.378671-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401183309.378671-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 8CAD23809C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/01, Jakub Kicinski wrote:
> Sometimes it's hard to spot the ok / not ok lines in the output.
> This is especially true for the GRO tests which retries a lot
> so there's a wall of non-fatal output printed.
> 
> Try to color the crucial lines green / red / yellow when running
> in a terminal.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This is a bit of RFC, I'm not super convinced this is worth
> carrying in the tree? Please Ack/Review I'll apply if we get
> 3 supporting tags.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(not sure why you think this might be controversial)

