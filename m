Return-Path: <netdev+bounces-15763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7F749956
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48C128117E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB040848C;
	Thu,  6 Jul 2023 10:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E279FD
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 10:25:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7619B7
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688639114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjvjrVrcchow6hGiOnuuMtRWRueWUenkpTgXIpZAAh8=;
	b=ZXEAeRGq2JvVSy103LLX9SVjOu0wZIAdK9A+aPMj5c5GKtW0WIMnJSUaqhkNwfxlZthQrg
	y/uacwhZdpvrPgthyioik6Zeb0222dLZ7XgLXP+LNHRVv9eRdo3CxCCWU3/jedSq6HofhF
	dLwruUnfrCpFW7oH951jZ8SAWi8gAHM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Z3qzNx0COaCeMnvnjaCIPA-1; Thu, 06 Jul 2023 06:25:13 -0400
X-MC-Unique: Z3qzNx0COaCeMnvnjaCIPA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9928b4f1612so42947166b.3
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 03:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688639112; x=1691231112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjvjrVrcchow6hGiOnuuMtRWRueWUenkpTgXIpZAAh8=;
        b=XgDlFGvLCclkSG6KMNcenvKkKIz2ti7tYS93cwh/Wic4HF2DG4eBmrZVyrgsaFJ1B2
         D0AWjz4SuMhyxvML/NCQngl876FVBEcIXaR19lIbvK7aTUswD8pkY9gME2x3nqd5HL5T
         n2oHzCLFV9vltu3CGJXLo4tpnHBta8RTWBw1P/Xi+UikbrGKGuh2vPMVe67VmyAec1oE
         pQAn6Gs1+ZDGX70iM0GJ4POhHpfzDOdmuh/96zvEL/AuWSLz8dLoB72I00l+brzFfu6z
         VCaRX+JOwffopMaKO9n/XBNWQbkE+CaLjKBB5yWXUH0GD25LVZAG4kYWxnauAlAwr4bD
         hCPg==
X-Gm-Message-State: ABy/qLbYaW1AMUgfIa58w6NUrAc3Erpyjq4BhUeoobWbTbm0DeUopobY
	SMfXrsWagbW9675jfHSyXThxYaHhpmBZpW1KZjMlOaGdNnSWz2XyBMsdQsf9j8pl7vFfNHk2VXv
	R+YBNa9FZdj3mNR7y
X-Received: by 2002:a17:907:3e82:b0:992:4250:545b with SMTP id hs2-20020a1709073e8200b009924250545bmr1377607ejc.47.1688639112069;
        Thu, 06 Jul 2023 03:25:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFr9Hi21IV/P3pz9UBZySRhK0MYxzr2A35i5/1bhE3Uhj9GCjFNrePH9akO1T4VJzL3KX0U0Q==
X-Received: by 2002:a17:907:3e82:b0:992:4250:545b with SMTP id hs2-20020a1709073e8200b009924250545bmr1377598ejc.47.1688639111809;
        Thu, 06 Jul 2023 03:25:11 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id jt11-20020a170906dfcb00b009883a3edcfcsm628316ejc.171.2023.07.06.03.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 03:25:11 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <cb8f65a9-30ac-ee6e-3368-e653a72dfaaf@redhat.com>
Date: Thu, 6 Jul 2023 12:25:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 20/20] selftests/bpf: check checksum level in
 xdp_metadata
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-21-larysa.zaremba@intel.com>
In-Reply-To: <20230703181226.19380-21-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 03/07/2023 20.12, Larysa Zaremba wrote:
> Verify, whether kfunc in xdp_metadata test correctly returns checksum level
> of zero.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 +++
>   tools/testing/selftests/bpf/progs/xdp_metadata.c      | 7 +++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 50ac9f570bc5..6c71d712932e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -228,6 +228,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
>   	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
>   		return -1;
>   
> +	if (!ASSERT_NEQ(meta->rx_csum_lvl, 0, "rx_csum_lvl"))
> +		return -1;

Not-equal ("NEQ") to 0 feels weird here.
Below you set meta->rx_csum_lvl=1 in case meta->rx_csum_lvl==0.

Thus, test can pass if meta->rx_csum_lvl happens to be a random value.
We could set meta->rx_csum_lvl to 42 in case meta->rx_csum_lvl==0, and
then use a ASSERT_EQ==42 to be more certain of the case we are testing 
are fulfilled.


> +
>   	xsk_ring_cons__release(&xsk->rx, 1);
>   	refill_rx(xsk, comp_addr);
>   
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index 382984a5d1c9..6f7223d581b7 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -26,6 +26,8 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>   extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>   					__u16 *vlan_tag,
>   					__be16 *vlan_proto) __ksym;
> +extern int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx,
> +					__u8 *csum_level) __ksym;
>   
>   SEC("xdp")
>   int rx(struct xdp_md *ctx)
> @@ -62,6 +64,11 @@ int rx(struct xdp_md *ctx)
>   	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
>   	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag, &meta->rx_vlan_proto);
>   
> +	/* Same as with timestamp, zero is expected */
> +	ret = bpf_xdp_metadata_rx_csum_lvl(ctx, &meta->rx_csum_lvl);
> +	if (!ret && meta->rx_csum_lvl == 0)
> +		meta->rx_csum_lvl = 1;
> +

IMHO it is more human-readable-code to rename "ret" variable "err".

I know you are just reusing variable "ret", so it's not really your fault.



>   	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>   }
>   


