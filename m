Return-Path: <netdev+bounces-260394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILm5NdVbnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591C0183682
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EE4530603FF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502F364EB7;
	Tue, 24 Feb 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUdFB2nP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418B33A703
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920336; cv=pass; b=NEswkdmcUM4VflIyau7kjIvT7ewcy4vpcDSZHMR4W5a+fL6qR5JKZgG93cEb/LZV7gF6K3j+lgCPh49pg21Kq7gC4CuxQolqOFcsng2/VGSYNZeKleRWS3OItvjALFeRcDAGrtdvoyQz4XGeeJjVOYKvz/yIb3ZzWJqwo9PKZk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920336; c=relaxed/simple;
	bh=RiLvPWVE0XGnkXkU6LVU6jQZopUhaTIiyl6ToVdk6m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqMpVipG/Y5AGJlc6vh3It4iNYMPSZKQ/1BVjX3vjaYeq68HIYxWOZInkZpX2mM0QeGYakcUN+alOBarJ2E8as6RV38u2kgQ0TBce8x62q+9Yxdnf+Ml+PE16nkmN3VyCv5wE6PX1woM2VGPTxlDA6H076yFMbRpuBWhycJl3ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUdFB2nP; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso4942615d50.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:05:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771920334; cv=none;
        d=google.com; s=arc-20240605;
        b=h2grH6WkuKuGRWRWr7fS1wz5pEgLn601Q7zkEXUY1JvQ5BsmDqM4tjR1+mqoQVNDln
         w9nWSTn19OK2wO9LTMpL9pJSOMHdAaxeMkXlqyjrkExpyLUGrOscUmH7/Dg0oYhvQ3St
         qQMvZygR8lsTYDKJbW0xo/lbElFPYT54JnM2fRe0+FG4o1ydRBkevr1LzmFppsAwATSn
         tiuo1pMXWaTGXvp+t5b0C7xOLdWkTa5CXkNghNeqQAmUCJ4dwf4KWuAzkpKD1qB6JGvv
         CeRwaGQNweJZ55XDMsNxRbke92d4yxz86qF31grbfqzq1yf2f+BEc/XaA9TSce0nxzoy
         YSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RiLvPWVE0XGnkXkU6LVU6jQZopUhaTIiyl6ToVdk6m0=;
        fh=gHiFTUQDEWbeiYUbppHl3RW0cKUGWtzPdRhs8sdbaHk=;
        b=ej27vEPgrmz85sd8g92gfYIzg/atZWdzyCsNCuQiWatna+4FOXgoJLCYTwCg4JG00T
         VmveszrQlcaQnQGW4xSA8Pu8LvydU1s1nmyV4CaYSebFf0Z9ZG9QkYKsbfln9Jp0zc95
         kEooqDK4lF1GcZpobFOkAokx6owUGALQbk4BK24vvJe27uegXGyqegPWyjCY/OGSCDch
         giDUsYetWlyehF/JabXCPgaHhljUNXoxBUFJIXqTtI6hhe8D9daJifXKxdOZ2roxwGSq
         /weKnlTAAeTgZBXUNo431Dc9+HK4+x+0QVR0F7omxpjf/nGRYOsnqlsm3x3fl5ZuI8In
         iuLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771920334; x=1772525134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RiLvPWVE0XGnkXkU6LVU6jQZopUhaTIiyl6ToVdk6m0=;
        b=HUdFB2nPPiCS4Q4c2ztYcqHxSvL3NzRiBC0i41G1m1e80eWO58uobcDzNRF23RYpMo
         DypDxIIIdTHJEUahGhoDC99e0Tj619n2Oq4Tr7zwNCk4LTdKUoRVmm9dBPL4Ni6suAen
         OEX/LUFTCRdvEniu0+zsji3yvyrgryYEA3Z1wF9mFDBLhBtUJwDTwP3UzuAa4AP6Dheq
         8YiQbS7C7/bQKBJglxbjEKnCMp1Mt4zKlwSalFZHXW1Amlaxh0ZSCx8oPi9ANO29E3dc
         1vNDIGMDXZ4bEDLKDPviAs6P2Acpd6SK70HKV2+qyVyLgTX0IOQCIxjBBq51ttGssMqP
         gDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920334; x=1772525134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiLvPWVE0XGnkXkU6LVU6jQZopUhaTIiyl6ToVdk6m0=;
        b=flK0BjKqXZXfS5iHq2fIhAZESSHuc2ie2/s0jMk5rxDuEa47qhZ12+XU9ONd/IK4TW
         DAbLLlyDqTfXv/ATVvsznUgvyz6BUM5IeRoRvmDEtYoyRXIuV0gCBpVwfdhBkvSvTx2B
         dC2MDaq/IFUABCc9/g4Jasaw0qzBrMq7Oh6YJmYEewsUZCTt6Cti5KBUiGLeCNtGrOIV
         gNAyUv7QJ4dpWbwfnZMCokGqoKa3LvDA3WbZMUQtMzYSXwXgAluDgVx7Ig5s08ylHE3D
         urVkhaEotBYJHmPJBHbH0KCh3U0+fS2eu+PBSAxvPaLMcbqj0SJ+GVpx/EII7mGgGN1k
         HMhA==
