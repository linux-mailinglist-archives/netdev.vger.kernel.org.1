Return-Path: <netdev+bounces-27680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7977CD58
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E91C20CFF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB68125B4;
	Tue, 15 Aug 2023 13:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEE8832
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:34:39 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B7E109
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:34:37 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fe3194d21dso9326985e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692106476; x=1692711276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLeu7IXVB9GuSEApvEJZew8ULFnMzW+UHkUIvjcoK10=;
        b=ZNxvcoK6UjQ0UeOUymiwT+6cTE4TeFp/osMeypMdR4sef5+xfWjITW+749pboouCN1
         G4tfu1WCHPEWkpaXEPAszFtndvhLrwr9bCuGL7ufvw+bb9GFgqX76pSlL/vdmiHt5Y06
         nyOtKfzaMmGNQpUiSZXe4FjzUvlSslqIA3MgfXa0+e9bX5VHusdE42kkQd/Rc4j/MmXR
         t3XzCpWQzBjoK/zY6c2yu5rCBJFq8sXVDLLdY54QVb4MfEyWK8sBAPpEa8VW6POX7iZX
         vaXbqviH/pQIFiIG4kSjwCENALH01RY9udGriERIbJip5bJL3ePmyOURava7v6eVq7Df
         74lw==
X-Gm-Message-State: AOJu0Yyf3ogdfgO9PZ5gy9+72lsX6PBt660+9/Kp0P72hMMe+eObNXrd
	Xtc5tjW5KxfgVlDhSOLUqQo=
X-Google-Smtp-Source: AGHT+IELEQqgddEUQOFSj2CbYrqz9r4riJqQkHL6Uy4ACdg6juPicR5XwbIdVqZNe6JNO0g0Yr+dCQ==
X-Received: by 2002:a05:600c:2258:b0:3f9:88d:9518 with SMTP id a24-20020a05600c225800b003f9088d9518mr11612100wmm.0.1692106475785;
        Tue, 15 Aug 2023 06:34:35 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b00317ddccb0d1sm17878409wrt.24.2023.08.15.06.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 06:34:34 -0700 (PDT)
Message-ID: <6a0e9122-87f3-b0e9-0a54-dbcc4cd9d819@grimberg.me>
Date: Tue, 15 Aug 2023 16:34:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
 <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
 <fdb8caf7-78cc-c39b-3dda-2d9db4128a34@suse.de>
 <ce3453f8-807b-301c-f18a-3d7a7bc0bca7@grimberg.me>
 <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> How are you testing it btw?
> 
> As outlined in the patchset description.
> I've a target configuration running over the loopback interface.
> 
> Will expand to have two VMs talking to each other; however, that
> needs more fiddling with the PSK deployment.

Was referring to the timeout part. Would maybe make sense to
run a very short timeouts to see that is behaving...

