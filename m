Return-Path: <netdev+bounces-260436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBEjN0JynWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:41:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E829184CE8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1CB300D15A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6636C5A2;
	Tue, 24 Feb 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjAYE6G4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D936C584;
	Tue, 24 Feb 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925834; cv=none; b=nHBp1YTvqUfyGjZFLCN91JVqoZiSxwv/sw1mh38j5P0+1ed3oM6GV1AvGEOq6opo63bRk1tG+iRtJQEW3CAw9qHC4BnfvM7z+OX2l70avI6T67ATO0IrbGXTP+3nv4WPJqUfmMnMpv1oklpsfwU2d4acWGCNcch05SuB4ZI8ClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925834; c=relaxed/simple;
	bh=N8WmkEqhWZu+jveubVScw5voh1Ygh85+P1NCjctqWUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8UlnboeKaPL1w52uu6b34Rhgx01dC+bpXceGiT4GrSbnIVmXaXvNRCIDOn5KcBaQ9l8r0M/3ZcOIbnyi5iYajX3juW5n3r9w/N+W0T5haiQvFAMaDibrwdtgS6OS2U+Hlye9Gb1n7s2qSA9E7buiHV/Dy6OU+jj6Kry0xo9v5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjAYE6G4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6596BC116D0;
	Tue, 24 Feb 2026 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925834;
	bh=N8WmkEqhWZu+jveubVScw5voh1Ygh85+P1NCjctqWUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjAYE6G4nhqNaANz6wlNAh/8ucyxg9dDWOhivVdZaB/KWqvn7hVufismdQMNftxFJ
	 vEzzW/1/PVcmb2flcxi81mCNlteep7i5UoQxb+sMoHyo2+ZKHwKQ+mJr9y3VieP3f/
	 p78oDBm/DV+j21Z/KEazl9+ZX+EtnPQWy7Mh/RRDae9Kv3FH0A77fx7SFuSuNiHfO3
	 axivUx6iF0Y60khzkdsEpxmx5wtaUqxfCV3eEi89g9vrX39aU4/SxgLhfGoW8fJ2cm
	 +bGjQc8Kcpzaj7FZVrVcfpZ6sqcizwhirq+yOooEl3HzsTZOdEK89EdN1hCrzcSRIl
	 Wc1McD4xZ6U8g==
Date: Tue, 24 Feb 2026 09:37:11 +0000
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: kaweth: validate USB endpoints
Message-ID: <aZ1xRzIJGy7c0bki@horms.kernel.org>
References: <2026022305-substance-virtual-c728@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022305-substance-virtual-c728@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260436-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 6E829184CE8
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:00:06PM +0100, Greg Kroah-Hartman wrote:
> The kaweth driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg,

This seems to go back to the beginning of Git history, so this seems
appropriate.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

