Return-Path: <netdev+bounces-33047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B579C862
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CDC1C20A75
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7717729;
	Tue, 12 Sep 2023 07:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559415495
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:41:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F237B9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694504480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pzk/gs6nFtPw3RplH4nmuBhznG8c5ya8srmTPu7k4N4=;
	b=d4AYn1JthmouMXmP8tji1Vo0sSZBUi816Linzwg1Lda8VnfY0r7SVDyM7kj60HTvwS4NLu
	M+dIGjSYT4ngicB3HzB9RNmDt0XXrRnU26caLRMaLWa0UmvR1CGPFxAQXH947w/vV6p5FX
	K+TUtZ7sRR1ii17ZFcV9jYb8ny5HA38=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-G58qa9RdPcOBCZGTGCNqbw-1; Tue, 12 Sep 2023 03:41:18 -0400
X-MC-Unique: G58qa9RdPcOBCZGTGCNqbw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-502b134fd49so667922e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504477; x=1695109277;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pzk/gs6nFtPw3RplH4nmuBhznG8c5ya8srmTPu7k4N4=;
        b=WplpgRDkPl6OPd1/C6b79dEsu5hrJJACTtKr9OpfTfsha0osVAAAEFXbhN42XvIF06
         hGiH1GL54aPdPp/mwX4vY7Jv1gvUImkf1WJvPFjxi/Ww/HeT7bWclO/h72u6CMFtJ1sf
         +4ECixIcBf5waQ4y6y+bpmX5Jj8zOW50FvnNNesdjqST70R0kgIkNrOQbD2dE/RK3vHN
         JU/Z3XgJzqydxwyFsINapjc874dk6bYUkvDCUKIvqhN4YfdxWyWqMaon7mzYLvDjppkh
         0PIhnsvhNX20lXNGlr/svsiJOiCwUl47+6wdWjfVCQlrt/WlGz0ft0ne8xiIJyBuZR8z
         hyNg==
X-Gm-Message-State: AOJu0Ywqba1Tmi94rBP2VUN4SFGXszPzTufT8tYrEtIJ9ut7jbjYHFOt
	BgrwxCglJljhelTEM5/eQd6OGmzCCE36cXYnNUUscgw4mpp2E42byy42MnhaRal8hzz1Ry3lJkj
	/IRQJxXzsluMo+esX
X-Received: by 2002:a19:a408:0:b0:4fe:5838:3dbf with SMTP id q8-20020a19a408000000b004fe58383dbfmr8224588lfc.1.1694504477507;
        Tue, 12 Sep 2023 00:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXUPn50MU8f82TDjKFpDKlXHGriMZ9o/UC6OcEtsTLUj7Nxu/+WOYleLMhquwq5l8PW/1Z2Q==
X-Received: by 2002:a19:a408:0:b0:4fe:5838:3dbf with SMTP id q8-20020a19a408000000b004fe58383dbfmr8224568lfc.1.1694504477181;
        Tue, 12 Sep 2023 00:41:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id cf4-20020a170907158400b009ad88839665sm545831ejc.70.2023.09.12.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:41:16 -0700 (PDT)
Message-ID: <253e481e308f73cf9ae3b55b62bc00412047c02b.camel@redhat.com>
Subject: Re: [PATCH net v2 4/5] net: microchip: sparx5: Fix possible memory
 leaks in test_vcap_xn_rule_creator()
From: Paolo Abeni <pabeni@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, lars.povlsen@microchip.com, 
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,  netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Tue, 12 Sep 2023 09:41:15 +0200
In-Reply-To: <20230909080207.1174597-5-ruanjinjie@huawei.com>
References: <20230909080207.1174597-1-ruanjinjie@huawei.com>
	 <20230909080207.1174597-5-ruanjinjie@huawei.com>
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
> is allocated by kzalloc in vcap_dup_rule(),=C2=A0

Small typo above, I think it should be 'vcap_alloc_rule' instead of
'vcap_dup_rule'. I think it's relevant, otherwise looking only at the
changelog, the next patch would be a not-needed/duplicated of this one.

Please fix the above, thanks!

Paolo


