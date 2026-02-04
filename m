Return-Path: <netdev+bounces-256597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAo2FBDygmmWfQMAu9opvQ
	(envelope-from <netdev+bounces-256597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:15:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ADFE2927
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 847373015A5D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671FC2E92D2;
	Wed,  4 Feb 2026 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cIJum6Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C527B352
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189325; cv=none; b=Ek1csS7o3BM4JFBS4fMJ/y2zq/O2tr2MilH8ZcG6uXHQcZYQ1P4vztr9AJ5mPe4GAM9XSfiQ8zVKJRilbjN6SQwA+HO2HpOA+Zi9+vg9mgr5jDJEUic9v/tgrxmxIlADgsDqA+PndywZXgriCeQiXUXcBgo+n2aa2YBrI6LDovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189325; c=relaxed/simple;
	bh=i7SHrii2V9xume0ZQ/Ds3fTYY3TfRh3hjqvbzH/xuv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur/mmMm2sROAoT0jnH9q0r8hLkq3HLnCTxkksnm7+2/hyCHjfrjE7Ilf0JWaw3/yp/zt5KooaW5Pc+WfzfBtyClYsJoGHrZF2E7BYWvXc8DTyknZ3011yVRMD1LmlfTaobT4BrpIibM3+ZAb90bh8rT48VD4iqzas9+ZazD9Ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cIJum6Pe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483100e97d8so2176105e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770189323; x=1770794123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x92saUYYugyMtUj3313uzdtAS5z3eKHI07XSbNMRFLo=;
        b=cIJum6PezYHw4GB41rtyZVwGO7yKbwtAJlwIMnsUa6leV32Qk/ylJqxd0rLLxgBAo7
         iKFUey2n2S1tnBs6ETVCsQozDPsRo7LZKZZ8tQYQOgZJyD8XMINxRgCcDWs/XmZdP8d9
         EI981owvyMWYXff+bHyw5GFz3LJZCj0bBJP3iPG8wng/6AIlX5mmSTiGBNeEQ1UJfGfm
         hmiKhkaa1VhoSU8JEHWtt+7+1HdFqyC6iBz3JoI7VMIJtCHjVK8owPRYc8LRLZOhjwSv
         itCnUNAQMe7T/a0PhAhwBS+yaSXkTx394g32NxHY0U6k3QAr4SgsC7JcBsgSR+JyqOwl
         aUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770189323; x=1770794123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x92saUYYugyMtUj3313uzdtAS5z3eKHI07XSbNMRFLo=;
        b=dl0kMI/k083oBix/xSXaBHzsGBnhHZ5Vrr68Viz/62Bujk0asJT2GiVAfOFfRtHXgT
         AlJ1y0IjlR1vRM+ppRHVWyBZ10G52Ydh3IdcnRU8pRtrcIjTr2HfPoHbYqdKj0rCPM8o
         NugHeh0XRTvpoaYK7A7rw8YUUdF4q2r9pD3XjhhyK1NyakdQyPckPJfwzCiLkzxNsjAF
         g1tBD56yFO01zaxHDzSnJlhOi5MWO90F2iX0Y+5DwR3r1QtrwzWtUAMwtsuhJHRPrhEn
         G8Iu0n9PpJYFATZ8EdVhgIa+ZrLXlF+1gl8d1ZEnDsA2B/+8BTlSM4b/ueA2Ooj2gIFo
         fb7w==
X-Forwarded-Encrypted: i=1; AJvYcCWYL0pcA5dC6HPP7Ra4wW7n1YCUpPHfamYL2JI1qHo5dj8wPwkdYdvFh2kGD69fmi6nsG54aLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3BSWPk78FcfRbIOsZki1q7UeJtJHSkvUVPV+0Vv0NpFCVQRm
	ezo/qcMZkmd6iV+8HVR+CBHQPnYoOce2sNjNvcU62jnTL1OnxxLoofpFQD3lyXqwHU8=
X-Gm-Gg: AZuq6aJOOz5qEAVROpdViNTMtiQwfMt2kIDJDKL/LJotnNxHz9RQKNwMCJ1RAnUbjnb
	8y8S30vDIJITwlFf90CieX7RyeMJ2ahaHN3/JjsJJoVsaJZvbRvsHIpGEJg4LQrz4jsfuKK1OYn
	6eAfQcOsEtiWlR5dRGwFUXRNtOc3QopPl5xgF904Y6Ec95RSSTCQmOW8iA6sutN/XPJnisOxqYD
	2GzUGTUqbIxEaKruPNnCHxOg3clMfuBoX8sLI8UUomd0gB7khnO4hvPO+CKybLYlDamL/qoIfCR
	MXQGVWb+MP780+8bWDzuShlmeXFGXSnE/oitLzn5ojjDTlQNJ+8M3BN29eF/6E7jnz8j6eY/pVw
	/18b7/FxreJ7bAhN1g3qBvWjdQAZwUQ10Fxel2yqe+VGN5BVcw9hjjKhJcMWps/VYU8tT48f3HB
	JylyEv2rhzKWOUVjmKHTjlRcGqiNf+Y64=
X-Received: by 2002:a05:600c:4e0f:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-4830e98f6fbmr24165955e9.35.1770189323508;
        Tue, 03 Feb 2026 23:15:23 -0800 (PST)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:9519:b02d:f49f:3f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483108e3ed5sm19055735e9.5.2026.02.03.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:15:23 -0800 (PST)
Date: Wed, 4 Feb 2026 08:15:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 02/14] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <y2q4usbmebqm6vpu32is6m3ga3f3xs5xe3jbk2g5n7l7fmt2eu@4m3guiuc3uuz>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
 <20260128112544.1661250-3-tariqt@nvidia.com>
 <20260202194946.64555356@kernel.org>
 <wdkd7yelgosii7bklmahxf5t6xnn2vydnwiiruiwqpyue722dj@yjnkcdctzeav>
 <20260203184200.216bb426@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203184200.216bb426@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256597-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B8ADFE2927
X-Rspamd-Action: no action

Wed, Feb 04, 2026 at 03:42:00AM +0100, kuba@kernel.org wrote:
>On Tue, 3 Feb 2026 10:44:16 +0100 Jiri Pirko wrote:
>> >> +/* This structure represents a shared devlink instance,
>> >> + * there is one created per identifier (e.g., serial number).
>> >> + */
>> >> +struct devlink_shd {
>> >> +	struct list_head list; /* Node in shd list */
>> >> +	const char *id; /* Identifier string (e.g., serial number) */  
>> >
>> >Why does this have to be a string? The identifier should be irrelevant,
>> >and if something like serial number exists it can be reported in dev
>> >info for the shared instance?  
>> 
>> String gives drivers flexibility to use anything. Perhaps I'm missing
>> your point. Are you againts free-form or just string and buf+buf_len
>> would be fine?
>
>I was thinking binary buf+len is fine, and we shouldn't really expose
>this to user space in any shape or form (hence no concern about free
>form).

How you imagine to name faux device then? I'm sensing that you want to
get rid of busname/devname handle for things like this and rely on some
randomly generated index. But the whole ecosystem is bases on
busname/devname handle. Any idea how to overcome that?

