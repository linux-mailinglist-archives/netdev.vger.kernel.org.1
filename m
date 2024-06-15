Return-Path: <netdev+bounces-103749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A11909527
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 03:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D469FB20CD0
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46E3D9E;
	Sat, 15 Jun 2024 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blzXKRaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CA3C17;
	Sat, 15 Jun 2024 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718413636; cv=none; b=A9PR15uCoGd9yld2lSYRjs08qJuLAzujIxKWgjxEFyKnfEENR21slk1yfMLj6yiwCZnp/0nrpGtgcL5dy/k2f2kbIzD4Gjfb9bTnTSRHUbnnVgaVfnRCjVIm7HpnbLlBywq85OLBixAPD3e1ouRiVe7aeKYmt4R1nt0Xi/FGOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718413636; c=relaxed/simple;
	bh=zOCIZ5eJ+mVJwBicS2wXoaPx3Xa1pkKZhJVdZwvCgmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXQg/YEgJywP5lfjvtWWEcEa6u647DM00XkHJnKUiup3i/s5lfoo0ifaKPmKji7qBAEJMCv9wNF+oWiEXMFbt3+lbOIe7faE9SOUHifMgMDGTlIwaVWvibeTZhVYAGt8wQYjGZ3ggOKC/5r187yamPpxTTRrWxdm4Jj6bmKgePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blzXKRaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EF7C2BD10;
	Sat, 15 Jun 2024 01:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718413635;
	bh=zOCIZ5eJ+mVJwBicS2wXoaPx3Xa1pkKZhJVdZwvCgmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blzXKRaUeIkfV4FZh3Uu1sZksPEKNNI70c76BOR6SEdnHymNVRIEqpojUpd38bBPw
	 hqp1KUK6X1ANIAfl8KmXfdRH03xsZqlhiYOPB7X4fG8l0umgM7VCovmUwxPAo7vwHB
	 vU8302eqPrglLEpDlTeLZVyCLf1+G/K67mfHBTCRJWZSKPhxO3wp7WoyEMdKCWP4Xn
	 2lmiyGid9nt3WZMJOBlRlh8URXAse5RiRTa4arDdY/YeMYBzoV1g/2FCxrCchyZ252
	 UGR+ZNvLPbv7U5L7ZSwupKS6uEREM2gdtnKwb3yWFX+jJFCb3MpKQ1+ckU4ZzCAU2G
	 t0zK006kGW28Q==
Date: Fri, 14 Jun 2024 18:07:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/4] net: phy: bcm5481x: add support for BroadR-Reach
 mode
Message-ID: <20240614180714.7f81a9cd@kernel.org>
In-Reply-To: <20240613132055.49207-1-kamilh@axis.com>
References: <20240613132055.49207-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 15:20:51 +0200 Kamil Hor=C3=A1k - 2N wrote:
> Changes in v6:
>   - Moved the brr-mode flag to separate commit as required by the rules f=
or=20
>     DT binding patches
>   - Renamed some functions to make clear they handle LRE-related stuff
>   - Reordered variable definitions to match the coding style requirements

Doesn't build..

drivers/net/phy/phy-core.c:16:2: error: call to '__compiletime_assert_1283'=
 declared with 'error' attribute: Enum ethtool_link_mode_bit_indices and ph=
ylib are out of sync. If a speed or mode has been added please update phy_s=
peed_to_str and the PHY settings array.

   16 |         BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS !=3D 102,
      |         ^

