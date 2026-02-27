Return-Path: <netdev+bounces-261825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC6qM1l/oWkUtgQAu9opvQ
	(envelope-from <netdev+bounces-261825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:26:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B81B6892
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5140A3013CB9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F53EF0B8;
	Fri, 27 Feb 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ity7D1Zy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vHcNRTfM"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B313EF0D6;
	Fri, 27 Feb 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191570; cv=none; b=E9h1hAw0j+aYg21Rwmq6p8NrHB0L88gtRgLmA/3B73Gq/5bJZauiuoFYEUg9P3pfMLSzBNW9N5m2eZBBZgeSk1PtHvKXKCb0eY+bjsJTbIoUu50TTXZA2l1ehdRbOnOC/RibKPCWbWynSvrJy20Xc+04cMrPJhRJaxVcjHBxlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191570; c=relaxed/simple;
	bh=ElIUIhJIkwzPaCL3/+UdjS/gFyvlfx2rtT+AE1WHC6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYLqb1RgkL2r1aZN70Pfz4KKb2gvyorluGCGfw5GOmlxQg1qpLiDraYedHmhY5XtzkmOHyubWEn7j1DWCV+xunDsrw3Or4oGak6xldqL+nIN2gSfG+gIBgYYRjJ2qGv/W5M+oMLAv7f1unvdRpXzM9azliFYC49xxZ/kgnYQkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ity7D1Zy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vHcNRTfM; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA2677A022A;
	Fri, 27 Feb 2026 06:26:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Feb 2026 06:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772191564; x=
	1772277964; bh=14vtuXga+oTI4F3rS16mlIwKvS9B5UtXd6fMPufamT0=; b=I
	ty7D1ZywjI4H45wD+pLjVtwyOtyw++BaYGH8yX2YMn7bfLdkIp603BIIgRTpUBfU
	mSL6ffh835qLALzIVAnnwyqcA3NlAWFTvzHIgo/MiEbFnbZFUM4yJOhanXeQdzjg
	WlaRwNLyJlMOkNu3MdOUJvASfQKg7WmCH545kCI0yQlCYPQrCax9D+vmi5+H5VZC
	/spqL2oWRfSTWs25eX10SBUSTiFoPff8q8r7sAY/Ml9mCrvsnlukcWHekihyw16j
	5e3hVkKSvR8zK/9PuO/Akb4DTCeks4zwEo+NJEBwn5bhX3y8S+cI7Eqz5kWGS19b
	l38+WsN9YFN97r5YrETTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772191564; x=1772277964; bh=14vtuXga+oTI4F3rS16mlIwKvS9B5UtXd6f
	MPufamT0=; b=vHcNRTfMBs10gILL/ZgKDqVvRTv479Z+ol7z+trn5qeEmW75cox
	KsKSasPKV2NOvGjmP0OA0Ajle+hxlIJmpa0rDZml5xdc/+iXUL8612CHWU5pKI+S
	xfonLJSo4/WLvYukCGWhxoo0JDRPI5eLN02j5JFuJ/fq3JMk9MTgwVo4aD+2l6d/
	so4BJhy1VlfzV4i1xXWEiuXDfSSraRY0YgXoBX4PoXmSXKXg4COzamiG95aahBfs
	qMXf0ekbW8jTm3JfI9H2EMNL5mWGw7stmczOJREqvJRfOvANUqty0T0nqUlrlSYy
	y4mEQAwADzwZicILqFx1+F8+5zr0svX/nOA==
X-ME-Sender: <xms:Sn-haQTqub1ykclpG1cocW51Hdze_XrN9K8YlFe2_m1RUquKgl1vGA>
    <xme:Sn-hafLSMma_mp01rd418QdGWNRekE3MRLpwD5avH6Dn0KdNQ3hT3lhAbUAvd9WpN
    msoyxqGq4F-QsxNSFJwX_FeE2IduwrRoIPGzOqtIS7HT8713bGcz9U>
X-ME-Received: <xmr:Sn-haXH89xujpY6HLhp3BcGZYToQj3hFLqx5cy8485Dy_YhHarLIsiKfMvgh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepvghvihhtrgihrghnsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegrnhhtohhnhidrrghnthhonhihsehsvggtuhhnvghtrdgtohhm
    pdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtoh
    hmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgr
    uhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Sn-hacS4hm9n3kv7gI5VPyISXKf8plGzFKzX31DQeglAcA81zVNg7Q>
    <xmx:Sn-haQXNsuilRaPiuZBKA1Qq9eNyd1xBMs1m_4WmnbAL7bKvJOZLoQ>
    <xmx:Sn-habgm0yOJK834bmrVIrlXd2Zzr0KdJMo1pP8nn3PREUrpF7li1g>
    <xmx:Sn-haZceQOm-0uzK0oMf7Ogl7hq-RtTrFkntOQ5hn2TmcAqO6G1uFA>
    <xmx:TH-haToiCUSF3w0kxYf3-1_ezkBx-jYqTF-CvsfkFUyppzS0VpUk_w_2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 06:26:01 -0500 (EST)
Date: Fri, 27 Feb 2026 12:26:00 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Yan Yan <evitayan@google.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, Nathan Harold <nharold@google.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aaF_SAQj4WT8jRaO@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261825-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,linux-ipsec.org,paul-moore.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B68B81B6892
X-Rspamd-Action: no action

2026-02-26, 17:44:51 -0800, Yan Yan via Devel wrote:
> Hi Antony,
> 
> May I request that we also support updating the XFRMA_SET_MARK as part
> of the new XFRM_MSG_MIGRATE_STATE message?
> 
> In Android, the primary use case for migration is switching the
> underlying physical network for an IPsec tunnel (e.g. VPN, Wifi
> calling). Currently, due to the limits of XFRM_MSG_MIGRATE, we are
> forced to use a separate UPDSA call to update the set-mark. Supporting
> XFRMA_SET_MARK within the migrate message would allow us to update the
> addresses and the routing mark together in one atomic call.
> 
> Regarding the logic, I believe the set-mark can follow the same
> omit-to-clear pattern as XFRMA_ENCAP and XFRMA_OFFLOAD_DEV.

I think this raises a wider question: clearly definining and
documenting which attributes need to be explicitly provided
("omit-to-clear" as you write), and which will be implicitly copied.

Currently it looks like we copy:
 - all the crypto stuff (aalg/aead/etc)
 - security context stuff
 - coaddr
 - replay/replay_esn
 - pcpu_num, if_id, tfcpad
 - dir
 - mark
 - extra_flags

but not
 - nat_keepalive_interval
 - offload
 - encap

[gathered from a quick read of xfrm_state_clone_and_setup + the
definition of xfrma_policy]

Anything that we leave as implicit copy will have to be "forever"
implicitly copied with this new MIGRATE_STATE op -- unless we find a
way to pass a new "clear these properties" flag (probably via a list
of XFRMA_* attribute names), but then we could also implement that
with the existing MIGRATE code.

-- 
Sabrina

