Return-Path: <netdev+bounces-254253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD1dOoYJemkK2AEAu9opvQ
	(envelope-from <netdev+bounces-254253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D51A1C7E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 156F73006125
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A734DB6F;
	Wed, 28 Jan 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MUEfxRY2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CF2D780C;
	Wed, 28 Jan 2026 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605507; cv=none; b=fO4hwQkCOTOraAkAf9egg2bwK3mfeadGRGYFA31jOLAronMBqh4ondaqzF7YiHd3Bsj0CCISTnYEqsAvRnRCvI2cm7Mm4TLrvIxZG1/kjYFQcJzRrm2rWGLpCpF13ItnBBKHvORvTCN/YvYlmMf/0UswcRO5mTVt6sXpGL6VZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605507; c=relaxed/simple;
	bh=ESTMSMTFDgwYwQdrt7kTe1Fh+2+qEtuoiPYtYAXlcc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN66/oeD3q6w4sN1qQvhTRPx0tARHMHXW8nGmTjxLOUScUs58JZD6Y5y0ywAzWIa26JLVXaPWIzwK0Xcwpl1COPmPOlhsXCNA3w5s0DgNeu/KF6DSJMlY/iaqNa9vWPmAuoY+hGT5OqX3P9msvdrr3OFqN10H5HzwNZ4zd9gXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MUEfxRY2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ed+M5p6EMFjUlX1FF69lLrmjPkwCamn1MHDppwDEglk=; b=MUEfxRY2knk9AlDTawZSXvSjYd
	Wq+ksifZhFHu0Vc23ktejkfptSo75pY1RJzjqO+KGNPbY0qlTcxW4qkKlglmUtcaW950yLrM3pmSS
	McWWrF6RbEBL4Sl7SnaDQWa/O/qtqVg+Prz9j2EYtqueWcVMA6EmpxhJNpptor95U3cU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl5E1-005BAT-C6; Wed, 28 Jan 2026 14:04:49 +0100
Date: Wed, 28 Jan 2026 14:04:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v1 0/3] r816e: Add r816e driver in Realtek
Message-ID: <4a8f6225-09b5-4320-bfe5-4248b4a99844@lunn.ch>
References: <640c373b-09d9-4b54-9113-782df41aa152@gmail.com>
 <20260128065309.556-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128065309.556-1-javen_xu@realsil.com.cn>
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
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,realtek.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-254253-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 35D51A1C7E
X-Rspamd-Action: no action

> RTL8116af is a multi-function device. fun0 is a BMC virtual driver and fun1 is
> the nic driver. The BMC virtual driver(fun0) is used for power management,
> while fun1 provides the actual network functionality.

This is the sort of thing which should be in patch 0/X, because at the
moment, this patch series makes no sense to me. You need to explain
the big picture, especially when doing something so odd.

What does this BMC virtual driver do? Is it providing an NCSI like
device? Should it have a real driver at some point in the future, more
than this stub?

> >>   r816e: add a fake driver r816e for RTL8116af

Please could you explain the naming. The device is RTL8116af, yet the
files are r816e.c ?

	Andrew

