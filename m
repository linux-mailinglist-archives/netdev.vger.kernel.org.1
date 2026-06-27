Return-Path: <netdev+bounces-302341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8xofEC4AQGp1bAkAu9opvQ
	(envelope-from <netdev+bounces-302341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 18:54:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94D6D2565
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 18:54:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ooK1TFmc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302341-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302341-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B56C3010536
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A331B101;
	Sat, 27 Jun 2026 16:54:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F22701DC
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 16:54:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579243; cv=none; b=HCZPsRPO8YWzJGXUwXN4iNFCCpFHcP4c9alAac71bdSEhn1XgL9ovBMU1scXWhzUgC/u4urqndsjgnCR8Ze7miShACBU0LPj7x1BKh/HFPhQjhbXn85knU9GKiIgCU6kzG+jIaJXyjQzujVxvVxvOvG/g0OddiLZ4CnxcqJoxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579243; c=relaxed/simple;
	bh=rWNJ+nWH3zByciyqYf1dZa6E0Vryg3VlN2/mkJpjSJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G5g0abz5bOi9nSgIM9YVUugZHvk8giDj1WwN7tmeRrZF0p9hryGHaStXB9u+VbQAqq07+altbEwkG0KbCv4sAEbK0lOg1/puMAlYOVw6TlVKXXvD9Gemmm8Mi1jltvvKqZnf5alANjK8nXlYUwnz1yQfpTGneV95xb+4SWrefSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooK1TFmc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ACB1F000E9;
	Sat, 27 Jun 2026 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579241;
	bh=rWNJ+nWH3zByciyqYf1dZa6E0Vryg3VlN2/mkJpjSJM=;
	h=Date:From:To:Cc:Subject;
	b=ooK1TFmcLq+qtpDExwhO4CzxA+rmCXYd2mkEvsuB7heev/jeSX+CeqwgrClvpHvin
	 vNwLoogRqBZSPz+gyId6Mo1elUwbXPLmIX6zvVuctLoPC5Aq72vHCxl9OdRL5h/r3d
	 mvYi8as79IwYa61USCU6yiZDzA5VrJlVTaWmiTDAHWS8oNpbjtQ7ceYsY7SvBd5GPt
	 Tfd2i6lVuJ5mnfTk6u7Yt/vD86pnmOHvV4E0zxcFd/5bpdQsKUUCZKQwOTDrgmXgwO
	 vsuGsjTNqSEy7D7XGsYJI+GSWJg4t3ZwGCpNUnvgPgU4XSsXG5EmIwAVSEnQ/Uynsa
	 RhrMpDijzccgA==
Date: Sat, 27 Jun 2026 09:54:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 intel-wired-lan@lists.osuosl.org
Subject: [TEST] intel: low timeout
Message-ID: <20260627095400.3c3d9f80@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302341-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:adrian.pielech@intel.com,m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF94D6D2565

Hi!

Some of the tests need more than 5min, could you increase the timeout
in the runner to 10 or 15min? Looks like it's hard-killing tests right
now after 2min:

https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout

which leaks config across tests:

https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout

BTW the JSON reports the timed out tests as pass.

