Return-Path: <netdev+bounces-254481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM8pF0aHemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:01:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C7A956B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4B83022613
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE84341056;
	Wed, 28 Jan 2026 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QkKP87rQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E8228CA9;
	Wed, 28 Jan 2026 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637660; cv=none; b=jl7ozk2MU+ixZdsmtP7xzVXqh5F51jOhBi7nmS1ZblLG2IsvthnQNXZK4Ui3CFthE/uOl7IQJRIAke+Fvff6y9a/5gs8DsH41cnSCJkzlYyhieyLCwU2DKeu4JsoQLvj9TachHoXejMHXX/5mSZS55eYNW9VwFQqCoTEBYGyyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637660; c=relaxed/simple;
	bh=Pr9W0TJTxQfkteJORcfkfTT3Vc43LHiOIR8QlDKL4hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRpitrqZpfl/HwnsQI5dxOGiKcjovk2+TUAbUFzqB4O/OjAbx2N+2Wjo7+pThZqeaNL9WK/LHRF3Ypl3QoS4clrBXKwg1id058kZdCCe6rS+VCO0Pa05SGRj/2o0cNx1fiaKG7TcUz4FqZDYgend3oPuahK7VWl2NS8/RXSa+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QkKP87rQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kL5xR/IwwRggd+tjtkDqeU/lLMEuwjvUemYV4fI7oXs=; b=Qk
	KP87rQ5pEIGipEENjVa7jpd7nimjSv10d81KWctU1peddGibgGy0hDFtj+JQ96J1yhjQdkuXHBfc8
	+ktcvBVsd/jddvpo23l8DZXZ1ju7ECMdsxbUVmtkhvAkqQnX9hnYvR9bY/HPuSiGXvOgl/3G6dj65
	wJAGA0NlL/N8/J4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlDal-005HgV-JZ; Wed, 28 Jan 2026 23:00:51 +0100
Date: Wed, 28 Jan 2026 23:00:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukasz.majewski@mailbox.org>
Cc: Jakub Kicinski <kuba@kernel.org>, festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, horms@kernel.org, shawnguo@kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
	richardcochran@gmail.com, edumazet@google.com,
	andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org
Subject: Re: [net-next,v20,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <ed0e1af1-0210-4461-8939-3e4e35d74dae@lunn.ch>
References: <20260126103400.1683125-3-lukasz.majewski@mailbox.org>
 <20260128022549.4151341-1-kuba@kernel.org>
 <20260128224125.246bcf41@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128224125.246bcf41@wsk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254481-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,pengutronix.de,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B98C7A956B
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:41:25PM +0100, Łukasz Majewski wrote:
> Hi Jakub,
> 
> > This is an AI-generated review
> 
> AI is going to take the "Maintainer's" job :D

We had a bit of a discussion about this.

Our observations so far is that AI finds different sorts of issues,
which human reviewer often don't spot. It also does get things wrong,
so we spend some time sanity checking its reports. So overall, it
might actually increase the workload, but also increase the quality of
the code which gets committed.

	Andrew

