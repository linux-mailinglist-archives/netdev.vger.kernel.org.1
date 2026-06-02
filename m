Return-Path: <netdev+bounces-294159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i1ZmE1G/HmqLFQAAu9opvQ
	(envelope-from <netdev+bounces-294159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:32:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518862D8D5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="xMONduS/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8088301FE70
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09793AD534;
	Tue,  2 Jun 2026 11:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5862809
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399236; cv=none; b=DBY8ODiD91pCeCoJVHA6eVlWX9Ie9lQNDXg7N3Cscb7xzoj+iZbiLeYW12KtHfjUfjbZhMroyLHs7Zbx3AHKcLE2ZaHN3hvLGaX4nzHgld8bx9NBO0Vyk+gIGdoT7UxbCeX5EFXnvUAqTxW61Q3VJgtOYGoh/MM7VxbUzyjktQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399236; c=relaxed/simple;
	bh=vrS0RV7424gT0I283K6akodv4liM78+AzCZHA48Ok6Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ksvX8Le3PwFGJFp9/51gMihxtyE+4hnAjzKaNDPDukVWGDLhhZXMW380vwLn5BTrPE39CBr0XnItbL9u7ZQcqCM9r8GL9oikqJERK/4sEHzWZ/0VB3PKKoyyJCg/8jpbw/1AYvrr41m33S3gS5bvsdK2Sq2WDuJbS66bj5QF4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xMONduS/; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6406A0334;
	Tue,  2 Jun 2026 13:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780399232; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xUVUTRqCxDHPUZM4nyM6p+a79DE4JFuE0oGDHqGQwzk=;
	b=xMONduS/Mg01sVtBZ7u+zQ7eA6DPGhK5hAZrgzIg8gaGAp8xJAu6KoXdVBwjiam2M7Y7nG
	mehdoKb1PgO2ZBTe1Sb9kxW6nQtpu4+7XLC880avgZ6hf6/5O9Wfa0tMSUlLPQGKrcnwUC
	PjSCypcewK5XBjRLnnHpbZIZjuYujPneARZtXiksCK9cy/fcT8NPY330I5QiXq60s3baks
	tRgqx0vmvgiLQKKVgXlKIu3r5WlSL1B4zbdBnka48amxagLqLes/aK/6xGLiHbpd/nW+ED
	9nDtu+P34v4x2ON1M6oFjPwJGf+QMHuXVftddV5gaYmXoSM6ZRa/5oz5XUUIPA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jun 2026 13:20:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 joshwash@google.com, tariqt@nvidia.com, haiyangz@microsoft.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com, willemb@google.com,
 ernis@linux.microsoft.com, sdf.kernel@gmail.com, kory.maincent@bootlin.com,
 danieller@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 02/14] net: ethtool: make sure
 __ethtool_get_link_ksettings() is ops-locked
In-Reply-To: <878q8x5mip.fsf@cloudflare.com>
References: <20260528231637.251822-1-kuba@kernel.org>
 <20260528231637.251822-3-kuba@kernel.org> <878q8x5mip.fsf@cloudflare.com>
Message-ID: <34fad14a092e28c3512f2405f0869133@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294159-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:haiyangz@microsoft.com,m:linux@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:willemb@google.com,m:ernis@linux.microsoft.com,m:sdf.kernel@gmail.com,m:kory.maincent@bootlin.com,m:danieller@nvidia.com,m:idosch@nvidia.com,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.90.174.1:received,2600:3c15:e001:75::12fc:5321:from,194.13.80.246:received];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[tipi-net.de:dkim];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:from_mime,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4518862D8D5

Hi Jakub ^ 2

On 2.6.2026 11:17, Jakub Sitnicki wrote:
> On Thu, May 28, 2026 at 04:16 PM -07, Jakub Kicinski wrote:
>> __ethtool_get_link_ksettings() is exported and called from sysfs
>> and many drivers. Looks like commit 2bcf4772e45a ("net: ethtool:
>> try to protect all callback with netdev instance lock")
>> missed adding the lock around it. Not treating this as a fix because
>> I don't think any driver cares at this point, but if we want to
>> remove the rtnl_lock protection this will become critical.
>> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> [...]

>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c

> [...]

>> 
>>  /* Internal kernel helper to query a device ethtool_link_settings. */
>> -int __ethtool_get_link_ksettings(struct net_device *dev,
>> -				 struct ethtool_link_ksettings *link_ksettings)
>> +int ethtool_get_link_ksettings_locked(struct net_device *dev,
>> +				      struct ethtool_link_ksettings *link_ksettings)
>>  {
>> -	ASSERT_RTNL();
>> +	netdev_ops_assert_locked(dev);
> 
> Not sure why we're using the "compat" assertion here, which falls back
> to check if RTNL is held, instead of the newly introduced
> netdev_assert_locked_if_ops().
> 
> The contract here is that all callers are expected to hold the
> netdev lock (if needed), IIUC.
> 
> [...]

AFAIU that's on purpose: the original helper had ASSERT_RTNL(), and
legacy callers still enter with rtnl_lock via the wrapper. _if_ops
would silently pass for them if rtnl ever went missing.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

