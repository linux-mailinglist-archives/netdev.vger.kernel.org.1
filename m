Return-Path: <netdev+bounces-25657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325C77509D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 04:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3762819C6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17616376;
	Wed,  9 Aug 2023 02:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865762C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:02:28 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046031BCD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:02:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686b643df5dso4434298b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 19:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691546547; x=1692151347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zi1MK0Dr2IIdCuTzoCjzxF/xq8gQlbln/7ZKksVbTQ=;
        b=BFkxoOmxMXUtddEvdt7OJnExEFsGtWCUQKj3GwT6HvEXLg+pdb812ckogCifaMIEcp
         bxz5gAFAOiuyK5Lt2S6/aRYV2dSDE06uI7vJOzBCHKg/iq58mgF0vQDmbMpoE9V2fcoT
         kavPgdXiYWkPstm9YqTBraRBh0pBrvF7Oh+QJV9kvPPNndLwgwDe6b/tytV1RueOj9Kb
         yUsk2ZIa/cMq78xObqBTSEc2HqXnLmnw5xHS+lk8KYVwkvE/KK/zvOxaA9T25EQRJjwr
         EW26PNrkAQqqt7yB6GD4JGuAcb55fOE2KX+hdFEBHNS2g/RiITnWjXtvp3W3Z0AmdAn9
         O5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546547; x=1692151347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zi1MK0Dr2IIdCuTzoCjzxF/xq8gQlbln/7ZKksVbTQ=;
        b=Fc8ctmqBpUFyjF5ARXiPCAHeQ1foiG8HKdL39og9jkx9zk4m1CmSfgmwVS8aor9UXF
         lcEliAGmLv7b1zRMy1tnTVFknEPcW0GmmuH41CQbBneG1A3PuKaDtMbn6E+GlR1cki7O
         tIta8K+o6h5+wPzr56nEPh7rQkCu4fVpRKPC4xRTxgR4JzQvNnu3oKJIwgxrlkh0ochO
         WQ2QPjAGLvF5Xf/Yjd9e5ARgHEwOYI81GMSHPexa4H67wA2m7OV0/3zUdW6WXhaa6qWY
         uyQjBxIohyMS9S1j215ddFOwlGGaPJeYW2R5GpxcIbKBxKMoXSpLj2rn4xSA9MU0hzLa
         w8mA==
X-Gm-Message-State: AOJu0YwoVcjZ4Lvf/wxrOnZyuCk+AS1RzM7moNi0bkFYYZThLVEmqpfh
	73gz3AeahuUIoVWF6FpJBE7SIdW/vltgLw==
X-Google-Smtp-Source: AGHT+IEuBBXKTTTx2cXimFPIsIsWwu9ltYTmcik5UsZbbgFuyNYkQGjUrLnNJTciT/M8fbA4P+DILA==
X-Received: by 2002:a05:6a20:f3aa:b0:140:7b6a:68fe with SMTP id qr42-20020a056a20f3aa00b001407b6a68femr1171764pzb.35.1691546547346;
        Tue, 08 Aug 2023 19:02:27 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b001b53c8659fesm9690709plb.30.2023.08.08.19.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:02:26 -0700 (PDT)
Date: Wed, 9 Aug 2023 10:02:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net v2 09/17] selftests: forwarding: hw_stats_l3_gre:
 Skip when using veth pairs
Message-ID: <ZNLzrj5opo9gra4U@Laptop-X1>
References: <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808141503.4060661-10-idosch@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 05:14:55PM +0300, Ido Schimmel wrote:
> Layer 3 hardware stats cannot be used when the underlying interfaces are
> veth pairs, resulting in failures:
> 
>  # ./hw_stats_l3_gre.sh
>  TEST: ping gre flat                                                 [ OK ]
>  TEST: Test rx packets:                                              [FAIL]
>          Traffic not reflected in the counter: 0 -> 0
>  TEST: Test tx packets:                                              [FAIL]
>          Traffic not reflected in the counter: 0 -> 0
> 
> Fix by skipping the test when used with veth pairs.
> 
> Fixes: 813f97a26860 ("selftests: forwarding: Add a tunnel-based test for L3 HW stats")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>  tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh b/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
> index eb9ec4a68f84..7594bbb49029 100755
> --- a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
> +++ b/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
> @@ -99,6 +99,8 @@ test_stats_rx()
>  	test_stats g2a rx
>  }
>  
> +skip_on_veth
> +
>  trap cleanup EXIT
>  
>  setup_prepare

Petr has been add a veth check for this script in a9fda7a0b033 ("selftests:
forwarding: hw_stats_l3: Detect failure to install counters"). I think we can
remove it with your patch?

Thanks
Hangbin

