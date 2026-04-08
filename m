Return-Path: <netdev+bounces-276507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF1hL4ZP1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E723BC689
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A20B3002B5C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437426A0DD;
	Wed,  8 Apr 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="HYaswijV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB52F39AB
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651992; cv=pass; b=SQD1jP3k/qLDbHe8VHcYiGdVy7qHNhO6Dgt0uTI9pKX3DdxGEzm2NO2saaf4iqBzAAFV+GWGixV5T8+FQg7TInUZo8JoDR7VOvbksqivLsrGcUWklCKiDdG2mf6Y2GGdpLrgrPSxDruuTPeOdQ3EgSTxHxcyLVWR6QRVpxur7sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651992; c=relaxed/simple;
	bh=fHgOpYV4fzqqhv3xgr9XUCOgzUgIGZdpDscYp19R3a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKXoBqwRLrxCavS1jo5CzTzG90F1osQVz0tXoAsJVn1COeqFlaNwT8xFKlo9HgLY53E2SB3l28fGhfb2Kj13o4sLxlJNhkO0EXceArR60Iu+85KD7TxLmG8w8PpvPC/uL/aaHo0lwk6T8heXNe+owuxY+ddSyfABwiKRMSOJdhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=HYaswijV; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82cf83bf375so2560186b3a.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775651990; cv=none;
        d=google.com; s=arc-20240605;
        b=f2gJbmfGiJehfOqeOMoa/0QTO4cccl/hFHAhEC1lw7FlIGhpy4zj9FNw0vi3/QRrBo
         SjP9OCknoX/AUN7nw3RC5dgpweUA6lzUPTrsgpX6eu4neA/aj4lBVaoZUmcms8ebtyYg
         wx6zmPEKEmA25AdXnJlNcYhVpBT5JR7sb2WCSA/PHBjTiOy9P9Bbr3FQNomePWUGdLiL
         42fnOZq0QempoV0r0s01xXYR18cmy+w2K2hmQva480pFwEA9QxAi69h4eoX6/DMjddVI
         q5hOxHgeOSZ5NypkEK9FZ1NSKP1x6Dp7tPPEW8LiAevXm6MIC3oJP7I8y1Er40uWWdbz
         lwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E191xZ6QDA0FNa5/qKilpMk6DpWFtdCsbSwOmXHS168=;
        fh=y+WlYgGW2jljbzGm4opOMogERYkn1mWg9a8hsRau3hI=;
        b=km6D298y5wycxgXM8K/Wayk7QL+U16o4+L9qkWbq0bEszxBzj+3fVfqx0rvqbeKARx
         jal9ZE6lCT5pCu11+L4hrSaZPfxQQ812hEJ9WmANOVJptfmhITWDiU+u6QGKsu8DhQqh
         OhY5A1ZLUCrQzSm43KXCPWKCD75PpYNpFR4d72hsoq5HA8+Qflr72gmKWXcVTox0crHI
         Mpfh45In5nGtRfzfdDxNor3NPDH2T5W/p5n/hSeQBdsjSM55N10WRfTcN1AnqPCYy3Vv
         JuubHG3bJyfEaBBbSBY3679m2TKuaKFpiUStEEIbubS2LckcP2SNqebVNV3xDkIArWzQ
         hA2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1775651990; x=1776256790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E191xZ6QDA0FNa5/qKilpMk6DpWFtdCsbSwOmXHS168=;
        b=HYaswijVdQ4EdHVyBeW8kHSEcZn6BOlLEilNPb1sPyggfLG18T8Trni8e2yCpqz6PK
         gADb2D5UC31XfIOZsqU0kq+vqLbfqewDnc6m2FtzVpcp+MuPGqNF6XGFySY3pXI5bKez
         vfHMGIXW53afSSrfmB/8yRBhs91fYJWSMQyQa1fuZZzbE0p9D9bzSy4jrnWXSMg2plfr
         EzhnqY1BburGOSOawrD2rmdfUm/83WXRL+biCK+xT8HrJ9vyXOMKzKhYGG6tcFpWdp/v
         HhPvODa63GMd40TKpTDqfZ5F+HyqsvFIZ35rmLd3pT6B9P9BBfLzbKtrk5JtkQfvjozH
         jy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775651990; x=1776256790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E191xZ6QDA0FNa5/qKilpMk6DpWFtdCsbSwOmXHS168=;
        b=YeeLi/fgepNTfOxOGs2bOc2rYAcZRjkrQXIA3/W3dBq6j2V0apy26eYcvIwroEvlVe
         +KNwfsVxboRAFia0zCHbn1WuA0RcjINHWWhTTt5hxVPyvxzvk1voawBiARVenn5rLIjp
         Agym7Vgk6VRZ7RFtUFyz6z2srmqMb5wZ6fVexC2XvB/KrsKmvHH9CrUa0o02sIw2dfeG
         knAqm9s59bYLV6Lf4D6mHLGIy4g0x+NFXwFseuGXKjJjY6/xMgpOrgW7H26shMClI6Yv
         fwdX02tv/uyQpxTaVMoNDHgt+bmOPfFuGupBZQ5E+CNRPnvMYb+QoHZHIWhKU8M5RGXp
         BnFw==
