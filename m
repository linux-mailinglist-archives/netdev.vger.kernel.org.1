Return-Path: <netdev+bounces-182693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA0A89B5E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C49176B82
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE927FD6E;
	Tue, 15 Apr 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z2liOoDp"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811AC2417C8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715092; cv=none; b=kWuNux/+6MI7AwkJIqeUpY4xjr2iVYShXWUxxLjOwi+FinC1xu6QS8xOsdcfnQZuF7h2Ti5vWzSGyabOlMnR0F1xDFQxKilGWLzgfFpGWIYpERV8lzOdMEGoCK8zFtPuRTAmLwKdlhSSa5QvRgmvKKMUOC6qO1p/fZ20SNWodVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715092; c=relaxed/simple;
	bh=GSu6JHo+YSCZ8F3pdRafzygNXm1hMM/Juu0glZnvuCU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XrW9z7eKrb1MTGgbGdY74PIBYKGIE3kr995NPUdfXv3bQugrfxQ8m3auZ49nhvqe4VUWIC0TjnEway+1JiWdF4TfIHJAuQ6frzJHbXmML0X8zeOeA1ZNlyS55k7TLR6GfMXBxiX4v+jZ7S7EEq0VPoz1m/avtLAnEFW9sUCtTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z2liOoDp; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744715078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbbEvmW5ERCV6V3g0BQvaj+wv5+2mrjsX8ION5ZUGEQ=;
	b=Z2liOoDpBAthCTgDeMWcJWeim/QFw+glL9/xaSwlyqtGJyeauIlabk9niKOZMPYjfHgBzh
	FsYiV11/pKzTpBy0e1rofeZFzFsMBAqsDvD6JxbqiwI4ZSrLm53lP9McBeip/W8BxgW8z9
	Sbj5KiXaSCi+EbSX9V8bFMtKTZiQO0Q=
Date: Tue, 15 Apr 2025 11:04:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e60b4acd2780eed0a0f89ee40df32cf518545cc4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <Z/19S2yMP/2TViMa@pop-os.localdomain>
References: <20250414161153.14990-1-jiayuan.chen@linux.dev>
 <Z/19S2yMP/2TViMa@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

April 15, 2025 at 05:25, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Tue, Apr 15, 2025 at 12:11:45AM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> +#ifndef __TRACE_SOCKMAP_HELPER_ONCE_ONLY
> >  +#define __TRACE_SOCKMAP_HELPER_ONCE_ONLY
> >  +
> >  +enum sockmap_direct_type {
> >  + SOCKMAP_REDIR_NONE =3D 0,
> >  + SOCKMAP_REDIR_INGRESS,
> >  + SOCKMAP_REDIR_EGRESS,
> >  +};
> >=20
>=20
> I am curious why you need to define them here since you already pass
> 'ingress' as a parameter? Is it possible to reuse the BPF_F_INGRESS bit=
?
> Thanks!
>

The lowest bit of skb->_redir being 0 indicates EGRESS, so we cannot use
the built-in __print_flag for output in this case, since it requires the
corresponding bit to be set to 1.

We could certainly do this instead:
'''
if (act !=3D REDIRECT)
    redir =3D "none"
else if (flag & BPF_F_INGRESS)
    redir =3D "ingress"
else
    redir =3D "egress"
'''
However, as Steven mentioned earlier, using an enum instead would be bett=
er
here for trace_event.

Of course, we could directly print the hexadecimal value of _redir, but
that would result in poor readability.

Thanks~

