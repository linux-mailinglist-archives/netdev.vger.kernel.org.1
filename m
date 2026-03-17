Return-Path: <netdev+bounces-268435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C6MLojauGmjkAEAu9opvQ
	(envelope-from <netdev+bounces-268435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:37:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD082A3C5F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3CDC303E3A9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802232D7FB;
	Tue, 17 Mar 2026 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cLoFRvyY";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cLoFRvyY"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7F328260;
	Tue, 17 Mar 2026 04:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773722169; cv=none; b=TNt9Q5M9i4m6RTCXtEf4LnLXWJ1b+nJOYbYZ0tG+yH17pvuzNBC3p0PWl2NxtrBLfOIXN2YG/5K27gDLIOlE2huf5sX5V2lY2bvd+eGJGmgFyO4p0i3mPvrTc6/kIV2pXIqloZOPGPkuPXhioeMoaLUgdP6fREC7deLI2NAPkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773722169; c=relaxed/simple;
	bh=a0oYQmrjumgT6bavll3Lit4NoxGFeRMCW1hSM++Mtgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9N+MUDV92PKhRRxhelSpLXy9FgrFmI8TkPTA9n3tiLeho3gl2HQAnLtUd1MbWQ9P5kdWAB3VwYBIbMoT7NrmLIFdWxW0Reh6DYcjj826N6JfcU5J+2LyTbXMWQkW4s42nBBGYZa8O0KP2Uk42N96Gs03g/3hr4ckEDZ21hnRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cLoFRvyY; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cLoFRvyY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773722159;
	bh=a0oYQmrjumgT6bavll3Lit4NoxGFeRMCW1hSM++Mtgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cLoFRvyYyVkUHSUEOn3bbyheViar8ZwM2omRBcgMgIE3rhNNbBPwjk6/KDko8dw3a
	 0ZLV+hQn9MFtlipkkjZsn5QjyEJAI47HBKth+SSNB/qbRMsxhZ5ytqdZMLMRLydidc
	 X8/jSr7hRuaWtd2PRUMWK+ipvhF4pUopsFmZJzwmqvzO1eUOO2tIgikKwCsShO+Vfz
	 aunQiEJq3Ka6wyXuItY2mw3pRnwaGrfVxXDCbkY/YPe1+eOgvhKwvSfy71eAYmgAop
	 eoqFUlRbuMtOQmXmVSLcIqajrEegaejPWvHD0hoehInEdtKokoPYNNmdt40gKZv3ko
	 zDYLp8iDZuMlw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B56F23F5A6; Tue, 17 Mar 2026 04:35:59 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773722159;
	bh=a0oYQmrjumgT6bavll3Lit4NoxGFeRMCW1hSM++Mtgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cLoFRvyYyVkUHSUEOn3bbyheViar8ZwM2omRBcgMgIE3rhNNbBPwjk6/KDko8dw3a
	 0ZLV+hQn9MFtlipkkjZsn5QjyEJAI47HBKth+SSNB/qbRMsxhZ5ytqdZMLMRLydidc
	 X8/jSr7hRuaWtd2PRUMWK+ipvhF4pUopsFmZJzwmqvzO1eUOO2tIgikKwCsShO+Vfz
	 aunQiEJq3Ka6wyXuItY2mw3pRnwaGrfVxXDCbkY/YPe1+eOgvhKwvSfy71eAYmgAop
	 eoqFUlRbuMtOQmXmVSLcIqajrEegaejPWvHD0hoehInEdtKokoPYNNmdt40gKZv3ko
	 zDYLp8iDZuMlw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C44083F5A6;
	Tue, 17 Mar 2026 04:35:58 +0000 (UTC)
Message-ID: <df5e1911-c7ba-4727-b462-812d6289ea9b@birger-koblitz.de>
Date: Tue, 17 Mar 2026 05:35:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] r8152: Add support for chip version
 RTL_VER_16
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
 <20260314-rtl8157_next-v1-6-9ba77b428afd@birger-koblitz.de>
 <20260316175057.7eed3fab@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260316175057.7eed3fab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-268435-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FD082A3C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

thanks for reviewing!
On 17/03/2026 1:50 am, Jakub Kicinski wrote:
> On Sat, 14 Mar 2026 10:31:42 +0100 Birger Koblitz wrote:
>> The RTL8157 uses RTL_VER_16. Add support for this version in all
>> remaining configuration functions for power management and RX/TX
>> configuration.
> 
> ../drivers/net/usb/r8152.c:1744:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>   1744 |         if (i == 10)
>        |             ^~~~~~~
> ../drivers/net/usb/r8152.c:1747:9: note: uninitialized use occurs here
>   1747 |         return ret;
>        |                ^~~
> ../drivers/net/usb/r8152.c:1744:2: note: remove the 'if' if its condition is always true
>   1744 |         if (i == 10)
>        |         ^~~~~~~~~~~~
>   1745 |                 ret = -ETIMEDOUT;
> ../drivers/net/usb/r8152.c:1734:12: note: initialize the variable 'ret' to silence this warning
>   1734 |         int i, ret;
>        |                   ^
>        |                    = 0
Will be fixed, of course, in v2. I need to figure out why I did not get 
these compiler warnings.

Birger

