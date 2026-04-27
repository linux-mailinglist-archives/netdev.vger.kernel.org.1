Return-Path: <netdev+bounces-281262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO9tAbce72ml6wAAu9opvQ
	(envelope-from <netdev+bounces-281262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5846F190
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77BE63000B3A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA576397E86;
	Mon, 27 Apr 2026 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOwPqjfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D0253340
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278643; cv=pass; b=q465KYKbhf3YJhIi6R8QGanu9wcf2cW79YCDo6ijaB3Jk5CeNwIImYTnKRMVMHtu+JaMWinNJDkSxqxHVwiQlQRWVtsbAnYd4xHdhpVsLMZwxGckRNRln3T8xIaTHXcFjvL2ZP6IRNQx6D54DpaO/UzgKY6hc1i/hjTD8APac08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278643; c=relaxed/simple;
	bh=eqjT0Kr4NV7zi0GO3k0PPGjVw8ZG2UPB9oBwTiAjBzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feSKpDipEmZoe4iiz5BXGZYacEgzX5Tl10HaI1CqbNbdmqT7V0uO9wxyErmoAxdqrY2Ax49HLsmcvmYbmjRD1DHB+Bmg1m5jYgeDiAjhQn7bzJ9oZVuxx0n5ZtgCduyirF+vdZih4ZRAko9sorFYry1EzsFzSV3fU8XVP18/bK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOwPqjfu; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5062fc5d86aso81621211cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777278641; cv=none;
        d=google.com; s=arc-20240605;
        b=hYVNkPBD6gV+yUSyGwONBGLE1o4bBdl0acvh7CVBNhmZwOOJc/1ixC5RbpDVkIndu9
         0puFRuLnNNdF7w1zX1r2CBWLRBxliGBok5dN9ThdK8j9Uj7uVy4cR+pf43ltMBwpHwsh
         gud6jdmUCaQf4LF2SkOQiuODuOBAqDc1Ke1cTLFRQdR2+CY6IcgGCF1diV8Zgsv+dAJq
         EtXGm5FuWPiT4pKOVHT7LA6SuvgDGbKZQZ4fU/+DTpqOly5D/ELB+mkYVniPEP87xkxI
         Voq//Ijl12HM+Vfh4/7orhRTMJdobbiv6rjz/uxuGB2CGdO0QE3jwkt8gDGLLkhxcNgU
         Ej0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eqjT0Kr4NV7zi0GO3k0PPGjVw8ZG2UPB9oBwTiAjBzI=;
        fh=Nmq+bhBLFbqD1rQNsTkZaMffzahkmMEFGgcMEKW7wbU=;
        b=dIIsZ/MIsLvj/FftubwQuVU6KzaT5mwFEKdTiV9bhG8Bu0VDahNk5DMlsinPQhN0fN
         yxcRGUDGNU/goJk3FMpTe5GKjC2Hiqs+ttJWZYO5eD2w3ZtTI8uMVK+K4kFIpQ3LTnq1
         qKs55/7oW67kaMofts/TdkZ/ggFDfV2ms9fFUQC/ERpzeIua8RUff+9VuDPYQUkBuNIa
         pK19RigfmKKmhfy4p46JQtTgKmwHDKx16fbCDeY8uB6rqkSopCi3CCLzR5g4YpIy+8p/
         sL5kcXTLtfMkfUyRI1f1QbrCy9WmOkvRymJCug5qxUC5/65cWePZ5yI2hZwjqif9ZIMU
         Stcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278641; x=1777883441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqjT0Kr4NV7zi0GO3k0PPGjVw8ZG2UPB9oBwTiAjBzI=;
        b=FOwPqjfuGFEM45SRFdweGg3NiJPaHnXJoohPxNHxTHvHPf1+ywDJ8ppycZsG7GWaNW
         xt0kpG4xrf3OM/UJefoGn050xWKq8AjnYusC5zukxHVwNPWWlZLsRcI6jxCZHfxHLC0M
         IPtXRCWn9aUtrA6wYbHVlfv/65rTIjeGtksR2Fjdgs7JU5WTe96lTdI6I/nasz0Q/iLk
         Sg8VHqI2Cibu2cb1UbCzV3ImTuI9N6/2M6hsdKL7L7MY5D300uFtEf5fkdflqr1yCNOu
         SKRqiJ3wCdrL8QrhgtkwKZc3vprqJzjT9ChHTDHIWcMzp+CHUKHVQ01doyZ8MIrjFr6n
         9Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278641; x=1777883441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqjT0Kr4NV7zi0GO3k0PPGjVw8ZG2UPB9oBwTiAjBzI=;
        b=n8xLoCcZyUTBWw1TgtkDBBSA4cJTUKzfbFS/aSVC9sEsR46Mo/CsDIhJQicaGvPjzK
         zAToVNTCAXuf7j4edvMnLI6n4QIsvjmdngYoldrEIU/7QWAuMuX2fgyuuo1ZU1g4G4Rr
         yx+p/LKBbsWiYCaPGSmYzld3r45uXemcyir2FKkWlSLoSjsavIZCVBmuvMCEpA5Q7RwG
         IGks3QJeKNtuXH82yh9E/JVVaDTNp3ustMHSAANzSEb+cK3zCbZ8qBc9UF+Q9oFIZTik
         B81iMHNwervwCklxEKS2bhDpA/cgBSZ1g0XtF9Y4ERAI9l3CHKuvNTUB8seut3CKxF7H
         NEww==
X-Forwarded-Encrypted: i=1; AFNElJ/aiHHsaaG3iU3XvEnOUQc7iKLoki0u/4fOAjHB1b21ZyT3vaQ539h5T2JvqwYzBXjiRJdGR80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPH/WTLImotrN19tDflcQYO6chbQ13t/8JKeQMtbQ5iHqAkNr6
	j6U8sLw9qYb4ZNmPDy6o0TweYTn3f5XFe4IRsWktgW86wUjomtCe4D3kP/2Nwh3VMoXlHYWeu0n
	7gE+oqz9JX728r0nGZ2CSYo91pmwIYOlB2Qa9u5OO
X-Gm-Gg: AeBDietK59oz0E/rJlRfJL9Enk277Sb+REUWJmabkDZRP/XIHf+ynKf9PndqkAamYbj
	ROa1UntgsvpkgEAlsHY1Wvmy9a5JPt7H+WTgnsDdB04rWyqUJUIlEso+nCnDbXwjcVCoqYUErTY
	mluViS7299dMl3orcxFnC5LfV3/etGigVuFduMnCd4F2ojDFL4K9wLjXd6gi2bfgsXQPBrYy+a1
	K0qI2ZhAjPfibziwbsLhLDCUN09iyS2Q+/10qvoSrJYE2sCNU/zo/syejAD2QXhywDm7rwc6fjz
	ws88PFWvsBEbKtIi7bkDu7krM1SEXcoI1tXwnz3Tjb3StyMvDXtEQLNYb6UtdltYz8AH9/KfG/8
	mQu5ql6jkar0oNjFS7gw=
X-Received: by 2002:a05:622a:5806:b0:50d:8903:ae6e with SMTP id
 d75a77b69052e-50e36b87672mr652226541cf.5.1777278640970; Mon, 27 Apr 2026
 01:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425075521.736328-1-daniel@iogearbox.net> <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
 <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net> <20260426131714.GA180947@shredder>
 <dca69fa4-2284-4251-a569-8b26ab9fca07@gmail.com> <20260427060127.GA263748@shredder>
 <55ffdceb-df7e-4bac-8f7a-49cf036f7c50@iogearbox.net>
In-Reply-To: <55ffdceb-df7e-4bac-8f7a-49cf036f7c50@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 01:30:28 -0700
X-Gm-Features: AQROBzAafHPISM4DmTYBlPDsbBE8J59UYZDYy1SCw0YD1FXpGPKNZWFOIlz-uS4
Message-ID: <CANn89iLTsBuKGyV4CZoEjoRQkYHOg=qMNiKV_mu+6j8-_8PobQ@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ido Schimmel <idosch@nvidia.com>, Justin Iurman <justin.iurman@gmail.com>, tom@herbertland.com, 
	kuba@kernel.org, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 99D5846F190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,herbertland.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281262-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email]

