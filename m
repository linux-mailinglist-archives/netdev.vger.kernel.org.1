Return-Path: <netdev+bounces-274066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBhnLMT/zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5A3794A6
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F02EC3088EA6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485736EAAE;
	Wed,  1 Apr 2026 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bgLPNfQV"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD51AE877
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041622; cv=none; b=GFg7fKTvU39jdnSI2FwkDamr2Q4NR5CCQEzMeCC3y00Df6t/l+CbnMCKFVL9tZ4Zh5FzaU4+lwP+yDZwpiueIPtFwgajgGGEwXvY/V+Mz0rkWIYeaDgLM33zfCgOnRPVS5E4i95i8aOcjF3EraUMCd9QcsajcJ9mLQqmR3kLytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041622; c=relaxed/simple;
	bh=1MTI6WHu4XlPWpmiNtRvqpHuLq0+7OEng2q0et2PCbc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PJi14TLtv6zPQ4l0CGb4nka4o6lUrlILCpnCnYR1T1C6KlxB2TF67K22Z9aatvPtPZkOTx2FeCuG+2wr7Sq6LtvA31vJ70w3zs+6xCFoG9biQxgQd4Y/1Zy7kgMZDzWKRxfFjsgxM3eVHpFpwE1MtZ5jxvpN35nJPyThS1ziAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bgLPNfQV; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 01 Apr 2026 13:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775041619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MTI6WHu4XlPWpmiNtRvqpHuLq0+7OEng2q0et2PCbc=;
	b=bgLPNfQVXb22aWtLmMYHdPw8og76fnDwlmiAsE9kyh+f0YuyLtdYj2xNy2KIjOdyrQDbof
	vJAzAAqy5Lx1AOF5d6OqRy3sm7WQnLXUp+3fTxmlvQFrKab4N/keopgEc5aHHDWrZEJblx
	0O1u6wiLbXJbEAVLR050rOUZHi3Vt38=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
CC: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v4_1/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_require_valid_EOT_supervision_TLV?=
In-Reply-To: <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
References: <20260401092324.52266-1-luka.gejak@linux.dev> <20260401092324.52266-2-luka.gejak@linux.dev> <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
Message-ID: <85A635E3-DF1B-42CA-B552-729943E5C0D5@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-274066-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 26E5A3794A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 1, 2026 11:52:02 AM GMT+02:00, Fernando Fernandez Mancera <fmancer=
a@suse=2Ede> wrote:
>On 4/1/26 11:23 AM, luka=2Egejak@linux=2Edev wrote:
>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>=20
>> Supervision frames are only valid if terminated with a zero-length EOT
>> TLV=2E The current check fails to reject non-EOT entries as the termina=
l
>> TLV, potentially allowing malformed supervision traffic=2E
>>=20
>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>> with a length of zero=2E
>>=20
>> Reviewed-by: Felix Maurer <fmaurer@redhat=2Ecom>
>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>> ---
>
>Hi,
>
>This has not been reviewed by Felix=2E Felix provided his Reviewed-by tag=
 for the v1 which was completely different than this=2E
>
>Revisions of this patch:
>
>v3: https://lore=2Ekernel=2Eorg/all/20260329112313=2E17164-4-luka=2Egejak=
@linux=2Edev/
>
>v2: https://lore=2Ekernel=2Eorg/all/20260326154715=2E38405-4-luka=2Egejak=
@linux=2Edev/
>
>v1: https://lore=2Ekernel=2Eorg/all/20260324143503=2E187642-4-luka=2Egeja=
k@linux=2Edev/
>
>Are these contributions LLM/AI generated? I believe so based on the email=
 history=2E
>
>AI generated review on rtl8723bs: https://lore=2Ekernel=2Eorg/all/B2394A3=
C-25FD-4CEA-8557-3E68F1F60357@linux=2Edev/
>
>Another AI generated review on rtl8723bs: https://lore=2Ekernel=2Eorg/all=
/3831D599-655E-40B2-9E5D-9DF956013088@linux=2Edev/
>
>Likely an AI generated review on a 1 year old HSR patch: https://lore=2Ek=
ernel=2Eorg/all/DHFG26KI6L23=2E1YCOVQ5SSYMO5@linux=2Edev/
>
>If these are indeed, AI generated contributions or reviews they should be=
 disclosed beforehand=2E Also there is the Assisted-by: tag=2E Also note th=
at developer must take full responsibility for the contribution which means=
 understanding it completely=2E
>
>https://docs=2Ekernel=2Eorg/process/coding-assistants=2Ehtml#signed-off-b=
y-and-developer-certificate-of-origin
>
>Thanks,
>Fernando=2E

Hi Fernando,
About the Reviewed-by tag, that was my mistake=2E I forgot to remove it=20
when rebasing=2E And about AI=2E I=E2=80=99ve been using it to help format=
 my=20
emails and translate them into English since it isn't my native=20
language=2E However, the technical logic and the code itself are my own=20
work, written without AI=2E Should I send v5, and if so, what should I=20
do besides stripping the Reviewed-by tag? I've read the documentation=20
on coding assistants you linked and will make sure to follow it on the
next revision=2E
Best regards,
Luka Gejak

