Return-Path: <netdev+bounces-30298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F272786CD6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1412814D3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD546134CC;
	Thu, 24 Aug 2023 10:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CE156FF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 10:31:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C18199B
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692873069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpjf/YZm7tfcPZCca7L2sv1Wv8PZiaW/olle5+rMMQE=;
	b=XpVr2hWyoohuQc1Na3o9jd+9hf9exdi7gnvrubFyokNzLN3hYCKYmA1gUvzzFYtmmoHqoJ
	7BwVQBTGdhPrYIpxGCtDKhhdSp7I3W3Y5s4m0mI787wpKZcMyDE0nD+XTfo/dmNQdyVihr
	WMdTbaXi+H8URT/E9oln5G7w9fNt67c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-_EC4lqqYMcCzdFQRoRlu9Q-1; Thu, 24 Aug 2023 06:31:08 -0400
X-MC-Unique: _EC4lqqYMcCzdFQRoRlu9Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40179a353aeso908455e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873067; x=1693477867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gpjf/YZm7tfcPZCca7L2sv1Wv8PZiaW/olle5+rMMQE=;
        b=DscUgAiBNd0Ro/qseP2BdRy1H/xMKk0xpOwR6YdxLqQfGFwrjc5GYUsj8s/wLcJLwP
         eiRp2QGDiFMB8JBNgAoW9UNNMsa4u52l0s1li860lJr42GbKqu73ls1EZx3KjBwmh0Cn
         zHzjiivezlkFP61RwfnKqIctJ0Dg/yWhhesNkGZfaueEOXbURSqcE200urxgLIvKASrS
         h6zLPRac3AL5iEHAXNPhunehchen9KoiiSLm9AJiIWm5+Af/LpIJKnHI9p46bLRjM+r2
         ZlQoLQxJjU9tldKP6Zkw9Nz3Ssu7HnYfE6HrIlYjX56hZOivW/3snNWPkGHHCj4ezHv2
         e3jQ==
X-Gm-Message-State: AOJu0YwT6OpsFz4buBWg027mV5XoNHMZeK54IUiw7friHdhqQ8WBa04Q
	K3rESQjoFSP91ewLfnon0wuCoi80NIzOUrK/v7uOt4yiCkQyOckTvECUavoU0+3DzjKe3v5F2Rj
	0HZJ6ra9jnWKj7y7igI9YNZPI
X-Received: by 2002:a05:600c:5185:b0:3fe:d46a:ef4b with SMTP id fa5-20020a05600c518500b003fed46aef4bmr11818116wmb.1.1692873066833;
        Thu, 24 Aug 2023 03:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZtwK14eR28M+W3iJ2f6nXo7erBL0kYURufI72Y2JY32Cs5kl5Iq/OMSPYFBH31/x9KQNrUw==
X-Received: by 2002:a05:600c:5185:b0:3fe:d46a:ef4b with SMTP id fa5-20020a05600c518500b003fed46aef4bmr11818104wmb.1.1692873066484;
        Thu, 24 Aug 2023 03:31:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003fed78b03b4sm2233452wmi.20.2023.08.24.03.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:31:06 -0700 (PDT)
Message-ID: <c25141405ba52eb0eee96317407376ef68802198.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests: bonding: delete link1_1 in the
 cleanup path
From: Paolo Abeni <pabeni@redhat.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Date: Thu, 24 Aug 2023 12:31:04 +0200
In-Reply-To: <20230823032640.3609934-1-shaozhengchao@huawei.com>
References: <20230823032640.3609934-1-shaozhengchao@huawei.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-08-23 at 11:26 +0800, Zhengchao Shao wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So delete link1_1 in the cleanup path and
> drop any warning message.

I think the same could happen also for the link1_2 device.

It would probably be safer creating directly the devices in the target
namespaces, with the 'final' name

ip link add dev eth0 netns client type veth peer name eth0 netns server

Cheers,

Paolo


