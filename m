Return-Path: <netdev+bounces-255851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GexOnCWgGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:20:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65956CC498
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF5F3031B25
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A235F8A5;
	Mon,  2 Feb 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="lHdwoUwx"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DF23EA8B;
	Mon,  2 Feb 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034547; cv=none; b=C7bFMWhEDLSRSoYNrjoGdT4pCNsKgQw4r+nUpaApH+zEcTND63BEmT/JjafaaNec98fj0MPkNTfFkBfBPX86DeGihnulyfUgjIdERVYOG9jBgBDQEDDifG/1n/ruapeVrdKbj7a3Gc53f46DvJC4WI6kol0RgnylV0nsEi/a0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034547; c=relaxed/simple;
	bh=J5YAUEvdRSPdIe0eFvACFFSbO6JcdQgRSZZxwU2kLRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvk3L1Mw6w668wtPZ7+oBTkLrqid/jmjexYxnT4LfLsBUaUHef4dhVavcEEaKk+q5bUAcpXyW3onw9riuU7N+0kDyR0mxoirsDTYB3yFlbLVYESFsXdpA/EEaiLKOVkImk7Lz/b8BrmW8Ah/QPil/MxYbm6DMgddDS07duQZQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=lHdwoUwx; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1770034542; x=1770898543; bh=J5YA
	UEvdRSPdIe0eFvACFFSbO6JcdQgRSZZxwU2kLRU=; b=lHdwoUwx2joWLS4FlpXc
	UM5HqfMgCeTj2EVirubP+HrLXnFhSbab7KGj4jdKsAC8hjHBMKD1WietnKYxOndb
	OZHeHlgoMK/iXwo9dVymB0BlSYTO+b1bYVHyZX5wE7YUxI4EXeQk3uXMLG2mfGVf
	en+Ts0b/ZXaIXRE8arKx5XvzVti51wD5d5bHtD6JkTcpSKA8fWecVu2qsxwlLX6r
	PWhCod1rMs3bDs07wEMe8JLnYsNg5H1qsqKlfGWwYVcD2aEuTcvOlNqlWxK7QqN7
	5rdQ06dcT4ht21TUy7lZW0rtOExhnypiKzmbon1yne+lE3Ds4wO7YvLfT0ENSN2n
	rg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 02 Feb 2026 13:15:42 +0100 (CET)
Date: Mon, 2 Feb 2026 13:15:41 +0100
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org,
	linux-kselftest@vger.kernel.org,
	Tobias Brunner <tobias@strongswan.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH net-next v4 2/2] selftests: net: add
 ICMP error source address test over xfrm tunnel
Message-ID: <aYCVbatEuE4kpVpg@Antony2201.local>
References: <cover.1769595011.git.antony.antony@secunet.com>
 <af9a189bee31f7d8f3759ed71d09ab5a82437592.1769595011.git.antony.antony@secunet.com>
 <20260129184318.53b1dabf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129184318.53b1dabf@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255851-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xfrm_state.sh:url,phenome.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Antony2201.local:mid]
X-Rspamd-Queue-Id: 65956CC498
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:43:18PM -0800, Jakub Kicinski via Devel wrote:
> On Wed, 28 Jan 2026 11:20:45 +0100 Antony Antony wrote:
> > Test that ICMP error messages generated by an IPsec gateway use
> > the correct source address (the gateway's address, not the
> > unreachable destination).
> 
> could you check / fix shellcheck warnings?

lots of warnings. It looks like x-mas lights are still on:)

> 
> +In xfrm_state.sh line 115:
> +	$ksft_skip)
> +        ^--------^ SC2254 (warning): Quote expansions in case patterns to match literally rather than as a glob.

I will add quotes to. Thare 30-40 of those!  

> 
> +In xfrm_state.sh line 157:
> +	[ -n "${NS_R1}" ] && ns_r1="ip netns exec ${NS_R1}" && ns_active="${ns_active} $NS_R1"
> +                             ^---^ SC2034 (warning): ns_r1 appears unused. Verify use (or export if used externally).
> +
> +
> +In xfrm_state.sh line 162:
> +	[ -n "${NS_B}" ] && ns_b="ip netns exec ${NS_B}" && ns_active="${ns_active} $NS_B"
> +                            ^--^ SC2034 (warning): ns_b appears unused. Verify use (or export if used externally).
> 
> +In xfrm_state.sh line 166:
> +	local ns_cmd=$(nscmd $1)
> +              ^----^ SC2155 (warning): Declare and assign separately to avoid masking return values.

other shell checks are harder to fix.

+In xfrm_state.sh line 417:
test_unreachable_ipv6() {
^-- SC2329 (info): This function is never invoked. Check usage (or ignored 
if invoked indirectly).

those are invoked indirectly.  eval code I would like to keep. Would that 
work for you? are you aiming fori strictly zero warnings?

regards,
-antony

