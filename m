Return-Path: <netdev+bounces-291006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJxvB5sKEWoVgwYAu9opvQ
	(envelope-from <netdev+bounces-291006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:02:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A93165BC6D9
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2DFB300BBA9
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F71DD889;
	Sat, 23 May 2026 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POFxUF9R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E042AB7;
	Sat, 23 May 2026 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501720; cv=none; b=BlthrAkoxO626VQxSXeGRoLlPOW14ov2Uv6Y4UNefzGiFEawNGIz/N1niwHvxRdZj3SKRQQDUj45f5upPnqWS9m3AYvImpn+Yy6mQAZW9EpWMCEqh/rPZzdJFAExVb615lRreNwiZMCuuy8NRWiByK3a/4op5dwIrcVoKtetwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501720; c=relaxed/simple;
	bh=E4HbN/Zm5NwpqBSXqKBpQ21+E30whduckc6SCmpCLzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjWwnSfW3Ow5zAkQdnk7gjraj2CCZZ+HDshz2DXuYrZ8bONACIgB7oGNcCwCoMYQNsbJ6cnWY8DjR+YTOEAFKArEaDYKe62zeaKZzVvKdXyoabajrYtKnjiZilFY/WYzIhuTIgapQIHiM7BfxwzQE9USSAZ0oZygyGoyDchtYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POFxUF9R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4871F000E9;
	Sat, 23 May 2026 02:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779501719;
	bh=E4HbN/Zm5NwpqBSXqKBpQ21+E30whduckc6SCmpCLzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=POFxUF9RQV3lNgBwJeeqntDwAJP08HxOSPylrRoqiYNK43RreGrQrodnBjYfiBhNL
	 piYXxG4wkS1rzlvMMdw2qVZM7v69CuwPKxwzPY8ZIuBxQKDtM1+ftMIKv7Rv0mXMSM
	 yV4PRg9Hy2+aHfqdwUJvBaJ/kbThv89i5CxrEIhMRJUoF2t1VmOmFp5Zkf1PTucDPQ
	 06LXn2DOsuki8zM7AFa50FXCmPAQInkrVi5sMaVDwpusYr439aSLgUwcrmJRqTVmrm
	 6fh8gSrdtn+yYoTGm21A9nKTO7T9zFdzgnWDfSjRD22cvrNDvxOlw2igZ2eP/oguFV
	 9OLL7cruxqLIw==
Date: Fri, 22 May 2026 19:01:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Steen
 Hegelund <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
 "Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Herve Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 12/13] misc: lan966x-pci: dts: extend cpu
 reg to cover PCIE DBI space
Message-ID: <20260522190157.02e1e3ff@kernel.org>
In-Reply-To: <20260520-lan966x-pci-fdma-v5-12-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
	<20260520-lan966x-pci-fdma-v5-12-ca56197ae05b@microchip.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,microchip.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A93165BC6D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 10:12:24 +0200 Daniel Machon wrote:
> The ATU outbound windows used by the FDMA engine are programmed through
> registers at offset 0x400000+, which falls outside the current cpu reg
> mapping. Extend the cpu reg size from 0x100000 (1MB) to 0x800000 (8MB)
> to cover the full PCIE DBI and iATU register space.

Are we supposed to take these to net-next ?

