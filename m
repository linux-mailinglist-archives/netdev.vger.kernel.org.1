Return-Path: <netdev+bounces-63316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C382882C44C
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D0B222F0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAC1B5AC;
	Fri, 12 Jan 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="P/PBMVno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897D17C78
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6db05618c1fso4341468b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705079357; x=1705684157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/vV065I3azgsUBonv/9Vufk2Ogb/tFuvSXrTyXyD+o=;
        b=P/PBMVnoLshX0/SOcWT/gwEi7tp0eCOkzfSEOCQyiZgYCNJHspTR8C/gpzUzPy4OoI
         PfQGbOx28j8ce69u1Yv5v40oieg6cVtmQrJQXGKSu/LSBXBRixxBDbmDZBamL2LiDVZM
         sxrmtmiV77/JO/ZK8AKR+vYH1YMmbqzJ2Ye3+di1WNQJZ3Uamo6JqeVTwPyNAZ6ZRnn8
         9fSMXMP+yGzQSyLZBp2O/9D/iYBateGyYAub2BAsje0I3MERlJyvs84EvKnz4vuJYbVU
         7fb4t61SDb8SVSVahLeukAY1dPxF1dLxXezqjrhEZm7Bo2Rq3ZaNfyilTdCo0Qnl1HE2
         U7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705079357; x=1705684157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/vV065I3azgsUBonv/9Vufk2Ogb/tFuvSXrTyXyD+o=;
        b=DmmVptqw2sKtuSlop7W8und/eCj+2cMGmjhCQTW/1lvXH1Qg0JzrKmd33H9Kc6MuAW
         ScpOrvLq6DjuxmCx24Bbw9hIg9ekl0fCA9XTVFcMMCUlow1nNwQK6Tit3/rh7V6QxhAD
         bY40d2ZVcpOrc9aLYfriLQ4qEMUEBvNInLqY5mKwDN+Zm06cB4iY+cwpri0oWAauiSa/
         kcS/9KCb6cAfgelzYNfiN4H7887BHxqs9ooFLdTyXLYqUCOkziT7t9c8lhIdc+pSWqbM
         34UF2+4jKhhK1k1y8SOZc8hK2eS6NqhAtMf4m8zsazPHzQqvwz6z8t5EqdqSlS93Qkfw
         oc/A==
X-Gm-Message-State: AOJu0Yx1od32D0Fst41anCcntQRjqqyz9sQo6HWEytxBZiVaFWEHXF16
	M2ba3xOkDOD3teSRuSCeuAXXE8vfQazh+o+PeaaDdAWoOMm9zDz7
X-Google-Smtp-Source: AGHT+IF/k2+cDolUSHitg3txVf8ffTXZLdONWTC37iTFveblewxWnXD4xo+b7/j6qD+r+ZLsdb0mZQ==
X-Received: by 2002:a62:8406:0:b0:6d9:cb27:e47 with SMTP id k6-20020a628406000000b006d9cb270e47mr1290011pfd.18.1705079356965;
        Fri, 12 Jan 2024 09:09:16 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id lc26-20020a056a004f5a00b006d9330a934dsm3402480pfb.64.2024.01.12.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 09:09:16 -0800 (PST)
Date: Fri, 12 Jan 2024 09:09:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] man/tc-mirred: don't recommend modprobe
Message-ID: <20240112090915.67f2417a@hermes.local>
In-Reply-To: <ZaE0PxX_NjxNyMEA@nanopsycho>
References: <20240111193451.48833-1-stephen@networkplumber.org>
	<ZaE0PxX_NjxNyMEA@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 13:44:47 +0100
Jiri Pirko <jiri@resnulli.us> wrote:

> Thu, Jan 11, 2024 at 08:34:44PM CET, stephen@networkplumber.org wrote:
> >Use ip link add instead of explicit modprobe.
> >Kernel will do correct module loading if necessary.
> >
> >Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >---
> > man/man8/tc-mirred.8 | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
> >index 38833b452d92..2d9795b1b16f 100644
> >--- a/man/man8/tc-mirred.8
> >+++ b/man/man8/tc-mirred.8
> >@@ -84,8 +84,7 @@ interface, it is possible to send ingress traffic through an instance of
> > 
> > .RS
> > .EX
> >-# modprobe ifb
> >-# ip link set ifb0 up
> >+# ip link add dev ifb0 type ifb  
> 
> RTNETLINK answers: File exists
> 
> You can't add "ifb0" like this, it is created implicitly on module probe
> time. Pick a different name.

Right.
Looks like ifb is behaving differently than other devices.
For example, doing modprobe of dummy creates no device.



