Return-Path: <netdev+bounces-27348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A189977B8BD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AB91C20AEA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D80AD29;
	Mon, 14 Aug 2023 12:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5DA923
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:35:59 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82B9E52
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:35:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-5236a9788a7so5829380a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692016556; x=1692621356;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WHdD4JVrjI3O9NsXkqkN6Nlx+9LLcoHH1jbc5XRS6kU=;
        b=Tl7uJg+iP4XJcrrEfyHDjJ6Lf27tZkA1+lLL3Y5W3mBBlqfATeq8O/qx12iJwW+4MY
         /iDZVpl7LImb7yCKr2CktReSF2aHADaHvnnbgPsTXCuX8IlDJx1q2f2evYgHlKFXKxCc
         YY9Zn45uFyF7g5joRZIsDkoYtrYwIQg/3fbR3hwG+WlPZ4OWg1dHbzGZa6nIGJrOf2zY
         S6hVcymaqCGbpELphnfK4W6DWgazt67Z1L25R+TTfDc9lrw0rnkyaJ6Mlbs4NPlucn45
         DSdGcNo/iLE1Cd8x2g/+GrCWRR29rCiS5z4GtIV53oDRa9mbUMlMVsy+b4H6B+jO4wRD
         F7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016556; x=1692621356;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHdD4JVrjI3O9NsXkqkN6Nlx+9LLcoHH1jbc5XRS6kU=;
        b=gSKGk6ldYvtAEM+zEhi/fP4jTq5EJikj0WHMO/TzCI5ChxZGQeDV+MBxFVycQJT+rg
         AT+yKKdl+55XNU4z4uZVVzX0RMmh6C8hJRXG82i8XYSOhTkvChQ6M0xPmzjW8CQ5NYmE
         yjJQ4mn4PWEUGT1Z0bDW2XNVR7K+xOcw4iLtcYNdU8q9X4mOuZWOuaC5jK1QTS2jr9r+
         U0soSpL/lhK0ClJ+iFQ60DMffXmbIadnnI0FKnLv11Z4gHtpXdaAeMoepKl10o78GAG/
         9g6XxKtCD6o/15F+foqteGdQY8jDtoNlR4IrLAgUioJ01cv+JlKeWWdYwqM3lgvN7Q9V
         3oOg==
X-Gm-Message-State: AOJu0YzhA0awBT4GN83Xdmymjl+MoUB3iDk4kEyorLfnWRBamy5tm5dL
	Bk/nS5ybsvCHZwvKeoGpsTpYIhe+3EctvkDv9FBJxX94j8sOug==
X-Google-Smtp-Source: AGHT+IHxNzRBZ3R8uVtiVX0dz5qD/lFOGWGz8pbltJuE5Riv+GJXgnldYhhvvTPZ7o8A3d97dK9DQDoXcNM1dS0fUyQ=
X-Received: by 2002:aa7:d481:0:b0:523:b665:e48e with SMTP id
 b1-20020aa7d481000000b00523b665e48emr8265912edr.7.1692016556014; Mon, 14 Aug
 2023 05:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrzej Turko <andrzej.tadeusz.turko@gmail.com>
Date: Mon, 14 Aug 2023 14:35:44 +0200
Message-ID: <CAFTCNRex-NrtgcMQ+Cpw020QMy7erWB2EJU_t19eFCOA-QeBzA@mail.gmail.com>
Subject: Issue with adding classification rules RX flows using ethtool, igb
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I was trying to add classification rules for RX flows using ethtool,
but I got an invalid argument error.
This happened in two slightly different scenarios:

Dropping packets:

root@amwld-aturko1:~# ethtool -K enp1s0f1 ntuple on
root@amwld-aturko1:~# ethtool -N enp1s0f1 flow-type udp4 dst-port
34567 action -1
rmgr: Cannot insert RX class rule: Invalid argument

At the same time there was a following error message in dmesg:

igb 0000:01:00.1: ethtool -N: The specified action is invalid

As far as I could tell, this message is generated there:
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/intel/igb/igb_ethtool.c#L2916

The reason for it is that the target queue index is higher than the
number of queues (fsp->ring_cookie >= adapter->num_rx_queues).
The ring_cookie field is an unsigned int, so my guess is that the
check for the special semantics of -1 is missing and the value of the
action I specified (-1) is just being treated as a queue to forward
data to.
And because it is stored in an unsigned variable, it ends up being
interpreted as a non-existent queue.


Forwarding to a queue:

root@amwld-aturko1:~# ethtool -K enp1s0f1 ntuple on
root@amwld-aturko1:~# ethtool -N enp1s0f1 flow-type udp4 dst-port 34567 queue 0
rmgr: Cannot insert RX class rule: Invalid argument

In this case I didn't notice any error messages in dmesg.


For reference, my network device is I350 Gigabit Network Connection
1521 and was bound to the igb driver. I have used ethtool 6.4
downloaded from there:
https://mirrors.edge.kernel.org/pub/software/network/ethtool/
Also, those are the queues I had available:

root@amwld-aturko1:~# ethtool -l enp1s0f1
Channel parameters for enp1s0f1:
Pre-set maximums:
RX:             n/a
TX:             n/a
Other:          1
Combined:       8


Are those bugs in ethtool or could these be due to a misconfiguration?


Thanks,
Andrzej

