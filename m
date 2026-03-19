Return-Path: <netdev+bounces-269250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAhaByVSu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:32:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138A2C478B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B3131A5172
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FAC27E07A;
	Thu, 19 Mar 2026 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buj/u3Ne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0F274B28;
	Thu, 19 Mar 2026 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883756; cv=none; b=fxfNur/L3BJuBtJcqjbqiSmowzt4HLPDm/6baQFxv3im1Mj881DcrzThKvN03eS9mlp2riE0Zng8rzljAcrHizD3sbUqI5y2gNZy2/G+WbvMKCMELgudGGULen9UgTBzzWXL95ACkro49qbhUvY6EvPd8RrLEIQr1n8Cpwe4zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883756; c=relaxed/simple;
	bh=uesbNCuani5ZswAWIZ23FLTqykJO4QCLxGxunF6beRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkHGsGYE5W9jxQY0urLGGiCCvJq64hAHS04nAtNx0XHq6UGEOA+yy6tr6A3ztFeoIsVTXFh6knMDkt8MUQpZMUEX576+2R/Q+1XUdLPFGCIVmAiPxhOCZ3FHcJtHB4K/6rEjme/uJ1OYG4kqoXOK+LoZjSG+JfdIj9gsY8wjqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buj/u3Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CFC2BC87;
	Thu, 19 Mar 2026 01:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883754;
	bh=uesbNCuani5ZswAWIZ23FLTqykJO4QCLxGxunF6beRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=buj/u3NeK4KErQP/SgT757aSvQE9vS1jTpWjVkcps8g0kT46uakOpyZLQOzEYT4pL
	 WP/LNbAxmILlipphX5ZYOxbxjZdozIGS7FVfGkCqJmjmPsKB9gyeG7nfBu7DsixDk1
	 Yw/oNjSE14KZQxCLBdqBx9ZWDAwqf8aeaIGPn0ln9PlpmIijrFzCMZ0nI7Gvhx7GKd
	 y+RsrDGBf3kVo+7pG/uQOd+RRtBl3sXwtGzoLLPZ8/hV0fjupVKbGFFwHRGZULzM7Y
	 LGpa1W2GBVXW0AJdTDsRu5Fdgmo5zcpECCwCnRa/CzPydRtNIgBjgXxfWL7aKNPkvV
	 5jUX1zoN5Pvcg==
Date: Wed, 18 Mar 2026 18:29:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: phy: microchip_rds_ptp: simplify
 allocation
Message-ID: <20260318182912.06cff868@kernel.org>
In-Reply-To: <20260315214527.4113-1-rosenp@gmail.com>
References: <20260315214527.4113-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269250-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7138A2C478B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 14:45:27 -0700 Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Remove memset as it's now allocated by kzalloc.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. 

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

