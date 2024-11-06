Return-Path: <netdev+bounces-142318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D89BE40C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA581F229C2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFA1DD523;
	Wed,  6 Nov 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7S+b6At"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720661DC747
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888288; cv=none; b=n+5P3IygCFxKUluHBavBMEYhEolv3KJPRo6xDKPquCyx46K0KWh3Hy+VNoXR3EFNCBU6z0K9Vz886pGU3W9YelLzr/WzbHhKZUPKNFE/bLH+GE48jG1gW/ZYCsK+jLYEl51S69rgfxBNyYd4wlHIjv2nwaVajss0Zre77wj2E1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888288; c=relaxed/simple;
	bh=12HzFz08y1i2tWb3JlGpLFzmf7rRqgM2C9+E1f4r2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkbLbHVZX0MJpCJFwG2rq6c46kmtGzXPbjDZWW48gYaSEeBxA6eS9bSTNCxROiMyn8tjNiDhxqU9sy0npWWTbY53gQjkHpTQQpP4Q2F84xeJAoETQssi4a7s17uwdlUeU9NyDZujJlBULzb7zlEzcEojdkSl+OCSHR3ncIRSAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7S+b6At; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F51BC4CED0;
	Wed,  6 Nov 2024 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730888288;
	bh=12HzFz08y1i2tWb3JlGpLFzmf7rRqgM2C9+E1f4r2qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7S+b6AtgouMqqZLOcjEXJ4ogF/Tzq8uSfWq6zt2LElVloeqCNoA5nFXj/Dr6walN
	 3WraTn2aFbUGMHcSuLW0Sc8gMa7dH3Lg1SwuECcepfbhHmiFPUsvdL8X7lV8inrA79
	 4kgp3DfcKr6+PuUj6J46BQ20i+f30mGX/3kAuhs5s7o+WSu15dAiPkU2L5JGMNDSQW
	 lYBeSc6EmVenzCGYJlPUwIScss8UdevQ1zJRiax8l53ScbUbQYDvfM6tMxAzLmLDCN
	 1Tm1D2CeINTJt/MmVQXAOahqg1VeEjiEOAIs0tXnnUfAo3BwwqF4o4bVLkde0EFIdY
	 DClpF6V+XPCHA==
Date: Wed, 6 Nov 2024 10:18:04 +0000
From: Simon Horman <horms@kernel.org>
To: Juraj =?utf-8?Q?=C5=A0arinay?= <juraj@sarinay.com>
Cc: netdev@vger.kernel.org, krzk@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v2] net: nfc: Propagate ISO14443 type A target
 ATS to userspace via netlink
Message-ID: <20241106101804.GM4507@kernel.org>
References: <20241103124525.8392-1-juraj@sarinay.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241103124525.8392-1-juraj@sarinay.com>

On Sun, Nov 03, 2024 at 01:45:25PM +0100, Juraj Šarinay wrote:
> Add a 20-byte field ats to struct nfc_target and expose it as
> NFC_ATTR_TARGET_ATS via the netlink interface. The payload contains
> 'historical bytes' that help to distinguish cards from one another.
> The information is commonly used to assemble an emulated ATR similar
> to that reported by smart cards with contacts.
> 
> Add a 20-byte field target_ats to struct nci_dev to hold the payload
> obtained in nci_rf_intf_activated_ntf_packet() and copy it to over to
> nfc_target.ats in nci_activate_target(). The approach is similar
> to the handling of 'general bytes' within ATR_RES.

Hi Juraj,

Perhaps I misunderstand things, and perhaps there is precedence in relation
to ATR_RES. But I am slightly concerned that this leans towards exposing
internal details rather then semantics via netlink.

> Replace the hard-coded size of rats_res within struct
> activation_params_nfca_poll_iso_dep by the equal constant NFC_ATS_MAXSIZE
> now defined in nfc.h
> 
> Within NCI, the information corresponds to the 'RATS Response' activation
> parameter that omits the initial length byte TL. This loses no
> information and is consistent with our handling of SENSB_RES that
> also drops the first (constant) byte.
> 
> Tested with nxp_nci_i2c on a few type A targets including an
> ICAO 9303 compliant passport.
> 
> I refrain from the corresponding change to digital_in_recv_ats()
> to have the few drivers based on digital.h fill nfc_target.ats,
> as I have no way to test it. That class of drivers appear not to set
> NFC_ATTR_TARGET_SENSB_RES either. Consider a separate patch to propagate
> (all) the parameters.
> 
> Signed-off-by: Juraj Šarinay <juraj@sarinay.com>

...

