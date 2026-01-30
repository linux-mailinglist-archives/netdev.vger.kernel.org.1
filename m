Return-Path: <netdev+bounces-255001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPP/M/UffGmgKgIAu9opvQ
	(envelope-from <netdev+bounces-255001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:05:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E332B6B3C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2261B3025166
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596C1AA7A6;
	Fri, 30 Jan 2026 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KlwQV+TS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C282D7384;
	Fri, 30 Jan 2026 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742310; cv=none; b=r/KmPB9YKNmKH14qGIBONGAxlHrcO7ail4EzpS438PwRY5c1/Cx1rvhlz3eZhbs5B1gKIMreHe4qaLaiPL7qva2N57bubf7PFUZYLG+TybPzEyJy/Nc1hGjNM3bOno2cajarpR6vitFEFWXqldRcCRFK4I6eMULaxTmWXiNtP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742310; c=relaxed/simple;
	bh=fIrJc6V38Gm1Xzp831y0qUcjo7su1xHPtmVZvEaRb+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D65v80qK5uOFpMFmRYaUrMS6/EuOmfR8chODL7jMrR9DOMA/U+0xh5ZShZbGRy8WcF/Vdeej1750ki9lWWqVRXuIJa6XQKgOjlTcT9Y9gQbaiTmq+QESEit2r+ZUSg86ZaXG+8ULsrl6Y0xc8VvqS/B+8IT78kpSIQMRxzY2KW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KlwQV+TS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1B1BFi/8fLCjDIghQMyCqBsdwfNOBaYQ5QhAovF8jkQ=; b=KlwQV+TSwfw4pV4qL7mbq8CuOo
	E97ZOuJxvR6aaj3Apx8scwubXOzPpgAToaQFhGDPEtDaLLRzz7tjj5KjEpTH7gRmFZ6jqZikW3OT6
	LEnMLwGSzKWW0XquTB8mJQNH+jcFayqYyCMhuOG1J+nZ8kwiT/U/gu3aoyocewI16B/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vleoB-005R2o-6Z; Fri, 30 Jan 2026 04:04:31 +0100
Date: Fri, 30 Jan 2026 04:04:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sam <sam.chen@nebula-matrix.com>
Cc: Illusion Wang <illusion.wang@nebula-matrix.com>,
	Dimon <dimon.zhao@nebula-matrix.com>,
	Alvin <alvin.wang@nebula-matrix.com>,
	netdev <netdev@vger.kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
	kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
	lorenzo <lorenzo@kernel.org>, pabeni <pabeni@redhat.com>,
	horms <horms@kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>, hawk <hawk@kernel.org>,
	ast <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	sdf <sdf@fomichev.me>, daniel <daniel@iogearbox.net>,
	"john.fastabend" <john.fastabend@gmail.com>,
	edumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77yaW1BB?=
 =?utf-8?Q?TCH_v3_net-nex?= =?utf-8?Q?t?= 01/15] net/nebula-matrix: add
 minimum nbl build framework
Message-ID: <ecbf1ba5-6ef9-4d94-8240-518852050f03@lunn.ch>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
 <88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch>
 <ad0a6f0f-3ce3-4f38-b27d-2f121511d6e3.illusion.wang@nebula-matrix.com>
 <c1536b51-f441-45ca-8bfb-d5f7d8230713@lunn.ch>
 <152750cb-ab8c-4f08-9c6a-6b69ec185f30.sam.chen@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152750cb-ab8c-4f08-9c6a-6b69ec185f30.sam.chen@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-255001-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E332B6B3C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:23:50AM +0800, Sam wrote:
> Thank you for your feedback. I understand what you mean.The reasons why
> we cannot change the module name now are as follows:
> Our driver has already been integrated into multiple communities, and
> the module name is nbl_core. Many customers have already deployed it. If
> we change the name, there will be a critical problem of conflict between
> the two modules during subsequent online driver upgrades.

To a large extent, mainline does not care about your vendor driver,
and it does not care about any compatibility issues between your
vendor driver and mainline.

I've not looked at your driver in detail yet so i cannot comment on
your driver in particular. But we often see vendor drivers do things
mainline does not allow. Custom ioctl handlers, files in /sys, write
APIs in debugfs, statistic counters wrongly grouped, etc. In a vendor
driver this is O.K, this is all open source, you are free to do what
you want. But when it comes to mainline, you have to keep to the
mainline rules. Such code will need to be removed, or reworked,
breaking compatibility with your vendor driver.

So it can be advantages to have different names, it then become clear
if a customer is using the vendor driver, or is using mainline.

   Andrew




