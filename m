Return-Path: <netdev+bounces-259818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMTfASRPmWm6SgMAu9opvQ
	(envelope-from <netdev+bounces-259818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 07:22:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C016C433
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 07:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AAE93016D1D
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B833D6D9;
	Sat, 21 Feb 2026 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcYa0aZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9312F363E
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771654942; cv=none; b=BE7wi+UygPBbIJa8BMx8BtFLmFafBpe0C6gHCpqN4dNdFVa1X9bvX1U467lR2bH51PZ/tg+N7+yPbZ6YZMv3si25KgLSrbV9GPQCJLIFamQ1Ur3JtbKbOKnzGGucFHtv1i6a2Fl/pGgrfY5B4HKIGCp5aCt0sc/nejWARn2HA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771654942; c=relaxed/simple;
	bh=WiLpTwpO6VG5xw4dUaI3Ch3DmsVdYCb8Wat/kUstxRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Sn3+cN8ZOzYEBJ3ei3VpWEIMle8wljw3w0jiBLRoT0x/s9z/wG9UuUW6agReKgCBZcro2nDnXyCSc3KwdfkdoWOHOHFUa5Dwfo6j3z5YDUY+u7lwV/K/l4BtNemrtFcR1wgnPNk5M1kAEJh5m/fZ2uEeodwHnBY5b1giNJun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcYa0aZo; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bd8097c709so333752eec.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771654941; x=1772259741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CmZSBJp5TTAdoZ4YBh+QvQaNRBlacZGM9WdHFW4yfI=;
        b=dcYa0aZozvbGGzrCtIV9dRHN2W6fhiSaMKRGqvp0Hk/LKGzrFxggEozT2GVDO15uKT
         9lme3rpwNdwNRuovZfX5n2qjzdZpO0rbPepFAZfP5gWu0inxKDYgA6FTIqhAAyQzwpDz
         QFg98DrWKiZpnIt2rFRMbX3XwUcblJw9Cq315PDOhBEHmkt94bbDamqIqreFNO/C5CmU
         lLXC6wGhmu+IjRdqo6wX+JCh17xbXcYPnQkYmm4IV28TFA+6isxmjyrJcik8W+Hj2RK7
         gYDzXnMQEGKSwK34eHbZubK6MbGizs49Wf8OQQTzzwRMFGu+1BoKgbF9NYafQyuBXr8b
         lKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771654941; x=1772259741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CmZSBJp5TTAdoZ4YBh+QvQaNRBlacZGM9WdHFW4yfI=;
        b=jXJcYyXtOyy5v8j2v0uLE9jmNuWuZW7G7RRzE8d5Zu9VLpuVLvWq9Ksu78Qaplk+mD
         Z1IWHrvKIZuo+42nRwn74pVqhUl+UVF06jL5anLxuyUpNxFTh0e7gDP2rdVEeE4PccC5
         sR8Yd4J62sbdHbZVy+fgFesSyg+X0PO5n2zLHCQNi6fkUgIel/ygeQTB/5rEiD83BBIO
         XtM9akGu3ziytp+RlynW8s8VRTs+X0hiKJ1P9cCZthcvzboLGgbY4YIM3N6O4NRRaw41
         pVcLZkHn8YOY8j7dWyZyfHyqStwmq+Zvop2ACSAKRr23nqJKrBrdcNe930tQ7yxKVm8n
         BkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpnbYqlarilC5jEN8IUQhCqvVIDG6JV8DxhbgYh9IXeQutZ7AQL1ybFZ/u8PBMlPrE0h/rovY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLljR4z+vQRrx1DtspmKTctqNBmIz79oNSqDNjrIpJqJaLVoe7
	smj2UgJYiXmpU9kSzfcGmF6xpfK9k3hpOUpKAIQ/o8zTfGW1+ZU470s=
X-Gm-Gg: AZuq6aK4p7KkRxZ8OL+APrkGLWbNK6yvYxoywYeNOhbqc3KTGec1Gu93Y/rNHKNwLNl
	dk2ZwlEgLGmDEtHnsHmsDAXnE2d58YEoz8oiB+df0Vs38/FUqsSpyvMQxLQ9cmzBY/v6PnCjqXs
	BPfMz+LhWSYe4e2LheO6nsk/G/neV33+z1/fMqgFvNdjtDbjrObg6C1Sh5qlhsx7G8Nx8aA7a8M
	vNY63thRA51H6jtH4eWSQ/+oeN6tkL4rKALJ4i0vfDHH7FTVQpXRZsIzv8LNeDE7AdER4YJsADZ
	Bv6aZyqAZvwcon4meOjUVeD8gNEs3ozkKIsO4ltMlwLYPF2MH7qG+y0cUrad+UPp7pL0ibP7zYw
	9qpejOy/sLJRUBo50B49LN0uKJlZt2njHpETkYrToqxOdNQ97Jq05gcNycPKUvoQTLU/7AeqBU6
	28wRNeAR9ASUjUPMAyscMGjw3r4dcSAVnfZugth626xuWAebTHXebolla77WtmqWUUgHr9yop5d
	DoL3+v6UJKsgFJ0gA==
X-Received: by 2002:a05:7300:6144:b0:2ba:82f6:ccbd with SMTP id 5a478bee46e88-2bd7bdaebc5mr1139048eec.34.1771654940695;
        Fri, 20 Feb 2026 22:22:20 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa35f7sm912418eec.8.2026.02.20.22.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 22:22:20 -0800 (PST)
Date: Fri, 20 Feb 2026 22:22:19 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: I Viswanath <viswanathiyyappan@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <aZlPG0A4KYrCk12N@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch>
 <20260218174025.2fe593d3@kernel.org>
 <aZdddVNRy6sYiUEt@mini-arch>
 <20260219121213.5b5ab0e7@kernel.org>
 <CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com>
 <aZkHFB1yH2ooiukD@mini-arch>
 <20260220172214.7a12e722@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220172214.7a12e722@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259818-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,davemloft.net,google.com,redhat.com,kernel.org,queasysnail.net,fomichev.me,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D0C016C433
X-Rspamd-Action: no action

On 02/20, Jakub Kicinski wrote:
> On Fri, 20 Feb 2026 17:15:00 -0800 Stanislav Fomichev wrote:
> > Hmm, interesting, I haven't seen that.
> 
> FWIW it was one of the "public TODOs" I put together a while back.
> Not sure if the version posted by I Viswanath was converging fast
> enough to be worth reusing. Up to you.

I feel like it will take me awhile to figure out the instance locking
(looking back at the lockdep issues we had), but happy to help with
the other parts if I get there first..

