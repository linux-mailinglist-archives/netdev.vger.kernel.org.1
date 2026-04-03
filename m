Return-Path: <netdev+bounces-275086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CtkL+jSz2mY0wYAu9opvQ
	(envelope-from <netdev+bounces-275086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD423955C6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C4B3008766
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784D34DCE0;
	Fri,  3 Apr 2026 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Nk6SyLpA";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="YjWs4/xQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7522156C;
	Fri,  3 Apr 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227621; cv=none; b=mLYZm9AbcA0LQE9N92EMQKmBERuRrbgcWrJ9yXscCTVCJpRom9UC0ORZzr4ePwpPoJbaPQe1mYPAbJdCvCx+Hfy6Z69BtBHv5I1Trfd+akRKOq+fpQfD8Q3gCcHpa8Ueoo0ck+XHmfVEdSIkcjiXSTJrjvXaK3++gsNbGCCae6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227621; c=relaxed/simple;
	bh=MUfPxn/Q9+bz73UceXrEBg6t1eCeckaRsXsjJcRKe8g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cGkTbIHbMIY4g+37VkBPINS2fTxK7rcbRwJ4p3hYCB3rOzMSx8dAZp7sO4mHuAYHWMitM5cGXscNavoLQVWvBevMSxLMx+VXE1w9IwhqP5kzfNcXvp8M7ZIv764g8NyX1kMD+4Y81y4dg2b9PQYI7tSeh5ENuauUJzVLKOz0iTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Nk6SyLpA; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=YjWs4/xQ; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 633Ek7Be016152;
	Fri, 3 Apr 2026 16:46:12 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 3F28E12289F;
	Fri,  3 Apr 2026 16:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1775227563; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcQvahFVMdD7UhY+90UTpiqjLUeMeXA4tfOKaLjxFds=;
	b=Nk6SyLpANzW6hPOU5+FmMVhLAal7weNGfeSglJSFHv19WwW2suo0UAwm3nqYmreZwPYIJ+
	892/zQJ0KwS4nqCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1775227563; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcQvahFVMdD7UhY+90UTpiqjLUeMeXA4tfOKaLjxFds=;
	b=YjWs4/xQGLVNRGMeq5pC7P1AyzxMu/oZUrE40GFzH/LAIIJLdgcdn/6RZmiZprUJnvm9Nu
	5FT4N9ZvuyQjawImojHoF5Jqw4E4O9NwwzeUXhZPFBzJyX7rKzoy4nUEAZW+bnQC6VCtLm
	bS5pvv7xYTlsCDPn5g6MwjfzBgZOoJSgacvlnaj5169SYsJExS3FwTK7rJ5YiIfl6q1SAZ
	a+OLCkyQeLkjNcC/ozy/ehwf5/zWicf9bAi0TjvPwksfsFe9xbEvOTu3EzPKKDuT08tfa6
	XCZcGLBLgkI4NPLmawjH4PloYteimP6jG3qYW0F1R8746SAHf3j8ClJQCG7suA==
Date: Fri, 3 Apr 2026 16:46:02 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        dsahern@kernel.org, david.lebrun@uclouvain.be,
        stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2 2/2] selftests: seg6: add test for dst_cache
 isolation in seg6 lwtunnel
Message-Id: <20260403164602.1ca0e48f06ddbf1291627f0d@uniroma2.it>
In-Reply-To: <d2b6a7fd-e09f-4e5d-838a-077ccecbd67f@gmail.com>
References: <20260401185755.29813-1-andrea.mayer@uniroma2.it>
	<20260401185755.29813-3-andrea.mayer@uniroma2.it>
	<d2b6a7fd-e09f-4e5d-838a-077ccecbd67f@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-275086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:mid]
X-Rspamd-Queue-Id: 1AD423955C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 20:35:12 +0200
Justin Iurman <justin.iurman@gmail.com> wrote:

> On 4/1/26 20:57, Andrea Mayer wrote:
> > Add a selftest that verifies the dst_cache in seg6 lwtunnel is not
> > shared between the input (forwarding) and output (locally generated)
> > paths.
> > 
> > The test creates three namespaces (ns_src, ns_router, ns_dst)
> > connected in a line. An SRv6 encap route on ns_router encapsulates
> > traffic destined to cafe::1 with SID fc00::100. The SID is
> > reachable only for forwarded traffic (from ns_src) via an ip rule
> > matching the ingress interface (iif veth-r0 lookup 100), and
> > blackholed in the main table.
> > 
> > The test verifies that:
> > 
> >    1. A packet generated locally on ns_router does not reach
> >       ns_dst with an empty cache, since the SID is blackholed;
> >    2. A forwarded packet from ns_src populates the input cache
> >       from table 100 and reaches ns_dst;
> >    3. A packet generated locally on ns_router still does not
> >       reach ns_dst after the input cache is populated,
> >       confirming the output path does not reuse the input
> >       cache entry.
> > 
> > Both the forwarded and local packets are pinned to the same CPU
> > with taskset, since dst_cache is per-cpu.
> > 

> > [snip]

> >
> > +test_cache_isolation()
> > +{
> > +	RET=0
> > +
> > +	# local ping with empty cache: must fail (SID is blackholed)
> > +	if ip netns exec "${NS_RTR}" taskset -c 0 \
> > +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> > +		echo "SKIP: local ping succeeded, topology broken"
> > +		exit "${ksft_skip}"
> > +	fi
> > +
> > +	# forward from ns_src to populate the input cache
> > +	if ! ip netns exec "${NS_SRC}" taskset -c 0 \
> > +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> > +		echo "SKIP: forwarded ping failed, topology broken"
> > +		exit "${ksft_skip}"
> > +	fi
> > +
> > +	# local ping again: must still fail; if the output path reuses
> > +	# the input cache, it bypasses the blackhole and the ping succeeds
> > +	if ip netns exec "${NS_RTR}" taskset -c 0 \
> > +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> > +		echo "FAIL: output path used dst cached by input path"
> > +		RET="${ksft_fail}"
> > +	else
> > +		echo "PASS: output path dst_cache is independent"
> > +	fi
> > +
> > +	return "${RET}"
> > +}
> > +
> 
> We should check it runs as root here (e.g, required for netns creation).
> 
> if [ "$(id -u)" -ne 0 ]; then
> 	echo "SKIP: Need root privileges"
> 	exit "${ksft_skip}"
> fi
> 

Good catch! will fix in v3.

> Otherwise, LGTM:
> 
> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Thanks for the review.

Ciao,
Andrea

