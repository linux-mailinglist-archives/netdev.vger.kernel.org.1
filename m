Return-Path: <netdev+bounces-272604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KByYFAelxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:40:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0046346E63
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8FF5305ACA2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DC2DF156;
	Fri, 27 Mar 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="AM/Nv6Ol";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="o+ovQMcj"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638A3770B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625735; cv=none; b=UrMkIYkcMSW2OHm6qilxyYgIVdqy03cWj6FiS+oYHuAB5ASdoTT0UsBq7nGc2/fWxCXCYcQ5O8emnc1OIlJTuKk5f2UC1JTfSIhFsWCYJWsbkHQQ+NwRjqX5c27dN8Izs1OU4GZzkh2ygp326Rnl0nvZETBdxd1P5nV2lG6ln7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625735; c=relaxed/simple;
	bh=cBecj4/BHUgpx2Akznttb6F22ju7+BUQg+K5+fkSw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO2HFj07/CwutCtHqQzsOIEZR6mGciwqKZnjn6PwV9Wb/77jtSN1hrUWMhs0RL29dRHs3fCI+I4xqgbFqBM+c9Rz8uuQfJSbSTAhhGTYE52K5VLd9IBogzprW0u27mlnVTwuT05BQZMPeTptllc3WgxUyjvuiH6hbHLX6ipPLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=AM/Nv6Ol; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=o+ovQMcj; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=AM/Nv6Ol2T95fudLP+syTRCGn+Yaw5HZu2X8qBuTydDK2yHmFpGRo/JhiTmfjppyjcVKb8B9X86YKznSip+ylxjzUjqapirOlQPXSdlfgCQq23CFeP3hYRHIuiomEXx8Hc25defyvS4WGCLJuj4I8gPOwv4ghiGKII4gfT/0YKGkuxLE5EcYxIcbkf0WbbzEQcjtnajqcpoa4QPxx0u4zvayAYtcEpugtv8+9rMQWtcoMD9NESm2ggUl2R8zbVC7rxRIgbCe+mXcyblyM47sd8mPU/Y4PHwnjwDMLA0k/QTXXSlAEKmM8ipf34pOmgJjaEyoBPwUpeLsaQdPSWNlVw==; s=purelymail1; d=tinyisr.com; v=1; bh=cBecj4/BHUgpx2Akznttb6F22ju7+BUQg+K5+fkSw+I=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=o+ovQMcjc8yWn1enLEUls6VusOHGrS5ndPoQaEBA9lPdJ9spFmXfm9fGehuKqMjQ0B9E6vnWDFjpmeyEvVVon0Xq5xnUARnL3uheQhxWuYeJLB39Grfk7S2sdRXljPiGIVvO3Vjypab05C3lsKHrx4aUujqdQQSeCvZpvs/ZIIXXfCVWlOhKQBZeccp1etUMOKAYrhx+klJ6472yGRigB6fc6SK8fIdUTSgJ/x0oMO+wEJlNnsUmA+472Ko6AJNx1U4uzodod1P3z6Y+8QGWeTABKf41BblAOamcsUmCIeOxifGjL0xPOwIbfZ9L59api5KEEp8jqo9D5zaG3FgZSw==; s=purelymail1; d=purelymail.com; v=1; bh=cBecj4/BHUgpx2Akznttb6F22ju7+BUQg+K5+fkSw+I=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1686820232;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 27 Mar 2026 15:35:25 +0000 (UTC)
Date: Fri, 27 Mar 2026 17:35:15 +0200
From: Joris Vaisvila <joey@tinyisr.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <acaijjDU7cgOUWmU@archlinux>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-2-joey@tinyisr.com>
 <acW9G8vrMz89Enss@makrotopia.org>
 <acYZOEksxcc-uHcT@archlinux>
 <acZqvZfYXR_4sMlT@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acZqvZfYXR_4sMlT@makrotopia.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail1,purelymail.com:s=purelymail1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tinyisr.com:dkim,purelymail.com:dkim]
X-Rspamd-Queue-Id: B0046346E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:32:13AM +0000, Daniel Golle wrote:
> > [...]
> > On the hardware I'm testing on, it works fine with the port set to
> > "internal" or "rgmii". Would it make more sense to set "internal" then? 
> 
> "internal" then. It's a single-die SoC, the switch sharing the same
> memory space, clocking domain, ... with all the rest of the SoC makes
> it very unlikely that RGMII would be used as an on-die connection
> type. (unlike eg. MT7621 or MT7623A which are using multiple dies in
> the same package, and actually RGMII or TRGMII to connect the
> MDIO-managed switch part to the main SoC, see "MCM" / "multi-chip
> module" in the mt7530 driver...)

Makes sense, will change CPU port to internal in v2. 

Thanks,
Joris

