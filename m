Return-Path: <netdev+bounces-274200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PKnBjZUzWkMcAYAu9opvQ
	(envelope-from <netdev+bounces-274200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2022837E976
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2E7D3019FE2
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82B47B426;
	Wed,  1 Apr 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9LBBcW2"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B084418D7
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063132; cv=none; b=hhhjiOafyflWDkbCJF4CSOpAsjH9dEyxm7zWIx1jtFh+Vf90Yvj/0+s+Gtfi72Kzuy08u02Gp5cpTdxMhAfCKRA/+k8Qt/oBC/ugPTp3JazaVTzSjsPDBUiX7xTUu0kyvUXEUr6AFtL/6T7r1sVqT0XfjyK9vA+FYja/y5vu/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063132; c=relaxed/simple;
	bh=n2jQv47PIrnfO+hHV9FIaP6j1YbNMb5O/ELqKo3CI9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=H3cfn1D2lnEu+t4q7zvbamVPcBUHK+dpbAvn7cEuH/MgvMDWDfD8uWcJWsTR1QTp4wfacDL9wIeibQDVaA1l9Yli36Ai0yNXcjzWcw+TnGOQ8PlsxNbkw+qCGHoDnpU4QpPikEv3uFkU//We+O4XX3PFnFTdfsnaahhyqzSrrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9LBBcW2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775063128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2jQv47PIrnfO+hHV9FIaP6j1YbNMb5O/ELqKo3CI9s=;
	b=f9LBBcW2Gu2t3reQHiByZTUD2b8Yqr9IPHiTTHXIquQeQo4IzGm+GW7UgNiFDq3X924V6P
	w15pBGcYNyY8pxkuX8alWqOpP/ciGuf5f9oWFJS9z/S7q8SVJy09ABTUPkjEPEG/9QKSEh
	wEe0EirH2YVbAtQ1KvQQpQsblWV/kMM=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 19:05:25 +0200
Message-Id: <DHHZD2L18VZT.2TLAQO4JAD79Y@linux.dev>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, <luka.gejak@linux.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>, <fmaurer@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
In-Reply-To: <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274200-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2022837E976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 1, 2026 at 11:52 AM CEST, Fernando Fernandez Mancera wrote:
> On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
>> From: Luka Gejak <luka.gejak@linux.dev>
>>=20
>> Supervision frames are only valid if terminated with a zero-length EOT
>> TLV. The current check fails to reject non-EOT entries as the terminal
>> TLV, potentially allowing malformed supervision traffic.
>>=20
>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>> with a length of zero.
>>=20
>> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>> ---
>
> Hi,
>
> This has not been reviewed by Felix. Felix provided his Reviewed-by tag=
=20
> for the v1 which was completely different than this.
>
> Revisions of this patch:
>
> v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.d=
ev/
>
> v2: https://lore.kernel.org/all/20260326154715.38405-4-luka.gejak@linux.d=
ev/
>
> v1:=20
> https://lore.kernel.org/all/20260324143503.187642-4-luka.gejak@linux.dev/
>
> Are these contributions LLM/AI generated? I believe so based on the=20
> email history.
>
> AI generated review on rtl8723bs:=20
> https://lore.kernel.org/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@linux.de=
v/
>
> Another AI generated review on rtl8723bs:=20
> https://lore.kernel.org/all/3831D599-655E-40B2-9E5D-9DF956013088@linux.de=
v/
>
> Likely an AI generated review on a 1 year old HSR patch:=20
> https://lore.kernel.org/all/DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev/
>
> If these are indeed, AI generated contributions or reviews they should=20
> be disclosed beforehand. Also there is the Assisted-by: tag. Also note=20
> that developer must take full responsibility for the contribution which=
=20
> means understanding it completely.
>
> https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-=
developer-certificate-of-origin
>
> Thanks,
> Fernando.

HI Fernando,
One more question, should I include Assisted-by tag in v5 if AI was not=20
used for writing code but only for formating and translation of the=20
emails to English as I previously mentioned.

Best regards,
Luka Gejak

