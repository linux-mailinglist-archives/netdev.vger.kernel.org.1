Return-Path: <netdev+bounces-263742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPiCEbYKqGkWngAAu9opvQ
	(envelope-from <netdev+bounces-263742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:34:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDA1FE696
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C5693035E27
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4663A4510;
	Wed,  4 Mar 2026 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="v2rTtyqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E693A4522
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620463; cv=none; b=UNt2qbZiRGISw0VHcH4CHXoW3QVVOHXymw2bQvptcPXkLqGUPMHnZ1Q9FZKA4Pc9I2I8giavI1t/UrWX5vI63Kb8HbcOuadg1RMitFMVx+HLl/tertcSYyVruoV4gcVu4kv6SfMjue1tdjFrF4dfzERRzYsM5/r8/m4RQGFn99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620463; c=relaxed/simple;
	bh=rsnQDpKzEj4Z2yTxDa6CF8A7GwiuAZWpSeFHHfKXoIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD01rTqz3HlR4hPZgAEN7+Q0OMz/B1No4vFTTdziH8ie8fe4GANY83/oJH6m/vbPm0IpPsEw9UPgvii45UtkxfEj9aKHOykTe8IaOlwm+EvM5zNeOisEVwIS0FS90wxommtfMM9pHo3/DIsfLcDJgiOO6BaAkZuHf7c6dDjKt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=v2rTtyqr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so76057935e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772620459; x=1773225259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32nyzB5LhHXwJ+wC7E/bptZjPbk/YG6iOgM6+tf22gE=;
        b=v2rTtyqrqtUBZRZMayOIVCD6cb/dRadEr1ZBV+xfFXusUUFhTF3mrzfOOrD7c/opYZ
         YQgH0hqbWZKce4PpDbXZ8a8RwGDvrG2M64JofNhHGVUMfdTPYUYdK8tu2d2PoU2Ytkv6
         LxVxw/wOPG6Q68agLIzHmXKpat2iiGwS7W3V2vTdOhR5rF2g78dN4Bf0MSsOpZ4KidJ8
         EVzwdyijcHyYft4V3uwpiy3hlz85lFcUsc56iWsFje+KBd3d3vC56CT2Dn12nL00neu+
         /9KDjPoQY3dgsbyjB7uYkAnKpdBg1V7V46rOb7ItSsVB633YyHNx0zo4R6evplg3NNTC
         RQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620459; x=1773225259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32nyzB5LhHXwJ+wC7E/bptZjPbk/YG6iOgM6+tf22gE=;
        b=ia8vhfItDesX2bE+jEcYQJHjtUYrlrj5ctRAE7K1CdV8ZqUK3R20eXgvqEKP3ubKMm
         lrNV3XFjtTA1yI6U8dgxr8oDo57GGP4adMNOVLlHV8i/o/twj421TvkGDeLtKnK9Ep5i
         ArqzSYEu4TpxkI8xGpss2mkmjcFPh9zFsQFDI5rYngb9r4Xbdd3kVPKzl51h+9laah4w
         Tdxh4VOboKjadn5zNh/u3vQKwa0Isb9kpw+yMN1C+STciCH9Lzn58Wk6DSljW8eSwMWA
         A3hCeH/WHPHk1zx6UAJJiXwrDBKXip5ZJ+/IhCaJJd+MDWloKDk4dr7t153M/AVi+uyT
         QXbg==
X-Forwarded-Encrypted: i=1; AJvYcCWeKpF3EeGRqQMWemL63Bp6pLIbzIFHKbS03g+3hp9+lVmllYo29C5syO1wz2J/t1ptt9nPwv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Hz4tL66al5uGaP2P1TP9rT1Cjd/Of5ITsRlpqtxa9Ghw3m7n
	fLMq1/KdvLShIfaxGyYoPpi/pJtMXEB8PDAQZvSeOkewjFvxtmi+D9weeyoS5wg/elk=
X-Gm-Gg: ATEYQzynd+1WEQQ3q9AcsRKikXDGtmj5EETrIjjEPzxMfzba/yTU1jVy/oMFu9tiTmm
	hstBQyM3D61HD9orMGhNGqCDSNBMJfj3T/SyOOCKpREKmaS5uTqQllyaDOaJOrgtBs9vlhGeZ8H
	hEpMencDk4NbbXjcZboz06c3gX7mGXDQdz247Vw8IqR7UUWwDMLuSu5Xt44wwaXW+SI8VLq42Vh
	y/PifDdG30dq4Lv6s9tk20q22L4qKjNJOOijbgmDFZ7W9AjdBOWmoqbB3WQwt3yuqeLTbxuFrFj
	5lA4N/nX2m1wf8+rtv4XZhSd51bmxxeo14mAohs1+qW37uDJatpq5r08eAse9wkqVQRK28UMKYH
	7W8ahJELBEiFxzJbAwemKPcXZZ6LYs1F1eBrdFczE6l0bYEeiAOMGSG7CkfUiqOwz+dzoPpPpkW
	lv51r4XaSHdQKi1Fb3w99Awi8oFXfDdwk6Rg==
X-Received: by 2002:a05:600c:1e2a:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-48519848388mr21825225e9.6.1772620459148;
        Wed, 04 Mar 2026 02:34:19 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm41054094f8f.21.2026.03.04.02.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:34:18 -0800 (PST)
Date: Wed, 4 Mar 2026 11:34:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
X-Rspamd-Queue-Id: DBCDA1FE696
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263742-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Wed, Mar 04, 2026 at 11:05:06AM +0100, jiri@resnulli.us wrote:
>Tue, Mar 03, 2026 at 04:26:40AM +0100, kuba@kernel.org wrote:
>>On Fri, 27 Feb 2026 00:19:06 +0200 Tariq Toukan wrote:
>>> With this series, users can query per-port resources:
>>> 
>>> $ devlink port resource show pci/0000:03:00.0/196608
>>> pci/0000:03:00.0/196608:
>>>   name max_SFs size 20 unit entry
>>> 
>>> $ devlink port resource show
>>> pci/0000:03:00.0/196608:
>>>   name max_SFs size 20 unit entry
>>> pci/0000:03:00.1/262144:
>>>   name max_SFs size 20 unit entry
>>
>>Code LGTM, I have a question about having a new cmd, tho.
>>
>>Does it matter to the user how the resource is scoped? 
>>Whether the resource is at the instance level or at the port level?
>>
>>I worry we are mechanically following the design of other commands.
>>Since the dump handler is new we could just dump resources with port-id
>>there. No existing user space may be using it. Alternatively we could
>>add a new attribute to select a bitmask of which scope user wants to
>>dump.
>
>You can specify what you want to dump with dump selectors. For example,
>if you are interensted only in port of specific devlink. That should be
>enough for most of the cases, no?
>
>>
>>I have a strong suspicion that the user will want to access all
>>resources of a device. `devlink resource show [$dev]` should dump 
>>all resources devlink knows about, including port ones.
>>
>>What's the reason for the new command?
>
>You are right, one cmd would do. Good thing someone forgot to implement
>dump for it :)

On a second thought, if we merge multiple objects into one dump, how
does this extend? I mean, the userspace has to check there are no extra
attributes, as they may be used as a handle to another new object
introduced in the future... Idk, it's a bit odd.

