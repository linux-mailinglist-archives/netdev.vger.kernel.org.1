Return-Path: <netdev+bounces-103770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CBF909690
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23AA1F230BF
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1E16415;
	Sat, 15 Jun 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdlVeB4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6C182A0;
	Sat, 15 Jun 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436915; cv=none; b=CeprZS0B4yfxlMLbNhzzz39Uavqq8k+iAetf274qcfd1UJWL4j6naVlq1qEF3N89ElzVYcKbGCbPke2CQXnq/I32W53mOETgvvvdDYXSq46sUKwaCTnm0k4JIKQaIlsR8m53ky1TMKRcPUUHLp2VX0ATQo988IBTTWybuz7SMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436915; c=relaxed/simple;
	bh=WN8+1EL5UU20JLPnEmj/YfX8PA8TXVtuZSlPbt7LRgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSRMpBgmgxXKKvtOzr4OwFQZVYg/xlEOi5qMcD/wgFjKyOaINROGd95P5VGZRvokTJvr2vcTUxNx5wnXlJtiFgPeyweUTzBs5IzDJ7zGaumAoKA+i6+YNMoarx7Ho2NepixiUCWlczn5lG0lSrFPBEli4lMltxWO1GNWWyghYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdlVeB4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDAEC116B1;
	Sat, 15 Jun 2024 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718436914;
	bh=WN8+1EL5UU20JLPnEmj/YfX8PA8TXVtuZSlPbt7LRgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdlVeB4ShSbOhokm7RlReaIj/d08///o7evtBquGRbIY93rvTR3IUon38wSe2V/pa
	 dBeBksMfLaotA+C/FuEzEvOzTQyk9vqfVVjRRtE0SNl02ehowuEtXKsrPEYAUutOZD
	 Xc7tCTL1gVVg/NpEqTVScaYozOEb9mEZu9ruis3CG10FkjJFLW0C0BwONaLHTPszuF
	 VwK7tvR68yWoL6bMZf8ekl2EEgUTaLSj2qnJMbeye/WCk3JLeS5CJV5zAs5E9HQRaf
	 /soQUXs7CN5kOPxHJ1hCFIIf+VdnNKMC3ymnkYlioY1S/HO7ABxLB1DlNvb7o3OxS1
	 kUS+qGBkKYFTQ==
Date: Sat, 15 Jun 2024 08:35:09 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH iwl-next 12/12] idpf: use libeth Rx buffer management for
 payload buffer
Message-ID: <20240615073509.GA8447@kernel.org>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-13-aleksander.lobakin@intel.com>
 <20240601090842.GZ491852@kernel.org>
 <2c22ba85-2338-4f16-b3c2-70c4270cd96b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c22ba85-2338-4f16-b3c2-70c4270cd96b@intel.com>

On Thu, Jun 13, 2024 at 01:05:58PM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Sat, 1 Jun 2024 10:08:42 +0100
> 
> > + Dan Carpenter
> > 
> > On Tue, May 28, 2024 at 03:48:46PM +0200, Alexander Lobakin wrote:
> >> idpf uses Page Pool for data buffers with hardcoded buffer lengths of
> >> 4k for "classic" buffers and 2k for "short" ones. This is not flexible
> >> and does not ensure optimal memory usage. Why would you need 4k buffers
> >> when the MTU is 1500?
> >> Use libeth for the data buffers and don't hardcode any buffer sizes. Let
> >> them be calculated from the MTU for "classics" and then divide the
> >> truesize by 2 for "short" ones. The memory usage is now greatly reduced
> >> and 2 buffer queues starts make sense: on frames <= 1024, you'll recycle
> >> (and resync) a page only after 4 HW writes rather than two.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > ...
> > 
> >> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > 
> > ...
> > 
> > Hi Alexander,
> > 
> > The code above the hunk below, starting at line 3321, is:
> > 
> > 		if (unlikely(!hdr_len && !skb)) {
> > 			hdr_len = idpf_rx_hsplit_wa(hdr, rx_buf, pkt_len);
> > 			pkt_len -= hdr_len;
> > 			u64_stats_update_begin(&rxq->stats_sync);
> > 			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
> > 			u64_stats_update_end(&rxq->stats_sync);
> > 		}
> > 		if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
> > 			skb = idpf_rx_build_skb(hdr, hdr_len);
> > 			if (!skb)
> > 				break;
> > 			u64_stats_update_begin(&rxq->stats_sync);
> > 			u64_stats_inc(&rxq->q_stats.hsplit_pkts);
> > 			u64_stats_update_end(&rxq->stats_sync);
> > 		}
> > 
> >> @@ -3413,24 +3340,24 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
> >>  		hdr->page = NULL;
> >>  
> >>  payload:
> >> -		if (pkt_len) {
> >> -			idpf_rx_sync_for_cpu(rx_buf, pkt_len);
> >> -			if (skb)
> >> -				idpf_rx_add_frag(rx_buf, skb, pkt_len);
> >> -			else
> >> -				skb = idpf_rx_construct_skb(rxq, rx_buf,
> >> -							    pkt_len);
> >> -		} else {
> >> -			idpf_rx_put_page(rx_buf);
> >> -		}
> >> +		if (!libeth_rx_sync_for_cpu(rx_buf, pkt_len))
> >> +			goto skip_data;
> >> +
> >> +		if (skb)
> >> +			idpf_rx_add_frag(rx_buf, skb, pkt_len);
> >> +		else
> >> +			skb = idpf_rx_build_skb(rx_buf, pkt_len);
> >>  
> >>  		/* exit if we failed to retrieve a buffer */
> >>  		if (!skb)
> >>  			break;
> >>  
> >> -		idpf_rx_post_buf_refill(refillq, buf_id);
> >> +skip_data:
> >> +		rx_buf->page = NULL;
> >>  
> >> +		idpf_rx_post_buf_refill(refillq, buf_id);
> >>  		IDPF_RX_BUMP_NTC(rxq, ntc);
> >> +
> >>  		/* skip if it is non EOP desc */
> >>  		if (!idpf_rx_splitq_is_eop(rx_desc))
> >>  			continue;
> > 
> > The code following this hunk, ending at line 3372, looks like this:
> > 
> > 		/* pad skb if needed (to make valid ethernet frame) */
> > 		if (eth_skb_pad(skb)) {
> > 			skb = NULL;
> > 			continue;
> > 		}
> > 		/* probably a little skewed due to removing CRC */
> > 		total_rx_bytes += skb->len;
> > 
> > Smatch warns that:
> > .../idpf_txrx.c:3372 idpf_rx_splitq_clean() error: we previously assumed 'skb' could be null (see line 3321)
> > 
> > I think, but am not sure, this is because it thinks skb might
> > be NULL at the point where "goto skip_data;" is now called above.
> > 
> > Could you look into this?
> 
> This is actually a good catch. skb indeed could be NULL and we needed to
> check that in the same condition where !eop is checked.
> Fixed already in my tree, so it will be fixed in v2. Thanks for catching!
> 
> (BTW I fixed that in iavf when submitting the libeth series, but forgot
>  to fix that here lol >_<)
> (Also, it was implicitly fixed in the later commits where I convert skb
>  to xdp_buff here, so I didn't catch this one)

Thanks, much appreciated.
As I mentioned above, I wasn't sure about this one.



