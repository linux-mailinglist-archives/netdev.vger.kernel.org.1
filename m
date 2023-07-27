Return-Path: <netdev+bounces-21991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87C7658DA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26268282457
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453C27131;
	Thu, 27 Jul 2023 16:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AE8F41
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:37:40 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8CC211D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:37:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c04f5827eso729105a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475858; x=1691080658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cgG0ZaR8t8OuiGWgd5910cYe86YjYguqpgeUn39fOY=;
        b=e6/UbFsHk5eizjT5n+2u8ZniNz1vcRcOL144F87T9aq3Xb3S+Z770M2JeO7GzCIij0
         pqt0Wu3hRJseTkyyBuazhmeXI3y6WYYizS11JMDJZFtFkjpufxWz2sJzo+cZfMfYFTRM
         8HtfvmebTNEpFtpn9BrICx6SmJtjhpjuQHsfHkCwRCth9jCPA+npLIO8dp7x1WF1olO3
         rYNT0Du5FAc5QN5M85aJQhFeusKWL6sU2j3CGcoNVg6/e0i0blFkQHrVMYCeWGVPkEdv
         xIom1v918Lmm26QazAiYonVcqDMIr5gPE35k0H+AbTNwvUoIpPbzQAHB2QLomrcOJyFx
         ccpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475858; x=1691080658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cgG0ZaR8t8OuiGWgd5910cYe86YjYguqpgeUn39fOY=;
        b=YWyCqMhAoSNtcb7ULcnOyLrAjqDtZBdicEmPNpYbYe38fsDvaNvPmjiAsrhuRj4Gir
         qhxkNMnkNME0YJEeFhna17LTPEgLtuVoWs7vI2i+wmRQorBH1zHa+tC/XPaLE1paWiBn
         /OGBzaP9DawFy6dVbNbjL4B2027yy+m12wLCALhLuebh6NOH+c7jPyIVcHNd83/9yKfX
         ABJRrh6R72N8hsurvtSfKWxbwFdY8wSrraksV8e9ZOThTPYtxvc8JHDemT0qtb7SWaql
         ikR6h9iTZ1NuZpSH5QQts6mUWJNmOkczKLXnnEihQVGza+M65JDdWp4Iq/4DPCEjVQAR
         XxwQ==
X-Gm-Message-State: ABy/qLZ696/0z8/LhnNxVEhQdDA6q6IWx61+tacsPkhw7hfiLx/naL9u
	lrAiEzSErBKBmczicKqmBR6Q8Kw=
X-Google-Smtp-Source: APBJJlFNxoH43LyPCKEvWiRj/irsFrJ1yuIR2ttQ29BMDgQJitWqrego1USHOLVdcIkP8/t602c14Y4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6f86:0:b0:55a:12cf:3660 with SMTP id
 k128-20020a636f86000000b0055a12cf3660mr25756pgc.1.1690475858489; Thu, 27 Jul
 2023 09:37:38 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:37:37 -0700
In-Reply-To: <50fc375a-27a7-8b6a-3938-f9fcb4f85b06@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch> <ZMBPDe+IhvTQnKQa@google.com>
 <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch> <50fc375a-27a7-8b6a-3938-f9fcb4f85b06@redhat.com>
Message-ID: <ZMKdUbsAGe318yCS@google.com>
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, brouer@redhat.com, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, 
	willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/27, Jesper Dangaard Brouer wrote:
> 
> On 26/07/2023 01.10, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> > > On 07/25, Willem de Bruijn wrote:
> > > > Stanislav Fomichev wrote:
> [...]
> > > > > +struct xsk_tx_metadata {
> > > > > +	__u32 flags;
> > > > > +
> > > > > +	/* XDP_TX_METADATA_CHECKSUM */
> > > > > +
> > > > > +	/* Offset from desc->addr where checksumming should start. */
> > > > > +	__u16 csum_start;
> > > > > +	/* Offset from csum_start where checksum should be stored. */
> > > > > +	__u16 csum_offset;
> > > > > +
> > > > > +	/* XDP_TX_METADATA_TIMESTAMP */
> > > > > +
> > > > > +	__u64 tx_timestamp;
> > > > > +};
> >>>
> > > > Is this structure easily extensible for future offloads,
> [...]
> > 
> > Pacing offload is the other feature that comes to mind. That could
> > conceivably use the tx_timestamp field.
> 
> I would really like to see hardware offload "pacing" or LaunchTime as
> hardware chips i210 and i225 calls it. I looked at the TX descriptor
> details for drivers igc (i225) and igb (i210), and documented my finding
> here[1], which should help with the code details if someone is motivated
> for implementing this (I know of people on xdp-hints list that wanted
> this LaunchTime feature).
> 
>   [1] https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org#tx-time-to-hardware-driver-igc

Nice!

> AFAIK this patchset uses struct xsk_tx_metadata as both TX and
> TX-Completion, right?.  It would be "conceivable" to reuse tx_timestamp
> field, but it might be confusing for uAPI end-users.  Maybe a union?

Sure, but do we add it later when we add launch time? For now, let's
figure out whether 'tx_timestamp' is the right name for the 'tx
completion timestamp' :-D Later on, we can union it with launch_time?

