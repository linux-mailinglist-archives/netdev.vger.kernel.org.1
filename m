Return-Path: <netdev+bounces-285208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAOsKTJd/Gm7OwAAu9opvQ
	(envelope-from <netdev+bounces-285208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F84E6131
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7574A30485C3
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189223C3455;
	Thu,  7 May 2026 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GjG6WYOa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSmAboNV"
X-Original-To: netdev@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0D38E5C4;
	Thu,  7 May 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146394; cv=none; b=CvK6oG9z/Ybtrx6mnfn/8G9oGbeTYb9QppPbGwNQCt7ngYNVaGkmGDgiSCn/+P1ISysENlHEfaWVmX4oc0g15Dnzv7mt7hpiJPmKNvct10v4xcxBHxlf8CxCjO4t/6B3BIocrlvFcPEYast5xArgW6d0mnum+YlB7QdMfNSeZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146394; c=relaxed/simple;
	bh=qTI+rCfckoAaQfgJ9BckzMl347yOt6lcc7PBTWgdJiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd72DBK2RY5o1lLtYaD4hkV31pq05QsXs/tOcJSFkcz2Z2w2/l1Y9hOE+k7tvbTSHxf4SQk2+/U6PUtt5rN75GY9lRTyaUqbnTQljN5uFARrFDL6nWTSUk6fOxlEGcD8pxURAdSpifoBWlZ0RIb9pBvwpGXBwIYa5bgin2eLdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GjG6WYOa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSmAboNV; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id AC061138003F;
	Thu,  7 May 2026 05:33:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 05:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778146391; x=
	1778153591; bh=7b++wZS149+bDBFrMI31xSpECQLGsVLRHFUW6GY5gX8=; b=G
	jG6WYOaJRcFkli26MfJAoVLrOMn58VQLv0VWjQX/gc4dmIL6ameL6f5lRVdnO2Sa
	Bbpkb/MAwc49daRKCBRsPHOxtMMK4DdHFqNpMHOBEAHanrkYW/zlgLo21LUk4vZ8
	FjqhiwgHq37jxMgnagl86tnfaNE03pbF/U4SKPsWpqd1xIUNNUd9nNZbnE3/DjmZ
	ltMEpvZMY+YJZ18mHq70obxVITywgnsVW28F07DmuBX3X7ZCt7EiRfzJ2mhxFSBa
	l9Z53I8nY3PDPcqE9u0ORPGCkkHfm85vZbUmYDluPcQu0xObQt+rLXMDoqCcT2Oc
	YPNiJO5WhiMn7On446bxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778146391; x=1778153591; bh=7b++wZS149+bDBFrMI31xSpECQLGsVLRHFU
	W6GY5gX8=; b=lSmAboNVt6YB3O2pN62qiwXYnv4z+/OziUfFk2YpdY5d6iJR5sW
	Df5O+5+0Hq58YNjImPuyscSKGkZ0qm4XD/2YQDum7tB/ucBBtxWuySjwLaHszQe/
	oJMNG9ZHJ5y2BMJKc7OBGOGl0sb+u9+O45XN81clGxICFZEK/qISHtxypUb6DaZM
	BgFyc+yWaNrlv1Zcia4pKBlSOUuLta5A3Zv1mcSO941YpTDOnLxl4lsJHOnwgOr8
	O+byfKXW3YlEMIpwE1TRbvIEX3XfvdlW7EjYxebcewm/wokgXHv3zTsl3xGHU70h
	+bjwpEKP00hzmq5bbPbFQbLrSsOXOiVU+/g==
X-ME-Sender: <xms:Vlz8aRzNTAyCeWq5FimU9mXfG3pH1IaexilG5MuDutaQWMpoOo9eyQ>
    <xme:Vlz8aS6Ek7Bz6lLVWUeJBZJuY1xrVXzLlLS3bDrXHqyidQ2TIRg56qQsTzFuQsFH7
    RcWPPKPhr0Jx9-yNno8AASJpZZzWKjuTa4nCvB-37jvDiQtFRn3RFpg>
X-ME-Received: <xmr:Vlz8afaAutwLW73z-Cg3NvDP4jGJXwg375qEomtR1uP7L16gIYMRDsF8nPmJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:V1z8aZ-TH4icunXsbymIpsZAZCcGCuoy-V3KqhmUoJl891ZDunGoBQ>
    <xmx:V1z8aR9RoRpxzI2okencdUtKZvib01IpsfBFVT1qkEyDJp_lMYracA>
    <xmx:V1z8aalXdvKMlMmrkG9FXHWBCv5OqOTaoX-VLxZVkJBsewl8ixUgmQ>
    <xmx:V1z8ack5HUW5fMU6OYO4uZK02__0LFTo16O6H-wcB0OuHILJKSZnhQ>
    <xmx:V1z8abbzHQabRLWM_ggYEDsX3FPh9WlLMXTAzTAfOLuuxW6cxB6pqWi7>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 05:33:10 -0400 (EDT)
Date: Thu, 7 May 2026 11:33:09 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v8 04/14] xfrm: fix NAT-related field
 inheritance in SA migration
Message-ID: <afxcVV83k7CxImwC@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-4-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-4-4578fb016965@secunet.com>
X-Rspamd-Queue-Id: 6A3F84E6131
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285208-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,linux-ipsec.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,queasysnail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-05-05, 06:32:43 +0200, Antony Antony wrote:
> During SA migration via xfrm_state_clone_and_setup(),
> nat_keepalive_interval was silently dropped and never copied to the new
> SA. mapping_maxage was unconditionally copied even when migrating to a
> non-encapsulated SA.

mapping_maxage should be harmless (0/unused on non-encap), but I think
migrating nat_keepalive_interval should be considered a fix:

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")

(maybe even split out of this series, but that would cause a conflict
with the previous patch)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

