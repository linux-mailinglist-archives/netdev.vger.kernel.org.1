Return-Path: <netdev+bounces-269217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBqUJRA2u2mTgwIAu9opvQ
	(envelope-from <netdev+bounces-269217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:32:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF02C3DA9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41BF304C7D5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4149238C23;
	Wed, 18 Mar 2026 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0p9yvZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC604594A;
	Wed, 18 Mar 2026 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876749; cv=none; b=fttlU52riAn6kS1xTJ6un8awXE6B44DnaEypIKRMJsUWseItdeoWMy/MHQqlpzcYFvwUzhbYbqcl9Ps2PX35VRSRIYvQqjEef5ZDGQPhuLryra7GNNuA0DHswg8xoGGix1khTY97IrrYmoDAML7qPheshekM2sat8mRHTEWHRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876749; c=relaxed/simple;
	bh=e/d7ShjCnym/ty3yqUemNHe2klr/gMpK6LIYk6qOJjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsWHzt63aftNHyqrpnR9/52eus3LVZLPFh82sNbvpWJSO7I1855+rJ6Hwf3KwgvjA00afy7pWOrO+1RmGhg928OKHTwclWbIvF45juFZ8tWZMe7QDzIlDyzI1Jg8E2gOC4vjT1BFqfNO9KZOSc4vOjfEkVM4tUO2Uv3PPpdCE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0p9yvZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D2DC19421;
	Wed, 18 Mar 2026 23:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773876749;
	bh=e/d7ShjCnym/ty3yqUemNHe2klr/gMpK6LIYk6qOJjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0p9yvZl1oS+2uQqEnXA3FNqenXchSGmsrkJJNsBQ/kbOAreJaPKBIMUQqdGRodGB
	 SZVcq5RbCAfDVxHfnzz1rw2DY6V2PpgzSyzkerN6KlyjVrnb5iSazDYG8MAKgWxtAJ
	 ZU1U6ka31gZ/tVu4oDwaYWoh1e7kZn6P8aXhKbHKLt+YJZNJQaNE2+pkpBv7C/8kE/
	 lo+UCddDY5z/eLJuw+4DU1iI1hvClhuexCkpRloo8/C3NDYQs9UBER8JHZaT2yzuiy
	 Pc9KPIt/asValH4pxNwrVOWXW7UI9LftX+uhBiOfPYu7RJqz3Y0KtaPwcm38IPjxj2
	 gZyr0A4Mwr+uQ==
Date: Wed, 18 Mar 2026 16:32:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "
 =?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>, Frank Li
 <Frank.Li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Message-ID: <20260318163227.2566aa76@kernel.org>
In-Reply-To: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
References: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,prolan.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.910];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BAF02C3DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 16:56:15 +0100 Buday Csaba wrote:
> Fixes: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

No empty lines between tags please

