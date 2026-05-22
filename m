Return-Path: <netdev+bounces-290716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGj3BDUPEGpQTAYAu9opvQ
	(envelope-from <netdev+bounces-290716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:09:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809CF5B05E5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C26D3027342
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F7395AE9;
	Fri, 22 May 2026 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCwjejsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD137F726
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437328; cv=pass; b=r+DROmTVg+x1yn8q7kJcV9YihzJz/NI3J2bxM6mR6z6WzErVn0zUq07Cl+PXXSQN9PD3BOTbCL6xUaIDUtb08EzS4Q7tNT+e73Rrf+OG7/ahR2Q5mcB5NauiYXaYmmq3/Sou0tLcKOO2fdHatlyZb46Ob9pkcR3rA+9gO9dd29k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437328; c=relaxed/simple;
	bh=DElLwKPPbPOncuE8+T6lNKNRkDQ4AmTvj/LhG2kQibU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHwkAuJYsv2X46QCkr1k6ygMy5ElWopSdW+x1kY/fyPX7jErb+Vy7S8ggk/hWrdfHVx2Xkw/JlKZe+v6bJQc2ZsS6pUZloNJCR5hjXB91IqS/CeVSWWBx/x+kxHHU0I0kUT4SU0tvlEYRNB6VliXE0+WpIeopYrKnkfv/BDI1Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCwjejsK; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90d1f03238bso757009085a.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 01:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779437326; cv=none;
        d=google.com; s=arc-20240605;
        b=WM2Qtehj8kXVdN4uxIU4amT0CdWpn6jM2y2OMRj1mZbQxXpcspr1xnkYnFCCWwUdkG
         0b2K0CNUsbMDDMTKNlgRc1b4IqEEnJzKMcuck+psgnOnDYdoIn/aeC6D/QixGcXlVBu/
         caAzECH2ez1T31LCQvIw6jdMGfhCWtIVBzLIUNA1wBV3ecKWrsVdKKUVjRodu1paBPdb
         7BFV43W4pFqE4y8/Tflo68pNd+Kawo9CeXVouQq7VCHaUo3p5YLE6SfeSjDe7ksMNmlJ
         Us6XLowhMZNRLSWmz6k2Su/IbJ3X2CBrwVY0rmSIZ8Y2OYC0cQ6PR1qQKfb21D4y9U19
         hswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DElLwKPPbPOncuE8+T6lNKNRkDQ4AmTvj/LhG2kQibU=;
        fh=WdoVpZewMziVdsKtD7BiXLx6LbuoGSUrauu+mGOQW7g=;
        b=arCJ5G4y58dHCtfamTdU2esRM3o9rxQrMjYHn1D1boEoBrJlFiYpDtFCEWOkcXIt8W
         NrT7XH2Tb2jojOdW6qcVSxgZG5WvLEAvor83B34rZgYFgHrw62q84CB3T/b2aj8PvAjr
         RBiCkRCzxlG8IpZn26jt7l21w/6CtCMu/OoyCXwMHyTSFOdSTrkJamCTOe3L6bEjku5S
         nCzj5GhmJqBu9X5Divby/dPqu8tgdGd2lh/r09ZkuDcZvQTXnKW9GwOzgDZyPnEce6SH
         V3zJcyEZeKsCSmCmLPj/OKcBci9GaKgIsdCmIZuJFvQNtkaau1YnQL4O12QetZJyisJN
         IlzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779437326; x=1780042126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DElLwKPPbPOncuE8+T6lNKNRkDQ4AmTvj/LhG2kQibU=;
        b=cCwjejsKBVsIY9/w4kdb1wo6bsTGYd51OGp8Ne6r4CcmT5aqCP7UmdEWR/Zvq46ooS
         geLWbKzea6UNiTn4kGg58CN4RheFBs0tGWG+BImN4T27UiKPtvvtJnwR2s+8gzC4N16D
         1Et7zcnq1B8VkEbHaZP3T1BS7M41oy9xm50LZbIHx/F8Qer1SW4jQ9u7suH90OUUm6aV
         ScMwrDzE+O2Fai9Jt6TpWU/htSAxW+mh6Pm4lS+grlw31GDy9j9BMrYpjhuk0/ayjO52
         /E4ZtwjYXo7pQmbw6jJtpIBS9iHHuggUGYnZ+Na5KTy2vwoKIplGUKjMoRzxqcuVv5Gj
         Vw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779437326; x=1780042126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DElLwKPPbPOncuE8+T6lNKNRkDQ4AmTvj/LhG2kQibU=;
        b=WNd3sCNJQTSgqOeeV1Ccv5S2bsp8T2BMHG3wz8G+7trKBlL0gUYAX9/w948VwgIRxy
         NsB02upNr/yIorAX86nx9+qsQlZx7DHhMv0COmDbgSrXarg7PK3dwjKwIve6/9dpZ141
         dZOIGniCE7R/tKyhvJHWsEKlK4HMGprbNgyA/Zbm3C75dlnU0TpaEJ1+1nUzoFdHZwK4
         jKjj7tOO+EMP0qdnuxZ0wcqrnqbRUnI8K7YJkpv8/Q5vCg7x/T4xiaKzecSNhz4XEhXG
         cclu2KFN7S3uLPVWn4FjnxkrFFTxVk532dwKnVMBBqojYmCW1ne1d1nHKBxTSUm9s5gw
         UjtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7h56QIiObK62U+sqDb3gr2IQXbNwW5YSrLPifcEUTNNhXoYL+yCjhF2sLXIljoOsEtw47Uqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0sihkn9wZm2s3KJCvOsNGV8XcJa8pMkJcBP/gNGNhYz+lxwTA
	ftk9mSfdyVYXxxNWzPb+ZQl3a0Ev0m3GVI2tMhX3FdWPV0C2paNfhZvN9iJkS2FIMVDQfVfRNkz
	Ty2n5xN/r9qUn1RPq0bg8RwW4UmKbTb9XP8uhUetu
X-Gm-Gg: Acq92OHs6fjfZ1wRASJZIyv3l76dIxspzuC58OFOlIxfk71QnZEq/cGl+/Fa3OYZdme
	hOD8tftBTKWGcXT/5BjFn9EQbaTaMrJUSzFsQCRPnhiIWmUAnu3c/ibODweF4qBonel5NavOu9z
	3anlfCQIeQC6CRa7jD58TbzAA8IJbvbVE8LEFyo3xrxjNzTWtFREK8O0ZzSXMuXA6CMv5XqjwOn
	KBOXTrek3+/8R59mVHiDA5r0GJt3xpAYwEYwe/hIBJZhFLov8D6LNXeKD1+4ynd7drb9/O28l5N
	sUzutFUWNDn+5j2p7mHxKaZjkon5go6l6fcCs0h4r/p8AvCfv5LAu+Mxm9RZ/x8fJB/rwy08Ntu
	K/EVk3+IpfTr4OhgSaJLXRyWcm8QgaqePoDVE8vweDJL/4PyAXDzionUfO4+MAgnH
X-Received: by 2002:a05:620a:710d:b0:90c:d467:24a6 with SMTP id
 af79cd13be357-914a240e563mr853458685a.41.1779437325714; Fri, 22 May 2026
 01:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521150811.1896373-1-victor@mojatatu.com> <20260521150811.1896373-2-victor@mojatatu.com>
In-Reply-To: <20260521150811.1896373-2-victor@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 May 2026 01:08:34 -0700
X-Gm-Features: AVHnY4K4q6rdDKaLkaZ_lLbXXtuUvVp6z5A22tWr94b7Tm4aymjGx3LEaiDrGKI
Message-ID: <CANn89iKS7Oc1CLc9O4CLe9BF=bPjfMfgiqg30B17mS_i9qm75g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftests/tc-testing: Adapt idempotent qdisc
 notify callback tests to recent fq_codel changes
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, netdev@vger.kernel.org, pctammela@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Queue-Id: 809CF5B05E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 8:08=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> Commit 150061a20651 ("net/sched: fq_codel: local packets no longer count =
against memory limit")
> made fq_codel not account for local packets in the
> memory limit. Since tests a4bb, a4be, a4bf, a4c0, a4c1 were relying on
> these packets being accounted so that parent's qlen notify callback was
> executed, they broke.
>
> Fix the tests by adding the qdiscs to ifb instead and making it see
> mirred packets that came from scapy. That way the packets are accounted
> in the memory limit and the parent's qlen notify callback is still
> executed.
>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Thanks a lot Victor and Jamal for taking care of this.

Acked-by: Eric Dumazet <edumazet@google.com>

