Return-Path: <netdev+bounces-285028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHX5Akmp+2myewMAu9opvQ
	(envelope-from <netdev+bounces-285028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:49:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF04E0616
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C77B3009095
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5DF3B19BC;
	Wed,  6 May 2026 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ntQpjk8K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AF3B27E5
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100548; cv=none; b=VZkOYPWJm87NM1ou6DpxmaU0+9P+Jlmi+J3CtqKAjYC3p7Ok3CzDOuArDl3rPgbU9yUuQ1tHZhKy2timJF/b2GQZ4qgDizSMDB0p3KgB9cFDGOqf+R+xC8j5911rLTO8v6qJ8i+MiMOPKUBjue3oX4KMQaJgaUly1Txfs9WB+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100548; c=relaxed/simple;
	bh=KTCvtuXioIzyBTbuRiKZ8xct4SR9Y3b6fZiFzbTo+8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcGHruA0rqGMGREYeB/pw0VzP81wAcMrwUE3Uc1iiYARVkUWFeZfxntjnNJLFOGeekLdvFavmQ/AN8S3rcDpyuLKdWvnN6Pn0d3d5H+yZI6nHpfZxKUB7zp0gxE4jUdf35iEn5SRkLKSs+Of6L4JveMpzMRN3teAYXJaYw3TyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ntQpjk8K; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83659d38e38so15777b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1778100544; x=1778705344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8gPP8nEtjCFfwXbHwnHytevRiknOZ8KC/b57qw83Is=;
        b=ntQpjk8Kg7dderHoaBozP0q1motNwnZCL8FAHhKKlN8/F7GpVbTqHJuIF18OO9vvnS
         EjzDPGKiJMIQtpeBixfpP56Czb/96duDgRbIyBqPrkpIkPP0ptkWa2HUUz7tx2yMZvl0
         BgSvsPb76B66rLxTbC5kRVOaz/Isagc9pk1rIuNsNUVyRLO8P+8rrPbDH506PG0zVeFJ
         TOYcAPwQdngjzL4szKCLxlPVmRMFpuDx+SUib0gHgU7+hzG7idvLgBARwuzZ91n6ULHN
         Dz5HDrOIHhMMDvP6Sxg3imuK+CthFSmw4mHbOsttrT5nmYYCDpIiYqoX/Xs5XoTZ3ZS2
         s8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100544; x=1778705344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8gPP8nEtjCFfwXbHwnHytevRiknOZ8KC/b57qw83Is=;
        b=aU2c+4wIgakq9cIxs1S0FHNPQwMKQUJT8ZwL/gVAiqqCPGR3f9cWcMA2ZsfUNTsyED
         FjGZeQGJEOowLlEhPqOYX0r4JUblJ/J+SL6Wrakjy0tBs0E0Ln+mJ937habzHcVl5lHo
         i0Kt2SqY5BkuUjtSYnKJeoGAmZOBddqOK7I+ULdI1xhptFlXXGmZTBF/d7tvuBm+JpRq
         bwqrz4sW2VozM2GczycGGgC5+hKkAWqwYf0adI4qykKGyPl31IoK3xxcC2Yz1BOwPiAN
         XZCcNN4ZhF4LIGJ8hBJIUHuU+Ezs6/yA/oxqbmt2qH1ai0lDk1ObL5D7S9D7tW5+RPxr
         DVZA==
X-Forwarded-Encrypted: i=1; AFNElJ95pih+4oin0qWbaRkzUmhdBIJ0o2OPBCDQBn5hnstKfMtjjmEjiyAum7TgUgeqdDEoyx4dXdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybk+xK4VUlBoy4lv2qHYgwGXYw+iqjHOlHYSp4+7kOOUQ/CdXW
	p1TtV3jV2t3N6iRfjoowCSDb/NySeDBkEzieGAush6wuu9t2VR6m1KuPO5QM6MQg4Jo=
X-Gm-Gg: AeBDiesmoTsZD7Ooe/XO4y7KbKV11gFnqeHnecIf5eXxj/uP0UyErktQhYoBBIrqdWJ
	DJPbY43tzuIZmiOvNx4YwrHzKIeOM6GUpkAf+diLa1amRBPN1bNelOjO5VWpTWqmTvyql4Bz5/Z
	8y5cLXKwjLh2A2Jri4fhpgx4WJRiB8NiwHFu1OdsldCJYWHltJl92huoD0UfxVa3WF9/AlrbEDa
	Kk2QVix1ntMkSskwmjrSsaoUacbmDoZ92zWQpBlJUNejvvjAjJnenKArFi+MKbOhLfLIiiWYPSB
	Qtk3gqhX0D/v6IgHfz/Do9ti0+2zV/ugz5vV/wXPOovhT3d2xrymMbJPCADvFglbLIzJRFEi4Gq
	doZEd6tc8xpmJx4x5nPnIBnhvKBTJ5Ihip2WYyYjp1Gfq5VFA5eQT6IS512EwHWCXDjEL7QaPek
	eoP3eD+TZoYm8/xIE=
X-Received: by 2002:a05:6a00:21ca:b0:838:1c02:2763 with SMTP id d2e1a72fcca58-83a5b3ca97dmr4530650b3a.9.1778100544184;
        Wed, 06 May 2026 13:49:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm7882028b3a.21.2026.05.06.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:49:03 -0700 (PDT)
Date: Wed, 6 May 2026 13:49:02 -0700
From: Joe Damato <joe@dama.to>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Gal Pressman <gal@nvidia.com>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: napi: Avoid gro timer misfiring at end of
 busypoll
Message-ID: <afupPjPGVtD36x5l@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Gal Pressman <gal@nvidia.com>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506090808.820559-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506090808.820559-2-dtatulea@nvidia.com>
X-Rspamd-Queue-Id: 96FF04E0616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285028-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20251104.gappssmtp.com:dkim]

On Wed, May 06, 2026 at 09:08:08AM +0000, Dragos Tatulea wrote:
> When in irq deferral mode (defer-hard-irqs > 0), a short enough
> gro-flush timeout can trigger before NAPI_STATE_SCHED is cleared if the
> last poll in busy_poll_stop() takes too long. This can have the effect
> of leaving the queue stuck with interrupts disabled and no timer armed
> which results in a tx timeout if there is no subsequent busypoll cycle.
> 
> To prevent this, defer the gro-flush timer arm after the last poll.
> 
> Fixes: 7fd3253a7de6 ("net: Introduce preferred busy-polling")
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
> Changes since RFC [1]:
> - Sending only fix to net.
> - Made commit message clearer and more succint.
> - Fixed timer arming to happen after clearing the NAPI_STATE_SCHED bit
> - Arm timer after clearing NAPI_STATE_SCHED and drop IRQ disable.
> 
> [1] https://lore.kernel.org/all/20260428175134.1197036-3-dtatulea@nvidia.com/
> ---
>  net/core/dev.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Good catch on this bug. This fix looks right to me.

Reviewed-by: Joe Damato <joe@dama.to>

