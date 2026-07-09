Return-Path: <netdev+bounces-306227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sFoYHVqfT2rolAIAu9opvQ
	(envelope-from <netdev+bounces-306227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D487317B3
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:17:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gnfLaqb3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306227-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306227-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C6C9301E23A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB7338DF9;
	Thu,  9 Jul 2026 13:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEC72623
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:12:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602771; cv=pass; b=A93jLA1ZFmRzE9dBMtZN+bxRWM5QskQA+Dyt9hMGZoSZ5+bPljukP10kEQqRNvsQoArVYFKAXECOBvVALXGTei4VuMSV3gjVjxRg1/YUHMCXYVmabwfIrqObtkbVBnTfiUL3sBp85I7QYejiRKHH0IBb+9yMcxa2W8zeAFteJkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602771; c=relaxed/simple;
	bh=LuPyH45JluGUsFbICdv0dPPjeFb1YqiZhn15J0rMzCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQrJIIy1Ndvy7MehLpc0NUzZ+A5U3NLdAC5ytFJDuflSDZRTqTiejDiqV09RWQO92upYmVy8F/yFOsDqCWXPCa6NddicNgDmwOaciWjcapPVjfzHdkjXuAh8lCmq/iXcpJMRQa9Kxu48U+bTRweOykkdcyMTNgc/SspWWuhUaaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnfLaqb3; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80bb8287d99so12900597b3.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602768; cv=none;
        d=google.com; s=arc-20260327;
        b=JyOxs44uPaOUByosRpzMTqvsJ495mCBR/4BnZIZoSuyQ4StKBPlTohS1HzX0Z0ypJ6
         uALTDf76paeGkeUGdw6mWrPe7GhRIqtCBQkKMIVefxlyjUvHI7RQBtVY+MxSrQ40+a5s
         nEDkkcEBcWwzSZkUgQvlULgiBCkX4WaECUlLrqFtZ+9MeMbbsLnKhK3yYiVJ0na7YJvI
         quUbMUc3T+2B2Yr9CTNRdBtKYJ2TT1xdMD34GLZbC0plePi1MLgV4jT0jNYxojWK3BzE
         M+84krmv+UKg10eRUu55fKH5baopZeIy1vXFnFF5x2muefNx9vQlyFk0O1HZ2WOI+GzF
         AY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jjrc/YslrI9jNEKvWNKtjZOydztcYkfUnEU0y2FxQDk=;
        fh=ROflBGdq8J9NlzpcqtXi6smtlTpQbG5PtzUr7jZdobg=;
        b=VP90dwAXt25IbPEK0dS17kSshhdFU/CZ1+cWWcdHTuyMIb6edkvj0UcVH19NR6Z7UG
         SbGXXDvnZMgT0mZZGFKB654qksaVbLoHH3WwPzMrb6HZS19D6W7wiv3uJBzsxMlWCZmn
         ClCKzndZJr+CuJNsxU8vhSxbR1okLFaQ92yAExPeQcKkTKl/t+e1aX+g+a6YK3HYWYcU
         gVF/w2d9JtdR/xF+qgj38/ZepjzJaMapMhds2SQ6lNc2MYOzMoWCqM0wZjfz3ZtgOu1o
         kbkdctR+SMu+4fMhAl5uomOsFEqVX3qY4n6jdL2lAMbRFu7BEH3p8cna9BXKYKWBODRC
         IJ2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602768; x=1784207568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jjrc/YslrI9jNEKvWNKtjZOydztcYkfUnEU0y2FxQDk=;
        b=gnfLaqb38pW03UbMgnB+dF4uuRfV7M+sJbi8lH5DjX6CvwHTPejmQygngb2jza3/EQ
         dG4kPmVVaRw6M3eyDo0R2wjUk1JPrg8y/THDsbpy9qyzGfOnjpK+Cd59OwXmEAvLvgbL
         9HidmzLrpO/p7h1sOKmG4/xgiY5SwBQH1Rp6Msh9u9Y5dk2h2J8vKCDg4KqaLwFILi1j
         k7P0d0G1BCzlK9XW2ODBFNtp+fSoUSjJsZHDBvfUQqH4/F8dqylHa+u9is/OPTkrZ5uS
         2/CTUBULnarjMOgKnTUhOnkOLdIK5Bwo81KjE6JlJF0wNh+iak4B6erPmLA5+dBd5Q8x
         ylhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602768; x=1784207568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jjrc/YslrI9jNEKvWNKtjZOydztcYkfUnEU0y2FxQDk=;
        b=DDO0d49U/NGAhkKc2zmLQCKCG3prjOl6OQxQKqGEl9cbCwnOFI+X0aDpzU6TpxzJQI
         Ilq9P+K36Ll8YET5C5LxgCmbBTqMi3Kbl1v3hEOJq0rcIrIBilXkea6DBYiAevj1+iFH
         vNC+AzA8nWwP59se06KiuZGibNiI2vZbLonR6dSuvpXEsFxCoR3x5lk79Ayq85H/9NIv
         I90b7+qFkGR+7imivhSIS2DDytIiYgQoqHJSEwgor6chSNLPVOOdIPYb/an4SbWKv/yD
         AQqFdeE7Qai1dVbEqnzSsdOkbBp6lN5GkAFNGbKVYEQ2Ux960zm75CFLPn0f5J4DzRJU
         KLYg==
X-Forwarded-Encrypted: i=1; AHgh+Rr32oYu+uOmw7CA4jPkYiHuMKnNpj2TwXl4ZnYZhDGC+hcpd6xz6GRwrG688SsmHWkgrcj/RZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGfXt7vnwaf6hwzpGxlK++JiBy+9KWjqtCckkjWUyL2twqqOk
	jrV65GKRm3mOXEyFWBAJHd/xZk1khJmcDN2sfgHR1+wbbwpdJvWBdP9brkaAd5pFGUXtQB33IFk
	hC30H53dn4tMa6ITDiKyJ6QOKwkGTZQ0=
X-Gm-Gg: AfdE7clH5OEzc7ao9zq9iu5owzXQzXPUBDb/V0BYVKEp9lC+JPthkJLyCxRy0wsOY5e
	yzQDBmGb0vX7f7QWE+pyuc+46tWwtO6SrsuGAzN3IyKENij6405QgHpU0JWxY6LX2tq9AENfvMD
	vFd6Co8bagzNc+HvB6kXV0kQIxNl8N/3uhdYhDAIjfzp1vJbawe/xa8nScpQv7Nrk4GVg2MH6Vp
	jRA0VRDhdXuXEaxaeUkG2GVTogJMLWkMNKrBzQEFwluOrpzweJ6sv8ZShv5GwRPFuhIUz0XW4P3
	YoLBtim7t2Tu3CAoTfEqazqXgqN+2OfcKBcp
X-Received: by 2002:a05:690c:c0f:b0:80c:1df8:7c14 with SMTP id
 00721157ae682-81dbeb5c467mr57573557b3.48.1783602768316; Thu, 09 Jul 2026
 06:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
 <20260707171730.2679013-1-michael.bommarito@gmail.com> <8155514655323d8c4a07da86d2b2ccdd7244c125@linux.dev>
 <8d735844-dccb-4a65-b7fc-468d144ebc02@kernel.org>
In-Reply-To: <8d735844-dccb-4a65-b7fc-468d144ebc02@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 9 Jul 2026 09:12:37 -0400
X-Gm-Features: AVVi8CdRFgA4cFXf-n4mZkaXWRsJYRCw57JUJkCLnvRfnyRQQEi4EQVk8jwdwKs
Message-ID: <CAJJ9bXy29+cwu+Me8WNrf=f4qc=uoXSMCrUG3NJbR-xANJxseA@mail.gmail.com>
Subject: Re: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
To: Matthieu Baerts <matttbe@kernel.org>
Cc: gang.yan@linux.dev, Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:gang.yan@linux.dev,m:geliang@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:martineau@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D487317B3

On Thu, Jul 9, 2026 at 8:27=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:

> By chance, do you have a reproducer? Maybe using Packetdrill with MPTCP
> support? [1]
> If not, how did you discover this issue?

Yup, I'll send to you offlist.  It's a custom Python/TUN/qemu setup,
not Packetdrill, but I'm guessing it could be ported or extended for
testing/fuzzing.

I discovered it with my homegrown agentic stack, which is a Rube
Goldberg machine full of various tools (like cocci, semgrep) and
knowledge graphs (built with libclang).  The agent logs suggest that
it came from a family of rules that surfaces suspicious struct init
candidates, which I can share too.

> If I may add, please also send new version in a separate thread, not as
> a reply, not to confuse various tools, as mentioned in the same doc.

Sure, thanks to both you and Gang for the feedback.  I'll send a v3
based on your suggestions later today.

Thanks,
Mike

