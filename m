Return-Path: <netdev+bounces-277899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPbLGMsE3GnCLAkAu9opvQ
	(envelope-from <netdev+bounces-277899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:47:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2233E5EF5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4FD300955A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0630CD85;
	Sun, 12 Apr 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2PPHmow"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857C292B44
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776026823; cv=none; b=IwYBEetg40EffZzgup0pYjbI1KvHLmThyNAwiRl0UIRB2Nd1/3W9/ftV3dLvrv86iF0L4KxjfKnp4HArH/z+hwIxUYdOQ4+z8KZO7LO3MVVyDJvk9b+pmAawOJ94Y4+7TwyHDYuTIpiFvuSmcz5X2/4buX9x0OMJq3fojEXFuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776026823; c=relaxed/simple;
	bh=kC2WfPwQn5GwuR+hHHVvoKKJeXooIQ0/5D03gv6/z9Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=N4ShW0+xkTyAJ/sZDDPAQJoZ7bYUux6dmwNToN9Xn9zCVDOYxIJVKEplinkZd0D11EQrxBgHBq4gNhrYgrfhvU6L+N0KVEw1TrOECu/rS/zmtDExMF9fPa5GyGQ3fc5c6osnRBEMV+m/+yG/jPDZeSDohfte+T9f4IDARuilP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2PPHmow; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 12 Apr 2026 22:46:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776026819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC2WfPwQn5GwuR+hHHVvoKKJeXooIQ0/5D03gv6/z9Y=;
	b=t2PPHmow5NK8ETq5rmhrXbnr0TbpVgeyvLoJpMoQiM6wLfSCyefwCvI2Hz55Xh8fRtxyyP
	5iiFh6rl15NQW0dHmfg0UOFtrgnuF69GQdX3gYOS5XsXMPfSsPj3kz5qw6Db2AtHSoLpwy
	zFhRcPhnYQtNQSBgHVd220uURyjZddQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
CC: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org,
 luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v5_1/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_require_valid_EOT_supervision_TLV?=
In-Reply-To: <20260412133157.3b335e1b@kernel.org>
References: <20260407162502.19462-1-luka.gejak@linux.dev> <20260407162502.19462-2-luka.gejak@linux.dev> <20260412124558.190c725f@kernel.org> <DDF9CC02-6FC1-44F0-B95D-967151BF0592@linux.dev> <20260412133157.3b335e1b@kernel.org>
Message-ID: <0CA147BE-C5AD-4B02-BE57-B586218B52A2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-277899-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA2233E5EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 12, 2026 10:31:57 PM GMT+02:00, Jakub Kicinski <kuba@kernel=2Eorg>=
 wrote:
>On Sun, 12 Apr 2026 22:13:35 +0200 Luka Gejak wrote:
>> Regarding the TLV loop: I actually implemented a TLV walker in v4 [1]=
=20
>> for this exact reason, but I moved to strict sequential parsing in v5=
=20
>> based on reviewer's feedback to keep the implementation simple=2E Could=
=20
>> you please check if the approach used in v4 is what you had in mind?=20
>> If so, I will rebase that logic onto the memory safety fixes=20
>> (pskb_may_pull) from v5 and submit it as v6=2E
>
>That's not really what I had in mind=2E I was thinking of a loop which
>just skips the TLVs in order, leaving the parsing of known TLVs as is=2E
>But I've never used HSR maybe this sort of strict validation is somehow
>okay in HSR deployments=2E
>
>Please just undo the comment tweaks then=2E

So keep other changes as is and only undo comment changes?

