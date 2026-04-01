Return-Path: <netdev+bounces-273823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BH+HRV4zGmxTAYAu9opvQ
	(envelope-from <netdev+bounces-273823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:42:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078C373889
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 051D53001399
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA02777FD;
	Wed,  1 Apr 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlZZAnSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961D175A6B;
	Wed,  1 Apr 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007706; cv=none; b=ZS/I/48c5ovYl3lX0fCukOH7JnGXzItCTm184bTtIeqYf3eXqLtTETHOsB9whYx9uGOscCbn8JTjcuFNX8Q1GNhjOEU9psHcDWl7cDV3yDLBEcAfIm7fsFjCJ7wBLaY4RjJSTKe0frOGccwYvPHDY1UxqqGe7dNnpQcSoAT84I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007706; c=relaxed/simple;
	bh=l90JA4GnbclL2LtNxVZVwnt2WU2yKWlxAnYhL7O4gBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOih3eRi1w47S5lkgH5acOqN0DzBH3tdmjRPX0CZm5GT5TceFnU2Y5DThA3i5xQLPM4dTbTIefwbV5f2jR2ZhZEUqHxd73IRaqNUKIKXnJ6rzwnXPLXJSE7V38aQNWYbzo5tr8fbVacRcjYaOrLVTwsV+TtqH2C/5r9P6XyaGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlZZAnSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0EEC19423;
	Wed,  1 Apr 2026 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775007706;
	bh=l90JA4GnbclL2LtNxVZVwnt2WU2yKWlxAnYhL7O4gBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MlZZAnSGIKtQkhIAXfqNocXep5jV7U7AxivS2bKifKGbVMQZrcyYPXJtbSe7s9tyY
	 rFsn8EZ/UBvfXrV/JWGwhSf/KBejQd333VYOII700+dIt4f8MUai3k+wKWrZl2Hxf7
	 73llqUlLUCmgPghZov60fpU5vJGLiEnTnpfVdShh4Y8bHIqRF28MRRsOTqBA/jjl3b
	 5mlSQONq7s0CrGbOaLuXUZ3aotrHpwO2zcYGh9jzJk8HMiUDcTjC3qyrnUupwPkM50
	 hL2pTYO32w3/3uhG78ONMWqMmxIVRXUQLni2lCLkRA8ihAmbZREaEyZ7JmoJzpxlg2
	 cnrmN5hC1/CNA==
Date: Tue, 31 Mar 2026 18:41:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Wang Jun <1742789905@qq.com>, Jes Sorensen <jes@trained-monkey.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-acenic@sunsite.dk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH] net: alteon: Add missing DMA mapping error checks in
 ace_start_xmit
Message-ID: <20260331184144.7643062f@kernel.org>
In-Reply-To: <acxcGhzbNsHdK49W@devvm20253.cco0.facebook.com>
References: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
	<acxcGhzbNsHdK49W@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,trained-monkey.org,lunn.ch,davemloft.net,google.com,redhat.com,sunsite.dk,vger.kernel.org,bjtu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6078C373889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 16:43:22 -0700 Joe Damato wrote:
> On Tue, Mar 31, 2026 at 09:48:41AM +0800, Wang Jun wrote:
> > The ace_start_xmit function does not check the return value of
> > dma_map_page (via ace_map_tx_skb) and skb_frag_dma_map when building
> > transmit descriptors. If mapping fails, an invalid DMA address is
> > written to the descriptor, which may cause hardware to access
> > illegal memory, leading to system instability or crashes.
> > 
> > Add proper dma_mapping_error() checks for all mapping calls. When
> > mapping fails, free the skb, increment the dropped packet counter,
> > and return NETDEV_TX_OK.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")  
> 
> Is this fixing a bug you've seen in the wild? If not, I'd probably drop the
> fixes tag and send this to net-next instead.

Either it's worth fixing in net or its not worth fixing at all.

My preference would be to try to delete this driver completely.

