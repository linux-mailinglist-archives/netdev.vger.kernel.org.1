Return-Path: <netdev+bounces-63260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC382BFE3
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024E61C22950
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D459B4D;
	Fri, 12 Jan 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="unrzj1Yx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC759175
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso72929621fa.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 04:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705063335; x=1705668135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QO513bJXCQVBbCzTDvT3IK5YyflX0UfhneENDHId1hw=;
        b=unrzj1YxFn0VvBXayR+sSH/XVajuoidFO2mVr9MbQEmyJKfBq5SvnLYvJWiuxI5um4
         lMtuImpSa7g6D5nYLVEb/0x61FpeU2MNmWwUzviRIl/c6KEVTBDXFEyn6AJ2CyfykpfP
         tSx0cYkYI+2wUIQ0kCEb13vD5BwdvTdC0nQD5td1nS61XgQrzTVTtDrsp8aHB5U0vntp
         CiRox112JpdKTdlASt+7TJKHCWcWUknoQMGJED6Je7IufO/PBfNN78i1xTtVbBeN08lo
         /uy2hhH52/nDutT8hPXIvNkwQti3x8ghpTaO0JC2CDFKXLjDX/TMBFQ1V/2ed8/h/o+r
         x9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705063335; x=1705668135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO513bJXCQVBbCzTDvT3IK5YyflX0UfhneENDHId1hw=;
        b=Yi57NDGqF3SvJd07MfSVZoYbCqvgSc3O4y4JBnenElM0ZPQNOUOK7UQiE7k+Q7Sp3R
         qeAeovD45tv5U2GbJnzLr3jyDp1BL9tpgiDJRqfU12OEgGgBuDzXOzxAgAHG0N15Qlm7
         6m5wJ0VyZ+t2UkyfsYXAWvh9PzXnbo4FocBritzIa1mE1YCJ/jYLW02zSsHIifyV82Fa
         tw7JuGTbD2LSH/aGlOWhCK2NAtGQ5wB93JZx/aXzoi50KBoWCjyu/XGbg928VsTN0Bhs
         LHjW41AoEA9W1SisYuOSi9g2yVnXuyqwarfELPW7GNRae/I2aa6flarCAm+9De8twoSG
         +eKg==
X-Gm-Message-State: AOJu0YxPRdc1F4/iHHsXGbuhty283dCMvlYeoFXH95ru7mNJKtDdqK6Q
	AAq4T37jod6v2i8mlrQq3e95OIiOJ1ro+UYImn+HiE+Bmb8=
X-Google-Smtp-Source: AGHT+IG40Kj419k2cCj4yK/lEo2EiqUDJ6T5VZceRICrbnsCR676kdVL9ZClpL/bcvpD5E5WsT+etg==
X-Received: by 2002:a2e:b784:0:b0:2cd:3fd3:4541 with SMTP id n4-20020a2eb784000000b002cd3fd34541mr343445ljo.60.1705063335665;
        Fri, 12 Jan 2024 04:42:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ef5-20020a05640228c500b00557d839727esm1756186edb.7.2024.01.12.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:42:15 -0800 (PST)
Date: Fri, 12 Jan 2024 13:42:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/4] man: get rid of
 doc/actions/mirred-usage
Message-ID: <ZaEzpWaTLDG6Ofby@nanopsycho>
References: <20240111184451.48227-1-stephen@networkplumber.org>
 <20240111184451.48227-2-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111184451.48227-2-stephen@networkplumber.org>

Thu, Jan 11, 2024 at 07:44:08PM CET, stephen@networkplumber.org wrote:
>The only bit of information not already on the man page
>is some of the limitations.
>

[...]

>diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
>index 38833b452d92..71f3c93df472 100644
>--- a/man/man8/tc-mirred.8
>+++ b/man/man8/tc-mirred.8
>@@ -94,6 +94,14 @@ interface, it is possible to send ingress traffic through an instance of
> .EE
> .RE
> 
>+.SH LIMITIATIONS
>+It is possible to create loops which will cause the kernel to hang.

Hmm, I think this is not true for many many years. Perhaps you can drop
it? Anyway, it was a kernel issue.


>+Do not have the same packet go the same netdevice twice in a single graph of policies.
>+.PP
>+Do not redirect for one IFB device to another.
>+IFB is a very specialized case of packet redirecting device.
>+Redirecting from ifbX->ifbY will cause all packets to be dropped.
>+
> .SH SEE ALSO
> .BR tc (8),
> .BR tc-u32 (8)
>-- 
>2.43.0
>
>

