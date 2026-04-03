Return-Path: <netdev+bounces-275121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jj5HMXPjz2mD1gYAu9opvQ
	(envelope-from <netdev+bounces-275121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D6396050
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9433024CA1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6203CA480;
	Fri,  3 Apr 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOjp5HqM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3F3C65E7;
	Fri,  3 Apr 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231733; cv=none; b=UPShruLrvKCv2GcrHOZ8AoZ1mLqJ7zzoF30SM5xtldlQE0aqaq5YYOrnN5TfM2IcyRDczYbIfpOjnDBC5AhedkTbNsa5oAjSr2CyZG+9II/TN5dQ4r7Y1bDTDNR9rznTCsp8fNx3LWuzYU7eRMQsMqFhkRQGmjbo1b69WTk1LsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231733; c=relaxed/simple;
	bh=5zCdI3/H+C2yChLoNxakHbo/nK6sYvMuqWoXXXeX1xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCGsZwxQlD4KWoZqJWymnSFJtiyzBWQGN3TfWZdaAx/aNHQEgFaeDEtwN/7XzpwNKUe4DKcD3m7evPoSvXN62XW2QwzQWlSP19zV++9AREoBSVLClV+mv3jlQXR0vgBhMFVVgASAyXLYOsFGfua4hnFHM3Ix7remD/wKVmo4ujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOjp5HqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF1DC4CEF7;
	Fri,  3 Apr 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231733;
	bh=5zCdI3/H+C2yChLoNxakHbo/nK6sYvMuqWoXXXeX1xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOjp5HqMlfxqT8dJIb0IjSHeFSaxEgLddrpyBkKJIdaJeYCW5sEQ9ayITXYjdcSmy
	 5F8bwW6PBPgJohc+QcKbboI4SzLiBsFYI2+csceuSx1lBK6mgEosFPd34EghQBCHps
	 EdajSe9aiOVZQNK+zAQOl6BdUFroLLNQLK+VDWZhBGuIuBATjQiziJ0c3Gl0nG8d6g
	 z98LvV7OTIxb8/BAOFw9xw0iqT4ELkK1MppSKO25nQmRBIw/9E8NaW22bWG4QHZJ6L
	 v70rtSy/18LZXUuZh/QO1QfcCYCNeLeCGSSUfR3oHl+jdYXYy95BpsZX1l6SMJqYFc
	 /ocOleUbPmjdA==
Date: Fri, 3 Apr 2026 16:55:28 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com,
	Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org
Subject: Re: [PATCH v2 net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
Message-ID: <20260403155528.GA198235@horms.kernel.org>
References: <20260402103519.1201565-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402103519.1201565-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,dev.tdt.de];
	TAGGED_FROM(0.00)[bounces-275121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d8c285748fa7292580a9];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 543D6396050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:35:19AM +0000, Eric Dumazet wrote:
> lapbeth_data_transmit() expects the underlying device type
> to be ARPHRD_ETHER.
> 
> Returning NOTIFY_BAD from lapbeth_device_event() makes sure
> bonding driver can not break this expectation.
> 
> Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
> Reported-by: syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69cd22a1.050a0220.70c3a.0002.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Cc: linux-x25@vger.kernel.org
> ---
> v2: cache lapbeth_get_x25_dev() result in @lapbeth.
>     make sure @lapbeth is set before returning NOTIFY_BAD.

Reviewed-by: Simon Horman <horms@kernel.org>


