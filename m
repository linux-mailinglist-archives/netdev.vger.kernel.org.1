Return-Path: <netdev+bounces-284478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIxZBt0O+mlOIwMAu9opvQ
	(envelope-from <netdev+bounces-284478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4894D04FB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C894D300EF99
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3FD481246;
	Tue,  5 May 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="OA9pK6Jk"
X-Original-To: netdev@vger.kernel.org
Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D7156C6A;
	Tue,  5 May 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995463; cv=pass; b=J3WpHGF7qVOUx+t+SjpqktODphf7GhE6qlQnYs1QoPPzlbDDpa3L0AAPuB7//qfTj7otodJq3kDBn/up0v/IhiCs0NieMBDr7lkxO58SqDzuxtBSw5Lgq0n8ghScfI8qJ4q5tjOmc+OaJZxc0nQ1vns4bfFF+ktLck2JL9dOeWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995463; c=relaxed/simple;
	bh=lOZ1F/93U5BqwqZkHHcoFSMnxY/3NqwCM+tlOZ8UjQw=;
	h=Message-ID:MIME-Version:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=sI4o2iP5PmZeq3KfkM+V9iykzCvQYhiN9z207NTp7bL28nHORPKaZkkfIQczd2bgjR3476fsoFkRw39AXFKsAGMYihj2bJMhljeuum2hLmm/GL9Bl3CoLkmGH9kJg/Xu3b9FbGAFENZxjVLvgiaWjZL8pZWuX3TNyhSTJZGiDLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=OA9pK6Jk; arc=pass smtp.client-ip=23.83.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7CDFB802AFE;
	Tue, 05 May 2026 15:37:35 +0000 (UTC)
Received: from de-fra-smtpout10.hostinger.io (100-97-142-130.trex-nlb.outbound.svc.cluster.local [100.97.142.130])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 33CBC802AD9;
	Tue, 05 May 2026 15:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777995455;
	b=xCnlpjAaETZZ8nB6SHCx3uKHKF8gy+I0b8kIjK1SV84Nm7mr8kN3yQ/Bmv3zfScALbXL32
	D5utVoQithYoiwZafCH//fStWO43iF8/Ra80x591Umb+NdUYSmvvRQwyWDrhKeANzNBxKR
	ScKKAlKyDPFBvMA6zg66D2HC3zgzG1+DmhlSr/FRWDI/47Ij8rimVot3QP6jh4UvFs0dqW
	fsc6mGtJ25RuYhpMpacUA5LLAbuL3Ym2iHKpeWOqD+lV6oDVB7QWhBtCCaja3d/vLT65tG
	/RIexo9YoI5clp/Hdx3gbfabxD16WwoSQlhn4hupuTnGVEA8GIMHybE+faZeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777995455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qVt3lmzQ7N6PZH719ot9HwSZfxNbFLse3Q7BGP9gLo0=;
	b=gkdE1mw+RZR9o4dfnfLlPxauQN3/RDP4M2R0bemfmlpvKtMDXJX9EO4BgFUzp6XYHuCHr5
	fphQ4lzkndpIP9nC8oJ9ja9MEtglZgDclAhs3Ow3AsnARgJR0baSQX52sJLBbQ7oydtggJ
	7WvXdIRvmmO8KOsC2sYqajMmYvwhmlro2sD1s38RWLqRaEX4ifNJn6wAx5xUL/kUzLMFI8
	jXf/ZjZsXGqPqbmzSr9FqyHloDIG5aO0MGyp56rxWb601WtxwiAfC6CIFka5J58dbztCF3
	Do3fRdTtAFhEUohsSrvrGgZJ+Mrp1/JgGYedIyubmt0PXFrYMR04mpqmWem+Rg==
ARC-Authentication-Results: i=1;
	rspamd-859c89884f-8lmrr;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Juvenile-Stretch: 5e85dd1b5d2d99ef_1777995455411_2547369502
X-MC-Loop-Signature: 1777995455411:900885652
X-MC-Ingress-Time: 1777995455411
Received: from de-fra-smtpout10.hostinger.io (de-fra-smtpout10.hostinger.io
 [148.222.55.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.142.130 (trex/7.1.5);
	Tue, 05 May 2026 15:37:35 +0000
Received: from [10.10.10.3] (unknown [109.228.203.208])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4g92h93Jbrz405w;
	Tue,  5 May 2026 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1777995450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVt3lmzQ7N6PZH719ot9HwSZfxNbFLse3Q7BGP9gLo0=;
	b=OA9pK6JkqwuJkBC+Lq+VgLCL3oEA3PmUnLE0lzbyZ1xTPUXiGdZjaaZU0J/ENZ4Uqowz21
	9XL/4EcTiKKIO2L33pdCYLntrKcExyiqBl++T7gG39FOqJ8lH5QOQatAQyFmdXE40WCDm7
	w7l7Y5QpsdDGEj8Vukspph9Ry+AOzzjPJzNEP3A58CHNWYE2vCxsSGtOQrIc9vZrKvFaYf
	mHW3Yb5h5q/y/vW6cXLmeRN2BLytuFanPMFhsJs/TZbVMSWw4B1A40FmFiQ1p6tkyo4alT
	LhIJuERJceb7zLJMsOh0lAMR5FKCQZALMmH3UQ9eybEzMqT7jc0W2XGHXQWmbA==
Message-ID: <46071c08-d85f-4157-9d61-6a0feef56747@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] net: dsa: mt7530: preserve VLAN tags on trapped
 link-local frames
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
Content-Language: en-GB
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <3ad4b724d7ae6250b8429d50fe913d2dca07a3f9.1777986341.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue,  5 May 2026 15:37:29 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Ceda56rl c=1 sm=1 tr=0 ts=69fa0eba a=CS7yVHPVoEopjVSexcYCQA==:117 a=CS7yVHPVoEopjVSexcYCQA==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=b-zwJ4yWfF2n_vrUc9gA:9 a=QEXdDO2ut3YA:10 a=6CpsfURP9XNmmWg3j1mJ:22
X-CM-Envelope: MS4xfKevdoLEsxmpx10pKfk+csh2waOq6MgMEWDN9OPOgqtKBQ6a+CfiVfyz0RAK+HWO2338y9SoLUXXzQmIZHlwm/h4SaeL6E6NGBhsz1bCYQhQipE6Ja3v QKIYit66gJaTE43yJrGJ81W53ozrNCPScbIhy30OVoH0M1tF4AMBCk/9KaMHXFaZXm/7ti0DKX2CBaTAmSqr5+j0dAXVNLP/8NR+J1sZKqYzia636LPlp2om 8xd2nSTWGAm3UBp4QDfXne7l+hDgqnaybhYar5ubdrztmXc2z5neorRu5OqUMsq8CjM3BWoiVIoAN7NdLY+KpKdD9f8tXpVSw/j8QghojOW9zDBR0In4HPPK RdrNEeGfTLOBEra8wZUvKeqHG8aawJ0NToAzksH3WJjLf0FBDgLGUSVq/OgssgwZ266jM9wgJyOJZHmABwzfd9N94MhMgECu2f6AoWI/XcMX6SOvmUXJzF1k fzYzDiVSXBiiIsEhY8a+7NIaZ+k0u5daHZ+zHi22w8RTR/FDy1T9LkNSvpu5mkB114IpbpR+PRXM+Y/7AHUGi+clPfAtz3JP8C9IadOeJ+CqJn6k0TD6v9+K ddBDsnci/bQ27jdT1+h3Lu6laUyjTWNSNwKNa2KEmXZna7YiEzzUrxHD9W5BnpV+efNBh1w4b1ZZNjVWyWmsQhgMaagfD4NKXvWnuWjzMfQIur6kRLBlxFNF 30atd3eNxtKdbCz5RwNU6BwidLZoO03Pi8KYIwgLr44V3mKSjBg//A==
X-AuthUser: chester.a.unal@arinc9.com
X-Rspamd-Queue-Id: 8E4894D04FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arinc9.com,none];
	R_DKIM_ALLOW(-0.20)[arinc9.com:s=hostingermail-a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284478-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,arinc9.com:dkim,arinc9.com:mid];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,arinc9.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arinc9.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

Hey Daniel.

On 05/05/2026 15:16, Daniel Golle wrote:
> The BPC, RGAC1 and RGAC2 registers control the handling of link-local
> frames with reserved MAC DAs (01:80:C2:00:00:0x). These frames are
> correctly trapped to the CPU port, but the egress VLAN tag attribute was
> set to MT7530_VLAN_EG_UNTAGGED which causes the switch to strip any
> VLAN tags from trapped frames before they reach the CPU.
> 
> This causes VLAN-tagged link-local frames (STP BPDUs, LLDP, PTP Peer
> Delay Requests) to arrive at the CPU without their VLAN tag, so they
> are delivered to the base network interface instead of the VLAN
> sub-interface. The DSA local_termination selftest confirms this: all
> link-local protocol tests on VLAN upper interfaces fail.
> 
> Set the EG_TAG attribute to MT7530_VLAN_EG_DISABLED (system default)
> so that the switch does not modify VLAN tags in trapped frames. This
> way VLAN-tagged frames retain their original tag and are delivered to
> the correct VLAN sub-interface, matching the behavior of non-trapped
> frames which pass through without VLAN tag modification.
> 
> Fixes: 69ddba9d170b ("net: dsa: mt7530: fix handling of all link-local frames")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Thank you for this patch. Could you please confirm that it conforms to the
findings documented on this patch log?

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=e8bf353577f382c7066c661fed41b2adc0fc7c40

Cheers.
Chester A.

