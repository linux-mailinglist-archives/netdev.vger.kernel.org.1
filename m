Return-Path: <netdev+bounces-273791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NBTDpddzGmDSgYAu9opvQ
	(envelope-from <netdev+bounces-273791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F34372E86
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95AA9301649C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605E3B3BFA;
	Tue, 31 Mar 2026 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="XCH4OTXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F052311958
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000972; cv=none; b=Hk6lI4rQqNhm+c4mtskEzrr0z3u7fnJ0CNd1bFFYqtRSRBJomcCGBlN+iswU9BzbnWE6VtF5snom9oO5S/oqyQpjMCwksXziXF+11+uUMpGAvK4HVhSRQY3gWYZiSL2YEq1HEd9pLX2V5yw0MM+vzDYY39OsYGU2wQTx/i5McjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000972; c=relaxed/simple;
	bh=UyMVRepP/rnOhUnJa8xf8Ft93q2ZedCPMrUbrrTdRgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDMKSfPFTqalRXMcLeWTYMLLoerOJtqnSaYtXqtxBsTQ1wJoDqaH3cAcICqvAaojqPGOWEjMYHm8QF8rm+lTuUzbINO5AJo8evHgA/0UXgt5unNvMISsy6mcYkgWBUqmSZFGoWI+gITvvySehF/fnyoEpLQGWUn1oWzA0SL1OdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=XCH4OTXs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so4600105a12.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775000970; x=1775605770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQoMxYx/EUYySte96DMrsK+QpxxOGj4DhnUvsx3xPFg=;
        b=XCH4OTXsUJXyIdoMk99VsriQPu+BVD1jk81Xt96YYXrm0JcuK9MgBkhwJWNvwpC8cN
         QtFAPaFLLUf36RR71WUi+ih2yKQH8x0oPgl66Rr/XGNFw9xKc6FrvHuIB1M7T/CJdVgw
         fL+TplxAYJONqAeCOpfQtf+EENCxBi/5d2A6kokLzM6SscjPuRnIwkHlsjqXEMX5ziCv
         dXpzUbCQqxnaNHFk5Wb16N+oLZ3bluPpD5yn4mdQCVzo4cp8+fuGo5gf8y17fYC+JpqC
         5D2LeF40NCrjVMJqLHBye1lhs/+s6ram4y2XlbkRTnQk/Dt+VWKxh2op5j9vw4ZCPKNe
         rDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775000970; x=1775605770;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQoMxYx/EUYySte96DMrsK+QpxxOGj4DhnUvsx3xPFg=;
        b=HhPZias2812Qb8dAmJmC2mHYxCY2S4MsIGix4Wb8Ni31X1ROYoyAE9P7ELUoVN1hHA
         0vOzhlw8xNfk5dHMqGu/0p14iB9p+ufuHt0wx8FNDG/6mNryYGnW89+iGi+VSD/2B2zY
         M1cwam0QOkAOdlIZwFSdN+IZUIpJKUulx4DyCcG5++qOnsoIahC4IC8zB8YtYK6YCEJe
         muRj90cU5j1FDCfp8XDPaTKOYLj9oScls9BXtq5Cxl5r1o+3pvCipjqEypg6ZsVuyrts
         x8TiKairr8lfK2gOChY1aIOlBIGlQ5rDrK7xlht3xgecAt+W5kx9v0FVPxEAu3qNS5av
         CKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgJeDDndbkpI6OZyK2Et5Ld4XGPY7m9pZeDXhyee/KnVi2DhWhm5/rQuDejPNfJmfGxGlggPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegpbCMga+c7bBCwns2VO7I0pIrc2MB85S6iAzXKvlnEkriveZ
	ADi3bww5j6v3C4TbbCWU3DcWY93fNWDf57QUbE59byGDaSqYMjCmbzKDj+gwCEb9No0=
X-Gm-Gg: ATEYQzwjJp2jawL3fW9z+66ajETRcoqwOAzTkiQ8j8Y0ze0IKZpamEab9YkzgefcbVJ
	6pwLTHVHDPZ7IG3UamdwmPpqy+TC2aoaowrnmir2kISesM2/+EsVqgJI80K16gGl/kfNO6dWXqH
	Pnj9EzoxKL8tCAkmjO2MajaoNkz1HTDgQPs8CdLQlvHBUcgs0TBTOw8HT9tDmgHJlCeOE7B8sqv
	3Tg/KxmucUPFgVG4fdSqOyki40kKxHKXDZ4DsVXsa3Yhfirwk/N6HF1IGJiYXbHLYPWRHuNgzwH
	S85bMacaVIKbmOm5XkDqzju04e+LYv5YNJXQw3XN99ZnS27SNv6tOSMkb0AXT70jVzhDokt9GCo
	pNKjCAR/7514N971BNH1eRb3fs0L++DgWTE8ZK9ungXx553z7Jws4oV12xQ+29fhx9bf/vhCopZ
	MQPDQ0
X-Received: by 2002:a05:6a20:94ca:b0:39b:7f5f:d591 with SMTP id adf61e73a8af0-39ef79e7243mr1045522637.63.1775000970519;
        Tue, 31 Mar 2026 16:49:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76bdaed389sm276018a12.12.2026.03.31.16.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:49:29 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:49:29 -0700
From: Joe Damato <joe@dama.to>
To: Wang Jun <1742789905@qq.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn
Subject: Re: [PATCH v2] net: ns83820: fix DMA mapping error handling in
 hard_start_xmit
Message-ID: <acxdiUMDaYE5WmzX@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Wang Jun <1742789905@qq.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn
References: <51dfd8ae-dc4e-4837-9b00-c596c457117e@redhat.com>
 <tencent_EB7280CE1394ABF5035CDA078FC60A481906@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_EB7280CE1394ABF5035CDA078FC60A481906@qq.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-273791-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 82F34372E86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:21:41PM +0800, Wang Jun wrote:
> Hi Paolo Abeni,
> 
> This is v2 of the DMA mapping error handling fix for ns83820. Changes since v1:
> 
> - Added queue restart check in error path to avoid potential TX queue stall
>   (as pointed out by the AI review)
> - Adjusted variable declarations to follow reverse christmas tree order
> - Switched from dma_unmap_single to dma_unmap_page for fragments

Usually you'd put the changelog below. Take a look at how this recent patch
does it:

https://lore.kernel.org/netdev/20260331123858.1912449-2-charles.perry@microchip.com/

> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
> index cdbf82affa7b..f8d037db4ffb 100644
> --- a/drivers/net/ethernet/natsemi/ns83820.c
> +++ b/drivers/net/ethernet/natsemi/ns83820.c
> @@ -1051,6 +1051,12 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
>  	int stopped = 0;
>  	int do_intr = 0;
>  	volatile __le32 *first_desc;
> +	int i;
> +	int frag_mapped_count = 0;
> +	unsigned int main_len = 0;
> +	unsigned int frag_dma_len[MAX_SKB_FRAGS];
> +	dma_addr_t main_buf = 0;
> +	dma_addr_t frag_dma_addr[MAX_SKB_FRAGS];

You mentioned it was fixed to reverse christmas tree in the changelog above,
but doesn't seem like it in the patch?

