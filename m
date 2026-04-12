Return-Path: <netdev+bounces-277890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAVJI/v822kYKgkAu9opvQ
	(envelope-from <netdev+bounces-277890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:13:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F9F3E5D50
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6CAB300A7E7
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359337DEB2;
	Sun, 12 Apr 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdBKKcS5"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B371A3164
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024824; cv=none; b=rgsym+CmYKBEaODHfhz9ndcpnTHPWzPXNn24ddFQekOKgD0bppGvwjEvr6fkJ47WdVoCwm0JIQc58BRZP3joaBQq1C9BJoz+f7ZgCikzV/P6KoS7aGPeJABcmI6G4DL/JABcLd0FWz3zfp/Y6m8jNyvNuGdy2bPEIP4Qpbv7xhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024824; c=relaxed/simple;
	bh=2GOQ+7g+C4WqmPLOJXz+vmFiiyFGGybuosx9t3X2JnE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qKiHArqa03E+OlYmwN7fhC9bao3JD4yaTPCWWUiaTri4PQEAzd4XI2DhfbSWGihSWdFh61ecRFpYfj1fqVzr/t0wz6eAhyB97bDXz2EnVr1DFC4ywtr41DmvtZGPgukMHfcvFWaVLDqvMT3LOqdMnOhRm/Tynrh479T4H07lt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdBKKcS5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 12 Apr 2026 22:13:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776024821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+GKgvetarubZ7eT2ndempdze700136pee4ifTTVdr4=;
	b=WdBKKcS5UaYk96Bghe0okQ2joXXGKdoU45VNaLquoFmPVx9b/cv1KuyKiLyo54pjHe4UFl
	PAZnoJ9SIvtzoeWCNhIGWmiMOY2p+WhAU7QWYx9dPwCIOvy8EgsgPVckHnTfP+Ey8Tnvv7
	C7iRsLlKLkXgdKbxZZKfv9zZpCOHNYY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
CC: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org,
 luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v5_1/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_require_valid_EOT_supervision_TLV?=
In-Reply-To: <20260412124558.190c725f@kernel.org>
References: <20260407162502.19462-1-luka.gejak@linux.dev> <20260407162502.19462-2-luka.gejak@linux.dev> <20260412124558.190c725f@kernel.org>
Message-ID: <DDF9CC02-6FC1-44F0-B95D-967151BF0592@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-277890-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05F9F3E5D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 12, 2026 9:45:58 PM GMT+02:00, Jakub Kicinski <kuba@kernel=2Eorg> =
wrote:
>On Tue,  7 Apr 2026 18:25:01 +0200 luka=2Egejak@linux=2Edev wrote:
>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>=20
>> Supervision frames are only valid if terminated with a zero-length EOT
>> TLV=2E The current check fails to reject non-EOT entries as the termina=
l
>> TLV, potentially allowing malformed supervision traffic=2E
>>=20
>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>> with a length of zero, and properly linearizing the TLV header before
>> access=2E
>
>> diff --git a/net/hsr/hsr_forward=2Ec b/net/hsr/hsr_forward=2Ec
>> index 0aca859c88cb=2E=2Eeb89cc44eac0 100644
>> --- a/net/hsr/hsr_forward=2Ec
>> +++ b/net/hsr/hsr_forward=2Ec
>> @@ -82,35 +82,33 @@ static bool is_supervision_frame(struct hsr_priv *h=
sr, struct sk_buff *skb)
>>  	    hsr_sup_tag->tlv=2EHSR_TLV_length !=3D sizeof(struct hsr_sup_payl=
oad))
>>  		return false;
>> =20
>> -	/* Get next tlv */
>> +	/* Get next TLV */
>
>The capitalization of the comments makes the real changes in this patch
>harder to spot and follow=2E Please don't tweak the comments unless you'r=
e
>really changing / improving them=2E
>
>>  	total_length +=3D hsr_sup_tag->tlv=2EHSR_TLV_length;
>> -	if (!pskb_may_pull(skb, total_length))
>> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>>  		return false;
>>  	skb_pull(skb, total_length);
>>  	hsr_sup_tlv =3D (struct hsr_sup_tlv *)skb->data;
>>  	skb_push(skb, total_length);
>> =20
>> -	/* if this is a redbox supervision frame we need to verify
>> -	 * that more data is available
>> -	 */
>> +	/* If this is a RedBox supervision frame, verify additional data */
>>  	if (hsr_sup_tlv->HSR_TLV_type =3D=3D PRP_TLV_REDBOX_MAC) {
>> -		/* tlv length must be a length of a mac address */
>> +		/* TLV length must be the size of a MAC address */
>>  		if (hsr_sup_tlv->HSR_TLV_length !=3D sizeof(struct hsr_sup_payload))
>>  			return false;
>> =20
>> -		/* make sure another tlv follows */
>> +		/* Make sure another TLV follows */
>>  		total_length +=3D sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_=
length;
>> -		if (!pskb_may_pull(skb, total_length))
>> +		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>>  			return false;
>> =20
>> -		/* get next tlv */
>> +		/* Get next TLV */
>>  		skb_pull(skb, total_length);
>>  		hsr_sup_tlv =3D (struct hsr_sup_tlv *)skb->data;
>>  		skb_push(skb, total_length);
>>  	}
>> =20
>> -	/* end of tlvs must follow at the end */
>> -	if (hsr_sup_tlv->HSR_TLV_type =3D=3D HSR_TLV_EOT &&
>> +	/* Supervision frame must end with EOT TLV */
>> +	if (hsr_sup_tlv->HSR_TLV_type !=3D HSR_TLV_EOT ||
>>  	    hsr_sup_tlv->HSR_TLV_length !=3D 0)
>>  		return false;
>
>Aren't there more optional TLVs that we don't support?
>You mentioned making sure that the final TLV is a zero-length EOT
>but this check is far stricter=2E
>
>Should we replace this check with a loop which skips over TLVs
>until EOT is reached?

Hi Jakub,
Thank you for the feedback=2E
I apologize for the noise in the comments=2E I will revert all cosmetic=20
capitalization changes in v6 to keep the diff focused on the logic=2E
Regarding the TLV loop: I actually implemented a TLV walker in v4 [1]=20
for this exact reason, but I moved to strict sequential parsing in v5=20
based on reviewer's feedback to keep the implementation simple=2E Could=20
you please check if the approach used in v4 is what you had in mind?=20
If so, I will rebase that logic onto the memory safety fixes=20
(pskb_may_pull) from v5 and submit it as v6=2E

[1] https://lore=2Ekernel=2Eorg/netdev/20260401092324=2E52266-2-luka=2Egej=
ak@linux=2Edev/

Best regards,
Luka Gejak

