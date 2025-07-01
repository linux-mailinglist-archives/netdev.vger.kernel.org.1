Return-Path: <netdev+bounces-202937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3656AEFC0D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08204E13FE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58627603A;
	Tue,  1 Jul 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/HA7hwE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013F2E41E;
	Tue,  1 Jul 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379419; cv=none; b=OovQkvqKJ3B15daYD2XkNvZLa7InC9oqcyV5YQ3hUeQrfCa0ZtxO644oXQiSjmUQwwsvKoF31jRY75puMmBeVaPd/afI6Y2K1BV7f4/q8CCYU/cn1e/Ci2FDspwxaeGiw1gi9v36PjIbuLHIjSiX0tVdgjKUA5NoiT+gO0FEY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379419; c=relaxed/simple;
	bh=JnBwtm72SwEClAyQ6fg2WIqUpzyAaD/aFkFXj21Re/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TogSi1Q4tSE5hohkT/dkD+OrcCtA3Vb9gnn4g3+t3O4R9vqtkYCPdcji+qsaKhhgdZAL9XTdL9F4IWlBCUAsimsBfJWK0D53TIQqGfcBfwX3pJLDosUd60otMbrEu49OxMaWchW97Fsti/1PHLJgwAwY10Wl/+Vw8/lMVOrO1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/HA7hwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91174C4CEEB;
	Tue,  1 Jul 2025 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751379418;
	bh=JnBwtm72SwEClAyQ6fg2WIqUpzyAaD/aFkFXj21Re/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/HA7hwEy8pWLEu+Lmz4fjQ7h2909zsFqztdOBBcG2mlqjK3/EAx/3CZqHfg5pNx0
	 G5sM0No9YAEDunFSkyyxo9edk8H6iQ9TJdZhdz8FTlcZCKGXLDoEQfltVLc9iEow/a
	 tBtGeDfY0c7D1kyH5wKjF2Z8ZacfMub4OeIz6Ab6xdI1BR7k1bOwbDWJTby2u8/gRp
	 Fbt+WyEc6/wPc4y5rdTjahpvswebvaeTH8DHjhDVRQAH4cBeh7mt/Us5s22xLLFXq3
	 8wKP/cOhI5PC2hxqBxyBC2zb9jkCeT0NHVl4v614HGtqXknU/xwMOJl/iy3lyLS1sn
	 E1EM1Df4o3Htw==
Date: Tue, 1 Jul 2025 15:16:54 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: Re: [PATCH net-next 3/5] net: ip-sysctl: Format pf_{enable,expose}
 boolean lists as bullet lists
Message-ID: <20250701141654.GV41770@horms.kernel.org>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
 <20250701031300.19088-4-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701031300.19088-4-bagasdotme@gmail.com>

On Tue, Jul 01, 2025 at 10:12:58AM +0700, Bagas Sanjaya wrote:
> These lists' items were separated by newlines but without bullet list
> marker. Turn the lists into proper bullet list.
> 
> While at it, also reword values description for pf_expose to not repeat
> mentioning SCTP_PEER_ADDR_CHANGE and SCTP_GET_PEER_ADDR_INFO sockopt.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


