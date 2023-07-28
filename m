Return-Path: <netdev+bounces-22318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D042767026
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36080282861
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1013FF7;
	Fri, 28 Jul 2023 15:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D813FF5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:08:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638E420C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690556922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OVP0vl6LhsH0mGe+FeioSrZgT4FlNIfqgRSSYLOSe4=;
	b=fiA/wOqrI0wBFl2eU4UDkKt2WJkzP6M/i9BX0YygPKbcXt4egLyT39t/BfEvkGOqDyaJ1y
	tFhhLIVYvjnnPr8Xe0b3Z9/hbxgsJMHr4XtTfakJnveTTIXQq1X1dna7IIdirKs8di0Pok
	auZrst0fpAtnbqluzH7P4PROsHEtD60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-k5yWZL7gP_2fyHna6_Ff6g-1; Fri, 28 Jul 2023 11:08:41 -0400
X-MC-Unique: k5yWZL7gP_2fyHna6_Ff6g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso12043025e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556919; x=1691161719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OVP0vl6LhsH0mGe+FeioSrZgT4FlNIfqgRSSYLOSe4=;
        b=CZ1vvDVb6b5UUsnWlBUIztW72Pzq9yBD4thWnKyzofgI2pE9dfxHcFB4EVex6CiHH8
         kSMq+p/PL9+eFPHMNuyOCFEqfNvwKAd/xD+ZTkg3306HriDujTnRYd/UJUBd8RzqwOUd
         9omt8s2Go+BJSPsXwtLC+9q+8vV8nMeZEMP/Eb2S657PPFkkJXaFTigUVTRE8nn83NxF
         S0mUs9oZELoni2tefGsj9ZHIm+wjCXOdoQL0kc7aBed01qU4P0v2OJOit1M+3INqZlT+
         OHFIhRiUd9yvs50HwNzv/WzrNHTXq+EosRm+oxZfiUUqyuorLK3e31LBZhI9UnjEN6Gb
         VJow==
X-Gm-Message-State: ABy/qLarTghYcc29842a51D4ReHcnaq2/xb2jOtzUmo9ME8T6Ln/00ur
	PWYWuuVhEfF8E5OtMbGNb5PbruUPtHnwLrUmtHczeenF4+xIQVJZ9qm0BdChZ28UJulhxbWLX+b
	RPkx3ATE/JMnEnAIZ
X-Received: by 2002:a1c:f70e:0:b0:3fb:4055:1ddd with SMTP id v14-20020a1cf70e000000b003fb40551dddmr1928703wmh.28.1690556919123;
        Fri, 28 Jul 2023 08:08:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIHBkmXFEaj2WtbNUc7EFExJgKzaUEFszJPKoF8ba8AGDE+DCkNuC6Xsrn8j0v7wM9gwj5LA==
X-Received: by 2002:a1c:f70e:0:b0:3fb:4055:1ddd with SMTP id v14-20020a1cf70e000000b003fb40551dddmr1928691wmh.28.1690556918813;
        Fri, 28 Jul 2023 08:08:38 -0700 (PDT)
Received: from [192.168.1.67] (198.red-88-3-59.dynamicip.rima-tde.net. [88.3.59.198])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003fc3b03caa5sm9355519wms.1.2023.07.28.08.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:08:38 -0700 (PDT)
Message-ID: <6eec84f3-f754-06d7-f20e-81cda36ea777@redhat.com>
Date: Fri, 28 Jul 2023 17:08:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ovs-dev] [PATCH v2 net-next 3/5] selftests: openvswitch: add a
 test for ipv4 forwarding
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Ilya Maximets <i.maximets@ovn.org>, Eric Dumazet <edumazet@google.com>,
 linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20230728115940.578658-1-aconole@redhat.com>
 <20230728115940.578658-4-aconole@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20230728115940.578658-4-aconole@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 13:59, Aaron Conole wrote:
> This is a simple ipv4 bidirectional connectivity test.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Adrian Moreno <amorenoz@redhat.com>

> ---
>   .../selftests/net/openvswitch/openvswitch.sh  | 40 +++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 5cdacb3c8c92..5d60a9466dab 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -12,6 +12,7 @@ TRACING=0
>   
>   tests="
>   	arp_ping				eth-arp: Basic arp ping between two NS
> +	connect_v4				ip4-xon: Basic ipv4 ping between two NS
>   	netlink_checks				ovsnl: validate netlink attrs and settings
>   	upcall_interfaces			ovs: test the upcall interfaces"
>   
> @@ -192,6 +193,45 @@ test_arp_ping () {
>   	return 0
>   }
>   
> +# connect_v4 test
> +#  - client has 1500 byte MTU
> +#  - server has 1500 byte MTU
> +#  - use ICMP to ping in each direction
> +test_connect_v4 () {
> +
> +	sbx_add "test_connect_v4" || return $?
> +
> +	ovs_add_dp "test_connect_v4" cv4 || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_connect_v4" "cv4" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +
> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	# Add forwarding for ARP and ip packets - completely wildcarded
> +	ovs_add_flow "test_connect_v4" cv4 \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_connect_v4" cv4 \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "test_connect_v4" cv4 \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' '2' || return 1
> +	ovs_add_flow "test_connect_v4" cv4 \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20)' '1' || return 1
> +
> +	# do a ping
> +	ovs_sbx "test_connect_v4" ip netns exec client ping 172.31.110.20 -c 3 || return 1
> +
> +	info "done..."
> +	return 0
> +}
> +
>   # netlink_validation
>   # - Create a dp
>   # - check no warning with "old version" simulation

-- 
Adrián Moreno


