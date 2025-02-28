Return-Path: <netdev+bounces-170808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F9EA4A019
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BA01895FF0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536EC1F4C8E;
	Fri, 28 Feb 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEClTUQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B431F4C85
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763104; cv=none; b=o/hIzKqQQWp8QFssGwz8LasAzCHANFcSA2NfJUCfiu4Ump55J4pHYayjklPNA3U59hT2FfLZtCNiXfiFqeqSzweENmLfqhfGj0YyyHjdYFpObHWu/jolIVMNTVI/fCjTTQm+l5nHHAGcLT77RXrj74366lKpt/pne1RQxxrF8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763104; c=relaxed/simple;
	bh=xbrkC9wQmBAJq136ugYGbFVex3ldm3gZ7hWF2a+WG+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5PEOygE7CZycTDHu49dy3oWcAVbiNIMHGXqHV+lAYcs13gS3LC5dWcfBoSO8gIGbQUWvA9FyIaa2ygFrh+FZYSn6f7L8hv4SE0F09VRA1bh19VAi/8s6zSY4ORRJiqgANnyZfgzJ8k4Nwp9hZ3LK0Wc+X4P8oVgN9kjwhhCqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEClTUQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD0FC4CED6;
	Fri, 28 Feb 2025 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763103;
	bh=xbrkC9wQmBAJq136ugYGbFVex3ldm3gZ7hWF2a+WG+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEClTUQYb5N66+eanwlWPzSIy3au/N9+juhIcnpu4xPC5GuegR6xOdiVGYQTCbBoG
	 F4PoULe1S6HNYvqje7H0TGXOa/D2V2Brmr2xDd/E/YA13KwItYymD+xNJ+Q5xbwxzR
	 qzjrvZrPD4BA4elcB89OKGEUe5qe2Uwobk6NttLPRKj60jb2UYsn2tQSXpR70trE8S
	 JEZqvsCScBurBbczLT1EXq0mmHfAV0gzuSvvMsh05PlffyMRH02+vgB3FfCdmZ6ebX
	 FgRFM5xNY1zlMgrUtn7F3or6Kdo/Wdm7+FXX7yEQt2b8PvQITeZtyJLOFaa6/lMBXJ
	 1pq70NoB5baKA==
Date: Fri, 28 Feb 2025 17:18:19 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-net v2 2/5] ice: stop truncating queue ids when checking
Message-ID: <20250228171819.GM1615191@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-5-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090847.513849-5-martyna.szapar-mudlaw@linux.intel.com>

On Tue, Feb 25, 2025 at 10:08:46AM +0100, Martyna Szapar-Mudlaw wrote:
> From: Jan Glaza <jan.glaza@intel.com>
> 
> Queue IDs can be up to 4096, fix invalid check to stop
> truncating IDs to 8 bits.
> 
> Fixes: bf93bf791cec8 ("ice: introduce ice_virtchnl.c and ice_virtchnl.h")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


