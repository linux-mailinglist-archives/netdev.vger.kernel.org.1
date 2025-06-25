Return-Path: <netdev+bounces-201082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40EAE809A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8457AEB21
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2D2BD58A;
	Wed, 25 Jun 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z80AyN6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D55289347
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849691; cv=none; b=cWHd2CncY0h/+zojw7JiGPEMYQk9hn7zms5c7rwwUt0p6WzaCNzqX0pSZLxO2Wx1D1FWqj6JHKF51ob4ZV3n0Z5E5KnFXM4Y/S7YBa4GKIya035oLuYES+cKzF8WpaNHD5hSQxVhL2Czl4ukd6hrynD2eTy4+mCMKiCMGKGuDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849691; c=relaxed/simple;
	bh=in2ZrC/g8/BPj/ywSXMIS6hL14gcqHN5NMuJmzxpw00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebV1yDS2VDxdpT+S1HMXm7N45DP1/PaVdjEPF76UvyY7f4TPY0VSBy8UTPl2Chujn6pNjd9LH6JWHXxW0+c8Ku88Rz26PFiHlLoWsavM9UACwrZSPtcm5bJTml7+IW0cdy7nk2peCssgSrRcNCk65kjJTCY89vj0HcN6TaNWurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z80AyN6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A46C4CEEA;
	Wed, 25 Jun 2025 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750849691;
	bh=in2ZrC/g8/BPj/ywSXMIS6hL14gcqHN5NMuJmzxpw00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z80AyN6m8HOWFV9FNDU3/gnXGKKSKBxNkoXjqrfcBdpOog/Og0gdYjB+zj1nOHqMC
	 Cym/8/0aAdlmsWrL2UnD8yT3LZgoVkCIbn+uh/lcP0CyB6HB2Ie07gHtm/FrTUIRla
	 EXW15iL5r0oS+JIu36qeCrTKA4fgbLTRZ1+/XaqTN1JnyBVbCUhrMW8Bstj5+8gu25
	 HwxxMWn6qTyf73AeMmTulZ/d6eg5k91c86+rxYGm3Ku9eEQ+p9MW5lwTbubpDzPxbe
	 Va/UpdbQ8A/wbFvO/PK1FZNVnhyE82JsUzn0tdr3IdNn+cKI7tNQxlGr/smo6UvddD
	 dsgwyv0M3pwlg==
Date: Wed, 25 Jun 2025 12:08:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: Re: [PATCH net-next 4/5] eth: fbnic: sort includes
Message-ID: <20250625110807.GZ1562@horms.kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
 <20250624142834.3275164-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624142834.3275164-5-kuba@kernel.org>

On Tue, Jun 24, 2025 at 07:28:33AM -0700, Jakub Kicinski wrote:
> Make sure includes are in alphabetical order.

\o/

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


