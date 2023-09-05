Return-Path: <netdev+bounces-32043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CE2792209
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6AE28111D
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B172CA47;
	Tue,  5 Sep 2023 11:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FE211C
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:02:28 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA91AE
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 04:02:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso35891421fa.0
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693911744; x=1694516544; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6OvtKSlFCRZS8hBjN04jSFnPDTZpSmr++4fpHiFrcs=;
        b=iQ2LlMEjcbiGM7b5R5tgzKcN4rhcuNpeB4As3lBszwA0Q13Ksc06KN6GYcmQeaaZ2f
         JYs+O1fmw24Xs2pp7/FssbcmsZNH6SczWRa2GQiFSl0nUhiwki87HzWlxjo0ALrf+2xT
         WE66K9x2ALWne9UciHF7R4xs4FsljQHK2QW+aq2zHNLlKZ02pvNSFT6RGijShUDxWJSh
         cJ9z9tDzkc8cDnbmRTg6QqNZcLewJTSlgBIPz5G9v7WgV0KQy2jhzHvdSVbGr8IBdukv
         O7E+RVhBiknFzFSMZk6Nx0bzqSOCKpnqOoCvv/RGluMSqJvZpw5sA9wbrIT7mLTHG+An
         cTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693911744; x=1694516544;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6OvtKSlFCRZS8hBjN04jSFnPDTZpSmr++4fpHiFrcs=;
        b=O8ySd9vtPeh8VwasQDT6RO6DOIafUk8rV/JYp8l/y4l6HpZN2eFO+PPhKsGdY5xhzy
         ksqyj1DJH7JgB56DAmiQbWLBcCvPzfZ4qHUyYeDIgvq6fn3OQKeBa8Td7YpmB1buuOjc
         QaIDLWW1AdVsOE+5vWIJhiBgTI2x+CZiaJIrI6yGX9x5D2j2LJeA1fMzf6oM5rFegOPv
         LTJJd/0eesMkK5jNueLYtMpa0AsNanpG1+whshP327PeetNidRDHGFZtoR3GEjSamSlr
         dCcArTbvCO3CPYLvr8kQlSmD41yt3ydwXqPhQIJnIzT4jxVmvHE2VxyybHeAC2t/U7G6
         XiTg==
X-Gm-Message-State: AOJu0YzB2yV9jwUNp09LrICz8x4Xokt4VApKMpyr2gq9OWhllG6qvfon
	QWgLG7SQBSvob8RpyF6dL1qBaHNus3w=
X-Google-Smtp-Source: AGHT+IGKHHOgN50XT8x1qQR4qyaJqIH+La24xByU9I5utsDtfP3Ax6srGiX2qpqan4ZCf67788XNOA==
X-Received: by 2002:a2e:6e13:0:b0:2bc:c4af:36b9 with SMTP id j19-20020a2e6e13000000b002bcc4af36b9mr8896562ljc.52.1693911744156;
        Tue, 05 Sep 2023 04:02:24 -0700 (PDT)
Received: from [10.200.8.38] ([137.204.150.17])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c229600b003fefb94ccc9sm16437172wmf.11.2023.09.05.04.02.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 04:02:23 -0700 (PDT)
Message-ID: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
Date: Tue, 5 Sep 2023 13:02:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Regression with AX88179A: can't manually set MAC address anymore
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, reporting here as the issue I am seeing is cross distro and relevant 
to recent kernels. Hope this is appropriate.

I have a USB hub with AX88179A ethernet. I was able to use it regularly, 
until something changed in recent kernels to have this interface 
supported by the cdc_ncm driver. After this change it is not possible 
anymore to work with a manually set MAC address.

More details:

- before the kernel changes, the interface was supported by a dedicated 
kernel driver. The driver had glitches but was more or less working. The 
main issue was that after some usage the driver stopped working. Could 
fix these glitches with the driver at 
https://github.com/nothingstopsme/AX88179_178A_Linux_Driver

- after the kernel changes, loading the ax88179_178a.ko does not create 
a network device anymore. The interface can be used with the cdc_ncm 
driver, however it is not possible anymore to use a manually set MAC 
address.

When you manually set a MAC this appears to be accepted (e.g. ip link 
reports it correctly), but the card does not receive data anymore. For 
instance, trying to connect to a DHCP server, you see that the server 
receives the request, makes an offer, but the offer is never received by 
the network card.

This may be the same issue reported here: 
https://discussion.fedoraproject.org/t/ax88179-178a-network-fails-to-start-usb-to-eth/77687 
where the user says he cannot use the adapter when Network Manager is 
configured to employ a randomized MAC address.

Would be great to have this regression fixed or at least to have the 
command setting the MAC address erroring out properly.

Thanks for the attention.

Sergio Callegari


