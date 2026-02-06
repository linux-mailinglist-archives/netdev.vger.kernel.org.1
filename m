Return-Path: <netdev+bounces-257503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHBAJTq3hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:41:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC16FC26D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D59673049941
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008135EDC1;
	Fri,  6 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zVTY/2R5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909735EDA3
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370595; cv=none; b=LB0e/J+mKE4MGRZMb5XAHp/wrQKRRk+2m5RmpiMDpZLdLnDqMtOg/J3OIxG/qidsnl4YGmxNZzHbdoO6pbhHUXeG5vQwCUCvuUL+NQYWTdSdjrkG0CespOAPggK3/z39PPsx4LBS7mSyum0mO7gCHrQVK5WEh2ZTkxJcArxvkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370595; c=relaxed/simple;
	bh=Lv8uI95dliFeoBdCejcOMOusz6kZTyerXTknQcwPhW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8PmBdlncMPGvx8dtG9x/ICWgGRPCIA99VkyeI7N+2ptajDeu/K2VXjxOjXbDohErm7BvzoewoxgZ5hSoBilgus2J+x4jdfywLL/31ScTpjhHS4s1Pvld7oUrpAh6Z5tRUAxHnp+uGFJssHAQmqUX682muPttvkZyIbHhEngLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zVTY/2R5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso16358065e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370594; x=1770975394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pF603AUQdiALGLuf8FGVmdwSpRghR2h7LwnvgLtFhUE=;
        b=zVTY/2R5AWD/9OiCCPIkxL/zp7SyokQsb3PgBTPTL2nJLbxeNJTyAYtMaAKiMr9XHl
         1MsawKAON4NOvrcAAKX27jySAT3eYHoXj1rh8Z+naXele+Ukxa3e48gqt+VFJDdbV2gl
         D+MEEPw6yDZ82N7IOvbnlhsHUram6127pRDfoY/cWN6OP+LfW4XBKJvCgXptTNRsD7F1
         p5KxChnzmVuHAtzHXtUq/+oSlE4mdhwj+mZobui2lJ59AggOXLIL5eiZtU1ruGxYZdOA
         +DnxcbrRkwSIQNlf6sxJzv6TXC13VLUfg0gygzAxBbippCOinkjb3hbAU1giZVR4VPEO
         JVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370594; x=1770975394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF603AUQdiALGLuf8FGVmdwSpRghR2h7LwnvgLtFhUE=;
        b=jpSH7tHa2w1745LNW/7QvC/aVT2ZmVDpEI7rJ2uTRmlnO2djBI8RRsPezOXcS9ClWr
         lBrUPMLxwvgEetUzha9JW9Ya3RV3oOEHSf1g6hh3J2JQisrljqdDO/IhXPhhRqisD4M7
         B3n7Zl4Y47CaqB9E9HvBOTxst8uuTBwHBCBqP6IVWwEOwkHg19FnAVjIB+6rih0PmH4u
         54yMpEmB0wkaMnW224ZL8ENHcll8MpD1jgo780KX+hBRSIjXmCoxL+vGHvTlOEgDcxc5
         gGD8SixpAoGS6VdposT1BQbFgDcHFZNjZBN3XVXRFkZKZpN/P3b58DzktH1Sp3986122
         BFEg==
X-Forwarded-Encrypted: i=1; AJvYcCWLRQyGmezfFrRu2p3CX0AUaiohiIItX6cjACUg8/Vk+9Uj8cVCqUsFkjJxD2BqZEl9FnfVNZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4odAQfRTY+JgsLWPrV7WtHnAJJ0/SZMgWjppHdszevc3IO1v
	oHYvnQ4vIOEsPkVVKlZXkf6hkfkTXZPcScceHmADP66hSG1upFg+1nwIUrfmuESA33s=
X-Gm-Gg: AZuq6aIqp90ggUYZxsmkFTVj/aRUYUxddM/FBDhgYihqxYnmwAmS4BJI9LCmUCEt0Im
	pJW/Z8x7cyeB2KGJU1YrDmdvsrSDcIXcPqH6GUHBm8SQAJWvaV3QsCBLMLr+Zh6PJorHnEcyq7+
	FXm5Q6YGtYXcOdCMAsRHIgxsquFK0pVMA3c/62guvGam6lbUM+Gx8wvfpWfqaGU0X77QqvIbTEM
	6wWyWBcXz624+beDpUcy72dQ6HrJn82vZUxYCAAXxfQidzC5mmcn0zm/usAUeWGZjO2Jjqu2vtO
	ucHx1HaOL7372nBFMHYuYv/0bsgqVMPgOQhLaSAxFNdvdC46QlbC1Q6eTNk2qU7LVOECNiMrpcq
	cgpGaE1YITTTMrtK6KTdT/0D7Jn4leoU1xRGATRpjQvMYYm6RCwhPDbUHnm+xAa0lL0ehwmd24q
	qU5l/DXey5vKgus3XQDED63syuz36Rsg==
X-Received: by 2002:a05:600c:4449:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-48320216075mr34903245e9.17.1770370593702;
        Fri, 06 Feb 2026 01:36:33 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm147111195e9.0.2026.02.06.01.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:36:33 -0800 (PST)
Date: Fri, 6 Feb 2026 10:36:31 +0100
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
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: Register SF resource on PF
 port representor
Message-ID: <kmoeavzguajvf67sjwxkh4x5ogbus3cigeatrstagbfcyqyka6@w5ufzb5brkst>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-5-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257503-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCC16FC26D
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:30PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>The device-level "resource show" displays max_local_SFs and
>max_external_SFs without indicating which port each resource belongs
>to. Users cannot determine the controller number and pfnum associated
>with each SF pool.
>
>Register max_SFs resource on the Host PF representor port to expose
>per-port SF limits. Users can correlate the port resource with the
>controller number and pfnum shown in 'devlink port show'.
>
>Future patches will introduce an ECPF that manages multiple PFs,
>where each PF has its own SF pool.
>
>Example usage:
>
>  $ devlink port resource show
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>  pci/0000:03:00.1/262144:
>    name max_SFs size 20 unit entry
>
>  $ devlink port resource show pci/0000:03:00.0/196608
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>
>  $ devlink port show pci/0000:03:00.0/196608
>  pci/0000:03:00.0/196608: type eth netdev pf0hpf flavour pcipf
>    controller 1 pfnum 0 external true splittable false
>    function:
>      hw_addr b8:3f:d2:e1:8f:dc roce enable max_io_eqs 120
>
>We can create up to 20 SFs over devlink port pci/0000:03:00.0/196608,
>with pfnum 0 and controller 1.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

