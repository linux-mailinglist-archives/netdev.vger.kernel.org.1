Return-Path: <netdev+bounces-15757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6637498D0
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC01C20CBD
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2517483;
	Thu,  6 Jul 2023 09:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7179F5
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:57:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC660113
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688637431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zsb1SP89ZGc9tRZJIomQD8nqsVc6zy47mftdUlg5sk=;
	b=ipyLF4aAG4gt6LkZ9PNYfxNexbVtqy8JsDVfcZeqFqrPTPWWduQsCyXrUHjQCfTE668Z6u
	Pi6o6VMp37/2oBNwYayNcBz7mAysRDPKOa4eQ3vV3W1QIyT62D5G/xjv//qzqgBhoUhwqN
	EqkilADWqhXIDkNER6wdFVf1iWTt38o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-YPkoINMCMGajsfqPTaWq0w-1; Thu, 06 Jul 2023 05:57:09 -0400
X-MC-Unique: YPkoINMCMGajsfqPTaWq0w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b70347bf04so4866281fa.3
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 02:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637428; x=1691229428;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zsb1SP89ZGc9tRZJIomQD8nqsVc6zy47mftdUlg5sk=;
        b=aSj+BiTPkYsq2PcApDnBkVZlRmBr6DDBCYflfnr8q6TTUo2rOS4QmrZhc26rZ17ZNg
         qNPW+aWVZBJ3uFsOg7aaG3+0CJZujc/swWE2TDbw1175WJZdZGyXo08isqvkwPLB91t/
         Ag1mkDSm8uEbRvJRtkBWc+Gyqxoz1R99fC6tqJSnFGObLK8xdcym3R4S1oGxt2nfZTOJ
         5AKBByjcQwaQOlLCRNBolcTqT4bkmJsT2TiD0iu59kRH4sD7ZTZRzmaWI3PjI1m6Lt+I
         +EQEz9r14dAxxgh2q3OonbJAwddpMmGbiN/giqI7Aa6wbSnGpqKj2bcR10cRaJY2jVDd
         87DQ==
X-Gm-Message-State: ABy/qLYVxKWh1fZxDopTw7qUd/058u2kpIzStOuR7EN/o9G1A6QD9SqV
	cN8DSfA0Tlh0QyhWU9kmlG7ZSFqJUIMcJ/2SAI27/71R0idDHoGecCJgO86ZOB0GEupKPxYllY2
	RHJV4NMBx/NED0FeU
X-Received: by 2002:a2e:b04d:0:b0:2b6:a6e7:5afa with SMTP id d13-20020a2eb04d000000b002b6a6e75afamr1076069ljl.12.1688637428266;
        Thu, 06 Jul 2023 02:57:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgougTcsRRbzaKfup7nQpf8GbXN1NXXCsc8c7jqbLKRFju0/oFjZjKYnDenXAULCC5eq2cRw==
X-Received: by 2002:a2e:b04d:0:b0:2b6:a6e7:5afa with SMTP id d13-20020a2eb04d000000b002b6a6e75afamr1076050ljl.12.1688637427940;
        Thu, 06 Jul 2023 02:57:07 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id y17-20020aa7d511000000b0051bf57aa0c6sm561571edq.87.2023.07.06.02.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 02:57:07 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <72f31e46-55f7-1e09-bf69-9ebde6f9e732@redhat.com>
Date: Thu, 6 Jul 2023 11:57:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 17/20] veth: Implement VLAN tag and checksum
 level XDP hint
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-18-larysa.zaremba@intel.com>
 <ZKWnbfTXp/vyHYUU@google.com>
In-Reply-To: <ZKWnbfTXp/vyHYUU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 05/07/2023 19.25, Stanislav Fomichev wrote:
> On 07/03, Larysa Zaremba wrote:
>> In order to test VLAN tag and checksum level XDP hints in
>> hardware-independent selfttests, implement newly added XDP hints in veth
>> driver.
>>
>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>> ---
>>   drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 614f3e3efab0..a7f2b679551d 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -1732,6 +1732,44 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>>   	return 0;
>>   }
>>   
>> +static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
>> +				__be16 *vlan_proto)
>> +{
>> +	struct veth_xdp_buff *_ctx = (void *)ctx;
>> +	struct sk_buff *skb = _ctx->skb;
>> +	int err;
>> +
>> +	if (!skb)
>> +		return -ENODATA;
>> +
> 
> [..]
> 
>> +	err = __vlan_hwaccel_get_tag(skb, vlan_tag);
> 
> We probably need to open code __vlan_hwaccel_get_tag here. Because it
> returns -EINVAL on !skb_vlan_tag_present where the expectation, for us,
> I'm assuming is -ENODATA?
> 

Looking at in-tree users of __vlan_hwaccel_get_tag(), they don't use the
err value for anything.  Thus, we can just change
__vlan_hwaccel_get_tag() to return -ENODATA instead of -EINVAL.  (And
also remember __vlan_get_tag() adjustmment).


$ git diff
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 6ba71957851e..fb35d7dd77a2 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -540,7 +540,7 @@ static inline int __vlan_get_tag(const struct 
sk_buff *skb, u16 *vlan_tci)
         struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);

         if (!eth_type_vlan(veth->h_vlan_proto))
-               return -EINVAL;
+               return -ENODATA;

         *vlan_tci = ntohs(veth->h_vlan_TCI);
         return 0;
@@ -561,7 +561,7 @@ static inline int __vlan_hwaccel_get_tag(const 
struct sk_buff *skb,
                 return 0;
         } else {
                 *vlan_tci = 0;
-               return -EINVAL;
+               return -ENODATA;
         }
  }



>> +	if (err)
>> +		return err;
>> +
>> +	*vlan_proto = skb->vlan_proto;
>> +	return err;
>> +}
>> +
>> +static int veth_xdp_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
>> +{
>> +	struct veth_xdp_buff *_ctx = (void *)ctx;
>> +	struct sk_buff *skb = _ctx->skb;
>> +
>> +	if (!skb)
>> +		return -ENODATA;
>> +
>> +	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
>> +		*csum_level = skb->csum_level;
>> +	else if (skb->ip_summed == CHECKSUM_PARTIAL &&
>> +		 skb_checksum_start_offset(skb) == skb_transport_offset(skb) ||
>> +		 skb->csum_valid)
>> +		*csum_level = 0;
>> +	else
>> +		return -ENODATA;
>> +
>> +	return 0;
>> +}
>> +
[...]


