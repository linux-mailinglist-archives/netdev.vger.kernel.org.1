Return-Path: <netdev+bounces-280097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMFwHkBp52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C345D43A782
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277AC305DA6F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A835A3B8;
	Tue, 21 Apr 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpMfWFqi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4D3A758C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773240; cv=pass; b=WaxAui0dJZtku9/FhF30XThUDd+BBBn/MhKJ/p7+97Z7IsK0/CACuv+VedhzkVoWiCUJfKZqiqnyw8E4/LZ7gah1Dr2HBzLmcj/pxOnRQmXtzk3t4w7a7z30e+Hza97bCTHaS+j4hBJIPBN/HaTv/B17ZHqucLZLckk6mZOjODY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773240; c=relaxed/simple;
	bh=/4xlXlgr5gHhEx7hkQ+MHrDMIugb+AXYYNkM+Z3m22s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DM0Ijv4fVQCdcDaI7qczAhsJmbWMolpEG5BiJRRLLtBXAMDp6No5bZMC2hOw//6vkBzMevub6QPhClMfpL6gYdoQBDnqwq9nIY/N5jJ/lIfO+moX62NCjmzvyNZJztDpaU3/Um9R0cNRg4jVvLq7aUTe/zN/P/EgExiFxdjXcYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpMfWFqi; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7986e538decso39243697b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776773238; cv=none;
        d=google.com; s=arc-20240605;
        b=ALufB5Fohd3SEmah3uXeGOxGJygrSZzK7hRO9jX9K856jbKNwDRsvCgTSOpM1poluI
         1Ykn+/HbQ+oerSdElt+kskP7Jjy6xaQ5SuWOOjefBnN1V6L/cCePwtPD2QA6vxubxX1q
         SaK10hZvoc9FLwfSSjmW58YE0THRna0OdHglDqi+FHLlF6C2AresZfHXy2w0wGz1R745
         or60896J6TGBwDgDCkKpIp5OylsP8SSY6r9/wiFYfBrLMIl/uMHO6w3nfKThzTk65g82
         mosVrfvppV6ATdMo6lMGdxycNoo+lQAH5QGg6SYcN5ZWf0PmsSQEKADz1tRDxKxXUrIL
         Dp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpkR/kk9mZLrEXxtkG1ZvoW6WEbgKq8NtjJV67sNSZg=;
        fh=MeIQixyPH0sjyj6dZ7UCB2RN/asv/PI3fk6jZ+gYAF8=;
        b=e7+Ij3flj75d+XCd+TfJwstZezMW0iXZmI34EmGH2OkLathAG0ft73+YYVwL1uUu4R
         7BA2yoVdnl707bAN9jxzwgtI98qg9w6BclvI5U3l2izc9uqD2tlrrZiId2FE9Joecp7F
         MnA6byn6k2Knc6GDiCwXXjJp5c3WJQbBmcrj4d0kJt+DZ7Nsqt1C5sZJw0d8m7EhUeyv
         BL5RCIIgr4aQwIjJD6D6xZ/IYeeyLk0cv6fV1IG3pwyM+HZEPWFwCddi88A8jNEPIBd7
         LdTP8Am8pvXZE8IDGomY+TEd3Qx3m2qrAOl9LRhttpQg+tN72tAte6TbEOmZ1U3pY567
         XliQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773238; x=1777378038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpkR/kk9mZLrEXxtkG1ZvoW6WEbgKq8NtjJV67sNSZg=;
        b=UpMfWFqiNGTufhiBe3zlzyDkiOLop55WB7RrqrbYGKkSdQvEBsYwgaBKbFBmkxsbAR
         7BqMRz456e2OhtDnhJne0pI0QzLHPzsTWsH41LqcgOWsnNsKff5+0eyCjn/IE/PMvP4M
         l4OVLtuLWOvlZEONEEP/3qI5nMKidV5jce3fRmdM9D6rZJrngzxJcF0oK0boVFV525HD
         GD7B4mWQju1WezwICT7/v6QgCZ2GjYmg8FOEgO5MV5h1u+6T6Zk/v9lVLrShyeAPBXhs
         yy2O4Qf+XWjx/J0vcwmLa8xZioN+hmuzygUaDJhORiOBvNgpqbi0bp8tkHo6UOhFbmC9
         axjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773238; x=1777378038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpkR/kk9mZLrEXxtkG1ZvoW6WEbgKq8NtjJV67sNSZg=;
        b=KhZHv+hFrMzuBqfKPvlnD5PyqRVkrIfUS3coIkm/xo/ul5b1CRYLpT4xX3G4rkdWKD
         friOFyhj6jClhCjSg0gtFnWuZJNFmQrDiIjp+DuG7IDBE/zATSI79/Mvb0haVwdYbes8
         Os7DCWt4eCxFzDEdkErTYZwgaB9iUv4ZJEgUNlvWmXfXE6gZFsAqk3oz3gliYWWoIfHr
         oRStggZEAUEIHExupjWoGcLOLEzc/gxX7jtfPHTjxlj/XHTu6TE6TjHIFYIAHPuM0mW7
         aiqjKhi+6Fd1PK9Wvo3lXLp6zM5mYzRS+wqni5liLWeqwZRkWODmxEBQLTRvVLkD/udh
         i4zg==
