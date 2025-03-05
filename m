Return-Path: <netdev+bounces-172001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEADA4FD5A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29E83A80EB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7375970830;
	Wed,  5 Mar 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Exo0sgyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1E2E3377
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173361; cv=none; b=asl4oYBwsfDBFB3VCTo9j4ukmWxuyS6r0SzfxNTn6xf5qInxBh03Ku1U6OKW9mCyl70Os8HEZ7k5mK10WjE0ArNPFmMinAMCGVx2TZ/51RJzIABPRFIchRDaIaOIHAwOhYWEJecp8dFd6PhG4UWLUetqnCq8m6bTp/8yj1mbpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173361; c=relaxed/simple;
	bh=v7LI38xkeWG6cVSpqp+6pXrepcB4JMdiHdJj+5c1pVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZWI/s3X/QtDRseBK3I5WZ7fW/rU6Pno07/MudIdpygiD11QKo31c3WyiMiEOYvmlIcFbySFeuB5OsiRR45cETa6PkyanhJjtAVDh4yjEIvbo9DZgNDeZcP1BFsSpXqzoRZc97mXfWJuMopL0FS/VhNbZAUIPY6BzKNnzmmO/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Exo0sgyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49137C4CEE2;
	Wed,  5 Mar 2025 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173360;
	bh=v7LI38xkeWG6cVSpqp+6pXrepcB4JMdiHdJj+5c1pVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Exo0sgyWuqwGBxyDDDt3idnRA0JH4ZFcMXiyp9c97HznqwJvMBaZGRtDcRPShKRyE
	 gtIkTF2jrKNyY3xSdTpBb2YsmDcqcqaEgjgSOvZBdmDcCBckwgoQgEJnWaSRFZfWuZ
	 J9A3QbJRSUYTTnFdnFoOyWvGsD3ocrjS0kMQeW6Q5s4Lc1B4iPjw6QFEZ/Zv1rATzK
	 dzC1cuzVq7QY5pLbG165TJao1IY2GGRpGFRa1OdVt5HV8aq2kbyq5LFIfZW32MMP/e
	 zyo1OKcIqfeXGRMoyASl7Ng0zbeWQQbJAzcUzYS58RPHZKPLbwQX9YDVqo6g07mraS
	 mURtYAClOl0CQ==
Date: Wed, 5 Mar 2025 11:15:56 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, andrew@lunn.ch, pmenzel@molgen.mpg.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3 1/4] ixgbe: create E610 specific ethtool_ops
 structure
Message-ID: <20250305111556.GJ3666230@kernel.org>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
 <20250303120630.226353-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303120630.226353-2-jedrzej.jagielski@intel.com>

On Mon, Mar 03, 2025 at 01:06:27PM +0100, Jedrzej Jagielski wrote:
> E610's implementation of various ethtool ops is different than
> the ones corresponding to ixgbe legacy products. Therefore create
> separate E610 ethtool_ops struct which will be filled out in the
> forthcoming patches.
> 
> Add adequate ops struct basing on MAC type. This step requires
> changing a bit the flow of probing by placing ixgbe_set_ethtool_ops
> after hw.mac.type is assigned. So move the whole netdev assignment
> block after hw.mac.type is known. This step doesn't have any additional
> impact on probing sequence.
> 
> Suggested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v3: correct the commit msg

Reviewed-by: Simon Horman <horms@kernel.org>


