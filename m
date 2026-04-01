Return-Path: <netdev+bounces-274198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCX+C51SzWmnbwYAu9opvQ
	(envelope-from <netdev+bounces-274198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:15:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6819C37E7DC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D601306B9F4
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1647CC9B;
	Wed,  1 Apr 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rC7fNxoD"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750543DCDA2
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062793; cv=none; b=n9NPGCePmPrBq6seMS0z83vAajqp1bAe+WHP5R1NtepluAWKnpKJwu7tkfaC8y9IQugQS5JD9t2fY27N00Lnd+9dOPTghbmghjjQ5h6YJLwlsiwpyDHl3oee6i6tzggxCHsorbG+/DclllIyieFSQpdxLW1WbNY2I0KHS81ZGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062793; c=relaxed/simple;
	bh=kJjatoj12q1IVFN7ceHnVQp6+VKfe2YdEN9hKvtcchQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sD1pe4oS2Brby9kalFyggLP5icpoR0fx0+t99zKz9Fw9ATaVvm28MmAew75pWL1+M2LB6wr1BwAPMoINcy6eI4UN5PNnJ0Ho2nqLoGDEdv8tntVflogs2mOmLCW+rNWPLhIsHbp6unzzdLiZFhLpxy4fPOQ7KHIjMIml7u32s4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rC7fNxoD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775062788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpiUdagjamy+bZwyP2hl/BIuvfqngZCXPP6zxd4vuSE=;
	b=rC7fNxoDQSUfZxMXYaIV4WUpwL6FDs2YYR5tH6ZkyWvnqFqzYBLAK6zMNgeokKBQT1QFUh
	9yleGRp4Kni9JuAJzwI6UUZmVDdIQYvFrdaaT2LPdxXG9xxJPt3UB319vj/QxTyAMH/+M/
	nyzycow4vxNCpA3zsbXD0WPcXL83SnQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 18:59:44 +0200
Message-Id: <DHHZ8POWJINS.1CRKQT33EM1WW@linux.dev>
Cc: <netdev@vger.kernel.org>, <fmaurer@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, <luka.gejak@linux.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <2d94a1a6-e6c5-427c-b10f-63377cb10407@suse.de>
In-Reply-To: <2d94a1a6-e6c5-427c-b10f-63377cb10407@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6819C37E7DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 1, 2026 at 4:47 PM CEST, Fernando Fernandez Mancera wrote:
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
>>   net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
>>   1 file changed, 22 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
>> index 0aca859c88cb..17b705235c4a 100644
>> --- a/net/hsr/hsr_forward.c
>> +++ b/net/hsr/hsr_forward.c
>> @@ -82,39 +82,42 @@ static bool is_supervision_frame(struct hsr_priv *hs=
r, struct sk_buff *skb)
>>   	    hsr_sup_tag->tlv.HSR_TLV_length !=3D sizeof(struct hsr_sup_payloa=
d))
>>   		return false;
>>  =20
>> -	/* Get next tlv */
>> +	/* Advance past the first TLV payload to reach next TLV header */
>>   	total_length +=3D hsr_sup_tag->tlv.HSR_TLV_length;
>> -	if (!pskb_may_pull(skb, total_length))
>> +	/* Linearize next TLV header before access */
>> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>>   		return false;
>>   	skb_pull(skb, total_length);
>>   	hsr_sup_tlv =3D (struct hsr_sup_tlv *)skb->data;
>>   	skb_push(skb, total_length);
>>  =20
>> -	/* if this is a redbox supervision frame we need to verify
>> -	 * that more data is available
>> +	/* Walk through TLVs to find end-of-TLV marker, skipping any unknown
>> +	 * extension TLVs to maintain forward compatibility.
>>   	 */
>> -	if (hsr_sup_tlv->HSR_TLV_type =3D=3D PRP_TLV_REDBOX_MAC) {
>> -		/* tlv length must be a length of a mac address */
>> -		if (hsr_sup_tlv->HSR_TLV_length !=3D sizeof(struct hsr_sup_payload))
>> -			return false;
>> +	for (;;) {
>> +		if (hsr_sup_tlv->HSR_TLV_type =3D=3D HSR_TLV_EOT &&
>> +		    hsr_sup_tlv->HSR_TLV_length =3D=3D 0)
>> +			return true;
>>  =20
>
> I do not follow this approach, why a loop? From IEC 62439-3, I do not=20
> understand that supervision frames could have multiple=20
> PRP_TLV_REDBOX_MAC TLVs. The current code handles the TLVs correctly.
>
> Which makes me wonder, how are you testing this? Do you have some=20
> hardware with HSR/PRP support that is sending these frames? If so, which=
=20
> one? Are you testing this using a HSR/PRP environment with purely Linux=
=20
> devices?
>
> Thanks,
> Fernando.
>
>> -		/* make sure another tlv follows */
>> -		total_length +=3D sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_l=
ength;
>> -		if (!pskb_may_pull(skb, total_length))
>> +		/* Validate known TLV types */
>> +		if (hsr_sup_tlv->HSR_TLV_type =3D=3D PRP_TLV_REDBOX_MAC) {
>> +			if (hsr_sup_tlv->HSR_TLV_length !=3D
>> +			    sizeof(struct hsr_sup_payload))
>> +				return false;
>> +		}
>> +
>> +		/* Advance past current TLV: header + payload */
>> +		total_length +=3D sizeof(struct hsr_sup_tlv) +
>> +				hsr_sup_tlv->HSR_TLV_length;
>> +		/* Linearize next TLV header before access */
>> +		if (!pskb_may_pull(skb,
>> +				   total_length + sizeof(struct hsr_sup_tlv)))
>>   			return false;
>>  =20
>> -		/* get next tlv */
>>   		skb_pull(skb, total_length);
>>   		hsr_sup_tlv =3D (struct hsr_sup_tlv *)skb->data;
>>   		skb_push(skb, total_length);
>>   	}

Hi Fernando,

You are right that IEC 62439-3 does not specify multiple=20
PRP_TLV_REDBOX_MAC TLVs. My intention with the loop was not to handle=20
multiple RedBox MACs, but rather to make the parser robust against=20
unknown TLV types. If a future revision of the standard or a vendor=20
extension introduces a new TLV, the loop allows the kernel to safely=20
skip over unrecognized TLVs by reading their length, ensuring it can=20
still validate the HSR_TLV_EOT marker at the end.

However, if the preference for the HSR subsystem is strict adherence to=20
only currently defined TLVs over forward compatibility, I completely=20
understand.

Furthermore, I am testing this using a purely Linux environment by=20
using a virtual HSR environment on Arch Linux. I set up two network=20
namespaces connected via veth pairs and instantiated HSR interfaces.

The nodes successfully synchronized and maintained the connection. I=20
confirmed this by observing the expected duplicate packets (DUP!)=20
during ping tests between namespaces and by verifying that supervision=20
frames were correctly parsed, allowing the nodes to populate their=20
remote node tables.

Let me know if you'd prefer I drop the loop for v5.
Best regards,
Luka Gejak

