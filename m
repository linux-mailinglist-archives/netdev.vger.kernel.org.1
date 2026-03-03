Return-Path: <netdev+bounces-262993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJBuDgFIpmlyNQAAu9opvQ
	(envelope-from <netdev+bounces-262993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:31:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6A1E816C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA203087D30
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8E375AAD;
	Tue,  3 Mar 2026 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK6kECNQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEF3750DC;
	Tue,  3 Mar 2026 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504951; cv=none; b=uBfIkfEnuSpZ7fYwZDhh1wfmuKMBhbGhmOTxfxv83rQUUv+wxNpq7ei9gUpCYy5uXiCfkzmcrLcZXMK7TPmGrZjoMqMuVGW+zpIo/CaQjEhFMvJmygqhmDj1RMjxKU6zlSIbMDgNooK6961sq23XlQDO1yBADY0W8BkDXLzZfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504951; c=relaxed/simple;
	bh=ZWSjDglVV8rV94EH0XRkO98jwAKM9tzwFT5sW1hwJnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUZzHsgR6kqgrkqwk12+cSYvwCEs3TdoAR9AzrWQrYM61dLQgAde/QBMotbUX2KWD7Mt45t3llxHD0PhwmVjrdlVk/nOQpm6g9Wn7U5dmuJ6BZ3q7eQm7g7Zv/nZ+Opn0O8GRHAk6t2o9Y6atsfVgCR6kTqtGUou4JwzGH1LGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK6kECNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C309C19423;
	Tue,  3 Mar 2026 02:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772504951;
	bh=ZWSjDglVV8rV94EH0XRkO98jwAKM9tzwFT5sW1hwJnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lK6kECNQH/MKzjx/eLAD6yVhEThloPbePGhSvt4wh4ZmBHnBrIFF2Ovamdmch2aYh
	 /9ElB2EKdcZVeSbMr0erPOU+KiiPg9FHeRnMhU1ayUdAdp0RgpfEL6Xe76SwJfzAKJ
	 +hq9qN2dR8MA8Q+YnKOexpUo5kMcwO6Fi1p5QEdq7/MoOPQWHW8B+kD4Zhk3yi3KBq
	 6hawD4eIIMPJGt+IATChGupmYRIXfYxQ7/FptU+DXGXBcSJYlEo3TfgGnbpb3u+jP8
	 lFZhBAr+EfY2Ph6lO2ybv+C6YaHhfKu5Oc6veSpEnzpUlH5MRiBGz+xrO5E6+2sP4S
	 bi8MG6R4ZK9BQ==
Date: Mon, 2 Mar 2026 18:29:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Valerio <pvalerio@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: Reset prog ptr to NULL
 in case of error in mtk_xdp_setup()
Message-ID: <20260302182909.06de1942@kernel.org>
In-Reply-To: <20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org>
References: <20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 81B6A1E816C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,mediatek.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,kernel.org,iogearbox.net,fomichev.me,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 16:52:11 +0100 Lorenzo Bianconi wrote:
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3751,8 +3751,16 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  
> -	if (netif_running(dev) && need_update)
> -		return mtk_open(dev);
> +	if (netif_running(dev) && need_update) {
> +		int err;
> +
> +		err = mtk_open(dev);
> +		if (err) {
> +			rcu_assign_pointer(eth->prog, NULL);
> +
> +			return err;
> +		}
> +	}
>  
>  	return 0;

Maybe there's something special here, not obvious without context,
but why are we setting eth->prog to NULL rather than old_prog?
At the very least the commit message needs to explain..
-- 
pw-bot: cr

