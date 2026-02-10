Return-Path: <netdev+bounces-258056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ77CY0Ki2kdPQAAu9opvQ
	(envelope-from <netdev+bounces-258056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238AE119B11
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDABA3032CDC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DF3164D6;
	Tue, 10 Feb 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv/gp+D9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E53164A5
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719880; cv=none; b=N8gjeqr8UbkpRbcU9xvBoQ2GKUtLnxJnL2GrSUvwK3bdy6lG6BsKboVShH9hiwyQ30//mY2xoMhYZ20RqNxfWpZIcCd2PwWcNBTm2GeaKM54c1drLEEKXXvw2v+bmwDajS1QXsdk3yV8yACBIvvwdNnVBVtvb3pYsEHc2PBQ5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719880; c=relaxed/simple;
	bh=nql3REZHm/889FCSxEmQiDoNigzkKAABGEemj5aNGQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXeN8t0D3mL6C9pCI1qTyqIBEsyRGFIqbhrG99Woy5O2e5R/iQsRuIDSP0GFP9gu2zBa5ZHGg+aqjfMZHBj3fcb1GqTGiwZ79cB+dmJ+iDhc6YN/24ePIRVkm42eHkgcdnIu/39eM7RgRsQkZ8IRRqhJ6Z0C++QDMFlbHu9/KHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xv/gp+D9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so7648065e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770719877; x=1771324677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUsFeNTA29iUzBEZy6/HMLSkX9AmxCg99Net+tWROhE=;
        b=Xv/gp+D94O2WucC81+3YYOwuDOAAqClR/wV9oqErGH1290pQhBxtJrdBoVh9TCxT5l
         Pu/I/YevzBIRZvaxWUR28RraznnBARZm7/htHJfRHyiZ8HTYRQ01NhD6hhwP63WSJH4i
         ZN/F2GxbXUWJNBrA5jOr1lEOCH4tKxIKXYrqxRaXFqw1RD2sYFvdlQq6fR3Wh2FSPqKh
         SSZA/J0p2Y44zMv/zoY+LQW1sH75c651BNgcCisU9v77gelnhSmr4I9iImLqYjec409z
         uWgALkr2YmRehnPp3CLBABMsSdnNVT2OxjJjfYY+tz7cZXI1pc3z5wu35+Eo+HKQjlhb
         ZJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770719877; x=1771324677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUsFeNTA29iUzBEZy6/HMLSkX9AmxCg99Net+tWROhE=;
        b=q0Q2SSHCILptEFu6+mYjP5poueLCSs9K/klePbaLVBy389WbMpMY6VrsXvnc3wxQ1b
         MhV8pqtI5HAxAhfIzfsAAHkFVbdvfbHhud7hVpPth33toMwSdXGrWMIuAQvXK3wrS2J0
         ZGrlnU32vOkopAocnbPIvN9vvyMy0/kOIngTsIS/MxrX+nTwAgCa//nN66124TCTMjFL
         HqC/tt/2B97O8QXI5NMTeJVRz4AOPSpTnAqb26II1lebpCpXk0M1loMxX6RjvQHjle7q
         gRdnHMKY9raFucHIKH7zhwEAI16bQ2TJoLTIa269j8SkKqbdlTy45sMxaTsxjWdINpZj
         XETg==
X-Forwarded-Encrypted: i=1; AJvYcCX9NvIEwqFJ1SffQ389Uiip7OHW7BmWisqhNh8MqSuls158RRYNEyl7nbM5f1l4LB7vuS18dKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGj2ccIFIQg9H5BevqAlGtVK6TcErJ/jICI4z40ZGAtf8l/0M
	KKm6u7tmTCXKvpNdm6BnQ2H6vOe4NneI848RS+DZmFE9LP/WO+Ts5L5tdEmqyOFXifA=
X-Gm-Gg: AZuq6aI+jPloKViYvZKed8WEgjlt+dVLabEUHK0BnZnzTRSZHtk1YOUu2OYv3zTQOC+
	4k500X6UFWiu8XMkNyJzz4iCHNRSlxR4+U6TUjtOUN+7Pm1bAdo1jXkHNre2sBXs3JBCS88DVw3
	xAleJ51a2mTzQmhS91m0aoDG7OvtXacMTzucZHgToOuC34e03P9CM4bM/tvRVmamHsNp9O31tLX
	Q2WSmB/63rYlPskiUYs7scmPdkVqEjjqsC/pQFcZtOyoKVT156JRgffSOpVWcgT69v+zYOLOLQt
	hLFewcgnoeNHlmnmBLCAHisN8+XFX+K4Tm6QbsKinIqn5SSsog1bf1TF955RR/GBJr6VR4+564u
	rg5G7FRhz8+5ZomJWnM5CdpgtHhcMgCCxylUfY/mz/ouX84avirgenw3tt+Z4TRBGYzSl0SporA
	NGdPMbeKFlee1auNWhIfOvzH8zE31H
X-Received: by 2002:a05:600c:674f:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4832022aee5mr185650025e9.30.1770719877231;
        Tue, 10 Feb 2026 02:37:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e1a5esm52330635e9.4.2026.02.10.02.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:37:56 -0800 (PST)
Date: Tue, 10 Feb 2026 13:37:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] net: ethtool: Introduce per-PHY DUMP operations
Message-ID: <aYsKgV050-wa1i96@stanley.mountain>
References: <aYXu0esD_wSjGTZm@stanley.mountain>
 <c9c6378a-14a3-440a-80b7-f48cdb06623b@bootlin.com>
 <aYmID1BOGmwb2rUD@stanley.mountain>
 <e5f1688f-cb13-4d43-bf20-644cda6ab494@bootlin.com>
 <8cd942c4-986b-4c20-bc12-f8fc17f626c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd942c4-986b-4c20-bc12-f8fc17f626c3@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 238AE119B11
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:10:38PM +0100, Andrew Lunn wrote:
> > > ETHTOOL_MSG_USER_NONE, 
> > > ETHTOOL_MSG_FEATURES_SET,
> > > ETHTOOL_MSG_CABLE_TEST_ACT,
> > > ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
> > > ETHTOOL_MSG_TUNNEL_INFO_GET,
> > > ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
> > > ETHTOOL_MSG_RSS_CREATE_ACT,
> > > ETHTOOL_MSG_RSS_DELETE_ACT,
> > 
> > While these commands don't have ethnl_request_ops handlers, they still
> > have a genetlink handler, see the ethtool_genl_ops array [1]
> 
> At least for the *_ACT commands, they are not expected in the
> userspace->kernel space direction. They should only be sent by the
> kernel to user space, to indicate some action has been performed, or
> happened. I don't know the netlink code too well, but i assume there
> is something which will throw out such commands if sent to the kernel,
> without even looking at the parameters?

Ah.  Got it.  Thanks!


regards,
dan carpenter


