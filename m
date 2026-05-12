Return-Path: <netdev+bounces-287214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG4zJ7NDA2pV2QEAu9opvQ
	(envelope-from <netdev+bounces-287214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:13:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24515523656
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48211301B6F2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9539EB6B;
	Tue, 12 May 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kt5h+Q+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g99FBwDL"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DA3ADB94;
	Tue, 12 May 2026 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598832; cv=none; b=pJE9W0E+QxaG6SUYOCALSmAIHugw9AVBSwy9Yu2AwngocWW0DLUOEcGh+XcTzIz1Xve7g/eMhsk+4Xme92PNZgNQIlAuDvAPxm58647mKhhc3Ja8knts07UZEKMJAQQE0ZQ9RE8oBDjP4dhwDPH4m753m1KLVdVM58fPBhuHbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598832; c=relaxed/simple;
	bh=n6He3MHOhl6b1jzMbiTQcxN/83zKOZ1lsUWQ1p+11Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFwuz6PLCe6xUUM/xnIWPmrboJT7b9dzC3HFIZ2828T0qGxK1AAnUQuhsjtdkTSg2IL3iCXoRPkciM+wC7+dz/KgP0HHFb4r2Q4ZvVsa8MssHWpgd/O7PZeCB3JgrJ/cho9WGuwq1qEEBoiu3DzBUYFOOadKFAwjHXsP3iXzMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kt5h+Q+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g99FBwDL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 16DE5EC0206;
	Tue, 12 May 2026 11:13:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 12 May 2026 11:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778598830; x=
	1778685230; bh=x450cnHuAsSkugN6rsBxOaQ+GdojEN9A8YeAUH+BPUI=; b=k
	t5h+Q+P2x1N9ZGO5m7E9vqlONRCaT+HTEVygiNRrmN2jlPXMmZSmUA11cKdCkczv
	nDi+CiGkawupfFfiUmLjfWiSQGrZzcMlgs3XdK4esB4oa0bI+MvuK7gi3ayUlPFb
	j8lT+1nCnu61IAN60rwHnOkCnCz6ECYyElsJ/pXjNaYcn35g1eWzQaRgJot1s2f1
	qM+xn7zRrMDwgc8ou+zTKQmqnshHfNwIQorG7hySHvcym+crrgpCFCHzS9lhClfg
	FH0X5B2bq7wWUABgnNg31/f9ntJooh5aNhPlhHnea179slb1mJ3OUcLi43Aoh3Go
	uXHmughELB0XILkDlapkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778598830; x=1778685230; bh=x450cnHuAsSkugN6rsBxOaQ+GdojEN9A8Ye
	AUH+BPUI=; b=g99FBwDLp2sfBJbP3sOOn4Xr+RaLKurfRG1l6u45yxHgmLG5LhB
	1dSle44sHDqzsQY/x3PPM4TN9GXEP2oqoBNeP5EPQwjcEVs6f5N9bpgya+dS3BE0
	rgdd9kPAg0mnrFRBPs9LfWhzmdl/yjrgiC3+JglFfuDBO9gQrgxodmxZcaMS1Cnf
	MsrPO8JpNvMny5POyxohQYDoyASQjr98e0m6xlzL1SaiDFOd2ePK5mPaInNb4L4R
	LGApjxy9oXOWT7Z9W85SVq+o3+aJOf+Wlemr9MDI0ecgFIcUDvaZC+3X8QefD3il
	ZIXQi7dW6oD3i7lfSUTmnVosQoEj3Tj+lvw==
X-ME-Sender: <xms:rUMDap_HzlOdHzMS0f121DVfh49_1jlg-nIUb8Dov7wqUyB8ji8jNA>
    <xme:rUMDaiqOhGwo18qxASPTI5FhM3srfrtZ56I67YUSLyv9U6IWR56Qv_98DdBDC_d0z
    Wf-3VsETjIlCAJqrq9u8QWdxJCFAeKeaRDh8xsLCLLqVyE2nZAQpQ>
X-ME-Received: <xmr:rUMDarRzYkgoc2KkVe2smsKq1h5JVf_XShwranuHXj9vF_AbFTMTPjD82dLz-DnfWNcyu7yq23YcJb1tkvor6Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhgvgigvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rUMDatOxcBne1nuUOCtci9Cu7xkB3KsLJWp5y5CCVaaHgSQD5VE4aQ>
    <xmx:rUMDahhFSsZHypiYw4Em46L8L4n-yRrguqbCNyHka4yudt9ozVaMsA>
    <xmx:rUMDaininiFHfTJMMiRow6oYOENZxCUzmTigiZSysqDxFI0qQpVzFA>
    <xmx:rUMDalhaSY9qOJO4Vc7mjWcleTUwrMMT9EdrKaPlC2y3LaMyXnq9Yg>
    <xmx:rkMDagO5UrWmWSR8arn6y46LpRhfK5LnN3DO522bBStLwQyEc1DL9SyM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 11:13:49 -0400 (EDT)
Date: Tue, 12 May 2026 17:13:47 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] ovpn: respect peer refcount in CMD_NEW_PEER
 error path
Message-ID: <agNDqz_4aUnwkusN@krikkit>
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512042036.19870-3-devnexen@gmail.com>
X-Rspamd-Queue-Id: 24515523656
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287214-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-12, 05:19:13 +0100, David Carlier wrote:
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 291e2e5bb450..4c66c1ec497e 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -462,10 +462,12 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>  sock_release:
>  	ovpn_socket_release(peer);
>  peer_release:
> -	/* release right away because peer was not yet hashed, thus it is not
> -	 * used in any context
> +	/* For UDP, the peer is unreachable until added to the hashtables, so
> +	 * dropping the initial reference is enough. For TCP, the peer may be
> +	 * concurrently reachable via sk_user_data->peer until
> +	 * ovpn_socket_release() detaches; rely on the refcount.
>  	 */
> -	ovpn_peer_release(peer);
> +	ovpn_peer_put(peer);
>  
>  	return ret;
>  }

nit: after this change, ovpn_peer_release() is only used within
peer.c, and can become static.

I think it'd be nicer to do that now with a v2, but if Antonio wants
to pick this patch up directly, the fix LGTM:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

