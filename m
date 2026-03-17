Return-Path: <netdev+bounces-268654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLmnM/tvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271E2ACC7A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D747302B4CA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C223EBF08;
	Tue, 17 Mar 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="td5453Yu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdSVKj3D"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255B3EB818;
	Tue, 17 Mar 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760483; cv=none; b=rqbRE/FX5hyJ3/pjlbZyfPWgW08uHKdR8BqI1kFUqQmuMx6hVBVoImyzJF2pozIXecy1SR1NqnxkPiiR6GefEybNhzTtyHjufaukEH8PQyZmAKGN31yEMFXXfzLRJ5rRuVd03KoSX2jH6NIk5MbzUyn1FXy7BZbVVcjVoGm7Ii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760483; c=relaxed/simple;
	bh=D3y2WhnSJvE+wz/GFNo8yJ60vU7+uLn4ADUTqegr0Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBY0mAm6dqrMEfJaBj9O/4grDsDbM9B1lSANDIIdxCLjz+XFXk7Mo5zt8/wsVXxiQeqfDq0jkfcTCsMdHB/CuKIldW8S46U8DEVO+C/qxm5RoZVsb4F+Dtt1pZQ17mxr9s2rcqnozxK00hbxVxNw9JWiOqZ0bRD4dVNIxLX2vew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=td5453Yu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdSVKj3D; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FA467A003A;
	Tue, 17 Mar 2026 11:14:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 17 Mar 2026 11:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773760479; x=
	1773846879; bh=62Hd5sMxPyXCHbiWA7pjRcn1UXJoQVCZ08Ew47em6gU=; b=t
	d5453YulURXgjrTxnWAD+J9En6qLW5sK4Z0FxJcBu5R5Pr+xQHVMpCtyundg1rt9
	Yo1mfaBazkE01OskmuMMGE3NcakSh6cv83n0yfxQCXTueWnQE4X6yDWztLOa5ueD
	Ek4drKCPPaq1Cxb1UrZ677cwdM1fXK2cOWRmdysg+YrMUFhAZR50MiCgUltCc5/C
	GMrnm4WQmJspUamp7tDzyFqFqJaBkIP3Hb8GJZ3B20fVA4Xhq5GqO2NFrYUk/k07
	UbKIoXN07+A8iUl3hhThzkhpolXqFM/TAFqmdcxJAFNPucyN/Ndtd74574RZzhfQ
	Wuwuh1CnZfusx3jyq2Dyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773760479; x=1773846879; bh=62Hd5sMxPyXCHbiWA7pjRcn1UXJoQVCZ08E
	w47em6gU=; b=qdSVKj3DgfbAjvr+hBkRZUx2PWZ3Pzb5q5SEM0dXGThkiTre8jk
	tEAdqFR83ZuhQwyDdc7e4kGifIqHJKmXF88MHfO34y/TxS1sD861ggcZIq2zzPM/
	n/p0RFNnkQNaUNO+aGTRGCK3hPBL436Ze9KkguILqEQvULX58hQO13M1mpQqB3NV
	oTI1mXmM8bnPsEOdAS0cSBPDuQ4Mb7O+y4b03jtlLymeYLlimc2Y8VIpiNY5gMzO
	OHsT4xFSAX/jjOvDVupO4Wjmu32cp628dbg4nmX/m0SkukgXNNXdUY5VkwnSghoZ
	vX20ad+Z7i2urZusFztgpGQqdby2fZUR+Fw==
X-ME-Sender: <xms:3m-5aakSndrvQjFvGMuy1zz8mH1JwGg36qBXhXceGeOC28I-NN79tg>
    <xme:3m-5aRTs1xBAKUTO4LmRfuu9K7_WXtQDNLNGuQ22IZODHiMRQCX3YkeN31uPRQtW3
    fAtw8thIsjUI5pAF-sj5h7iUN7omnrXwxE18AqgMyguxl-wroutW3s>
X-ME-Received: <xmr:3m-5aZuBpLiWNjwM-iwKpridktg1IfOPx5TtX4kqmuxvjFL2Co4o7Dp8GK6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhn
    uhhllhhirdhushdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:3m-5aS7kCoOXOjg9oWl-PVQgB9yeL6XMenODRIwGU2AYwU0wS-fCqg>
    <xmx:3m-5acjr7zNu0uqiZ42p4mZAYYnD_UJUGYYomlfeoQMFQ3WnjVEGkQ>
    <xmx:3m-5acnj7s12UZfJ5RnW5awDno8Om9vzBJtGkXrwx07zzCa9JAFUVQ>
    <xmx:3m-5aTudVLXnm-CrZIUSWkgBE_dTzvzDTw-alMV5ErKzrR09PLdlEg>
    <xmx:32-5aY4OIfWFph7Scuaor0Ymv7sQaAFN3QKJ6kMISZlsnP7RmRnAHfyI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 11:14:37 -0400 (EDT)
Date: Tue, 17 Mar 2026 16:14:35 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Message-ID: <ablv266AIETvJwpP@krikkit>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268654-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 5271E2ACC7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-16, 12:26:09 +0800, Hangbin Liu wrote:
> Add a new ndo_update_offloads callback to net_device_ops that allows
> devices to compute and update their offload features during feature
> updates.
> 
> This callback enables master devices to recompute their features
> based on current slave device configuration. This is particularly
> useful for bonding, bridging, team, and failover devices that need
> to aggregate features from their lower devices.
> 
> The callback is optional and only implemented by devices that need
> dynamic offload feature computation.

Maybe a dumb idea (and sorry to suggest this quite late in your
submissions): since all implementations of this callback are only
calling netdev_compute_master_upper_features(), does this need to be a
new ndo, or could this be some kind of flag within struct net_device
(2 flags since netdev_compute_master_upper_features takes a bool
argument) that changes __netdev_update_features()'s behavior? Since
the goal for the netdev_compute_master_upper_features() work was to
make this code more common, not introducing a new ndo where random
hacks can accumulate separately in each driver would maybe make more
sense?

-- 
Sabrina

