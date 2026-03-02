Return-Path: <netdev+bounces-262661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKvGLhuapWnxEgYAu9opvQ
	(envelope-from <netdev+bounces-262661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:09:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D321DA679
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2DD13030755
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8D3FB07C;
	Mon,  2 Mar 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkicWOLy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C63FB075;
	Mon,  2 Mar 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460096; cv=none; b=rxspv3V0Yr0m+St8Qmx6inmT0zQOk4A7bn99/qHTQ48zWg4D0tbDMKMItgelrmJYttMaTk4eMawtSbwAoC4UEBuUhv83OcJl1mx0FQmNrv67bynvvVPKecSHh+AayGeo92GXsJyK+ZQJ4mddAFxTjEH3DokptyjnkASqTrFZI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460096; c=relaxed/simple;
	bh=XFMk11oeljHMBhoFTTlUyjc23VWaT7pGRNxgBn2MI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9MvSiR27Cy717vdVEtcBQvBI6fwvEfaB4WDJQH8JIDo5BDT5N1J6NhnmD7L4DI/yIAd/O3oDNIDBO7BKiJMPVvtqxNcRib3YBx+xUPpyjo6dlVIJOiRJ1WmE9dE+Lmem7KEa9N32Zy9w+dZFBq5eLkUIvbf74dobBgI/37xLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkicWOLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38077C19423;
	Mon,  2 Mar 2026 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460096;
	bh=XFMk11oeljHMBhoFTTlUyjc23VWaT7pGRNxgBn2MI6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkicWOLycIxim6Ba3RFZ3Cn5ra6HyL881MpUu6ip8iN3lY+02u/+ncqA/Hb0ROmCE
	 2R44/Ny1Mw1cVFhb7WazrxCJgg2MvaEt47WOjuuIOqEdsJUWf3ExkNJSzfF+w6St7w
	 wUpD1r3sNhX1ad/dkR7/Oo6CZyAdJ6KZfcQG7qOJq+10UKIdHdkicqF9ItQ3HexkI8
	 KMxk4hzdH6Nxk7ItucK4Hn4a+ZY9ADdhBjH7uGU95GSBHtaVfO7toij+Xo+oO8hUAm
	 7dpTiKVfliO/etBxGCdYNIGp6cyeNdTrDW5upVPJa3+W8kPnY6f5a0NvAJI98n3iO8
	 65wqrX5rf80+Q==
Date: Mon, 2 Mar 2026 14:01:31 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] dpll: zl3073x: consolidate chip info and
 add temperature reporting
Message-ID: <aaWYO60jHmmlxsZJ@horms.kernel.org>
References: <20260227105300.710272-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227105300.710272-1-ivecera@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262661-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: C1D321DA679
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:52:58AM +0100, Ivan Vecera wrote:
> This series refactors the ZL3073x chip variant handling and adds die
> temperature reporting for chips that support it.
> 
> Patch 1 replaces the five per-variant chip_info structures and their
> exported symbols with a single consolidated lookup table.  The chip
> variant is now detected at runtime from the chip ID register rather
> than being selected at compile time via bus driver match data. This
> simplifies the I2C/SPI drivers and makes adding new variants a
> single-line table addition.  A flags field replaces the hardcoded
> chip_id switch in zl3073x_dev_is_ref_phase_comp_32bit().
> 
> Patch 2 uses the new flags infrastructure to add die temperature
> reporting for chip variants that provide a temperature status register.
> The temp_get callback is conditionally set during device registration
> based on the ZL3073X_FLAG_DIE_TEMP chip flag.
> 
> Ivan Vecera (2):
>   dpll: zl3073x: detect DPLL channel count from chip ID at runtime
>   dpll: zl3073x: add die temperature reporting for supported chips

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


