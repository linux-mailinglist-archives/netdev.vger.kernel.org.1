Return-Path: <netdev+bounces-255250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPhfJ1ETfWnCQAIAu9opvQ
	(envelope-from <netdev+bounces-255250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:23:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480EABE611
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D683018777
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4AB34EF0E;
	Fri, 30 Jan 2026 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hs21MMS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A634EEE1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804617; cv=pass; b=iujurgQo7QkueAfX9nlSSiAntc34nZP9wsyoZ+fUTqTZehkP7nI2Nt0XR1Gexe/+itlU38FZJRZ7PPFv6dIiH/ACRysNNdhMqdXvIkOJwBTPUzN/oihyeYL1u6cn/WBUiNyWM5pAaF/ZFV17j/XfFilsLdgKLhAUtYq0S3rpxKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804617; c=relaxed/simple;
	bh=lCcMWU6ocUfOz04HROZ2VVNzKSBxxiz9KSgZZT4pP64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKXBFxXaXCAYs2hhs9k8cLX79VsgvEecbwapcBoY4fulMQ3eNH0Gjdk3adCS16kb+B0DINtewrfRd/JwjoWZ9LvdU8fW+7qU6xc5IAbvYsq+XQBZ9Fhb8zEvhN9bcQXejyVEE/e9cFTTrcc9oMutZ4gtZ22hpesaK9Nbpn8wMjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hs21MMS+; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a26ce6619so31509586d6.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:23:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804615; cv=none;
        d=google.com; s=arc-20240605;
        b=kGudOdV1bDXQL770vbFqMgYJ3mbvPqfiaj+vtss8m2Y4QGXjmxV0+nnpubXOWJidFM
         qhqMBWNlaNtxnzBcf7PXBOWu0yx1KdP4/15HXTst5ofxJ/nFkJcxTV9GXoXcxhvFaANj
         FtaWiElC+hV/niHWnt+8vd9xtZmNyy6x75b6YkI8hdylG/T8dxVjNt3l4BX7vft4iQ1k
         NG5jCTWHHXsSHARpOf/Yoc9BH3dq0JMJu5DQOqKiF4g6SwrmoDq4jKjb5d72oUlMpuqd
         vmE1x3oMbtUtW1NwLRfqb2f5lr00f357vgZxhC91QSv7TqpP90+ae9cI9Tzxh9Bdim62
         NhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHAWuXPjXFbXWMFCvQxp8QIuB5dPbTxYBgl3Qg+Prx0=;
        fh=8Gys8iB09Q1h8L/bhChPa8hnoHPIO9Hw3r/ziYNleTg=;
        b=a6Wu+14hLRU6aP7A4aIOrpkGuE7pXW41K+I9r3+bNYkcC74t8jQIGTpAXxuKB5lgPO
         WgqqnPBw1FxER6to2RSNHrLrCV9m18WVRtBONzVDd/WmuYbRGIrgJ663XqiydiGbaG/c
         UxTg3supHHJy1LQ/7qV633kXOh9APz/el9Zje+qTdc73HlsBB7NRp9tip/btEYDXpgoM
         ARKQnUrC9uQPGkkX5dJKz5zZGe9BRA+Az4PT1BwxOBmUJgdI2Sg7h7GjxuLaO/rUGzjZ
         88B18gjRD3CZWOYagAqgt+brFRru5f3iuulAzGz/j74BbbRFx2yIpbAIuSvcJ4yYGRpk
         1UYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769804615; x=1770409415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHAWuXPjXFbXWMFCvQxp8QIuB5dPbTxYBgl3Qg+Prx0=;
        b=Hs21MMS+aP2rzrNGyxWBCo31avKrL59Y2mN8clIC9aDqNw5jvh6nxNQof/o2ky3F+P
         3O2Ap6YBL6UPOIfk8YbEGgcjUfDDPZH6ko82rKZcKouEpipNnABgGC5fATI98w0pS7P9
         07HHWjAZTVtGRZ2EySSYtibSK5FztS22mnmURxaZ8rBL5/CHe44dlXqeKpevMaT0HrvF
         Wbgg7eZStspOOgDMgHy0NWpn0J1saNGBDdwmnAsyrG51n9eh6BwbR0usFO+LJrfkO2C6
         KqeNyiofTnBoae1pbf+jxOyNpV2Nq+XSXNu0GY3HPMpUkHApywcgWYn/du8CymubJZLe
         JaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804615; x=1770409415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHAWuXPjXFbXWMFCvQxp8QIuB5dPbTxYBgl3Qg+Prx0=;
        b=UsQhvO1wCfEEirUlD39ZruE/hsOIH6U5oIY5ZSUwezLY3RmZOqirfBHUi6eNRI73TH
         F7HOi42RsxgcdW6q6t1z3zxxT4l2vbIWhsoTRK3rwS1/4mH8gNkLZcvs0icr/D4R3tEP
         upJqGQS+65NLRIjDgUi4tdy1VgvEtflPntVJkCRvCEgpog7qS3Q1thaVeVF0oIDSDah+
         EVfEFAgUVpMZsdfPvPkRmCsyU8DSy/KO7m54d+8oxbIULfBMMfp0d6wQBenCKUevFYAu
         qB+UfIDClgeaFG0lOWARDohtrCvmGIUtqcRU+nnbOdzBHyo7kEuiUPrnHmEM5f6dM+gd
         vR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVdZEKVcpLogSqFs6T9qtDdtNK9UtLuXh8bb/I4XXTFH1YaGLrRCXtjJayOYZmAGLeTl1KUK9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehbKTKP4fcT0i0WaCWoYC3w2Zp9qmgxCVh1CsUizvD/mp/BRS
	jL9GO86OIssua/pA9FxQfygD3TQG81XwvOPue7t057WUI8tKhHN7ivSzfviyAEy/pN5Vsmy2DXX
	qLffHmVXvBmb+q0teBq97lyAeghM24b4SBBT0M6Sr
X-Gm-Gg: AZuq6aKI1wAq8iP12GSzDlGZWsTxy/DV3uUoP0iKsfhLIRbM6uQEwNBQ3TedeEda84Z
	G6YNkckmken5KkNcfE8NZdIyxgOG68qXFcMzL711/FYwxNN3/dZK7tZ/f1KQ1pya53LgC9i7eX/
	WxzaUju+676YoMe8Gr4MQ+pF5lCXFNpNa+ZVG7b3pwT/uRAJ1APUKzVc0yLPmSIwtBFlf62tDw2
	A2wrDXNak/nYn0yuGL/Q7TmcKth5m6Wcpnl3kj0FhS0BfvfW0KX2f3O+mP1YhHlO8669KA=
X-Received: by 2002:a05:6214:401b:b0:894:78e4:27d1 with SMTP id
 6a1803df08f44-894ea1792b3mr66148016d6.68.1769804614835; Fri, 30 Jan 2026
 12:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129105427.12494-1-fw@strlen.de> <20260130081245.6cacdde2@kernel.org>
 <aX0B1xaFGL43xxUn@strlen.de>
In-Reply-To: <aX0B1xaFGL43xxUn@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 21:23:23 +0100
X-Gm-Features: AZwV_QgqAFMVwmSqA2GrImjNKRZiJIHf6kLxIgXO_d7ss3jbAHFtbwaIY0HOCuE
Message-ID: <CANn89iKUV07+84PVq0cHe3vMaSGNTQzhq9=xetg+_P2DmsPmQQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/7] netfilter: updates for net-next
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255250-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,strlen.de:email,linux.dev:url]
X-Rspamd-Queue-Id: 480EABE611
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:09=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu, 29 Jan 2026 11:54:20 +0100 Florian Westphal wrote:
> > > v2: discard buggy nfqueue patch, no other changes.
> > >
> > > The following patchset contains Netfilter updates for *net-next*:
> > >
> > > Patches 1 to 4 add IP6IP6 tunneling acceleration to the flowtable
> > > infrastructure.  Patch 5 extends test coverage for this.
> > > From Lorenzo Bianconi.
> > >
> > > Patch 6 removes a duplicated helper from xt_time extension, we can
> > > use an existing helper for this, from Jinjie Ruan.
> > >
> > > Patch 7 adds an rhashtable to nfnetink_queue to speed up out-of-order
> > > verdict processing.  Before this list walk was required due to in-ord=
er
> > > design assumption.
> >
> > Hi Florian, some more KASAN today:
> >
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/nf-dbg/results/496421/vm=
-crash-thr0-0
>
> > [ 1144.170509][   T12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [ 1144.170759][   T12] BUG: KASAN: slab-use-after-free in idr_for_each+=
0x1c1/0x1f0
> > [ 1144.170922][   T12] Read of size 8 at addr ff11000012a16a70 by task =
kworker/u16:0/12
> > [ 1144.171079][   T12]
> > [ 1144.171133][   T12] CPU: 1 UID: 0 PID: 12 Comm: kworker/u16:0 Not ta=
inted 6.19.0-rc7-virtme #1 PREEMPT(full)
> > [ 1144.171137][   T12] Hardware name: Bochs Bochs, BIOS Bochs 01/01/201=
1
> > [ 1144.171139][   T12] Workqueue: netns cleanup_net
> > [ 1144.171145][   T12] Call Trace:
> > [ 1144.171147][   T12]  <TASK>
> > [ 1144.171149][   T12]  dump_stack_lvl+0x6f/0xa0
> > [ 1144.171154][   T12]  print_address_description.constprop.0+0x6e/0x30=
0
> > [ 1144.171159][   T12]  print_report+0xfc/0x1fb
> > [ 1144.171161][   T12]  ? idr_for_each+0x1c1/0x1f0
> > [ 1144.171163][   T12]  ? __virt_addr_valid+0x1da/0x430
> > [ 1144.171167][   T12]  ? idr_for_each+0x1c1/0x1f0
> > [ 1144.171168][   T12]  kasan_report+0xe8/0x120
>
> Sigh.  Doesn't ring a bell, I will have a look.

Could this be related to "netns: optimize netns cleaning by batching
unhash_nsid calls" ?

