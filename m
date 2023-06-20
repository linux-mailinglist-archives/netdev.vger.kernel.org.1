Return-Path: <netdev+bounces-12349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD37372BB
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452521C20CF7
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25E2AB59;
	Tue, 20 Jun 2023 17:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1892AB3F
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:25:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DA1739
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687281938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WelivlojEg7/Ui+rvmWELsM50z+DhTfitwvWDoBJs90=;
	b=HxTOVjjlg2+jCZe0iAbw9G2LdGYCCAdljv9j6ioVu+TZytrwgM/tnEM0YG1y4gcmqH2R69
	OyTgqLDJXtramrQHMpoCcJ6ABhmq2hgQ7AeTzprYzUBVX+PeQ0scarg2+ZPluIir2NQsV7
	avgWyUdw4PwOxitmGd4VHrnmWb5p7fA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-zewn3n3gM3GZ971JozJXsA-1; Tue, 20 Jun 2023 13:25:35 -0400
X-MC-Unique: zewn3n3gM3GZ971JozJXsA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edb90ccaadso3475904e87.3
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 10:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281934; x=1689873934;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WelivlojEg7/Ui+rvmWELsM50z+DhTfitwvWDoBJs90=;
        b=F/DPZZHd7Uoay89wfSRNZL8epTrZH7+UgK67itOlUqgEmEdWUTPYRtacYYlPdkw87d
         yr52KDAiPRm+DdLvQIoq/hwlZrW9b+s7o44e6oRMeFGDMfIzP5AOuZ4vYqO7KbAnCMWW
         Z2n34OqQ/lGhW6tHypyVD7GAiipPvxuZzHuMygtZZH4LgIZGdF1LOg4oLk3TJvxrw9ut
         UTuTrAKpe5+Zsliz0k5AiYtZlkaIXYef0UKHcksFko25CWvtNZhlbdbhzU/XJS/btjdx
         2dy235reWjLjW89ubpvJSSMssPgWhypQUU5rT3D5KrT5HaWMF4f1JyhVA/0hWIkrHoer
         pGjg==
X-Gm-Message-State: AC+VfDxUA27FbVg8e0ZxaYvxKRTBruKB232p/h0KCuIHc87Xpx9a1i0T
	nzb4DdEIqnIlY+ovv92mLN+t4ou1bmiiohxuQVZjftwG3soRA2znKpudL/dVs6phkZoNcDOGT4w
	30WZIrWq7GgXCsxGQ
X-Received: by 2002:a19:4f01:0:b0:4f9:5711:2eb6 with SMTP id d1-20020a194f01000000b004f957112eb6mr208932lfb.28.1687281934108;
        Tue, 20 Jun 2023 10:25:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uHsk/RiCH395+1HpLTCiH7Cx0/5T9OaASsbbrdWzEC8sgwk7OYrc5fsB2I/fC9LtWsg/cfw==
X-Received: by 2002:a19:4f01:0:b0:4f9:5711:2eb6 with SMTP id d1-20020a194f01000000b004f957112eb6mr208907lfb.28.1687281933353;
        Tue, 20 Jun 2023 10:25:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f908ee3091sm9226918wmi.3.2023.06.20.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA910BBF0AF; Tue, 20 Jun 2023 19:25:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 tirthendu.sarkar@intel.com, maciej.fijalkowski@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helpers
 for supporting multi-buffer in Tx path
In-Reply-To: <20230615172606.349557-7-maciej.fijalkowski@intel.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-7-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Jun 2023 19:25:31 +0200
Message-ID: <87352mdp10.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>
> In Tx path, xsk core reserves space for each desc to be transmitted in
> the completion queue and it's address contained in it is stored in the
> skb destructor arg. After successful transmission the skb destructor
> submits the addr marking completion.
>
> To handle multiple descriptors per packet, now along with reserving
> space for each descriptor, the corresponding address is also stored in
> completion queue. The number of pending descriptors are stored in skb
> destructor arg and is used by the skb destructor to update completions.
>
> Introduce 'skb' in xdp_sock to store a partially built packet when
> __xsk_generic_xmit() must return before it sees the EOP descriptor for
> the current packet so that packet building can resume in next call of
> __xsk_generic_xmit().
>
> Helper functions are introduced to set and get the pending descriptors
> in the skb destructor arg. Also, wrappers are introduced for storing
> descriptor addresses, submitting and cancelling (for unsuccessful
> transmissions) the number of completions.
>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
>  include/net/xdp_sock.h |  6 ++++
>  net/xdp/xsk.c          | 74 ++++++++++++++++++++++++++++++------------
>  net/xdp/xsk_queue.h    | 19 ++++-------
>  3 files changed, 67 insertions(+), 32 deletions(-)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 36b0411a0d1b..1617af380162 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -68,6 +68,12 @@ struct xdp_sock {
>  	u64 rx_dropped;
>  	u64 rx_queue_full;
>  
> +	/* When __xsk_generic_xmit() must return before it sees the EOP descriptor for the current
> +	 * packet, the partially built skb is saved here so that packet building can resume in next
> +	 * call of __xsk_generic_xmit().
> +	 */
> +	struct sk_buff *skb;

What ensures this doesn't leak? IIUC, when the loop in
__xsk_generic_xmit() gets to the end of a batch, userspace will get an
EAGAIN error and be expected to retry the call later, right? But if
userspace never retries, could the socket be torn down with this pointer
still populated? I looked for something that would prevent this in
subsequent patches, but couldn't find it; am I missing something?

-Toke


