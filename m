Return-Path: <netdev+bounces-257504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CkXF3W3hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:42:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C03FC2B3
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC614305ACBD
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB235EDB6;
	Fri,  6 Feb 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O9tVlAas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088335EDBB
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370622; cv=none; b=anNEbd4BT/KQe0xHynqxr/ADyv6t+AeHf2qUdOP71zwFMJ94DSZJL5F70dp3uV0AvuTPN2mH3BOt5JY0X9Fzm0supMWIbM6wYfsioRZc2xspo8wamwT2OYyDXcmg/eGmXuMZiUr1nLhFOCQu0sPPc2XxfD3b88yKT2v1nRgomsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370622; c=relaxed/simple;
	bh=PW/cUZwzFiiiVYrbjLi+IZRoi6zXuNxLhvfj3skBHOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLndMjLXlxRkIN3hA7bjR3eBZOUq3ayoDH6i1AEIQquLbaA4w7qsrdcTlu/fG8VsKSSgPErNshhtfgmU/1/pCRQmepEeM5c23wF+7esUsZdZ2v6xYGciJcU+SMZ9qcdNIU9xg2nFAfyrwqdIrwhUkSCRMqjUIAUD1vaew4Dz+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O9tVlAas; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so28132765e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370621; x=1770975421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW/cUZwzFiiiVYrbjLi+IZRoi6zXuNxLhvfj3skBHOk=;
        b=O9tVlAasfC87pV8+srE8Fnp7LzWL9qTDXNIdbHPsDemn04UoLuwt75lx1yjKaejc/D
         3IVAxkmeTjbWhCkwjvVprBNN7oHGz3yGjKohL6nCGX/LRP5XxdF/jsP9b4UIrvQAswEB
         v+r5JULntlZ4PPfiI95wnJXH17mkmS0J6Nm9NkeMeBpyBxiJQsjdQTLhO103M0JcpquT
         YRlMWhJ8yLc9p5DLqqAy6GLkd+4/LisZLRfdkO/GBx9rGZ5OZXIKK2/xejfjFNZix2lC
         xLlCuTEkuN8NX13FdtB7mjhCklPmZoHSgHs98HIQQjN9mE8KDkUDyWdEqex1uQDS+NRa
         mpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370621; x=1770975421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW/cUZwzFiiiVYrbjLi+IZRoi6zXuNxLhvfj3skBHOk=;
        b=kUoKW1irKZEIZ8Ss8ppzpjmLOppiqyLJ99OdqHwQLYcTNaHCNCPwFcmNvvcTPQ5+oU
         wPfwOOCVSicY4t+cLtfxcfxpg2dyda33TNqL1DRe8dfVlNuP40+wITR1g9Kg7ZSNG36o
         u/1JkJ2kpuiWKxvL9u4l83F7uSOfAX33aJaM7jOO1CPGHOClh0lVmwzTbzW0wsgsBUb3
         4AHoiCgMViDtcvZhZr5kUm365i6sJ44GEMRpVU3zeaUn0E4P5lSZ4tFrG9PlhTivNBUR
         h75jPuR2doMc+9mfZd2eFYtfMXGjMfeEjpg6taYI5pAb8OHfVLwbOneY4MYL8OzpSWlc
         ZLCA==
X-Forwarded-Encrypted: i=1; AJvYcCVn7EcLk/1E3RpcseYNIpGWapCd/qD6P1T0a4iZz46DzS26Juc7yHm2P0wdEySw6lmzF2xvTdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFeC2Q5poVCe+FfTIOGzI1OFK62NNsm3Z/nodYXKMdd+1wLIv
	uybnu1lROASrwWcq8lLb3UuAcUGK6vZ/qcVVOg/arRrTdGo4tgV89iSTBMj47fYUUyc=
X-Gm-Gg: AZuq6aIAasys/jCzQM3e30F8l13xUXD4s2GZK8sQt5Iz9yoceJSkVeMsnyra144PhTK
	+r3JhcfAfc/6UM9T9vsfek91j/P01C9tdGOKndfYejmTHGQq5OosYMhG6N5zBhuFK5VNdiVe5Ov
	e8eDWo4IRgu+ZcE3fCr3O7cK2Z17e60rrXNgiB8Vvu3DV3xtnRtvC55VciAEQVGtm2XXP5jTvuX
	XcZjC5NoRFcZmCuNfdpNEs0ypbeUR/CXPBaDohfCjjdt9BEqyCTOyqdJoYloANTmJU0dlTWUZNP
	Ztwp45Ov0WLj9GtqvwpuKEzI6a96JtJIyRdTjQwKN+Q3IheRiFGGg2npmHLcRg6ZtbjIHPZ7CHj
	Nh9fERqG3vHbpg179Qy/R0EPh52dX5ryiN117KlOjqlhKaOBquXciuW3pANpEov59xaBo5ZYZR4
	WexYUahJfYGVHSwMfgxALtlL239RZhMA==
X-Received: by 2002:a05:6000:2c08:b0:435:a48a:123f with SMTP id ffacd0b85a97d-4362937b167mr3578107f8f.42.1770370620697;
        Fri, 06 Feb 2026 01:37:00 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756b0dsm4020062f8f.40.2026.02.06.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:37:00 -0800 (PST)
Date: Fri, 6 Feb 2026 10:36:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V2 5/7] netdevsim: Add devlink port resource
 registration
Message-ID: <vtlfg47c7tme2stoefit6nws5fhxhcyx6uia7pcbqvi4xenzoj@b44ivjpnwzgx>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-6-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 05C03FC2B3
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:31PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Register port-level resources for netdevsim ports to enable testing
>of the port resource infrastructure.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

