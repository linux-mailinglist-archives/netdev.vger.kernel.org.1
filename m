Return-Path: <netdev+bounces-254760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBxDMgA/e2mNCwIAu9opvQ
	(envelope-from <netdev+bounces-254760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:05:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E08AF612
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180EB302CD07
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0F3859D8;
	Thu, 29 Jan 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilfxICpA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9t4vhn0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CE385EC2
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684711; cv=none; b=pd80pYNeisLMerbnWAVcO+YpLOkbcmYltTZNvjE/XwK63tpZA4u5wIJAnsZYOwDdABdcEnuSQQI1LKjtpK1svG4WQPLGW/MmrNyHGpzACkommFm8KtHsNwksG+G1iDJH8zWh0FIeFaAo+aSsUv1RqlQNmlQqlzZf/7BHHizvUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684711; c=relaxed/simple;
	bh=0X2NG7LaFxgL2LklVQbMtspcAAcrm1TXYa5HiaupJWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSnyQdZuFE2GpPT9newqJMqEfwAljLtwifUOR4gEqJIKHEOLxztPV8phKQnx8U9fFrSno0X3Ptav4QczIM3ITa7x6TAXisBzHtdEP6Gy9xuLOvImuLpZ05PlTNUK+spLhDI3V5iRBa2VYd4JTtwwrZOdFu2tlHfpFJYvv/kCFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ilfxICpA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9t4vhn0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 12:05:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769684702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmNPOimiLR7DUzIDDTi5o6rGJt9YY+whR5m/PtOZ6fU=;
	b=ilfxICpAb3J6wUZIIYcmzDa/XUexov/KqBsLjedvNSAFm1RccXBtwQ619LRdTiVxYvw7Qy
	AGibvH29wHIRn6Wb7ovgSAa4IqwrO4ixMxjxZBeAgQualfgoswyJ6fLGvXFOHthCiBZbbd
	BXEtX0nvosxdl2XcOP4MTQHbjzSOCNp9OsCgFd5OFOmrr/BNZB4ZEjply3DIWRTaabddwY
	zx7gIH46Le5thobrpc73klVUyS9hc/pbssKgHlz3LXwt3Wbd04+5DG5VC5O+ClyOCjtDiL
	Jp2J75sVxIMjZLz658lLL6cQCN73x2pyxaLJ0SCClfw3whiU4fPXkQq3RvGxtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769684702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmNPOimiLR7DUzIDDTi5o6rGJt9YY+whR5m/PtOZ6fU=;
	b=h9t4vhn0JEaVpIYdWY1DVzJKvM4Mf2VkYbcHOQLrovXBWm0aXSOUWdxxUxyQROpspEIeCi
	yRgOWRqKj+OCobAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <20260129110500.l2jOMEYp@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254760-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 59E08AF612
X-Rspamd-Action: no action

On 2026-01-22 15:56:56 [+0100], Felix Maurer wrote:
> diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/testing/=
selftests/net/hsr/prp_ping.sh
> new file mode 100755
> index 000000000000..fd2ba9f05d4c
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/prp_ping.sh
=E2=80=A6
> +	# MAC addresses will be copied from LAN A interface
> +	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
> +	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA

so I somehow started this (I think) but while browsing the spec it
somehow says that the same MAC address should be used on both ports.
Could it be?
It says that the two frames are identical except for the LAN field and
checksum. Also the duplication is defined on src-MAC + seq nr.
Having this requires to merge the two MACs for a node and we do this but
could this be a left over from an older version of the spec or a
behaviour that was not meant happen?

Sebastian

