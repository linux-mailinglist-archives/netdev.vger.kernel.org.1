Return-Path: <netdev+bounces-284914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBObDrBc+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A34DD1A6
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B19B30041CC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1C48166E;
	Wed,  6 May 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="q1H8/0zx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523E48C404
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080936; cv=none; b=iIZvAtVNoDXSAoYb6oCfv+91e85jCJuDyKmIMtfMqgTm+WdcluILWtgu6Yzq7zn5HdTgJMRhlcPL+vHVuo/0p6u/12EJjTadVn2gscbIUIpNc/uybPRHOwEFm/KGvy3QkcCCsZXTCKZ28tqJropAB7vbGmPanMnNga+zw+padUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080936; c=relaxed/simple;
	bh=PZt87gsUS+Wgo4zfaqwWXZGdWegl3vlb2EK9YGH238M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnxQhugULHrrB1PrQoyrFVaDNw4S4OEGNnLN67JNUvuwp+8ZT9fljkTk/8S7Jc0ENDWy0EFsn0H5EL4rIqY0s2Z4dCv5d4vatOGAbxOdfzgTKjNZIdwN0jEseV7nHk3hVLFe+PtZcL78BU1oF26lMPeB/11ErJQbwSkQtcfjRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=q1H8/0zx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso69525355e9.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778080927; x=1778685727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2otLqzL5UIwKJGEw7GU0/viRo2RnqRLXcAGMdCXHaA=;
        b=q1H8/0zxTASA4aBVYQKqHcEePfrxTpKDgm7SM4meO4nF/VtG5mRlWWg769m8cnyJpd
         UKNz0ti95hz5Bp8K+souRyejdRtmHNS5v/W9vE8bUi32krABp1iE1H7lxsuJxUzsBerh
         oiYYHm2yR0nkl5on7Xm/zqLTaXq/J7M0OsyhmbiAMU6UAK/4nKNXeKzltC/Gcb3rVCcJ
         ixD3vYj1DoWgY1/D+fL+q2jPvmAKkFI5J0lxZVxspIWkF2hn2cjNinY4QtKlPcW1SfZ9
         OqzVonpDqa323pF2Cvjpc0hKhy+Q3syiuJD7ZRIqc9mudLk7m7eyDQ8nAyW2eF1t4/pu
         zm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080927; x=1778685727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2otLqzL5UIwKJGEw7GU0/viRo2RnqRLXcAGMdCXHaA=;
        b=nCvA2OGodQHMZszfw3DNUS2JbEwR03y58NZZmic/Nx66NZUjbRa7fUPlrygbywQH//
         dYWGQ+KIAqIL3X/gTXrLM0EgR/0DDTFW7AiKFfe3M56BeAznAe+YI4IJzwdcax+jtRx9
         +AckPdW93gyEU2ZfW5JKTFA6Es6jPIalvFI+1y1eKy0JJkNVC3dQxudGQ2vHGSoDTs8p
         hurSC3P6QaWW+iRPUOy4zM6kmst+mFC9l4PUKEPI5txzPDMZw/vA5wSS6wJNLmoyNX0A
         w9LUxO5tYdWRDaUZqamPFvXMi3raoyAJaUPuWXkssbWjhG5i5qZq/vl1wD4golyLS+0Z
         9DJg==
X-Forwarded-Encrypted: i=1; AFNElJ9KceSyLyEPG51BaIbS/iTnhdBPo8SL8LB+Xn9UdOZrExm3Nc3AwDUVzkz8RD/aymjEgB2yILk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCDIx/SzAiO1n3xwQ1l2QuDDDwbUUoTEXvZLdewvwOzrw/4mp
	gq7CIoImrcC+9nIh0yx3WbE6Twb0GB/GwvMJ7ZSPXCTkPfcPe/Ux/RTtjPYcRAldNp9eyvvyDPP
	Ngnu3iHQ=
X-Gm-Gg: AeBDietLWwv8nsJsouM1HI0y8gAD6p5fasL9jwQWtDybdczQCUy4unfRcGcjrcGaUff
	hAg0A9jzJMnEd1b1rYbBLYVm0pwnRxROJI+iXybeW6mUsVYjQfIQIfhOs47E3auj+HGy1sk3uZV
	ZmBMJukhERLkTzHh7PcHjt/D1jHcpD5xUhhSMoMZ2I5w1ylx06zfP9UynoBuPpNgrkeS8q/gIbH
	6lzCh0BSDiO/IfhZj3RfRo2Mbchc+QCQeuhZEGZyc/ViCOKxuUznF45r+Y3FngaGxRGOQwAiqpw
	WMGTUrdjFUho3DkC5I0DTnDA+7MboDGzE3pj+K05ghSDGxYvcVQHNFzVre/qFlp4kg+t1Q0K4Ov
	rRKgimg2a7CcaCJFVqsqtleBhp1tO8nRruZSJs/FOxrcZM+QzDXu2hLBNouonW0mbpYni3bAkV/
	a2iHuR26x02/asNWFWt7e07pxyvkv9bGWxAg7FI5ouBVemMAaJuK6jbw==
X-Received: by 2002:a05:600c:a111:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48e51e0bb78mr54150665e9.1.1778080927453;
        Wed, 06 May 2026 08:22:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:8c0b:afdd:3d9d:e976])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm12838076f8f.0.2026.05.06.08.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:22:06 -0700 (PDT)
Date: Wed, 6 May 2026 17:22:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Christian Brauner <brauner@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <aftaW-irGmkfA7FS@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506123739.1959770-1-mbloch@nvidia.com>
X-Rspamd-Queue-Id: AB5A34DD1A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284914-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Wed, May 06, 2026 at 02:37:35PM +0200, mbloch@nvidia.com wrote:
>This series adds a devlink= kernel command line parameter for applying
>selected devlink settings during device initialization.
>
>Following a discussion with Jakub[1], I am sending this RFC to get the
>conversation moving. I started from Jakub's example/request and extended
>it to cover requirements from production systems and configurations that
>customers use.
>
>One important caveat is that the parsing logic in this RFC was written
>with AI assistance. I am also not sure whether the resulting syntax and
>parser are too complex for a kernel command line interface. This is part
>of why I am sending it as an RFC: to understand what direction and level
>of complexity would be acceptable to people.
>
>The implementation is intended to support the following properties:
>
>- A system may have multiple devlink devices that usually need the same
>  configuration. For a configuration such as eswitch mode switchdev, a
>  user should be able to specify multiple devices to which that
>  configuration applies.
>
>- There may be ordering dependencies between options. For example, in
>  mlx5, flow_steering_mode should be set before moving to switchdev.
>  With this in mind, defaults are applied per device in the left-to-right
>  order in which they appear on the command line.
>
>The intent is to let deployments set devlink defaults before normal
>userspace orchestration runs, while still using devlink concepts and

"defaults before normal userspace orchestrarion". I read it as config
before config, which eventually could be skipped.


>driver callbacks rather than adding driver-specific module parameters.
>A default is scoped to one or more devlink handles, for example:
>
>  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
>  devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
>  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:param:flow_steering_mode:hmfs,[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:switchdev

I don't like this. What you do, you are basically introducing user
configuration tool on kernel cmdline.

The same you would achieve with a proper userspace tool/daemon.
I did try to come up with it and push it here:
https://github.com/systemd/systemd/pull/37393
That didn't get merged for unknown reason, but the idea is sound. You
provide configuration files for devlink object and systemd-devlinkd
will apply when they appear. Wouldn't this help your case?

[..]

