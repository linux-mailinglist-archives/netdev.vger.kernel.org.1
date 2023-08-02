Return-Path: <netdev+bounces-23566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C713576C855
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D151C21240
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A515B0;
	Wed,  2 Aug 2023 08:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5A567B
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:30:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1EA1718
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690965056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spT8fPKpBrur06PlvqJtfOWJsGk5XV9Ogm63QxBCjDI=;
	b=DlqAGKEcAsaNxXDswEBdOgjDX7g6t+2sxII1nouXMx1rcnrOARihtGQePAufbwHBT5Ci3u
	S1Kbm82RuJKtEAl+qlOm80ROjlZ6eteLRy2uf81dzJV3TaMFhH/uASq7PRexLFOLIRdzFJ
	yIGKA3qOD+DssUIJrKw1qXLZenLmuN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-pCrBGRJoMCSGEqau_A7zpQ-1; Wed, 02 Aug 2023 04:30:55 -0400
X-MC-Unique: pCrBGRJoMCSGEqau_A7zpQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-317a84a3ebeso335507f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 01:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690965054; x=1691569854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spT8fPKpBrur06PlvqJtfOWJsGk5XV9Ogm63QxBCjDI=;
        b=fx9+4zUNOUqIaAFIhVb4RgOMBIZ6V9hfECOSNkDZpFcyh6Hx9Yngtly7w3tfqwCEb7
         DxrFt7pt7Rd6pdS2zQvyD7GhzZztfb0C5pEe40oe1bfXf35iAGry4XYMMEOjSCjjly+j
         J3JhHqT1iLvhcwy//44qN3gT7Z11LcYjOHFr2+tTU/EBvFSDpfTS7tzLHIDhVtGXmJu0
         gyCuLh28Q6nAWaa/UfWSoVXLCxhxy8F1hNI/tMFqKciiWZ9VifFp5VzxLPE+c95hcMT2
         tqxFeVuR1/UxuohNAm8LVJTNPyYZRBv309FG1bKilTKdqtsLaDz05tefVlukqsxnhvX6
         4IEw==
X-Gm-Message-State: ABy/qLba8OiX2x+VWEjRmul+aLZ7Aab6abfCK+etIOAfgS5oD5AWRrYc
	eNg/cRXQRsoHRUKf7kobzdVqlPRRLE31EREwkEK/iDNtZBw7vxVePX9/0QX63Pu6cwgG91ALWv1
	GfT4APd9XMo0Mt3gR
X-Received: by 2002:adf:e7c3:0:b0:314:1f0:5846 with SMTP id e3-20020adfe7c3000000b0031401f05846mr3834083wrn.19.1690965053881;
        Wed, 02 Aug 2023 01:30:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEj47SZeYxoccOiABA+KmMfcUrcXgKlvMiT/hmItGRVmgnRQkrrpjBTDyY0QM+uH8dra14NSA==
X-Received: by 2002:adf:e7c3:0:b0:314:1f0:5846 with SMTP id e3-20020adfe7c3000000b0031401f05846mr3834062wrn.19.1690965053438;
        Wed, 02 Aug 2023 01:30:53 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b003172510d19dsm18409682wrt.73.2023.08.02.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:30:52 -0700 (PDT)
Date: Wed, 2 Aug 2023 10:30:52 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net 13/17] selftests: forwarding: tc_tunnel_key: Make
 filters more specific
Message-ID: <ZMoUPP53JWP7l2pG@dcaratti.users.ipa.redhat.com>
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-14-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802075118.409395-14-idosch@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 10:51:14AM +0300, Ido Schimmel wrote:
> The test installs filters that match on various IP fragments (e.g., no
> fragment, first fragment) and expects a certain amount of packets to hit
> each filter. This is problematic as the filters are not specific enough
> and can match IP packets (e.g., IGMP) generated by the stack, resulting
> in failures [1].

[...]

> --- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
> +++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
> @@ -104,11 +104,14 @@ tunnel_key_nofrag_test()
>  	local i
>  
>  	tc filter add dev $swp1 ingress protocol ip pref 100 handle 100 \
> -		flower ip_flags nofrag action drop
> +		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
> +		ip_flags nofrag action drop
>  	tc filter add dev $swp1 ingress protocol ip pref 101 handle 101 \
> -		flower ip_flags firstfrag action drop
> +		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
> +		ip_flags firstfrag action drop
>  	tc filter add dev $swp1 ingress protocol ip pref 102 handle 102 \
> -		flower ip_flags nofirstfrag action drop
> +		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
> +		ip_flags nofirstfrag action drop


hello Ido, my 2 cents:

is it safe to match on the UDP protocol without changing the mausezahn
command line? I see that it's generating generic IP packets at the
moment (i.e. it does '-t ip'). Maybe it's more robust to change
the test to generate ICMP and then match on the ICMP protocol?

thanks!
-- 
davide

 


