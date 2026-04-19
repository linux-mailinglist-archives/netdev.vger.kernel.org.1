Return-Path: <netdev+bounces-279569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEQoO7ph5GnRUgEAu9opvQ
	(envelope-from <netdev+bounces-279569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 07:01:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8642323B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 07:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFBDE3008C18
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 05:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBFC26A0D5;
	Sun, 19 Apr 2026 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxqoJm6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7E10F2
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574903; cv=pass; b=gKSO+JXqAFThxvbbygDIleBfPz9oHeQJMEJ7XC3I8lGCSTnUA3aKrbWfa2hUSEP+I3/Cc4AIKdLo2gxQ9cPsSLnAxmIhoDWtl30K/21SYadIyzQLzFtNLy5xHcK0txWmzAq9QktzfPocBIkWxrBrfiLJJNC1UGpc/6sHSTIFFiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574903; c=relaxed/simple;
	bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfPzT9lP0JVu60d2/tlUERVjCxZZc4IcwVqJtD+twEPyUiYA+Ei7JU5O2T3byq8SEHTLk56cZ7eiq76vC6dao+x6qN1XQ0F++qU+cDOvwjP/j2m2Pe0kE3Ygz/Msa1ekIQKuKbobW9uQ+T+JreIfXO6lMHXX2UYGwdgzv9H2gns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxqoJm6l; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65006c99d38so1922820d50.3
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 22:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776574901; cv=none;
        d=google.com; s=arc-20240605;
        b=CWun5jXpVKtko1Qalvl0dt00tXU1KO6/n6ev8zVm3P/ZX3O+uye978Aj5srcQaX4b0
         5zjzTne7xh5umW5fIe05LGE3s44nuAKvbULygWe/LlGNefjh7+j1XnLPCycXMeRSe53z
         peXtSgTB2gpbMfYpjkhP3EMXAuyebWJ/iCKgvFJNlWPqHSx7QPIpF4VtUmLt4rbAfV+r
         8Z3OJq2v/9XQGCJnRk/5QNsWqEbR6nzYU3c+6HH38rQ1JXWw+MwTwdaBE9U36bNkIdla
         vzsBQ9WXmWBJnkjsYx2hMOuTPEEXlb9xvL+53eBJzvXx/7UIw/oxrWqUbCaCx1LVYNyy
         c8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
        fh=FVG5/0sTemg+pxv13QoLYJaFnONlIM5xYvuEEu90+vE=;
        b=bwoxnCbjo4bATYmUtu4RYzH0RI3L1QG8lebcfIm6fS0nEMBrZRb8oCvcaRg0zCvccy
         P3yEKNfFBWNXzy6ICZjvEZPsm5bbtvgEihuCp/TCxJaqU2HnaeVbwF4IpLxnKXnwjbbZ
         fMcDDKsJixmfU7bUJ08HwssgWJ8Q86cPSEiRaBMpLHvFPONMjIpDqq0gCTA7cA2wybdd
         ylA1xVu0Pcxkgn/yWvvIveTF6/yIQe7jQ7SEGOYdv/ctM9zagTt/cwi37QZjtCwLEVke
         yxmJqY3Q3WiGYbBXcD67UPgWxmdi5Yjdnx+d8iYeiFklBFRNTIu44eVym1WI1kfrEUkq
         633g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776574901; x=1777179701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
        b=MxqoJm6lLS0W7jqdmwOtojgfTFzaPBra730VH7OjLQG7+Kz/HTxP2DCb/Xc1TnjbUa
         qQMKXbnc1WiDZmLxeYS6W9qNdlNd7+qOa9On2lhiep3cE0tEqYLpR9cYFmP3bgchMymm
         FE0kkQXnxF0GeekArFPPGA07g2LwQqDWqrXKVCuc0Azi4r0pQ3Ohoi3hmrNskjDHWeLW
         xYccajqUq2OVR9YBEaEoHsysQgUlh3NdwrBnFIqTPi6AvzV0+OQZg44A9+ivWWcYrC4M
         oNcjQkuidAhrNI5nOThPoTiZW3Hl2tTcrvZRtM5YO10uHbvNwdfIdzgXMyF7GjB1hUoW
         vXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776574901; x=1777179701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YCCUzjM/p2xoSD20SHgjZdgeD6MDGHJ4xWdipBp+t4=;
        b=rla3QO02u+MWsDAbxz7dWG+KEWHbtADhmtMrhD7MaUzSW3f0MRbCyPZPpxERbIMlbC
         sVJgvgOTlYMf8zbwN+nSGV6xUeDpbajm0+avKrYuPuc9ksAwNoiCrbMCkHpw30ZA3aSe
         iFfgB3po5t65BWJnOqTZJRs6nQi7YBQKvxsd6puZrxVUsO7yLKE1FJv70fBxQ6fI1stA
         vzFosPvgLu4MnKSD//MG3o1j4Uygvej05Wpip95/JvuPAcM1lx2cX1KUWOzkm+AzW55R
         0c8ITxK2Ero8mUIHD6p9GTT8HOaaSQYIjgbEAkdKV+c9QF2i4oBK8hyoSGsldE0Hrl/x
         Gc6w==
X-Forwarded-Encrypted: i=1; AFNElJ+28UzCYaO3PZIPi3kTFGbMcHvoOEMP15PDi7I29Xo0InO5ogu6ChBclXRS1TpgY/5zSq/Xh1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OmCvmQbOAyCTlrNlQAiula1VoQxI4S3K4edxFeqwy9y9LWWy
	HjPs/82FKXGc/2iH5cXJyoxi+Iqb6EJy7NgzNr2o1hDVXjz2Ujx7MIxM2+53GXEcZ4WqsaF2n/6
	1NemSKZwNtFfPfoNnXg1qwAaL4kgnn0g=
X-Gm-Gg: AeBDievmGTJ2YxW7rSW6V84ZdgxQM9/P0Y2kt6socyPrZj7dA9/Ddda75D/erE+OTbk
	Pxhn8z3j+DqlmRJtelKltgJBECKKkRMmpMyDYA9VNws/7+WI+A6ZaSAfwpTyhfuzRaFg3IP07rK
	wkcWfo7hL1UrQzTF/8s2GX1Q2UHIxBFqc8vqc9TBdU13uQwgsx81bHgaZusoiUPPDMmrdlLzIgL
	LAszxvxsfGuBy4aErKIOXLxWVaPaEFARge469XB94e6DmtBbRy9wV3Xw3g1E5mGZ9K0xFV4snGt
	7Fbx+SZshWb+fczVNf0VaGLtqs6KY0uZm95EJwJDHaIs1s4NmwIQkV4u41EScW/wr1o=
X-Received: by 2002:a05:690e:419c:b0:64c:a4ab:e4dd with SMTP id
 956f58d0204a3-653107edd75mr6704204d50.1.1776574900890; Sat, 18 Apr 2026
 22:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419040426.9672-1-avinashpal441@gmail.com> <557b90e63fb85b646de7ae4792eb2c06d6be251dcd95dabe9ed99435c82b85e0@mail.kernel.org>
In-Reply-To: <557b90e63fb85b646de7ae4792eb2c06d6be251dcd95dabe9ed99435c82b85e0@mail.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 19 Apr 2026 13:01:29 +0800
X-Gm-Features: AQROBzD8qwKrPSY9P1AT3an5qxnX6iBnH_hkCb6oiYpdndmJpIgSaNI8Zgm7iRs
Message-ID: <CABFUUZGGBL8Buo3piZA=pmaNY8ihgTo6xuP5XLM4m1pc0zWn9g@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type()
 for scalar regs
To: bot+bpf-ci@kernel.org
Cc: avinashpal441@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-279569-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 7FC8642323B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Avinash,

This looks like the same bug Mykyta already addressed here:

https://lore.kernel.org/bpf/20260416-kptr_crash-v1-0-5589356584b4@meta.com/

That series includes both the verifier fix and a selftest for scalar
store into a kptr slot, and Alexei has already picked it up.

Thanks,

