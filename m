Return-Path: <netdev+bounces-277212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBJEIPJm2Gm1cwgAu9opvQ
	(envelope-from <netdev+bounces-277212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:56:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B0F3D1999
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58477300BCB7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B03009D6;
	Fri, 10 Apr 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0PBCj58"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8B13D53C;
	Fri, 10 Apr 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789807; cv=none; b=Jiw5rzC0H8Gx3TFZp4aBl3CMLlBpATdJWo2ZM9fEmwf9iZuvioEEhtNG9W7MNNkdXSvnZ1S9M8vDbbd7gw/hLHjMfl2mqsPZIrsJXwvSDDJ/Ah5FwzdFdV7qm+dp8whBRafryhyJL/XlxdaetZyUJNfNj/T6gQoLIsNVp9PMqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789807; c=relaxed/simple;
	bh=B9kpSbJJ5ghjv9xGYI9AfenQBYv+RQ6JZSeUfjkeTW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+UONJ0oX9Fht77O4YSNrbbgBJoElnv2OML7uhxlGXC4gTLYPX3HMLigKK2eq+xoJv64EQUl2M3gRYfAB7/fcz90xog1M8MiO8/sse4MLPMcTUG5Ob+ttPcl37yov2qBjpP7xkOik7HAooK1T2T4gj0XaoWj3fkk7T1t9LKarnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0PBCj58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FA2C4CEF7;
	Fri, 10 Apr 2026 02:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789807;
	bh=B9kpSbJJ5ghjv9xGYI9AfenQBYv+RQ6JZSeUfjkeTW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j0PBCj5804Oi5magRfTOBgMi/tGqroy9tnJC5VzMthMJAIwT1slg/7krpIJFdCRvN
	 /EiROl2kPERgWlqviiKXYbI9zRvlgwANO7CQhfOQHKXmb1poBTD5qJpfjPpyqaMQQE
	 Asx44P5Izpwq691fu3Ndh3F9qYAOfxqNKptg45+hXVoC3kNUwbhiu6R/zZNzVa4Dzb
	 rh2FsVJfXmmaup2N5YXjZo4rsUD8DjGsgkNLGOkJS2Td3jTovdsphi94IUkJvwIHWr
	 0hpic6bEjTuVxXv7MXBXFpux2PHELaVuNNnfVWZ6F6lf9C9bRriR/g0r5z9/qpk7VT
	 cqeDiYniRnqhg==
Date: Thu, 9 Apr 2026 19:56:45 -0700
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
Message-ID: <20260409195645.16c68979@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277212-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4B0F3D1999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026 12:34:05 +0200 Lorenzo Bianconi wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.

Still waiting for the device tree review. I'm going to blindly send out
the Sashiko review, please comment if any of it makes sense?

