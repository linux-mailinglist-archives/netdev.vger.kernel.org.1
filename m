Return-Path: <netdev+bounces-284505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMjwCqEY+mlYJQMAu9opvQ
	(envelope-from <netdev+bounces-284505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 950784D1204
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94E6C30B8C6C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1848BD5F;
	Tue,  5 May 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="cqqREIpx"
X-Original-To: netdev@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083748BD42;
	Tue,  5 May 2026 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997534; cv=pass; b=KCNyh0vkohzj+i+OaOM7fGBQNNklMpFuSyEFFI5BX/NvYTDZbqL39rwJABDB4sMm9+RAPuminRVKqitDtTTwaGmCQedTftDh9ZEfueA8nvqcPdyTkkVg2bTSv34Lgt9EkNvrzxoK8yZi1ZlWKPu2ksJ2iqfDDkDpilOh1VSOK5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997534; c=relaxed/simple;
	bh=mpORlpM+43YzFj860mG/06ZvLVUW1QVN7iDDOBE1+a8=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=pkW4sHehpeL6PlLqh+DhWbGETwx/WOU4iw+f5/Ct/w5jdkw/9oIco7Kd7qIoB3SOB6QmuywjKIztSQLr1nPUDfFXdA4fAmAKYFZdhk7pEkv/YyRVsjehwtI7rDYV0m/p54Q7kPOviY77lgbuX5Zs3tdizms6Y3ZWub+RqCuegI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=cqqREIpx; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C3B1040042C;
	Tue, 05 May 2026 16:12:06 +0000 (UTC)
Received: from de-fra-smtpout10.hostinger.io (100-96-24-249.trex-nlb.outbound.svc.cluster.local [100.96.24.249])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id A21E5400DF3;
	Tue, 05 May 2026 16:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777997526;
	b=VTr7TGlcrQQJh7V1+2z9UiyLQCPDe+uOGK6XwFmgvxkfhFDcyvBrhsrD2mO3MzEwaTkaun
	dmBnUplnUTXN0C/8pzq0vzi2emcNBOa5DDhmPphKs/Zu9RqFjWZTL3Sj9CH9WZFQXcNnC1
	J//TfucxzzQWTu+sZLFwuzdOChJeyS4DOvVR6TlWF9g60cnVs38XyABeeTGcEUU2YGxAiJ
	7wNtgzaTvbZPeyFTF3cPDA3t9FCF/X9lF2QhIG9D1Vpma723vZfnhIEEvaFjtYtNDwo6kY
	eRBw8dntV90793Xt4Ki306ZGThI9zdKVe4e/u8cm8Jwxbpr6XboIve21J3tqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777997526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O4UXY/O1n8garPzUK7BlpEllKN6HEI5/pvuk32gImq0=;
	b=6FRuuJqN8ZBX8prOKt/kIalj2pN3qf4Nb5OwTUAZtesJqSJ3gP3xmyozJ8/+BS5X/NOlsA
	0qAYF2xX0TV09czB23KAUh63IkCB/LNrAsE62LPeX95woHN63FPMPJwEZbfDvFlBQlSA8S
	bRbQL+5tIcIXxF7F3Id08geEmL2KfpYgzrlYm1Ij1eICKUhbziNRlO2kRJabaSnoLJiaIq
	KX5htLX78trx212oOLPq6aZRulDHfKkqAqFnu131HF+Fa3MUsFqpX3Zfu4yERszO5Yj4X7
	2PIzGHSSVefTLNwWfN7ZmTi3VLfg+FhEoJnj9+yqEI2YbDMAgtCPvd0c6V3Dyg==
ARC-Authentication-Results: i=1;
	rspamd-7766795c76-g2nwv;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Stretch-Celery: 71ee9a8704ca7cd7_1777997526695_4240053568
X-MC-Loop-Signature: 1777997526695:4274407990
X-MC-Ingress-Time: 1777997526694
Received: from de-fra-smtpout10.hostinger.io (de-fra-smtpout10.hostinger.io
 [148.222.55.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.24.249 (trex/7.1.5);
	Tue, 05 May 2026 16:12:06 +0000
Received: from [10.10.10.3] (unknown [109.228.203.208])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4g93S01kzqz406B;
	Tue,  5 May 2026 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1777997522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4UXY/O1n8garPzUK7BlpEllKN6HEI5/pvuk32gImq0=;
	b=cqqREIpxtI/aaybTpgT+MCzSKcM4Q4HuWLNLVJY9whqtks0uzjeSBh5pz24N8kwxqSkhDr
	XjmlWKxOERed0sHJvxodML2FPP3gxdHWcP5JUhcbOHIcE8RWx2WAu3ERDRjvDareEL9CUY
	kZUPN3Cgw0j7Z01wCB8qrXE1S+CaQ5vtb5szY5jGrw8nz4cB1ilrBGH2gxX5i3mpYP2TZt
	DmSgC4f9yhXn0XS1nuaYIz8ZIm1gaJlOFj0hSsfajkieAWRA/6YZYA0xO2kzpuqbPLvl7g
	nyGziJpqIg+T0OfjmXZB5t6REwZEu+b640GPOq53g0TGhBJNPodj22KISNmTaQ==
Message-ID: <1a62de44-7fbb-46b3-8d6c-66dac7ef9c94@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] net: dsa: mt7530: preserve VLAN tags on trapped
 link-local frames
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 DENG Qingfang <dqfext@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1777986341.git.daniel@makrotopia.org>
 <3ad4b724d7ae6250b8429d50fe913d2dca07a3f9.1777986341.git.daniel@makrotopia.org>
 <46071c08-d85f-4157-9d61-6a0feef56747@arinc9.com>
 <afoUt46gGwAC33ZU@makrotopia.org>
Content-Language: en-GB
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <afoUt46gGwAC33ZU@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue,  5 May 2026 16:12:00 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Ceda56rl c=1 sm=1 tr=0 ts=69fa16d2 a=CS7yVHPVoEopjVSexcYCQA==:117 a=CS7yVHPVoEopjVSexcYCQA==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=GvHEsTVZAAAA:8 a=E8QqtcFgGylCMEfhWDkA:9 a=QEXdDO2ut3YA:10 a=6CpsfURP9XNmmWg3j1mJ:22 a=aajZ2D0djhd3YR65f-bR:22
X-CM-Envelope: MS4xfJcwCJVpL1ZtOgXAwEetgW+YoNBvGUQPfmTxMKooQpgL08qLBmkPPJT9r7YgekgaKNRoJ/wjtuoqxgnatbFlj/11pJPx8GLKuo+MZmXFw/WCY3T45xBP 5WbYH8ePugTJ0kc8bjAbKWKDIzwU2N3qszk0q5AQ9qRnwlR5wRD+s3LeeZ54ghfygM+Vol+AExOaR8HPsIPw/RalpnzgD8XdcwJcTuGCkrXZtvY3R1dAD0UH CJuH/J0d+7c4Nns/xevN6Gt8HPUbqm6Dh+BlRo4bOv8ZZh37z1qcAKLFcqlOba0/Nj1TSL40RXk7hMjTFeMedEggEu2a255jm60L/0VYdOG8G2PmUm1OZ7kD OiEYi9gVjup8hJ2G7orHrds12F3ntgZpfm915uBvg9b+hO7IhDEZlebtR88TfAbi4Au0kHv0UVbJq/YW5BVGIrUTItdB3klrFuK4rtN+SShMQdQfW5EyICQX FHgFR8uW6s1z0d7RgSS5IqNfQT2K0AXDFkE4uaa/0uv5k97Ez4zOGM+aR04M3FR7a/WGAzYN7bPPoZiy8sebYM0D8HU/wtdXwXEAICch3fmxi+vmoK5rSTzD Rmj9NhD9cqIH3grnaBt4gu61sI5xcnQDdBp5vr4j8ltfWCGBPnMmdcy6wMFX3JtrzAWidLOeiK88bJpakJAw7+cQDP9wMKfmdoUcBHCOLJM5msp17puLno6x Af9zAoY6PYFSfVxUBNEW80D5OTn395RI2HOFmhPgbNLN6vRV2HvPUg==
X-AuthUser: chester.a.unal@arinc9.com
X-Rspamd-Queue-Id: 950784D1204
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arinc9.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arinc9.com:s=hostingermail-a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,arinc9.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-284505-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bridge_vlan_unaware.sh:url,local_termination.sh:url,makrotopia.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arinc9.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chester.a.unal@arinc9.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 05/05/2026 17:03, Daniel Golle wrote:
> On Tue, May 05, 2026 at 03:37:29PM +0000, Chester A. Unal wrote:
>> Hey Daniel.
>>
>> On 05/05/2026 15:16, Daniel Golle wrote:
>>> The BPC, RGAC1 and RGAC2 registers control the handling of link-local
>>> frames with reserved MAC DAs (01:80:C2:00:00:0x). These frames are
>>> correctly trapped to the CPU port, but the egress VLAN tag attribute was
>>> set to MT7530_VLAN_EG_UNTAGGED which causes the switch to strip any
>>> VLAN tags from trapped frames before they reach the CPU.
>>>
>>> This causes VLAN-tagged link-local frames (STP BPDUs, LLDP, PTP Peer
>>> Delay Requests) to arrive at the CPU without their VLAN tag, so they
>>> are delivered to the base network interface instead of the VLAN
>>> sub-interface. The DSA local_termination selftest confirms this: all
>>> link-local protocol tests on VLAN upper interfaces fail.
>>>
>>> Set the EG_TAG attribute to MT7530_VLAN_EG_DISABLED (system default)
>>> so that the switch does not modify VLAN tags in trapped frames. This
>>> way VLAN-tagged frames retain their original tag and are delivered to
>>> the correct VLAN sub-interface, matching the behavior of non-trapped
>>> frames which pass through without VLAN tag modification.
>>>
>>> Fixes: 69ddba9d170b ("net: dsa: mt7530: fix handling of all link-local frames")
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>
>> Thank you for this patch. Could you please confirm that it conforms to the
>> findings documented on this patch log?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=e8bf353577f382c7066c661fed41b2adc0fc7c40
> 
> Yes. Combining VLAN CTAG and DSA tag into single "mess" tag is what the
> MT7530 hardware does, and also what tag_mtk.c expects, and mtk_eth_soc
> "special tag" feature handles well.
> 
> I've found, addressed and verified all the issues in the series using
> the DSA selftests in tools/testing/selftest/drivers/net/dsa, ie. running
> bridge_vlan_aware.sh, bridge_vlan_unaware.sh and local_termination.sh
> in a loop, and random order, on BPi-R3 (MT7531) and BPi-R4 (MT7988).
> 
> With the series applied many of the previously failing tests are now
> passing.

Great to hear!

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

Chester A.

