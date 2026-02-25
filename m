Return-Path: <netdev+bounces-260890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pw4NDfZnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:12:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741CB1964C2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DF5A301C565
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7330E839;
	Wed, 25 Feb 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sePre3lH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E162364020
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017972; cv=none; b=UwJeZVBvv/zbOxaYyNfZvyyGT4fWzSds1lKuHIXgaMQ5zGQb2+3tJuPSIVXl8Vt1lHkpl1ds2B9sdeNuZgzUJlw/Ph9gTEyzmtsRKoqJ1vLMXWSUXK7ijU+WX5Vrl2gRKx4+gxYG/U4BxkiN4n/r9b2TvbrytkIF37KZuvybUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017972; c=relaxed/simple;
	bh=NZQ5aqGdj3t9c3WSdmsR1ZCcozQn6Lp2eFAxaQNensU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvkmz2lmKQmOonBj0IZ6IIYWFkuzb2WOLYX0+aNrPKXxeEVjd4Oh5QvfEccHQn2VIXadVE+U1QH28DLYywRw1VzE+EH11pZv0LJ6AOqBIuOIZX/TkyqkUzmB92FbcLrImKZvp01fubZcTMO6QHDWO/W4+0Hn02inDDqquMmJmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sePre3lH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48371119eacso76808125e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772017969; x=1772622769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k42r/wZU6ZvLwUBvdfXFIAWDBVbvy5Zr19fCDdW7dzw=;
        b=sePre3lH7lCnOYqQedvZ8BJxwGIjZQ6VHnmD68BICm0cNRxPTbrRXJ97oy/vC46+vt
         pzKSVMtpXdUbsijkkx0EpctfM1oCmhQTUNlD4GXeE3+8KEB8F2jBzvpSjQOfeHooL4xU
         Csi/4TD9764o0dfzmmJw41WTNghny6sH6H5usA9FR8FaKxOHeO+uos6j/PNwgqxvA1ek
         El9btRrgzm8MuxOdapwXjdOENjnFfokKZqAswpjidXNRTI993j58vIyFDVRta/yvQfR/
         MAprb4alNz/XWHGwxJouqgWgY1IDImsvJ8rK3Y3koNwR9gPJ+SH6oBG7hfEbUEPkreBR
         rSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017969; x=1772622769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k42r/wZU6ZvLwUBvdfXFIAWDBVbvy5Zr19fCDdW7dzw=;
        b=Lf/9OXYs4VljiofCxpYZ9lw5vj0LxBSdu89i6Vydtojdb9s/Gjsm6si4GWvJ7Y6bx/
         uBFkEp3z2fisnyzDTo5ARd8WiSgLCvXUghnoQcW0smfNIZMnUqI6Dgc7osiWYsmS1146
         sdnlndRcLcEHFB0h+fXmrjgmk3NpQLiMiWbsmlZ2wqSFd3NHkl/+0nVPt4ZLEtkTURNQ
         5y46M6p+MdzSW2IyKpWGh6azBRZieb8gxE7/fSqsc++Lw5ynwkiF/Wnv2PQMTs8pK9Vu
         a1MIbgmX6Xtfiu6hv+rfqbFdPHekHRxWlddMD1yQZZMQlnecCx//wwUYnAzFBD1pj7Ev
         bcjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8pY+0OWv5nghM4rbhTjzHhWHvH7mOVppbRRpuBpH8iZp0OTVBBWr3fjQASeV5v5YiF1ANPMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRWE9KnzRaO36/qe3CL+vWIDLmtULrDg8v5ELP/AZbPQzelkf
	i+PbUzSQ/BORd8pPTjY52MzO/wsQEJYTFs7uI80bNTN5FYHj0X0MvFJcS1M3SFiq1Gc=
X-Gm-Gg: ATEYQzzriFeCM1qEv66NerBcbccf+tfIa08S/Al+r10pXoAw7gHCICosrSX8BV7speL
	yuySl5HKMsT720NEcoWeSuqrTN6THlnreS+i2r/H4tdFkYv8mXXOpeiWpX6QNqfOJO8LpU0g3yb
	J+bAYSJvgWrwrDIGbRpfBmNemq80carlQ3j2gQj42spd1E1ICuukoclu7gVqLFwm8JW9ZyH9X06
	OrMA8v9pf09nhcZPTQTIaQWes1eXVfnPwW3QQMGvyNLGbLIx2Y84yULMCfeXAAcnOBNqHmelnEZ
	yPlQJQqY/JyR3adiHuMR8M601QTnA+MAxwzz4OolZVTWEBsgzwZXcAAi0PKDR8HR+gn2YOb9jEo
	jxgYdNTYcmCUT3mHcMobjAMFeq2buAmsfph3EUIQRVFUumdCK17YgDOVEIcr1jQVkYttvGHOnXA
	LoT/dzjNIvZZTMpXlaxwKxPJ5QWwc=
X-Received: by 2002:a05:600c:c3cc:20b0:483:afbb:a064 with SMTP id 5b1f17b1804b1-483afbba23cmr174155785e9.1.1772017968958;
        Wed, 25 Feb 2026 03:12:48 -0800 (PST)
Received: from localhost ([41.210.147.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm53663815e9.4.2026.02.25.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:12:48 -0800 (PST)
Date: Wed, 25 Feb 2026 14:12:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Message-ID: <aZ7ZKk1ZUtvPnNeV@stanley.mountain>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
 <aZ60sfG1tdraA0zB@horms.kernel.org>
 <aZ7Ex6c1ZeqvWLFp@horms.kernel.org>
 <beb5b67858a5e90709e67b7935430b9986306279@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb5b67858a5e90709e67b7935430b9986306279@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260890-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,stanley.mountain:mid]
X-Rspamd-Queue-Id: 741CB1964C2
X-Rspamd-Action: no action

It's pretty common to have multiple Fixes tags.  But I don't think the
AI is correct in this case, actually.  I agree with you that it doesn't
really make sense to split the patch up into two half bugfixes just to
make backporting easier.  Plus the affected kernels would be six years
old by now.

regards,
dan carpenter


