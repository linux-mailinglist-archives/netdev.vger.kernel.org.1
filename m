Return-Path: <netdev+bounces-260133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IMgBaKMnGmdJQQAu9opvQ
	(envelope-from <netdev+bounces-260133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:21:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD017AAF9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E80BB300B3CF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4DD329C60;
	Mon, 23 Feb 2026 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RL7vslDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Af5RbD/R"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B8303A12
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867264; cv=none; b=H91V51dSmsk7kyOBUeAO/G7nHyzP6GYoeX0CMBOUl9Dt7jGIkGQECfLe4LfNnYyAt79be5/BUqmNs3FBUMlp5ix2cYavsTWq47DuqKs6lVzvZXJtxI0cKRx1XABwShWwywtnpI75BXoa1z6Yo9rcabXFZDpSugqtQeg2L3LL0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867264; c=relaxed/simple;
	bh=lzABwYFOXQ5oij5fe2LT93rT7LPuwyTyStNxhSGQYV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hygOmBxfLsFJJAp6Nten9LUwx7Beyg/9pPUfP2DRy+yKegIJPOCfCD5JBns4hBfUzs6PdCiAO/3fKm+PSV9C2g8ZRxA6PGP5gQRusvGuXSxKP78AXF6bRLKH+z/YssGtdNDvQthPd/viSD7GFDNnHLtX84vnWIMZpHoRyh74aFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RL7vslDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Af5RbD/R; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C5E0AEC05CE;
	Mon, 23 Feb 2026 12:21:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 12:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771867260; x=
	1771953660; bh=Jzr274Z9TaOqetGuxegsZs8KdoUxTTLufuHO0MWkd+s=; b=R
	L7vslDMNW9Y8TqmsRsoQ+/b0Clk+RASnMT+mI8dFR7+FcvHDElIIHrNLZZ1MTzUu
	ZO9fbiAUv6ma2988HDX6JkMiteJTcvL6Pg0bOUGzdGGfqx8zkKTRT2qKT4uZr3HN
	U7KESrTPfLXY8YnGcuc9ooRW2kStJfcd64iDQ+pJD27Xt6JyXJR8maVWSehSjU2r
	Mmoewunf1XdWbiVNLTM3gT1K19k0OfdsHuprjhYz5T4sbTpdM+MO2CTKdgfnA32i
	QL5HBcTTWDgedqU+5gRBo1fQ75HqjVzdY1DsCDzqGgaEMuQ7fzvqeEXTZ/xTKjix
	Y5HnT5376MIOPC43862IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771867260; x=1771953660; bh=Jzr274Z9TaOqetGuxegsZs8KdoUxTTLufuH
	O0MWkd+s=; b=Af5RbD/RY5nzw2Z+8Aj5kg8AC7oty1bXMETSC7/qZCm0rWfPT+j
	odFYlHVpsTL5bpOtAoBOtdUyg3RY2TxooVk4deezEXgL/XM4oq2XJXqOO8uJoHah
	yv3mJLWIttCdJpdr/tpHczxRTIel3f/ToBM8piM4RZcwboxuc7DSONuXofoNCH4/
	ttyUanMFUYLTyHntmAIMC6T39U2qIzLJ5ph07cEOq6iFjTL26576COSHVPMSTD49
	pjtR07c5xpjCsJ2HQ5hyscZ3Ukm+brGGomtePVIYufuWJuyWXPAXb2/ZX6fkmpXq
	7vOYlztNaRNHY2PW9nkNe3clMSRUNMiIx2Q==
X-ME-Sender: <xms:fIycadhyguzDhqP73_ucyjndHmrP30vfUC26LVOBH9axoEQb1PWUyA>
    <xme:fIycaencpI0mEgUTGytUJ7EqJZchKeOUcMms12byXVFaeDc2YJ4zuaG_MW9lAM7mK
    Xl16L7BCyI901dbqmuF2R_pnEeZMpkbuweZ3y8C_pO01Odh_sGmVQ_a>
X-ME-Received: <xmr:fIycaRieHZYhMclUNT5vtg4O_XFPM0be8lr0y31sGCQ0Nk07_wOl53hoYJX9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehi
    mhhvgegsvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhulhhirgdrlhgrfigrlhhlsehinhhrihgrrdhfrhdprhgtph
    htthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepnhgrthgvrdhk
    rghrshhtvghnshesghgrrhhmihhnrdgtohhm
X-ME-Proxy: <xmx:fIycaZHhOkUQtHue-lIB7e-RneSjqO_rhJN0cvDpnmteLcV4cOt9hA>
    <xmx:fIycabsohGyEkLXlMIfW5YyniJVLmdKAty-8Q0b7jnmWnxtgYMNVUg>
    <xmx:fIycaSfRQ4CF1Apj12Pwi0b7uBZwKbRe-u_SvK7SJbHYOj7qTutDsw>
    <xmx:fIycaZmAfcBLJvsCw3lACrTuW6uvKWsgnD882_cpcSB6yOlF9xdmlg>
    <xmx:fIycaYOcRHFpP5tsdpqjqhBiDIF8F_XLvAAWuWulqB0ZbQu4ozSvM7m4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 12:20:59 -0500 (EST)
Date: Mon, 23 Feb 2026 18:20:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aZyMejqTbkI7o_VM@krikkit>
References: <aZgpkyTDU3aXe_V0@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZgpkyTDU3aXe_V0@v4bel>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260133-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 7CDD017AAF9
X-Rspamd-Action: no action

2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> This issue was discovered during a code audit.
> 
> When strp_stop() and strp_done() are called without holding lock_sock(), 
> they can race with worker-scheduling paths such as the Delayed ACK handler 
> and ksoftirqd.
> Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> invoked from strp_done(), the workers may still be scheduled.
> As a result, the workers may dereference freed objects.
> 
> The following is a simple race scenario:
> 
>           cpu0                      cpu1
> 
> espintcp_close()
>                            espintcp_data_ready()
>                              strp_data_ready()
>                                if (unlikely(strp->stopped)) return;
>   strp_stop()
>     strp->stopped = 1;
>   strp_done()
>     cancel_delayed_work_sync(&strp->msg_timer_work);
>                                strp_read_sock()
>                                  tcp_read_sock()
>                                    __tcp_read_sock()
>                                      strp_recv()
>                                        __strp_recv()
>                                          strp_start_timer()
>                                            mod_delayed_work(&strp->msg_timer_work);
> 
> To prevent these races, the cancellation APIs are replaced with 
> worker-disabling APIs.

I'm still not totally convinced by this patch. The comment for
strp_done says the function expects to be called at a time when
strp_recv cannot happen in parallel:

    strp must already be stopped so that strp_recv will no longer be called

"strp stopped" is not really enough, I think we'd also need to reset
the CBs, and then grab bh_lock_sock to make sure a previously-running
->sk_data_ready has completed. This is what kcm does, at least.

Without that, if strp_recv runs in parallel (not from strp->work) with
strp_done, cleaning up skb_head in strp_done seems problematic.

-- 
Sabrina

