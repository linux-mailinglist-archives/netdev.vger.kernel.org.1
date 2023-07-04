Return-Path: <netdev+bounces-15455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB9747A8D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 01:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209981C20A89
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 23:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9D8BF9;
	Tue,  4 Jul 2023 23:54:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754C8BF3
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 23:54:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7346B1B6
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688514861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PORwtyRFGlG4lvPZI8qM6TQsPqsUfbHMoOVfE2D1XLI=;
	b=W7TWEHf1FgBXwx+m2ziG39ABk7FQHxxNKl2TFsLhqe1EKV/kM+LzWeXjaTfnPBui4wLmqz
	9WCsggVEXmOfl4QqvBIpv1spM3aDzrqqxK3oQPzyasVo/Ca6areOugBm+Eq3iS/RdewQDJ
	CL/IP8dGlEhMyP2NCx2/FdMgfmt/6aU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-j5UYF0qeP6GuV5lVep_3UA-1; Tue, 04 Jul 2023 19:54:20 -0400
X-MC-Unique: j5UYF0qeP6GuV5lVep_3UA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso3508135f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 16:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688514859; x=1691106859;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PORwtyRFGlG4lvPZI8qM6TQsPqsUfbHMoOVfE2D1XLI=;
        b=l0wMrwh1Ha7PXWQTZQDaoMoldS2RF+KHiwl9rUdBx7X0HbHMdKOEWzZ3m7FBpCj2nL
         mohQlQclZ9k12KYh9KI0q3To3FlqJuTIvsBUsWlxBqkfI4ArzQdP4wsXf/vrOVhMX+nN
         8cRvEoaj+jF2YoL020F0msJrYgrBTSx0r0OBq7HHqpAsYcZOOFQVtr2F0kMxJwLpik2j
         tyBOG1yuWQyX/vdGGBEGaJ1kJiXffsU1wrkcbtnOLF66y+LSvf6TvNqspV5efhYsWvdW
         Ar49ibUOSby4Ko+ZF7CRIWTOqOfasvn6s6/iNWxHlv9vSHSgGhSdLH+e6mh04gXlr9rA
         e5hw==
X-Gm-Message-State: AC+VfDyVcK8IzbPbIFgHAZXDtgGHQPXUPwkvh4buX7M+TwvfTGaXWP9q
	WKlm5+fOArd2L4gkAl7nVowi7thPZnHyGYZLMHUkrDH+atV++rKA4ieERLCuwLQCXDzkV4guRAP
	3SDGoMyT7/cgYU6YE
X-Received: by 2002:a05:600c:3787:b0:3fa:8c67:fc43 with SMTP id o7-20020a05600c378700b003fa8c67fc43mr12744032wmr.32.1688514859029;
        Tue, 04 Jul 2023 16:54:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tq90DzBUFgJTJaEJ4Ac9MVzBo9lw3N89KMFWnG6tpF5auyzg3GBH2U3SFnJuMDfeVAFVYtw==
X-Received: by 2002:a05:600c:3787:b0:3fa:8c67:fc43 with SMTP id o7-20020a05600c378700b003fa8c67fc43mr12744017wmr.32.1688514858642;
        Tue, 04 Jul 2023 16:54:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm457745wmi.23.2023.07.04.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:54:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 45C8BBC118E; Wed,  5 Jul 2023 01:54:17 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>, wei.fang@nxp.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: fec: dynamically set the
 NETDEV_XDP_ACT_NDO_XMIT feature of XDP
In-Reply-To: <5b1182d5-a147-4bfd-9ac8-b33462e97b10@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-2-wei.fang@nxp.com>
 <5b1182d5-a147-4bfd-9ac8-b33462e97b10@lunn.ch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jul 2023 01:54:17 +0200
Message-ID: <87mt0bb5cm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Jul 04, 2023 at 04:29:14PM +0800, wei.fang@nxp.com wrote:
>> From: Wei Fang <wei.fang@nxp.com>
>> 
>> When a XDP program is installed or uninstalled, fec_restart() will
>> be invoked to reset MAC and buffer descriptor rings. It's reasonable
>> not to transmit any packet during the process of reset. However, the
>> NETDEV_XDP_ACT_NDO_XMIT bit of xdp_features is enabled by default,
>> that is to say, it's possible that the fec_enet_xdp_xmit() will be
>> invoked even if the process of reset is not finished. In this case,
>> the redirected XDP frames might be dropped and available transmit BDs
>> may be incorrectly deemed insufficient. So this patch disable the
>> NETDEV_XDP_ACT_NDO_XMIT feature by default and dynamically configure
>> this feature when the bpf program is installed or uninstalled.
>
> I don't know much about XDP, so please excuse what might be a stupid
> question.
>
> Is this a generic issue? Should this
> xdp_features_clear_redirect_target(dev) /
> xdp_features_set_redirect_target(dev, false) be done in the core?

No, because not all drivers require an XDP program to be attached to
support being a redirect target (which is one of the reasons we
introduced these feature bits in the first place :)).

-Toke


