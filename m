Return-Path: <netdev+bounces-307697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8yhKaxBV2rVIAEAu9opvQ
	(envelope-from <netdev+bounces-307697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8C75BC83
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=FdF4tPTk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307697-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307697-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E70A300FEC4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113523CAE95;
	Wed, 15 Jul 2026 08:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C73CAA51;
	Wed, 15 Jul 2026 08:15:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103311; cv=none; b=uKAvzDmFQdj7ff+f6i14w87Og5B+ai2nuPCJMMELTE8SfFJA+iU0nhg3roXXpqooys+x2ydJ9gZerJ5IiBSpYr5jt5936xhCKx1IOwt/SGQ1iuHC81MzfOi+asagj7aWzzJMzzP+lqQlM7HjqLJQTWuDEztLJLC+ZE4MRMY49X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103311; c=relaxed/simple;
	bh=U6JR/PoX3S+8pkFQ9lQp6OpGeokwyfDEgky1PWHD/+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mfcLBj92O590hgyuc5HqSb/mvsX3v4nvDDPt0wThcfDmjthI9yaUR0MXrsc/3/9S7JKNWRvXaQKPlRD1UB4eZrWalIMMRiaj+wK4nWyq6/bc2MY7XQGbh3lWSpwQQpFfRFlFtAQfqlQdWpumbW2ohuAVtTPy7qW7smkPsNAqWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FdF4tPTk; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=U6JR/PoX3S+8pkFQ9lQp6OpGeokwyfDEgky1PWHD/+8=;
	b=FdF4tPTkpdJA3S/IzS0ulc19hUvFugKRToNxGqhzY3KDEbK6vlxUWl4Uy/AvQI
	tzDP/NVFWdA/75cs0s3TynXW/FrC4lYezaMVmPcoaMFqNycut7dT3AZrbj9eqTtf
	yu0I1sR+Tv14+hDa+uz8MRYgVmzyaD+SFMiBpuQW6kIjM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHagJzQVdqIzlbHw--.21009S2;
	Wed, 15 Jul 2026 16:14:44 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com
Subject: [PATCH 00/12] vhost: cleanups and improvements - PLEASE IGNORE
Date: Wed, 15 Jul 2026 16:14:44 +0800
Message-ID: <20260715081400.1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHagJzQVdqIzlbHw--.21009S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfyv3UUUUU
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzRTdbWpXQXTOhgAA3p
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307697-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:virtualization@lists.linux.dev,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:jasowangio@gmail.com,m:michael.christie@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiongwm2026@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiongwm2026@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28C8C75BC83

Please ignore the previous series "[PATCH 00/12] vhost: cleanups and improvements"
sent earlier today. There were missing CC recipients. A corrected version
will be resent shortly.

Sorry for the noise.

Weimin Xiong


