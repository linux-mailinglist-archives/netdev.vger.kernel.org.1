Return-Path: <netdev+bounces-16885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8374F481
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE9B281804
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0175619BD3;
	Tue, 11 Jul 2023 16:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517E19BBA
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:10:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15371731
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689091762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHgmi2wwFrPjMP5Rxs8KSVDqK1J+qf75UCdExpa0HJo=;
	b=FAEk0HWXnilwz3LsY/kart+Q7pfP7muWGMaiJy4RJwfattSPglA3JwClHG+w15DH9rawPD
	D3oEjHXCQVS2Ubj8OJFO/EzCmnlhA4vERSSjV42BQWQ1w8JS90eMCAVj1E1Wo7/O5e8oV+
	Nl8QHyQKjETEtg4Ry+dy5xhBAq2fvSg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-EGTIuPb7O1OAiTItO9gAFA-1; Tue, 11 Jul 2023 12:06:56 -0400
X-MC-Unique: EGTIuPb7O1OAiTItO9gAFA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993d5006993so292041166b.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091596; x=1691683596;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHgmi2wwFrPjMP5Rxs8KSVDqK1J+qf75UCdExpa0HJo=;
        b=eTJzi1DH8mtGKn1rFSsHqsg6/aLDm/8xzghk61WS14A2OXvHi4NxQC6OUTeNwBF3sA
         hzp7APMBB/NlFQLsfjF8slh+EHDPL7FblwWwQO8klLxeRNsWVKEN6n9cgd8T3j0/ZGp6
         LZnww0XNypEYkzLbAsNMcLrSbxJog6SHxVYOc86SA2asRjGTafuj3ML8DU79oUfpmDy2
         0pzc3O1jXXXwtylkcd6dFx6pPTtGMacaERSpGEGBYlPzh85Yl0HWJU0ha5ru3Sl9OraX
         9UiWTL+pJ3eF2N0P/lVgwdyByCGrFkFgxc3WMxGTTylgeP0bMeSFr1HJ3kPCybOJq7Oe
         7Ngg==
X-Gm-Message-State: ABy/qLZ3Kae228O2pR2bZ75lQ1geaup0u3ctORwZFdDR6bcDfM6wim3A
	B3cvDtYL/ufMrbcSmY1C2bMCP2tju9swFs4erRWV6Ls3FFy0EDN7q0GODi0yoGFvw5jTPVZEpgN
	kbiwUP+d2HBfVFwVn
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr7195369ejl.4.1689091596090;
        Tue, 11 Jul 2023 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVb+VnLW+A+oRRKhUDHDJ2ge75t79bT8wF0gNCeIcmMzqWP9QSikucwVt4UtqYjBbKUKQ5GA==
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr7195342ejl.4.1689091595649;
        Tue, 11 Jul 2023 09:06:35 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709060ad300b009934b1eb577sm1340404ejf.77.2023.07.11.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 09:06:35 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <da7ac0a1-5f62-bc0e-8954-d3d1e846fb52@redhat.com>
Date: Tue, 11 Jul 2023 18:06:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huawei.com>,
 Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711115848.2701559-1-pulehui@huaweicloud.com>
In-Reply-To: <20230711115848.2701559-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 11/07/2023 13.58, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a memory leak as follows:
> 
[...]>
> In the cpu_map_update_elem flow, when kthread_stop is called before
> calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bit
> of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
> will never be executed, and rcpu->refcnt will never be 0, which will
> lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot be
> released.
> 
> Calling kthread_stop before executing kthread's threadfn will return
> -EINTR. We can complete the release of memory resources in this state.
> 
> Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

LGTM, thanks for fixing this.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


