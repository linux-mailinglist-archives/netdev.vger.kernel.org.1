Return-Path: <netdev+bounces-294219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eK8UKcbXHmp0VwAAu9opvQ
	(envelope-from <netdev+bounces-294219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD162E657
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:16:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=x3YCFDDD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294219-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C9E3302DFB4
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBA3E0730;
	Tue,  2 Jun 2026 13:14:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFC2441B8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:14:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406079; cv=none; b=L0EDDernY2KBjNwqkaAR3j8whgPNKMOFFceixhi4Ji1muHDPUF0i+vJxx9O2+X3AfB6llbWoyAGRrbjDfqLJZyLDiyXyOf9oOs3gUXFsxiwFtXYMNAUTyvFTo1POJkOQSX2nKhHuLgJVn/I6eMzOQGuJ3VIwF/P0wCwdbuKNJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406079; c=relaxed/simple;
	bh=MFApm68By4k0Kr44EXAgoLdlNMPDX44vW3plH4MrTxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG1mvngmooXmgR1Ad1iyJ3c+2u47TcVuuvP1XWZEIiPcF/2ZoM9utQWuVcS3kHNRYa0MrRVW8zpbwAnmYg3dM24QB0nPA1X0NmrvpZU+WEgBcjwogOD/YLHeR7kkGagPPM83d2APrm5jcct0KKirQfOZZcEmZkgjBJkIm0P1+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3YCFDDD; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VKs59dNKmRvI1Hmlk25t2+mwRctoV974/4uKPiMDGpI=; b=x3YCFDDDvzUX7leJXsQbsXQu01
	+SYZMHNXF+RhyJufNzuClcmU4NV9fTIwZGmiuH2qRO+pcdpsQF1Rv5gBr733KIMYPHiUxV11ACFcd
	uBxamZ1vmtYDeuw73frUJV2epqWv2QKKpU9ZU0A6e4U57GyXpp8APM7HaGPxouao0MD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOwz-005gxN-74; Tue, 02 Jun 2026 15:14:33 +0200
Date: Tue, 2 Jun 2026 15:14:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: txgbe: fix module identification
Message-ID: <9945fe19-815b-4e27-8446-c21cdfaa16d9@lunn.ch>
References: <F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294219-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10BD162E657

On Tue, Jun 02, 2026 at 10:54:43AM +0800, Jiawen Wu wrote:
> For AML devices, there are some issues where the wrong module
> indentified then configure PHY failed.
> 
> The module info buffers should be initialized to 0 before the firmware
> returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
> zeroed contents, so explicitly clear the temporary interface masks before
> setting supported interfaces.
> 
> Rework txgbe_identify_module() to validate module identifiers through
> explicit type checks instead of relying on transceiver_type heuristics.
> When using the SFP module, transceiver_type could be a random value,
> because it was read from an invalid register.

This seems like multiple fixes. Please break the patch up.

The current DECLARE_PHY_INTERFACE_MASK() is not great. It is mostly
used by phylink in structures which get allocated and zeroed. But here
you have it as a stack variable. Maybe we want a new variant which
includes = {} ?

    Andrew

---
pw-bot: cr

