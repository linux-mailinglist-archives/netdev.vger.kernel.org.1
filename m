Return-Path: <netdev+bounces-278026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E/fAAzC3Gn5VwkAu9opvQ
	(envelope-from <netdev+bounces-278026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11C3EA719
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FB263071033
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06123B8D4A;
	Mon, 13 Apr 2026 10:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1483B7770
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074858; cv=none; b=oEpeG57yPJTjrCr+TzcTlK+dnGFpb4Vr3StH/+pMjymIzffOAhhIv4nPdPCVzLmgfQqPgRSRxbKkD2oy65rPXCzQBRiuRYoEvqDNH5LiWWwv1kMfQuAjWW9uqazS8Jtl8lyL9kA8VhnStQfxqL+d82JftkQuBLerpphKKnaFGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074858; c=relaxed/simple;
	bh=jqlmsgW1ZXF9UwTaqAX0MQN18po3bOo3czPFfe39k1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eWbo9qyeVwFFaY1DuuSJ33vD5WrvaVi/aV+uToAp3ONOkNf6Y6RvYGHbz2y49YYgI7XjUKejv7kZrLmQBu1mIgXMUpqDdZa8ANI9u0QeG3Nke18RnJsuu7lwbVs5s1+3Tv+6VxO08tf7c2cPwME/TMFlum/udjD1BUKAiq51QV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: phx <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_cake: fix NAT destination port not being
 updated in cake_update_flowkeys
In-Reply-To: <CAKvCo-yFnu3RBbiGkaVi-X5qX_hN1a-FYrBZfzB9UKz8k-PZtQ@mail.gmail.com>
References: <20260413084715.70169-1-phx0fer@gmail.com>
 <874ilfdwoe.fsf@toke.dk>
 <CAKvCo-yFnu3RBbiGkaVi-X5qX_hN1a-FYrBZfzB9UKz8k-PZtQ@mail.gmail.com>
Date: Mon, 13 Apr 2026 12:07:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y0ircgwp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [1.60 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-278026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:mid];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[]
X-Rspamd-Queue-Id: 7E11C3EA719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

phx <phx0fer@gmail.com> writes:

> You're right, "vulnerability" is too strong - it's a correctness
> bug, not a security issue. Thanks for picking it up.

Cool. Could you please re-send with an updated commit message? Thanks!

-Toke

pw-bot: cr

