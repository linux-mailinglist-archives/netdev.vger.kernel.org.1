Return-Path: <netdev+bounces-259662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBDCDVkamGki/wIAu9opvQ
	(envelope-from <netdev+bounces-259662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:24:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CED165A16
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD87303C604
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B43358C0;
	Fri, 20 Feb 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuXLO3hx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3C3358B8
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575722; cv=none; b=BxNlWeOhC1ZsBYdVlrbqIksojeLVZeqjAUuQHXEGS7Bmje3X1m+UHEQsaXPeck2VFXa0fGnIDMtjhQEkt4O8iycuhreJAtGaaostOXXkmyopuSSd9arFbdaXJ0l/U5riNEmzPtzwlwvfqgFvZWkYRqVgHin+64Szwt4+o986M8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575722; c=relaxed/simple;
	bh=wESvlSEbldOoxwn35sM2kDfazzaW3mTiu1L3Bu/NAaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVjtZC86kWQH0S5v7RdCbMZL+uWyxb2ERQEF/q1FtQ/aTphFd8TVWiTwADTKMvuZ3zW8lJVt2vrxMTQ2qNkesW8QInq9XUe+dMhjIvIAMINX2nhs7GmHCEsPjs2eln3fZ6bC12VsLhVF+RpQADBfSvjN/e6HYwawZtF6u2tnJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuXLO3hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146B8C19424;
	Fri, 20 Feb 2026 08:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771575721;
	bh=wESvlSEbldOoxwn35sM2kDfazzaW3mTiu1L3Bu/NAaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuXLO3hxbc7UV7e26d2w5DTZmAO3qu5dWgYCTpwVOtu7X3CS0iC8bj3meY0U6Eunf
	 /BW2PNJOmtZYA6792KzbiNsrdg3+teen7qJIP9ViogvNVIjePctFybprN0iE5e1G+S
	 p6gVvWo90IWpmu3d7UVKGB8v7qqLXAd4KcIM6cRGorNxlql433O2i2axo/0jpaREPi
	 SSV2OeMpHoZDdXZr6GuHWo158+Fd93y6Sd6tT6Ob+wOXARwaLQGqVmsC4DVg2BeVK2
	 LsbLO0MX1m3K99BVop8b5sXuWhlDUhVGWX7GsMCqZa8UatZyrRg6+tC57Ob5Q3JHmw
	 MQDeK7Bczm2Rg==
Date: Fri, 20 Feb 2026 10:21:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: satishkh@cisco.com, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update enic and usnic maintainers
Message-ID: <20260220082157.GD10607@unreal>
References: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259662-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email]
X-Rspamd-Queue-Id: 85CED165A16
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:24:00AM -0800, Satish Kharat via B4 Relay wrote:
> From: Satish Kharat <satishkh@cisco.com>
> 
> Remove Christian Benvenuti from the enic/usnic maintainer lists because he
> is no longer working on the drivers and the email address is no longer valid.
> Keep Satish Kharat as the enic maintainer and the usnic co-maintainer.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04e5fb80c..239a1948c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6173,14 +6173,13 @@ S:	Supported
>  F:	drivers/scsi/snic/
>  
>  CISCO VIC ETHERNET NIC DRIVER
> -M:	Christian Benvenuti <benve@cisco.com>
>  M:	Satish Kharat <satishkh@cisco.com>
>  S:	Maintained
>  F:	drivers/net/ethernet/cisco/enic/
>  
>  CISCO VIC LOW LATENCY NIC DRIVER
> -M:	Christian Benvenuti <benve@cisco.com>
>  M:	Nelson Escobar <neescoba@cisco.com>
> +M:	Satish Kharat <satishkh@cisco.com>
>  S:	Supported
>  F:	drivers/infiniband/hw/usnic/
>  
> 

Jakub,

I assume you will handle this; is that ok?

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

