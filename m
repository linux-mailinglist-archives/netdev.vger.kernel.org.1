Return-Path: <netdev+bounces-294551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2HHtF8O9H2oTpQAAu9opvQ
	(envelope-from <netdev+bounces-294551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8263451F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:38:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=pKT1gyCR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294551-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294551-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFA17302F011
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35256381B1D;
	Wed,  3 Jun 2026 05:36:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE01437DAC2
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 05:36:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464971; cv=none; b=gNh85u6mSiXw6TMKaYpjY9/uwm7sk7fORrSl/1/0CHq5cJ2hIhcJjAS+twqFfjyj+N1ccYLmTQbnFd479s3XmEFosYrtfC/7ENeK6cDO6wpEeo90BwSAe5xp+zRPODgYEqfOSLEKUL4WtmOwc1r2tKTRtTgOb31212+65c7bIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464971; c=relaxed/simple;
	bh=QZdWL8TW93hBVmRCbf+wTaax3/MrgBmqC4IKbOxsDW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h11m0Q4qZZckp2GoieXpAP6LU7cGkiCN3qEZGoqFHN+r7gtVnVfJ/8CveCMyiAdH0gE59w70aVT1n6w3z3WvhejN86gEJvs72P48Xb+ZbZck75bKMfd9QI7ZyigHnpxI/7EgZjDBiDj8hpvY92pbcHo0ZFjmI6RhR0x4dMgVYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKT1gyCR; arc=none smtp.client-ip=95.215.58.180
Message-ID: <752224bd-bada-4729-846a-c5684de38101@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780464954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7v3/xj0c3pZJZawiq+jPLnhvqm6ys3j0ue/XKbnFgQ=;
	b=pKT1gyCR+Ei4hlApb7vqQMC2wJtAwBBWeZ+eO+LXf/dK4zrC14XL0hmcapFQpyJsCc97hI
	9+g7Vkg6nFJfLDKTDvj4kDweb0q/0/TpZ/+3ri3hgGz8mGbgQnle8QRwO6XrfsQ4AB28fy
	eEgwzMEboRadZZTekCcd76QPabN/paQ=
Date: Wed, 3 Jun 2026 13:35:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] selftests: net: add socat syslog for PPPoL2TP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260529021146.5739-1-qingfang.deng@linux.dev>
 <f4a18ecf-4810-45a9-bf2a-1add45623248@kernel.org>
 <8233aae4-42d4-4fac-90aa-240fadd9a39b@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <8233aae4-42d4-4fac-90aa-240fadd9a39b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294551-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-ppp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BC8263451F

On 2026/6/3 12:04, Matthieu Baerts wrote:
> Hi Qingfang,
> It looks like the issue happened once since this patch is being tested:
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-extra/results/668501/11-pppol2tp-sh/stdout
>
> Is it enough for you to understand what's wrong and how to fix it?

Yes. Both pppd instances detected a false loopback, possibly because 
they happened to use the same PRNG seed to generate the magic number. 
I'll send a patch to disable this detection.

Regards,

Qingfang


