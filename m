Return-Path: <netdev+bounces-211385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326EB187F6
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25F6164830
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2511DE3CB;
	Fri,  1 Aug 2025 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAnBlyG8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFFDF71
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078809; cv=none; b=aeoSXgZcreAz21ZMY1UymzUEvWRU8G2vkdtq0vNHrsKMrPw7BEpBDoLpSw6qhB/XqtuvfqtxflpO/C9lbXY39oBzVHOEbOIZWh4TrAfJwDBBPxzlO6avS/pSG3/UjTmVZQsOxaeYSf1C/1jWP26iMITgH1M4h4aWRBeOdiUWLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078809; c=relaxed/simple;
	bh=T7/74GDSNVPhlAsnSqKd+bYVq/4pK/GDutVg+bbGPyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1KTwqouVJp0xw412KMCmRuzpA4Z2EgnlNgReYUMXl0e9v81HaydVemxDXF1eV11+dDtqMfF327E5THVd305jtLGjUWB6ClMdEJGLCqOjtVAHFijQ7JSOKCA8xGZ90vpdKuZrb2aEVOC/XqnL1hf8EhxLY0sBbJ9GXhh9i0S3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAnBlyG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2108C4CEE7;
	Fri,  1 Aug 2025 20:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754078809;
	bh=T7/74GDSNVPhlAsnSqKd+bYVq/4pK/GDutVg+bbGPyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sAnBlyG8blUfyGmDkkkwg6RrtOjkJ+MD0g/Rfz6HsmeAglcOkldBzgC6RiS/ybKkl
	 qMphAhXuXCaiJtIKB600PIHTugUeAZ4bRARSQzanOtERuNEeI29idNcWrcs/4/N2P2
	 UmhFVw7yq656lo7FRV2gIvAkXZTuN29WvRLIDEnEOAndOWu7DGGeVErR9Vovju7u0G
	 KESESRcrHeeUhXSaSgkFB2TrjuaKBxurDLwqO8OkOkepui6hvCNyk7cf9u420ynijl
	 Uigg33eMBnyhz34T7CNJXOFypx9wmY1m0MZLG+gjQ55ClXAjuClQdG6laQvQGpFWcj
	 rFqignGYiKelw==
Date: Fri, 1 Aug 2025 13:06:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <netdev@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v2] ethtool: add FEC bins histogramm report
Message-ID: <20250801130648.341995ba@kernel.org>
In-Reply-To: <20250731231019.1809172-1-vadfed@meta.com>
References: <20250731231019.1809172-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 16:10:19 -0700 Vadim Fedorenko wrote:
> - remove sentinel (-1, -1) and use (0, 0) as common array break.
>   bin (0, 0) is still possible but only as a first element of
>   ranges array

I don't see this change in the diff? It's still -1,-1

Also, not seeing per-lane support here.

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 1063d5d32fea2..69779b51f1dfd 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1239,6 +1239,30 @@ attribute-sets:
>          name: corr-bits
>          type: binary
>          sub-type: u64
> +      -
> +        name: hist
> +        type: nest
> +        multi-attr: True
> +        nested-attributes: fec-hist
> +      -
> +        name: fec-hist-bin-low
> +        type: uint
> +      -
> +        name: fec-hist-bin-high
> +        type: uint

The bounds can be u32, TBH. The value really is a u16 but we don't want
to waste space on padding in Netlink. Still, no need to go all the way
to uint.

> +        name: fec-hist-bin-val
> +        type: uint

