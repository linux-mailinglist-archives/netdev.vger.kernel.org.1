Return-Path: <netdev+bounces-280217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LoQI73E52lCAgIAu9opvQ
	(envelope-from <netdev+bounces-280217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:41:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E448A43EBE5
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741AC302FAA5
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2E3DC4C7;
	Tue, 21 Apr 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W03jPU6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7E3DC4A6;
	Tue, 21 Apr 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796805; cv=none; b=UrcuqsjdBVeO8T/XUxcc6U2P48E2GgkK7WD/BaeqaF4tSdQsrHA3k10lkng0XCvgWTThwhNczqgYYcDebZnsZ+spKeJ4BkQOGBCaBD4I4UuVcj32qcEFowSqV2Rk1Gjju7r0s0fXXO13YlNcsoJVKvrsQM0KzJl7XHA7y38MKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796805; c=relaxed/simple;
	bh=hR9w0ZwRSBV8FS5s0cQgmLvMB6qT8ow21OS/g1uvucE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=X3mYkk4MVKmcCsYMuHbGc99xC5kIAczTMMhoex28NqcbDDcqft8lNrvTb5fT6Q0i0eHiLDH05g00DKh53iG0Od6yD+WdEJwDLS8rX/ki+MEHOY+sQ36wLQRkQZBxoN8hRDyU0ZKTzcqkIan6bAni+Q8dbJRoNIF1nlqKHQ07aW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W03jPU6v; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A77C0C5C9B3;
	Tue, 21 Apr 2026 18:40:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22B3A600D2;
	Tue, 21 Apr 2026 18:39:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49E101046085F;
	Tue, 21 Apr 2026 20:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776796797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hR9w0ZwRSBV8FS5s0cQgmLvMB6qT8ow21OS/g1uvucE=;
	b=W03jPU6veJWiofjBlPVaRXLhUhjBDldWhVhcmR/qtoJMPaKhVTZBr7nBu/8zy5ZjXP5iHa
	eBnJWzW6Vne/bCVjybEsmqzGpUnHL5HkXz90OMj7J5FLLUtHIYU1Fu162hPj5OHqQh6Vyw
	58MU4vG2k3lYm8XjXkYNSmFBDDhiAd2ij2uiLivBUoUAzTBYDbuyjlbSCYfSKW4AogSOfi
	u7KtIy+AuZmtz2QJRc7wsLlGlUkUXduxKSCGVAqghowRqzkBjTF9bKMHIQu4bk3lIf8RJ/
	lnE+WO6lXkIiU4pzCuBrCrHTp1StiohZ6MH3FZ9TRy+rDTZFd1SUw2jCNsBvmA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 20:39:50 +0200
Message-Id: <DHZ1W95EQ4NC.2U9U2Z5YLCXWY@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Paul Chaignon" <paul.chaignon@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: drop xdping tool
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
 <aefAHLdVZaOmf1Os@mail.gmail.com>
In-Reply-To: <aefAHLdVZaOmf1Os@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,iogearbox.net,linux.dev,davemloft.net,fomichev.me,linuxfoundation.org,bootlin.com,vger.kernel.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_xdping.sh:url,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E448A43EBE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul,
thanks for the feedback.

On Tue Apr 21, 2026 at 8:21 PM CEST, Paul Chaignon wrote:
> On Fri, Apr 17, 2026 at 05:33:02PM +0200, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:

[...]

>> Drop test_xdping.sh and the corresponding xdping.c userspace part. Keep
>> the ebpf part (xdping_kern.c), as it is used by another test integrated
>> in test_progs (btf_dump)
>
> The xdping_kern object file is just used in bpf_dump to check we can
> parse the license as expected. You can replace that by any other test
> with a GPL license (ex., btf_type_tag_percpu.bpf.o) and remove
> xdping_kern.c.

Indeed. I'll let a bit of time in case anyone finally advocates to make
xdping stay, otherwise I'll send a v2 making the btf_dump test use
another prog meant to stay, so that I can also drop the xdping_kern
prog.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


