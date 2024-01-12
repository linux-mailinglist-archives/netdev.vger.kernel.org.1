Return-Path: <netdev+bounces-63336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C5D82C555
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C3A283A00
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11932560E;
	Fri, 12 Jan 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VliK7r02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231C2560B
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28d61ba65eso797159566b.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705083696; x=1705688496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14b9T7PZxdbFdXGn+MH2oJNUOLJxpmLpLYeM7eBbetg=;
        b=VliK7r02DTk7i5kuVWvuEDn4KmavBw4zFW9efbDwnj7MVmtQFEloEm0tJ5XufJ3syh
         EddCQOcCcxiQj2UXZYGjAoEu98m7Kc5wbwWp2PgcNnaKpi35yoiXlPAWVQtwaOiYNfXT
         es2wqpkETDH4utOSo4mBTjUmPntV50UWr5lbs9PkKbJYTW4/6AMmYPQdNZov8G80LT9m
         ujV+ryU6N7cLCx2HkItx6A/IEu2FeJDdZTbPTj+Dyv/yIAfM/CbdXvB0V4N2HznmhsEJ
         jF4Ll/B/ePbI6Uu3RsaRHy1UB/MCY8rCnY8Q+nSOWQ8W2Jcv4JGgNUYmfGVAwfgFbza0
         B8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083696; x=1705688496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14b9T7PZxdbFdXGn+MH2oJNUOLJxpmLpLYeM7eBbetg=;
        b=FhwT+7M1ErY+jOm8qSQTJyIB9CVPLHowq9aanvd0FUuA6+wf/RdLDHtC7tQCGvHURO
         GM6uRgq7UZCSZrcjaPnunEUD6jVnmpqA0qDkc6kJBGzEDDlXhZGIf62exjB6lmH1Zetp
         PUjmDlhyw5jHdChW2vzKOlL0U4SHTrhmmEpJFMdNSfTQKWacW9UB83kQRR6y9pw4g1fu
         FWq2rqIVF30IR6C0oTY/p/aIyYdQqXbXGnX0T9O7isNdFycZEcZxzLez0zoyImeD2Fg2
         gayxcYNcV9T2nGzEGmjoL6eKwC9THbYl+G0C4/E++7iqgb4Jr0NMIDGCP7eq98AYAYMY
         bv1Q==
X-Gm-Message-State: AOJu0Ywp748TJrIjyx4okIrULDwm4abXMkmx6Fi4HWceJcqwlxI77RrL
	sRIlIP85SvQbhsO9BaXpKKzD6tV5QBNzs3ny0UUVemoKI48=
X-Google-Smtp-Source: AGHT+IHpgwGIw8umLV4iSqXUyQlN61/mtX485Bwjt10Z9Q23eBzb6XOV6Y00ForC0kzRNQBR75eDqQ==
X-Received: by 2002:a17:906:615:b0:a2c:8872:60d4 with SMTP id s21-20020a170906061500b00a2c887260d4mr653064ejb.22.1705083696336;
        Fri, 12 Jan 2024 10:21:36 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090639c400b00a27a766c6c8sm2047440eje.218.2024.01.12.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:21:35 -0800 (PST)
Date: Fri, 12 Jan 2024 19:21:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] man/tc-mirred: don't recommend modprobe
Message-ID: <ZaGDLociGHMaumZY@nanopsycho>
References: <20240111193451.48833-1-stephen@networkplumber.org>
 <ZaE0PxX_NjxNyMEA@nanopsycho>
 <20240112090915.67f2417a@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112090915.67f2417a@hermes.local>

Fri, Jan 12, 2024 at 06:09:15PM CET, stephen@networkplumber.org wrote:
>On Fri, 12 Jan 2024 13:44:47 +0100
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Thu, Jan 11, 2024 at 08:34:44PM CET, stephen@networkplumber.org wrote:
>> >Use ip link add instead of explicit modprobe.
>> >Kernel will do correct module loading if necessary.
>> >
>> >Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>> >---
>> > man/man8/tc-mirred.8 | 3 +--
>> > 1 file changed, 1 insertion(+), 2 deletions(-)
>> >
>> >diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
>> >index 38833b452d92..2d9795b1b16f 100644
>> >--- a/man/man8/tc-mirred.8
>> >+++ b/man/man8/tc-mirred.8
>> >@@ -84,8 +84,7 @@ interface, it is possible to send ingress traffic through an instance of
>> > 
>> > .RS
>> > .EX
>> >-# modprobe ifb
>> >-# ip link set ifb0 up
>> >+# ip link add dev ifb0 type ifb  
>> 
>> RTNETLINK answers: File exists
>> 
>> You can't add "ifb0" like this, it is created implicitly on module probe
>> time. Pick a different name.
>
>Right.
>Looks like ifb is behaving differently than other devices.
>For example, doing modprobe of dummy creates no device.

Older drivers did do this. Bonding modprobe also created bond0 in
the past. Now it does not. I guess ifb behaviour could be changed as
well.

>
>

