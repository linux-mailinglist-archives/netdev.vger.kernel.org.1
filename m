Return-Path: <netdev+bounces-277455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN16BOEU2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:18:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED43D9196
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C3D30A3578
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7913D9045;
	Fri, 10 Apr 2026 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPdqteGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEC3D902C
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833893; cv=none; b=alRhUxdW+lBnY25KNvltl5o6mVaU2mE2m0Wq3Lphjextx7ZvQreSKsdeKzj2oCdOs7WiqU9y6Ou0r2fxuU4c6ZW3jforsRcqNvs3Iu1kg19uPoAAxh+6RomI1nQsiVDYsF2x7d6UM+8ESjMlgjz6eAiLGnSBdGHWNRYHd2f4Cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833893; c=relaxed/simple;
	bh=xjJORM7tfy7vWxsh2geZIlFRt9OGr4V1D2nhCg5EtZo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/Rmvqu1Fe8oBsAuinkawWZravgWpmiinrRvhQB+MZIg0joT33/p+VEBQ0scjJHiwma3de6rqPxNoT+lYkNcOJ2dUu61fn3xE0iQOv5nXybwycV24qNz8NARM1LaKI5N9dHXLmIvsC+zF1cPL7xHFy+45FjKGyDc+Llq+ILyTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPdqteGM; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d9e22176a7so1115982a34.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833891; x=1776438691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvG0lUmWvJDVV9hH9ZMs4QcX1z2+NpKGjl8rKX6kmfA=;
        b=dPdqteGMXfG9ncp72tu6tdueyp/AzdW32IBzu6cumBfqWtkJtTdQqEgnjTAVuex0S+
         QuFNDU9ssuG/62+F8yM3RQ6kkXWfGRSMwVysrJ0LxqxOyOFCwvoCt86l9f+e86cSe8JY
         050LQYdBO5WkXT3AGlpY3DwrBz9vayRg70SAFUcg4cO0nIHwTXWpGsa0K3oX0eGEILnK
         L3qIRGC23ocvMPhxcT2kWbjSRwoDKlbL31bwVVZRVCfjQgN3PgKvK9i5RTbgV4sw0C4E
         q7tHilimkIdtE1jgeb8CqgoEpUkD2xXF5rPGFaF5PMQI6BJ0VIRZXAQ6PuEu4rvFH7j8
         JUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833891; x=1776438691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvG0lUmWvJDVV9hH9ZMs4QcX1z2+NpKGjl8rKX6kmfA=;
        b=IyWtFpLidBv008HdXX+rLIRbn6IOr9qXJWl6urbNfU3EoEJc1qeFqHehknf/ZKJos+
         Y4OtnXQ/vpOH7xG4P8TlXc2NudTIA8PFbA7XcebRswsp5aWHr8yfp7uGEU/I5SLhmTvj
         ZTP6dJzAJsyiJzHShvFPRrGGP/z5xoxgFNBFw9eYOLqyD2eLblpcIxLFUR8D5Xgu5VQ5
         e4yqK66pfbcrLZPkeTdhn0ezT7J2/bjeU/zZ22XwTSpEHepmkrBX2EKevGR2gtRILbBz
         Fnfz24ui2YWNoQDTnxJ8wAM6XjLj7DBRNJBCDOuQn+Xbgy3zONBzPFRs400RsX5Mmuk9
         VggQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWkG4AifuHNifhCFfIV1pcsparPh0x4Yx8ekfiM0WArqnc6yqwnd/pbVJFPZFwGOJ+fRvSiZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xoHKxDzEdS6Dmgtu/URGNW1zPZ8Y1pg4GLb1d/u7/KMJJDo9
	WCrpNGsc5RqVE4zx1pfKUo1BZxrJdd0f7GYDkqv/rRheJN3KNW9Swh/f
