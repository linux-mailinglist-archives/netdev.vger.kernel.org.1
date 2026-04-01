Return-Path: <netdev+bounces-273909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ETNLAnCzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF0375795
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C24301110B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5908346777;
	Wed,  1 Apr 2026 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Bwk+cLZ1";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NbLcjFRh"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400031064B;
	Wed,  1 Apr 2026 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026557; cv=none; b=GWqVwFdOz+6idH3mjygW6NyTxo3utrJzu2YQWCTEyHfGKd47uwjYOGGE9O9ROuLLCAlYn0p5ZFMH3eluArSEZjtzD913iuzttEchwzXMFQC0LYJW53O3pcy1ih0KhV4WgWJUDZI2Kkymvwq4ujHKF+pdAt4gIN7C5HtfPduNvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026557; c=relaxed/simple;
	bh=YOAFUrcoHlkS5vMthYdV39cpt6VMyGb0bYFJDCrOr7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLHtn2XeAEZieyxi1uya6cnwiyGqdAyMMJILW1EN3ZKwzFXgyNYyEyN8TbZdjMUdb7Cn4yT9cxH2929LNH69m2kP/WbITXb0JrTfZaFKUEoas3WA4sh+5GcxXWjH/srO7OSdjZTCrGr19WbCGH7nN+pKcM1rn90tfby3TDnELfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Bwk+cLZ1; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NbLcjFRh; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775026554;
	bh=YOAFUrcoHlkS5vMthYdV39cpt6VMyGb0bYFJDCrOr7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bwk+cLZ10dBFpvBYd6stVDXcPdJEUCKKEiUXM6QkdRj4eyH5gz0oIxrr8Osgqg03Q
	 wFycmm+zpNOE7oJ4lJEzc4T8rdr8SKjaE/SYPzMxDop1e4Fkqf0bVTWf1yNZ3Szrm3
	 ARKq146c9oAUf10OC9/BgCV1xkCwYwHpunS2ozvublFLYYDehv/gpCYk3WfYpnxfp2
	 Dt1twUDNbZdaa4KNTkAgDfHIol5nBMxh2YL/x/WEIQ8Sj0S9IRItp5exBpRSyuYk3J
	 Phirvh9bE5tZ7lSDLGVFTkmMgYOU39KR+Ir8m5z97gK3PGIxBcCKg9kZrPrDipelAq
	 KnXMauqY0JdzQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8E7D8406F7; Wed,  1 Apr 2026 06:55:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775026551;
	bh=YOAFUrcoHlkS5vMthYdV39cpt6VMyGb0bYFJDCrOr7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NbLcjFRhhAHr56RUDYulQdb/xs4s2wY9dINd55ec5sfDwGGap0VgX5Yz+6Xe70ier
	 QLkPh4x2LrmYc8+2ZwrvnnaBYJuL3WfAwEHExDP/kY7QbzDO6OWCQ8a1hO0hsekil+
	 dSCwc025wM/rq116DfOsz27UhAfrC3TO9BomcC/q5K//5gCChEUFShxLiiL53jtYfS
	 gPA5yTLK+EYXnYOq4vzlXTUQKb7x2L2aa7M9inD5k3FPYEoI23fFI5zk4SH3IAMj1e
	 k+I6wMYQOGlzLWlq8Y2QUV1fGXxArZZih8Pqjxy6sQMzj2mDEaxi9d1XmyvZIBhlCF
	 MatLpWSWV2lzg==
Received: from [IPV6:2003:c6:9f04:eb00::1c8] (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E71E8406A4;
	Wed,  1 Apr 2026 06:55:50 +0000 (UTC)
Message-ID: <59b4be26-1fee-40f1-b9ff-45881cddc7df@birger-koblitz.de>
Date: Wed, 1 Apr 2026 08:55:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260324-rtl8157_next-v4-1-034312b12de5@birger-koblitz.de>
 <20260329193449.2764517-1-kuba@kernel.org>
 <50dc7e8c-6c6d-47d1-866e-677638b4deaf@birger-koblitz.de>
 <20260331175649.729e60a7@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260331175649.729e60a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-273909-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lkml.org:url,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 0EAF0375795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 02:56, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 17:38:02 +0200 Birger Koblitz wrote:
>>> Are there missing switch cases for NWAY_5000M_FULL in the hardware UPS
>>> flag configurations, such as r8156_ups_flags?
>> This question has now been raised the third time, see here:
>> https://lkml.org/lkml/2026/3/24/1902 and here https://lkml.org/lkml/2026/3/19/1765
>> However, while I share the concern, I cannot provide a better answer than
>> the first time or second time.
> 
> Apologies for the repeats, I tend to send out the full review as
> soon as I spot at least one chunk that looks plausible.
> I should do better but re-checking the AI reviews takes so much
> of my time already.. :(
No problem, it also took me a couple of minutes to understand that it
was in fact the same issue :-)

I appreciate a lot the time and effort spent by reviewers going through
patches, and reviewing AI output probably just adds on top of that. I
see that some of the issues found would have been hard for a human to spot.
On the other hand, some of the issues raised make little sense when giving
them a second look, and would probably not have been brought up by a human
reviewer. Still, they take quit some time to answer properly. One thing I
noticed in particular is that the AI does not seem to take into account
that the code actually works: suspecting broken SRAM-access or wrong
descriptor-size settings would break the driver at such a fundamental level,
it would not be able to work at all.

Birger

