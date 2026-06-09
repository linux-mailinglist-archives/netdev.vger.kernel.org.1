Return-Path: <netdev+bounces-296827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mTyZAilpJ2pwwQIAu9opvQ
	(envelope-from <netdev+bounces-296827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:15:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9F065B92F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=l9KGMpBk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296827-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296827-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C03530B63D3
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0A306B31;
	Tue,  9 Jun 2026 01:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12D31A7E2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:06:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967180; cv=pass; b=IennBKEkHItkMMxdYZiibNEwpyuO5TwhRu8RoR2ONCAvsteYnW4FmlZQHhw3O2TpFJwDvXaAVNwI9FkYHoYnXZtR64ODrhD1+yFHM1dr4ujGhckeG8vkBjyhF46l5udMMVhaRG7fmyjY7d/TmzUjV4U+Iz3+LH0Pr2+NxcsrvzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967180; c=relaxed/simple;
	bh=toPMLNVQSV34/03MBqQ1HwuMFhQ+qWBkaUc14FgPq4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4XGFPEXU2HgKGrTMhQwwsXXgsoJA5xgZQq8LFBtG0rdPPidrGh1zvUWIFf7cbm1NWJH5+wcOg4Ldv9qn4GCA6YXxPerJTSX09DDKCe92Gorj90r5aoBiSZAD5vM0g7cZ6ZiKA6rRbEXYh2m1xgdWKf7fQalAhrmkER0KccN364=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9KGMpBk; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5175cb5946dso32122471cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967178; cv=none;
        d=google.com; s=arc-20240605;
        b=LYteDZQcpay7aMQslKPKdvIZ0T8pi2gabqM4ATm/IWZp0CYf0kEhDszOMAVtvy8ecA
         Xk2Dc5HAEwiWOcYFH6E2NOjN8kwRHlYvzFFjArPaQ3ebVAv00RrEvuEPH9fuueuYzlPw
         wLYMq7TJEiVqyMcJ+M/hRbU9n88D/4zyphp4qlMe52IQXlu4qQLjVC+Snmol4l0OPvZT
         1kiedzsKY5597kjyOnlEwTjYab5nRK3I9Cmqkc7UMm8ozylzRgxmPeLGaTJDc13zx3BY
         PIBlY08dAm3fD/gTNrL+6ixtfOKK7hIkfrG0WEu9aMNOS2u9mz1srbcQyOk/8CaKpd9R
         Cq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lqyzj2XHrXITuroG0QfMcLCW6DC20XarCYsV8zWnDag=;
        fh=nxkqWVOMcjD+SgLvY75b47KiqeKsXF5zzb5mHRZcYds=;
        b=Kbx+2dNU6qnfeHW+my/ApZGuBN32cZCJhWXJSVBUb87iKvPzGFyxp9pjekca1C75SS
         ng4SxwCkqu2RjyFg4KlX8zLMp5+QCv+xlTaqWFnYh25nH+2lIOQYkXepw4hhUI8ZmapJ
         md2G3ZdXEhxRrVnuJlwO8H+v5My7hRR0cQhpql7WBTn5w5fvlmF346UjA2cCpAZsAxVK
         DDH1DcyT1+2pK+cgyr3+qqSjlj5j/SNNvADdPnb8KfHMMjcNG5Rf+h0A9AdEXQ0BupHM
         hTK/RQu4rcq9C6DzS8pRSJXp6T8tFu1ROXhiAHxXnagquQb14kOznPpd+viqtW8OIfjh
         /ENg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967178; x=1781571978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqyzj2XHrXITuroG0QfMcLCW6DC20XarCYsV8zWnDag=;
        b=l9KGMpBksUY9McfW1Sz2Aw80uwv5ggcxd1aSgOY/+FUpQFZHCUgNPXkzIGGdsl00Fa
         p8htjfL949DBde9dKU5G8g6VQZ0xO0bRN6Kq+J+3MjEmjHr2kCm3QHYyLTp6n8/UhhWN
         8+yqdmHHkNdwiKwO6obfb6DPCycfz1Sm2EjfRhPUajGkM+XrBiw276hggR9uboXlh4oi
         0HRGx8hyUvZDYrj49HBsmrXqiTWFwuiWnh1enE28EN6Eq+qKKMmlPAJ1k+C+OaXLIatx
         gz88FrUivhWncMCmeaBsjhE2HUbk3P5PM+pe0FD/xNFYTcIkezBlBdtbeTOT93bpwrTH
         sRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967178; x=1781571978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lqyzj2XHrXITuroG0QfMcLCW6DC20XarCYsV8zWnDag=;
        b=rU9SDGw91+L1UPFAYPackqYd3zsnMWqT3JgX7LrbKmeFCYOT3pzIwwjKWFQcsYHYFE
         rnloPTzX10zXclEKcrUranL53mkaTH0/NEZTMSvvVK1OK9nXZVpkogB3hzhdaH4O7aPJ
         j4ShOC+wwV7lVHJty9ktylwz65hwhqVPmtLpiX9oJhTGBY/R8rjLKF4xE05LrqHslvNy
         DMp0vVpiExoEKkGuUL37/9neVp1gREHpvXKajAWVEPqXI7tX6vlibnd5GqcBB+VUEPD+
         e1+gk7zR4xeNipds9M0HZumiIKX/T3aIgGjicMbxz0+WrsIyzkwB7v9TGDK1rVIHa7ge
         wehQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YtDwP3k4vgwHdLi2j7k2IrNn4wzOLiJ1yMolcmK0WBswF/NnD1hsi+KVYeKQpI4D3Ij5ecAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+UqnCDu3VKp1zS2njgvXrXmPKTLb9bIs447A5D7OdNMimwOF
	SYHb1p02jr9IV99ylIQq2B3JAbQmeA9V6QjOfZEAaHi0uHdQcSoQuP9N8MzMsrYTr3d4tVy6tm8
	Z+ivMHw5mSYrGvTp5OsLYh5HC9QMgX+9qsilwoODZ
X-Gm-Gg: Acq92OEpGJgsjDxkAesGwzcg9QkB9BMTZXmgRqvtILGXNbGNRmQ6HDIFobQqYIEdt2l
	jNGFTvfUACIgR84z8iXmEDXQ9EqzNVNX6gEXtXReQBUHoh3g6omIBJiRlrcnyYsw4pxY7jE/0jg
	6P/f01V8r7CcANTiDEw2C0DnS1vQWO5i3jeqGMlxX47meiF1fmet4fM8Yj8iuIWrCqmGRocYKJd
	6ALfpEBFgqfzuLB/fWG59C86jf+qggl++HMSnK637dvC1/PEJGt7JCZqOa6T+mC/g+HxQV1nMJm
	KzPXveYu5Kbemj3nobHl0RnLzOgFi3F/Iv5Y4pUSUWVmlWubExTgLyz+aw6hGiiX5iY6XT+g1hj
	X4KssBryiesrWevHD0PlfOIiv3Y4X
X-Received: by 2002:ac8:610a:0:b0:517:675f:3ee8 with SMTP id
 d75a77b69052e-51795a874f7mr248477051cf.12.1780967177784; Mon, 08 Jun 2026
 18:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003749.1238146.66c32a2beed5.ets-change-class-stale-deficit@trailofbits.com>
In-Reply-To: <20260609003749.1238146.66c32a2beed5.ets-change-class-stale-deficit@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:06:06 -0700
X-Gm-Features: AVVi8CdTn0o1ZZypJcD8pyWjV6AO7T-aXxJbTihXg56aSfRbxJ2PT3-45hEiGAk
Message-ID: <CANn89i+1sjE5gA8q-0Lwmp5tSE7k=tKZ-iN9iS_yO5ymN3p21g@mail.gmail.com>
Subject: Re: [PATCH] net/sched: ets: reseed class deficit after quantum changes
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296827-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B9F065B92F

On Mon, Jun 8, 2026 at 5:38=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> ETS class reconfiguration can change a class quantum while the class
> remains active.  The scheduler keeps the old deficit and spends that
> stale credit under the new configuration.
>
> This can be observed by making a class active, changing its quantum, and
> then dequeuing with the old deficit still present.
>
> When an active class quantum changes, reseed its deficit from the new
> quantum so the new class parameters take effect immediately.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

NACK