X-Forwarded-Encrypted: i=1; AJvYcCWQGzunrVU7s488Aex7hYEBwfMfw6olj+okiGmvPAyDwwp36YmOZL1uRmLMTtPEyEN98lg3TCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaiebsX7eIerugTwjUer/zj/XyaV8gNSq6HAZGogKXU75N9rE
	09wtn8wAUX8YRjDA94qb/3n1vRbJ2bmBu4aHH5WY1L5YhoIBfM67RRPAsqJPQ1E4IQTYNqSWJvu
	8CQ3fFl7dFebdymfJCF6iS/5ETgLXFWla9bjymtNS
X-Gm-Gg: AeBDievWaCsZD/1w2OAaUkK5CJnBKnMbqBC/1c9yjrw5cpkJMzrUMTdxw3ErfBOmwzO
	aahx1FNdn2yEYIRSqgITyYAPr0qN6khVqZzIT222WGnBRsGJhGIYQ9l0NTLuHN4wQNHe1ciOJ2t
	fpEtuP5OE9//W3j8oAy3JdoIdBVKgbD43YhH9KOCfLc9UZ2lyl4THj00xJ7JVcT/DjAKhd5hAxI
	SaaMLogn1kMXoeaIxdhjTq4EnM7PJb8mSWm93amB7hQZP2YpYgWwKGCcRdQz7i8+6zZhtupUwSk
	BYcRQfAnnOcUoVda5Yk=
X-Received: by 2002:aa7:9064:0:b0:823:9b7:9c0e with SMTP id
 d2e1a72fcca58-82d0db3fcadmr20184474b3a.34.1775651990444; Wed, 08 Apr 2026
 05:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dcd085bd504ec1d0698690e08e2e1c4d0edff8e4.1775232030.git.dcaratti@redhat.com>
 <CAM0EoMm2MpiZ-Rn7PVE8rYq8bOkrqs+0PAjuLi23iLN6Eih2sg@mail.gmail.com> <adYRpRrnIdUnglAy@dcaratti.users.ipa.redhat.com>
In-Reply-To: <adYRpRrnIdUnglAy@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 8 Apr 2026 08:39:39 -0400
X-Gm-Features: AQROBzAsUMdsSGEgF_nlWPPpsiNhB-cxd_O7OxH5vfr3PF3ZuaM3pkciUIljxBA
Message-ID: <CAM0EoMmazEniasUWUwDQ-=uWbF5o1kSU4HMPNEDcOrv91+CrRA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cls_fw: fix NULL dereference of "old"
 filters before change()
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-276507-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C1E723BC689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 4:28=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> On Fri, Apr 03, 2026 at 02:59:22PM -0400, Jamal Hadi Salim wrote:
> > On Fri, Apr 3, 2026 at 12:04=E2=80=AFPM Davide Caratti <dcaratti@redhat=
.com> wrote:
> > >
> > > Like pointed out by Sashiko [1],
> >
> > Just found out about this ;-> So bye-bye old AI? ;->
> > I must say, finding this specific bug is impressive.
>
> [...]
>
> > Observation on consistency pov:
> > You will always get a "q" when you invoke tcf_block_q() if there are
> > no shared blocks attached. But that doesnt mean the "create"
> > configuration is complete; it is only complete if step 3 above
> > completes. This is because we are not sure if change() will result in
> > "old" or "new" lookup setup. So the check you added for q may be
> > inconsistent from that perspective and fw should have returned -1 like
> > all classifiers...
>
> "Hello Jamal, you are absolutely right! (emoji with fire) However, ..."  =
:)
>
> > I cant think of a simple solution to verify if the config is
> > "inconsistent" other than to add something that gets checked in the
> > datapath (and when absent, return -1)
>
> ^^ This. Specifically for cls_fw, that would mean converting fw_change() =
to
> allocate some control data also for the "old" uapi, and I think it's too
> much effort for the legacy.
>
> IIUC the inconsistent behavior is: for a small amount of time, fwmark
> classifier used in the "old" way would classify also when the filter's
> 'handle' is not zero.
>

True.

> > From that perspective, your check is not catastrophic, so it may be ok.
> > At minimal the Fixes: needs to change to Vlads commit? Good news is
> > only fw _seems_ to suffer from this challenge...
>
> This is also what I understood by reading the code. Sure, I will edit
> the Fixes: tag. Thanks for reading!
>

If you resubmit please add my acked-by

cheers,
jamal

