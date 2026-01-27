Return-Path: <netdev+bounces-254012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMfmA1g1eWnAvwEAu9opvQ
	(envelope-from <netdev+bounces-254012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:59:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 697309AE0E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268DF301E973
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F53321A5;
	Tue, 27 Jan 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JMTs7/Kd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A4332EAC
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551189; cv=pass; b=PDW44qC9efDGBy1IH0x/6xPIMn+YCVuqwiEWeuM89WeVFnPUN0n7RVXrODBUCqZTTeAMkbmODB8r4bF7NR5z8ayprxTsLHG1GK/oYVL2yFfcTrFQQiMbmhz9d5K48mPEX/3AoukE52YAyRfrk3wgU+JgAU/Y2gvY8g7LrM5nBOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551189; c=relaxed/simple;
	bh=iEljPudkY64iSiYqxMk96XjA0vobla4RgCkNZJQ8tPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl0ps+SH/AoXGGgeTEtimAFMgn9jePAz60uwjdED9pW9iUv+340dSIeOUz/VYS282+/sTJNGvF2a6c3wRMgvP7EUMCAgKfQ3eucF3hYWAuJ5zTe/HWD0i4/uLcfo46gzfOF07Y5JDRm3+hgUNqTS//HLIU4NEnxWp67J0xpF9qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JMTs7/Kd; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso190843a91.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551187; cv=none;
        d=google.com; s=arc-20240605;
        b=CDlJUvdWd0YcuLq2fFE8ZiOTYxO5kbnYYPJmueBVdLzqHjoRM4nIetfBMkWnlRbi4Z
         aj71U3NQLrHw+BAKaKbE3mxLszErxnZxkhtezIun+WWeUwuRRu5dD03m0KPqSAmO54df
         4CDibemmhIZBwE+bnrlbzKovWGthVQBL1hSPfdaLvT2tmcn+e4gkRXe+3UEw6Oal1alJ
         P203zS5YVBVZ0ZnxF3wCLd6IAv1leJN09RwoygOfMGF6RNEB9rleApKZQgntbGtyK+nL
         X7WeLHJqdZR6RSFzmWULaC/zmwbiMX9L6fLYZTwbvtq1iNXmjpaWn9XSfsbA4Y5GqHRu
         TbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        fh=L2xVNCSP5fkaYbCrZF9oHa0gxfqHXnCn3kh9r/EgTT0=;
        b=HWPGnbZYDKIVZw39ty3xQnvzk+KKrPOhyJ+WmiIbrQ4DWGJEf+wPjCpbC01agkP+L/
         Qnr6TEEPOfgsVkGMl68hCdYtZSQk5m4nORoS9c0zWDeGIpnqNEjwr2PjzNv/UTxqZEGh
         rSIyrQU5TBER3lG1mKRQjOrN3LGWhEu6s2H3ShxYALhGnUoHjN6cOEklqxXepDPwzgeK
         GVU5oOPizx382ircszbecotmGUbYgWxp7hpPeqJ8xlnmE/Y9PUhe6OYkW+l3OJdiJflb
         ctx+mli9JiOADX5gPPHfk8+ewfeTFl7ERRiwg0USpCm8W763sLoHKz/LwMam6TWcCSPh
         JSeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551187; x=1770155987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        b=JMTs7/KdKcxdrGHC9AxwSrl7pGUSUk9jwHQczSqgkGpi/CHtAKQxw4q5cLAwykh/fG
         skVxRkLh677s9HCG1jzpiaLsQc5WcGD2+l8JC1inqX68k3eVANi6eqXRYDWNkZoJKfzq
         KcsQqyxJ16yDe5Gmkl7NKPQahYfiTZ4lnS+8/t4bd1tBseOmH8KfgE9sYNy6mcUw0786
         w9TP3+ayqGx+MNkNLyDBcq7yU+4YwjZcxs8np53XFiWYGdyy6tKvV+RcfLITdfstnW1j
         X8X1vjbPpaPdotfnbJwVqUpqudgH0prRNnFonLR845mTgTvD9b0H7wTIhmNoZwMoWuSD
         NfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551187; x=1770155987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        b=TOrmB1MZ55856WKYUL5Ot3EM+j4Mng9HASoEhI5vr9GzPh/nnsFcpcv+9MXPuzlBpH
         zKX8ziRVKIQfEbnKkppVBqSviK+8lrhxGR2LJ7s7trvc/8JYGw14BVPEfoIaSfyR5jwk
         btvIsis5i+tX6kk747FKparYBdAhw28BOwsReNm4EO0Kx/BemDSFGDupbBRMkxGOHdt9
         AqHMz7OykkLh1gpzCqBPxjJLFvq1XuyWFtlv3EvSL2qLAcMnAt30tL7SzpjRfTBLRVc0
         TnC2eYk8g06z9Pz/v67cWMBCICXXwBP4AwiHPgnE8FcqADHhqxf997J9c+K9XhAlHxyW
         2BDw==
X-Forwarded-Encrypted: i=1; AJvYcCWczISQcreGrbPsRp1/Xw0KUYaWcChiD0BrSiJ/LJrx6Q/z1QPLsjVbjsaKqd0eGx1WYCA/2k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHOx8+aPPcoT5GjEwafOwkIz6UTDCV/0uVDB0AfKaNeyAiXWO
	B/DHc/ojHg64Ur5FuYxIV9Pk443wMBY+f85w0dvXg7GHVDJpMfobLmccTuSblunTfSzzjrQSLQv
	jIy7tS5QwQlx9wxwTPQi5/VwQYTViKa+Ccxld4YpM
X-Gm-Gg: AZuq6aIn1Mwf0MIoJ9Fk+tVIzVGYNChlHpDkhUwU9BrgZyBNuAQ/tAMxILRQbrlD5Vt
	+JuXjY7UPJ2rgvzS7cvSMMK0MskWc3mo0mqCAqGHOYTist4bhgz3xMTpQO1YsEhzlNtxn0dp4aI
	imCEWW8pM/3FTEcLIzkgg/EK3OC8T9Mjc0AS9NqhUJ3AU3bxIy8FQxRIQu2B9+aTIqU0ahC0ANZ
	itn9xALNo0bI3+UC7ypNBqUxOWpxPD8dPdGxxrU5WFY0Y8IGDrQ25RjWDZj3yT4mg/cCw+dXNPO
	32ShBw==
X-Received: by 2002:a17:90b:3c4f:b0:34a:a16d:77c3 with SMTP id
 98e67ed59e1d1-353ffa2e81bmr2407723a91.2.1769551187312; Tue, 27 Jan 2026
 13:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com> <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
In-Reply-To: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 16:59:35 -0500
X-Gm-Features: AZwV_QjHjF_BvN3T07RPQg-eLzyv77ege_ZVuB2hfBf8S1skY3WEi6mlROEWEsI
Message-ID: <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254012-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:url,paul-moore.com:dkim,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 697309AE0E
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:51=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/27 7:33, Paul Moore wrote:
> > On Fri, Jan 23, 2026 at 5:13=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN=
 and
> >> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op=
 by
> >> returning an error value from xfrm_dev_{state,policy}_flush_secctx_che=
ck()
> >> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_chec=
k()
> >> returned an error value upon NETDEV_UNREGISTER event, the system will =
hung
> >> up with
> >>
> >>   unregister_netdevice: waiting for $dev to become free. Usage count =
=3D $count
> >>
> >> message because the reference to $dev acquired by
> >> xfrm_dev_{state,policy}_add() cannot be released.
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> ---
> >>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
> >>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
> >>  2 files changed, 68 deletions(-)
> >
> > I didn't make it very far into reviewing this patch, because it looks
> > like xfrm_dev_state_flush() is called by the bonding driver's
> > notification handler, and I don't see that reflected in this patch?
>
> xfrm_dev_{state,policy}_flush() are called from only ...

My apologies, I was looking at the patch too quickly and shortened
xfrm_dev_state_flush_secctx_check() into xfrm_dev_state_flush() when
looking at the callers.

> LSM hook for checking whether to allow deleting a file in tmpfs which is =
still mounted
> makes sense, LSM hook for checking whether to allow starting unmount of t=
mpfs makes sense,
> but LSM hook for checking whether to allow releasing memory in tmpfs whil=
e unmount operation
> is already in progress causes nothing but a resource leak / denial-of-ser=
vice kernel bug.
>
> What xfrm_dev_{state,policy}_flush_secctx_check() are causing is somethin=
g like
> "LSM policy is refusing release of memory used by a file in tmpfs which i=
s already under
> unmount operation".
> xfrm_dev_{state,policy}_flush_secctx_check() are too late to make LSM pol=
icy decision.
> A must-not-fail operation has already started before LSM hooks are called=
.

It sounds like we either need to confirm that
security_xfrm_{policy,state}_delete() is already present in all code
paths that result in SPD/SAD deletions (in a place that can safely
fail and return an error), or we need to place
xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
safely fail.  The patch doesn't relocate
xfrm_dev_{policy,state}_flush_secctx_check() and I don't really see
any mention about security_xfrm_{policy,state}_delete() in the patch
or description; have you verified that the LSM xfrm hooks are still
being called to authorize the removals?

--=20
paul-moore.com

