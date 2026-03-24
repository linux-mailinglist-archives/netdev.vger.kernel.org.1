Return-Path: <netdev+bounces-271157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHcFLfy2wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:08:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF08318B89
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD94315EEA4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284038D6A4;
	Tue, 24 Mar 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UO/bt1EA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8091459FA
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368045; cv=pass; b=qD33OuESXN8lGuKce7mgj2jYVt5dehJ5M7wouzK2ySobktCPcG3CIGRZ5xxbG1uaWq5C528DJaI8TDI6mVOcp8GvXyiJdrycBa95C2WDlmXMxSOeWHOtjIvIG8DRnOwvvAFYcRrCzFOy6tvyc9cyDheXjJ21mV0iegqdk91m+C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368045; c=relaxed/simple;
	bh=yKHA0Al7R7AUI5wgee3YEebHe3w1XcJgLSs0JySgzk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px5jljJcf+T3sWhn13YEPiK3kQS+BjdndYQHCu2VacXVkp2TwqDK2eogrzDC/b9SxDTauCqpf7DywoNJJxFcY51iet9fiWwBlasz8N2YWWTo64tOAdeOhZC7HYNnbtBdppc+3g7YborZOBzMdw2eTiEKv07B6tmMy8t/oQ5arxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=UO/bt1EA; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b979d16dd0cso817478466b.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368042; cv=none;
        d=google.com; s=arc-20240605;
        b=URrrXGtEftorm4DMff1BoA88zgCCK/kH6K80m5ejKRosA4/12H/oelx3hdamUk9MRo
         wd0aVAcNe7UDo6FgO+L9YYgD1M2ugeM+kYUEa8Wjl7y7GANdhMeyJ24YB15VW8wwljiB
         6eZln5FKQbh3Ibz2hrxYsKuETYuCmzXhf+Ipwqx0sAnxYow36hBYEnJzqAgkhXclNk/m
         tv5cVkkBFVGp1SYogjF7qx3VganC6nEJ/JGPRuDMI6xdkq0r0Nc1r0d+Xu49lGN56TIm
         L7P2CUQGDgbNYFhPk3Mx8xLPh1rdbRGss5VYq8dF8qtLbu6q/doGHynOnMEFUChBX6DF
         C12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKHA0Al7R7AUI5wgee3YEebHe3w1XcJgLSs0JySgzk8=;
        fh=6onRMPJOFnN+SFYsH7i1T3oxeslPNmAyryxlffkEzvg=;
        b=ULUdzq0mFIR2TKSBTA5xZxhGPzROM3qeWnzt786s/EFoXdscdssC6C19KkBsaR6zDi
         5mE49SJxVenLZk+i5s7sWobAXKRznJISgAm8FkTSbFRmCDHZ5z2A++S2TXe/RrGItLj0
         DCvtlAkQNcJAv2N3YP0mEGm1XQq2OWlWz3OLb8F+igqBt7RM/ZcUvK35p/ngDnt8fppo
         KKw1CfQ/XyeU74DzavXM3UH2JzMgSKNn2c1B0OC096kuKrzuw5x/3bekBzsdZPzFRAsd
         iBDVOHyjj9NTL2qZXnS0L9QQIxc+S/He12VhGicDeXHWG1m9dBe0KogfGU85e+pkgVGN
         v1dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774368042; x=1774972842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKHA0Al7R7AUI5wgee3YEebHe3w1XcJgLSs0JySgzk8=;
        b=UO/bt1EArFcX9d2qjGVBHZRDis8tS21kio1A7MF/rAt1PBSojnCiooGwU1X1/7zhca
         hi7vletsrReGrAztFopH58E4WLGeEWbVSXsQJYRdadZnaGvL266ZELY07Fk8QPIlIS//
         Hm+1dqwOkrruB2yqZ68HIIEtvpiHpad2ElIHtjPrB512jmegPYyFKaAYlaMeQFcTy3U2
         uoguR9qxWGLwVtHPv5P0Ie7S9c0YPOuKxxhgdnGy3qtn2dXQE68hHVXxoQS9P1ZHUkmW
         YZUu3/jVuPSipBpseo9r0FNxA1wYmyA3UeTAIyMqAqZV3rV3Xt/Tip8UVM4tcl+YHJ/1
         /Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368042; x=1774972842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKHA0Al7R7AUI5wgee3YEebHe3w1XcJgLSs0JySgzk8=;
        b=rN7C7yJE3Q8c45IjIsVdYOc6OjNSSdFkkkKfU1S5VGqGBHIWJnkghN0w2nWO7QbNh1
         Y4J7/kTwX09n3YxWLy174nDn2PX706F2WQyupCZrjAzsdWAHzsvVsqlneYOD/kGEHePK
         9IvTOt38PRddsztfxEf9p1qaxZ3Wqt4Grk9wW2fUX24mIK1KLQT/P8Lzxd7YEBzG3Yal
         SxHC4FjNz684Mepor34CaAS/RCUC209vB7bGvYHVRt0PbH5QbetQljAyw+/4fhcKUT1i
         FOg6HIdsi8jmDcyxtMpbqQ6nSGjuRUHUDy1+Q5hkB1jvZMEXZns8LBYU6uFJPJRWrOYD
         wjlg==
X-Gm-Message-State: AOJu0YwZm3u0O8OlD988ynHk1mcxUjjlQgwwWbXGya8t7xC0q+XFJbdk
	7e5+ivFPND9c+VWuw9drdojFJiq6woiyjbZui3COy3eFwjthM1ZQ3OzA5cOQivOXS7kd8n1xuti
	vXtAZ1oEBiiPfqg9z93LlJu9Y5fOk/QkzZq/ksHzdCWFGNjoBgRi5RqwKag==
X-Gm-Gg: ATEYQzwanHCqYNEXp3ktVm9VlhVsKthJTQcO/HlpwbAXMO8OE3jye+VVkCd+nICQv1U
	9geDc548EcMHkZbT9CK4Y4T66wEMLzszVwjOKQXXWTXooNyp7pzkkSleAY1rSzvMBbF0fQt1Kvt
	qYwKkehX+0e0l6StLPpUYEur0z+qm5fXdTamic1MbBmBOb8kG/7tXgczYg9lk+e7XZvhpwjbmGZ
	fQFYsZfOt6VMGHS3fqBI0ySwXWXCsgNY1cZHLNok/1nsEBX6JHcECP3lATeQT9J3yMw0w3+eo/e
	z+UALqfzgxtmlsGV4iaLZY6wsjzzcgz925ciuzcszg==
X-Received: by 2002:a17:907:cb89:b0:b93:51df:dd23 with SMTP id
 a640c23a62f3a-b982f1ecb62mr1204687866b.16.1774368042166; Tue, 24 Mar 2026
 09:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Tue, 24 Mar 2026 16:00:30 +0000
X-Gm-Features: AQROBzA2UyldTau25I217czUDJpDCx6pvQaLQ4Px-q0IwZyGWdJZ7A2JAP42Okg
Message-ID: <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2 device
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, 
	Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271157-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim]
X-Rspamd-Queue-Id: 1BF08318B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:06=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:
>
> Hi all,
>
> this RFC series adds support for the SRv6 End.DT2U behavior and
> introduces the srl2 Ethernet pseudowire device, together with
> corresponding selftests.

Hi Andrea,

Thanks for the work you (and Stefano) put into this series! As
discussed offline, there is interest in such a solution.

A general comment: I'm not sure about the name "srl2", as we're
talking about SRv6 specifically here. I would personally love to have
"l2srv6", although I suspect we may end up with "l2seg6" to remain
consistent.

Cheers,
Justin

