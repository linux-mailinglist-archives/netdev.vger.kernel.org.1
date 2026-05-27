Return-Path: <netdev+bounces-292252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BLjLOfPFmowsgcAu9opvQ
	(envelope-from <netdev+bounces-292252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:05:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00535E3117
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21DEB30095F6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71433E9580;
	Wed, 27 May 2026 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="izVqxEVt"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A28F7D;
	Wed, 27 May 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879899; cv=none; b=sahtCxhpmtYJsacAr3G7JID1VVzMH5t/ObAAHUF6w0IjuLFrH9wWuiwr+wi+NmhgbZhOWk7L7jh8jw9yPzJSwP79ZwhDNJl8Zkofq8RGtfIdCr2MSJjOiHOr2c2zsCFxHtLX19+wq57RRDAf/BSILs3HIOV5AHgCKfIOKEvJ9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879899; c=relaxed/simple;
	bh=o0xh171fdwD+9c0xRLYHo8tZ/vQg88T8RsWQ3V606Ag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H1d498rgziKeNYtj5QpFAJazR+LoHkDox6umn1micRjvn0RKUSoEiMk+msE/5plpQJhKtlE7TVmMwUDcSIU1ZAw7TlNNdffzVaqRVsXownACeSm5twWa6zZOCdg+RGPX5uSeKN2KAmrmTE2Y5a+aqSPWVEqMxp3y596EtBcHXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=izVqxEVt; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64RB4Leo009199
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 12:04:24 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64RB4Leo009199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779879869; bh=o0xh171fdwD+9c0xRLYHo8tZ/vQg88T8RsWQ3V606Ag=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=izVqxEVtUheC+mWoTFjcYaAwvzv7aTvikcq5JRePD1sZ6SxPSSS5HVg892VJkZYS0
	 yv1y62Ju+cqa/M9Edj7S2O6bZaVivkELahmfGINZSyh9NPY9KkiQrZEo7RFkWgFGK+
	 VHtvS6w2ppYeaf1CMTP4TLE/WzRLA0ZIyZsDTx/pra/ch0yp2xPaUqLbFMsBJWIL/Q
	 moYi8E1LUtECViXmuzhtJbuk5cRO+UxAe9lNUMSYdINEjGCfqYVFtb5jq67dBsOKI7
	 1qWd6qHtHaNLSNjEnA2bhqZnKfsBb4ooNyqZrk0b06++YTb5nOyznkS6Ee39Y0ent3
	 Db8SAoRU4YZTA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 5/6] net: dsa: mv88e6xxx: CBS support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <CABvLYuAYBwbJbNwhTQi=aJ=APdQekVBELog=tyDO3deAr16o=g@mail.gmail.com>
Date: Wed, 27 May 2026 21:04:10 +1000
Cc: netdev@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74040510-EFB6-4BCA-9818-46168CB7014E@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
 <b4279a06b836da86ad0c0137c3a6989a99241427.1779841530.git.lukeh@padl.com>
 <CABvLYuAYBwbJbNwhTQi=aJ=APdQekVBELog=tyDO3deAr16o=g@mail.gmail.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	DMARC_DNSFAIL(0.00)[padl.com : query timed out];
	NEURAL_HAM(-0.00)[-0.821];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F00535E3117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Why is the avb_mode set from the cbs setter?
> avb_mode is an ingress setting that controls if frames are classified =
as
> AVB frames. Cbs configures shaping on egress.
> Eg. if an AVB stream is received on port 1 and is forwarded by the =
switch to
> port 2. AvbMode needs to be set on port 1 and cbs is configured on =
port 2.

Sounds like a bug which might explain why enhanced/secure mode didn=E2=80=99=
t work when I last tested it :)

I think it might make sense to have CBS just configure the shaper/strict =
priority (i.e. as your patch does), and then only enable AVB mode if the =
shaper TC has a MQPRIO parent (retaining the mapping of TCs to AVB =
classes).=

