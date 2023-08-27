Return-Path: <netdev+bounces-30950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E194C78A159
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F9280E74
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 20:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4DD14279;
	Sun, 27 Aug 2023 20:17:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8A111A3
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 20:17:59 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42E103
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 13:17:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so3656744a12.3
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693167475; x=1693772275;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lsmpv2SQIe1r/hGPOIUPJdaAzdUfvB0Dts+sfXUfvcs=;
        b=ei8yMDLfacZs1cJ8N5ahaTWeDuN68a2eb549PvLgkLKUBnStxPqvFJ7k+L2XICieJK
         rf9ugG4zxLSL2w2SDQn6BAJI8vO/mYoWQqzqdA/xAPsORm289WanMqB3cddlqyt7iGzn
         hCVD/ZvFcy8olPbFJNfIR638ibsIa6DmRIbe/6Zm/tfffdECQskmu4VrlzplUwres1Ie
         UBS5xrO7DtFoMm5AjQPv51AEX7FWO4ZY2L/0BfQl6Rx9/sRMHw3zRFfm9PMWBSTX9tHC
         qN0xwFFN5hH41MPSSO2OXzVIN/FXDkUzst3wszeqPxw9T4K6CUv3JZuqNqNd+d6o1kke
         mxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693167475; x=1693772275;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lsmpv2SQIe1r/hGPOIUPJdaAzdUfvB0Dts+sfXUfvcs=;
        b=eTnjeJ+g+pVhZyWIZ2ybvsa0/QKL2ZRF+JyKyzpsIUmGUfMtoRTjpW4QfmIWKgdzQJ
         fEk5nkF9dN5Z7/5ug/hRfOGDFWEeRm0NPbIMbSvZf0TVrQapBHBDlBP+wJEcK0ID7BRd
         pctJU4e2puUipiWMppzgOWIl5eU6bNgkLU2V8MzNPiHcvoqKU9zZlhCfU9kkZIgchH0h
         SqM3iTjaS1KQxUtbnMny62BKxilRB8U6h0CJMTp4KEXptVHPOz5iDGze17XUpVM1DnY4
         HGThT2Dnet1onb51uiLgb38Js1SJRNwx8vHlvtM/L80wSr5hiHwuDJdcDkk3iconDt6q
         ZuaQ==
X-Gm-Message-State: AOJu0YyR3bg4uL9IOs78JutPCxtO9EgW145OuHigj+9lzCznU1ZZu9sO
	Qb0XWHkju384UviPvXlddOBl13E0lqM=
X-Google-Smtp-Source: AGHT+IFcP4WO0smKTvrvkO9+soXeY/J+AueVSOrbV4hPPhHFlA6eH2P8bfN53J/K/IRv9WmIOIx2ig==
X-Received: by 2002:a50:fb04:0:b0:523:2e63:b9b with SMTP id d4-20020a50fb04000000b005232e630b9bmr18360375edq.24.1693167474574;
        Sun, 27 Aug 2023 13:17:54 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b00525c01f91b0sm3675789edr.42.2023.08.27.13.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Aug 2023 13:17:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: High Cpu load when run smartdns : __ipv6_dev_get_saddr
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <b82afbaf-c548-5b7e-8853-12c3e6a8f757@kernel.org>
Date: Sun, 27 Aug 2023 23:17:42 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 pymumu@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4898B1F7-2EB5-4182-9D8D-FC8FC780E9B7@gmail.com>
References: <164ECEA1-0779-4EB8-8B2B-387F7CEC7A89@gmail.com>
 <b82afbaf-c548-5b7e-8853-12c3e6a8f757@kernel.org>
To: David Ahern <dsahern@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David,



> On 27 Aug 2023, at 19:51, David Ahern <dsahern@kernel.org> wrote:
>=20
> On 8/27/23 7:20 AM, Martin Zaharinov wrote:
>> Hi Eric=20
>>=20
>>=20
>> i need you help to find is this bug or no.
>>=20
>> I talk with smartdns team and try to research in his code but for the =
moment not found ..
>>=20
>> test system have 5k ppp users on pppoe device
>>=20
>> after run smartdns =20
>>=20
>> service got to 100% load=20
>>=20
>> in normal case when run other 2 type of dns server (isc bind or knot =
) all is fine .
>>=20
>> but when run smartdns  see perf :=20
>>=20
>>=20
>> PerfTop:    4223 irqs/sec  kernel:96.9%  exact: 100.0% lost: 0/0 =
drop: 0/0 [4000Hz cycles],  (target_pid: 1208268)
>> =
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------------------------------------------------------
>>=20
>>    28.48%  [kernel]        [k] __ipv6_dev_get_saddr
>>    12.31%  [kernel]        [k] l3mdev_master_ifindex_rcu
>>     6.63%  [pppoe]         [k] pppoe_rcv
>>     3.82%  [kernel]        [k] ipv6_dev_get_saddr
>>     2.07%  [kernel]        [k] __dev_queue_xmit
>=20
> Can you post stack traces for the top 5 symbols?

If write how i will get.

>=20
> What is the packet rate when the above is taken?

its normal rate of dns query=E2=80=A6 with both other dns server all is =
fine=20

>=20
> 4,223 irqs/sec is not much of a load; can you add some details on the
> hardware and networking setup (e.g., l3mdev reference suggests you are
> using VRF)?
No system is very simple:

eth0 (Internet) Router (smartDNS + pppoe server ) - eth1 ( User side =
with pppoe server ) here have 5000 ppp interface .

with both other service i dont see all work fine.


Here i will add in CC and Nick Peng he is developer of SmartDNS i he =
have idea =E2=80=A6.


m.


