Return-Path: <netdev+bounces-285926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJKsNDUN/mm2mQAAu9opvQ
	(envelope-from <netdev+bounces-285926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:20:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A1E4F958D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603A7301E944
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360FB3F54CE;
	Fri,  8 May 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daEkcEoH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930733FB045
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257165; cv=none; b=OKo0XdlhcQP/apRcrAPwEBWqDIDMReUUTMvFVaMsLk7O00+AzhKvj5+GfwDIVvYtofu9oGCsz4zR4obpOOF11ojdBEh1j63HYaxkG0AcuhSu/0yRNAJgUbmNy+Oz+42iFL2QbHTB4XZnPUeIWzXYv1dKb2ivHmr3tudyiC6Pp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257165; c=relaxed/simple;
	bh=uc3jnip+H+oiJSYneTaQeBj5rHlfyX/72RGhkpqkc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkuekGNJoTakm4tWs7561kc5qOB2uL9mEW1Mhk3kEKsPIbU6PukafCHssEHj5zbml4UKYPeENWEUbjz3WgIYZSm0NTfRA5ad7ZZIPMOhGOCXL/foJzdkFrsK6YwKjxx1g3O/JL4v8g5E+vPecEKn1qgUF3EisGy81ZxNkzyIUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daEkcEoH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so292060885a.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257160; x=1778861960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bkqlCvbruBHnLjafR3XguFKTezYBeYRy/KbFBaQEw0=;
        b=daEkcEoH1UhQuK+JpnN1jrE/KdqXkddeyf858Hm0b8tLuc0/CJEGBoPTjizNAgLnIA
         vhElmBKzNi8+wLbmNYYtHbu+EARdyEWCwNGFdn5GUwIA1oqD+D70Vwm+Lhnv9KMuM7qs
         27/p7UZFnH13LGY0bIcihBOBsfMmoJXDhKsETkXEEvCiT1BCgmg6HQ0bVc7cDstTDk02
         X0KCPgEpGzQs5gCSbVgBC/eI+DFTK9QDmU0K19YQDem3IPv9FR3gJJYJAh4ePtUn/d3A
         qE//px4aaoaZM55Dytc/NGh/AwIPe+6myMJSgx9S/W6O8frsgCGgKflLJMW2NzOuzJhV
         qoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257160; x=1778861960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bkqlCvbruBHnLjafR3XguFKTezYBeYRy/KbFBaQEw0=;
        b=POFPmy3CPjCYTypVNkH7HkaQzhioXjKv4NajRtkFRs2QnyF1M8tcb62G3EkUFeBSe+
         pFIrqpKRZ3s72Hc+LnWf99qWl35v7B6pPSGO7DkchIWkjEyPGNl3iuLQy61lVqmfrcYM
         zTvXHe8smDV98peWP+KI3FKVd7Cy2NQjlhN9m3gx0ho7U9ykx0lj3kwZg1OOD9tkPq/e
         /6JiPmKADJW2oT2jUBJHTJCsoHmDqnc2LhGhDsmUCOeAhw5mnFxIobWqw/XivDKcV0BD
         bSqAXQmwqMVpuqHdBlvQqQCf4MR+KfY0GFwgel6Fxita9fe2oYh4g52s4HAKeWM4bZPe
         /jAg==
X-Forwarded-Encrypted: i=1; AFNElJ/1fifywZAWx3IxyyDEglYTMcCpwRLjb0FYU88WsXHwhofbjHHNggWNXQl4mR9WZQxPFKg20bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eM2clUYBmz8ATjbukyPOhH6Tsame/RXthhuZIcYBM1TEhgFv
	bhL6lezBSYXd/qHjcoRGzGufVfi6Bjgumkq//QVEnTfIsftddOoUoeHx
X-Gm-Gg: AeBDiesXY5m0M1lbS0qIupz0vzi31clRWOfMLiR5WkhzfLKCmSb5n4NqPWmwZ9+26nx
	hSSJQf2O3N/U0UABiIvRw897nMAjiM2nq0m0SIWzzc7CkH85cqT4IhyvvLI9pUTyjBZSWtr21D/
	Od34ohSJHAjmVX7ECwBWk1RWwxT4gvl/1WDkIRTUpuLk+2JvsC0TK5EjbN49NoS9Ls9lgNAGk1/
	knW/sSfh7PiYz6EFW4sqmqOZaKzCiVigBCadnxZRB35pDNzrVBE6kcaS64bhT24+NDJKtMppfem
	LAJd27d9geClsHfZA5x5yyVgbiOJF6qwwYyL54qLN0YSnnxkNtCeSw2+S20JjJR0F7623s3o0VH
	T8GX1v97mGWfl0zuXbCNB9vtP6eDUk3k4BmEo5S+Y2q8irpMJN41CdQFrbXDId0xO45lwvlWBHc
	ZTLoLhQTWIz+TlcT4V9lSiskV8zWbJbvDc2bd4bvJ08tURvkZA2Le5KOKJ2A==
X-Received: by 2002:a05:620a:4554:b0:8cd:94f9:1bc5 with SMTP id af79cd13be357-90650ef5401mr1076760685a.12.1778257160389;
        Fri, 08 May 2026 09:19:20 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:1b::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm228049085a.4.2026.05.08.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:19:19 -0700 (PDT)
Date: Fri, 8 May 2026 09:19:13 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af4NAebQLJbdCB6p@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
 <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
X-Rspamd-Queue-Id: 69A1E4F958D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285926-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid,meta.com:email,fomichev.me:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 08:01:17AM -0700, Stanislav Fomichev wrote:
> On 05/07, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > When a netkit virtual device leases queues from a physical NIC, devmem
> > TX bindings created on the netkit device must still result in the dmabuf
> > being mapped for dma by the physical device. This patch accomplishes
> > this by teaching the bind handler to search for the underlying
> > DMA-capable device by looking it up via leased rx queues. The function
> > netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
> > device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
> > devices in the future if needed.
> > 
> > Additionally, this patch extends validate_xmit_unreadable_skb() to
> > support the netkit case, where the skb is validated twice: once on the
> > netkit guest device and again on the physical NIC after BPF redirect or
> > ip forwarding.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - Fix validate_xmit_unreadable_skb() bug for non-devmem
> >   unreadable niovs (should not be dropped)
> > - Major simplification of validate_xmit_unreadable_skb()
> > - Fix prematurely released lock in bind-tx handler (Jakub)
> > 
> > Changes in v2:
> > - In validate_xmit_unreadable_skb() to check netmem_tx mode before
> >   inspecting frags (Jakub)
> > - Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
> >   netdev to fix lockdep (Sashiko)
> > ---
> >  net/core/dev.c         |  3 +++
> >  net/core/devmem.c      |  6 +++--
> >  net/core/devmem.h      |  9 ++++++--
> >  net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  4 files changed, 72 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index fbe4c328a367..268417c9ef22 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3999,6 +3999,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
> >  	if (dev->netmem_tx == NETMEM_TX_NONE)
> >  		goto out_free;
> >  
> > +	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
> > +		goto out;
> > +
> 
> Since this is a good case, maybe fold it into skb_frags_readable check above?
> 
> 	if (likely(skb_frags_readable() || netmem_tx == NETMEM_TX_NO_DMA))
> 
> Otherwise it's a bit confusing to have:
> 
> if (xxx)
> 	goto out;
> if (yyy)
> 	goto out_free;
> if (zzz)
> 	goto out;
> 
> (or, reorder to be out/out/out_free)
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Makes sense, will use the combined conditional.

Best,
Bobby

