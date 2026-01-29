Return-Path: <netdev+bounces-254844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMxhAxyKe2mlFQIAu9opvQ
	(envelope-from <netdev+bounces-254844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:26:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6B0B2259
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 631BE30088AE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7233C1B7;
	Thu, 29 Jan 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMZgMwzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916282D948A;
	Thu, 29 Jan 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703961; cv=none; b=IaCcts0siDethhLzl/z3ZrHxyyTIYntZO1zEkscllmE/J6WcH2b/s3CXxu6CjX6ioXpAwHaeTAJJ3b7iK+tSrMDvc8KYIDqZi45faNAf3IrhVxBLwFEG5n8DEVOFoI3DLkH9neMrctyulEqb5/fVYuagpSDvnAysu+hyz03PAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703961; c=relaxed/simple;
	bh=feCsBGPM+FB5KGBMZz36dWkNHaXgbwy6QMGW0PLeH5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEMJTFMx1DLDrMzYgwHBWRi+AxjhjVcMSZuu0eMUmZtQ8VkpXoN9XLpmdVl47rAEybSWJr1Ve6tGzfbXJNGT+suuPdL1B+r+nA1Oil4oZf/M8TjhbWtzE7Ga/GGnyhvvXaBaA1f1xZE7p/uhzhsZxOxxCMrdCPupeT0j2oocqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMZgMwzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976AC4CEF7;
	Thu, 29 Jan 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703961;
	bh=feCsBGPM+FB5KGBMZz36dWkNHaXgbwy6QMGW0PLeH5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMZgMwzgAsNZZf8bbfdwpL8IGipFaOvHOetjELv5rxExbu31uTJ7iHPZUGOPv5cBm
	 TG9ONF4aK3+bE+Me4MjibKYep4xfw7yJr5KA/bsFvkpKw6lrhXcGZaCFkcWIyumkKH
	 qZH8Nd1eiR0qZBVMZvVqXDdVsTX8Xmot+UlcSrHB4Loa9FaXfhR/M05Wpj5a/aOr9/
	 NOazzACT1+3Ac664s4mXtPnQX1F+C6c3shEBzdcgX0Omx0K2ZEToAo4LEDlqkpJnQU
	 WM2s4XI1H+l96gc0cE+5jjMrL7XDvh7EJ4YOuhdJngeKEED65PtmjoXKKygkKazxuW
	 aGP5JHETCRd9w==
Date: Thu, 29 Jan 2026 08:25:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis
 <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>
Subject: Re: [PATCH 2/2] net: phy: dp83867: add numeric io impedance DT
 property
Message-ID: <20260129082508.274f6e35@kernel.org>
In-Reply-To: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-2-8deccd658d16@phytec.de>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
	<20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-2-8deccd658d16@phytec.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,ti.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.phytec.de,phytec.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A6B0B2259
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 15:13:34 +0100 Teresa Remmet wrote:
> +		} else {
>  			dp83867->io_impedance = -1; /* leave at default */
> +		};

drivers/net/phy/dp83867.c:534:3-4: Unneeded semicolon

reminder: please wait 24h between reposts on netdev:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pw-bot: cr

