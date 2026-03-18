Return-Path: <netdev+bounces-269108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OqFDMffumk3cwIAu9opvQ
	(envelope-from <netdev+bounces-269108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:24:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B72C0328
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 515643334BE9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE43EDAAF;
	Wed, 18 Mar 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghQjv1fp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBD378823
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850901; cv=none; b=kfkmc/gRIGJ5YZrSeaSKVoxwfiaWsIOijchAEE3roop5bIiynAVM5Ug5tlZUOig/IYsMGRNpDBEaWpVQdIDWbyBS5NMgrV4/WL3qXKk6KbfhA/66FHa3spu20lLtIY9vcHI6qtRv6rrpqccYYHTT25T9GJIwI8+HLJoK87IfqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850901; c=relaxed/simple;
	bh=Xais5AlC7gPN/jeDsX8Mvz9zOloreO5rETe4qgoEMv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4v0NfLwlX08+NNT/T35c6QTb8yGsa0qBbAqwxCG3Um+MxePab5rceSiAYJTxN8hg0u7JdzDM2PP9IJMz9kbdgRRj6asAXeys7RSITpQbhqF9Pp+yJ62dIfE8C6MRUI4gNjTY4uzHhw11hVfsXROF+Z+obt4qw9sFcJ00zxzOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghQjv1fp; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso164491d50.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850897; x=1774455697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aU3ZUegYeNO/2K6RsfKemLkoDaSg+c0LeYfQDENeDh8=;
        b=ghQjv1fpKGyjAGY79ZcebNubMwKey2UMAJ+vXMYM6mENNEt2d1R6+094CRB6n9HS9S
         TtXiUaRH9zeze9hhcBD4cIARmC6nni/zibKmo2VAKQCv/0oZCbspsWvBaf3HIf17uCSa
         w1kyqUmlxwH0XvJ2hYOIZE9JpbJwY/CNUc37YJ5C+A21Zz+JyDLX17kpcpXi0kpCosF7
         jQ8S/5SU9DYPRClxCFgCgujLt7Q6yEw44BqQDJN/zKVml+y709iUUhRrHHpok4Tnit2o
         nTtXZKN73Rf1eGqei2dkTBNBcB6U1Fmt7S1bbBdkTYQTKKBdIE8gxr5w+LJXISzdCVne
         ox1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850897; x=1774455697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU3ZUegYeNO/2K6RsfKemLkoDaSg+c0LeYfQDENeDh8=;
        b=bJFeG8d73suh4SbgqM6G9ZwG1+mPlRANJ4KOUczJ9c4rEtXTepGkUA6orHIWMp6xZY
         OxdUNB5NBvxa71hCxqLO2DOrsl+6W0H7q6ek3Jx3gWi4o/if38hfJjxhYOGBfby0w8hL
         59mAbT7aT843LpTqnTy/3Onke4XBry6PmpKrlKXTua28OOkUpXOGwffRxIUHO3PZ+Fqr
         0QQ7ds210JsaVoBG34wZNPQtoYGgn4diPAYRawn3UjqfH9XOFIW2OuwBjD1O2mMpje8p
         XiPngVQeJqfarYblli1Lqz+b851Fd7o5KxXkhxYOKnZ6B4gL4ZWegDLGEc4qpRvrbM43
         zaSg==
X-Forwarded-Encrypted: i=1; AJvYcCUOlLoY+UeNFTKrjgTDH86jksyLglXICaFjURqvIKpA9B1N+NukxM73M9DtW5CXVPLPOOtrea8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPUHAemWWIrupu4mL4sbW0CJ5YoBUvVCV1k06P85rWq8rRuTf
	h9wgrVb6ZqdAe1vj/qp4xGjl2WoXTer4HDsaMlsJj78QSF3d3pQaY0nM
X-Gm-Gg: ATEYQzzthE2DbO99U6Lr+ZecvFzk/JQx1MROy1hFNNsyeNl7LxxfQUwht1KKGsh5mK5
	diHFEVza17tL3gdkb5qRGCgWRYLwOap/+mB0WmzrYQSd3lia9FxzrOyPrprh47LTVKar4XyzXZJ
	TkCfACu7Nqe5Oe6eSLyjXEIQglRlvQbkdK8Uuxhwcr3bOSnWfnVqH/ZmrQs+7tOROuh+BpBSHyv
	57hykjKRKLkC4jl/K+3SeFXIy0pKb3r6VoBCa28NuSyh3lIvB0pPm0ADTSXZvyAjNVNU6W/ZzTt
	5h+yeEO4KZwNmqRos0upqydKvIm+8C7xWymBLciiUerpXeh+J4SZFLjh5aCPpIxWs9EfToPipqT
	234VeG25+6jdA9qlNmuGbK4V4/Q+Vk5ELvO57yay8vmB/eyiSORsx8HhnK4hpMOdzaNJjo1UGtl
	Z6bIIAooWBq1RLVYD3KmoklrVjIYU1AoytFDb1H5/bxH4UGcs=
X-Received: by 2002:a53:b20d:0:b0:64a:df24:813a with SMTP id 956f58d0204a3-64e91351a08mr3367724d50.29.1773850897139;
        Wed, 18 Mar 2026 09:21:37 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91c06df7sm1882816d50.17.2026.03.18.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:21:36 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:21:32 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abrRDNi79H9ircl1@devvm11784.nha0.facebook.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
 <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
 <abq97UD7CHR7bdod@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abq97UD7CHR7bdod@mini-arch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269108-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.934];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C0B72C0328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 07:59:57AM -0700, Stanislav Fomichev wrote:
> On 03/17, Bobby Eshleman wrote:
> > On Tue, Mar 17, 2026 at 05:08:20PM -0700, Stanislav Fomichev wrote:
> > > On 03/16, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > 
> > > > Add tests for devmem RX over a netkit device with a leased queue. This
> > > > is the same as the other devmem RX test except for ncdevmem executes in
> > > > a namespace, binds to a netkit, and skips the ethtool NIC configuration
> > > > steps (relying on the test runner for that setup).
> > > > 
> > > > The RX path is setup as the following:
> > > > 
> > > >  RX Path
> > > >  -------
> > > > 
> > > >  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
> > > >    |                    |                     |                    |
> > > >    |--- TCP send ------>|                     |                    |
> > > >                         |-------------------->|                    |
> > > >                       dmabuf                  |--- BPF redirect -->|
> > > > 
> > > 
> > > Is it too messy to parametrize the existing test to run both with and
> > > without the namespaces? Feels like should be somewhat doable in python?
> > 
> > IIUC, we could have main() do something like:
> > 
> > for env [NetDrvContEnv, NetDrvEpEnv]:
> >     with env as cfg:
> >         [...]
> >         ksft_run(tests, args=(cfg,))
> > 
> > 
> > And then the tests could call helpers that check cfg.netns to use the
> > nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> > addresses?
> > 
> > It should be doable if I'm following your drift.
> 
> Yeah, yeah, this plus some small changes here and there (to pass your
> new -n in the netns mode for example).

Sounds good, I'll give it a look.

