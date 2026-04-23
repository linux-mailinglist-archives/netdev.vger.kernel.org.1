Return-Path: <netdev+bounces-280607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFRlD/C06WkJiAIAu9opvQ
	(envelope-from <netdev+bounces-280607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:58:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A813444D5F2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E123024A1A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761E3CCFC8;
	Thu, 23 Apr 2026 05:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E237C923;
	Thu, 23 Apr 2026 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776923884; cv=none; b=lNVCG4CY7kexMB8U2ZeJU+5ihOKje/70CVvhpc5sY6dkH9a9TRv2euS5MEzXEm8ObEW1+Pt/R5k72951JjeRjg5PayEAy2mw3ImetoStWbPxa8DLXk+Xd1XTY2zTdUtBQcrmtzobDrhrZ4rke8S7ubUcKZUeEnM8JCGgwVUlmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776923884; c=relaxed/simple;
	bh=17CWfY63CJpkL5X3N8B6Nj5ektoHahVkJ4AqnzUiJpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LugwxR5VU2tuVSA9c05D9GQIPkQSYOpWprzFr5JZYfi5AROAMpj3VfXj9rX2gG3CqTiiUwcO3l05mzc0p8MQHCDOyKun2gdMPO7f01pvk3xlph0uFvpHLSODhn8E1oIUYI2LFQhnPXkmgnxjsHZFzOLA11IBGfIq+V52GT7JkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
	id A64F52006ED; Thu, 23 Apr 2026 05:49:24 +0000 (UTC)
Date: Thu, 23 Apr 2026 07:49:24 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Fritscher <michael@fritscher.net>,
	Byron Stanoszek <gandalf@winds.org>,
	Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 13/15] drivers: net: 8390: pcnet: Remove this
 driver
Message-ID: <aemy5Lm9B2dLItdd@isilmar-4.linta.de>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-13-08a5b59784d5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-v7-0-0-net-next-driver-removal-v1-v2-13-08a5b59784d5@lunn.ch>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dominikbrodowski.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280607-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@dominikbrodowski.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dominikbrodowski.net:email,isilmar-4.linta.de:mid]
X-Rspamd-Queue-Id: A813444D5F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 01:01:56PM -0500, Andrew Lunn wrote:
> The pcnet was written by David A. Hindsh in 1999. It is an PCMCIA
> device, so unlikely to be used with modern kernels.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/8390/Kconfig    |   11 -
>  drivers/net/ethernet/8390/Makefile   |    1 -
>  drivers/net/ethernet/8390/pcnet_cs.c | 1717 ----------------------------------

NACK for this one. This is the most common PCMCIA networking device, so
should be removed only once the rest of the PCMCIA subsystem is removed.
For the other removals of PCMCIA device drivers in this series:

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik

