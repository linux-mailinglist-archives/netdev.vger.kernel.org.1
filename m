Return-Path: <netdev+bounces-73024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59585AA2B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0E6B20CF2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF545956;
	Mon, 19 Feb 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHMexvHy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E94594E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364735; cv=none; b=QNP4ziRRWgV4tdH7vTaxjpCUlZx2DL3XmJ25RtWR7QOepQGxkI3whiwgOdnRsxMaHDHIl6L3pkdwYNXCwaqJn2CZQPiEpK6/uHReO7nHVfLdXT7hERnebHCcXbaMBKz/e7VUVABFEZS8ELnKNXnNBOfohzsHBe+LZuYx26T1naA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364735; c=relaxed/simple;
	bh=bdFnrodiA3Oryo73/orAtpsSlDND+gpACY/M3K2GSYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObMqelSRKrpv+VhysMdhcUQIK7HGpNWY/MYES7DU1Qj6y773P9h2dA40KEK/s5iiwhQOHe7shpNQaNbfLlwlc7iZs73FEdXIaCR4saZleOp0Aszhu58FoBZt4T370+C7pqu9eJ1uE4nCAY4E6e5QKcio+aismT1XyJKFEWnjn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHMexvHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7394C433C7;
	Mon, 19 Feb 2024 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708364734;
	bh=bdFnrodiA3Oryo73/orAtpsSlDND+gpACY/M3K2GSYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHMexvHy2/g7JjZODiNl4Kh7oOIg4887XtsNW5tVNMH4scRNr560/4HtAn4DBVWN+
	 jQROLuq6ZvBmNwgFdCu6fQ2u22OaXfT8QsSG5nyW2bP49x0EtNF5FdlT8f+/rVKDj9
	 3MsTqE1yeXfYEvjNxIyMXYEp/qG/2pcR9cWbB8w3tO7g3yFDpUwXBuj7rvAbJv+A/u
	 cvfb1c97ZuY0F8h4om//nVAQiYzHQp8vrdb5DKn2Uhb7sSFuoNKKOS0fLcy26dM/wr
	 wgPzznd+6zpcyklxwGqzkMssE/FJVJc49lNx8B50q16NBNHUXBOP4bjzUFpf9LlEn2
	 wXbLkM9Y4On8g==
Date: Mon, 19 Feb 2024 17:44:00 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add MODULE_FIRMWARE entry for RTL8126A
Message-ID: <20240219174400.GL40273@kernel.org>
References: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>

On Sat, Feb 17, 2024 at 03:48:23PM +0100, Heiner Kallweit wrote:
> Add the missing MODULE_FIRMWARE entry for RTL8126A.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


