Return-Path: <netdev+bounces-254084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAuuDe58eWldxQEAu9opvQ
	(envelope-from <netdev+bounces-254084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:05:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CC9C7C4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD97E300C902
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8012BEFFF;
	Wed, 28 Jan 2026 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5c8wEO6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28F1AF0AF;
	Wed, 28 Jan 2026 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569409; cv=none; b=LnGv3ofyYvtuZMpAtPiJ529hitayY0+QChlXFc983Lyl6T2ESlKULyW+hrPc+mMjk6jKbODnahpHxnt09Tq5ZrCP7mGC1SxxiechAYEibUd1A2nrfeOsVRHwAHcJekzp1dbzlHiTbPJ9Zee08tdON4Vfp5YGexGyOVa8Z2K42K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569409; c=relaxed/simple;
	bh=NuPmG5cCSn0t4qwwi8kNapz/EY1MPUp1qrbJz4vUVmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+2nbocUe/FaCraFy2/2slt20rQSBkRVCmRaKpJr6B1s43oEQKxFNbSS2Hq+SlTE/BCpQ4EcGRZXv4yBGRnDDkKeL/6FEvNCVUwC2ZCIpVdYo2hiJU6tjoOQ+VKRXzMiT7peAq9jViUmU/gyoDnv9tKx6ugiSvVryok7bw0rfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5c8wEO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE66C116C6;
	Wed, 28 Jan 2026 03:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769569408;
	bh=NuPmG5cCSn0t4qwwi8kNapz/EY1MPUp1qrbJz4vUVmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5c8wEO678/rrHZPIjaXRmN18g+OJ5VWuR/LSHlb2rrSaZNq0tjFngCOai5US7lRK
	 DoKih1bTpnQOoZ6qv/Pkult2ITUbob5l0HitVJu11wPNfU7Vpo77XopGZsWvdOf/IZ
	 j3zB1aGhgPLRfNOVo83p5pHZypFzjShWHlKtblrRf7zk6idxO34WA6k+Kd2UQmHQVK
	 3T3ks+4XCPmtY4P1CleU8kCPnyuTSwGbVIbawu/5gMVTX3cLmptLSAjp0qiCuTNDdm
	 Vz1zRe6//U0LISvFQ8oUbqoBgXuZicH+ju3kuB2ni/zW+UGutLRxkIsMJiuzFoB3hy
	 Y8JMGFaJRse2A==
Date: Tue, 27 Jan 2026 19:03:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/8] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260127190327.79d3f154@kernel.org>
In-Reply-To: <20260127-ksz8463-ptp-v4-1-652e021aae86@bootlin.com>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
	<20260127-ksz8463-ptp-v4-1-652e021aae86@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254084-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F8CC9C7C4
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 10:06:43 +0100 Bastien Curutchet (Schneider
Electric) wrote:
>  	/* Read interrupt status register */
> -	ret = ksz_read8(dev, kirq->reg_status, &data);
> +	ret = ksz_read16(dev, kirq->reg_status, &data);

AI code review points out that we're potentially over-reading here for
!ksz_is_ksz8463(kirq->dev), I'm assuming the wider read is okay for all
chips? Is this something that'll be obvious to all readers of this code
or should we perhaps leave a relevant comment here? (assuming you need
to respin, not sure its worth a respin by itself)

