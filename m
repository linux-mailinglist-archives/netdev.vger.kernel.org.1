Return-Path: <netdev+bounces-284948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKYgK2dt+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:33:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A264DE278
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508253004C56
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC93F0759;
	Wed,  6 May 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iUn/eC+o"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9293DC4A9
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085218; cv=none; b=t0IGPS0lRUuDX+2IkYBqR4XwgOtWT2TqvbYpLcmZBi0cboXJQeGZavobCKZF2Pp4Osl1PP1hDE5O8bsrq6RVRgBAKuqj0WpGUn95sSPkLcPULmxRJRvh3jdo4sEJ7VQbfebpsEi/T6gTFjp/kaxqUclontOn8exnY7yUynFOrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085218; c=relaxed/simple;
	bh=1zh/X7+hH1d7/prFg9KD4l+u+lDSEM/tlRGsDHYYRH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB3B0XwKFY3F257PUWcZvj9mgf23tqKF9xTJBeB7KPSF/Mdlv+/Zx1PtlQ5jwS6bjW0nxG+FVT7Ytp6wBw/oQZ0gyledG/dZCoH/+9+dqYQdzhBCFTM/v6DQFb1ZCe7AR65xByCOMCUF6FdCDg8DP/GnJMNm3WWKCrBvo3Dn4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iUn/eC+o; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x5/8GNpKuwxNH2D6O6cXan6XYudQ5OFljrWDqSUwgEE=; b=iUn/eC+oW6jHxAr4GiDolFvV9C
	FrevA416Av8BD1L3RWODVjNIKgNQpzA6AfJ5AfIaNkfm4xdMkAzNDo7prdb1pFMMb0b7U6sSyCyQ9
	gHVOdBABl3EcIkEoDfLhKmSYpMJnUg7yl7WP2vHwHZXZPOCoSLKUPIROifiNRWh/O7/LHZq7ny3JK
	jhAMtL6P8bKq4XGMrFHE8kOJ9Vs18AeNe1+2T3g6nZ4NnLuVd3PQL68um31r+echUITwnSvK0yZU+
	qgUhJWVxh9sQE6jLOWMBnFXTfsd7ced41GBcx0WvYU/Uh9A4D50oXhC0D05scOtFrl2tDtcuJWjpl
	zCwfyX7g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKfBl-003j2p-28;
	Wed, 06 May 2026 16:33:33 +0000
Date: Wed, 6 May 2026 09:33:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, 
	andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com, 
	jonas.gorski@gmail.com
Subject: Re: [PATCH net v5 4/4] selftests: bonding: add test for lacp_strict
 mode
Message-ID: <aftsOtnImLpgATff@gmail.com>
References: <20260506161144.465485-1-louis.scalbert@6wind.com>
 <20260506161144.465485-5-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506161144.465485-5-louis.scalbert@6wind.com>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 07A264DE278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bond_lacp_strict.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bond-lladdr-target.sh:url]

On Wed, May 06, 2026 at 06:11:44PM +0200, Louis Scalbert wrote:
> Add a test for the bonding lacp_strict mode.

Test seems fine, although it seems there is a bunch of copy & paste. Any
chance you can mke it a bit more modular with some helpers that can be
reused?

> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 9af5f84edd37..91269e7ceb63 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -7,6 +7,7 @@ TEST_PROGS := \
>  	bond-eth-type-change.sh \
>  	bond-lladdr-target.sh \
>  	bond_ipsec_offload.sh \
> +	bond_lacp_strict.sh \

TEST_PROGS is sorted alphabetically; bond_lacp_strict.sh should sort
after bond_lacp_prio.sh, not before it.

> +COLLECTING_DISTRIBUTING_MASK=48
> +COLLECTING_DISTRIBUTING=48
> +FAILED=0

FAILED is a bit misleading here. 

> +	# Allow LACP trames forwarding on bridge ports

s/trames/frames ?

> +	RET=1
> +
> +}
Remove the extra line above.

> +
> +compare_state() {
> +	local actual_state=$1
> +	local expected_state=$2
> +	local iface=$3
> +	local last_attempt=$4
> +
> +    [ $((actual_state & COLLECTING_DISTRIBUTING_MASK)) -eq "$expected_state" ] \
> +		&& return 0

The line above is hard to read, and idententation is a bit off as well.

