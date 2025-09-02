Return-Path: <netdev+bounces-219079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323DDB3FA43
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F4D16A8EE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D613C8FF;
	Tue,  2 Sep 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn3Ofsoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC03221F09
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805114; cv=none; b=Wg9D9NeE9Om72SHwpt+Ijcj9uRwqfTU5DgQ4vHFT8L+BLelSO274yIdYoFPIhm/jVAuZCbE6BdLj025+cL34uu4D55lBch/RLkpefZfBELR/w25RLiOZCmDmbOEXoB/btW/AJxbibu43M42AIaLRthF+RDFbk4+6OiAEOecHQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805114; c=relaxed/simple;
	bh=Gir5FL/6U85la2b3A3gYkp7N+HOwiXlJmyqMRnXBoc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buM6P287DtIcYJrbIsKcx8u1BxYaVFqnzJFWHoZ8EKOfbytJVmaGNbgzztRaLg4PW7EfmYAbk6nn8inoERB2ts3XGvKUNQlOZJifTkwYSscIJ/1sInFM5tHJTaYZ1etQKeWF7h4XU/Uz0ujyZcVkLWLqe7TYiS190VuWJq3ppU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn3Ofsoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9EAC4CEED;
	Tue,  2 Sep 2025 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805114;
	bh=Gir5FL/6U85la2b3A3gYkp7N+HOwiXlJmyqMRnXBoc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bn3OfsoqPmp7vr1XWJezR6FORqG/4/CG8Db+YcPlw9ymTe3X64rfy13plgzJUQtMC
	 9pjgGH7Btw40tadVQVsuKpxpyeQSfb5WoMtVYh/IOxfpZOkocfTxOneU/inTlccJTy
	 j7a6HQgxZB7RJ4tZCBp0qdXJMLqGU7mJWDSLmZK7NiutoenNP7/RWgia+npv6+FvU9
	 xjR7yz+VlTkl5bHtbWd0ZTyJEcfVyV1p3mANC/0KV15MeEO0xgu7GYrkHzmFPZOPnf
	 s7SoDW1OspQtFcoOlVDYdT+g2fBLyUhDuDWvcKQDMTQikp8D97mHhjGDoWQL60X5vS
	 +uNeKNxn83Efw==
Date: Tue, 2 Sep 2025 10:25:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, dkirjanov@suse.de
Subject: Re: [PATCH net 1/2] Revert "eth: remove the DLink/Sundance (ST201)
 driver"
Message-ID: <20250902092510.GX15473@horms.kernel.org>
References: <20250901210818.1025316-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901210818.1025316-1-kuba@kernel.org>

On Mon, Sep 01, 2025 at 02:08:17PM -0700, Jakub Kicinski wrote:
> This reverts commit 8401a108a63302a5a198c7075d857895ca624851.
> 
> I got a report from an (anonymous) Sundance user:
> 
>   Ethernet controller: Sundance Technology Inc / IC Plus Corp IC Plus IP100A Integrated 10/100 Ethernet MAC + PHY (rev 31)
> 
> Revert the driver back in. Make following changes:
>  - update Denis's email address in MAINTAINERS
>  - adjust to timer API renames:
>    - del_timer_sync() -> timer_delete_sync()
>    - from_timer() -> timer_container_of()
> 
> Fixes: 8401a108a633 ("eth: remove the DLink/Sundance (ST201) driver")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


