Return-Path: <netdev+bounces-258760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q7Y3ELt4kWlBjAEAu9opvQ
	(envelope-from <netdev+bounces-258760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 08:41:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60513E3C8
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1861D3010176
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC9239E9B;
	Sun, 15 Feb 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqn4X9w4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC68F48;
	Sun, 15 Feb 2026 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771141304; cv=none; b=gRUTQD+1mZHu3ltt1H3GNG700YgNwRMbGAm95hlzAmGOVw+ymisz2Eh+D2HKxTw19nsgnMCJF/8PkbrHL0l7C4t5uYZK4H/NB1us6x0O1Au1R0MFghXH2oG8GIwT3HJ92eDISYiJoVEpLF+aaNuIMnxxEpQcQ2sP8xwXR62CnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771141304; c=relaxed/simple;
	bh=WF5JAtFaQBxTZsull+nejNp501IkpzjIzqxu5mudPps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsyTvA0IgnIbFuGT8AM8ijVommrFqZWe0bN5yFIWOreDr0FbfPZRcuIj005wk/dijlmMLJlq7lgoSjyz9Vs4eVrJLo7937H0T7JT7ZEf5aR4e9/vNmss3Lxu/Vr6hTFcYSdsjoG6ukjdqy9+bUV2U7ZLlC6nvsvhkUqBBmFSSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqn4X9w4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4417CC4CEF7;
	Sun, 15 Feb 2026 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771141303;
	bh=WF5JAtFaQBxTZsull+nejNp501IkpzjIzqxu5mudPps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqn4X9w4yTzocV28ummD8MWO/hu9fnNWtvqV5W+fhC6O7iD/k6cv7A+NIGhiEJppO
	 BgmPKEDnHZd19PpRRu4qTO771yxSRFVal03nbj7LStzo5zXvmjvRuIhMQMuf0Iq4Mg
	 RKKwd9xodUyUjf5ZNtAbq+rdwz5sFBQZbtUDz+TqyBRSscIPDiulD0r3V1OGYCZUt9
	 jJWF+UeabAQbrlCMZafYEIK4AB7mQ/bgcy36SYAuMxA2LIXQ6yk1xmH+loHAGTZ/HY
	 QejWhSliDT6C7A8Wx6/+m1oLtD0Rb/kP5f+NB9fnK8nzU0r7pJQ8z9Kfdx1HJPSDKO
	 HHsh0jWCkVPlw==
Date: Sun, 15 Feb 2026 09:41:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: satishkh@cisco.com, Christian Benvenuti <benve@cisco.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop enic maintainer entry for benve
Message-ID: <20260215074139.GA12989@unreal>
References: <20260214-enic-maintainers-update-v1-1-5bec573f90ff@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-enic-maintainers-update-v1-1-5bec573f90ff@cisco.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258760-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D60513E3C8
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 06:26:02AM -0800, Satish Kharat via B4 Relay wrote:
> From: Satish Kharat <satishkh@cisco.com>
> 
> Remove Christian Benvenuti from the enic driver maintainer list.

Why?
I'm asking because Christian is listed as maintainer for
drivers/infiniband/hw/usnic/ too.

Thanks

> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04e5fb80c32c..8b122a39dacf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6173,7 +6173,6 @@ S:	Supported
>  F:	drivers/scsi/snic/
>  
>  CISCO VIC ETHERNET NIC DRIVER
> -M:	Christian Benvenuti <benve@cisco.com>
>  M:	Satish Kharat <satishkh@cisco.com>
>  S:	Maintained
>  F:	drivers/net/ethernet/cisco/enic/
> 
> ---
> base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
> change-id: 20260214-enic-maintainers-update-f7968ab3b54f
> 
> Best regards,
> -- 
> Satish Kharat <satishkh@cisco.com>
> 
> 
> 

