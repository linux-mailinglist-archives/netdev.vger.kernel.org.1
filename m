Return-Path: <netdev+bounces-287008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULI5MhnqAmpKygEAu9opvQ
	(envelope-from <netdev+bounces-287008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:51:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7251D0AF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0742302E319
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23C38F62F;
	Tue, 12 May 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="LeakSED8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DA4963DA
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575547; cv=none; b=bitAOtQ+QLFdm8eLfML54sry44Ufo66b1PvFL4eDDcLdhT4JzjbvgXcl0bfyUlhcedkYBeBPIJeZl5Nkk8GO0XQgznR527WSFfhuediChVC9fcDDA5mpMLgg3kP4yZ/MJB+qROSgKoJprr/DqzI6oaQH3iEj18z6KCNLU7LDRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575547; c=relaxed/simple;
	bh=VejzyZEps18cwGic+7y+WtCkMAqA/TE5eqTckN89HUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLd7JoBk2uGT/7lpL8KyNaedUe4fNZxsqTfyR5UX/TxIXbGTKDJWA0rvKmU/hE5CeXX5n2LTNT0LzlVxOGzR/njsf3aFxhu3UW521Fv50w5zZmqet70X23q/jfKNjdsZK3pxepYxTxdfJVZvPSpQCwwMAO1O1/Q7sYxYS0m4y+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LeakSED8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso48690465e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778575534; x=1779180334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOyBgh5+zqSkeyyWb8Vcm36qUJiK94Wa6W+p9Jv89ZA=;
        b=LeakSED8mzEjkziOEF017NihImfhHHQlpj458I8uwZBvUCjkO6zTlIPrfDzSNIttud
         xYYRo5EPB6xkd0LNw1GaLgqmqCVARGDQpIG590qMTtAVWha+dqXogLiRcXyrQSYC8NQx
         L+8y1c5oIEoc7ZJZWjOSfYApEi29UWMqo8LhQXPzNqjIQeGgVpHIQV5rnzdq5dnjaTSK
         Dg7IYzjAmfgSdnyRMpf5HSGdcvxMpT8OWEW7d5hH4LCkuHFO3z6r9E7UwYk92ymOKZvO
         s06MJbhun+y2dfeM2uGt/CQt6G2E1hMUInjuPMNwaIercHz2lXRcsozzJsk+dI33PJo4
         4rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575534; x=1779180334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOyBgh5+zqSkeyyWb8Vcm36qUJiK94Wa6W+p9Jv89ZA=;
        b=NckGo2518vfZ2sTik4ThxAql3m4KzUHeLvV9Hv7JyXwk1dNvO0LUUoiEujtDaB+w19
         3drBKZBFU56QIY1Ge7vKyEjv1pixY+D3rW7Ryatap4pfCxHYYFksnCV/f2WugHMqW3md
         LKslAu1Xa1ZOFPASJOsiTWsECWHPMLWsxiWBkUIiJ51bHPSnFw1wvjgraT2AKd6fR5Ae
         pneqNe87KA5WpbjZK4NKXSg9D2KI6eyDZlbCqJaPKFym6Ex36KhNEkq2Zu4rxFWi7nNt
         vakVmhTrlSWTF2PV6jwFB6RXoEMEjeR0evh2KvR38mAuSh3D+3+/nrr3lMo7egoGwPcg
         9iUg==
X-Forwarded-Encrypted: i=1; AFNElJ/fmH8on6t/ouFVnEP5BqtDub+LqriC9luLV0pOSqhvLEpYVCoH5gbS5zNHtEKHD9cPaterJu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuoaaiPNYQZ+mg+wB9+TSFHofNY1JC9EJxvaILL/QvYbIf9us
	3r6+AyGQQpsgkSqtInowIewKzaN+YI0/A2nGYF+5e6qEsFVEcaG2kIy/cARiQZHy0G0=
X-Gm-Gg: Acq92OGuHki/hQ6aor/REIfGDgTa42bi1LZ3Eos0a5i/1RX6Oo7m9QLnCPkG1jBDxYz
	3JlnU/gUaI8bns+GzvMO+u4l0k4qg0WEwzoFiBUTBNxY8vER0/XHE0zSCSuX9/+qdSYuVs1OMiw
	msd9s+fnVogw8KVdIfQi2JxmynsGCXTbvwdqRQb2xSoy2vXP7J+R1ky4YraB97FAD9Gydk+u0vK
	A7vEVhHEwA4J6fQStHzh1xmMJlihR0XdwE/62r0kmyEekzqgiQXojpLaq5I2tHMBuJgCfHuiRWp
	PuFPFc81TItycBds9BOZt6I0D5OZg7UppjP7JfHEhcbHsiseMBNVFirNkL1vvSKulOtWzJwBQYF
	c/yoA3ZT3EpxwTHTDCNdGF1NSu65Bz0IiljnGJP7bw0/TVjrWEVDSDV5g1XtUK9rVnTjiqdcbST
	Jt2oVdvAk9FR2teWHAz7ct6AgYCYNrlY1jN/4ltyJn+zMbRQ==
X-Received: by 2002:a05:600c:a11a:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e8fe4dc0bmr23026925e9.2.1778575533826;
        Tue, 12 May 2026 01:45:33 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906b04a9sm50232105e9.7.2026.05.12.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:45:33 -0700 (PDT)
Date: Tue, 12 May 2026 10:45:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <agLoeZtsSizR-R24@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: 21C7251D0AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287008-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>
>> From: Mark Bloch <mbloch@nvidia.com>
>> Sent: 10 May 2026 06:02 PM
>> 
>
>[..]
>
>> > I look at it from the perspective that from some CX generation,
>> > switchdev mode should be default. So that is a device-based decision.
>> > I believe as such it can optionally be permanenty configured (nv config)
>> > on older device. Why not?
>>
>Because sometimes switchdev_inactive is needed and sometimes not.
>Such knob is not device decision.

That is what I would call corner case. In that, user can use userspace
configuration to change the mode in runtime.


>If it is placed in the device, orchestration needs to yet use additional vendor tool to configure in the device.
>And that theoretical tool cannot even run yet because driver is not yet loaded.
>
>That sort of defeats the purpose.
> 
>> This is a deployment policy decision, not a permanent property of the card.
>+1
>
>> The same adapter can be used in a regular host/RDMA setup or in a
>> switchdev/offload setup. If we store this in NVM, that Linux switchdev policy
>> follows the device across hosts, kernels and use cases, and can surprise the
>> next deployment that just expects a normal NIC.
>> 
>> I'll send another RFC v2 with support limited to:
>> devlink=[...]:esw:mode:{ switchdev | switchdev_inactive | legacy }
>> and let's see where we land with that.
>> 
>This looks elegant to me as well covering all eswitch modes and still sw is in control.

