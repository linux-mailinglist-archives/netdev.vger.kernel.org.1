Return-Path: <netdev+bounces-95716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F28C329C
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AC11F21721
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF318E1D;
	Sat, 11 May 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrDidNXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875187F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715446627; cv=none; b=uNJz4cqngScZQ/OX7Cj+Se6H3ZufpWU7RKU5SJF/mBGvQApcmA4ykof0aSAY+Su9m9dzkTt/wtYqAVhQWvaLWPYfXTVl0E2xosMtB8+WD+Ak81/dzqCXaQsZxZhGbjmII/AwrwLTU2jcRtkkZcf+QGFKlap31l8sb2JEY8ecri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715446627; c=relaxed/simple;
	bh=H9A3Ifmn4o4ZDOqzHZ3u3zYShj8DYerAWEvvBW8wdVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV5Mj6IOVoX/M+VVv7Kco6SZMkZ8/YtQ5SCY5gv/D+r4g7gLTyHuefo4SpY2RvI5VlGVDtNFxeesrvJOs/FNaLERNuihjSsgyi6x9T12NAxlr8+miZXBEUDoIMWr20rvW+zBaoQDkog6EPI4+K3PBgtnFIsc/R89wc+RoQqSxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrDidNXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E2BC2BBFC;
	Sat, 11 May 2024 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715446627;
	bh=H9A3Ifmn4o4ZDOqzHZ3u3zYShj8DYerAWEvvBW8wdVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrDidNXyLK6HS9YBaqsuCfTV5Qf3UfpQXI+jcdtzzyzeRgs5PrkuD49JH/PGh7SXY
	 utpj9/cAl0im0Rn0tuxx9gzI3leZ14BmXhuV83Ajzcq0M4zpm1LJndnH68KQ44t+1e
	 bSWSnSH7YArEZUIl9OqZPz2ZJk9lwbAnYGoxpTrUQZnkrFMcwtakvciQo+KCH/ZY0c
	 70UL41+HZR4OvgzJxu/k+/pO7XKOs/cQPKX62bOpwyvB39V0NnBh1jzgLDSl0RdUxU
	 xe6M9JkHOd28zSvRwCwA0yj+dBa6o3ScfZeCspWDt093b57IFLtyhlKCxoAmmtpSns
	 3Gmfc76YXWP8A==
Date: Sat, 11 May 2024 17:57:01 +0100
From: Simon Horman <horms@kernel.org>
To: Anil Samal <anil.samal@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	leszek.pepiak@intel.com, przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v2 2/3] ice: Implement driver functionality to
 dump fec statistics
Message-ID: <20240511165701.GP2347895@kernel.org>
References: <20240510065243.906877-1-anil.samal@intel.com>
 <20240510065243.906877-3-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510065243.906877-3-anil.samal@intel.com>

[ Fixed CC list by dropping '--cc=' from start of addresses. ]

On Thu, May 09, 2024 at 11:50:41PM -0700, Anil Samal wrote:
> To debug link issues in the field, it is paramount to
> dump fec corrected/uncorrected block counts from firmware.
> Firmware requires PCS quad number and PCS port number to
> read FEC statistics. Current driver implementation does
> not maintain above physical properties of a port.
> 
> Add new driver API to derive physical properties of an input port.
> These properties include PCS quad number, PCS port number, serdes
> lane count, primary serdes lane number.
> 
> Extend ethtool option '--show-fec' to support fec statistics.
> The IEEE standard mandates two sets of counters:
>  - 30.5.1.1.17 aFECCorrectedBlocks
>  - 30.5.1.1.18 aFECUncorrectableBlocks
> 
> Standard defines above statistics per lane but current
> implementation supports total FEC statistics per port
> i.e. sum of all lane per port. Find sample output below
> 
>  # ethtool -I --show-fec ens21f0np0
> FEC parameters for ens21f0np0:
> Supported/Configured FEC encodings: Auto RS BaseR
> Active FEC encoding: RS
> Statistics:
>   corrected_blocks: 0
>   uncorrectable_blocks: 0
> 
> Reviewed-by: Anthony L Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anil Samal <anil.samal@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


