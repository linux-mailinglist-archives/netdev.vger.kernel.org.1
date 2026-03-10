Return-Path: <netdev+bounces-265829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHtRDrltr2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:02:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB81243408
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D2A304CA58
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDA26A1AC;
	Tue, 10 Mar 2026 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="tMN8ZLH2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6B26C3BD
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104559; cv=none; b=DcF5ttqGV23GEqRhsDfkMZl9c9Rky8Uekt7ndIk/WDKWq6ibg2YTCILNjswWjpEU6+AzhamTe98Vxoi8Fz6HgS2IR7FPydYbaWudKQ+sNF2eaceSv47KCdmMb0K32nnMrg5Y9ODymbIsfk6i0QaM8azIH3k6AdIJVPZjQsPRY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104559; c=relaxed/simple;
	bh=8u5aIGkzdWH39FyyG84Cpgt7t2bR5rtumOcEDOMTekQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDjGiO3UhexXBhCPQi4tBhTU1cJn3xw75eCUYK+UCbx1uaU0koWkALhO4dsVya2fzJmUm6drDukCef5o9Fun5sWHe4Yli1v6hxKeH09LjORAzpSBFRtQHWnK14VUSOJS0nRvU4nVvBTGH2Imoaru+Lx5AmeJHyS+jUDfOIkLXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=tMN8ZLH2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3591cc98871so5499318a91.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773104554; x=1773709354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cozoilkNHFvAFGwq+G8eAqvAnWdVX2syV8KrlFutxF0=;
        b=tMN8ZLH20s6EFrlhhIZPjqr7cDCkAYamW+jL/S+/XcX/y9tB+hjp22m3mkL6dmvw7l
         auhP0To3XFKB5LRg23ecQ5Lgwk6C2CQdO0Fvwaa/M1V6zP5WPdLlFd72OUNDvFD6ug+U
         U7B3cpxH3UhdAHREBX+A9NF3uc1OftTcUdmdfhFSNOM22ZSnemW0IlXHTSzAFBZVzbx9
         ZIZhx+JddPl4BMq5tVMVNjs606ialRiCYVpPmlcl7Hi0x4D8loshj8za3RB9PPb4Okpv
         Jj86NYloq5HDSHMoe6YneJ9b5xGViVgaYUkWQOQYBGfu/fyq9HP320FNP3zRVgKuHdqE
         IX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104554; x=1773709354;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cozoilkNHFvAFGwq+G8eAqvAnWdVX2syV8KrlFutxF0=;
        b=rUmPZI8xbF/NEtOGtFsizqlYhLbiKQwP2PMcG5v62Dei2lQhNl0XxI5fl72Ah+ZXWD
         NhIKUAPj1UcK6k+arVCOSRv/DsFHVYS8N6vIuplfDEQnsngED/k4PWe6USyRD9mJckhV
         f1xl6REJACDKfrBjnFkiRqqZdnofhzDi8mAlFnWW46OMu/2mrGmBneVhHbMy+nbpQN/U
         RUzWz9c2PqhUH6XtRqsLeRWHz5ZevNRzf2tX7jjHLFeemdyVR4cd7LlwYYWe4s6HH8dC
         WwlTEp9Csz5yXdk1Cn0ee1EZ/SIWTkTlDr6O7ijqASZMRlDjDdSya8YRElU9Cle9VDiS
         JNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmAOgbBdQfpl5r9QcO/qiWycRSH4M8rpe0roRcBW8TvBdYLawzImcMHvxy/GR7YadBcCuA/Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy239o2w98EOUMiet8VHMyjrvmSA31aaUrP3PeOi4tZneGyGOp1
	NE7DzFC0TUeQ+x3ynMIwbEhYMwRfdHcTk5fvA7uEqAto6IZXlaGUjiWP8f9stgKBMzg=
X-Gm-Gg: ATEYQzzI293juuLxN8c6+5CsJWy0v32IObhBTeNhyBTrg1/HrbMhGmWoDOOhzIZSSoz
	+R37VMx7l/QGxS83WZq/7cIQG19jy6VBMA0cOoZMBWHe+FmruG3c4cRe9CEdsyoEm5VTWiCKNzB
	AbfChyS8tFyoK5yI/qB24Nj6qIILAhmHYqcD0Euf/qiuqE+ece3fFAnXztlQcM1OhlQXk/rAUxc
	IZLprsPAUVj8/097EuvN8+/rkdVvm7+L4oIQndxps3o4VSFav6fgQ4l+AdTYtw4wfOIIwuv3EbU
	aTkTaDe9lp3rYgefrl5MJzJSsQA+cTANmoFFWFN/wewyMatA1NlPolK1l5zTNxWLMyEDy5Un8wf
	abYQmfuAMH04Fp4m3NQOUAxyLVFw5urVKVbuHdHrdKHZf7+kWpgSRHSSlnURcgWKLw175b1jnY9
	r7VJQ=
X-Received: by 2002:a17:90a:dfcd:b0:356:2fc5:30d9 with SMTP id 98e67ed59e1d1-359be256405mr12615086a91.10.1773104553864;
        Mon, 09 Mar 2026 18:02:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb516esm123326885ad.75.2026.03.09.18.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:02:33 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:02:32 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] bnxt_en: Implement XDP RSS hash metadata
 extraction for V3_CMP
Message-ID: <aa9tqH8i1GQ0j31Y@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-4-carges@cloudflare.com>
X-Rspamd-Queue-Id: 8FB81243408
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265829-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com,cloudflare.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:00:18PM -0600, Chris J Arges wrote:
> This adds another conditional for if cmp_type is CMP_TYPE_RX_L2_V3_CMP for
> drivers that support this completion format.
> 
> It uses a similar approach as found in other parts of the driver.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 1f920464b426..25ecef1eb96e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -514,6 +514,26 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  		default:
>  			break;
>  		}
> +	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
> +		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
> +		u8 ext_op;
> +
> +		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		else
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +
> +		ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
> +		switch (ext_op) {
> +		case EXT_OP_INNER_4:
> +		case EXT_OP_OUTER_4:
> +		case EXT_OP_INNFL_3:
> +		case EXT_OP_OUTFL_3:
> +			hash_type |= XDP_RSS_L4;
> +			break;
> +		default:
> +			break;
> +		}

Looks like the above code is duplicated from bnxt_rss_ext_op?

Maybe that could be refactored into a helper in bnxt.h and called from here to
reduce code duplciation?

