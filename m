Return-Path: <netdev+bounces-257863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HpohKKbqiGn6ygQAu9opvQ
	(envelope-from <netdev+bounces-257863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 20:57:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE710A0E1
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 20:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 992643006526
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B7F324B19;
	Sun,  8 Feb 2026 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfMEVkgJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljIc6eK2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GaUeFwes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="86HsFDgP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BD3242DF
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580643; cv=none; b=OnRPg+GxS73R6NrLv4ngad5U/crrT9KvJ3X4/Z+YbY+rReP4cfJdWGTtYboP4hrtIscu2HuyHueqkk1HZqTXYeBCWBDTt7bXgK/6AmrbiroUnmVzwMbwc7Qhsrw5m5GW/Ds8xukSRSe90PvYsn1Xg1hQ9kS5NJ2RP44nCx5+0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580643; c=relaxed/simple;
	bh=iSjRZvo+Ke3aUGcJzyWR1QsS/IsWTpdlCp8M+eB+HJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCsSJEXB1wQkbodXs2vU99paHl+oSrOJivh/sEX1fEhPq0FhR3nkQcIvw7FK7h4RZCZDHLtcJ/CRPHDD/+0gio3HYAHbqjgrFo/hHlalso+OybsQ7OEqFLnH0vL2cLnOL16G2eTj1pcn7Ms3EPk+ideyofEdQ2toBgyViazsYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfMEVkgJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljIc6eK2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GaUeFwes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=86HsFDgP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 850823E6CB;
	Sun,  8 Feb 2026 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770580641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqlGwtYX+MEze4I4SMUvvWRAbLM/JY8G2ZtgZDFiRjw=;
	b=JfMEVkgJ/keczEDLJpEDDh1IJwENp0LwWgkfxf9BZe05UpoD1uMjBR5qdXUR3FUgXmCSoI
	ojPYpmHNtohZugLmjBcV6s8p0xcGzzyo3DW0sMx4kNi3E6M+tmXAe6B90k/8D6FRnZxet0
	UzwU0sAz9z6veCpwOcC60mMmTrUGo/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770580641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqlGwtYX+MEze4I4SMUvvWRAbLM/JY8G2ZtgZDFiRjw=;
	b=ljIc6eK2EcWTHkMgTLs1v0zdywxcRUWzyL4OUSFl20Cxzvd+JciUzZPPetxAsYdqOWHawK
	yuUdidzL9DnN6ZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770580640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqlGwtYX+MEze4I4SMUvvWRAbLM/JY8G2ZtgZDFiRjw=;
	b=GaUeFwes2MBhGzB0IPoDQ13x59ho8OQmxpsbJiUjhyddoRtpi8kZGkmELbjjxjudF3Twlz
	pqposZn9WeWHO/Hie00pQeo4LsOrAbRUAHkNiOPiwoRHFN79OveWz1lWe2nlEj6dRqI7kW
	N937DHTwpJMREJrJIw4DB0+gd2WSLqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770580640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqlGwtYX+MEze4I4SMUvvWRAbLM/JY8G2ZtgZDFiRjw=;
	b=86HsFDgPRs8+gHvEGmqjeqo0TfYF7T1VcYh7c+KZxs1BHvjXe1/eCx1S1GR0x0SxtFID0Y
	qDPoiTbB7MhhkeCw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id D481220085; Wed, 04 Feb 2026 10:01:53 +0100 (CET)
Date: Wed, 4 Feb 2026 10:01:53 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Josiah Stearns <B00TK1D@proton.me>
Subject: Re: [PATCH iproute2-next] ss: escape characters in command name
Message-ID: <54yxlodp3y7dpdlngbheflrmaaqnswsvk4kvkrq6xjasx4bzxs@3ykkmoz2j5sy>
References: <20250204162429.17902-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204162429.17902-1-stephen@networkplumber.org>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DATE_IN_PAST(1.00)[106];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257863-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim,networkplumber.org:email]
X-Rspamd-Queue-Id: D8DE710A0E1
X-Rspamd-Action: no action

On Tue, Feb 04, 2025 at 08:24:16AM GMT, Stephen Hemminger wrote:
> Since the process name is under user control with prctl(PR_SET_NAME)
> it may contain escape characters to try and mess with screen output.
> 
> Reuse the existing string logic from procps (used by ps command).
> 
> Reported-by: Josiah Stearns <B00TK1D@proton.me>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Hello,

I found this patch while checking if this problem was already discussed
in the list. As far as I can see, the patch has not been applied and
there was no discussion either. Was it just forgotten or was it rejected
for some reason?

Thank you,
Michal

