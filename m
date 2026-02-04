Return-Path: <netdev+bounces-256639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II9KH0kQg2kPhQMAu9opvQ
	(envelope-from <netdev+bounces-256639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:24:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F59E3C9E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACD0305D6E5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8BF3A4F2E;
	Wed,  4 Feb 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puwpPZkX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tg27M+QV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puwpPZkX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tg27M+QV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFD3A4F22
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196883; cv=none; b=eJAb9pFY3yWq9xo3t4Pi4+nGfApAl/W/HawCtkTYhxR6D9XM/V6Kcl3nLTXRdMrucRK2SvL083p7FBOP4icYFRuVJswN5KSU2TDbflCAeheulhtCG9pidDRo3VWW8qg1nsy5b/bHzHqu/B3uO42dKUS571rR2Am/Kk5waey8T+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196883; c=relaxed/simple;
	bh=tGNplHP7+0St/UWiX9DzWaQwF4Fs//5DvtAYVYdZiRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhHSCyQHLeXmmb19enRPMJxRSVeoOyc3xHk6lZ7wOmy60QKCudfcw/m3uZYlIt+AiTtpjZyvmVzw9IBKfrc2iuhWF7wM8cNDj/KSQzTKi9dsjMdOhxSPuBHHPH+RcFJcXpzzOtBGf/MzukkL9xXwV2ksaRX28AdBoGS5g6VXDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=puwpPZkX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tg27M+QV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=puwpPZkX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tg27M+QV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79D413E6F0;
	Wed,  4 Feb 2026 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770196881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnA/eKY7OfU1JlPid59Hfm849Jy0oJFMU/FrIu+o+iA=;
	b=puwpPZkXxA35zqlbLWmb3cDPCyeiLlIzalERVZGnde/omI3tNBMEW47tLQtMkMJDy/OdhB
	Q59ibKmW0ARMO+uAbTz9Ks2xQEMXYHr4/MTi3rJbNuJ2+MqxShZpPP8DNZ+4S+YZfzNGsp
	H3iL2Ds95T5JuTKuRTv4QVILLseqzXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770196881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnA/eKY7OfU1JlPid59Hfm849Jy0oJFMU/FrIu+o+iA=;
	b=tg27M+QVmYtSjEeAHg/d+8Kk+4/vJvIVw7rIDVPG38vtw4H2cmZVLeAyMwHZR+Z7/3pH7a
	JlrWKuN5MSOx3lAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=puwpPZkX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tg27M+QV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770196881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnA/eKY7OfU1JlPid59Hfm849Jy0oJFMU/FrIu+o+iA=;
	b=puwpPZkXxA35zqlbLWmb3cDPCyeiLlIzalERVZGnde/omI3tNBMEW47tLQtMkMJDy/OdhB
	Q59ibKmW0ARMO+uAbTz9Ks2xQEMXYHr4/MTi3rJbNuJ2+MqxShZpPP8DNZ+4S+YZfzNGsp
	H3iL2Ds95T5JuTKuRTv4QVILLseqzXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770196881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnA/eKY7OfU1JlPid59Hfm849Jy0oJFMU/FrIu+o+iA=;
	b=tg27M+QVmYtSjEeAHg/d+8Kk+4/vJvIVw7rIDVPG38vtw4H2cmZVLeAyMwHZR+Z7/3pH7a
	JlrWKuN5MSOx3lAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FCC93EA63;
	Wed,  4 Feb 2026 09:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBvqEpEPg2neXwAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Wed, 04 Feb 2026 09:21:21 +0000
Date: Wed, 4 Feb 2026 10:21:14 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Josiah Stearns <B00TK1D@proton.me>
Subject: Re: [PATCH iproute2-next] ss: escape characters in command name
Message-ID: <3kqsi4wasq53l2ugn45jcuowb4ntnbsdwidqulqvuakc4ezslj@hbuct36boj6v>
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
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,proton.me:email,suse.cz:dkim]
X-Rspamd-Queue-Id: D3F59E3C9E
X-Rspamd-Action: no action

Dne Tue, Feb 04, 2025 at 08:24:16AM GMT, Stephen Hemminger napsal:
> Since the process name is under user control with prctl(PR_SET_NAME)
> it may contain escape characters to try and mess with screen output.
> 
> Reuse the existing string logic from procps (used by ps command).
> 
> Reported-by: Josiah Stearns <B00TK1D@proton.me>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Hello,

I found this patch while checking if the problem of sanitizing process
names in ss output has been already discussed. As far as I can see, it
was not applied to git and there wasn't any discussion in the list
either. Was it just forgotten or was it rejected for some reason?

Michal

