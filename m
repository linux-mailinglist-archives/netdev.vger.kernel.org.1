Return-Path: <netdev+bounces-290140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBgYLrNKDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493CC59D0A2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B2B31AC343
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF83CB2F6;
	Wed, 20 May 2026 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvSck0i7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4F346FD2;
	Wed, 20 May 2026 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320834; cv=none; b=LCLyomJeJL5pkY9lPnV1SeG/1k6evgx1xsT9dcflt0HEME1BtykX70a3mDu/ZEIhZSsPr4/vbcRjUw3OZlitbUgBEFMcsdvgJtYzWtw4R4X+E0EYNFjkdVHocop1VEsDueVZEiZMRWM+dwDpd78WUpJRdK+hr8w9NdekygV/mwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320834; c=relaxed/simple;
	bh=5kIzZtjDgWTAkUNSaZQ6Gxpzvhg+juerW8LhxTP4onc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncag00QUOl5TDHc9GX9RoO/Sm97DFvvJBvGUWJOVkHnCcTcBRlA6+xZDrEVKPpWIYt8BBHSrH++ZeU0+YOvbsTe5nQJp84ahcJgFUfy4hgvXSFD+AiVO5YsQ57ihRA9ulklsZjI+VhnTWjEPIwRQjgyYJcI2S/Sq88gUWWEw4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvSck0i7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342601F000E9;
	Wed, 20 May 2026 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320829;
	bh=JhWhJZzLtCgb3VTBkY5U5MIdYZG/ZpopZMMPMjI8S5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IvSck0i7rQ7hPBRobNNSs9UbvuqMD1GZuqZYNbVWXQ/2gI/AycmE0Vsa0DJRrCewk
	 leyQkHCD4ncAgt8c7WLK9vURKox0f9L6wqlfuFWTV1ShY57fvGzNjysLAxws2FfBQS
	 894ZxZq6iRxb0cM30XDt5EdoUy63ZpqjVerJLlGx9b+squ3IdE4zsiCoF5CkJO0oL6
	 6PxcUN979r5RpvT+Fx2OXeNrYZxMwDv1Q4xe1GqVQY//1wG/tlOzNlpBXiQ9V0+bM1
	 BUm1PNdSpDaKnpFJ8xN/HXfOwq92SDsrZrrM2LOfEv4OtwIR75Q7eJtZszViq6/kHO
	 +Y0ewDwqS/rtQ==
Date: Wed, 20 May 2026 16:47:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Joyner
 <eric.joyner@amd.com>
Subject: Re: [PATCH net-next v2 4/6] pds_core: add PLDM component info
 display
Message-ID: <20260520164708.61040755@kernel.org>
In-Reply-To: <20260516-upstream_v2_clean-v2-4-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
	<20260516-upstream_v2_clean-v2-4-7e0d66bf4020@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 493CC59D0A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 16 May 2026 02:42:38 +0000 Nikhil P. Rao wrote:
> +	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
> +	snprintf(buf, sizeof(buf), "fw.%s", info->name);

No passthru of names from FW, please, and the FW versions should 
be documented in driver doc file under Documentation/.

