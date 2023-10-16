Return-Path: <netdev+bounces-41262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413977CA654
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E5E1C208E9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABF219F3;
	Mon, 16 Oct 2023 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7kXO24M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCF14283
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BDEC433C8;
	Mon, 16 Oct 2023 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697454784;
	bh=LIAd5eIB7WxazbMRVYdEI0ou++tgLkv4FU4blqvs1Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7kXO24MJR3Abl4R5dtCPiwxWpfmLZhFN5moKBSrzWQYaI96BMBxjpoP5EaeT/f9D
	 V1JjfmVl8BHSy/bgcZs2lAg/aBIzl5d4VFM6708PMLWsQ88Hu4WbqnySrmrPEsZU7A
	 qpe1pSUSPz1G9zUFs0iwDNHIvG9s4e9hklUcqYL7P2Ck2RbVp9HDZMXi+B25wmzJux
	 IDklju0MfxQsI5ShXFU7hxwqCicPH27eE1GxqvsipUujX4c9Kp3U2NDh864M9U9wV7
	 ZhRXOZAqyklV53kZnufABTDsqdXhfoK9D0/J42I1AC+2iT3xnXjZ9grlQgMvnQ2NiG
	 1OdPFeqXfwDLg==
Date: Mon, 16 Oct 2023 13:13:00 +0200
From: Simon Horman <horms@kernel.org>
To: Aniruddha Paul <aniruddha.paul@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, marcin.szycik@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net,v3] ice: Fix VF-VF filter rules in switchdev mode
Message-ID: <20231016111300.GK1501712@kernel.org>
References: <20231013134342.2466512-1-aniruddha.paul@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013134342.2466512-1-aniruddha.paul@intel.com>

On Fri, Oct 13, 2023 at 07:13:42PM +0530, Aniruddha Paul wrote:
> Any packet leaving VSI i.e VF's VSI is considered as
> egress traffic by HW, thus failing to match the added
> rule.
> 
> Mark the direction for redirect rules as below:
> 1. VF-VF - Egress
> 2. Uplink-VF - Ingress
> 3. VF-Uplink - Egress
> 4. Link_Partner-Uplink - Ingress
> 5. Link_Partner-VF - Ingress
> 
> Fixes: 0960a27bd479 ("ice: Add direction metadata")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Aniruddha Paul <aniruddha.paul@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


