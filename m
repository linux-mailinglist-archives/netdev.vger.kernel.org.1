Return-Path: <netdev+bounces-301525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q6kpM6Q5O2rrTQgAu9opvQ
	(envelope-from <netdev+bounces-301525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02D6BAD99
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=fgadyb3edffxfnzbdpg4if4jyy.protonmail header.b=GcBxWjgR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301525-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301525-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A55A3022940
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A027587D;
	Wed, 24 Jun 2026 01:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42623E325;
	Wed, 24 Jun 2026 01:57:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266273; cv=none; b=G1LFhmebGEy3efnwj8VYUaR5MCupj3RInyzZjuyuA1+4e2YMIr4DlVH8z9Cg/10HMGCG5XkVuhCmpvn/YgQOIzN+wu4IC5J7PPRXLwf8Bfr6O0nFoFrcxSjel/tiM/O14JKI0yzsH8R/ZFd0fEjpoJO+Y1UXVZCte0tDZB04KPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266273; c=relaxed/simple;
	bh=xF3sFcPi0EOxkKDjR9PcSPmEdFj8kGYq0amzycQg8rk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf7GyBISszJvWnHFBz07+TWFGAmgQjGUJ3ZhhdNlpUWXo4KzuI3eudkGiAwuI11JKAl9Xgr0kKueVSmcj7uJ9/Uq9uaPO/MQEBBtS7Oxfro9XFFGsHJ5KQNz0at1YgT9ZigoEjqo5l3rJg5Mmuqec6x/N/B7Tyh/0TdyV6NNn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GcBxWjgR; arc=none smtp.client-ip=185.70.43.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fgadyb3edffxfnzbdpg4if4jyy.protonmail; t=1782266261; x=1782525461;
	bh=FMYU/AuXJxQ3vbFR2572qW7X6ukHUbrFodSqJLoxnxg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GcBxWjgRU9f7HNFgFeGY8Ep1nORqIQNwsFPCnRuGHzEPeqrGhhIMNRcfNFhjjJM4E
	 A1gVRBBSJG7g/4pZq4FlkQruvB1zZ3I6dBrVO4KwaLx46Q2/V/NCkPuRv6y53XAy12
	 cOXOgSYmW8+6h9EHS8TqWFDw1tVC9MadVdlzmtzkbgCvpCjv5LTwgP5KbCAkVNFebT
	 mZB2JKUW6zPXPWy/Ek74wJyhpnRB8NKHW5nPlnvTF0pPojTqqLUCjm0L0w4DTGM5zk
	 Voz7fMbZQaY1ayxwbM/1IiOQFjjGMRO0f4yKhz+CZEdZz7mvTZvfmDLAel2HQB5u0+
	 qNUniHoh3YnZg==
Date: Wed, 24 Jun 2026 01:57:33 +0000
To: Alex Elder <elder@riscstar.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] SM8450 IPA support
Message-ID: <48c624c3-5408-4862-b4ec-9321ad279bf9@proton.me>
In-Reply-To: <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me> <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 6d2e7d5a8228660f0c093f05f6ae7dd76fdff2b6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=fgadyb3edffxfnzbdpg4if4jyy.protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301525-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:elder@riscstar.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:elder@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[esteuwu@proton.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[esteuwu@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:dkim,proton.me:mid,proton.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B02D6BAD99

On 6/23/26 11:56 AM, Alex Elder wrote:
> I assume you have implemented this based on what you found in
> some downstream code.  And if so, could you please indicate
> where to find that (so I can do some cross-referencing myself).
> I no longer have access to any Qualcomm internal documentation.

Hello. Yes, that would be the case. What I used goes as follows.

1. My personal findings regarding IPA:
https://gist.github.com/esteuwu/bd49ed67ed9290f41612bdae1cacb5bc

Note that these may be subject to errors since I mostly cross-checked
values to get here.

2. SM8450 downstream device tree:
https://github.com/LineageOS/android_kernel_qcom_sm8450-devicetrees/blob/li=
neage-20/qcom/waipio.dtsi#L3304

3. SM8475 downstream device tree:
https://github.com/LineageOS/android_kernel_qcom_sm8450-devicetrees/blob/li=
neage-20/qcom/cape.dtsi#L2624

It's worth mentioning that between SM8450 and SM8475, IPA SRAM size is
different, so I used the smaller SRAM size to support SM8475 as well. Hence
the reason why I included SM8475's downstream device tree as well.

4. SM8450/SM8475 downstream IPA driver:
https://github.com/LineageOS/android_kernel_qcom_sm8450-modules/tree/lineag=
e-20/qcom/opensource/dataipa

Most of my cross-checking came from the source code in this folder.

Finally, for some values such as qmap, aggregation, tre_count and
event_count, I had to cross-check on the same folder that all
ipa_data-vX.Y.c files reside, since I couldn't find any reference to these
values in downstream code.

Regards,
Esteban


