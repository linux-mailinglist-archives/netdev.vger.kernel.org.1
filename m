Return-Path: <netdev+bounces-34924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DAD7A5F0C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FAB2812E8
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751762E63B;
	Tue, 19 Sep 2023 10:08:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13727110B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:08:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDEEA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695118099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cERlGbZRXFnv/hzYhptX+YYYGk8PD0dNEVNa7S3t2J4=;
	b=W+H3jrbU+utcl7yBiRCZ9JbeVxYYjA2IsY6n+CDwi9EzM1lkOBCCvnuy7Hn8ARX6juxiH0
	wtKo068NDkJ3P3Ph0kHzpw9i1v9Z4T4t514lJV+Nw6h7sHWXk3qLSQ+5tUmYZsc05cm0ap
	1OJNDWjwXKRqRUbtHRGAe3Qx8GXNtk0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-LUENlRrgMQCP97pIICty5A-1; Tue, 19 Sep 2023 06:08:18 -0400
X-MC-Unique: LUENlRrgMQCP97pIICty5A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso126312566b.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695118097; x=1695722897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cERlGbZRXFnv/hzYhptX+YYYGk8PD0dNEVNa7S3t2J4=;
        b=YCkpbRvZUgynvN1nd8ZMO4PZovr6YxRwaJ4LC9cRCG9Vz//OcNX46NnqVxJxNXLDga
         isidwGVE/gEWmV6Ci8clXGboW0Kx6o/IvHhImKQ7hyeyca+JggknXNwQB6MH5tEZ/aGk
         aemH5MPnZGK+9jkULTvo0KNy2XHJXdlyjaWUr4uHzbqqUxb+5Kchm24HZw11w+12qiZW
         LSVG/9sMxq0d6xtvFRIBou4y7Ouu/UMgHx3xB4H3G04xQSPbajiCDU4a9sqBGNPT1BxW
         96fwOJeOOndKLb44TOLFzeCVxRd5IfjeJquB5/v6qTfWxNvEGSKm6hX1XzRBBqF8uqBl
         rP+w==
X-Gm-Message-State: AOJu0YxGItmyQ57lpOcRvrW497Zbj7aWml+NqHrpwj5fF6CXBSw9IBDW
	cDzNlLajj9JNmX5Fn1gzl49zDhF6/m/HfJB7qKGulYUp6p+7ZgpZs1AQwC4/xEMzY6HqQkQGJss
	W5C50cP2HTZ1Vfo5H
X-Received: by 2002:a17:906:51c7:b0:9a1:b4f9:b1db with SMTP id v7-20020a17090651c700b009a1b4f9b1dbmr9359953ejk.1.1695118097408;
        Tue, 19 Sep 2023 03:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdXfBEcepG3Pa/AnEdJYfdXJ/gaHg+SymSi6cUBIK8ct4MyWSoAmOzkjYyURyQCTqAJ5kxfQ==
X-Received: by 2002:a17:906:51c7:b0:9a1:b4f9:b1db with SMTP id v7-20020a17090651c700b009a1b4f9b1dbmr9359934ejk.1.1695118097049;
        Tue, 19 Sep 2023 03:08:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b0099cb0a7098dsm7733324ejc.19.2023.09.19.03.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 03:08:16 -0700 (PDT)
Message-ID: <ad8d1b2aaea245f2c21548b7ee485fbd8c57b0fb.camel@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: libwx: support hardware statistics
From: Paolo Abeni <pabeni@redhat.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, andrew@lunn.ch
Cc: mengyuanlou@net-swift.com
Date: Tue, 19 Sep 2023 12:08:15 +0200
In-Reply-To: <20230918072108.809020-2-jiawenwu@trustnetic.com>
References: <20230918072108.809020-1-jiawenwu@trustnetic.com>
	 <20230918072108.809020-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 15:21 +0800, Jiawen Wu wrote:
> +void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
> +{
> +	struct wx *wx =3D netdev_priv(netdev);
> +	char *p =3D (char *)data;
> +	int i;
> +
> +	switch (stringset) {
> +	case ETH_SS_TEST:
> +		memcpy(data, *wx_gstrings_test,
> +		       WX_TEST_LEN * ETH_GSTRING_LEN);

It looks like fortify source/clang is not happy about the above line
I'm not sure of the exact curprit as the warning output lacks a
specific indication.

In any case the above syntax is a bit confusing, '*wx_gstrings_test' vs
'wx_gstrings_test' and  WX_TEST_LEN not using ARRAY_SIZE.

Please clean-up the above and try to avoid the mentioned warning.

Cheers,

Paolo


