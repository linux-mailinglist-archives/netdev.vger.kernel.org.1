Return-Path: <netdev+bounces-296409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rNoGIrF8JmosXQIAu9opvQ
	(envelope-from <netdev+bounces-296409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:26:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F4654036
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:26:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=SoxPgps0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296409-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0EA03016D9C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7E3A2E12;
	Mon,  8 Jun 2026 08:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE70345750
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:15:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906551; cv=none; b=SzYHCMNcT9p5rKOekDrcLmnMVso6XWLmWYdI88Go0QjL5bZLL4U8Owz1OUAgFRgeIfnQVzALsCZUSEz5Kvorsl1ezkis33WCe3HbpKWTRIk0Emc+ARhAUX5eBliaWxCneovvlgc1JNHZaQ5q73f3Zm4M+gGhQxoBhNnBrT5Dk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906551; c=relaxed/simple;
	bh=DcWadGp36DQpE98g7D9YRzqZr5H8WVrf8+uT2zyU5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=AX9hTY1osTiE51PVHmD6lHbHR4bDq2zfC/GJ6wdwe5PZOiMJbY8VZ/KjSiLg8KPBYd8ku2630lxZ6o2jMBh00fNyw82LOol0VlGJpWeG6pVaR/dXId6IVglMZuNY+FPoGvDqCOGifwYeFgEuFA3c+rTiCdbyTuw/hwLyfkyW6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SoxPgps0; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260608081541euoutp02abdf427e623ec76b10503f280e1dd487~3DRBnu68r1438314383euoutp02g
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260608081541euoutp02abdf427e623ec76b10503f280e1dd487~3DRBnu68r1438314383euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780906541;
	bh=DAy3x7sE043+BulJ2HvUrKnkJ0tG7JG7e7woKSNY+bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SoxPgps0WIiMPyOV0Qxq43MFyt31BqySQBk4qS/kLHtRaqvU6CRy1lCanIw/RYrti
	 6ULs/UtTTJ9gzDLCkNqt/Cl2AHho2i96AvWC8Zt9D6JzCY+ciwEWh8ahmisvoDiRf2
	 KECL/7hrEv3YZpg0vv30DxwiTlEHuXW9yxjCBaec=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260608081541eucas1p2115e23d320b726c9e3ee410121f67ba3~3DRBbTSgB2574025740eucas1p2u;
	Mon,  8 Jun 2026 08:15:41 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608081540eusmtip2bbe6b019cead0d739c1e4a413b1aa92a~3DRAz6O0b0470904709eusmtip2f;
	Mon,  8 Jun 2026 08:15:40 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:15:31 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/sun: Fix multiple typos in comments
Message-ID: <aiZ6I6XeCzJPpKQh@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260603192129.53f9ca9b@kernel.org>
X-CMS-MailID: 20260608081541eucas1p2115e23d320b726c9e3ee410121f67ba3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10ad1_"
X-RootMTR: 20260601163737eucas1p19d7a2bf830568053314738a191cbd591
X-EPHeader: CA
X-CMS-RootMailID: 20260601163737eucas1p19d7a2bf830568053314738a191cbd591
References: <CGME20260601163737eucas1p19d7a2bf830568053314738a191cbd591@eucas1p1.samsung.com>
	<20260601163727.554364-1-j.raczynski@samsung.com>
	<20260603192129.53f9ca9b@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 093F4654036

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10ad1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Jun 03, 2026 at 07:21:29PM -0700, Jakub Kicinski wrote:
> On Mon,  1 Jun 2026 18:37:27 +0200 Jakub Raczynski wrote:
> > there is no reason not to fix them.
> 
> Time needed to process these patches (you are at v3?!) and space in git
> history are two reasons that come to mind. These are ancient drivers.
> The most action these files will see in the future is git rm..
> 
> I'll apply but please try to adjust the compass a little more towards
> actively used code.
> 
Yea, that was waste of your time, sorry.

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10ad1_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10ad1_--

