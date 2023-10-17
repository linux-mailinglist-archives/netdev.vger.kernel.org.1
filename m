Return-Path: <netdev+bounces-41821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A887CBF8D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25C5B20EFE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4C405C0;
	Tue, 17 Oct 2023 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ZSSxz7tW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E63F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:36:47 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17336F7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:36:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32003aae100so4147458f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535404; x=1698140204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnyvAPXfbM3pHNArgX/1TjFCxp90NMWGwLop+8z7TkU=;
        b=ZSSxz7tWNl55EeB2CcwotpOMkL2La+22EMB+ZDNFywGbA7wO5PDVaZjAYkAHgHvHR+
         4/3b0ADjRUutvgtMj6RnH/HMeL3T1bVb2J7RhwgARmLvNzRMMpyFt1qb/6eue6l4mzo5
         6JypqILQ1pVVkm0X7q0vuLi6GWq6BB6ngRRy1qySAc9ov1LOXAGQu6ban3ICwu+EiBf3
         ow1dupYl4b30L+UN7qpxfrZ9Mg+CHNzDOHsIcxWCecraKom+h9+KKzlBMb1ThPvnnk0S
         Rs6zvHk/Qz8pmMbtjevvz4J0pyoIunL7adtUSHooc8imIj+/jPzGsSx6BYoqFnGLN8ef
         kXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535404; x=1698140204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnyvAPXfbM3pHNArgX/1TjFCxp90NMWGwLop+8z7TkU=;
        b=VcGhjsiKnGMfiWWxmhwtVY/8t5M2pimYectwDbUiKO+AkmgV0eU9YwDdCxeJtIWjTm
         HonOporPrksZ0EGpP6XxtT3jSSg/CwPXB2qsuOxpKhUudnOz/xEapCfI0ricT1rNb3fq
         o5RTg0AJoCbKTaWJtRSE/nqrWGPHVV6tWyjcNAscMyEJSfevYfrUP1Nk6olj4QdCaol9
         u0DTvJkXKoQ7+jqFqzCkkeZCrsOSWxYmW2hoODqXgpMKBJMrpQtky6ICMRAbaTcYu7Xm
         PvF0QJ4h1CTxE6dFDcj/k7Ga0yfwuhbPB8fVRA8HiZK8it6gFuvb4K5RvQauCb+/Lf7z
         yS1Q==
X-Gm-Message-State: AOJu0Yzxl/Ss7f5PkYiqXBoo9m+P5u/m7QSJr6lHeG2kby9wWdviktMR
	9d9qJnW+7G981LVBHEMqPmz2Iw==
X-Google-Smtp-Source: AGHT+IGXwC1JEe9tF7odbnErBwyHB4WoQJZa/co8D0f/ZTYmDAfz2ci9Fh9t4tr6buMcRKVahKMO5w==
X-Received: by 2002:adf:a2db:0:b0:32d:bff1:1361 with SMTP id t27-20020adfa2db000000b0032dbff11361mr1136185wra.28.1697535404468;
        Tue, 17 Oct 2023 02:36:44 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id e13-20020adfe38d000000b00327de0173f6sm1248843wrm.115.2023.10.17.02.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:36:43 -0700 (PDT)
Message-ID: <0b2a9bfc-4a77-a9b6-9df7-eacd40e1ca2a@blackwall.org>
Date: Tue, 17 Oct 2023 12:36:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 3/8] bridge: fdb: support match on nexthop
 ID in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-4-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-4-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Extend "fdb flush" command to match fdb entries with a specific nexthop ID.
> 
> Example:
> $ bridge fdb flush dev vx10 nhid 2
> This will flush all fdb entries pointing to vx10 with nexthop ID 2.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c      | 10 +++++++++-
>   man/man8/bridge.8 |  7 +++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/bridge/fdb.c b/bridge/fdb.c
> index 12d19f08..6ae1011a 100644
> --- a/bridge/fdb.c
> +++ b/bridge/fdb.c
> @@ -46,7 +46,8 @@ static void usage(void)
>   		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
>   		"              [ vlan VID ] [ vni VNI ] [ self ] [ master ] [ dynamic ]\n"
>   		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ] [ src_vni VNI ]\n"
> -		"              [ self ] [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
> +		"              [ nhid NHID ] [ self ] [ master ]\n"
> +		"	       [ [no]permanent | [no]static | [no]dynamic ]\n"
>   		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
>   		"              [ [no]offloaded ]\n");
>   	exit(-1);
> @@ -701,6 +702,7 @@ static int fdb_flush(int argc, char **argv)
>   	unsigned short ndm_flags = 0;
>   	unsigned short ndm_state = 0;
>   	unsigned long src_vni = ~0;
> +	__u32 nhid = 0;
>   	char *endptr;
>   
>   	while (argc > 0) {
> @@ -769,6 +771,10 @@ static int fdb_flush(int argc, char **argv)
>   			if ((endptr && *endptr) ||
>   			    (src_vni >> 24) || src_vni == ULONG_MAX)
>   				invarg("invalid src VNI\n", *argv);
> +		} else if (strcmp(*argv, "nhid") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&nhid, *argv, 0))
> +				invarg("\"id\" value is invalid\n", *argv);

id -> nhid in the error ?

>   		} else if (strcmp(*argv, "help") == 0) {
>   			NEXT_ARG();
>   		} else {
> @@ -817,6 +823,8 @@ static int fdb_flush(int argc, char **argv)
>   		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
>   	if (src_vni != ~0)
>   		addattr32(&req.n, sizeof(req), NDA_SRC_VNI, src_vni);
> +	if (nhid > 0)
> +		addattr32(&req.n, sizeof(req), NDA_NH_ID, nhid);
>   	if (ndm_flags_mask)
>   		addattr8(&req.n, sizeof(req), NDA_NDM_FLAGS_MASK,
>   			 ndm_flags_mask);
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index b1e96327..eaeee81b 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -130,6 +130,8 @@ bridge \- show / manipulate bridge addresses and devices
>   .IR VID " ] [ "
>   .B src_vni
>   .IR VNI " ] [ "
> +.B nhid
> +.IR NHID " ] ["
>   .BR self " ] [ " master " ] [ "
>   .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
>   .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
> @@ -900,6 +902,11 @@ the src VNI Network Identifier (or VXLAN Segment ID) for the operation. Match
>   forwarding table entries only with the specified VNI. Valid if the referenced
>   device is a VXLAN type device.
>   
> +.TP
> +.BI nhid " NHID"
> +the ecmp nexthop group for the operation. Match forwarding table entries only

perhaps ECMP ?

> +with the specified NHID. Valid if the referenced device is a VXLAN type device.
> +
>   .TP
>   .B self
>   the operation is fulfilled directly by the driver for the specified network


