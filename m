Return-Path: <netdev+bounces-274452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIuODzlCzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22D387938
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F1730DD912
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FF3DEFF6;
	Thu,  2 Apr 2026 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="D/PMtfr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VtvJWq0l"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB539658D;
	Thu,  2 Apr 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124599; cv=none; b=ub2uXMBRU0hgHEW9gED8QSXeFkoB89UJrHzDke/riAhq0mudZdVNJw5dZA7pRa2kbEInY4+SG2KyvtPa7dGhbSZLDU9GsusHE0bGZSCEdaPotClIwtpRwSfMXEHVGT60jG6pCcdC1r86OKhh6DOIZhmhAb7yqL5ogSkkNWEgaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124599; c=relaxed/simple;
	bh=Q8my8z2czIQTbbasLPpWnzgJlYNGB5PfMpthwy71GAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke3Q6f4wPgtD7tEYayMTMJOANP/OEKwrJZd0Mj9JfgPij4r5zVwczfIt3I/titarhULIroraY3rZWSTlDoJ1Ptb+F/kCxGviQ6mBj8Qtcc3nj2bvsjBtu0l9Puf5HaEi/m5jmpxSsJuFZa0cr9oMIIlvAIX08ZK3/e0693oH3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=D/PMtfr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VtvJWq0l; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5F80140027D;
	Thu,  2 Apr 2026 06:09:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 06:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775124596; x=
	1775210996; bh=/X0lAsHuUwtq9gmFrxKkkryl3B8IzaJkdJQ1jRzZxrI=; b=D
	/PMtfr61UJvI5m/aTZmvLqcnnWMEVtO/4pdim+MWiT34EoH8MJu0WyC43/6sjEao
	R6QqMmQ7QEINma59qNcxVtAfYJPyf1XRwSx532d865Vd1ZmaUinTqeEUzTyMnoRP
	vqn9rbv7OztMWL5svYpBqlMw+Baf539nghuiRqpJEZHn/VI/QHUxRzySRUobRAWi
	80K9YUT4zUIzFArd7Dp40ZuczRuzmm2HFQ+XjeNQ0En5YF0gZgTZ5TXpb4jN+Tg+
	PU9uM//MY2cr4yei0I8bpUFVP2CBp8YABFu3c4CUfmml0WY+jfIR1XhkghyPv0pf
	XDEYgBD323MOfOlUSI7tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775124596; x=1775210996; bh=/X0lAsHuUwtq9gmFrxKkkryl3B8IzaJkdJQ
	1jRzZxrI=; b=VtvJWq0l+QTsbUhUsEuf4nNO3Bq67hnFtGR6MO6hJCDyIuhqliG
	L6D7aeCqt08dQInLduDaNxgeJ5IfuFzmClV78bWR17ITnTc3hZGBWV6KhMIxUgr3
	dgbGyNJVL8y/NRuhpmgfBBC3iz72GQbJpSv0YCoPWylNHYHYLOcrntyJCIg0s6Jh
	CALpvFwy0jdL7a6t+5tzbGsYjzKqyeP9GPZyhrv6pQ64biPaaF0yEHPXc1f6d5OR
	sMzRbtplKPo8NLgFq37CB7lYzorg3QWpY0eZ6EXVw2QMaDW/RCFWJddQIptKKU+V
	bgevOpJ5135220yFLWbkwjHGJglTFYYbyAg==
X-ME-Sender: <xms:dEDOaYrrRt09ARH8sZ9nAkdk_8qmSYWBqMZt2ak4HrOV-1vYJZ-7GA>
    <xme:dEDOaQODtvDGwTu33oTL3spiIP_-sIY0WuDr4vIEvzT0qLfIXXFAAJ14BxdLaQm4g
    pxx_bhgxE8e2k8842MVpKEmLQZju9yZJtSA8C3swfIeNN4R_Pu4WB9E>
X-ME-Received: <xmr:dEDOaccQuR72uwHHq6Or6Z9qhnRFq21hX9-pECj-rCJjBCbLazs6RlZkSRrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvg
X-ME-Proxy: <xmx:dEDOaWXAUY48p-_JymtpvTl3N_xTjcXH78ZgbOckuo9_Ii3TekhShg>
    <xmx:dEDOadC2XshAQ3bkz_x-Xwu2NFlI5J3PjRrkTKQDGxn6DshML8e0Ng>
    <xmx:dEDOaR41vaIyFjGT3Kiejp7MxmQXbgnEUBSIc0oiPf4TCTKgJJuusg>
    <xmx:dEDOaU2z4MDDb5AevFSzXkFJOvx4mPyryiHucP85h6GWEKYjoTbOIg>
    <xmx:dEDOaZturolf87oXhLZ5dss4220ghAwuVvNH1u_c-Td5I5ypYdQMV_xo>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 06:09:56 -0400 (EDT)
Date: Thu, 2 Apr 2026 12:09:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v6 2/4] nsim: Add support for VLAN filters
Message-ID: <ac5Acqsc9cbB089G@krikkit>
References: <20260330130130.989236-1-cratiu@nvidia.com>
 <20260330130130.989236-3-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330130130.989236-3-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274452-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 8A22D387938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-30, 16:01:28 +0300, Cosmin Ratiu wrote:
> Add support for storing the list of VLANs in nsim devices, together with
> ops for adding/removing them and a debug file to show them.
> 
> This will be used in upcoming tests.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 65 ++++++++++++++++++++++++++++++-
>  drivers/net/netdevsim/netdevsim.h |  8 ++++
>  2 files changed, 71 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

