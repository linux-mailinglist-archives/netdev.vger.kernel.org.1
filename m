Return-Path: <netdev+bounces-63261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0D682BFE5
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB70286285
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C7959B4E;
	Fri, 12 Jan 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wug1iJFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229659175
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so41426015e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 04:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705063489; x=1705668289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czcMjMUg2ib3hdewzrv1gFcztYQg7kCDF/UCIJRPrpo=;
        b=Wug1iJFNVn6vLrsZcWM5j8FuYGj0b5CBH7hRZhFaj04LDLhYnWjLBD4NBq0vfgI8cl
         TP/Qf4w5xu8GpsAuR/B4WGsmosfOtZ/0b4bslNWP0ejIHPtVtYsUb/qaby+MHRP2vuHS
         jnwbSqYhMSGmwbk+TyGHbSUEFRBC1msruRPXajoDKT707iegfvXesC4wg01NUItUVkGo
         dbYzEhvvthFo1VldUetsTJqN157lzlDm1VknZjhjkqIctXA3OryoWXxmE6iTuk4+mhmG
         DB1LiRsTfY6xmXXrJUlN+KMZfVSswfQSKkUzUEjCUVXQL5KPofc+RAyRLUBwG2yqtM60
         Z1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705063489; x=1705668289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czcMjMUg2ib3hdewzrv1gFcztYQg7kCDF/UCIJRPrpo=;
        b=HdNAvdOmYUEjcuO7gOFbR0XbB2Q1DuVb66nanqVkJUUIGtujfuWxYR02L6TnB9ufJs
         ulj33ga2eMayls2kAGYy9GWyiWT3gbN52kjoVHSacjkf2/XOWACaurXavE7WNLj6sA71
         I+M1MBo82T+gVqGiX610NjTzbVLR+1T7yon3es4fk+svA6ZlcRaTOtkDOaAkuu1HqwrS
         zG4MEyaG4NS5alXlfpGepYeTSgNlcmTmBM5D9p1MkDEIYGlr9r94v1qngBq8d4ijUtV/
         6zqBHIP8X2frPsytiXy/t3c7+M01kZHnfJkuPmJ5mA4AotGjaBhVeULhwvH6ZWOi16b1
         teaw==
X-Gm-Message-State: AOJu0Yw3fDAR0aimtN1WlOWAkO3UrylUu7jXYjQUMKTc84GKDpvjXrco
	CSC2xxuVNlAGC8IGVrz8DN6z5u3eg7KXJ6ARGZZDuXTYf94=
X-Google-Smtp-Source: AGHT+IEBED1BTenAUk/jmieG9Zdz6T4qQZ8cA7oWUKlof5YLB+7pKNeUWnsJ/VHoZ2B8VmQMbpKIAw==
X-Received: by 2002:a05:600c:164a:b0:40e:43f5:bd33 with SMTP id o10-20020a05600c164a00b0040e43f5bd33mr836731wmn.77.1705063488854;
        Fri, 12 Jan 2024 04:44:48 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e486bc0dfsm9663119wmp.27.2024.01.12.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:44:48 -0800 (PST)
Date: Fri, 12 Jan 2024 13:44:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] man/tc-mirred: don't recommend modprobe
Message-ID: <ZaE0PxX_NjxNyMEA@nanopsycho>
References: <20240111193451.48833-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111193451.48833-1-stephen@networkplumber.org>

Thu, Jan 11, 2024 at 08:34:44PM CET, stephen@networkplumber.org wrote:
>Use ip link add instead of explicit modprobe.
>Kernel will do correct module loading if necessary.
>
>Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>---
> man/man8/tc-mirred.8 | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
>index 38833b452d92..2d9795b1b16f 100644
>--- a/man/man8/tc-mirred.8
>+++ b/man/man8/tc-mirred.8
>@@ -84,8 +84,7 @@ interface, it is possible to send ingress traffic through an instance of
> 
> .RS
> .EX
>-# modprobe ifb
>-# ip link set ifb0 up
>+# ip link add dev ifb0 type ifb

RTNETLINK answers: File exists

You can't add "ifb0" like this, it is created implicitly on module probe
time. Pick a different name.


> # tc qdisc add dev ifb0 root sfq
> # tc qdisc add dev eth0 handle ffff: ingress
> # tc filter add dev eth0 parent ffff: u32 \\
>-- 
>2.43.0
>
>

