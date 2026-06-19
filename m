Return-Path: <netdev+bounces-300557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0k/eLbmTNGqRbwYAu9opvQ
	(envelope-from <netdev+bounces-300557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:56:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC206A3772
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R9hcEDBA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300557-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300557-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEE5C30360BA
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F49217704;
	Fri, 19 Jun 2026 00:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D654654;
	Fri, 19 Jun 2026 00:56:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830582; cv=none; b=odlZd4oq3c8xaYiPoLSBVukQtjd+A2KTw8K/fm6gGtM3Cfwyw2HyPi8Dn+WD+K3IHS+EtPcmtZ0k/hKXjxY9uzHmr83JJaMe2VTWA8wx84Xx3Mw9YIHynRCUsaeX9GAp3nF7O8VG+9qdz6Kuj2uyfWS8tTIeRFEpGYFyWnTCz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830582; c=relaxed/simple;
	bh=OMHydIANu1o6UY/V/GnGmH8MKgNzsKxLVznwgMJGMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HosIcL9DXnQ1d8XQxCybIqVikGFdi5xeeuM6vYIjI7iJzm1+DgcxCeJfXPknqmtfdNbaYsGJKAGtASN+uXv+VfhlofBysZQP9OLcW0W5oGZSTiRhZdTcSFUp6QHgd2PBXY46W6lwZRJs4cAsR2VA5DI/0xz2/Quy57Qz1CjfZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9hcEDBA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865991F000E9;
	Fri, 19 Jun 2026 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830581;
	bh=BLHuCpwcCI0cZ7RukXDPSnWbikFTyCQbuDZK/f3vLdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R9hcEDBA1Zowa5TPQxBp5uPBhjHJU8jJuZaKzZaBQDOcZ42yrZgx7IYJGm66fnRN5
	 xVTb0ZgJsjreF7qey2sHR7YGdGFBXiQySJBCF8DKtx+ATO6UwqiUxV3t/MtIPF92PE
	 XnNP3vDLgBZWMRKpOq4sJdzb4yP+XqNMPpO4qalDQzrok1mNs+XUJcUMnfDzgQCvDI
	 HzDlIBJzdcoCMvL4wVEd3CF+BVhN3CqC8xjvDl+zr3znsSizkD8+Bb1eeEJIEth0BN
	 L7tshDiKS0qnSt7zqin5VgQItkip0yLFq+Pv2WpqUry4zGJP6lsuXnvyosdfXrvA0j
	 nvRLqnAwuYhvQ==
Date: Thu, 18 Jun 2026 17:56:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v2 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
Message-ID: <20260618175619.671a4025@kernel.org>
In-Reply-To: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300557-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shital.gandhi45@gmail.com,m:wellslutw@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:shitalgandhi45@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CC206A3772

On Tue, 16 Jun 2026 01:20:30 +0530 Shitalkumar Gandhi wrote:
> This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
> driver, found by inspection. Compile-tested only; no SP7021 hardware
> available here.
> 
> Patch 1/2 fixes the phy_node leak in the remove path.
> Patch 2/2 fixes multiple leaks in the probe path and depends on the
> cleanup contract from patch 1/2.

Wells Lu, please review.
-- 
mping: SUNPLUS ETHERNET DRIVER

