Return-Path: <netdev+bounces-300153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fHpdIraLMmpI1wUAu9opvQ
	(envelope-from <netdev+bounces-300153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:57:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4556995D2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:57:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300153-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300153-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175963201ECD
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C73ED125;
	Wed, 17 Jun 2026 11:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D843A4513;
	Wed, 17 Jun 2026 11:47:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696850; cv=none; b=mRSqVr3aj80R8PT53Ufmj+7jLF74KtIcX3bvxQQIOEXA0pVnukYdNjcTzU8sS8871Xi1qoV7MOro5owLOL+/NzZRLsm9DGXW4j5jb11PWCM5li0LCGjWNOOGo/vqd+DipecJ7RcYKUTrGZCOxldfNOBbJkeuQ4aPM6Kf7xvFy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696850; c=relaxed/simple;
	bh=UQz/zpVfzPAypWya/1CLJwByOe8kFymXks5SAlss86M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1NuxqNoVRn1IAn7USFB26FPKlYdeMPJvHxwPF0yvB0wdCdlozHNuayGVs81GInQBdJ4mt3wynUIXOKaFWy0s4e2WGhtjci2zPT5HJxi7C6kP9jP8VxuxOw1B/sbomkCDHf6T7vkUC1Ka+hZR/v7OpizDicfrjM36y8THwF99go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: esmtpgz12t1781696776t0b68589d
X-QQ-Originating-IP: GSnYg3plKNV5TirbqdFZVuxyMN8ytJ10c9gIuJ5y8q0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 19:46:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7157950420111944306
EX-QQ-RecipientCnt: 10
Date: Wed, 17 Jun 2026 19:46:14 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Message-ID: <0C93ADB24CB93157+20260617114614.GA273003@nic-Precision-5820-Tower>
References: <20260617083531.251119-1-dong100@mucse.com>
 <bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MTGYztYhR5ETrAT2RwY5/d3tN3X8phHwSwuZZMF8Jxg8iBPRDqKIqe2g
	gwe6G4o/++akMx2aWJ1E0g41zqoAt9BH2/jAQ6+CXVKBIXG7Oba6GrmaxY8j5bsaKfnUYkO
	o+PpckdhbNes9dF7SzT00/Qx/M/K7ZHevdarvD1CA0NQU+9fLcgToeu1PPxf6alZy5jF0Gf
	y2KckH137SuZ+UOR4J5IEgc3lY4fIevw5XNzWeqIpgnL4UY951zqCdsF4EnEDQbjso5Nyub
	SxNr78JWJOK4tUnqtPKAHCZTyJJNWzWysFmj9xVZ3up7QAkxXepTaLoh4igBAWiYdh9un11
	HX0yr7aJlcJRw9znSkXPRNA0UhCpm6qkqbtQOM+4lWgJSn2v4X4k/qlAIJ4FRp4vw4Ty4yh
	4ovLK6EsUyrGJEqohGJeuDn3a2FmVTjY1yK2ewIWK1WD2yo9d3tte/QmYYNw57uczFdJR1U
	XSXd+C1n7AVs7FHYBBR37IfVsVzCvygbahszGuFCYDH5dBy8rcgBFgBsyeA/kmWaW2tm+xN
	Jz5u9ZgKDNn88L/jrh6aMBe+QqwFZ9Cmhfeprj0ocOiT5OSZEhF5Na+rVpznkzP5f6zSMLg
	rL5/iuhRP0iWs6HHdJImDJscWmlWI45XRAtGkDaDV+pqDE1GdnY/VKczL2/J8Z6QToNQZt9
	9INKFzSbe2aWIqYlhEp7szQXEopD+q58QsEZEvjilCOpcdUbrz7YvVqBUehunp7nGgKr9W1
	9poFL+fUHENgQF7ebxzHI6Oe0Oqj1h/FnFSLFPCL01aAGuCFZeDRPInuHfCsYHRNSpor1lB
	OIRan+ne57gB70gLgJZJ4bn1Cav4497WZ7/VwJxfJZMum6nRnht9tuyvTczTFzRUqAZl/ql
	wA6pNDxOO0xl3S7akBaj92lL36sw+Fy/rTORBv7Y27cXXiWZ/LGgyvKrfrY3XU6eUCAl/9+
	B+oCPHwvAhskVVAfeWCq2UJgyVTlQ71iCLvQw2MhhBXxtlleLFOVnyO4P79wAfzs+3PmD3V
	nRXUPD2nYvG2jHnXdLulOPv9XCPiYEPH5qk1XYRLIdf5yiTDKqyb9ig9JCZFY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yaojun@mucse.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mucse.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300153-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nic-Precision-5820-Tower:mid,mucse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E4556995D2

On Wed, Jun 17, 2026 at 11:40:42AM +0200, Andrew Lunn wrote:

Hi Andrew:
> On Wed, Jun 17, 2026 at 04:35:31PM +0800, Dong Yibo wrote:
> > Mailbox data is exchanged through 32-bit MMIO accesses but the
> > mailbox payload is defined using little-endian FW structures with
> > __le16 and __le32 fields.
> 
> Given you are using __le16 and __le32, why did sparse not find these
> issues? It would be good to understand this, because if sparse missed
> this, what else has sparse missed which is also broken?
> 
> 	Andrew
> 

My understanding is as follows:
The firmware structures are defined with__le16 / __le32 for wire format,
but the original code cast these struct pointers to u32 * before passing
them to the mailbox read/write routines:
- Send path: (u32 *)&req -> msg buffer -> writel()
- Receive path: readl() -> msg buffer -> (u32 *)&reply
Sparse only sees pure u32 = u32 assignments here, so no type mismatch is
reported. In fact, readl()/writel() operate on 'native CPU-ordered u32
values', not little-endian values.
The __le annotations correctly describe the firmware wire format, but
the original mailbox transport using plain u32 * buffers erased all endian
type information at the MMIO boundary, hiding this mismatch from sparse.

I have also checked the rest of the rnpgbe driver: all __le types are
confined strictly to mailbox firmware structures, and this fix covers all
MMIO <-> structure data transfer paths. Comparisons between two __le fields
(e.g., reply->opcode != req->opcode) are safe, as both values share the
same byte order.

Thanks for your feedback!

