Return-Path: <netdev+bounces-33045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750AE79C851
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3679B2816B8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A217727;
	Tue, 12 Sep 2023 07:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CF15495
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:38:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12144E78
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694504305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s1aJql/A0JZTouVheT4leQVEfWFD9NDj47wdNMmY04=;
	b=fE2WjAw4rLzZwnYkiAJzbPdYu1d7wtnOqCs4AVLURflQJWv5hHMniwBofBP/5BtSei5tgb
	7UC+FAxomYO7quhxYaW9xgj1DVOI+G0DOo9eaVE796NVwMf05s0LSoqNHf7IzETMg/DF6Q
	hUyWeRj9fqrZHy+ttHFMNeM0GZRajB0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-xsC1PtdNNequnU9EdqhJpg-1; Tue, 12 Sep 2023 03:38:23 -0400
X-MC-Unique: xsC1PtdNNequnU9EdqhJpg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-502b134fd49so667207e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504302; x=1695109102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5s1aJql/A0JZTouVheT4leQVEfWFD9NDj47wdNMmY04=;
        b=vJhs/HFlmJRPl9zpH7XDpnUNrZORqA8EkqCvaRKfRPea8iYZtUj2WqtFTXWfvn9JRt
         KGqKYgYgTjylQua8jYgf9fqLA5/EegMlZSWuBsJq5gzW1d1U7SPm8TuTghOhAiccb+WA
         M9srcBciHK473gDffQ0eUGyPRV7WRhofeWhrRVr+REaV6GH8kJecHNraUSdt+t3KNRQH
         JkN3cQgxAG+BvmE7QqtVeYLFpksfaF6kLQMoMRXzV5Apt4Kcnr13Bf/C9TzDwbEe1iQd
         djrOJk6rj5ueK7EhsqAhTECUG4RhklNMlnanuOvCMT3FCEix3aFZG1d3dQ1iayiLfixb
         o7CA==
X-Gm-Message-State: AOJu0YzioV/l6XuCZFh66sSG6u+iZiIu268fW3VKQVqivx6wliKChjPy
	N06FhNcUE4oSAvcj065qGtXgCP/I564MRUa3uaLWb1BWk0TEBQnwRJ2MytsWmeS97Z14vZGsyD2
	J7RJpMHeV8mTuWhzrp7J5rZkd
X-Received: by 2002:a2e:bc08:0:b0:2bd:28:f56f with SMTP id b8-20020a2ebc08000000b002bd0028f56fmr11651184ljf.3.1694504301857;
        Tue, 12 Sep 2023 00:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzzMQDO6h05Sc1RJwCrRniDCxu5H3YiFPQgz1vjH6UXbtaKkLSHCCbEkfyjCI7S+gCygwrKw==
X-Received: by 2002:a2e:bc08:0:b0:2bd:28:f56f with SMTP id b8-20020a2ebc08000000b002bd0028f56fmr11651167ljf.3.1694504301554;
        Tue, 12 Sep 2023 00:38:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906044a00b0099d0a8ccb5fsm6455234eja.152.2023.09.12.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:38:21 -0700 (PDT)
Message-ID: <5eefb04c2e9028337ade88b50de3f8db3ffc5185.camel@redhat.com>
Subject: Re: [PATCH net v2 3/5] net: microchip: sparx5: Fix possible memory
 leak in vcap_api_encode_rule_test()
From: Paolo Abeni <pabeni@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, lars.povlsen@microchip.com, 
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,  netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Tue, 12 Sep 2023 09:38:19 +0200
In-Reply-To: <20230909080207.1174597-4-ruanjinjie@huawei.com>
References: <20230909080207.1174597-1-ruanjinjie@huawei.com>
	 <20230909080207.1174597-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-09-09 at 16:02 +0800, Jinjie Ruan wrote:
> Inject fault while probing kunit-example-test.ko, the duprule which
> is allocated in vcap_dup_rule() and the export which is allocated in

Small typo above: 'export' should be 'eport' or 'vcap enabled port'.=20
Please fix that, as it makes the changelog a bit confusing.

Thanks!

Paolo


