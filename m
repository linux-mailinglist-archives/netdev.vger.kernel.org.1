Return-Path: <netdev+bounces-295856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZeHKL7qImrWfAEAu9opvQ
	(envelope-from <netdev+bounces-295856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:26:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D26494A1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:26:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ho1GCmC7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295856-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295856-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 702CC301F985
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0373E3D8E;
	Fri,  5 Jun 2026 15:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212A3F4DEA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:14:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672470; cv=none; b=Y8YyPnHvdtTLFRl7yFqrRp4hNSVpFayeVNfnKMoRALzfxDxWkLXvTfkm6jTXvQAY1OTcBahlWIH7orlMTkCQdY6KexUvCe9sdaYAHaBeAy7USi8eO/1xJgXlcb2/ZNa3FMxN5es4mJCPlw5WxB9Bu7BpOCOBDGDfZlROJqqADDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672470; c=relaxed/simple;
	bh=+iR1M9yYqzyufLOWTZWg7ajKK1GPg5ZrcC7VtQr30Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaW7R56z0WRJLClzKwhtxTOWchkLhM8UZ4uBBGB0TuVZuqXiAhVmSCssoiG0I0ugyNPGfJFkhcc49nHFsFRppM86Al1uW1kgU/xSkSO1As+7gCoGQDMjCcwYm9Weehcixo+BJxNlpLhN74lbq4VnnQpzJQgLbN6eO6rGI0WXql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho1GCmC7; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso978840f8f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672468; x=1781277268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyRiQRM4moCCjTKbCSr5rYbdhGQBceKTugMVudUxfDs=;
        b=Ho1GCmC7MLe4FjtT6OG6EeAhoe70WMOZIFJBWvDmW0eKcWhOOtHGYDNWnXjzlZc0Up
         eKB8qKFQbzbAH+lGQiYAF4Yq/wZwkzWC0lf4odkQ+EKK5ht7Q0VUBhwrFbuK541GV19A
         UgxPl3MHU9VBCNgP7IFwGQYOpZjV/07g8ATC+Ogb3DHy9DRo8onqb3b/sWCcvzywGfDk
         rSexU0demSl0plhYmo1jm6SpG5FA8ds8XmOIxfIfCTgLynm/vNWRNNSagUiQpqBS4Wo2
         Itx3Tq8JH+GCKEW+lSzDkkQAIwk5+m5NkXX0O1Z2U9+rc0HmYq0QW/wEzDwCBZy+LS6J
         IIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672468; x=1781277268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyRiQRM4moCCjTKbCSr5rYbdhGQBceKTugMVudUxfDs=;
        b=Jz57kPXQ8T+tfsx3D8iIU2PnS+ikLGSe27gCmyU7TY7Vci6UhM76wxb7YqVcciqI3e
         DE6NNOFWZDzC+71erTvNSVBM7bz95sZ70kl3T7Q9OuEI4BzHDEOmuYWJwK6iLiP4ma87
         495v8gSpnLTnj/fxavBiS6EHknRaVXpAzLhq8tJOsT4ftjOmgA+qnAeHekSFpBACNvmM
         HvrugdSHvw+vJnOO7fUMZg+S2oX2hmYoEBBwGpozxroT8FYFMw/lxRP/4K5wEINKeFnF
         PqRINYVgGWSz93dDVzazef6ECFU4tO1tSI5wTkzLgnVy59JZyTrFFYnIz0UO9k3bTJ7F
         RKPA==
X-Forwarded-Encrypted: i=1; AFNElJ8UtTgpZildNxnEAvs/vUslnIg6U/gN6Qpg+WO+IBSrloix3yYeeHXJmoJNkvTfe44dl1S/NJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1qft5C5ds9i4BKQlDg6rJL5l2cmOHv+TTu/lXjwBbbU1aiz/
	dDW0oaIOIjNriGW7KDWGVRKVmQg6wORVS9e4R4fUiRT1GXFQI9fFO8ia
X-Gm-Gg: Acq92OHTukwS9LeDWDckDACnZo3ob+nR+5LbW2iQSlaWfiBUmc3yr8eJaBFmJuGLjBo
	u40WtlWYdwt1YghHPQ8WguHdusVkdj386bVw9YZJpd7Y30T/gPnhW39dW2GKOwutux4dToildQT
	fRONDHmAyjpWLXGyOtJta8G8qVEuz1t+IE8Fa/w3D2HsTiHPCuJXjoJq9+vxT5r5YpX4N7Jr3aj
	u3TG30cXTRbkP+RZR4ppv9V1zKgPvgVJHWCse6zEUWJjCYGRAcAEOHI/u0jWXpNsWAh1Ysucs/S
	ubmzUxDrPbdbZJ7Yg/k9X80BMSS974ImuV9uTNPP+Wz5bmEvu1mY4qb7ZBsGcPgcDsoHsvzB5iC
	yj++ZnLaaamgEyWQPUmhKZKaWCQ3Crq+XW6EgTllJAdg1J+cC2fSb0H4PuZsPDuERvKzxcIErsE
	snUgp+A/oMMqVv6aQAJfy60PvZjKxH/6+YAholRrMj3TBObjnGNmB4+w5N7RIEKSs5tOuGe7g=
X-Received: by 2002:a05:600c:34c5:b0:490:be9e:fd07 with SMTP id 5b1f17b1804b1-490c25ae3e8mr66631365e9.10.1780672467777;
        Fri, 05 Jun 2026 08:14:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm29110357f8f.5.2026.06.05.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:14:26 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:14:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers (update 1)
Message-ID: <20260605161424.334a05d5@pumpkin>
In-Reply-To: <aiK94g9vphHls3x_@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
	<aiK94g9vphHls3x_@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:metze@samba.org,m:axboe@kernel.dk,m:sdf@fomichev.me,m:io-uring@vger.kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:torvalds@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295856-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A05D26494A1

On Fri, 5 Jun 2026 05:25:21 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Wed, Apr 08, 2026 at 03:30:28AM -0700, Breno Leitao wrote:
> > Currently, the .getsockopt callback requires __user pointers:
> > 
> >   int (*getsockopt)(struct socket *sock, int level,
> >                     int optname, char __user *optval, int __user *optlen);
> > 
> > This prevents kernel callers (io_uring, BPF) from using getsockopt on
> > levels other than SOL_SOCKET, since they pass kernel pointers.
> > 
> > Following Linus' suggestion [0], this series introduces sockopt_t, a
> > type-safe wrapper around iov_iter, 

I'd have thought it would also have been better to use a wrapper function
instead of direct calls to copy_from_iter().
There is no need for most of the code to know there is a iov_iter hiding
inside sockopt_t.

-- David

> > and a getsockopt_iter callback that
> > works with both user and kernel buffers. AF_PACKET and CAN raw are
> > converted as initial users, with selftests covering the trickiest
> > conversion patterns.  
> 
> Quick update on this effort.
> 
> All proto_ops users have been converted to getsockopt_iter and submitted.
> 
> Most conversions are already in linux-next. Three remain:
> 
> 1) rds: Under review
>    https://lore.kernel.org/all/20260605-getsock_more-v2-3-80f38cdb8706@debian.org/
> 
> 2) smc: Submitted today. This is only limited to UBUF right now
>    https://lore.kernel.org/all/20260605-getsockopt_smc-v1-1-65da62fa44c4@debian.org/
> 
> 3) CAN drivers: Reviewed and acked, pending Marc's merge
>    https://lore.kernel.org/all/f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net/
> 
> Once these are merged, I'll rename getsockopt_iter to getsockopt and
> remove the legacy path.
> 
> Next, I'll convert struct proto the same way to eliminate the remaining
> userspace optlen/optval pointers.
> 
> After that, io_uring getsockopt operations will be unblocked.
> 


