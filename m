Return-Path: <netdev+bounces-304961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E6xeDmSKS2p2VAEAu9opvQ
	(envelope-from <netdev+bounces-304961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94570F907
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jd2yAfyO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304961-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304961-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B3A035BCECC
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50A442130;
	Mon,  6 Jul 2026 10:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DD44211B;
	Mon,  6 Jul 2026 10:16:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332995; cv=none; b=OcXs1RwE8rlqeKJXDiMqAV6r+xgOpVuL09W3x4hYY/egNgJzX+RveOLAtP/7FZizEodu9RWX1+3PuLZaB9+fB/6MB4qLj1KYK/8Qnu3T543JCeNad0lY6/KZNWf3Is4766h4Qt9OWnHpF6CcZHo5VmNBp4Fo6j5KUhJdwss3khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332995; c=relaxed/simple;
	bh=Ui/6WL/wE/IDrkuouB3Cpe6r7kaK99syNQCjQSVq+XQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vu+njwD769XqcQT+y1XMhRgtzSiylY0zd9Pg3KIuyoU+lv79yTUVn6ABTzSVWceXobiCgvzc0Fa+hrLm2t3fXQRYO1E9wXJ5vqgfZr6BH3+FQngE32FhFfk/IxX1pjh9ajo4pjyRiVqZsKEmVR1/YJNdfi9WkFyOpx3SQeO6lTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd2yAfyO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A361F000E9;
	Mon,  6 Jul 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332993;
	bh=yT+Ai7PVmpAGS1R+fNNohYl4y8lLsQnylybaH+IWsZM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jd2yAfyOznOWM1i2Ex037TWFM7s+HhO1kBqYSmUyH4LNJVTE4mwE75V0fcjoEkF6C
	 IFKL54m+7HZSeZR/IY6no51OooriHNxhrUQ3TTrntwWHmP4mZuleKJKufAT/TJEfTD
	 TW99ZoZ1hahJl5gNfH/dfDwXyRhf8T4FPQwEJEKCzKkOdj0fNCbM3sqHvXwSJs/fPM
	 HgoU87Ir/VXbg9FbyyZ/zF8s7Jm0XfpWKg/bMAlWEOuzpo4q4UEHpqlHRQdDtIGpyN
	 YrSbKjzBH5N3Au/2EiKn7BgYfagVaGr+8vUUWEXzEEMGPyj2qySQtou/oMPLvbu0AT
	 tfKVqrYrvBIeQ==
Content-Type: multipart/mixed; boundary="===============4166175548752548279=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d49e2fcbde106e80971b769793170fd479315d563d31bcaf6db33737c01c814c@mail.kernel.org>
In-Reply-To: <20260706093525.13030-4-mahe.tardy@gmail.com>
References: <20260706093525.13030-4-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 10:16:33 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-304961-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:mahetardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E94570F907

--===============4166175548752548279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
> bpf setup program creates a ksock context and connect the socket.
> Another syscall bpf program lookup the context and send test data.
> The userspace harness create a network namespace and a new socket on
> loopback, run the setup and send syscall bpf progs then check that the
> userspace socket received the data from bpf.

This isn't a bug, but would a quick pass over the changelog wording help
here?  A few spots read a little off:

  "One sycall" -> "One syscall"
  "creates a ksock context and connect the socket" -> connects
  "Another syscall bpf program lookup the context" -> looks up
  "The userspace harness create a network namespace" -> creates


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022
--===============4166175548752548279==--

