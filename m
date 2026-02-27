Return-Path: <netdev+bounces-261948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJPpOUDroWkjxQQAu9opvQ
	(envelope-from <netdev+bounces-261948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:06:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A51BC6BF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E39CF31096B2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F727FB1E;
	Fri, 27 Feb 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="o4uRYTK9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F45349AF5
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219091; cv=none; b=ZYoIVjsAotMF2c6+3pdlwhScGIel3kBSREX5TweMe8L4M5irTBdttFZsSswt9AfDTeVhWBnrIa54izniKf/3pb8y8hgvOVZlyhOHA8WrCco5M1tpTkYS8m9HP8F2pBL4HN0mo84fWgQmz5so4RNmvJVbC1IboctVeCsIXhUPGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219091; c=relaxed/simple;
	bh=IMAyHPy/blEQ/2vnWAKKyy0ruHH1HS387rxT0IWZDHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwXqz0RLIBl19143AJGnG8S+Ra7ztaJec16xQ1JW9s9wdytYTwREyhJtKww2mcp3qA7FXdBzDWbJHzbk2umUOLWudKQyd/oWnptOIAEiBpEJWyYSEwX+2t8VxMAz+tz5Y3jkGTSUphgoMcD6DtFKQFRs50z2R33NK8jwZph/v+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=o4uRYTK9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8274843810cso1063618b3a.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772219089; x=1772823889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seXoHa8MttyanDQdn7I7ioBq+qRY17Mw0b5Mol0x4jI=;
        b=o4uRYTK91pxdLEsQ03ktEwRmtIKQCUAtyTP39KwH0McABvNGMdNkzXDNjpCuJCSLVW
         LrPOVJ94eH+4R7UOoMqrKO6UKiHcS3v+7fyPofiTHHJ4H3kzQzukSIcbMegKs18JiXCK
         joBmGbnI9pg6NU80U8g3OlLMJ8tlrHzVEniZzcZ+yA+Q824qsR9TQFJf2yJqGHNvhp6E
         weBKgGGj1dtr8CTALLOAEhUvSuCaMbMcxEjXOtXYLHMVHBXogyLkeCsp23fqhkU82eTO
         3Mf8TYhACRW7m9B+tGfZT2vgov0bmAJuJpppwN7D8eLXFfpMhpvHoyV7u7NTLv9huXew
         YWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219089; x=1772823889;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seXoHa8MttyanDQdn7I7ioBq+qRY17Mw0b5Mol0x4jI=;
        b=IQ6PmNMFckGxRVpbVE5FKW7bENffU6+DBMisfT7hBkq0O9Ch0KdePXbFDBbBjTY36e
         yX9+YTdBGNhNb40fVZs6tl0RPxQe4gKE1dnnhQV9+Gu6J534KXzjDb/7L9TDKF/Wm3Q2
         7Xi5dyv9T3oA+GiOzfdedMqSMlL6FsLU7hQ88RNJlVPTAuUMVQW0MvcybI6XnY7+zn+w
         TRQvUqS89XGt8Hz6H1fsw3SV4Js5PrvPGFa5sbKitmA8ksFpp247efnkEwrYnWn4c8Mc
         uo62NDGw+iZhEPXTB5QjLlwYkQCF/NruWHgbSG/xwFcDeLvOdYrcmwnGjuCYnS7LYNle
         OFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWltC87ZDHVwOSayNuKlQOCC5vTCD/K1YV6nCNQJgXyOFZcCurz00XPtD62N1vOZmUjpmtp5ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZknZP+Os79C9HfgXsp34U7AdRpNL+GJhGbuNliYvVSbwe47x
	aoLZbvsF+lc0pohJH1tQAvVZdvcPzXoumWqYgU0qyzb2nwnXgToglDVrW/jMdB8bv88=
X-Gm-Gg: ATEYQzwsrDkF47HnBYatXTVorKI+s5xKm/5z8o1iTaHUPw0LLkskmoKjAh8u2uG5gnx
	xHflNzvbMje0/Wupm6zPdTchkubFfAWehCd4IHB3xrhlqqIOSnE77y0NWyJ9yw7g9MedsxEz9g6
	sdxHtm6nf63JzHognG3XbtpK6fIwCf/IZdPfqp1yii5VoSt1k19EZDPU9X3qngh7hKbBM3NNrZX
	eryn4/RGvGfarS8VHr9LM2kJu2LC4cYC6r9B2o9VB7b8/HqZLxH6IwrsQKPUF1c+M8U5YG7J15R
	UR6YLNlzkBGRAKdJ5q4Bds1Z4uwHoEMs+h2Y9Wpq56r1KCgCU6veZUkzbQOu+VnrxMHsbtc4LvJ
	Zo/iMcY9Ohd/rUzo/hrC8TnQSLMpJFUWkQAViOrZpfe5icPk50FO4033WF7sRjPo19JPmCxI2RN
	3g2AA=
X-Received: by 2002:a05:6a00:94c1:b0:823:1276:9a86 with SMTP id d2e1a72fcca58-8274d9ebcdcmr4188044b3a.39.1772219088702;
        Fri, 27 Feb 2026 11:04:48 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c5bdsm5954955b3a.19.2026.02.27.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:04:48 -0800 (PST)
Date: Fri, 27 Feb 2026 11:04:47 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <aaHqz/0RZi28xE4Z@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <cover.1772211065.git.carges@cloudflare.com>
 <7fe1e129215a789e55a446610321737aef10e20e.1772211065.git.carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe1e129215a789e55a446610321737aef10e20e.1772211065.git.carges@cloudflare.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,cloudflare.com:email,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885A51BC6BF
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:40:18AM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
>
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
>  4 files changed, 57 insertions(+)
 
[...]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 85cbeb35681c..f75060374163 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
>  				  xdp_buff_get_skb_flags(xdp));
>  	return skb;
>  }
> +
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct bnxt_xdp_buff *xdp = (void *)ctx;
> +	const struct rx_cmp *rxcmp = xdp->rxcmp;
> +	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
> +	u32 itypes;
> +	enum xdp_rss_hash_type hash_type = 0;

Nit: This may need to be put into RCT style. (?)

Everything else seemed OK to me...

Reviewed-by: Joe Damato <joe@dama.to>

