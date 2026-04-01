Return-Path: <netdev+bounces-274146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FVOJuk4zWnfawYAu9opvQ
	(envelope-from <netdev+bounces-274146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:25:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53037D070
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E650D3040E39
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16EC349AF6;
	Wed,  1 Apr 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hw/eBYEO"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187602FFF8F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055409; cv=none; b=YwtAXtS3aqIOTT4DGwkvScPBH1f3dwnqno4P+ID5WdV5XrN5L+G9R0gAzNwpGNpJOriu/SsLtU2TjpQsvkVmsZ1j+0W+D1wu/NZckrts9KkLgcA6lut8zAUG9urY/YKvCq1CRXKR1ZAhhdzTjUozNCqC2fx4nPI//x9kOqRQ8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055409; c=relaxed/simple;
	bh=zmAIsh5TPGPWyaH9h1u8K4jk5A9WaffOj9BvsQ5Dack=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JZbYXIzsgShFT8IJ+KvG+NZNYihbieacvWJqpp4maWc5P+A06bGA+CJzmbC8uwzBp2oN82ZbJlFTJCheweAS8GuBzsn+RxLxcZIfwSUY00zlff1YP8ALpA5W4a/t+tXdY2Fvv4/twYK8qsbGjE6rNvqX+8UPKyXpm+F7dy2/kE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hw/eBYEO; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 01 Apr 2026 16:19:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775055405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmAIsh5TPGPWyaH9h1u8K4jk5A9WaffOj9BvsQ5Dack=;
	b=hw/eBYEOa6ANBvKQ6dQqLqdn50aNhBEEfAswHqtoFJwkgq4Q2Znu9WLyLXv46lrxjDMDS7
	7M7PybEWiuW0sI9BgAW9QQk6qjzLayTARCZBNS91Hs6X3qtChGS7tB6wPxnRuge3szD38r
	w9MCkVVkAe8D0APflPTaHYFMYCm6VD8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
CC: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v4_1/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_require_valid_EOT_supervision_TLV?=
In-Reply-To: <8cf382ce-b110-4758-9de4-8944ba980ca3@suse.de>
References: <20260401092324.52266-1-luka.gejak@linux.dev> <20260401092324.52266-2-luka.gejak@linux.dev> <4549f521-6395-4c26-921e-eaead7248a36@suse.de> <85A635E3-DF1B-42CA-B552-729943E5C0D5@linux.dev> <1a22150a-0f4c-412a-9789-ece497d1c92c@suse.de> <7540A920-76E7-4768-9E62-6666D0FECFA9@linux.dev> <8cf382ce-b110-4758-9de4-8944ba980ca3@suse.de>
Message-ID: <72395245-A435-453C-925B-93417BA845F6@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-274146-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 8E53037D070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 1, 2026 3:44:16 PM GMT+02:00, Fernando Fernandez Mancera <fmancera=
@suse=2Ede> wrote:
>On 4/1/26 3:31 PM, Luka Gejak wrote:
>> On April 1, 2026 2:05:49 PM GMT+02:00, Fernando Fernandez Mancera <fman=
cera@suse=2Ede> wrote:
>>> On 4/1/26 1:06 PM, Luka Gejak wrote:
>>>> On April 1, 2026 11:52:02 AM GMT+02:00, Fernando Fernandez Mancera <f=
mancera@suse=2Ede> wrote:
>>>>> On 4/1/26 11:23 AM, luka=2Egejak@linux=2Edev wrote:
>>>>>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>>>>>=20
>>>>>> Supervision frames are only valid if terminated with a zero-length =
EOT
>>>>>> TLV=2E The current check fails to reject non-EOT entries as the ter=
minal
>>>>>> TLV, potentially allowing malformed supervision traffic=2E
>>>>>>=20
>>>>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>>>>> with a length of zero=2E
>>>>>>=20
>>>>>> Reviewed-by: Felix Maurer <fmaurer@redhat=2Ecom>
>>>>>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>>>>>> ---
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> This has not been reviewed by Felix=2E Felix provided his Reviewed-b=
y tag for the v1 which was completely different than this=2E
>>>>>=20
>>>>> Revisions of this patch:
>>>>>=20
>>>>> v3: https://lore=2Ekernel=2Eorg/all/20260329112313=2E17164-4-luka=2E=
gejak@linux=2Edev/
>>>>>=20
>>>>> v2: https://lore=2Ekernel=2Eorg/all/20260326154715=2E38405-4-luka=2E=
gejak@linux=2Edev/
>>>>>=20
>>>>> v1: https://lore=2Ekernel=2Eorg/all/20260324143503=2E187642-4-luka=
=2Egejak@linux=2Edev/
>>>>>=20
>>>>> Are these contributions LLM/AI generated? I believe so based on the =
email history=2E
>>>>>=20
>>>>> AI generated review on rtl8723bs: https://lore=2Ekernel=2Eorg/all/B2=
394A3C-25FD-4CEA-8557-3E68F1F60357@linux=2Edev/
>>>>>=20
>>>>> Another AI generated review on rtl8723bs: https://lore=2Ekernel=2Eor=
g/all/3831D599-655E-40B2-9E5D-9DF956013088@linux=2Edev/
>>>>>=20
>>>>> Likely an AI generated review on a 1 year old HSR patch: https://lor=
e=2Ekernel=2Eorg/all/DHFG26KI6L23=2E1YCOVQ5SSYMO5@linux=2Edev/
>>>>>=20
>>>>> If these are indeed, AI generated contributions or reviews they shou=
ld be disclosed beforehand=2E Also there is the Assisted-by: tag=2E Also no=
te that developer must take full responsibility for the contribution which =
means understanding it completely=2E
>>>>>=20
>>>>> https://docs=2Ekernel=2Eorg/process/coding-assistants=2Ehtml#signed-=
off-by-and-developer-certificate-of-origin
>>>>>=20
>>>>> Thanks,
>>>>> Fernando=2E
>>>>=20
>>>> Hi Fernando,
>>>> About the Reviewed-by tag, that was my mistake=2E I forgot to remove =
it
>>>> when rebasing=2E And about AI=2E I=E2=80=99ve been using it to help f=
ormat my
>>>> emails and translate them into English since it isn't my native
>>>> language=2E However, the technical logic and the code itself are my o=
wn
>>>> work, written without AI=2E
>>>=20
>>> So I don't think this change in code is related to rebasing at all=2E =
The code in this function is identical when comparing net and net-next tree=
 so why a rebase would cause such change in the code? Am I missing somethin=
g here?
>>>=20
>>> In addition to that, the new logic does not make any sense=2E What mot=
ivated the diff from v3 to v4? All that information is missing=2E
>>>=20
>>> Thanks,
>>> Fernando=2E
>>>=20
>>> Should I send v5, and if so, what should I
>>>> do besides stripping the Reviewed-by tag? I've read the documentation
>>>> on coding assistants you linked and will make sure to follow it on th=
e
>>>> next revision=2E
>>>> Best regards,
>>>> Luka Gejak
>>>>=20
>>>=20
>>=20
>> Hi Fernando,
>> These 2 patches were in the same patch series as 2 other patches=2E
>> Then, when rebasing to edit 3rd patch in original patch series(3/4), I
>> forgot to remove the Reviewed-by tag(I ran git commit --amend
>> --no-edit)=2E Then I separated 1st 2 and 2nd 2 patches into separate
>> series (one for net and other for net-next) because I was instructed
>> to do so by Jakub Kicinski=2E His email:
>>> I think that patches 1 and 2 need to go to net with a Fixes tag=2E
>>> They look like run of the mill bug fixes=2E 3 and 4 are logical
>>> fixes and change behavior so net-next makes sense=2E
>>>=20
>
>This is not addressing my concern=2E I am not complaining that it went in=
to a separate series=2E That makes sense=2E The v3 version of the patch "ne=
t: hsr: require valid EOT supervision TLV" is now something completely diff=
erent but the commit message is the same=2E
>
>v3: https://lore=2Ekernel=2Eorg/all/20260329112313=2E17164-4-luka=2Egejak=
@linux=2Edev/
>
>I could guess the reason is that in order to make sure the last TLV is a =
EOT TLV with 0 length but all that explanation is missing on the commit mes=
sage=2E
>
>>> FWIW AI has something to say about patch 3, I did not investigate:
>>> https://sashiko=2Edev/#/patchset/20260329112313=2E17164-2-luka=2Egejak=
@linux=2Edev
>>> --=20
>>> pw-bot: cr
>

Hi Fernando,
I apologize for the confusion=2E Now I get what you were talking about=2E
The commit message in v4 didn't reflect the logic change from v3=2E I=20
will update commit message accordingly=2E The motivation for the "TLV=20
walker" refactor in v4 was to fix two issues in v3: linearization/
paged frames and forward compatibility=2E
Best regards,
Luka Gejak

