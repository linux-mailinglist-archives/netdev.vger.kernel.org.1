Return-Path: <netdev+bounces-255703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOBwOjojgGlX3QIAu9opvQ
	(envelope-from <netdev+bounces-255703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:08:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B6C81FD
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04DA8300F9D2
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FEF27E049;
	Mon,  2 Feb 2026 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IvWIS+Xz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C727B340
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005284; cv=pass; b=e+l/liAUubAY9Onn9hpsHx/LcBdyMAyVCJM37vgxpGA8afmqjLxlnXRyqWHI+9f3LhUDx1tQsCLXGmd9ybV+cSmRQAIkq6E/L0EzE8zEOrNpUf7IfO8GjrPI2MBItit1v+zNnDBQqjZ+bflu6WW0vDxwA/VvgaDrMEfRelb84gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005284; c=relaxed/simple;
	bh=YOKr40N5NMnJSSsWi5gI3boLeIf3C3Tjpjo+QN3HJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdfz9T3v2Fzp0hQ0nRipZPzZ5o3ceLbYqEYX3PQOSls19WqvuP2HQ3Bodzvb9GCUBSCx//XO7PviZ8dmA1mGMx5Qp3ZrDEXkhbnFZf5riEopzx3xfUHzkwAeuXAz+PYn40LUoVvgvfVnUnNgRa0bXgTwCPbXsWgMGzubaQGskzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IvWIS+Xz; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so3110520a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 20:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770005283; cv=none;
        d=google.com; s=arc-20240605;
        b=aZzgNPNeu/CoKEvPMOGMlqOeYY5CU6LLDAiHeHIdymSpCn1FF2hLxo03JqRgOQ+gca
         512zpOQzlWcAZITexrtK03G/RWUc49XJAK49D+f4jgAHMrDBvSdz0iSzY+zXoVOsh+qH
         4PIJsX4OPFHIqWkPsKu4wsrQ/B9MydDYr0T+ly1Qykz0g6ZNERnVONzFDRt00zMN5idR
         xmrhlPLwatkZHXkv0Usq5ZQrHkoGaSy7AqkjdfOuWMHHA/OOX7RGXxkkXz4JBH3qLPVg
         Lrfk2xL8+VUCBdXCdNa5+iUgsd8Tf+X0LaTp4Rg0CbHiW6YDuqcdPxtX0zIbCPOkti0d
         d4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        fh=E/Xc0oC8vd26r9Af1kCsdX5ecafYKfTV8kBU38a+898=;
        b=S6OtXVQ+fIo2sfdyKSH4A+4hhnY5dqV8r4hnVGa5hlNFvtQbiuTSiBoVfC45v/BAZZ
         akYZKK03HcvbA23cHEg9ea9zZ4UB9S/ueeRjh4p6+oeoB90kqZfvI7hBQCt6/GyZOYNf
         SMGvl7HHriYptsj3tQapnFlp4Dnzv3INOB1nKzktSAtAs9E8/zEP/BT6nrquVv1ZGbDS
         ZrYQ1VhOUuYG1JtT5qjRr9SqHMJnWM2cel52+KrK4BuXdLXcVQ+Tr1k0oM2z+PV/QAo6
         dGzk3huypHGJk0+BKSBYbdyN8iZo2tAPtzE17k/v7aKZwOtF9hWBuUIZIa0Oh2f36aoL
         TMkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770005283; x=1770610083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        b=IvWIS+XzZ6U7rFPnUSWCGO8Q3sknl0BedpgeIZL6i8mAFEWGtcK5Efs2l8bT8pM6PV
         SGcDQmHDZ2mURMsU9hej5blJxnPZ3iNIuBcZPQy6nXkhztPJdB6dDkQCtYefYPl30Puo
         /DJPPseUGvDG0ijkPFAo4Nzv49LIKIxHY+DYElnW2U9NIhfj7cLnyodQWno48Oem4hJA
         SmS2rCOdhbxZpedZMgomtz8EnynLBJDX5PFDpRy83dJ/JMADB5zhhdFQbEcLabIFADqL
         QpDxWjfjVjeaxnwUdbnXriMMXSU6JrOnIcbyOzlsfYYvmlpXoBJ1MftB7Nu4VlgNhZQk
         +SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770005283; x=1770610083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        b=bs5hFRclLyqTnccXrjYJbSxFzos+M3aj3XF6aHDQpuesFL+zzMOopJWdDqpDiTtZ5r
         lfReyz/+2ar5b6j3N68TSeZmj8nnqz/b9cFf1Asxu1k9pJiImaGJxw2i0XoBgaNvmqWv
         LAW6CTsLsGdgHfDEjqBri5julrn6bQDB36FZldfLJzREMjoPEWZFm9Kwhr43Ry9tcPy/
         BIJ8S37dEhBcnrFj3S3S5Ah9oUuWgKh+2mQ6j7PvfSTY/uBUQum5r4FtQ8fe3geEQO/x
         8iNwu36ICBQlY6IXwIG+ZSwqAkeQP7t8sBCJ3bUWRY5TncgWswNlIRP3ap+q5lEF+oPC
         g5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVY4HCEkcWPiauacIQ9ZeI13r2KfuJfA84AA1fbMRwyyLzJZXjIEcveA8lKYw1MP9uzefiIxcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXaNRzdTdfz+ILfo9ruF6AmrCw0jHFMOHRuuvQMElJuG36UHk
	Nn30ye33cyVgohJ3OQGFbh/b26oJM73daXux5yz8egr2bdW6jExVndMkJLE4gCLXV4JdrU5aRVS
	HSawUl1OvSmTjAA4j/PZb2oJvICM8WiyPVj0j5Rwy
X-Gm-Gg: AZuq6aIW3E+PU3gNyWZufY3JX+Ful99cwawxeb+w/LgZXkpmQkj2OE1SAlnpZYofcbY
	Fw7d+cUX/dotE1yaQth4zuMvGtaG5kHpSVj5wz5+ZFlQibnw4z24cJhD+we7dZMyJL57HLAm0c+
	nA0Hm/AyEfGqY+bsM+A8B+HH3APIEv4Yww4LRMVb9GSo2OaZ7TzRldWcMYE2p6HiuvUCuFVKmwc
	dCkYTPBD0i0IgCOpcl05yMIQR8p7f/7AfPjihqJG2WHWG4lAUJssfFylEaGEQAKYZD8+h0=
X-Received: by 2002:a17:90b:2e47:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-3543b3e3a6amr10303423a91.37.1770005282654; Sun, 01 Feb 2026
 20:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com> <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
In-Reply-To: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 1 Feb 2026 23:07:51 -0500
X-Gm-Features: AZwV_Qj0ZPr30GBIZpy2KTBmQCeMzIbAaQJB4ILIbQRznBk2H145kQkQiYyOBUA
Message-ID: <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255703-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 526B6C81FD
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 1:01=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/31 6:56, Paul Moore wrote:
> > On Wed, Jan 28, 2026 at 5:28=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> On 2026/01/28 6:59, Paul Moore wrote:
> >>> It sounds like we either need to confirm that
> >>> security_xfrm_{policy,state}_delete() is already present in all code
> >>> paths that result in SPD/SAD deletions (in a place that can safely
> >>> fail and return an error),
> >>
> >> Yes.
> >
> > To clarify, do you mean "yes, I agree", or "yes, I've already checked
> > this and can confirm that the LSM hooks are already being called"?
>
> I mean "yes, I agree".
>
> >
> >>>                            or we need to place
> >>> xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> >>> safely fail.
> >>
> >> Did you mean xfrm_{policy,state}_flush_secctx_check() ?
> >
> > They both call into the security_xfrm_policy_delete() LSM hook which
> > is what I care about as that hook is what authorizes the operation.
>
> I can't understand what your authorization is.

I'm asking you to verify that we have the LSM xfrm hooks in all of the
necessary locations to ensure that we are safely and comprehensively
gating all of the operations that result in removal of SPD and SAD
entries.

> No authorization can be placed during must-not-fail operation.

Of course, but that means that we simply need to make sure we have the
authorization hooks placed elsewhere to ensure that users can not
remove SPD and SAD entries if they are not allowed.  I'm not arguing
about if returning an error in a place that can not handle an error
condition is correct or not, I'm arguing that you should audit the SPD
and SAD removal code paths to ensure that they all have the proper LSM
xfrm hook authorizations.

--=20
paul-moore.com

