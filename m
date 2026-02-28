Return-Path: <netdev+bounces-262223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKCEHUZko2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:55:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6AF1C9547
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E435930630A4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77361313E31;
	Sat, 28 Feb 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrrMzyBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4E2DB780
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313226; cv=none; b=aI9ss1xL1q5obahXGfGCAJt5S59RIUV7LsJcTFe7jlpNz6F8OF3TQNufV5+wcakoAp7+usLK24oIkP+7CtilsEKkYg2idLDYnp59zijQfhi5xE9cWMTRSUfYCVKyWQCxSVbdl27GBjRUCXUwrNd70kFOfLN9YoWSCA5C27fMskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313226; c=relaxed/simple;
	bh=llKmUUtoEYd0JXFcvQ+fLuLv+VnnT+bDzZL7pnFznKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnbPa+2jjHzcZisWlqcVLMEqRmPSf+PPtBUOiSsw/FdvRyT9/Rv1a7ih2kiu7+/2OGG+UqWb75Kfha0idyNpLgaWkp7t24ygkbQJ44lv0KqSb7EYNBiAUBCpJtnKYpKkRS45KfNxHKAvzhRGlt8DwOzvXWTDFXeO4evD42T+Xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrrMzyBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB8C116D0;
	Sat, 28 Feb 2026 21:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772313225;
	bh=llKmUUtoEYd0JXFcvQ+fLuLv+VnnT+bDzZL7pnFznKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hrrMzyBxSx+PLL15l+YslqwcZnNy6o8c4NKzOd6iQSqpqhCe1H6SvDxt4HmbzZeD2
	 8uOfYO/mLhGcoUK/l/0Bgd9kKrYwaasIzTLBdpz0JkSGhGKrBghl7HzInzUOPbzfsW
	 FLKUqLnmamz776dTxzJLciRidRr98qYwZCmlUXsMvM+kyeFTE+Oiy/tBaAjDLcuWbz
	 JoVwzVaE910++vqxDAYdH2Lv/8YzE64fFaX/h0OvpCVfNAgGMDBU12lTjiq9HzGyat
	 jxWmVDcFr1MwXT4K4rgWJyXIVb6ZcAp6xTRPvVREGXhz5XdUDTe926JzXqrOlQHbk2
	 lzYHjZqU+0esg==
Date: Sat, 28 Feb 2026 13:13:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 8/8] net: wangxun: implement
 pci_error_handlers ops
Message-ID: <20260228131344.6c19f311@kernel.org>
In-Reply-To: <20260227073450.23680-9-jiawenwu@trustnetic.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
	<20260227073450.23680-9-jiawenwu@trustnetic.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262223-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D6AF1C9547
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 15:34:50 +0800 Jiawen Wu wrote:
> Support AER driver to handle the PCIe errors.

new kdoc warnings:

Warning: drivers/net/ethernet/wangxun/libwx/wx_err.c:21 No description found for return value of 'wx_io_error_detected'
Warning: drivers/net/ethernet/wangxun/libwx/wx_err.c:55 No description found for return value of 'wx_io_slot_reset'

