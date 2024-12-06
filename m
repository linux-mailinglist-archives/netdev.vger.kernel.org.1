Return-Path: <netdev+bounces-149666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283E9E6B59
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED0716ACEB
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A51F4737;
	Fri,  6 Dec 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBP9H2H0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BD1AD9F9;
	Fri,  6 Dec 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479874; cv=none; b=SW/zfWf73AL3ye4Nw26ts2Y/gAcr7ylAfdCxK/hYGO0etYstKuKHknvr59YUCzgQHlFBUGJnBVTHfAZX55bKgTSExDI97lAVJGo2/YIT4aKpnrtJkPyz7/TvnFUDI06nyiYoSXqukpK+baUVoA2xWISjpEzJEPS3eiVBdnhfSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479874; c=relaxed/simple;
	bh=MLNJAgBwRgs2KjM5s4PX7TmimuKXeMg69Vr4tEt3vIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMrt+p/y0SohUU2rnYHT4lfi4bCcFNDVunR/4N63ZuCfHlpaiK4uryM54n3yWzeE+QnksskaX0cJDtJqF2AcIyUHJ8IxB+rSp+4uPXe98jaKIdyg7a3+9XMWvSLOTpMdlXZYY9b7vsqnK4KBu5yMwDzx8Sm5kbum71xfIR6e7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBP9H2H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A591C4CED1;
	Fri,  6 Dec 2024 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733479873;
	bh=MLNJAgBwRgs2KjM5s4PX7TmimuKXeMg69Vr4tEt3vIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBP9H2H0tqtGwm1CvEqLxfcBJhulgIHIQU5M+lk2sHOvivaDxLZHUmWH/xKxtoUZJ
	 RM8SdJK9fttmHgrm7fJEgRrFmSHFsXlyuRxfXwoW7qGICZqH0fjniM++fhLaza6mPu
	 GbwBUhJjh6xRpWZU8IaaIJsB80z5GxnuwnMtze36uwqvw4MNjA1k3LqCqRhisG5T/S
	 ibwfIcyBpTJeTbO22kikY5pILlQxYK2DJUJYDR48wjI/DvSmjXhQ+JLzPv/2K/pTlx
	 XdRinRuf57Iq8dfUeAJU3Kz3Kbmd0fD9xHaJJZ88Xe5Ja8WIzRNN7vLHwQJJqL6UCF
	 TAdA5nXM/N6ZQ==
Date: Fri, 6 Dec 2024 10:11:09 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 RESEND net-next 3/5] net: enetc: update max chained Tx
 BD number for i.MX95 ENETC
Message-ID: <20241206101109.GK2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204052932.112446-4-wei.fang@nxp.com>

On Wed, Dec 04, 2024 at 01:29:30PM +0800, Wei Fang wrote:
> The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
> increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
> i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
> to MAX_SKB_FRAGS.
> 
> In addition, add max_frags in struct enetc_drvdata to indicate the max
> chained BDs supported by device. Because the max number of chained BDs
> supported by LS1028A and i.MX95 ENETC is different.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


