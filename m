Return-Path: <netdev+bounces-263506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHPWNluGp2m5iAAAu9opvQ
	(envelope-from <netdev+bounces-263506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:09:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6A1F916A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B453064667
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A53054E4;
	Wed,  4 Mar 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoibYqOm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A23043DB;
	Wed,  4 Mar 2026 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586585; cv=none; b=FCQo471YFalOv0Fvw84+onv/5JIqQ6U7REFXIusp9At6r0jDZJBg82dvPovPvq8ux7TmHDJG61rk09dOQGswjYiL8fpcJYzSH3KQIEuYx8G0vg/cBYL25cpzvCJPK9TNmyG5kXyuPFlxEl4koYjBaz87feljYK+SoJX0tLAZkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586585; c=relaxed/simple;
	bh=/zcXtV0XmYcRIn1XMdgqVquD/7x7F33qdfCBK+B7CNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN7s/VG7My3qIVjApfRXsIGYfc+zOsINSrwq0bedVyYB2QLWGNOJOkx09jHOXfolUqISWVJHB76MSbd2Mny2bdO5tkSOJ7zuTGmQO4KA9l6N33fgjxiTldxtbvk8NOOQQPCvU9zBJH9Rj8uypMFHnQMqyVLd44VPi41N8uZYk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoibYqOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE89C116C6;
	Wed,  4 Mar 2026 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586584;
	bh=/zcXtV0XmYcRIn1XMdgqVquD/7x7F33qdfCBK+B7CNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PoibYqOm8vPdo9PcHp1HS6icplFQo9af3b3WclBsXG0HZ3qAIzGbW5eGPmdKRYRMx
	 ukqyyNBLw260rTT7qNgGT7ihuYX5Tbhg8610JzQ/HtdEbY0uGJXgEHb9QUw2w1x4BK
	 KaNmSC/K/kovRXL+pvC+8DpmPn5PMECiPFWI7ywVqvgDh6qtAVzP7bw7eWalYqAUcn
	 L/dLLQFYfuTYdGgZQxHbuoRz8LghAt2WunIG3I4EDOZbzQCY3lpx3FBjVgE1qhZqID
	 73Rur1yLSS6791lEkIFrnsPV0Ff1Ox9dm2byUn7y4rNqXsvOSc9NTF1hsZf24DlsC5
	 beegh9KjQE1tQ==
Date: Tue, 3 Mar 2026 17:09:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
 <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
 <cjubran@nvidia.com>, <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next 5/5] octeontx2-af: Add support for loading
 custom KPU profile from filesystem
Message-ID: <20260303170943.4066bd2d@kernel.org>
In-Reply-To: <20260302085803.2449828-6-rkannoth@marvell.com>
References: <20260302085803.2449828-1-rkannoth@marvell.com>
	<20260302085803.2449828-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74F6A1F916A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263506-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 14:28:03 +0530 Ratheesh Kannoth wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.

../drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:1764:6: warning: variable 'fw' is uninitialized when used here [-Wuninitialized]
 1764 |         if (fw->kpus > profile->kpus) {
      |             ^~
../drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:1723:35: note: initialize the variable 'fw' to silence this warning
 1723 |         struct npc_kpu_profile_fwdata *fw;
      |                                          ^
      |                                           = NULL
-- 
pw-bot: cr

