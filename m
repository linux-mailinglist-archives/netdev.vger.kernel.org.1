Return-Path: <netdev+bounces-260607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEhFB9bgnWnpSQQAu9opvQ
	(envelope-from <netdev+bounces-260607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:33:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CC18A914
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B97BB306410C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7C3A9D8C;
	Tue, 24 Feb 2026 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="PP4smpnZ";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RCEn1jB7"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576993A9627;
	Tue, 24 Feb 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954384; cv=none; b=MDgKu+tMlJDX8sBmntWo5it8CyReHTFPzKRlUToZMqNuWFuAhBeqX3+pzy6WgMx36Xs+uFgxIpgGFQMshm07ZGXTO4vaY660f3xJJEm/nPfjGKVPFFqmHSaok7V7D8h4+CxFnqOs8sS4vdZPKg7jCD8sP/C51qc+YfxcOsM++Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954384; c=relaxed/simple;
	bh=SlyAmiLYNVOdbRvL1dnKOb9oLm9AHpOb9WRvlUv8Mhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5BheWduX4sUYsjpFwJA2qbz9pbJbDiksHxwFUzgt0QgiqEkc8ttep7ld50PflJCEkIQLZPYElwA2IKbHki+b8o4a5t8ZKL4Hq6o+Bp9OodrOuGV55sbOxuyaLXxl1VJvqXw0zAWmwC7wuDUCArnJ6sCHbS+ogN2ERlnxRRmGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=PP4smpnZ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RCEn1jB7; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771954379;
	bh=SlyAmiLYNVOdbRvL1dnKOb9oLm9AHpOb9WRvlUv8Mhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PP4smpnZbOVhL66wZNf/q2vL5peac6l18u1aUrSCNoY9Pibcg2eW/yaIdHsqaZFih
	 JM2HXceJdNtjBCZsSVkIOpKf7aysi9gNo9peSrw0hW6shU4MgKxpnNFfv/9J0TfdGj
	 BbquhXnc9IHx5QS5iij8qt84Nka5Y3B0eXh5Y+Yxir0gMbXkANDsB0kZtgpFylRSZ3
	 Qy0pVTTRy5Dw1YE7U7lSv3YRh0gX5+ycOfPaBrlr1wQ8IbvL51+QfD2OO8NpgS8m0n
	 6PipoK4QM6a9NoVqrYL0wQ/Sm/4CpaWpz4W1vhNVf13KyBQAO/Iwplsk3RhCumoVXp
	 MkDqiuxTmNc+A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8A42E3F779; Tue, 24 Feb 2026 17:32:59 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771954377;
	bh=SlyAmiLYNVOdbRvL1dnKOb9oLm9AHpOb9WRvlUv8Mhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RCEn1jB7cfHNeX7awvzGIY1iAWsX6q13340Z4mtwNSWYTS13vmJlqJy6fzMjNzpsU
	 pYJdDC3kFd8V43oXT2+mftao+xiqW+9fi34R+vrc2CpGzLdzCBQClyX0G7TVn+Zqgl
	 9DJMCb+G5H+e4f98NXNXDhO28GVElQBPJlvdCe1/QIboOlgrdGdj1A8p9GggaWvIFs
	 TlWfQRA0v26GKh98foGbpy5finaXzo1zSoOylbWBmRJWzDLQIRcjdr5/U1SsKR3mkY
	 Mo9BfjGoDuwjg2dAUNV9lBYS1ruRWOBuoNqY/kOu1VVNxnyDKpY4g8hvzHbjj8DUa8
	 MS8dRZWeXu9yQ==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 306B93F0B3;
	Tue, 24 Feb 2026 17:32:57 +0000 (UTC)
Message-ID: <557cb9f7-8caf-4aaa-ab9b-313d329fd216@birger-koblitz.de>
Date: Tue, 24 Feb 2026 18:32:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8152: Add 2500baseT EEE status/configuration
 support
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_van_Dorst?=
 <opensource@vdorst.com>
References: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>
 <aZz_0_Zt67XsOyTM@makrotopia.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <aZz_0_Zt67XsOyTM@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-260607-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:mid,birger-koblitz.de:dkim]
X-Rspamd-Queue-Id: 8D3CC18A914
X-Rspamd-Action: no action

Hi Daniel,

On 24/02/2026 2:33 am, Daniel Golle wrote:
>>   	tp->eee_en = eee->eee_enabled;
>>   	tp->eee_adv = val;
>> -
>> +	if (tp->support_2500full) {
>> +		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
>> +		tp->eee_adv2 = val;
> 
> eee_adv2 set here is never actually written to the hardware.
> ie. you are never doing
> ocp_reg_write(tp, OCP_EEE_ADV2, tp->eee_adv2);
> for capable NICs.
thanks for the feedback! You are of course right, the writing part was 
forgotten when editing the patch. I will send a corrected v2.

Birger

