Return-Path: <netdev+bounces-301458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G5GoMHLQOmqaHggAu9opvQ
	(envelope-from <netdev+bounces-301458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:29:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B06B96E8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:29:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dVAUnxd2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301458-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301458-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D1B3041241
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAB3932F0;
	Tue, 23 Jun 2026 18:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56603932DA
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 18:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239343; cv=none; b=Cpkf870t+YAo7442HRTp5kuafWpqDzW3HRzm+BoW/nxh4kQA9Uf90IDm0mP+29IYqU2+OKP4p9TcCtzCtWgoh5MzSl4hJZXnmDiAC7UmMofjT/tqTT/8QGis44FGZeu7ybPucFh/gZDt9gd5Lr9522liY1+qxw9oNvqi0JZexcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239343; c=relaxed/simple;
	bh=ur9YcBIx9OOlzB4KIAFGKXMYB4qRT61i90PE7nu7grM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAQ8Up0BmXJX+hSJ+YH2yaXHhrFmasZhTHjo+U+Ha6S6v5Yq9AWRiZlQ3E5jElu7pvL+a/PMXmfrDnANfDe3ZrhuOA6FENKVpAzTKtCgY57PJzPx8JeR1zbh5WGtUGDH4Be3jivPUw0PdYYDPW7XD+kYjYUBPS0gEm4is/jYvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVAUnxd2; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84237c55ef9so216071b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782239342; x=1782844142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTYF1+0lyIvhIpVE2MUXYwIwgLw0923N5fDH7s7CEkc=;
        b=dVAUnxd21rzpHnZY+B0acolaFB2lQ/rSbryQr5/laYEv5DoVJ30e40G/FimJRVPOfD
         V8bZ7HqM+qBS8h3ZDJTjYyFrxicvx4wfPFfSQ+dM55uMiJFeOpq5NyxldSmVYrah1laK
         I2vedj2wEvkv0Q7OqL/IaeA3gdEtBYEGexVyK/bqEsj/iDpqQ7gm8B674Rplj2il39gj
         FsdWZkUbLUAmHeIb0QLRQH8l/WT5G1JWkwcM1O0fxxLCMqvEBLQ3D4gFBrjToLmYKCVQ
         fYDlATYC8MDtpuYtpjLh9V5t1ei3n2+mrkQExzSHzSQFW9CYRFKf9NWh5HAj80RY/OZw
         ZNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782239342; x=1782844142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTYF1+0lyIvhIpVE2MUXYwIwgLw0923N5fDH7s7CEkc=;
        b=aw2dBI1YEVm4F5L2E8Ch/8f+NWych+l0v04XK/SwM3sNlmMG/RatwEJZM9pT1A43y8
         yHCudpVZZlfGbr59sf2HiwLhofWBpOj/8Dgz0MMbSi/h6YMv1BhaGGB1aMr7DtTUaNYo
         S2BHmm3erAl1/Q6Ye9ISoGVxkVVrO6GlYChe6Hz2NaqaB750tdECWGcgjSLdHcGlucQ2
         YOrGPT6OF2dNcEst0oJ+P/CEGI/rzjHqDw38IMDC8vTfGagPTil+5aLIahIB5b8qxBT5
         tcsS/ave/4hMO2wOTfELFq7pudKuklKRtmEAOS/MR5nCpM2R9WsEYDB/+Fe3LBxaRGvc
         LsYg==
X-Forwarded-Encrypted: i=1; AFNElJ9YG+46QqRrZ9Ge5E7GTWlzA5TV7NrTJfJi60HW6ukKQ1w5Ze77L/eA1UwPJ8mNXN4936Bf5ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4oV0wrlNoBlteBvHxVkU71t7k5RmPXvo+mtXcMUEMrxx7Zuj
	CQOyAQ8Wl8pqK8A6Rt0kmHQFEbSOKmr2bYUJ9wFdwtV/I9Fq7naRqvWG
X-Gm-Gg: AfdE7cm2TLXajOmTTKd01ZA5F4TCU0wcbcSkl9v1RBcVqxTlRA5SCWaJN19RhbWcUMr
	FT4gD42UcC8NKJPzoXqhfGgrC8StT3TnZNhLWy3Tp6tll+1J0lJhaUEmsmOy6BpIrgHHyKxCcAe
	6peMfZxrbEdeWk1FvKk12oD/gCG56XTI8jVXdTBNfridjCEJYRhY6fbqMVBn0NUTogsdXxUxgKW
	HBqMvGMbZ0wC+4dzul2ykcgIFo/NRezBeWYKypWkr6WEh3N36u6witeK5MOF2GQwm+Fup3HFTbD
	E3U+IHAFIF+5O0w9buOEwBs9kfzAOroRItT4yDQLjGGRyksWtmKYK4OaSGgdlC6xyDaw+7noH9P
	Z7QG0ypwvTydy7MXnS/Ui2/b08pbwhSsHfDr6Hb3ylCG0AdWRxQBn5mbCGsSKkjjbQBTtEiJ1zN
	uLlr+z/yGiOp4/z09ih7I/THQ+Dxbio+bYQiLRgNf2YL4HOwrAHyyZItPShHuO
X-Received: by 2002:a05:6a00:6c90:b0:845:3033:6cb7 with SMTP id d2e1a72fcca58-8459524d4d5mr5244859b3a.9.1782239341727;
        Tue, 23 Jun 2026 11:29:01 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c5dbsm10835213b3a.12.2026.06.23.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:29:01 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Tue, 23 Jun 2026 23:58:49 +0530
Message-ID: <20260623182849.2623521-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <877bnpeaeq.fsf@toke.dk>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com> <20260623025147.1001664-2-avinash.duduskar@gmail.com> <877bnpeaeq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A8B06B96E8

Toke Høiland-Jørgensen <toke@redhat.com> writes:

> I think it's better to just move the assignment of params->ifindex
> entirely into bpf_fib_set_fwd_params(), instead of this restore dance.
> That way this can be simplified to:
>
> 	err = bpf_fib_set_fwd_params(dev, params, flags, mtu);
> 	if (!err && fwd_dev)
> 		*fwd_dev = dev;
> 	return err;

The caller-side restore is ungainly, agreed, but the assignment can't move
all the way into the helper. The early params->ifindex = dev->ifindex
sits above the neighbour lookup on purpose: that is d1c362e1dd68a
("bpf: Always return target ifindex in bpf_fib_lookup"), which took it
out of bpf_fib_set_fwd_params() and put it there so a program still
gets the target ifindex on the BPF_FIB_LKUP_RET_NO_NEIGH path and can
bpf_redirect_neigh() on it. bpf_fib_set_fwd_params() is called only at
the set_fwd_params label, below the NO_NEIGH return (and below the IPv6
NO_SRC_ADDR return), so an assignment living in the helper never runs
on those paths and params->ifindex falls back to the input. That would
change the reported ifindex for plain bpf_fib_lookup() callers hitting
NO_NEIGH, not only the VLAN ones.

I can still get the caller down to your form by keeping the early write
and moving just the VLAN_FAILURE rewind into the helper, with one extra
parameter, the input ifindex saved before the egress write:

	err = bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
	if (!err && fwd_dev)
		*fwd_dev = dev;
	return err;

and the helper owning the rewind in the unreducible branch:

	} else {
		params->ifindex = in_ifindex;
		return BPF_FIB_LKUP_RET_VLAN_FAILURE;
	}

So the restore leaves the caller; the early egress write stays because
NO_NEIGH and NO_SRC_ADDR depend on it.

3/3 adds a NO_NEIGH arm that pins the egress ifindex (input != egress):
with the assignment moved into the helper, that case reports the input
ifindex instead, while the return code stays NO_NEIGH, only the ifindex
flips. It passes with the early write kept.

> If you move the ifdef into the if statement, the if statement can have
> an else-branch that assigns params->ifindex, so you don't need the
> restore dance (see below).

Same constraint: an else-branch inside bpf_fib_set_fwd_params() only
runs when the helper runs, which is never on the NO_NEIGH/NO_SRC_ADDR
returns, so it cannot be the sole writer of the egress ifindex.

Does the in_ifindex version look right to you? The alternative is to
route the error returns through the label so the assignment can live
fully in the helper; threading the return codes back through it works,
but it is its own kind of dance and reads worse to me.

Thanks,
Avinash

