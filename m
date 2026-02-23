Return-Path: <netdev+bounces-259994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDmvAsUqnGlgAQQAu9opvQ
	(envelope-from <netdev+bounces-259994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:24:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56F174CDE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21DC03026533
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D435BDBE;
	Mon, 23 Feb 2026 10:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F81E8826;
	Mon, 23 Feb 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842213; cv=none; b=lCHyXJsjdnIDJ2X03AEsPiMnI1YGkMUIJ/oQ4irkWpF46akKvwpZ61hRhF+OJeNhhls4rE6Jv+B3uAGY+lHwwAMSdsHHJW4VbQn77YnFF3ElzQ9ulhZKOM7J356y6roXqhWeTblL92v5lq6Eo0ULZdAyowC8sjgO+oeMg1nv+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842213; c=relaxed/simple;
	bh=ELv5zMHZwICEdagRRVoDJRD9O9GW92zGu2PUck1DwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbOzF5qnUl8VzPa1KfwH7mLJ7To9KTGjCfX1TYiXhr8pFyK3/4NKdfKtfyYfH4sRlz/t5W23zK2IxmUHbBTRWEVFZFZ1zw2O2YCLfJh3f4unL5bXGBJzB4PNKaOiN0CtzJrpqu3RHvc9ktlJmNkz8f8OymHoFYPLeNcpKWL98QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 225F847D30;
	Mon, 23 Feb 2026 11:23:30 +0100 (CET)
Date: Mon, 23 Feb 2026 11:23:29 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260219162200.510325-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219162200.510325-1-g.goller@proxmox.com>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771842195152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	DMARC_NA(0.00)[proxmox.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-259994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AA56F174CDE
X-Rspamd-Action: no action

Superseded by:
- [PATCH net-next v2] docs: net: document neigh gc_stale_time sysctl
  https://lore.kernel.org/netdev/20260223101257.47563-1-g.goller@proxmox.com/

--
pw-bot: superseded



