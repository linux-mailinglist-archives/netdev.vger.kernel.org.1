Return-Path: <netdev+bounces-277219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMUZM65n2Gm1cwgAu9opvQ
	(envelope-from <netdev+bounces-277219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2473D1A10
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C1D300C90B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FC30C343;
	Fri, 10 Apr 2026 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET+FxGEv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DF3009D6;
	Fri, 10 Apr 2026 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789992; cv=none; b=GVIfEhg1GOJm1/CYjnDxPaq+EU97797Owv5NaVQ7Av24pQEX/+NwxQ3Bc42MoKxcJP09pjr9dmFX9tfJScEvnYZjG6J5xhP8WLM6riTWFhYVgovdewRLLXU9usQw5nWt8Li8sOgTVXqcoZeyK+oV5702OpewnG9b+Rc/pkhOYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789992; c=relaxed/simple;
	bh=MLXmBUt+5y/LI0drG1RByAqBpv7xchmUlLNdG+XBJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzVFk6I/YrN73B5QbTqjZMNXfsISdCdRC8pIoFA0qSuOe6ak8gp6Z35rwBQ52TcTuFPGn4v7PoQGQwezlTlQFbgGfDfuHb4fCiymsWLZZNyXOovFvV6cVLAESBBRaJYYNnAr0KoH/4FNaCGClkzLWqmuDDfekwt14L2pwEFfqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET+FxGEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401BEC4CEF7;
	Fri, 10 Apr 2026 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789992;
	bh=MLXmBUt+5y/LI0drG1RByAqBpv7xchmUlLNdG+XBJsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ET+FxGEvFyK5aaK+ipK1ANSh6vQiJyeax0/cD9WmrzLEe2QVyFmRKPWqSObyd+qTJ
	 QSzcUj6m9S1xblsfE44tUvjCAFeYDYC9srazHTj/qsl1mlRTo8vOed9ZeIdSZq6j7D
	 pudl4tcKOjQ2p5tL1gDhD9kNHYDRC4/08SXGsCQlPrs2owo9yVSh3EjVx2JgOqXO5M
	 ajsOf01oae4IUhmEzFaTSw25ZjdD4mYq3oljBQ4Ou3QbodLrpUdlGjyZgIb6Z5XONz
	 IqOPpMtRgIKjzB4McPOuCK5kiTFI53fID9YsKYugOxt2j3/HAkavSgktmlQwtn39rz
	 fVv4wwHryhw8A==
Date: Thu, 9 Apr 2026 19:59:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, Xuegang Lu
 <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v3 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Message-ID: <20260409195950.74e4bc97@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F2473D1A10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026 12:34:05 +0200 Lorenzo Bianconi wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.

Looks like this driver uses page pool.
If you're sharing the same page pool across multiple netdevs
it must not be linked to a netdev.

