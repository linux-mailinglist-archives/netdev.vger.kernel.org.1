Return-Path: <netdev+bounces-256240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAkmASDNgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:25:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E2D78D3
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ACFE303C03E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06FD314D0B;
	Tue,  3 Feb 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="PvIzIw+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5330C614
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114163; cv=none; b=M99u86CzRryExkuJM7T7D4OUGjVTS9XqnpQXcQk+P2ilBzWA2bstmIrNejQETNkWdPiRf4gN3RCHy+FNNcesnkY+rQL/cDKX7N8epl6jApVQLnee9Nzr/7gjeLmnalseaxV+x7+3ywVHJPvNXistt9yG1TnXevdGvygp0EJNAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114163; c=relaxed/simple;
	bh=Kqvpos+RWlrwy+XNoK4ue52uwQTiGDjvw7KEDW9cP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckxWTfvAFdKyANlKUpltoueGBTPXoL93v9Q+F46eNUFzhhDGiCrl6uI2qiG7uDoonU5k9nPbsODe7gCocHlmvNFE6z7BjSdpxzKtFIpgC/ZISRnLaMm1ffBJ9zozv0zn8MM/KImA3UIcGfIYRZffKch1e3oYNZDe2SyrrsoF3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=PvIzIw+D; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2ECD5E88C8;
	Tue,  3 Feb 2026 11:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1770114151;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lJqpLqxcGPZ2sC7+94x3oZxgngbX+frToDSayrxDPOY=;
	b=PvIzIw+DtaU55g0n8n6u658CkHSaMzx5IRD9n5vZK4qym6zIOVXtKJ/3JWmTksAOJJo8Nk
	QViqoQcYhy2hi/7iOHtJpeSH0mYJc0b7RJL9kea/8r/T2z8oRci78i9B86ACNidAJjqKmc
	HFWcY6BnRU9MkeIIGpGDp/0+NBB4gXoCUGdUP1gLUAuJBad6pR0/7FB16JV7YYO24yZcc4
	hFnxvRWWoJvdw5XL6RLFXP4f4hVFu0uC3p7gc6SHicZJN0Kjw+1FW5NFYb14LqXiJYiLkS
	T+YSBIxHE+FA1AfU9XzYGcnj13wK1fZCTKik5A1LnxjtiAvZcwXfNP0CTih5mA==
Date: Tue, 3 Feb 2026 11:22:18 +0100
From: Heinrich Toews <ht@twx-software.de>
To: Rob Herring <robh+dt@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
Message-ID: <6th22oikkvh2dxarh6fmbc6kqrpob5wvn4rrgmt3jjotezqum2@c37qu4rrqhhu>
References: <20260128133842.1173406-1-ht@twx-software.de>
 <20260128133842.1173406-2-ht@twx-software.de>
 <CAL_JsqKbRSWg+9vNNEa9a2YtDfE+WDYFrRQsjugF0AXj9Yiq7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKbRSWg+9vNNEa9a2YtDfE+WDYFrRQsjugF0AXj9Yiq7Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256240-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[twx-software.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,linaro.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,twx-software.de:email,twx-software.de:dkim]
X-Rspamd-Queue-Id: 578E2D78D3
X-Rspamd-Action: no action

Hi Rob,

On Wed, Jan 28, 2026 at 12:06:10PM -0600, Rob Herring wrote:
> On Wed, Jan 28, 2026 at 7:39 AM Heinrich Toews <ht@twx-software.de> wrote:
> >
> > Enable single LED mode globally for all non-CPU ports to indicate
> > link and activity via a single LED per port.
> 
> Please use get_maintainers.pl and send to the correct lists if you
> want this reviewed.

Thanks for pointing that out. I will re-run the script and fix the recipient list in v2.

Best regards,
Heinrich.

