Return-Path: <netdev+bounces-252344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGgoG0IpcmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:42:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 152DA676E1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 626CC8E890D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9743112D0;
	Thu, 22 Jan 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pn/AMgF+"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E83B8D5E;
	Thu, 22 Jan 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086300; cv=none; b=m97NnNORR6isKuZkky6LMfdSu0YzjWpIWH2lQB24rBRkzR8eBb4rk6vmCMRcX4Bi/Fmi8SMwtbwFG0NlNf8tog0JdJmglRLLCEUgQXnhOEVlY4bTbSH41BT7uac/Wyo3SJgyBqzZaI6O0WXC3kwSzUI+/Icj25fL+L2nsJ+dF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086300; c=relaxed/simple;
	bh=9IaT7yw7Auxhv5/NFAx9I3J5Tf8VyKOwe3C6pisHl7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka9oLmg2bZZfNaHsvU++UwfEei3YMmrkha1SrPuPhJqMO6jPiPffdHRFSu3tKRV4DWExRv1EajIUMXmjW9GRGUl8mNOzC4IwWTdmKiYs10o2HGEJ25x3V4kHMA5p+bbCaDj/QmjYC1hM+4Q8LETaLdLJNyrrn0SGUpPHq9THiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pn/AMgF+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6ryD9xTHOVZL3Ctrwu5BJ4DG4YQJ3Rs0CaxSMd8HeEE=; b=pn/AMgF+nUEMnYXnZBN5T4CMrp
	f4vnquFk0sIThRxcZgmCMeCzN53ew/FkgMBLw4zfT1TZvF7dbUv89GQugpoPq7EqMlfohYWitiGVE
	cm0HMlT3KsebfOgAoTTohIbmVqYtYGyXg4Qyi1WCCPFetHnePvtmRpm2DVm70s7Kqg9R0B6vcXOj6
	GAnTgJ714YhLAoHyaVzN4H6jSI7zwxj1OR7tY9VlMC87gocI7EsmDn6NQTRIRvzYMP6ICgEtKNljy
	yS79BqzytQCCib5BPq7pMB25hEpb8gWCnsdRYj3Y5Z8i3Cm9OPzPT/N6nxHgak6fUJN4WiainUlmz
	ebU7xDpQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1viu9h-00D1t8-CQ; Thu, 22 Jan 2026 12:51:21 +0000
Date: Thu, 22 Jan 2026 04:51:15 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, john.ogness@linutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v3 4/5] netconsole: Use printk context for CPU
 and task information
Message-ID: <aXIc43kUCBYZex2h@gmail.com>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
 <20260122-nbcon-v3-4-a722f2f0dfa5@debian.org>
 <aXIWUmhBnFLY6EqK@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIWUmhBnFLY6EqK@pathway.suse.cz>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252344-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 152DA676E1
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 01:21:38PM +0100, Petr Mladek wrote:
> Hi Breno,
> 
> I have got only the patches 2,3,4. I can't find the parts 0,1,5 even
> at lore. Something went wrong when sending them?

It seems so. I got a bunch of Delivery failed messages from different
places, including gmail and netdev. Not sure why yet.

If they don't show up soon, i will resend.

--breno

