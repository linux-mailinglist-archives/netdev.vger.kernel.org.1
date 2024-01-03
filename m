Return-Path: <netdev+bounces-61061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7B8225CF
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C587DB229BA
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2702580;
	Wed,  3 Jan 2024 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsSJz0WK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5A257E
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6551CC433C7;
	Wed,  3 Jan 2024 00:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704240328;
	bh=YHMoYUYF/CB03LXIl3XKRG/w1sBiHcrzCQwFRZ9nCXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZsSJz0WKxU6M9DfRiT2CWOPv4x54frW7ACHEHvm5bHX7zJtMdnaPIPSF3NtlpoY8G
	 6aS3LgqQVi0Wl52+Nkr9NIXPluFnRefUXf51BEigvab4as9cKNHCW5H37wfHK9nwYP
	 QYjk6NkKxSiZoATWTPN9OhJMIYaJs2gbo5a+iX3ip3C8ibsQAar2HKJHYZEnmyTBuU
	 sJmasVl9KKUu4Rbr2FKaWZ7Nw8EWzG/ElMPsx8Ck9GgUYW+s9ObFdtnfYlr1kHeUUu
	 j2IVrN2An7/L1UT3x0DNT2XVEfFhCpO2ZFew8mBeZKxR+UslBLIlgC9SBzVGd+kfkw
	 8YqHMwDHqlL+w==
Date: Tue, 2 Jan 2024 16:05:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch,
 horms@kernel.org, mkubecek@suse.cz, willemdebruijn.kernel@gmail.com,
 gal@nvidia.com, alexander.duyck@gmail.com, ecree.xilinx@gmail.com, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/2] net: ethtool: add a NO_CHANGE uAPI for new
 RXFH's input_xfrm
Message-ID: <20240102160526.6178fd04@kernel.org>
In-Reply-To: <20231221184235.9192-3-ahmed.zaki@intel.com>
References: <20231221184235.9192-1-ahmed.zaki@intel.com>
	<20231221184235.9192-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 11:42:35 -0700 Ahmed Zaki wrote:
> +	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
> +	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))

This looks fine, but we also need a check to make sure input_xfrm
doesn't have bits other than RXH_XFRM_SYM_XOR set, right?

