Return-Path: <netdev+bounces-275623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOb3MX7J02m7mAcAu9opvQ
	(envelope-from <netdev+bounces-275623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3DF3A4707
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E70300B051
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9C3859CD;
	Mon,  6 Apr 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5aibJvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089F3845B3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487353; cv=none; b=SUVHyp8koaR/H7GxFDz7nqKAPnka3bAkdPFN8grT8CqZ9yb2vOeocmFGs8syysy2LdQtGNgSkdOux/daT55eU2VOeDv16bpdq8wAP+YLa/KBDVKaG904oak/eBsE77j/7ky10+kx+QeyuDadEnkCgOSIy9eBi+tPUIwyThS0yP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487353; c=relaxed/simple;
	bh=aGSrexrnXCm1FNc1OAp6YvvAIl1RtimWhDTpstk2OGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb9IIls+9gLRwV+FhMSYsxF06XXc6ELtYWKsH23TTiMEYSic79Naj8JdccOHjPCp7cHuFyfOcGJWjcmuTwyzYBi6gcjo7o7TFaszsxKXREnjgA+l6ww4v0Sbf2hvs8pIgeaBf0ToqRqEHgaCwZSB8/QhX9gljvdqMVjWNsFt6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5aibJvo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaed195901so17152385ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487352; x=1776092152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoQfLFyrOhghKg6a7mdY4wVOPU9MO1lbVxnOVJ4i8oU=;
        b=Y5aibJvoxVoOhoJ0vHHUKi0ikFBUbvRjiQKD48LsPmi0n41MjXjcGWKx2gGnsqK4UF
         DPzYFJMN5MnO80wrRbXsKIwifqNmNuHUZmwrYSqXR9fVZOVgJpXvGIcBneq8Fchjrlqp
         ybWrh+Zn7kppFuAHuMwZegVvg20ehqeW8d3s30aC0dT1sW1GQBmmvVbPR+qXFZR59nyG
         SDL89NlVb5345AZh3FQE0EsW5PPEtEuV/FymD7rb/G+BKG4FBN54daXbsdf0DzA1w3Xx
         pcLoOcklAQMlzTeHA0MjOlvqCZLLuRozmZshjcVBRfDcsbAVpUCkq4Wd3TTLDKBs3Sa3
         O/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487352; x=1776092152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoQfLFyrOhghKg6a7mdY4wVOPU9MO1lbVxnOVJ4i8oU=;
        b=P8iZO2fL7Amk1AXNDrl44txl752HIJQ7ZgSi1FMseG6uNii4pIsThbhcejEMg6iSER
         ULhFpEaOze3F4ra3cv1XdZQ1CSkfKgyTRHu0d3daWh9IntKIeJ+mm6KwucBFVVUbtspT
         SpQX3U9Dwh2BHLFOCrkpj21ShJ8lhLLsms420iiGnmYCGTNquIffQmmsTmoecUBlgXBj
         UUj54Q6dyizjrPuqaDHxKGunVmNqkC9SVc5YnFCDekZ8EfRLX2sfZfxilwx0ZkqceaNy
         K5WqZVwgvrdhvDA9fy48L96iOeFIgT7b4K7U28a+thv46gxFHKsQIih4HshG8dpJNYzr
         cgCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTiKAaw1oysRgaUGsxRhL/5dskV+Rs53XRkdw60tjphI8TZZ4kAY6NphDPsToUX+4mj/IWie8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8e8y4v9AxuUdnK45XzziMFjnvMTMmFhGrJlqJVuucV+DoeSm
	O1sfwF69QkkTra7nbqjYq4A3XgCJ3bvGe4sc0gwxvxRKu4FPaQ6k+Vw=
X-Gm-Gg: AeBDiesVINvbPNvU3kXhHcMMK8/ZK+iM1C2A7jIDexyS4cKSVTIWIp6kVF1s0Rh5ySG
	vBNdp0CxSxE8doYaQiCVez3saun49YDLn74EVFsQihLpzqbfr8DSzU2WtuqhTEmfBc4NTnbWaOi
	Bkls414JFHjeqppLADkbdGVy8r6bqfWCuz96jeNJCbg0+FNAqhgo23HBG/JIhf7qWc0k01CBMA4
	pPOjdkUctE6oxynHdbwtCT8P0UUcUuCrPF+bTq9N7yh+0+SEIhEQG88lMRFGp+IHCtJfYWHL3Mo
	XoBWu9ovpX2oFT8tklqMFBX0SgW4AQDrEKQ6u6M49uVjo0huF16ppFQgoVgbMjg2Jgxh5u5mO/K
	vfc5KDRPjVcJxhCzADT3AAlDUu6Bib/lwJNyN9oTvWOsA7pCPHL4TC6/mEGX63VU55IuKlylWvX
	pa150EiNxD/RlkjPt2jZCmbenadUg5jdHotCgWdD2f5N0g/Ki2Zqe0Cp5Onzr8Ca2VTR+g1vdRm
	AnzZd9CmxHA2pknfA==
X-Received: by 2002:a17:903:1ae6:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2b28183595amr138943555ad.25.1775487351544;
        Mon, 06 Apr 2026 07:55:51 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2745c480dsm187051655ad.0.2026.04.06.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:55:51 -0700 (PDT)
Date: Mon, 6 Apr 2026 07:55:50 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	leitao@debian.org, shuah@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: adjust to socat changes
Message-ID: <adPJTsDhi6ZNyUUw@mini-arch>
References: <20260404230103.2719103-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404230103.2719103-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275623-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B3DF3A4707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/04, Jakub Kicinski wrote:
> socat v1.8.1.0 now defaults to shut-null, it sends an extra
> 0-length UDP packet when sender disconnects. This breaks
> our tests which expect the exact packet sequence.
> 
> Add shut-none which was the old default where necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leitao@debian.org
> CC: shuah@kernel.org
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

