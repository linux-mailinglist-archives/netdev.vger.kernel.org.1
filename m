Return-Path: <netdev+bounces-26533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D0778035
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C80281E9D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837F22EF9;
	Thu, 10 Aug 2023 18:25:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057A1E1DA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:25:58 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E372690
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:25:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6872615b890so2573211b3a.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691691957; x=1692296757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BLYqudylqXgLrn3dkh31GMazxRYXHwKlIWAfdLP26Y=;
        b=TT2elFGLHdgirqUPPztA6mM2wIL5hl9KSBxEw0WWmLnpkXhvsO2JR1FUBOgxMCW1+B
         qqpBRNQ2CPhUiVw+2EdfIHYa+LhXGyiRs88RjaJNKBXvdn9XCeppCKahsbgpEhNVrgYO
         zFJv77J2h8xTNHbvtJ2krPSifbBZqPa+Z+eY6zyN4ZfM/Fb/o5fpp6FX/E4JHRDISxQh
         YhZ1Fp900sgjF7VnRp9vg4EvRcylAUjqNA/82TSe755eQ6msdYAB7r9/ih76DtyjJ1bg
         jIkyuXrWRtaU7T6X1o0u88YO/hMDN+DoM3OTurwYkAc3VmuH/pFKDu+rSGspK+npHlvl
         feiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691957; x=1692296757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BLYqudylqXgLrn3dkh31GMazxRYXHwKlIWAfdLP26Y=;
        b=P2CrBdqJgmZahaeYnQLDSlkIu7g531RLzOQVYIcO8SZObfD1Y9jOc2Ki+Bwv58VowY
         gPcMTPo7Ha5GkiDKmzMXRAGOrzkB/lw6eLa8l1UR0qCnfK8HLkvUlods9EIqYhNlgH6o
         0AvqIIO5E6B1Y8YYHg6tP+pwG1cQZq+d30e5R0Uq5Q6Kq0hoQOz0cWkGek3MUu6U90LZ
         /0bXAiIjltlB5b+qH7OXRIolALz6vuIrV5MqHrO62Nxupci79BVTftUEVfU1UORzuePs
         2PVyd0GbVF2bE9aIhYnhhAwxIeO8fqyPhZHGB7SH9QIi8lA1iK6s1MggLVrWCTGflbz7
         sq/Q==
X-Gm-Message-State: AOJu0YzvnVl4Z1LoSZYU9JtAq4Tybm51ibn5+L7ZBw60ieTUE+yPSUSG
	fN8x+IclduFVfhKTx2HXr4Lxto0=
X-Google-Smtp-Source: AGHT+IEc92sn+li9HY5MkxUeFXWfPGX3qr4M+mD9j/s/NzllJhY4lahZol6TYBOw6auXj8Rob99n398=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:399b:b0:687:26bc:6377 with SMTP id
 fi27-20020a056a00399b00b0068726bc6377mr1086622pfb.3.1691691956739; Thu, 10
 Aug 2023 11:25:56 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:25:54 -0700
In-Reply-To: <23743395-5e9a-ec95-b685-e094777a1d4b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com> <20230809165418.2831456-3-sdf@google.com>
 <23743395-5e9a-ec95-b685-e094777a1d4b@redhat.com>
Message-ID: <ZNUrsqtc7L+NGBy1@google.com>
Subject: Re: [xdp-hints] [PATCH bpf-next 2/9] xsk: add TX timestamp and TX
 checksum offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, 
	willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/09, Jesper Dangaard Brouer wrote:
> 
> 
> On 09/08/2023 18.54, Stanislav Fomichev wrote:
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 1f6fc8c7a84c..e2558ac3e195 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -165,6 +165,14 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
> >   	return xp_raw_get_data(pool, addr);
> >   }
> > +static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> > +{
> > +	if (!pool->tx_metadata_len)
> > +		return NULL;
> > +
> > +	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
> > +}
> > +
> >   static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
> >   {
> >   	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
> > @@ -324,6 +332,11 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
> >   	return NULL;
> >   }
> > +static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> > +{
> > +	return NULL;
> > +}
> > +
> >   static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
> >   {
> >   }
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index 9c31e8d1e198..3a559753e793 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -234,4 +234,9 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb)
> >   	return xskb->orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
> >   }
> > +static inline bool xp_tx_metadata_enabled(const xdp_buff_xsk *xskb)
> 
> Hmm, shouldn't this argument be "struct xsk_buff_pool *pool" ?!?
> 
> > +{
> > +	return sq->xsk_pool->tx_metadata_len > 0;
> > +}
> 
> Will this even compile?

Yeah, you're right, this is completely bogus. This me doing the
'fixes' before sending out :-/ Will fix in a v2, thanks!

