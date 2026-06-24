Return-Path: <netdev+bounces-301785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VbwAIvRSPGqWmggAu9opvQ
	(envelope-from <netdev+bounces-301785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:58:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A46C1A3C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:58:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=vXijjovM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301785-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301785-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF3CF302DFB9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698828C5CB;
	Wed, 24 Jun 2026 21:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6E1A5B8C;
	Wed, 24 Jun 2026 21:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338177; cv=none; b=tYq4tjXEi7IRLWJEzo+zTBguanE13zRD7o1HRdOjUS02sIVyk6mrALJc6chEvZsiOcX6LRAMLOBkOgXpeghLoVobzYBJDKI0xlfVQHC3wd6gYi7KivPm8/2+DruciUPY/ygeKk78vAHAuotBaLXg/Q0KgVMvK215VhNQig52JrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338177; c=relaxed/simple;
	bh=LasahKFSXLBITBWRPsBXLd1ni40lQOnTMOoyA03O2Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+Jqe8rVpdUu+WJQ0usLDlwq/O9yuaVH75mCaYH69uucYRXbt3P2KUhPSkOZAx43FLECh7JXid/5ZtvdU90xBkwBzG9z48YzqfJf51hehrD1sg+1Iu9eQXxXtZWYzW5TzIpMv7jhllLLBPbkqm0BUBXEerdOAucpfV978mljw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vXijjovM; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qSla3jeK98XNsFZZwT6BxJJ0v52d6+uUp75wrdA60zE=; b=vXijjovMNj8CzyxZ3IQloFgNnG
	AieQK3gqgHrnUz4YDQNpy8zZo0mFi2yZ5xG9qwYH3RnZHY98Lvz+gD2PIRomoMXxeII8jG0VwFVsu
	7EqGriay+Qj+GD3cycIIIf6NBhVriGqhd8dli/+/eB3Lg+F9YHSytffDPpDIgtarqaBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcVZo-0099J8-BJ; Wed, 24 Jun 2026 23:56:08 +0200
Date: Wed, 24 Jun 2026 23:56:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zinc Lim <limzhineng2@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	alexander.duyck@gmail.com, kernel-team@meta.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zinclim@meta.com
Subject: Re: [PATCH net] eth: fbnic: fix race between concurrent hwmon sensor
 reads
Message-ID: <f2ecb668-ec56-4c84-ac97-474a2d761005@lunn.ch>
References: <20260624200514.1332788-1-zinclim@meta.com>
 <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:limzhineng2@gmail.com,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:alexander.duyck@gmail.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zinclim@meta.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,meta.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E48A46C1A3C

On Wed, Jun 24, 2026 at 11:51:29PM +0200, Andrew Lunn wrote:
> On Wed, Jun 24, 2026 at 01:05:14PM -0700, Zinc Lim wrote:
> > From: Zinc Lim <limzhineng2@gmail.com>
> > 
> > Reading an hwmon sensor
> 
> Since this is a hwmon related patch, it is a good idea to Cc: the
> hwmon Maintainer.
> 
> I don't know hwmon too well, i've never had to look at locking, but...
> 
> static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> {
> 	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
> 	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
> 	int ret;
> 	long t;
> 
> 	guard(mutex)(&hwdev->lock);
> 
> 	ret = hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp_input,
> 				     tdata->index, &t);
> 
> Could you explain why this lock in the hwmon core is not sufficient?
> It could be i'm reading it wrong, but it looks like the lock is shared
> by all hwmon instanced registered by a
> hwmon_device_register_with_info() call.

Documentation/hwmon/hwmon-kernel-api.rst 

When using ``[devm_]hwmon_device_register_with_info()`` to register the
hardware monitoring device, accesses using the associated access functions
are serialised by the hardware monitoring core. If a driver needs locking
for other functions such as interrupt handlers or for attributes which are
fully implemented in the driver, hwmon_lock() and hwmon_unlock() can be used
to ensure that calls to those functions are serialized.

	Andrew

