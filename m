Return-Path: <netdev+bounces-288380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPS4JPJSB2pIygIAu9opvQ
	(envelope-from <netdev+bounces-288380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:08:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699C5547CE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E519130298CB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A52318EDA;
	Fri, 15 May 2026 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RQ70Fcs2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E94331214
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863448; cv=none; b=tieLVXHnWb+5jqQ7CIqPuosOncMmnZVPNnFnusoMt3PvKXLlx7CvtoWHRS+7c2nf1xOxUzoLPqJrZosSFgT0KTXgR6TZbTvD64YIKYP6j1cH3uK0umsDwOdT7n5RB7AlG6vQHDOY4hq2nd8PtvaUtF/b7/mEE+2m8KTriMGR+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863448; c=relaxed/simple;
	bh=qEGHeTHTB5/uUgZai71P/1vmcO3UUZGvctapHQgBDOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzt9WmrQUc3gdxMh/dp1ByGVhkFPk9radcDsT5OwX4yDjmTp7dBDq61t6genDUV0k7mU6Qg0bRuJBrQWQDDltPeJG9hpibfv1PuLOTIOfCnrN7XOuHn895BPy+w4M5/fwOySaCrQ22+7sbVjzonH3WhEw7sIVwfkdYQmwuxc7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RQ70Fcs2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=di4WxEwImvWxYCM4Z6mGnsS0K4LS8j6Oo7Kf+kLHwak=; b=RQ
	70Fcs2BzqVStTSQZDX3X3ibiZhzuwKnrpTO7FgzgJyoMcCYMnb/I2rrmrAX6eMqKsiBqSTEBbMWdI
	XKX9XOBWLJi7JLC5FVnzbVMlN7Y+ezFY8R9CwB77iIBv3iHkdB0ZDl3Y1n0gbaMBjW2nOFYUcm/Sl
	JSC8V7KepvQy6C0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNvdt-0035ga-Et; Fri, 15 May 2026 18:44:05 +0200
Date: Fri, 15 May 2026 18:44:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, bjorn@mork.no, linux-phy@lists.infradead.org
Subject: Re: [PATCH] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in
 mdio-i2c
Message-ID: <32b1d434-7286-491e-9702-7816b0dd3700@lunn.ch>
References: <20260515161834.23628-1-petr.wozniak@gmail.com>
 <20260515162232.23758-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515162232.23758-1-petr.wozniak@gmail.com>
X-Rspamd-Queue-Id: 3699C5547CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288380-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 06:22:32PM +0200, Petr Wozniak wrote:
> I realise I sent v2 without testing it on hardware first — apologies.
> I will test and follow up with a v3 with Tested-by once verified.

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
https://docs.kernel.org/process/submitting-patches.html

You need to include a version number in the Subject line, and indicate
which tree this patch is for.

Also, please start a new thread for every version of the patch.

      Andrew

