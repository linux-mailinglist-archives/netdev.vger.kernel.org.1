Return-Path: <netdev+bounces-256911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH/eFED8g2kXwgMAu9opvQ
	(envelope-from <netdev+bounces-256911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:11:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD7EDE22
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AEF3301F989
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935325FA0E;
	Thu,  5 Feb 2026 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWaycEjP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744C241696
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257344; cv=none; b=b0XbXlhTG84M8WhCs3I6+nPYAVIG9/HOsF15sNx5/Vdv3oExNZ2VNJL2gg4QCchwHPAVzN1ilueTuY0SRX7tR5Rn5jUiy9fLCnXY3NrXVBmfsNDHrc+MzjruBytneJ8/eYiN2pwLRcXlk2WA6butE5GTx8wbD/W9sFCFMHwGV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257344; c=relaxed/simple;
	bh=eyffMdjBGSGAQEPIwVCVShqJDrCErQ1kaO2drX+W8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIbktcAXtOc5uE7NyWw5okRt/n+4MFJEJZKSU7XMcM5zMBimpI30MX6aSVardDJ6uuafHrH1GqjjIHfzPcIZyyg8nPBgKUnnXPqvo+eoc/UksjQy6+wrNevCHBHk9IlbHuQkBuzY5X7+MEJJJsDy9uyDrXcU/t1Y+VAy7+QhTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWaycEjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49876C16AAE;
	Thu,  5 Feb 2026 02:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770257343;
	bh=eyffMdjBGSGAQEPIwVCVShqJDrCErQ1kaO2drX+W8Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWaycEjPlwHQeQUQ9K6AIQu2WNLdU6h6fCKWo4h1OFqsxnXG9tTFnCICBnIImJ1FM
	 27f1cS7ZByLu8jsrA7l+AdiR44Dhpwjp6/KtzndMihbZOeQ0dmn+CT2S2MeYn+J/8Z
	 lXwdGfz2XgWbd2i6G69615vrEflnKpgoinf2VzLLJaDnKw02+LPTzENy/984aB/26F
	 eaUxhiHfPN1WvSwEgLRabX7UJbaYddryEwmVJ3xlfR6+g/0EcElbzjv2uNHs/hBzLv
	 DTGHYIWAXSqcwSIcUqLC+RtHXxQTxnwd6tI8Ew+Cee0rNINch/33sjgQDn1tafvwap
	 UszMMZfBtfo6g==
Date: Wed, 4 Feb 2026 18:09:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
Message-ID: <20260204180902.00918071@kernel.org>
In-Reply-To: <CALs4sv2c9QaRtrV-21YsRsGOkap5LnGPcqEnk9ELn3WcUocFOQ@mail.gmail.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
	<20260129061646.1417185-5-michael.chan@broadcom.com>
	<20260129180320.1c69a0c4@kernel.org>
	<CALs4sv2c9QaRtrV-21YsRsGOkap5LnGPcqEnk9ELn3WcUocFOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256911-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1AD7EDE22
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 21:45:12 +0530 Pavan Chebbi wrote:
> > > +
> > > +    for ctx_id in ctx_ids:
> > > +        try:
> > > +            data = get_rss(cfg, context=ctx_id)
> > > +            _rss_key_check(cfg, data=data, context=ctx_id)
> > > +            persisted_contexts.append(ctx_id)
> > > +        except CmdExitFailure:
> > > +            missing_contexts.append(ctx_id)
> > > +            ksft_pr(f"Context {ctx_id} is missing after ifup")  
> >
> > You can use netlink to get them all
> >
> > ctxs = cfg.ethnl.rss_get({}, dump=True)  
> 
> Jakub, maybe it's a rookie question but I am having trouble getting
> the netlink call to work.
> Not sure if my analysis is right but it looks like I don't have the
> right schema..
> It appears like the decode does not ignore unsupported ethnl options?
> I always get the error:
> 
> # Error decoding 'input-xfrm' from 'rss'
> 
> with the below call stack:
> 
> # # Exception| Traceback (most recent call last):
> # # Exception|   File "/tmp/ksft-net-drv/net/lib/py/ksft.py", line
> 319, in ksft_run
> # # Exception|     func(*args)
> # # Exception|   File "/tmp/ksft-net-drv/drivers/net/hw/./rss_ctx.py",
> line 395, in test_rss_context_dump
> # # Exception|     ctxs = cfg.ethnl.rss_get({}, dump=True)
> # # Exception|   File
> "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 1159, in _op
> # # Exception|     return self._ops(ops)[0]
> # # Exception|   File
> "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 1146, in _ops
> # # Exception|     rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
> # # Exception|   File
> "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 814, in _decode
> # # Exception|     decoded = self._decode_enum(decoded, attr_spec)
> # # Exception|   File
> "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 672, in
> _decode_enum
> # # Exception|     value.add(self._get_enum_or_unknown(enum, i))
> # # Exception|   File
> "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 662, in
> _get_enum_or_unknown
> # # Exception|     raise error
> # # Exception|   File
> "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 657, in
> _get_enum_or_unknown
> # # Exception|     name = enum.entries_by_val[raw].name
> # # Exception| KeyError: 2
> 
> Do you think I am missing some config?

Ah! I think you run into what I recently fixed in net.
Could you try with 1c172febdf065375 cherry-picked to your tree?
It's sitting in net, hasn't reached net-next yet.
Sorry about that..

