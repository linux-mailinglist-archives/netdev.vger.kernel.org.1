Return-Path: <netdev+bounces-285366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JKXEF6o/Gn5SQAAu9opvQ
	(envelope-from <netdev+bounces-285366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:57:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB384EAAEB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB29A308A883
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB53EDAA0;
	Thu,  7 May 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="xXKDUTPl"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA03BD643;
	Thu,  7 May 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165570; cv=none; b=a59V8N7LZUYX9pAWziARNHP1lT1XLZEz7/wfTrFh1LF9nF60K+A1urChwo5zqJD5iijrcK7LfR6uhlzSFaqWPp7z9AFVZ4uES3mELdW1UneZWpH5Rk796Czt9AMen53C+gPk8uDMPe43LVeD+37lAfsb0bBbvt3TmHqV+OQ85zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165570; c=relaxed/simple;
	bh=FpYeOAyis8m6Y2Clv0tM7NciA1U9CPYpox8KmfiFYIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmGFHEQGZDGdaZy43vP7/MfOeUzVQoXjysY38gNnTJ6DG68ohLKWI0ltLklutrsCMb3gidm9ChIopGoO6bWGuqW7OMlCJckiNWVkRlW4y9AIXJlHwZNkMhHNyhGsBRSn59Waqv7azOOTk9uTAeQtdfsrugIpEGYElbLpi+Rj3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=xXKDUTPl; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778165561; x=1778770361; i=simon@schippers-hamm.de;
	bh=SCuXleXqrC6ZPqhNX1oQ525cQB6TaYVm/6eDNN0AOKE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=xXKDUTPlCmVLxFj77VKeKnWV0cEWpObauI28cfewl/N1mNCaWUXODqHy7VVdP8ze
	 gbKOa6i69e/ctAYMhZQO+5EfyE5tkJUr07vUZ2JU/qqrXMfLjQFtylwxQoCtfXQX7
	 rz1tOcEOKKbEYS1bbzQ1K5d3RCgsiYaN3kTKugdBvupmNsogihVWXOVCfguwfJ0Pq
	 qmjILW+qFXEFeIdv4vuLS7HrFLxLQmsLn85L0SvouFLzD+8IZi0C6KsOFWSOomuiS
	 iLETPG0uIK/jNGdT5LjZtBaOfXf+dG4mHmySjBoSGpI0gn748jzYJ2ExOp5uQjYt4
	 zu9728NOlFW9pbmSEg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1MDQRy-1wBc503KOU-00Fay7; Thu, 07
 May 2026 16:46:40 +0200
Message-ID: <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
Date: Thu, 7 May 2026 16:46:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Paolo Abeni <pabeni@redhat.com>, hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sNPBPySUhNmmnBE6atM+k+bbsLAB6+xRJMmtae7kiZ0Cntv9b8j
 IbGCzldlSRJ/+O2RdBvTsuM9cCjiZGFP4i3oXIssD6eVHIJRIGZ/qBYip82yK2MbXnw6uYf
 VjOz84ku0JPpbKDdaA8LbSN20DzvL4TU5FhGlA3JFUZ1CY5Q2G79QE98o5yxRgbbDyg7Haj
 3R3ef0pT+EdEB5F/UXlZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GKx629lf1hA=;6wDalD/MxFjWiE/j36A6Pubvo16
 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
 nlDRg9ZEEbi8YF2Ihq2kemZV+CnXQSoC
X-Rspamd-Queue-Id: CCB384EAAEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285366-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon@schippers-hamm.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schippers-hamm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/7/26 16:34, Paolo Abeni wrote:
> On 5/7/26 8:54 AM, Simon Schippers wrote:
>> On 5/5/26 15:21, hawk@kernel.org wrote:
>>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int b=
udget,
>>>  			}
>>>  		} else {
>>>  			/* ndo_start_xmit */
>>> -			struct sk_buff *skb =3D ptr;
>>> +			bool bql_charged =3D veth_ptr_is_bql(ptr);
>>> +			struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
>>> =20
>>>  			stats->xdp_bytes +=3D skb->len;
>>> +			if (peer_txq && bql_charged)
>>> +				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
>>
>> In the discussion with Jonas [1], I left a comment explaining why I thi=
nk
>> this doesn=E2=80=99t work.
>>
>> I still think first that adding an option to modify the hard-coded
>> VETH_RING_SIZE is the way to go.
>>
>> Thanks!
>>
>> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b6=
2920df@tu-dortmund.de/
> In the above discussion a 20% regression is reported, which IMHO can't
> be ignored. Still the tput figures in the data are extremely low,
> something is possibly off?!? I would expect a few Mpps with pktgen on
> top of veth, while the reported data is ~20-30Kpps.
>=20
> /P
>=20

The ~20-30Kpps occur when thousands of iptables rules are applied and
an UDP userspace application is sending.

And there is a 20% pktgen regression (no iptables rules applied).

I am pretty sure the reason is because the BQL limit is stuck at 2
packets (because the completed queue is always called with 1 packet
and not in a interrupt/timer with multiple packets...).


