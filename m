Return-Path: <netdev+bounces-250242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50967D258D2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC59E300F191
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8AB3B8D45;
	Thu, 15 Jan 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCPw/h/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BD37E2EB;
	Thu, 15 Jan 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492766; cv=none; b=USqJ0nOODR3GcDpa8SeaSRlzBskKKwokYSGx9W2glWSzLpAawU0um2WOVczYIEaOpCxXlNH4YqMHfRhIVXc5gaQHRQD0pn79qN9RoCdmbRNT0q35YVgEYZVC9Bm+0qPk8fpPU2vw7ff6njCRMiuh+mWbulCzEluyf7OSDVyzuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492766; c=relaxed/simple;
	bh=bN9CLGNNCXd7vykIUfCDDnj+ImOvf0EhGAdjX48YNxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQWH/HeOWEo645ynVVMWQfrPiTp9C9tv4qp54ggOuN3LyokhY6I6WuM+bBnVk9lnVnkQ0iwYSbCnGigHSAJ0vgbsU2seO+gz5q6z9bTXgeXHPj+VVp0ExBsPjR4HN/yp4BdFuc8OV5o/3K+WWGaMihhjs3oJ4rNauApzFFzpxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCPw/h/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF94C116D0;
	Thu, 15 Jan 2026 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768492766;
	bh=bN9CLGNNCXd7vykIUfCDDnj+ImOvf0EhGAdjX48YNxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCPw/h/iq8wq47poL/XsPwxnR/U4QcUbLK2m017UAPPGx/Uv8IIL6hPZfRfwH2QG5
	 sVBjvXZpmEtC0OI47IDSh0j6hptIlsJA2e8I/hwFcMZgAf/TTqcauwBYVeGGWvpWE0
	 2mLptrXRw2Nggvj47G9nwjIc1BA3mN7gYfmulZ2Eurl1g8X/ooJlc9ORFcsS/j7+DK
	 VLzr/Q3zJ5LJrvY3t6INv97dtgG6RiOy7B94QldSH6JRxv0qNxPlSBHSnHPe4Sbjil
	 ow476hGSAjSeaubrA97JM7Dd4U4Q1bAAFq5FhPfvk69FHM+u6w39aZkMtD/x6D/Ask
	 +OYvFm5l276Vg==
Date: Thu, 15 Jan 2026 09:59:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Osose Itua <osose.itua@savoirfairelinux.com>
Cc: michael.hennerich@analog.com, jerome.oufella@savoirfairelinux.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: net: adi,adin: document LP
 Termination property
Message-ID: <176849276514.689697.7161411224164893001.robh@kernel.org>
References: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
 <20260107221913.1334157-2-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107221913.1334157-2-osose.itua@savoirfairelinux.com>


On Wed, 07 Jan 2026 17:16:52 -0500, Osose Itua wrote:
> Add "adi,low-cmode-impedance" boolean property which, when present,
> configures the PHY for the lowest common-mode impedance on the receive
> pair for 100BASE-TX operation by clearing the B_100_ZPTM_EN_DIMRX bit.
> This is suited for capacitive coupled applications and other
> applications where there may be a path for high common-mode noise to
> reach the PHY.
> 
> If this value is not present, the value of the bit by default is 1,
> which is normal termination (zero-power termination) mode.
> 
> Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/net/adi,adin.yaml          | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