X-Forwarded-Encrypted: i=1; AJvYcCWFK4RaEr/m6z+4su2HIhTeRVoWIPOJckuQ6qsrutqnHbmiKJ2KJTPAr6sx+HdYcZh1fCGb7z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBzNuk4io4lQ3vQI+VZaiq4HZESiufsMrqPkgRoS+eYX/6+gS
	uCfdMeRKi9h0XYM1I9qYQIBPuyBL/lj/iWiy8LgyldBqalP5eDi66XqaArJbLHAcR1QxbAhJsW8
	0DtMvTTkLxtxu3x7R+DttzgiO/jCDHQY=
X-Gm-Gg: ATEYQzyM/fWZgXN8D5ijk8vPQBSBBWQndgErM3UYE7u9vvDn/jvJaTN29zJfymMwLL3
	pgmORV0z166tr1zqpQeu6MYPkQRBxZ16o2mB4MC2x2t6XLdaZ/ZKg8aGueglmXTxPwm6IE0R7I8
	hHMY+MeJFnRWME3uGnZ7tJZGDU7t4MSdT7YWMJlZMxkOAxFDlfHQQu7c/YYwQaze3krkJrWPGz4
	s0obcARNg9+Q9qraKAyLt6EmdlJCMfSICLuX7oAYyYAO+Pjk8atTv9DgtpPOTyLX8yExBCbJD5u
	qObRmDizHd1crlE=
X-Received: by 2002:a05:690e:c49:b0:64a:e61f:a6f4 with SMTP id
 956f58d0204a3-64c78acccd2mr9210920d50.19.1771920333731; Tue, 24 Feb 2026
 00:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
 <20260223172214.5d8ddaa1@kernel.org> <CABFUUZEuMCYYfi-SapTLT1BhYOWBk1e-OYh+h9fOZcfoSP06fg@mail.gmail.com>
 <20260223185321.0f0581e6@kernel.org> <CABFUUZHb2R_SiiE_K-ixhjPVkvG4WWTjcOygAM-YBGtZ6Cnq_Q@mail.gmail.com>
In-Reply-To: <CABFUUZHb2R_SiiE_K-ixhjPVkvG4WWTjcOygAM-YBGtZ6Cnq_Q@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Feb 2026 16:05:22 +0800
X-Gm-Features: AaiRm518d9zdfiuzmBcE_5_BGm-KYKoZRLq-k7VGJtmRRuohi9TP0r8z4vJYsc0
Message-ID: <CABFUUZGj5=DNsiv__8Tp8WFS8sZ7fTva_bxZ14RrTndsjuQFQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/harness: fix XFAIL_ADD matching when test
 metadata is not initialized
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 591C0183682
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 10:43:15 +0800 Jakub Kicinski wrote:
> I thought constructor priorities were specifically created to avoid the
> problem you are seeing. What it is the point of constructor priorities
> if not to order constructors??

Hi Jakub,

You're right. Looking closer at the harness ctor ordering, the NULL comes
from TEST_F() setting _##fixture##_##test##_object inside its constructor
(after the mmap() allocation), while XFAIL_ADD() reads that pointer in its
constructor. If XFAIL_ADD runs first, xfail->test can be NULL.

Using constructor priorities should fix this cleanly by ordering the TEST_F
registration ctor before XFAIL_ADD, without adding new fields or runtime
lookups.

I'll respin a v2 along those lines and drop the fallback approach.

Thanks,
sun jian

