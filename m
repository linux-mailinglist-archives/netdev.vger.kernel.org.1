Return-Path: <netdev+bounces-268445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JUKKJ1HiuGmZkwEAu9opvQ
	(envelope-from <netdev+bounces-268445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:10:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F52A3E5E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BD95303338D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A52339847;
	Tue, 17 Mar 2026 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="A3UhdUQr";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="A3UhdUQr"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9651E511;
	Tue, 17 Mar 2026 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773724236; cv=none; b=dDEtAHeTV0DJnWqpv2/mGQ7OXrQOCZ0zxxg465HaO6i7K+NxS4y7AZnNlbbkBTFpnv2YqBU3GFGMHqp+zQHx2KXdjtLJygvpPxUEpc00ncbGMu7z653LiLnPW+CXlbUiP7BqFlSuMPJNc2KFn0zl4R3l6SAw3NPkRPrRgTsheRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773724236; c=relaxed/simple;
	bh=+0QBHxU4iNHLwQ8o9SYdy3OMq3UGOvW1+Ag5iPWHkT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9xnFITdu6tFSdPpEwSFJ69fw2WETXQwh4LobteH32aS5GJvqMd+rW5chr0E0PlUMaDX9+lrkBKBxfD3VXKqBvvGfUTYWpB1als7sE49uDSF9hw92KvACFZLtgigSpLffwGYzsQhtOstwBoJ49o5ov0pKQTOogNEQGi2u7nbmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=A3UhdUQr; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=A3UhdUQr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773724229;
	bh=+0QBHxU4iNHLwQ8o9SYdy3OMq3UGOvW1+Ag5iPWHkT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A3UhdUQrE5kUMRNcpfp6vsBrR5C1VhCdwDFgGeeHm5YaQc+9SR80kR+8pPPyjMk5k
	 hSL/IoJTN0cv9vY5eAPCy8yB72XifqpWg9WAFVV00E4S1GP3ilmi1/SIS0eXb2ovFF
	 BoeJf5AY04HZCjq1aliAZrmbw+DIy3ukuB8pf3KNDGoZDKagO0BZ2HN3KSka0Km1vK
	 AI3tA7FL3srmN1+AF87QZspFeuMqDb95nXmSVdvnuS4EMwI3ny9cF+syAlmeatkc4W
	 8RIFFC+KAuRkRPJLwnOuvj++qHxaxuGNqarfS37O9U8XYLNzkgiPCRmnX9oDOVf0Ep
	 RXAWn9zsrGZ2g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C813C3FDB2; Tue, 17 Mar 2026 05:10:29 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773724229;
	bh=+0QBHxU4iNHLwQ8o9SYdy3OMq3UGOvW1+Ag5iPWHkT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A3UhdUQrE5kUMRNcpfp6vsBrR5C1VhCdwDFgGeeHm5YaQc+9SR80kR+8pPPyjMk5k
	 hSL/IoJTN0cv9vY5eAPCy8yB72XifqpWg9WAFVV00E4S1GP3ilmi1/SIS0eXb2ovFF
	 BoeJf5AY04HZCjq1aliAZrmbw+DIy3ukuB8pf3KNDGoZDKagO0BZ2HN3KSka0Km1vK
	 AI3tA7FL3srmN1+AF87QZspFeuMqDb95nXmSVdvnuS4EMwI3ny9cF+syAlmeatkc4W
	 8RIFFC+KAuRkRPJLwnOuvj++qHxaxuGNqarfS37O9U8XYLNzkgiPCRmnX9oDOVf0Ep
	 RXAWn9zsrGZ2g==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F41DB3F5A6;
	Tue, 17 Mar 2026 05:10:28 +0000 (UTC)
Message-ID: <a0d20522-2253-4621-9060-29e61a1b1431@birger-koblitz.de>
Date: Tue, 17 Mar 2026 06:10:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access
 and ADV indirect access
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
 <20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
 <20260316175208.3e14385e@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260316175208.3e14385e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-268445-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: F10F52A3E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17/03/2026 1:52 am, Jakub Kicinski wrote:
> On Sat, 14 Mar 2026 10:31:38 +0100 Birger Koblitz wrote:
>> Add support for the SRAM access interface of the RTL8157 and
>> the ADV indirect access interface.
> 
> ../drivers/net/usb/r8152.c:1757:12: warning: unused function 'rtl_bmu_clr_bits' [-Wunused-function]
>   1757 | static int rtl_bmu_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
>        |            ^~~~~~~~~~~~~~~~
> ../drivers/net/usb/r8152.c:1788:12: warning: unused function 'rtl_ip_clr_bits' [-Wunused-function]
>   1788 | static int rtl_ip_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
>        |            ^~~~~~~~~~~~~~~
> ../drivers/net/usb/r8152.c:1793:12: warning: unused function 'rtl_ip_set_bits' [-Wunused-function]
>   1793 | static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
>        |            ^~~~~~~~~~~~~~~
> ../drivers/net/usb/r8152.c:1810:13: warning: unused function 'sram_write_w0w1' [-Wunused-function]
>   1810 | static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
>        |             ^~~~~~~~~~~~~~~
> ../drivers/net/usb/r8152.c:1824:13: warning: unused function 'sram2_write_w0w1' [-Wunused-function]
>   1824 | static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
>        |             ^~~~~~~~~~~~~~~~
> ../drivers/net/usb/r8152.c:9807:12: warning: unused function 'r8157_desc_init' [-Wunused-function]
>   9807 | static int r8157_desc_init(struct r8152 *tp)
>        |            ^~~~~~~~~~~~~~~
The same argument as for the unused r8157_desc_init() function in the 
previous part These functions support the new ADV and SRAM features of 
the RTL8157. If e.g. the rtl_bmu_clr_bits is moved to a last part of the 
series when the RTL8157 is actually used, this would also mean that the 
read/write functions it uses must be moved in a ripple effect as they in 
turn would become unused. It would make this part of the series only a 
patch introducing register addresses without any meaning. In my opinion, 
this makes it difficult to understand how the new features are used, and 
would make the last part of the series huge.

Birger

