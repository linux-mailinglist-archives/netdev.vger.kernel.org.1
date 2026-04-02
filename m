Return-Path: <netdev+bounces-274392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPG7HHEOzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:36:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1AA3848A7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA60030300EA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8E2E1F06;
	Thu,  2 Apr 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JVHZ7NT/"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF27273D6D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111703; cv=none; b=GRkVCwtAechwj9fi1rCRF1EVmyr0dyieMKDAKifEfQRUKYFdux2rnKsKqhW2xYvoAjKBIv3vKMPR2I4OjC7LQg5S14FlBXVBMFDX36zpA2SHRrUzfcKUXalgT8bOzyDNdPG5zMalFusbDY8/GCI1zo92eNASCd4MzLms8JAimOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111703; c=relaxed/simple;
	bh=ANuUFUZvI9nPefEPdOfV7Qqa6MjA7AaIxbEUpm/tjHc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oYbkxnGGmm4kjRVTKzo6iY5oKK98vouQzB1Zw+RafMVemNJ//gx0iR+IgU31Gkfgg0cyabLmCtqrG6t+6X3LKsfyYCwpEt+w/4qAUbDFMvJR+USBtXi8/CSDlcx6PIrTYIM7STMk05+FCEqATnnx17EaLfc+mX3q2uamvSxpWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JVHZ7NT/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 02 Apr 2026 08:34:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775111699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANuUFUZvI9nPefEPdOfV7Qqa6MjA7AaIxbEUpm/tjHc=;
	b=JVHZ7NT/wyTUk1fgK4vaIpww4M0ekAYVUAqmQ8AB702lrxlNLfu4TA57KPTQGi0uNwbuBk
	/N94+qu/yqRDoA1+I8ca+R92q0c2bw/gi3yCl2lboP/Yw0VQ0P9zZqYIE1HAXZcf4cxSD1
	ZwgjG66UxcIA6KXGc1Sq7EpQi+NUZDM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
CC: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org,
 luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v4_1/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_require_valid_EOT_supervision_TLV?=
In-Reply-To: <78c9c953-1aaa-4d44-9c1d-b4e52a5cead3@suse.de>
References: <20260401092324.52266-1-luka.gejak@linux.dev> <20260401092324.52266-2-luka.gejak@linux.dev> <4549f521-6395-4c26-921e-eaead7248a36@suse.de> <DHHZD2L18VZT.2TLAQO4JAD79Y@linux.dev> <78c9c953-1aaa-4d44-9c1d-b4e52a5cead3@suse.de>
Message-ID: <811E5B8F-85E7-47E2-BEA1-25E62C68929C@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-274392-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid,suse.de:email]
X-Rspamd-Queue-Id: DE1AA3848A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 2, 2026 1:30:57 AM GMT+02:00, Fernando Fernandez Mancera <fmancera=
@suse=2Ede> wrote:
>On 4/1/26 7:05 PM, Luka Gejak wrote:
>> On Wed Apr 1, 2026 at 11:52 AM CEST, Fernando Fernandez Mancera wrote:
>>> On 4/1/26 11:23 AM, luka=2Egejak@linux=2Edev wrote:
>>>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>>>=20
>>>> Supervision frames are only valid if terminated with a zero-length EO=
T
>>>> TLV=2E The current check fails to reject non-EOT entries as the termi=
nal
>>>> TLV, potentially allowing malformed supervision traffic=2E
>>>>=20
>>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>>> with a length of zero=2E
>>>>=20
>>>> Reviewed-by: Felix Maurer <fmaurer@redhat=2Ecom>
>>>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>>>> ---
>>>=20
>>> Hi,
>>>=20
>>> This has not been reviewed by Felix=2E Felix provided his Reviewed-by =
tag
>>> for the v1 which was completely different than this=2E
>>>=20
>>> Revisions of this patch:
>>>=20
>>> v3: https://lore=2Ekernel=2Eorg/all/20260329112313=2E17164-4-luka=2Ege=
jak@linux=2Edev/
>>>=20
>>> v2: https://lore=2Ekernel=2Eorg/all/20260326154715=2E38405-4-luka=2Ege=
jak@linux=2Edev/
>>>=20
>>> v1:
>>> https://lore=2Ekernel=2Eorg/all/20260324143503=2E187642-4-luka=2Egejak=
@linux=2Edev/
>>>=20
>>> Are these contributions LLM/AI generated? I believe so based on the
>>> email history=2E
>>>=20
>>> AI generated review on rtl8723bs:
>>> https://lore=2Ekernel=2Eorg/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@l=
inux=2Edev/
>>>=20
>>> Another AI generated review on rtl8723bs:
>>> https://lore=2Ekernel=2Eorg/all/3831D599-655E-40B2-9E5D-9DF956013088@l=
inux=2Edev/
>>>=20
>>> Likely an AI generated review on a 1 year old HSR patch:
>>> https://lore=2Ekernel=2Eorg/all/DHFG26KI6L23=2E1YCOVQ5SSYMO5@linux=2Ed=
ev/
>>>=20
>>> If these are indeed, AI generated contributions or reviews they should
>>> be disclosed beforehand=2E Also there is the Assisted-by: tag=2E Also =
note
>>> that developer must take full responsibility for the contribution whic=
h
>>> means understanding it completely=2E
>>>=20
>>> https://docs=2Ekernel=2Eorg/process/coding-assistants=2Ehtml#signed-of=
f-by-and-developer-certificate-of-origin
>>>=20
>>> Thanks,
>>> Fernando=2E
>>=20
>> HI Fernando,
>> One more question, should I include Assisted-by tag in v5 if AI was not
>> used for writing code but only for formating and translation of the
>> emails to English as I previously mentioned=2E
>>=20
>
>I think yes, you should=2E I also think that AI was actually used for the=
 generated code and also for spotting the valid and invalid issues=2E If yo=
u don't have a real environment for HSR, why would you look into it?
>
>Sorry, it is not my intention to be harsh but there are some things that =
don't add up for me=2E Maybe I am being too careful here and you just coinc=
identally found these problems=2E
>
>> Best regards,
>> Luka Gejak
>>=20
>

Hi Fernando,
I understand the concern=2E To clarify, I am a student, and I discovered
these issues while reading the HSR source to learn about network=20
redundancy=2E Since I lack industrial hardware, I verified the logic=20
using network namespaces and veth pairs on my Arch laptop=2E The code=20
and logic are entirely my=2E As previously mentioned, I only use AI for=20
English translation and formatting to ensure my communication is=20
clear=2E As requested, I will wait for Felix's review before proceeding=20
with any changes for v5=2E
Best regards,
Luka Gejak

