Return-Path: <netdev+bounces-261999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPkMMlkhomm4zwQAu9opvQ
	(envelope-from <netdev+bounces-261999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:57:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E61BED2C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580E030A050B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BF3BFE3F;
	Fri, 27 Feb 2026 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="krAlHxqs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9543D905B;
	Fri, 27 Feb 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233002; cv=none; b=DlWc5vJ+zJofgcum3xQV+ltuU8OYW5LLMqdj2a2dTUFeVabtRaLA1587Z80GT+LLJcOY18SDb58EXZhMpx73SUVYAdrCJn5dxbAmVsFLKDyqUETx/EO/qwp8GdmtWN3vEoaMLLb5B6aJufFH/Q5m7+mMttfc4I6NgMw3HVyv1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233002; c=relaxed/simple;
	bh=V6npR5hQEOWz6JusvcckNxs8YDE4ZvsZ4sGtGr3OKD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imeWIXoUPwEsw/5Nphjpggv8ROL2jDd1DXQ0B/sQRRspOofQjg9evuf555GKMymutVaFrBVop0ZNud8AJPRFZTOLThvfpyQ24t2VJcjxR1Q+6rMvUQeCt0DupLnd6yNd35oCiReI2liJKzVs3bHR82Gfo4KU6cUl2usVC0HLBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=krAlHxqs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Vxl3n6UVxlTEujCtUmd2PHjggcQA+AwWL+uPIPgUSac=; b=krAlHxqsOkw60/+66USS8tJnE6
	NGNI9jKq3Flip8ApbhQDOjXcNmv4zGLPrTjtFJ8hMKmSGQQxvmMpcUTTq3mtJc05fdEuoJuybkS/z
	7Z0Qdctbar3iu9/zLglfxvhM0WEEEJ1MEuwCmFaiW3ZNBJLuBxnUD8/XWKEfXG4sLYNY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw6l1-0097xF-On; Fri, 27 Feb 2026 23:56:27 +0100
Date: Fri, 27 Feb 2026 23:56:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 03/11] net/nebula-matrix: add chip related
 definitions
Message-ID: <c5d2ba02-55b8-4839-bbd1-1d387da27f96@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-4-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-4-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261999-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 3C4E61BED2C
X-Rspamd-Action: no action

> +static u32 nbl_sec046_1p_data[] = {
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xa0000000,
> +	0x00077c2b, 0x005c0000, 0x00000000, 0x00008100, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x20000000, 0x00073029, 0x00480000,
> +	0x00000000, 0x00008100, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x20000000, 0x00073029, 0x00480000, 0x70000000, 0x00000020,
> +	0x24140000, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xa0000000,
> +	0x00000009, 0x00000000, 0x00000000, 0x00002100, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0xb0000000, 0x00000009, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000100,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000100, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x70000000, 0x00000000, 0x20140000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x70000000, 0x00000000,
> +	0x20140000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x38430000, 0x70000006, 0x00000020, 0x24140000, 0x00000020,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x98cb1180, 0x6e36d469, 0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
> +	0x73865086, 0x00000080, 0x30140000, 0x00000080, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0xb0000000, 0x000b3849, 0x38430000, 0x00000006, 0x0000c100,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xb0000000,
> +	0x00133889, 0x08400000, 0x03865086, 0x4c016100, 0x00000014, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +};

What is all this data? How big is the object file created from this?

Should it be const?

Could it be marked __initdata? Or moved into firmware files?

      Andrew