On Mon, Apr 27, 2026 at 1:23=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 4/27/26 8:01 AM, Ido Schimmel wrote:
> > On Sun, Apr 26, 2026 at 05:47:38PM +0200, Justin Iurman wrote:
> >> Ido, Daniel,
> >>
> >> As I said, my vote would definitely go to the solution without a sysct=
l for
> >> the very reason Ido mentioned. Note that an upper bound of 32 is kind =
of
> >> unrealistic, although super (SUPER!) safe. Sending more than 8 Extensi=
on
> >> Headers (assuming a different type for each) is not standard behavior =
and
> >> would make you non-RFC-compliant anyway. But I'm happy with 32, as lon=
g as
> >> we don't define a sysctl for that.
> >
> > OK, so given that:
> >
> > 1. 32 is super safe and solves the issue.
> >
> > 2. We will likely have to maintain a sysctl forever.
> >
> > 3. A sysctl has the potential to be incompatible with the upcoming
> > "enforce_ext_hdr_order" sysctl.
> >
> > I believe we can just go with the simplest solution of hard coding 32 a=
s
> > a limit and drop the sysctl.
>
> Although to be honest, I like it slightly better if we could actually con=
strain
> it to just 8 by default rather than 32 given 32 is just an arbitrary 'lar=
ge enough'
> pick vs 8 something sensible derived from the RFC and the sysctl knob is =
not out
> of place. Eric, what's your pref?
>

Honestly at this point I do not care. I think the current flood of
reports requires us to avoid discussing days for a single fix.

 Anyone using more than 8 will have to tweak their kernel I guess.

