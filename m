Return-Path: <netdev+bounces-257555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BABCpHwhWkPIgQAu9opvQ
	(envelope-from <netdev+bounces-257555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:45:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA8FE623
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67E18301C328
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E23EFD17;
	Fri,  6 Feb 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlEvOg6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99023EDADA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385308; cv=none; b=A2l3u/RrZIr/t0lNM5UdkQmv6Oi5b0qxgUbtoF+vHoBYLwxBSIwSjVud8iXG+oRP0pkzgSvpV6oUsLWzrCsW0HiLLJrYfegEejyeXRw3JGuVqg/jlwwiYhYGs6NEwr33G7y9JaHkRdsQ8/j/XbCyi7Ti8KhitnnuoZb5NnRt1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385308; c=relaxed/simple;
	bh=0YjDWpFNWweUVWQPi8JoGRXhWWSpLt7OB1/7pQuiWWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ik7YyGFbAXz7YS1yUzWOqH5scT6ayJDxbkKblz0QucSHuKFyTRUZm/VVxls9dgHEbPoQ33ZI4s63E1vRPiPSJna4CfQyIaxfUmJbongoQZ9gLpj+W+a6xBZupIosnC9g/Qa3K5ATt/iWZ7umS07w/MrT+Yo4vA5NMYdVTFm6wF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WlEvOg6L; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so32279485e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 05:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385306; x=1770990106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtFvs/ZVLVRiCDqzy0YAzdGpW+q73bZZVs4CLpediDU=;
        b=WlEvOg6LReBT7J4FAFT+Ahy9unADlfKH+Ss4irshCq6vM86iQVhFcR5cdw9oWl1RfE
         43w38W8PDTd8XWq3dx0afs6XuX9Am46ozjQFLH9chEIPhuuSEFea9M697SE1eSNkI9GP
         QjlFuQxyElK1wB4L2CkeU2F4Mcnj7dgf3kD7PCNo+qa962p48aGmphxTE4XQ6YWaacKK
         sfD9TMsdKi15fA8YSJIvnfv9SikWXXmT///24fCQkqxOad5wZySgRPql6m5RXwsGQWQ7
         ezXmzszdB4f/xxYqsUCC0bOhXh9ZIGpJY91kOi7LpUx3Uvc4q/LGWVpW/+cNLh3RLk2e
         tJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385306; x=1770990106;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtFvs/ZVLVRiCDqzy0YAzdGpW+q73bZZVs4CLpediDU=;
        b=iK7GhVsID89TqDHs4RZQskPEYGyPML07amAG8vyVnYTUUBC/+z8A2Ogk5Ad4Y2HBCj
         KqLe5xNeIKmbgqnrDIOipb+1tZVD8WLuwcY8D9SwDdUm8DVDRLut4wH7VDvXSerU9Gks
         slgsfh7R1lBZ8lix8c+oM/x+4etbXGkjzsZTiGkr+hmHp3ws4TWA4XRlZJalwGX/gsbK
         ClObqSGR+iIg/dr8U3Hk1OjNVEq7iiwyBguWY7XLV+BL48ghJmGd3i/rprDGurXlEgi5
         bifeyegdSXG5YpXFVQ/hni+WVdDdTUddClrrv1RY8EXfpQYd2S1Wpqskg3/ShdiA4san
         4aZg==
X-Forwarded-Encrypted: i=1; AJvYcCV48x47q0D8ab7RTXygdI2G/0843eqtE+72xJPxZE70DlDGGkW6k57QJRRxKwtyeONRZpHV08Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZGEpE5sBiQHicQ4/aEZuGEQlUQxaLFEb03//vWBSXbaBde1O
	lxGFCeySyHN1slAb50iPo7/WT0HmGBhKSeCV/9Dwy9yFdJ67ULCbXaPMC8NpMcltCcQRF2RhP6b
	10YXH
X-Gm-Gg: AZuq6aIxAsCAvL1QBsAYy8upjfvHt7cRW9hH0JXPk+Va+dFllcMIHmsTmskkX70IsID
	VzGTIIhvpP2J/YhnfVPLfvDzAWo+SoPjwXWYwQLO0m36JcXml7VUEc4SydoyWj+bFvyj5Os43lW
	9DhkST+4Y2x/tryduLJDrnf0UYBPPXTsja5r8QdnSrH0GQY3r0aCd6yVkLuqN90mhCGyb6Y6v94
	+zR2TWGYojP648+F+/GphqPZzuilpf3MVJtQ4gJNaCUXenxO4bzSpuupeX/e9/073OcMcJIt80b
	bmn00UpkIG773TMTPrVqSTUl84Iws+NCZ9qCvtL59N9dV4AGd05Po7L3h0PW/lOqTYlXfZ0j4J6
	OFXRxinF57ydKsVOqoFUzeFeul7rbmYGkEZNM8UJLcTgSig+29iuQRAiuMW4z5IVMeZf0eeDbYZ
	1SqS9MrbprFBDFuh+PHpavk9MZ4MU=
X-Received: by 2002:a05:600c:6285:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-48320231170mr42647485e9.21.1770385305926;
        Fri, 06 Feb 2026 05:41:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832097d9a5sm22088785e9.11.2026.02.06.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:41:45 -0800 (PST)
Date: Fri, 6 Feb 2026 16:41:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] xfrm: always fail
 xfrm_dev_{state,policy}_flush_secctx_check()
Message-ID: <aYXvliWTCzC9IIVS@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257555-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,stanley.mountain:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1BA8FE623
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Tetsuo Handa,

Commit 638361ad7ab2 ("xfrm: always fail
xfrm_dev_{state,policy}_flush_secctx_check()") from Feb 2, 2026
(linux-next), leads to the following Smatch static checker warning:

	net/xfrm/xfrm_state.c:898 xfrm_dev_state_flush_secctx_check()
	warn: was '== (-1)' instead of '='

net/xfrm/xfrm_state.c
    888         int i, err = 0;
    889 
    890         for (i = 0; i <= net->xfrm.state_hmask; i++) {
    891                 struct xfrm_state *x;
    892                 struct xfrm_dev_offload *xso;
    893 
    894                 hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
    895                         xso = &x->xso;
    896 
    897                         if (xso->dev == dev &&
--> 898                             (err = -EPERM) != 0) {
                                         ^
= vs == bug.

    899                                 pr_info("%s: LSM policy is rejecting this operation.\n", __func__);
    900                                 dump_stack();
    901                                 xfrm_audit_state_delete(x, 0, task_valid);
    902                                 return err;
    903                         }
    904                 }
    905         }
    906 
    907         return err;
    908 }

regards,
dan carpenter

