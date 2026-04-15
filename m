Return-Path: <netdev+bounces-278821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICcDC8Ss32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:20:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD4405D1A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E4883066A23
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5AA156C6A;
	Wed, 15 Apr 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej9ZxS4D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5B54654
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266150; cv=none; b=ZnH5fkv7KhKp7a7xMgXkvbZHPmx/lyfcpqgeNICIOLhHZCRtcI/ymJw3KuV8N2IMyuDegDToyFhSScBTe4rSj9/gHej+CkZOvCnf4LAbjp5+80M7h2b7gBgoWyLz78EeQ7oyn/arvTguhV3O6aUWx3oGpdOkI0PWhLCCUF3tCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266150; c=relaxed/simple;
	bh=CDcpoBqVJZlaJMUWuD5g/SpFJRTuzD6dTnEZz4mVMvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxxpjhaedf0oNGfNTbKOGCpipZVbCo88H0puWNzwxOt7rWXjxnPNmDMKuWTCqxT6X9I+RUBBiAvbVBNmneMtPn7nkOpfHAOTio6L9J4Sz1tuEpLECL44nCr8pVsWi48bzVTHqmnv+mfmn8kglPi7tS0tqttLiSxOH1sl+dRoGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej9ZxS4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69154C2BCB0;
	Wed, 15 Apr 2026 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776266149;
	bh=CDcpoBqVJZlaJMUWuD5g/SpFJRTuzD6dTnEZz4mVMvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ej9ZxS4DZ9VfWN7vWabXKxJFBkq5mR2E4GIQB1/+mCxkkRYhkXhmvhwjjgwQibibE
	 OcRT7srOdeJaMa9wARrvYBUG4GB6UE62Kf1HLpxMBbgF5FUbfi2camCA5EVTErNfg6
	 mlXvBpCyhrR1kyJlyv+4vsNcMo5s8iCnne0oQNbjH7w6Fg5Cs0fSbJ/IfHikv/Yvus
	 xJSJTmMd5Buc8TlALwH/1ZyTpLgBb8St1wGRqlxho5DT4W7trPha9802X7h1oOyVa/
	 ID8xBL/Fv/T7T9psxoNsaAcp2cebl3EQ0c/fc8b25t6Jb3pBBj7Ly7ufvnfFEngx11
	 O5CT5OszG4NFA==
Date: Wed, 15 Apr 2026 16:15:45 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kees@kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	yuantan098@gmail.com, bird@lzu.edu.cn, ylong030@ucr.edu
Subject: Re: [PATCH net 1/1] 8021q: free cleared egress QoS mappings safely
Message-ID: <20260415151545.GM772670@horms.kernel.org>
References: <cover.1776039122.git.ylong030@ucr.edu>
 <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278821-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,ucr.edu];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 73FD4405D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:07:20PM +0800, Ren Wei wrote:
> From: Longxuan Yu <ylong030@ucr.edu>
> 
> vlan_dev_set_egress_priority() leaves cleared egress priority mapping
> nodes in the hash until device teardown. Repeated set/clear cycles with
> distinct skb priorities therefore allocate an unbounded number of
> vlan_priority_tci_mapping objects and leak memory.
> 
> Delete mappings when vlan_prio is cleared instead of keeping
> tombstones. The TX fast path and reporting paths walk the lists without
> RTNL, so convert the egress mapping lists to RCU-protected pointers and
> defer freeing removed nodes until after a grace period.
> 
> Cc: stable@kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  include/linux/if_vlan.h  | 23 +++++++++++--------
>  net/8021q/vlan_dev.c     | 48 +++++++++++++++++++++++-----------------
>  net/8021q/vlan_netlink.c |  9 +++-----
>  net/8021q/vlanproc.c     | 12 ++++++----
>  4 files changed, 53 insertions(+), 39 deletions(-)

There is a lot of change here. And I'd suggest splitting the patch up into
(at least) two patches:

1. Convert mappings to use RCU
2. Fix bug

As is, the bug fix itself is difficult to isolate amongst the other changes.

Also, AI generated review suggests that this bug was introduced by commit
b020cb488586 ("[VLAN]: Keep track of number of QoS mappings"). If so,
it would be appropriate to use that commit in the Fixes tag.

-- 
pw-bot: changes-requested

