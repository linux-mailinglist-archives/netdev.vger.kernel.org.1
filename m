Return-Path: <netdev+bounces-14983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B7744CC4
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BD1C20912
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE41369;
	Sun,  2 Jul 2023 08:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26F363
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 08:37:40 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56B183
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 01:37:38 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b056276889so2950633fac.2
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688287058; x=1690879058;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBqkgh+WXCK8tTDQ5hw0IqBPuXWXJKtGsBS4MwKDaUk=;
        b=maxUI7fySsS8PGfn0O+KDYLZLTIzeo7CZ91zLPBWYb2T+phOtrjvBS6Oq2Kq7XlBwB
         zWXfYSwkwqFV0LJbnVdGZD82IOnIH3AkTECB104eJMTrtCmSyb85JgBtTE3aI7UdiEC3
         K3IjJmv487P/T3luxyS45dmQwqal1D4MjS5UwsYThNDyHQGWNMifHYqzoKHw2CU2Di57
         AcRrtN9OtNzft6pYFmHbvYv3c2YISAoGT829U7T9ETK/mx811/lCQ31T1YDGMEAg59OZ
         HZuTatgOlJ68mhqZqCmFjAIb0GCdnpwFPG3v/fyeAksJXTIeJsHeKKtycBowGVtwG113
         vpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688287058; x=1690879058;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBqkgh+WXCK8tTDQ5hw0IqBPuXWXJKtGsBS4MwKDaUk=;
        b=UvIDsRELs6WQZAGQsRvSApQ65oNI4Ot/hnBAjaW12LC/6fiT1Rqn2XTburta3gdrbF
         pJM2iMowT1bZuG5abCDvHB1k2x1f+otPsWP0GthlIRAlUOPxQJ2cN//17kw4iEJXqf57
         z/XjWm12akJZG/tbrLTFDCBzcRWPjO830l30FzZWpr1s8YhtGqCCO7uqZDn8vwt6cZVC
         MjSYg5vlkTpJJIpnzwEQ0622QLeL+78HL0Kj6ebkFgikZ7Vrd2UEZJAA+T8fbBGiWTB1
         fZ8dAk1bj27yWfIkzTkhl6KRVC1yHvgLAj3Ed1HcGJBWcagkvYuZsOZ1drB8w9k3xtL0
         Xfjw==
X-Gm-Message-State: AC+VfDz/3YPAS1/d/POnSVgTVkpM57+MesSWCYUqje5SKkr28rdax7iH
	R3zo+QT1V21r4nrYiQE3ThI0GtLzz2CWBsEFpob9OW8gwpXJdg==
X-Google-Smtp-Source: ACHHUZ4/EfpdWF7SIg7PyR/fC6Raw0U4d8DuvOyKOZb1cNdO5a6tGTYctcj7yT/TZJA/fVcd9f8fJjsU9OZU9jNhN9A=
X-Received: by 2002:a4a:414d:0:b0:563:5ef9:59d6 with SMTP id
 x74-20020a4a414d000000b005635ef959d6mr5601226ooa.8.1688287057877; Sun, 02 Jul
 2023 01:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abhiram V <abhi.raa.man.v@gmail.com>
Date: Sun, 2 Jul 2023 14:07:28 +0530
Message-ID: <CAHaZnwP-KHYkVnWjsa_8cXq+-EJH1dWGMKwSkvu6GAU5MhgJnA@mail.gmail.com>
Subject: Custom Kernel Module for PRP (https://github.com/ramv33/prp) -
 problem with removal of RCT using skb_trim
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

I am implementing the Parallel Redundancy Protocol (PRP, IEC standard
62439-3) as a kernel module for a project of mine. The code for the
module can be found at: https://github.com/ramv33/prp. I have used the
code for the HSR module which implements PRP, as a reference for my
implementation since I have no prior experience with kernel
programming. Even though a lot of the design is different, I have used
the module as a reference for how to implement PRP. I asked on the
kernelnewbies mailing list and was told to come here for help.

The module is nearly complete. The problem I have is on reception,
specifically with the removal of the RCT. The receive handler is
registered on device creation using netdev_rx_handler_register and
netdev_upper_dev_link.
The receive handler  when it detects that the RCT is well-formed
(correct PRP_Suffix, LSDU_size, LAN_ID for the NIC through which it
was received), tries to strip the RCT before calling netif_rx() on the
skb to forward it to the upper layers for processing.
To strip the RCT, I call skb_trim as follows (as given in the HSR module):

             skb_trim(skb, skb->len - PRP_RCTLEN /* 6 */);

I have used skb_dump both before and after the call to skb_trim and
verified that the length is being reduced and that the tailroom is
increased by 6 bytes. The problem is that when I call skb_trim, the
packet is not received by the upper layers. Without calling skb_trim,
the packet is received correctly but the RCT is consumed by the
applications which should not be the case.

I used wireshark to inspect the frames at both the sender and the
receiver side on the two physical devices and observed the following:

1. At the receiver side - The IP payload length is different for the
same frame received through LAN_A and LAN_B. The one received through
LAN_B has a payload length 6 greater  than that for LAN_A (6 is the
size of the RCT). On checking the ip_rcv_core function, invalid IP
payload length is one reason that the packet can be dropped.

2. At the sender side - The entire packet is the same minus the RCT's
LAN_ID field for a frame-pair. The IP payload length is correct when I
capture outgoing frames on the two physical devices.
As mentioned at the top, the code is available at:
https://github.com/ramv33/prp. Here is a brief overview of the code:

1. The transmission is defined in prp_tx.c in prp_send_skb which is
called by prp_dev_xmit function defined in prp_dev.c

2. The code that sets up the two slave devices to forward frames
received to the virtual interface is defined in prp_dev.c in the
function prp_port_setup(). It is called by prp_add_ports(), which is
called by prp_dev_finalize() from the RTNL newlink.

3. The receive handler that is defined in prp_rx.c, the function is
prp_recv_frame(). It checks if the frame has a valid RCT, duplicates
discards, and then strips the RCT by calling strip_rct before calling
prp_net_if() which removes the Ethernet header and calls netif_rx()

Hope you can help me find a solution to the removal of the RCT. Point
out any mistakes that I am making. Thank you in advance :)

Abhiram