X-Forwarded-Encrypted: i=1; AFNElJ/+KZgkoZFQq/OEkgeGDOB7dgPdXhI+vxODlZEGGjpn7bPff4cf6Stld1sH9Jvy1YkdK0e21LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyODmvyv7Doruka7WXnLkxDo3FSFYHzNt5MX+x+WveSip+HeGFC
	VADwYum9klVtObk8cZRbzDUty+1M7j3c65Lg+rGaiGyqkQFrwMQy8/dhM8y+OYgK+dJXQj+iHhi
	VGT3Icylu3bMIx71yiPn02zYG3lr0kaI=
X-Gm-Gg: AeBDievlv/AvWhBLDGLYnQ+2LP4ZP9MZMvrvQomHGRN/e/lZKEJ/ZhUlP2DrT0JEEZ5
	mt89V7xOKGS9VdXCL0Yv11qVj1aC/MUvzr4XAiZ+F9WRN7j61iMYHMyomozfae65KsU+h5CorGh
	/ROLpw6H6+BMX7gcFr8nVuIKaBioxiJJF0rZ29lRFv41LbTgcWhKxEAJYTe0yGg9SkShEE5C4Pv
	pVANtKnnIFUx/rwzNP3xlIq2YTCAcqNm60VEsf/N2uuDW2fSv/veXadHKZ9nHv4JhtHkrecnvHi
	5/YfzV7PE3bHcRDMqvelRD3Ls2RsJq4sMMLHk9mnojXO1ByHHlKn4jj4NC2VmEH8uMWCGps4mV/
	brkU7FgKyk8Y8ObejBcnTfEhqepRNQ3XKOhhB
X-Received: by 2002:a05:690c:6287:b0:7b7:c5a2:fa49 with SMTP id
 00721157ae682-7b9eced6930mr181294537b3.18.1776773238303; Tue, 21 Apr 2026
 05:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54da3df9-6c91-4df0-87ff-1975d536761d@blemings.org>
 <CAEoi9W5o_twDPYMZDqajqz+UYJm5wOvAx+hUFefXmU=vUbOgtg@mail.gmail.com>
 <CAEoi9W6vTPPHh-NBKZcgmo7GKTecQw1UuZ4HjwNTzqvNXWC43g@mail.gmail.com>
 <7a9547e1-9958-4bce-8547-71a93153a0d6@vk4msl.com> <c412bf83-e8cf-4a3d-8619-63f68e108399@blemings.org>
 <CALJxBtX_T8sv11ank-arLfoVqJqXegi3D_ZT9ZFbMHkuf-2RAg@mail.gmail.com> <5549733f-c9d6-4bae-84e3-285a317ee334@blemings.org>
In-Reply-To: <5549733f-c9d6-4bae-84e3-285a317ee334@blemings.org>
From: Dan Cross <crossd@gmail.com>
Date: Tue, 21 Apr 2026 08:06:40 -0400
X-Gm-Features: AQROBzAzZ0GRugiuEw5UqkQyvcGzt_cc-9lr5ym2yuO6kTF9x3niAKkyk3PvjW4
Message-ID: <CAEoi9W4L3WTVv5Hhiec8D8J=654h-p+Mh_Nd9bbm_cDyardsVA@mail.gmail.com>
Subject: Re: Discuss: Future of AX25, NETROM and ROSE in the kernel ?
To: hugh@blemings.id.au
Cc: Steve Conklin <steve@conklinhouse.com>, Stuart Longland VK4MSL <me@vk4msl.com>, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280097-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[crossd@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blemings.org:email]
X-Rspamd-Queue-Id: C345D43A782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 2:28=E2=80=AFAM Hugh Blemings <hugh@blemings.org> w=
rote:
> Hi All,
>
> Just to note in this thread (top posting as it's a bit orthogonal to the
> rest of this discussion) that events have preceeded us somewhat here
>
> A patch just recently submitted removes the AX25, NETROM and ROSE code
> from the kernel moving it to the mod-orphan sub tree of netdev
>
> https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/T=
/#u

Wow, that happened much faster than I had anticipated.

> A shame but perhaps inevitable - but I think we have a good plan
> unfolding to both take care of medium term maintenance of the kernel
> code (in tree or out as it may be) as well as a move to userspace in the
> longer term.
>
> For the benefit of the netdev readership - we had a thread over in
> linux-hams on this but that may not have been visible to folks in
> netdev.  TL;DR: we think we have a way forward but appreciate this may
> not be quick enough to meet the requirements/concerns put forward
>
> If we can delay removal, that'd be grand, but appreciate that moment may
> have passed.

Personally, I think this may actually turn out to be a good thing.  If
nothing else, it's a forcing function for the ham community to get
serious about providing an implementation that works well, and in the
short term, an out-of-tree module can keep things working for folks
while alternatives are investigated and prepared.

I appreciate that folks want to discuss timing, but it doesn't appear
that there is much else to be done at this point. It would make sense
to continue discussion of alternatives over on linux-hams, sparing the
already-overloaded readers of the netdev list from the sordid details.

        - Dan C.
          (KZ2X)

