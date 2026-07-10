Return-Path: <netdev+bounces-306461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lDYrLzutUGor3QIAu9opvQ
	(envelope-from <netdev+bounces-306461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:28:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7A73875A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:28:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=SYXdhwf6;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306461-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306461-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EADB73035CEE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B63EFFC3;
	Fri, 10 Jul 2026 08:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B593DCDBC;
	Fri, 10 Jul 2026 08:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671669; cv=none; b=XdkL+eh//MiAeShwaGBY1jFsDddW8ybPALsvugQSJrUWle0p9EGClcVFTAEbaKiuDTawDmrfqmuPBJs21XrqAxDs7pLlBI/XjB2fTgUalJieXUY+bN3mp0FtRZvf1sp2xjzxUZv8q2YD0Em/9cfwneBLObD34/t/3uhlj6Ltxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671669; c=relaxed/simple;
	bh=AKDaVCfJi39Tgs/2h1ZaZCW7yPhT+bWU0gjLilWomb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU/iUSbj51cvQdgn6jQNxDn0AaQNmwvBmJ6NYD1IkX58LqCqSv5EkVG0kYK8QOIldm4oW9qhpRVVt701ypgEmkM3JuXwkt4kDEFL6uBatXTbVH9mSHBJY1bJa7GKe8a1XKPA0uhiM+GjrbqHkLApMna1HlbxGLzYjqLpadSq1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SYXdhwf6; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PLGhazUsM5CoDJX0gMbB8JmKh1fkD9xEB4wGjBKRQtk=; b=SYXdhwf6TnLG74rt3BsGAN1Jnu
	8XeUOLT9UP7PIRK7VMt2N5WOjEdBZAiJi83YQ7Sfayyr9ydhbMTHZSoQrtORqBGBL1SqTOWxczJdp
	zG0TPEe3qswltJhH6XxIiAntv+LH6NEsmt4u5XrIXny5kQ+l7G9qrvm+rjO7mtaHdj/JVKCYGvtkg
	iju1OXKW9CdG4su1GyGWuzGKjj5SlAjjr7FhmmtJD7Djj+PKyDfyoHeSyhBSEVoCDdQnxUrGymxjR
	UefwOZO2aK1UiJDyQNm1SsnfR8HfktgVBhqCQjqqARpcXyDYbP3I6wyJ1ebFoUqEfjxQw7WBQCN58
	4LALyksQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi6Tj-004LW4-2A;
	Fri, 10 Jul 2026 08:21:00 +0000
Date: Fri, 10 Jul 2026 01:20:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Illusion Wang <Illusion.Wang@nebula-matrix.com>
Cc: Dimon <dimon.zhao@nebula-matrix.com>, 
	Alvin <alvin.wang@nebula-matrix.com>, Sam <sam.chen@nebula-matrix.com>, 
	netdev <netdev@vger.kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>, 
	kuba <kuba@kernel.org>, horms <horms@kernel.org>, linux-doc <linux-doc@vger.kernel.org>, 
	pabeni <pabeni@redhat.com>, "vadim.fedorenko" <vadim.fedorenko@linux.dev>, 
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>, edumazet <edumazet@google.com>, 
	enelsonmoore <enelsonmoore@gmail.com>, skhan <skhan@linuxfoundation.org>, 
	hkallweit1 <hkallweit1@gmail.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIIHYyMSBuZXQtbmV4?= =?utf-8?Q?t?=
 01/12] net/nebula-matrix: add minimum nbl build framework
Message-ID: <alCrVABK5CLd57e8@gmail.com>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
 <20260708064742.35391-2-illusion.wang@nebula-matrix.com>
 <ak5sjL21NQSWDB9S@gmail.com>
 <25d3ffc3-6f45-4baf-9c3c-ff075de14778.Illusion.Wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d3ffc3-6f45-4baf-9c3c-ff075de14778.Illusion.Wang@nebula-matrix.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306461-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Illusion.Wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nebula-matrix.com:url,nebula-matrix.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAD7A73875A

On Fri, Jul 10, 2026 at 10:45:15AM +0800, Illusion Wang wrote:
> >> From: illusion wang <illusion.wang@nebula-matrix.com>
> >> +Support
> >> +=======
> >> +
> >> +For more information about m18110-NIC/m18000-NIC, please visit the following URL:
> >> +https://www.nebula-matrix.com/
> >
> >Do you have a link for the site in english?
> 
> >Thanks
> 
> Sorry, I will fix this in the next revision of the patch series.
> Our official English product page is available at:
> https://www.nebula-matrix.com/snic_s1000_en
> The S1000 series products are based on the m18000 chip family,
> and you can find full NIC product introductions on this page.

Thanks, that is what I was looking for. Please use the english like
above.

