Return-Path: <netdev+bounces-265820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG9/Hmhrr2miYQIAu9opvQ
	(envelope-from <netdev+bounces-265820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:52:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C073F243248
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D8F303C02A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF372765F5;
	Tue, 10 Mar 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="l6w5cri5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA426F288
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103972; cv=none; b=KmgOH7hd/D3kORtWyAA3iXyXYKWrtxn/TXdNm9grdxe6F41JO8DI2zJBI7kB9PnOYcZixuwdtWwGojaw1Li8rUyiNWF25MRJTGNKxdbGtiptBQm3Cvbt9j5ywi6/eE1uf170AUAz8eoa8fGOKKF/FT+IFCWQcKCjTaFGDzfoE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103972; c=relaxed/simple;
	bh=1w5nYgSGneWv1fTGho3iHRUDa3qYd/rN2g5t0VLnMxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKnQYoIh5aMvATyuIvMDcRwEICO5iadLoLIVPHys6LgmNCjy6BsoVYfx6ov7LPK7mUF+azz/+L2F0dgwjOrajUNjQ5RELXzR2RWBt/69wYn2othGYT1Dd4rHiwRimoPwllj2MNfh5rPdgHWti/vogoRqOWTiTpJ5Nwngq2rFcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=l6w5cri5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f316d68so54205175ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773103971; x=1773708771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0KRr1g0bUXUFpohVfNcD7Dto+nX2pFoxhEU7JGJkxU=;
        b=l6w5cri5Cf6al6Yl/n09oTEiKqQL/4ssX+bf3J/poLvsRPixMCPP/o7Ic4UjdpakuN
         2TeZd/ml+tlpwN5x5OEkcXed195uIfEqCaXEpHenm/ZVfqzDCpewpRsZfoi5xWv3Ish8
         wag015fBSein9rQRPZpBJXwdk5lzqO6CwJPe8+IL+Y7RpDRYiMhJOwdPyYdkNhNCdm/X
         KXZGDi+yIhxu3v3pucEZ8ODl6Z8RL5aCE0/5ZEjSVUHZjB/d6FTudwkki2xtSMaOH+Kz
         SyJ9YayEToVgsOBawk18zPeELbT1vvCZTDqHcVGkaL99oxATX/MtTqKuo0cb/MtDihbP
         CoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773103971; x=1773708771;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0KRr1g0bUXUFpohVfNcD7Dto+nX2pFoxhEU7JGJkxU=;
        b=A4AFW4wJ+DPTXFGvqEi6X10DTL8TgQntup01eGmbDdwt3SpaBw5sXxcJ8QTMG0apgc
         DcY5G5v+K7pSvVrvwX7A9cKWcxTwvzywqwbJlg2WgmRcs3RivqvW7IuvCleDY67ijDoa
         Vj/V29/Lwk6Z9s7BA6t0iV2q8ig1PF67wl2L/wzgRXxnCva8PnfO4kd7qwbIc7zq8Xfy
         DO4wiLAKY8vbj0JP4806UYL9TGgHr6JLcRCaJC7X0uWVqxcsaYiAN7MCBW4SH886aK49
         5NqVdlHDFeVdDBf+wM4k73/g8LoZAwwq/A5oaln6s+tC8SS1Lsm+GZlZ7KylTTdBBnHY
         x2uA==
X-Forwarded-Encrypted: i=1; AJvYcCV34DkUg/6idykKd0djjrT2OwV5piYO3TtFz7sKEF+HkzEca7b/cPf5P4OGKsD932Ej1xW74iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4d6lONIrfgsQsep18H+sEjkXC7KQ6jMEa+kiK3CgRXInHzo2R
	tmF7GX18W5rx8ak9meHrI3NqkzGFU0PqcCcxWS/1eTOV1/6T9Q5IHOO3xdXeEt1o0sw=
X-Gm-Gg: ATEYQzxvHp3ozf93+Vpl8/OIYAjHNS5ImQtm0UyPyyxURzIPgoEo1vZlKKSVAY4Gv3G
	QDvxWX/FF/RgKkBF+rye7Df6oM3tLkzPZjLBY+ORFArouFLerSMLVR+hiLSUu3qhoEXqupSrHtG
	j5MAgPmT53zqxUkLH+HNWrtpizts/GHT9ucHYrCj+K/iwru7Ip+6dZgY5cwsKSVD7CuusacZcko
	+e3JQo7SM7PyRFFT37xR82ygvdOZsIBJR+XgRc5ZtpeZDhP8E8mFfUMvuqEBwCJJfK6HEcPov/T
	nJmfWgrejZTF7t0B0x9eelnXLfLZrfIbQgpi1FTqh2/cjlrj6qpXsXYCQEFhyzeQ0NnJsBTEFIL
	BSMRd6Jt3dBeX+hYsZfmrTZTdeVdkC37VL14mgdmsjUBfFrvpS5Gf4Qg85cocOips3iGA+CK+ft
	eDcgAN
X-Received: by 2002:a17:903:3bac:b0:2ad:9edf:7fe9 with SMTP id d9443c01a7336-2ae82431ff4mr120993145ad.27.1773103971001;
        Mon, 09 Mar 2026 17:52:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e575f3sm171995055ad.8.2026.03.09.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:52:50 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:52:49 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <aa9rYfExRBUREZ6Y@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-2-carges@cloudflare.com>
X-Rspamd-Queue-Id: C073F243248
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:00:16PM -0600, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c982aac714d1..ab73aad40593 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	bool xdp_active = false;
>  	dma_addr_t dma_addr;
>  	struct sk_buff *skb;
> -	struct xdp_buff xdp;
> +	struct bnxt_xdp_buff bnxt_xdp;

I think I mentioned in the v2 [1], not sure RCT matters here.

But in either case:

Reviewed-by: Joe Damato <joe@dama.to>

[1]: https://lore.kernel.org/netdev/aacrSocsBAV9wZsT@devvm20253.cco0.facebook.com/