X-Gm-Gg: AeBDieviSMCVoWCvDjHM8lgCj4Ys9SVC7YCsuW7ulpww3Gq5KCEwldPAfFtKsUyuSMU
	ROx5eH3BlXEbxltCrGQXMwXNyTvYOrIQWLJ1ndKUWLaEFpz5FG3jJ7uxkiCMdh/27ca6YKGT4cI
	H6RNc3BVFGV/X4jbmBiqZDHOtRbzUc310MPW8eW1hz71RvWS/G5xaXmqxl3xDCswcI2SQ54g8sG
	A2mCE7i2yF1lmqFfAi9OMuw8mmiFxvyUPxDK2fBdp95IlSeGBNWMYc6Gm/Psu1VKQM8LjofHQwW
	JNTphyGyI3ryijOeYZOiYj5zrdjaXsIEGVOwTZblSKaTJBUmF+QveO9paHwrMJeOWh9ksFhiy03
	s2ASogtc2+zcuqeB0k4Ab7stsOEqfglaex5fPiACdrYLU3iKYVheq3HWydqmqLcasJ96U7iiOCx
	bFX/HduPksH5IF8BHy
X-Received: by 2002:a05:6830:488e:b0:7d7:fb0f:3e56 with SMTP id 46e09a7af769-7dc27f74436mr1889260a34.26.1775833890725;
        Fri, 10 Apr 2026 08:11:30 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc323b3366sm472507a34.9.2026.04.10.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:11:30 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Fri, 10 Apr 2026 08:11:29 -0700
To: Breno Leitao <leitao@debian.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, metze@samba.org, 
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <adkSnyihmD1Atfcf@devvm17672.vll0.facebook.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
 <adaJqy6Q4L7c-eTs@devvm17672.vll0.facebook.com>
 <adjvoD9f7QaQMu5K@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adjvoD9f7QaQMu5K@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277455-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,samba.org,kernel.dk,fomichev.me,vger.kernel.org,linux-foundation.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm17672.vll0.facebook.com:mid]
X-Rspamd-Queue-Id: 5FED43D9196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/10, Breno Leitao wrote:
> Hello Stanislav,
> 
> On Wed, Apr 08, 2026 at 10:02:36AM -0700, Stanislav Fomichev wrote:
> > On 04/08, Breno Leitao wrote:
> >
> > LGTM! Not sure what's your plan for the selftest? You wanna keep it
> > outside or maybe repost v4 with it?
> 
> I'd be glad to include a selftest. I've already developed one covering both
> protocols in this series and can respin with it if you'd like.
> 
> Test available at:
> https://github.com/leitao/linux/commit/2d9311947061f1baa43858f597dd6c54d7ccc5d2
> 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks for the review and guidance.

Yes, yes, I did see the test, so let's add it? I'm thinking that we should
already have a lot of coverage from packetdrill tests, but things like
you convert (packet/can) are probably less covered.
 
> > I'm also not sure your unconditional 'copy-optlen-back' will work for every
> > proto, but I think we can put something into sockopt_t to make it avoid
> > the copy if needed in the future.
> 
> Good point. I'd prefer not to over-engineer this now, but keep it
> straightforward to add later if needed. This could be easily achieved with
> something like:
> 
>   typedef struct sockopt {
>         struct iov_iter iter_in;
>         struct iov_iter iter_out;
>         int optlen;
> +       bool optlen_dirty;      /* set by callback when optlen should be written back */
>   } sockopt_t;
> 
> Wrapper becomes:
> 
>   if (opt.optlen_dirty &&
>       copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
>         return -EFAULT;
> 
> and the protocol callback would need to set
> 
>    opt->optlen_dirty = true;
> 
> I don't think this is needed yet, and if we do need it, it would be better
> to review and commit them together, making the rationale clearer for
> future developers/LLM agents.
> 
> What do you think?

Agreed, I was thinking along the same lines. We can add it when/if
needed. Since you wrap everything in sockopt_t it should be really
easy to extend later.

