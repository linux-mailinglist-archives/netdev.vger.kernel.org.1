Return-Path: <netdev+bounces-251625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IlfJDH7b2mUUgAAu9opvQ
	(envelope-from <netdev+bounces-251625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:01:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B44CA8F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5BF364F560
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA333D4114;
	Tue, 20 Jan 2026 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGkIU3Ur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CA395266
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946020; cv=pass; b=EU+pHQA4snRPyECE1vu1/aTkEVWPdNMwpbPgK9TW17yD/GAdnOc+iWLmqa+MXOG7vE+U6QxZ379OKXWQuFjtKsPE3IM3Duxd/hPbEpabXuNOi8GjnS/A+us82COexH+Yw9AJXIQsG36FgKdHlzP3DIXyf6H9hpg2J9HiOQ1h3g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946020; c=relaxed/simple;
	bh=OOkg9g07Qtf5oqCWy3DAcEVTf+vF40cuy2xsIZ4sY4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RagDZJw1VsvBv2CoV/EEGdtA6KPaj0u1Gu+ffn0m3Z6FSvWm0beUXAMuzE3ZvlR7yenYb+WI+xotzU0wnUGLsCLctomLJCoHnvSEf/wh7t82NGFoEF13yGW3oFQYMEj6QyvVUuJqN3h+XmnyulInSyHYMw/+HPI7iLRFEffRQOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGkIU3Ur; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124566b6693so8667467c88.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 13:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768946017; cv=none;
        d=google.com; s=arc-20240605;
        b=Abe+A+7CO0r3i+F1t3jP8HlJeRbSeztobAR/ulW7MQIaZkm9hYllTYe+DEANJhoDw/
         pWw54Wx7bpse9V5iLAPJvSykT8708xpVA8hj0zMQjSnm5ps/qGPCB823qTUw3c4aCM3+
         noFRfd2Tx7fS2kh6iNtKMq6woIVD9ZfbOyBaMJu1ymPZJKQfQvt3Tgry6U29FzajCmos
         U8LIXja+DTLZAT+c2+z2j0V3haMQzSMOUXb0cWfJ//lSCSETtqcAMA3UIQYCoJLE1XMv
         j8//MqqKmjF1x+dNOJKEwwY5ItL/8ibadCUKOjKISOgMCseWCzf5IsHUB0IU/PzoWnmR
         ejhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOkg9g07Qtf5oqCWy3DAcEVTf+vF40cuy2xsIZ4sY4g=;
        fh=023w3GgbKm/+MuA8/OSUG5Rfggo3dVt1dM2gVFdhp28=;
        b=DoEoS4KSHU8rIh9JEqFuAw+cCIDHb79qeV9SnV1pmKwjiotSrGZVPcgbBQUrO2Krfz
         zRuN5Wb+JUt1dxS7etZ8gqUHgWAtgbh+GeVEoFZqWF55TEckVweIOsN1eI544fxyQfzG
         u+PeNTiYebXm+DTAusmn34zxPIFQLk2lWjU52j5vZjZF4swVeR++G87skUzPkml1zbtz
         3mGnBOoD7j+oJ/XFqQZLYQgEzCMreqOfuYvv8RDZqMqfHCuwvLHWKg15gZQih+LEO/og
         XLCKCRjjrMrcUAyA9SdtA1BBtwLY2PtICwqcHHTAbLG9jd3kvMbtJolrRB+pqTG1RArv
         4xow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768946017; x=1769550817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOkg9g07Qtf5oqCWy3DAcEVTf+vF40cuy2xsIZ4sY4g=;
        b=OGkIU3UrcCkMKYd1TQoYwBJqO6+nmt2RA3Ww1nfF4NN7bEU7QSoQlL/mVyrFuLEuop
         whNllC0R4oB3sfLqU0YFQ7VaiSe6ItYQboJU4+ic7hH+N28cDBcePiACyDz0CXz2MNtT
         hlhi+VN7HeAcjLIrVQsqc59yLb46mWzlVnXVX0GlHeanggtsboZjkmbcuMiGIMPA4uUH
         ejfn8U2qKh3hPUqBJNDFGIhDbSKVrq4Pc67E+SeY7EzrjluUBBewqQUPS3MMxThar38v
         pYu3N6sS+H/yzEqhIykSxomW8GLm0PIOujRLLbtLAhN/3i0+WGEHh3PQOrBoZh5ScWDZ
         36zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768946017; x=1769550817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOkg9g07Qtf5oqCWy3DAcEVTf+vF40cuy2xsIZ4sY4g=;
        b=Nofgq/3P3kC9jjdheTaNP4X48koH0bPx5h11Ek3UKv2aJJv2Z678PNAPTS1wT4OZGP
         1JUjrHNGsoRh8Xxp7bjwYkWoEl9BvsI6YQon+/+2Rr487hu5hNe9VhSKJy5iFIcZ00Zj
         HDqQeh7NyiQkN4SIvQ2mrxKHh9w2LLZyb1N0dHR9WSyB+hqM87tGLk89FCp8CWjjw6bI
         yWmdY6pfNL9g40TA6FRE5FfpoqtWYTqAqDJljW52xiUABv3r+snvBuaSeKchd3sMRz/B
         ntg52VTPOzQ2iOCuABR+nFnYZntSdiE6whjfI3vi59C0qxUahD07RTvoO7E3PtMr+jx9
         lkLw==
X-Forwarded-Encrypted: i=1; AJvYcCVi58QzZLlzRGyjWFQW3qMjLDjW/wIRTxrp/n7bmDs4+hfrfucCj7swEz4qwE+EQuPR98y2nK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKcKKFDIH4oMtv73pzfGomcRBa6EzZf4f778FO+EdBSlZe88p
	NyqSMtkpUhrvzS7fGfSS1buKquSJIObIKhnMdDNxy8/dHqmdLy/q0P/goOrUMU9Kq4IktAgJwaB
	m2GuIAkQc3GR+l8oqm7T5AudBoFiUx9i+jz39cX+H
X-Gm-Gg: AY/fxX6r5/rwksMME3a6/FzpXO2Ma/b9mrWn28Zk+uRPtTzcVrZ6Uj7/9rADFsip6+E
	azclZo8C0qLOxkiGU7jWug2sYz4o60iVPF399ZDcKtjTIXpSqhnp9nq2IzibfVAyDV2sMDo5mqL
	pQlS3Bbd8e6lKJDTR1rW6X/+pdpN14AnR/xPRu7KxijgNSUBLCB7ib56mV/6QyzXiVl/WTKvz7Q
	Sxa0M4Y9Kia1qXgCEUBtAJ1HKqIA8LM82WmwZR3omvVjjaDXhGiDH7ywd9j/la4ogYmVnjZAKwK
	xrKPqHljy0CMNYD6bS4bapQqGKri/8jGz2a09X8MV/BVX3U42qCJODzVCH1/0zayRqaU
X-Received: by 2002:a05:7022:e28:b0:119:e569:f262 with SMTP id
 a92af1059eb24-1244b3359e7mr13971228c88.11.1768946016799; Tue, 20 Jan 2026
 13:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120125353.1470456-1-edumazet@google.com>
In-Reply-To: <20260120125353.1470456-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 20 Jan 2026 13:53:25 -0800
X-Gm-Features: AZwV_QhDty59E6gd0eGviuWFVgNNWxmTDQmV25jeTZD-k4DKZSQl5Vnu4o3NcgM
Message-ID: <CAAVpQUANrWn4sRLWYrMkFEkm0Qc+=6=WPjftBcx3+dHrHxgdPA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: preserve const qualifier in tcp_rsk() and inet_rsk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251625-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6B9B44CA8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 4:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We can change tcp_rsk() and inet_rsk() to propagate their argument
> const qualifier thanks to container_of_const().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

