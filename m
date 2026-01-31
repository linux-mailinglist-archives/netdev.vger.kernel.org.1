Return-Path: <netdev+bounces-255501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABJsLNFafmlVXgIAu9opvQ
	(envelope-from <netdev+bounces-255501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:41:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D280BC3ADF
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7D4F300462D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D436A026;
	Sat, 31 Jan 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LZ/A5DKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB36A018
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888454; cv=none; b=fhFtPBfnXIvLJzGIndk8AFKzdFDO+KhXgVtWnd0NZD2qkChGRWNijnhap5ulYwqhkF8h+HUYy55rtFBPaiQmsdbZDWnYpZanYMf44tzBVd+1ihZao7rJ7etAgX+GIBydNw2KBSOj+5D9mpD1Ksqf5q2LmfaNUw/NNYHWDOTjr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888454; c=relaxed/simple;
	bh=hr/RKnqfb+HWLFdfIIWeAFj8Thxn8yMsShjaVYZu0N0=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYlu+KSsMbqhdiLay1qJjnc08+IHGIayS8CQA6+saYz3Ubh5DBo5xzaRwbwM6PdcAIhK1t/mhZrje+qiTlz8OIn/xe7YuP8+2UubbMn/1V8wyHl+ZFN46sjiYk+YgtDHJO7kFbB2QZeG/ZPgmF3Y98ZBgdVxSg3yy74zGGis/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=LZ/A5DKC; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2998502f8f.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769888450; x=1770493250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZKSKsZim3FGhSsBO7J0Rl75kSZ5rQBMjVT8hzxSzzA=;
        b=LZ/A5DKC0EDbLrgW/mQBNbWAVzRmkHecZNwIzmsh1VmucUdXNORzlw9nFBJDd/JDwF
         ocG/CTlYShx52c6R+bf/WuOft9J152ROP2XIvzimQjwXuZCAWWBEeRw6qdJpKHKZhpBk
         6S86mAz2dKIY+Qb97WI+a+i2bZGTD3u8S1leqqBgY5/OiEpUykb+eTyPuPEV3mxqKBXI
         Xp7kVrWiDmXYNa82u200lRTf4wbZH154NWqH88cjufY2glRJROw+S1rqKzvMM5TOnDlw
         IBpVeWSBOxvA6p4mGh//TNMGH9Yeuqt5/kcbwbZFOhn6BbTudlUlllJdMzDZ/p78Dbn9
         RPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769888450; x=1770493250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZKSKsZim3FGhSsBO7J0Rl75kSZ5rQBMjVT8hzxSzzA=;
        b=LcyTcwqgWE4KT9L7e4w77PmdmiBuS4nFEjj9sz8o21EGyvhRMzX7kLOJOsn1snuII9
         ZU5foZb5/QSImceLnri9S0OvFm7XjIQmh+7deiJjecF70lTad38Baf5BcU80L0U8BQWC
         rlrytMhgrlsNmQVlbLkDIjbLvfPOeH+gfqPkleERgfmiTcU/0hvhS+gUQ7etNbhkpne+
         J8r3i7u3XNliAxgG3wHhhMoJCoCybYCKcZ17xrz06OmUML3TnX3RYj9FOUSBP/SJh9mH
         iP6i7QmMC81EnX1/6UkEt+yeTtBrsctQAg+QU+o+jd4QmX4K67zM57JzNz7tIGTyxXcn
         VAJg==
X-Gm-Message-State: AOJu0Yylw0MGCX5MK7NOq9TdEtLl0aWTHpfG4r2jRHjOG8cKegTrGzxK
	CMeKT6u5U1+0KTRyOTwkB/okLaJdSI8BY1Uj33mS7xPVMVuv3pNCFlXjDbqFYWPUUVVYsNdATQi
	puN+wy/Q=
X-Gm-Gg: AZuq6aLE7fYVqzx8kp03s6fmx4sHk55gugeP5D0kcVnbHy4MDkPEiVoFWg+NmnejMuE
	18DjD3edXIDyB+QW5ueoPamPNkAH/jbFVbfJZatVTyYngNJSPI50g7WvycnZPh2rIiBgAADWtQC
	jUmBWLGhp4PwMJA6sd+btb7oYBNIy/gVOJYQ5JzEDgbILtznEyl++p8UoI4g1SosCdJYygr1Wqk
	gvx4/pV+624Kh9coOx0nT1Uo84aDMVLVebcMxIoMaUo8PtvMIs0OMGG54NLSUSrxWw+MSTRTMTO
	IoSYdxFLntAG1Of46Qr7foBSAi4DAgF8HshraKLwqRjTqiIiyZVtt4WRM5iBA8Q1G00BMnduFKn
	SmVreUxXZf3UpetDeXTvmvPWU8AyDAH77Dc+ok9k9uEnQ3vOY/xMXxYzn8hAC+kyLWHR7P//85u
	isd6iBzt4fF2JI4Y3Wg92MTqGc0gJZSve4zZ6by0uybt9t03TgJPnS
X-Received: by 2002:a5d:5d0b:0:b0:432:b956:663e with SMTP id ffacd0b85a97d-435f3aaca6bmr9211220f8f.52.1769888450405;
        Sat, 31 Jan 2026 11:40:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4824sm33025375f8f.1.2026.01.31.11.40.49
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 11:40:50 -0800 (PST)
Date: Sat, 31 Jan 2026 11:40:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] doc: add AGENTS.md for AI coding
 assistants
Message-ID: <20260131114046.3d124837@phoenix.local>
In-Reply-To: <20260124221439.234122-1-stephen@networkplumber.org>
References: <20260124221439.234122-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-255501-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D280BC3ADF
X-Rspamd-Action: no action

On Sat, 24 Jan 2026 14:14:27 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> I (and probably others) are experimenting with AI code review
> and dumentation tools. It is worthwhile to have a baseline
> reference for coding assistants (such as Claude, Copilot,
> Cursor, etc.) when working with the iproute2 codebase.
> 
> This document is a first draft and covers:
> - Coding style based on Linux kernel guidelines with iproute2-specific
>   exceptions.
> - JSON output requirements using print_XXX helpers with PRINT_ANY
> - Command-line argument parsing (strcmp for new code, not matches())
> - Kernel compatibility and uapi header update procedures
> - Patch submission guidelines including DCO requirements
> 
> This helps ensure AI-generated contributions follow project conventions
> and reduces review burden from style issues. Changes and revisions
> are welcome and expected.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Decided on alternative path, putting iproute2 as sub directory
in existing review-prompts repo. Like systemd and kernel.

