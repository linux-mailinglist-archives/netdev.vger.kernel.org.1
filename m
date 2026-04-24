Return-Path: <netdev+bounces-280985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL6JBCVZ62nkKwAAu9opvQ
	(envelope-from <netdev+bounces-280985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60F45E06B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B0A301724B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E513BED11;
	Fri, 24 Apr 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6XJYsNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341D1862
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031345; cv=pass; b=eSPQKyk3nw1X9Pb57r553+gFWdw55QI0XMJfpMNJ+vp8VwUvoitloPxQyrbznzBHBGR9kgIh/+m5BFSXn1rnIvACUdEVvYZkqjyJHsShBUkPST0yCN3CBdBh5etYxOezI93hUyJdprBqJrwpDbFxt1YLftCaCM+jEVCCQJKxF7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031345; c=relaxed/simple;
	bh=S25RK4nMTAK9VP15fEcfR7N70e8eXdnyNRlIPU4OH/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8v0pNAbdIPbJx7SFF6kL/Xoo+Xi2RZ5Dul65HCW58YVWA7KbHEsuFILi37MRzSfB6Dr+LVxaVpr0PTJs+RjQf+YUaFKIXyOaE+fHcw2RL7irN7Ax4wpWTxX2yyA2nMd8Oc2ZpYWfz71+PCzo7WJT5OQrnZjNLhS5r19aW+HlsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6XJYsNZ; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so77059807b3.2
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 04:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777031343; cv=none;
        d=google.com; s=arc-20240605;
        b=XN7F6M8hkQFEzm5fGz5J2wFo0dKZpWiezjQ6I4i++uCQUs0R6v5GpUpyULqZhY1bl6
         2LQ3to8m6Q6SCU9ah0uimsIw6BybPrcv3IKVzkjpdhpnM7AuZ96l/ACBJ6Ws/L+B18zi
         oxsKO3oBngTC9rMjg8sH5C0vxFZ4qomXowl5fUq6YbQTVG21dzhsq40dki6EpBOngfla
         wNDwI5e8XzRMejTKcxIci1T1W6cOptizurYr4yFrYMs8rjUl9akokK84ts8miAQX3PfN
         wLiP6HKG8AGmFUu+Qp1scwouvvf3qqTNhfTIewuO39Jm7O164dwnCnwG27wn8BI0ANUF
         lQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D1K+7EGQkqRwyCBLZKYkV8W/AQWx4PeXqw/cCw4zx5c=;
        fh=hmPCaNnJ9MqPel2rOaPo7bcc1Q96xaoLIBFiYO9oCsY=;
        b=gEU9cVPggoo52OJMiZ1vQROk7e2HW0Qb091Q+CrxF4R0J3zZulbnJZMfFnb1XlPeqZ
         qd44tFRmdlmFv40a51lXbtcPaWmuBGSaIafLbeO0Od5BauKbFYVC42MmBgTKkofyu0tW
         LicfTZ3F0JijFSheSBFhNnS2C4DEib1kAp4kFgPGhM79TtmzektlUr1Zl4UAmbs3eiZR
         jIczgMd6ZjtQHgu4Sodrlz30OEDWwFZiwNWRqDmqOCf4/7cNszBOBes6E/ZxJ82lEolF
         Qr2829VvfX8b3pdLQt39UIo8k4OgaBaYSf+edKxxpB5Giko1V2yLFFssn2Fy+5X9Ppum
         uHvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777031343; x=1777636143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1K+7EGQkqRwyCBLZKYkV8W/AQWx4PeXqw/cCw4zx5c=;
        b=k6XJYsNZMLHY1IGexCfkiJ/PK1hS/fAglwniI5NBv1tHpe7lRTgnaRjAqBF8dOJWFY
         AazECwOF1v6YdVd0zvShiGUe5U2sb0FlBYUWY/mVrkU+EQvc+XxU0jl2FcWE+nC8uFTM
         gaOuGc0V9pUhlYmtf6TkIT7QRtupt36IN1CtRIk4uV5pPxwv0eWOtof2AsyFSXKG/J6s
         QvZ4i41Lf3t+gHKnHP9E1pUiyr3HVkHN0mKIioB0qMOc8TjGrZSL25NTsQB/iZ+klJMF
         R0PNOytZ+/Yk3IrFyLiwzYqul+x6e2EBcDIICw5t3s1Q8XO4evdsUHBp8ljC2ouiD1x6
         Th0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777031343; x=1777636143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D1K+7EGQkqRwyCBLZKYkV8W/AQWx4PeXqw/cCw4zx5c=;
        b=sDJcwc8sc9uihN8LICLr/M6008yAKYSQ+nOWG6p3LebDTnc/tjhlHYwwtk9+KWhG07
         38aspTt5cFnDhSpbuPxLAi94Dm2mFjZs9Tk75IKaypOl+RPr0uzDzG1++5ewU++GVOs/
         3cKNfDBOSzdX8/MFiDtu7WPVajup+faMBk2Wlurk9DuJfiASQvAiW9kyzh2Lq1czltXf
         Zgrl95y+b7Qkpi/YilZ4tr+2UQALtMznnLjfL1iMnnqI9onyH9haWxCzh6IojOGP3YJo
         JjvluwYgzY8IO8ZJ5c6wpshYgtU16W06HKn3UQqbF+Y+nZbi/gjSQmTgM2yEmkMGrrk8
         DriA==
X-Forwarded-Encrypted: i=1; AFNElJ8uXh8ZTGhOqEHq9hXnQkOXM23qNbDBVHdZYg15yaCh5hNZ7Dumw1iPkRAOFREln/mDABt77tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKg/GzgKCcKUwRmb60PCsTZQHzkWONBjIvm5836E6ESIR0Kci
	VxeV2yS7uq4wDMquBoKN1iLVVthQXaVMR8lDZpytub1ECohSJeavgZnN4PSbwP68yMZZdksIcZo
	oXuJ7P3/DiP8EUwATsilQZqcCftUjiYQ=
X-Gm-Gg: AeBDieseX95QgCnaZA2uJt6p43+/2ZWCbGyVafFrGqxYbdkQM5MOBYA5SwDSnDKfIJr
	Wcx1eT61/A/oIDi7E+06D5yyEa4XhFHNLdoGGoUXFs/Kf+xM+VnVQeCHKELz6c4cNDzCQC8LQ6M
	Mg5eqYkbH4kgzL610ke5Yhjo17T+rVk8nwA8vRpHa+B7pMOAlN2F9BrYsdHdNqi0/rr1R9KigzC
	68iTedBYtITiYoDkCByurUR4r+towqAjU6RptWfwcq5st4Sol0dViSc3UdDGzUXwuPKn1ElxYva
	lxG8BAF/GFho0WSXXouTHKpdkwC1xI0G+VR/Go/entK4Yao=
X-Received: by 2002:a05:690c:4990:b0:7ba:e315:d8c9 with SMTP id
 00721157ae682-7bae315d8f7mr240564787b3.36.1777031342730; Fri, 24 Apr 2026
 04:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420162734.854587-1-michael.bommarito@gmail.com>
 <20260423212827.1177552-1-michael.bommarito@gmail.com> <20260423185014.08269f73@kernel.org>
In-Reply-To: <20260423185014.08269f73@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 24 Apr 2026 07:48:51 -0400
X-Gm-Features: AQROBzBh4hC9NTAGbXjRk4_Ku1BLAEhdjkZWkM2-BUNuPjFEK99NdqrNAtxXAuU
Message-ID: <CAJJ9bXy2e6kHKW=Un5JcNaO8u-Yj3Esyum3sjVtCq8F2mOc5kw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netlink: clean up failed initial dump-start state
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8C60F45E06B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 23, 2026 at 9:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Looks like this changes existing behavior :(
> The tools/testing/selftests/net/netlink-dumps.c test used to always
> see a NLMSG_DONE now it doesn't. Maybe this change is more risk
> than reward?
>
> process nit: please don't post new versions in reply to previous

Sorry about both of those.  And yes, I think you're right about
risk-reward.  While it's fully unprivileged and could cause issues on
very small devices, it's probably only worth addressing if someone is
touching errout_skb and related branches for some other bigger reason.
Maybe the shared cleanup pattern is helpful in the future but I'll
drop this unless you say otherwise

Thanks,
Mike Bommarito

