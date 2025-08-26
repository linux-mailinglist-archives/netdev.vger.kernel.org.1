Return-Path: <netdev+bounces-216981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FAAB36F25
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78DE9877BE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7A3680A8;
	Tue, 26 Aug 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEhqFXnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76F30BB95;
	Tue, 26 Aug 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223498; cv=none; b=FNsGfiBDqEBCSJbpR6AWqMZtj/+a3DAjTkGl6PQNsoKn4haF1Ywj+y9H4BqWzGOfx+M93+pVL21cXrZ2xuIJVD9XBzQcYxg1JIFBIhiN/mN+R9+2srb92Biwnve5JnWlxu+o3CZ6FxcOURXhtIri1dL95aVlv/FNBWt2lzi6AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223498; c=relaxed/simple;
	bh=XjEHAiQqDs5s/HRQ2adlt14ljpMwMHqgW9H3L3VQpUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csy7HsGybCq44f4AGltymJKyPuzUlA8CnzfG6da+0ZQijQ7oxbfmhzxXTXpRkzbF4iNrrvb5jmF9DDV3CNxmRghqbUxZiFJ0DL+L60IVSpe4VCACfEIC8dUCUaWPrDXvQsvrnZU2QthNKGW+olMmp8ocU82BGY/ULUG69Ck0Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEhqFXnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8591FC4CEF1;
	Tue, 26 Aug 2025 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756223497;
	bh=XjEHAiQqDs5s/HRQ2adlt14ljpMwMHqgW9H3L3VQpUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEhqFXnNyibelsZJnXJwAuS+wUdvcv+KS2qxW0e4MRKmhaugKSqqN5f9Y37HM+TMG
	 aU8OJ0rbNO5UC9hZ267XpiwAuzoITTXEOfFczGXsk1/04K73p5OUR78G+Knucbmgnh
	 Otrrycvt4JJnAw4022C7XAs70oyQPbDmgbJIIXszHxf8Md9udagD1kltw5bogtbSJb
	 ratITwoXGpXaO/UgMglmCqBYH4X3S7wueaTzi5DOXMf9cG7yBEPzCQsM5CS5d5BVXw
	 MYOj1PYXHV2rfbEfEBHzk5Thl0YkRuGTGG8WgDjPdxx5bG50QrWs+2CDD5o97d11EP
	 I7Zyq240Sy2/g==
Date: Tue, 26 Aug 2025 16:51:31 +0100
From: Simon Horman <horms@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Kohei Enju <enjuk@amazon.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next 1/2] igbvf: add
 lbtx_packets and lbtx_bytes to ethtool statistics
Message-ID: <20250826155131.GB5892@horms.kernel.org>
References: <20250813075206.70114-1-enjuk@amazon.com>
 <20250813075206.70114-2-enjuk@amazon.com>
 <9b44df93-acec-4416-9f32-f97d0bfaaa7b@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b44df93-acec-4416-9f32-f97d0bfaaa7b@molgen.mpg.de>

On Wed, Aug 13, 2025 at 10:18:29AM +0200, Paul Menzel wrote:
> Dear Kohei,
> 
> 
> Thank you for your patch.
> 
> Am 13.08.25 um 09:50 schrieb Kohei Enju:
> > Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
> > Packets/Octets loopback Count), but doesn't show the TX-side equivalents
> > (lbtx_packets and lbtx_bytes). Add visibility of those missing
> > statistics by adding them to ethtool statistics.
> > 
> > In addition, the order of lbrx_bytes and lbrx_packets is not consistent
> > with non-loopback statistics (rx_packets, rx_bytes). Therefore, align
> > the order by swapping positions of lbrx_bytes and lbrx_packets.
> > 
> > Tested on Intel Corporation I350 Gigabit Network Connection.
> > 
> > Before:
> >    # ethtool -S ens5 | grep -E "x_(bytes|packets)"
> >         rx_packets: 135
> >         tx_packets: 106
> >         rx_bytes: 16010
> >         tx_bytes: 12451
> >         lbrx_bytes: 1148
> >         lbrx_packets: 12
> > 
> > After:
> >    # ethtool -S ens5 | grep -E "x_(bytes|packets)"
> >         rx_packets: 748
> >         tx_packets: 304
> >         rx_bytes: 81513
> >         tx_bytes: 33698
> >         lbrx_packets: 97
> >         lbtx_packets: 109
> >         lbrx_bytes: 12090
> >         lbtx_bytes: 12401
> > 
> > Tested-by: Kohei Enju <enjuk@amazon.com>
> 
> No need to resend, but I believe, you only add a Tested-by: tag, if the
> person differs from the author/Signed-off-by: tag.

+1

> 
> > Signed-off-by: Kohei Enju <enjuk@amazon.com>
> > ---
> >   drivers/net/ethernet/intel/igbvf/ethtool.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
> > index 773895c663fd..c6defc495f13 100644
> > --- a/drivers/net/ethernet/intel/igbvf/ethtool.c
> > +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
> > @@ -30,8 +30,10 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
> >   	{ "rx_bytes", IGBVF_STAT(stats.gorc, stats.base_gorc) },
> >   	{ "tx_bytes", IGBVF_STAT(stats.gotc, stats.base_gotc) },
> >   	{ "multicast", IGBVF_STAT(stats.mprc, stats.base_mprc) },
> > -	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
> >   	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
> > +	{ "lbtx_packets", IGBVF_STAT(stats.gptlbc, stats.base_gptlbc) },
> > +	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
> > +	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
> >   	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
> >   	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
> >   	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Also +1

Reviewed-by: Simon Horman <horms@kernel.org>


