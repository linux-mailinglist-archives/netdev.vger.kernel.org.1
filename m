Return-Path: <netdev+bounces-12819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA5739056
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7CB1C20F5F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036E1B910;
	Wed, 21 Jun 2023 19:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858111B908
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:44:51 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D021733
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:44:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-557224e7716so247750a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376690; x=1689968690;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asFgOSXPEXt2YbxEe5L8McfYdmAJwBR5t04QtXkXqXw=;
        b=Apw8Num2iRogCABfvOJdHsrxAIEq2rlS+DJHClqtBrKZPE2Ye+ht/B4+VosF5o5CPR
         qyz8mY5uUaAJF20IU/hO6ZpvRb6QiX6h9/tIWmkEO0BfVwJ+o5we4/LJ1VWn2OOzxvh/
         Dq+9nuy0d51lkIVTvxhOr6wltvir1ihkO8Nmu4a2B4lTa9L5VMM73quLyjrp/C0kUdqu
         PW05LhTElJ2xwJVy8YtCH2Twt2Sy3WEPisC6auClz9y0ZU2CqPayrgfVTWckQO6w7E1i
         W6X030oLwE5gbPXZ6aGtF7pHQaiYKZt2Vbcib/zF2I7qjv+12PycQWtAfSbi8CJbprfm
         xp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376690; x=1689968690;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asFgOSXPEXt2YbxEe5L8McfYdmAJwBR5t04QtXkXqXw=;
        b=VixTqTVRo2ZCP2JagUq8+HbS8NkHKG8a5l5U+VsUbgJuBumH6DNdfhLu5Seo8fpaDr
         vZlJzloxikH3AxELt7lOQ4RtcWZgprGoEHyoQgfqg70SxzfT4fH+/pCCg16wWLA6UlfE
         rt/zyyhfl7Nndnqbky2Epg6hlgrXdxqCP+aJFSMlZTX84ZBDkYRg8TsVR9AAl4aW+Ed/
         UjfUYrCBXn0rgn1e8iRfI6NZidpNyIFGLceT0O62I4A5QOv3TBPiIKbCMpe229puV3Wo
         uQVIMA41DPKQtrXqGP3J2KmpGQ8rm9z8i1jXNOB2cg9Kzx5TFZVTjW0dq4zhnOLzf4TJ
         eq2Q==
X-Gm-Message-State: AC+VfDwEet0FnzEvhPx8/f7PR1OzaLQ13T5FKPQ+OnuvKPXY9hgsar7J
	Zm37ht0E1eHdP5GYNu80IBsW9t29MCrR+NPCppYngZP0QAc=
X-Google-Smtp-Source: ACHHUZ4Dmbo5gQA1jToNrzlKTfXwj3knRMFrySEzwmSjjlUmAOnRCJfeJELAh1wUv+Z+SSRqxeN9y0dOHD2OM1dUOjU=
X-Received: by 2002:a17:90b:1c06:b0:25e:9ae8:4693 with SMTP id
 oc6-20020a17090b1c0600b0025e9ae84693mr19476940pjb.4.1687376689832; Wed, 21
 Jun 2023 12:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 21 Jun 2023 16:44:38 -0300
Message-ID: <CAOMZO5AdPZfQQEfSgW-Cgw2GySerc0oxUu4OEcQoxwVeB+wQWg@mail.gmail.com>
Subject: imx8mn with mv88e6320 fails to retrieve IP address
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On an imx8mn-based board with a mv88e6320 switch, an IP address can be
retrieved just fine in most of the cases.

However, when using an external Trendnet switch, it is not possible to
retrieve an IP address via DHCP. Using a static IP address works fine
though.

When DHCP works, ethtool reports:

# ethtool  eth1
Settings for eth1:
Supported ports: [ TP MII ]
Supported link modes:   10baseT/Half 10baseT/Full
                        100baseT/Half 100baseT/Full
                        1000baseT/Full
Supported pause frame use: Symmetric
Supports auto-negotiation: Yes
Supported FEC modes: Not reported
Advertised link modes:  10baseT/Half 10baseT/Full
                        100baseT/Half 100baseT/Full
                        1000baseT/Full
Advertised pause frame use: Symmetric
Advertised auto-negotiation: Yes
Advertised FEC modes: Not reported
Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                     100baseT/Half 100baseT/Full
                                     1000baseT/Full
Link partner advertised pause frame use: No
Link partner advertised auto-negotiation: Yes
Link partner advertised FEC modes: Not reported
Speed: 1000Mb/s
Duplex: Full
Auto-negotiation: on
master-slave cfg: preferred master
master-slave status: slave
Port: MII
PHYAD: 3
Transceiver: external
Supports Wake-on: d
Wake-on: d
Link detected: yes

When the Trendnet switch is used, DHCP fails and ethtool reports just
these lines differently:

        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Half 1000baseT/Full
        Link partner advertised pause frame use: Symmetric

Other PCs can retrieve IP addresses via DHCP through the Trendnet
switch correctly, but the imx8mn board fails.

Would you have any suggestions for debugging this problem?

Thanks,

Fabio Estevam

