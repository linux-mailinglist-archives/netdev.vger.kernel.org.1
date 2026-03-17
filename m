Return-Path: <netdev+bounces-268738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFPYMqi9uWnJMQIAu9opvQ
	(envelope-from <netdev+bounces-268738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:46:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5792B25FE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F0530672E1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1473F389DFF;
	Tue, 17 Mar 2026 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JchGP02I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700F349B06
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780338; cv=pass; b=fX1SbT2dcERUw3DiG5kU3F/EqhuXMzUcCDJ2CqJsqw23wjpVaeBmoolQo0d3tqOryIwTxDbtRO0qOuf7fimEZGhhrS2CdRZp4uH7bCmpqRsrdsmVogwWAXd1ZR/IO02zs6BIa0NN6DEtn9nEusPZR+bbvy+d0861kVe9VtlVqzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780338; c=relaxed/simple;
	bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9lSReApjYfPjbqUN+rXYfHwIddlkKdBjENXv0pcm2I+tlFjvfEyBx+NU1UxjfKUZCKMo7PKvFRbFY6EWS3g3ZtCXanJXXmZlAuk8KG7I8yooWwSATU7tKDi3CXgL/RcmnYdxRnpvkFXSAGq5QmFSiek6e/jTbjwyE+Cc1P0rxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JchGP02I; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a51edef1fso4906077b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 13:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780336; cv=none;
        d=google.com; s=arc-20240605;
        b=MmC53VZCFD2QxxfRtYg7HzGCCOTDI2g0NwdGrk02XfXv4N0sGXKNrgzOucYgpehQ/l
         /FiQYqh26iU2KG9HvCDmXETxQzEpPLOmObRpbe52VGILlgm/rKYGPXV1ULJkwM8DVtkj
         /3gVInNLBZIDTk+DOyiPTfiIQO7JEtPVQ2FpoNJaAleZjzboHYdXbH6rq6fq3rFPooVa
         W5kYd2alT2KxRET+kIjb9uc73hiym+bHAni08nDwIe8fUXJvD5WTudToMM9gZ5utTTdC
         SGLnDuYw/EsC56OD1RU1FpYsQ0vvqkuGyGAH8eVwvNaRp6KG+ly0XFiQS8TCd7a2c3kI
         0eeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
        fh=FXV056ux3zHjrwFESQ3QlDQpB3X4wQskC6BZwaqtqXg=;
        b=Zg/f+DWtHVPC+RLVyWJT5jFTgJnwlukchbPKyARuWPE8wzMmdo1nuwIhBBMZjgbSVF
         3i8wyy/ioRzq0socH93ovPUZIgtl3HkNmLw9FtZixyxF2CEJjeLHm36Ah7tgPX9CG1Jx
         FcNXUzHHPFLp+9ve8r6aBGKgN+huMUlUtsY2Y/9TmS4rG1RmoeIW3116DLrO0VH9qATA
         DnamDoq9HucJ2CB/XE194LBNRmoWRpO93HKJ416j/Xtx+35wZY0sijSlSzbnHpVBR6fw
         1EtH1K1r9nFflnL/fUoTcmLxjTle5BPLICK73iz+FrJHocNWDEKsVmu+TjDWoyy+t5R1
         T1PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773780336; x=1774385136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
        b=JchGP02IlUYHQKELetDxPFG6MFJYM2OOlsa2cV4R6jNgNAPHYBCAjl3p+rYX4RaOPo
         lVzMhq3Q70kwQEuwSLiGSn7TXVCiHfamsBTUuGVcpUmf2iNvnfKbPfNNGtdGQCtDPfwn
         jN9yqfCYxsGiXogNvqFGEwZWZYi20IbndPwVFZ8ZRk9rr6QniEoB3C4yc8EemA+4V/Cl
         9DOz6WZQPbtlGvY/DJA4J5zMG1iQQP8OaeuGvwO7C3tl92IBZFeQgapXkWg+QDMcoWju
         khxeHqc2YyJ4T3qy8SXT2gu7+YBs+cPydCzbOG5GGThEHppAPk1AVcVR08iv/AuzRpo1
         xFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780336; x=1774385136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
        b=I0UDZSV4qV6NaqzbHc3QXawInzRa03WgGm2/BI+NllBACec7UgIYwxXgTkiM6aTJT5
         R3TLaIQdHj/SKO64qS88pwF3IwbF9zJRk0Ub6/MtJ+mSokiDzte0HO02wIAN1+zfSoUh
         fqWEvujLhV3Nc4LoO/dawdPRx98aT4UdqorfxDZmAQpnM9c9EI8Iv8QO3WmiQUnoaaBo
         SgKGhb7vMfIwnenXeOOgwXs0aw7BQfu8UdqrxV1uPvcbSEMZLxLcBp2xNBbibGarNrAg
         +8V32FIZU803DQN5yGdUUjlPcYKzd5gsQ4JqmpOVw/BeFfX3J4s4P4aulxN/yKK+9Mt6
         2fnw==
X-Forwarded-Encrypted: i=1; AJvYcCW/VF0lCZDGsKHD6vToZ2E+LKuTYjqjaEZ/i/l1F8z0BXDckw+DVjiYkLAKAUv5Z8kCVqQ8j4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2CbQ1oo+4N9Pq0qSjja6+PzGXwqgcR/eDCCvyBq7+OTfjWAf
	Dy4lpt4ecMN/FhrmVuw1v7JPF6ZmXX/yZJJ101dXgdkozFi/AJYdvsFkRa//pDHy+GxEPZiIIah
	KdIdUu7b3D/lM8/rzXNu+BTWa16d/OI4=
X-Gm-Gg: ATEYQzx5+jATBDg8h4I3vuL40ksPIybqU/Mv15PUIJvrEJtMD6wf4G1mXCoHLQIx8pb
	eTaQoZY+xj8RztSxNv2HJWrRmAJmREBIBxuBVcNlIZFDjLgcgkqqXdmdwbEfiw4xoxVBczN7xWm
	SFD84p+6eq/1wjesqX1Uvlf+zFNlXWy+arFOENvQ0fiqF2uDpEZypg7Xf2tRvJckUnGMzzk5olw
	7vg/RmyOh3+fkmJbJWaOMF3r1qZLDuus5kB7P4Kw6zhtY0arW+rTtOzUXXvwRwJfW15ca5mRimt
	1lroud+hb2db651I599UIZ5ByE+aBy/UZ3q7WPgIrdpDam9G79DIeySTgGeTJJVEI3I=
X-Received: by 2002:a53:a0c9:0:b0:644:59ed:dba3 with SMTP id
 956f58d0204a3-64e88ae8608mr3628225d50.30.1773780335764; Tue, 17 Mar 2026
 13:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
 <20260314094707.105683b1@kernel.org> <CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
 <20260316162626.6829f49c@kernel.org>
In-Reply-To: <20260316162626.6829f49c@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2026 16:45:23 -0400
X-Gm-Features: AaiRm51Sq07q8TCRFBGRe6oIbP4lXve558SYH9gvPIMh569-Yf39T4vpvUdWTCA
Message-ID: <CABBYNZKpwwXWVi1pvksN=A2BVWh3-omsY9wJFv0CjzUbxnH9UQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-03-12
To: Jakub Kicinski <kuba@kernel.org>, helpdesk@kernel.org
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268738-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C5792B25FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Helpdesk,

On Mon, Mar 16, 2026 at 7:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Mar 2026 09:58:56 -0400 Luiz Augusto von Dentz wrote:
> > > FWIW this is what our AI had to say about the series, mostly nit pick=
s
> > > but not all (LMK if you want me to hook the AI reviewer up to your
> > > patchwork):
> >
> > Sure, I like to receive reviews of that, note though that
> > linux-bluetooth and patchwork are for both kernel and userspace, so we
> > may need so quirks for detecting if a set is for kernel or userspace.
>
> I think similar thing happens for iouring.
> The user space patches just fail to apply and the LLM doesn't run.
> If that's alright with you please ask helpdesk@ to give the "nipa"
> user permissions to post checks to your patchwork instance and LMK
> when ready, I'll hook it up.

Can you guys help me with the above?


--=20
Luiz Augusto von Dentz

