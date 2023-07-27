Return-Path: <netdev+bounces-21943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E547655A2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE832822DD
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEE1772B;
	Thu, 27 Jul 2023 14:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C700171A0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:11:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB030C7
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690467073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02H8x558hkZCT5QcK29c6OWGjNlpE3njHKaLGMgzpjQ=;
	b=Un68SH9gUWclIsn9p0B15Je36PqZOHbt0LWp43GX1qhCKVHr5nKPMhEHgNt0UR/0/qjiAI
	WTgyC8gQsK4R/n9xWKEKn58k2bkjuJJ2ONb2uVNNiWP4mBeqd3crqVe5aTjQ7JHbNNlztN
	j6Chq4CpZ19tn7Ly2m0MJ2xHAAwwMgo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-DTNQWaz3OUWYWtX4Puslug-1; Thu, 27 Jul 2023 10:11:12 -0400
X-MC-Unique: DTNQWaz3OUWYWtX4Puslug-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bcf56a2e9so60020566b.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467071; x=1691071871;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02H8x558hkZCT5QcK29c6OWGjNlpE3njHKaLGMgzpjQ=;
        b=VwDNGNpWPGD425cHIPrg53iiMdGIm7F13WLxR6nUt0DJtDwI/E6zgc026y7cdLeFXT
         z2J8hVemgvRjc+FXd1EnTK56VUiGOayGyvMOi3fEe3OoV/l9T1pySDk+akFSlN1OOBpi
         uFWW/CC6qMc/b74xzyhuiDh49oWUxYmqG0BEXhmQO7GkjPCmrH2hDwLzxpcG7ZlLJKnn
         wicrgS95NRE1kQgFMBi/ED7OYgeHlH8MZ+J3Fu52sYmyVEYC37PYpf/4ukOmIrzTmUH3
         ZoeoDsAsL5O6o3IgoE/9A0tGVuVEpK5kAXx5IVApMzO83ewsU7uZm6I9CvExl/jZTaZf
         cY3w==
X-Gm-Message-State: ABy/qLbVBipiLVfBHPLEdze8Q0ag59lOssIKXUZhcaCGmgbkARQcSFSW
	PqW3zQkho2jYN5QG4Gvrq2RZrgaU3HwP2T/rgWLBS+WBtwGvV4zCrUONEA91b2tLM42LeAdUxhr
	l356nbCgXbQMtIBnS
X-Received: by 2002:a17:906:7a54:b0:99b:4668:865f with SMTP id i20-20020a1709067a5400b0099b4668865fmr2312434ejo.10.1690467071172;
        Thu, 27 Jul 2023 07:11:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7IjqGxmTTXNFgOyjXwTagVILgqatNGoMeAgn/XqtOcq6Hkn97NgBSsfxMxoZ+Mwp8fNZ7Dg==
X-Received: by 2002:a17:906:7a54:b0:99b:4668:865f with SMTP id i20-20020a1709067a5400b0099b4668865fmr2312413ejo.10.1690467070894;
        Thu, 27 Jul 2023 07:11:10 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b00982a92a849asm822836ejb.91.2023.07.27.07.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:11:10 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <50fc375a-27a7-8b6a-3938-f9fcb4f85b06@redhat.com>
Date: Thu, 27 Jul 2023 16:11:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org,
 willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org,
 netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stanislav Fomichev <sdf@google.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
 <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch>
 <ZMBPDe+IhvTQnKQa@google.com>
 <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 26/07/2023 01.10, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
>> On 07/25, Willem de Bruijn wrote:
>>> Stanislav Fomichev wrote:
[...]
>>>> +struct xsk_tx_metadata {
>>>> +	__u32 flags;
>>>> +
>>>> +	/* XDP_TX_METADATA_CHECKSUM */
>>>> +
>>>> +	/* Offset from desc->addr where checksumming should start. */
>>>> +	__u16 csum_start;
>>>> +	/* Offset from csum_start where checksum should be stored. */
>>>> +	__u16 csum_offset;
>>>> +
>>>> +	/* XDP_TX_METADATA_TIMESTAMP */
>>>> +
>>>> +	__u64 tx_timestamp;
>>>> +};
 >>>
>>> Is this structure easily extensible for future offloads,
[...]
> 
> Pacing offload is the other feature that comes to mind. That could
> conceivably use the tx_timestamp field.

I would really like to see hardware offload "pacing" or LaunchTime as
hardware chips i210 and i225 calls it. I looked at the TX descriptor
details for drivers igc (i225) and igb (i210), and documented my finding
here[1], which should help with the code details if someone is motivated
for implementing this (I know of people on xdp-hints list that wanted
this LaunchTime feature).

   [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org#tx-time-to-hardware-driver-igc

AFAIK this patchset uses struct xsk_tx_metadata as both TX and 
TX-Completion, right?.  It would be "conceivable" to reuse tx_timestamp 
field, but it might be confusing for uAPI end-users.  Maybe a union?

--Jesper


