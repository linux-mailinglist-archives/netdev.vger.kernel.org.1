Return-Path: <netdev+bounces-111342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7B930A5C
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF41F21926
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F3130E4B;
	Sun, 14 Jul 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EucCSd+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAD53376;
	Sun, 14 Jul 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720967450; cv=none; b=Tl18o/6/n9tjAHI6cFe6VIqFtrPCgeHpCVCnnec2t7wXuhy58Pdb0fkeIMTIbxNqSN5hndY7NDvj+ogk4Mbk/24uarCXa3UxL55mw5wvk2DnFhYulH2oVqui3zqNmsNgHAtXcjOZCohaG7bsZL9jNpUaLrVhoiJEO0il8slezSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720967450; c=relaxed/simple;
	bh=gl8S9FjnxRKPrktUFxcD97UhkZMArlO+FxoS7L5UV3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPbn1NJqco1j+pvZYzzRvf9lP/rVKZveX0CU+MFY7L2OM3n8aDFvr56wZDncHzPrYnH0dP69yxNNZk4u+8WclW0nG3/9VDAhfCc6kjzEzV6ppTFf2q5s6Rnpsb9AKKtZy0FU3GfKDH5AYj3y52yrBb9fLC3ClYMQngbfpqlIJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EucCSd+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FB1C116B1;
	Sun, 14 Jul 2024 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720967449;
	bh=gl8S9FjnxRKPrktUFxcD97UhkZMArlO+FxoS7L5UV3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EucCSd+/8gq5Fmh3ESZSvq/uxlZPp3RVmlNXroU7q1yUZrF6TNEjBHztl3IWTOfrn
	 w3gz1rP7vK89xXG/wKBG+AwzWPbb1cUe+JivhJFg7/L5OhDaB6O2x0dkk44G7bDTqh
	 D2J0LITdLJoKvuNLhFExS80zZ0vQvA9E//+0kOsOivXhtcbrP1MbBlwN3zTUmSPFJ5
	 aGOHSm57Y23/oakJKbqVxAE4BtmUsqGADeYCFgZYPsXlM77RqHbVTD0De/mbH/bHFg
	 ElOhhB++eCWaDs5mNVW3tvS+TzvTPKhiTz7Jf9MjY1BII3HilyaiYwiFw9W6TFe+AZ
	 5GeaX+yUfvyxA==
Date: Sun, 14 Jul 2024 07:30:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 6/6] ice: devlink health:
 dump also skb on Tx hang
Message-ID: <20240714073048.77cd4b3f@kernel.org>
In-Reply-To: <20240712093251.18683-7-mateusz.polchlopek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
	<20240712093251.18683-7-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 05:32:51 -0400 Mateusz Polchlopek wrote:
> +	buf_pos =3D ice_emit_to_buf(buf, buf_size, buf_pos,
> +		"skb len=3D%u headroom=3D%u headlen=3D%u tailroom=3D%u\n"
> +		"mac=3D(%d,%d) net=3D(%d,%d) trans=3D%d\n"
> +		"shinfo(txflags=3D%u nr_frags=3D%u gso(size=3D%hu type=3D%u segs=3D%hu=
))\n"
> +		"csum(0x%x ip_summed=3D%u complete_sw=3D%u valid=3D%u level=3D%u)\n"
> +		"hash(0x%x sw=3D%u l4=3D%u) proto=3D0x%04x pkttype=3D%u iif=3D%d\n",
> +		skb->len, headroom, skb_headlen(skb), tailroom,
> +		has_mac ? skb->mac_header : -1,
> +		has_mac ? skb_mac_header_len(skb) : -1,
> +		skb->network_header,
> +		has_trans ? skb_network_header_len(skb) : -1,
> +		has_trans ? skb->transport_header : -1,
> +		sh->tx_flags, sh->nr_frags,
> +		sh->gso_size, sh->gso_type, sh->gso_segs,
> +		skb->csum, skb->ip_summed, skb->csum_complete_sw,
> +		skb->csum_valid, skb->csum_level,
> +		skb->hash, skb->sw_hash, skb->l4_hash,
> +		ntohs(skb->protocol), skb->pkt_type, skb->skb_iif);

Make it a generic helper in devlink?

> +	if (dev)
> +		buf_pos =3D ice_emit_to_buf(buf, buf_size, buf_pos,
> +					  "dev name=3D%s feat=3D%pNF\n", dev->name,
> +					  &dev->features);
> +	if (sk)
> +		buf_pos =3D ice_emit_to_buf(buf, buf_size, buf_pos,
> +					  "sk family=3D%hu type=3D%u proto=3D%u\n",
> +					  sk->sk_family, sk->sk_type,
> +					  sk->sk_protocol);
> +
> +	if (headroom)
> +		buf_pos =3D ice_emit_hex_to_buf(buf, buf_size, buf_pos,
> +					      "skb headroom: ", skb->head,
> +					      headroom);
> +
> +	seg_len =3D min_t(int, skb_headlen(skb), len);
> +	if (seg_len)
> +		buf_pos =3D ice_emit_hex_to_buf(buf, buf_size, buf_pos,
> +					      "skb linear:   ", skb->data,
> +					      seg_len);
> +	len -=3D seg_len;
> +
> +	if (tailroom)
> +		buf_pos =3D ice_emit_hex_to_buf(buf, buf_size, buf_pos,
> +					      "skb tailroom: ",
> +					      skb_tail_pointer(skb), tailroom);

The printing on tailroom, headroom and frag data seems a bit much.
I guess you're only printing the head SKB so it may be fine. But
I don't think it's useful. The device will probably only care about
the contents of the headers, for other parts only the metadata matters.
No strong preference tho.

> +	for (i =3D 0; len && i < skb_shinfo(skb)->nr_frags; i++) {
> +		skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> +		u32 p_off, p_len, copied;
> +		struct page *p;
> +		u8 *vaddr;
> +
> +		skb_frag_foreach_page(frag, skb_frag_off(frag),
> +				      skb_frag_size(frag), p, p_off, p_len,
> +				      copied) {
> +			seg_len =3D min_t(int, p_len, len);
> +			vaddr =3D kmap_local_page(p);
> +			buf_pos =3D ice_emit_hex_to_buf(buf, buf_size, buf_pos,
> +						      "skb frag:     ",
> +						      vaddr + p_off, seg_len);
> +			kunmap_local(vaddr);
> +			len -=3D seg_len;
> +
> +			if (!len || buf_pos =3D=3D buf_size)
> +				break;
> +		}
> +	}
> +
> +	if (skb_has_frag_list(skb)) {
> +		buf_pos =3D ice_emit_to_buf(buf, buf_size, buf_pos,
> +					  "skb fraglist:\n");
> +		skb_walk_frags(skb, list_skb) {
> +			buf_pos =3D ice_skb_dump_buf(buf, buf_size, buf_pos,
> +						   list_skb);
> +
> +			if (buf_pos =3D=3D buf_size)
> +				break;
> +		}
> +	}

You support transmitting skbs with fraglist? =F0=9F=A4=A8=EF=B8=8F

