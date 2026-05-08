Return-Path: <netdev+bounces-285773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMnXHfLQ/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:02:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F414F60C1
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6943018BC9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA9343216;
	Fri,  8 May 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b="AgwaEzUr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D7256C84;
	Fri,  8 May 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241774; cv=none; b=DyVe1fZLE/z7iTEeLGSp7fYB43ku6Zq43W6Ie+K0+6/FxLpyxQPQz3b0GdzsQYYdq4Nt1Cpzcm8nId9YDoB9k0h6RcaWc2dqB7K5b6/AYeC5BnbPLspEs8L+I8+SMX9Bjh1T2kx3Gw/76fTkNBmOnUeIA0lNOOfKvh1KHCZy0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241774; c=relaxed/simple;
	bh=IbfMGtNlgyWaWV4deyaJ80OvIp5WFMnDGOmztr5Ab9A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:Content-Type; b=qmuBgel5W0Sv8wYorb06PBNHq+mwGs9DkGg+9GPmkQgrcWiEk8Z3R6IRnT06t7eF54m6GL1evG73nHbURl8in4v+0YSTJuVryFVXw7vnR6G50QGiMr1iwg/qc+3+e3d0YNDNw6H1hm+nwPa8he0AdXD52WeW1Oag30IkkYhE1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com; spf=pass smtp.mailfrom=desarrollaria.com; dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b=AgwaEzUr; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desarrollaria.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desarrollaria.com;
	s=s1-ionos; t=1778241755; x=1778846555; i=y2k@desarrollaria.com;
	bh=IbfMGtNlgyWaWV4deyaJ80OvIp5WFMnDGOmztr5Ab9A=;
	h=X-UI-Sender-Class:Date:Message-ID:From:To:Cc:Subject:In-Reply-To:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=AgwaEzUrDzvruxCm+Gp4K9umfcOcruCjAYexhxmXp+oWyCE1AVkU5RIcALrMMoGt
	 Gj2L5v12eoFKz2T2mBQifbNigpQ64AdqYFWKxXlM8Mq/0yMthNuLZibXFkWllHFyn
	 I8Du03LgsCvjzF+01ebkZAFNtd8RfnQUyiQMVGyEFrx01bZb/Fyw1AFBZgGW5MlpZ
	 LJFD7vJVx1hh1z2xT+lkap+AUAD1u4GIi3izogenc0WtI+MS9XqDzHt0hvE9mjxvy
	 NIjYXbJtPPZ3/wKQnXSxGzny64alP4L8OibvJF2xnGi8id9dwr/McK3FyGcQ1WD0F
	 2wRRybpPzchDoTEuaw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1N49Yt-1vLHHG0QAD-014KaK; Fri, 08
 May 2026 14:02:35 +0200
Date: Fri, 08 May 2026 14:02:30 +0200
Message-ID: <27ab1dab62e7cd9d8f85c59db88d8fc2.y2k@desarrollaria.com>
From: y2k <y2k@desarrollaria.com>
To: kuniyu@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: ipv6: ip6mr: Call ip6mr_fib_lookup() under RCU in pim6_rcv() and reg_vif6_xmit()
In-Reply-To: <20260508115204.4068686-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:Rh5c7ZvJRgJbDecFAT8sZagSTgdS7qegMMQUe6wDr/JwLP2uRPM
 9UGbdJykdxjB47hhk9iqlBw4G8Lthxk94A4MrPi+Ul3LOtprw7nRkM5Sx1jaakt7l4WvocG
 4l2HY/vWbPKZzD7IlJTdyVgBgVCX1Rf1n/TnmSasjJsQLmvhqGFjf8yYdTLXssvIDhKXh8m
 9YKklrH5fKLxJQKpWmYlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CoiiSczY/rY=;oO+zyCu9Lg9bLlzr8Ir5ewa3Xyn
 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
 wnUpwcn5XgofttyNwl5w6MFhhPdJU4V3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A6F414F60C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desarrollaria.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[desarrollaria.com:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[desarrollaria.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285773-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[y2k@desarrollaria.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,desarrollaria.com:mid,desarrollaria.com:dkim]
X-Rspamd-Action: no action

Thank you for the clarification. I missed that IP6MR is not yet
converted to ->exit_rtnl() and therefore does not need this change.

I appreciate the quick response.

y2k

