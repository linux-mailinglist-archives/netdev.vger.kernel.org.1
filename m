Return-Path: <netdev+bounces-255275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eUSeF+hCfWnaRAIAu9opvQ
	(envelope-from <netdev+bounces-255275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:46:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88803BF705
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 582D630045B0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 23:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA3366561;
	Fri, 30 Jan 2026 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="c0g92UtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA61EB9E1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816804; cv=none; b=VaAZupAvQoDNteptam7FPcwpoq3Fq+8VZyAmpmcFuUxvmX7Qd/VpEXRlBgVnDA6olvz0QkWCMSL+7vpeui7JdhMZsdiMq/YrasKmI80+9xmhLBEsNWcoAUG3iRMPX/PSY98+RQk5FAmahqfRvWzsT068HvS23FpWRf8W6iwYNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816804; c=relaxed/simple;
	bh=UGcDUM6vE06bzGkDJLnU7yEK7vkly1thWJijwBbxFto=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbMGQicagH8T0saSanPQ+jQfnBH21ghrLS+Ra3BiSNEYhEmnxl7E6ET8t+Vd2UWPPiB6xUiexrdN5CDWZ16YDUzusSy/vzt8bWksOCn9WRgnAArAG8ukRvyYH1qKXK4/+L7WveZttirCsev9pPzOMs5Nt0lFdHTzhoesdy6Mw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=c0g92UtP; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so25571055e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769816800; x=1770421600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2Tlibu9iPf4/zwW/3CUh2XRvmhwTpDauw8lCy0hyho=;
        b=c0g92UtPFSvuFx5CSA4ZpqvzHKk7hJlDfY3Zvv3yoL7eiaXd29D4sP3KkJd0y3AJCH
         dzXduC3grkVKF4sDr4gHpPEF3XPd/yCUqRHVEcyvfzGYHCYr3dnNDY5NO44YVMbolQ42
         NvVX+fLmcqgwPy+eTl+cMW06TGkh7KV0TYsWuiV087TATDFieThW0H2v6g50rjITlsIz
         wK7IAuME0axth3MlBvcbyV+inZ8mXOalIO7P1RUftbUBsodCppAwt8CXKouyWZgrqAs6
         Nh4nmX6j8w8DGneijJPyWHbUe07cR8Jjte8OcGsKyXvcbhUMeXTXpvdo0nDqTYSbAkHZ
         DXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769816800; x=1770421600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2Tlibu9iPf4/zwW/3CUh2XRvmhwTpDauw8lCy0hyho=;
        b=OHzNqZhlOpAMEw/lqC3pqc0Ye3rqtNJi5VNDT7wNSJYb5ansr3Wc9IEECe6ks8z+2x
         EaCJC56ulcBqcM3QM1iA2fWTnhyBsMzGf6gsfY8I4W3iXoUUNmaCSDXGJz1A+4vc7g1C
         yxzdnI0MJxCWPZwqOCJvSBALgSWKzme6PTgWlHTJAq/UuIJJ4BdYgcFFB1hvxy5jiBLa
         E2dwLEojx+UzntiaWQ6MlkndqLQZie3B2LZRnwjQWWtLaV1h73md3P7wmEjKs29BItGm
         ZuKsSpqQcOGSsz/cFM2h8MBDPzs2dzK8vV0MNGscV/OB6TNjZznbEaESA/Gg2JLWGTFc
         NHoA==
X-Gm-Message-State: AOJu0YysKRuslCB7dgInkq2kvEJcP530/iAeAvCAlpQ5uvBTMXd4/6Sj
	JplnQSe6C6TjhsR8R1DlzxZzf6fwCalXqKCo4OqJze+DNX/XgN9xCAalhw9eIF6egwi0V0jh6Fi
	LxJx2te8=
X-Gm-Gg: AZuq6aIRnfZWup427E9ea5rLY+2x3LCCJd1hVDjPKAqdpXidfRaHzVAoR3xgKs3APUv
	WVyl9YoJo/kyajaM11GOGAWBRy5yl0FVfisMrPw43CkZwkQ6bcOuCyzfDNGp46amqPPaxsfx9rB
	8xUn2yrnGbk3i4B2Vuhzdu1a9/9nM8vo7hpKHeJXMC0id8FRdlqHMSDQq5igOsl3QiMGzX1CYKK
	lrCNEPcI5/JL7Tonhsb1SBBcEdT7QnAHe3ot0IMmLQ1tY3a3Ja9vfEOkkY04YQArXXphws0L022
	CSBpfWsth+yW3dxreZhooFLA0RTyZ5SnmTNnnczujqtNhl9jPRfQUncLRRm3Ynhz6xnnUDPY5tM
	uV+4LHJa0+YWCMv5BnOEVtMUiujYFM0rdvQi11oEwXJA8uNxzeJDaEq3ekseW0Ry3NANv1A81Hk
	CljF9rxV+enyYSEsNoyeGTfOnQFWU3r/ThcvjsPUyyZLGQL3WVACVG
X-Received: by 2002:a05:600c:4ec7:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-482db46b04fmr53997565e9.15.1769816800326;
        Fri, 30 Jan 2026 15:46:40 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm273125185e9.5.2026.01.30.15.46.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 15:46:40 -0800 (PST)
Date: Fri, 30 Jan 2026 15:46:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] doc: add AGENTS.md for AI coding
 assistants
Message-ID: <20260130154635.7f2eb4f5@phoenix.local>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-255275-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email]
X-Rspamd-Queue-Id: 88803BF705
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

Probably doing something in the review-prompts makes more sense
for iproute. I will look into that instead.

