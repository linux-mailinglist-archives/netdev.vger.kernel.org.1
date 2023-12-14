Return-Path: <netdev+bounces-57645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB9813B3C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36931F2234F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1606A015;
	Thu, 14 Dec 2023 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=threespeedlogic-com.20230601.gappssmtp.com header.i=@threespeedlogic-com.20230601.gappssmtp.com header.b="oeuDLz4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920968B99
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=threespeedlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=threespeedlogic.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso7555100b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=threespeedlogic-com.20230601.gappssmtp.com; s=20230601; t=1702584443; x=1703189243; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/Y+Q0nov9zir8e4K6AmuAGHpEWYG8k6pX7YmsKWyGc=;
        b=oeuDLz4v1VISMuFIi+P0yyOXqpnab7FF4kxUG1H0JM204TF1Tt6Q0/8LE+/Q7YUgw2
         LNDwa8wDGVKKFNTKtKD/mVtu8aX7vaP0lDH5vDYTW25Rq2t531Vk/XF6iBo3Qcdm2SYU
         FXox53w93klV0/bcxW2l4tOd6Vw82PnxY78XXVI+o/Mzj3OAUD24Wq3KUA+t8krVIdNE
         0oIGF3OzoaRO/aAGGvuOa0Hy8f1TcnJCLHqqVy3sYhDmU0RqvGqRklRN1qIxanKDdk/y
         iZ+K1fQRuAX33cn6n8xncU1CSEIcEJpy1lZdUEQ9nfsAJgQFlvMCR0kZLRQVmrP98VtG
         OQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584443; x=1703189243;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d/Y+Q0nov9zir8e4K6AmuAGHpEWYG8k6pX7YmsKWyGc=;
        b=Mil2p7gdCntoQjbSADTdIAPOnetjFNNAZZQgZDj5hNgKPfgPQMfIJgzpBRhwSWcIYH
         sKKmND6AUczGprAeNBu5PhYmpPTmaTF8JsLx1s80lbdMGNZSEJRTTkmlZg0W0z6dQu5M
         FGQ1pjwxjhVs2E70t+XkbBIJVNkRo3BltwiJPLWaykhYBRGOaVNBt1wVdb+K0/bNSL9Q
         M3MNP5dzplH9mnt85FG7z1mJXGHshMke9n0TFlH4rtgUlWc2liDB+EHm1+/N2BYNlbC1
         4+aGpK9kERIyglPVU5u1Qosak5kZrz40YH31xX60b7UJV3+EgLehna/lBJtUrngBeoj4
         wGew==
X-Gm-Message-State: AOJu0YweG6/dpgfLDQ57hue3NM16FHMmDEZGftTbAsiGEuZ+Desgpigq
	phL/FNa5KGcs5+DbiDuayzyhUw==
X-Google-Smtp-Source: AGHT+IHlfBbHiX1mxafk1T/SJFyjAXHhNBi+Sg1CMpNGJMV+q+F+YHfAt3NAY/3pI8jvMWglO+G0QQ==
X-Received: by 2002:a05:6a20:1445:b0:18c:aa14:ad4 with SMTP id a5-20020a056a20144500b0018caa140ad4mr13390918pzi.30.1702584442704;
        Thu, 14 Dec 2023 12:07:22 -0800 (PST)
Received: from [192.168.0.164] (d172-218-135-26.bchsia.telus.net. [172.218.135.26])
        by smtp.gmail.com with ESMTPSA id r15-20020aa78b8f000000b006cdd82337bcsm12208496pfd.207.2023.12.14.12.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:07:22 -0800 (PST)
Message-ID: <f532722f-d1ea-d8fb-cf56-da55f3d2eb59@threespeedlogic.com>
Date: Thu, 14 Dec 2023 12:07:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: davem@davemloft.net, dsahern@kernel.org
Cc: netdev@vger.kernel.org, claudiu.beznea@tuxon.dev,
 nicolas.ferre@microchip.com, mdf@kernel.org
From: Graeme Smecher <gsmecher@threespeedlogic.com>
Subject: net: ipconfig: dev_set_mtu call is incompatible with a number of
 Ethernet drivers
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

In a number of ethernet drivers, the MTU can't be changed on a running device. Here's one example (from drivers/net/ethernet/cadence/macb_main.c):

static int macb_change_mtu(struct net_device *dev, int new_mtu)
{
	if (netif_running(dev))
		return -EBUSY;
		dev->mtu = new_mtu;
		return 0;
}

This code is present in a number of other drivers:

- drivers/net/ethernet/renesas/sh_eth.c
- drivers/net/ethernet/cadence/macb_main.c
- drivers/net/ethernet/ni/nixge.c
- drivers/net/ethernet/dlink/sundance.c

In all but nixge, the reasoning is straightforward: device buffers are allocated with a size that depends on MTU, so the device has to be brought down and these buffers re-allocated when the MTU changes. However, the ipconfig code is incompatible with this:

	/* Handle the case where we need non-standard MTU on the boot link (a network
	 * using jumbo frames, for instance).  If we can't set the mtu, don't error
	 * out, we'll try to muddle along.
	 */
	if (ic_dev_mtu != 0) {
		rtnl_lock();
		if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
			       ic_dev_mtu, err);
		rtnl_unlock();
	}

The device is not brought down prior to dev_set_mtu, so we always trigger an -EBUSY with these drivers. The boot log looks like this:

[    6.988410] Sending DHCP requests ., OK
[    8.016248] IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.217
[    8.023994] IP-Config: Complete:
[    8.027215]      device=eth0, hwaddr=46:b5:da:0d:99:20, ipaddr=192.168.1.217, mask=255.255.255.0, gw=255.255.255.255
[    8.037729]      host=192.168.1.217, domain=threespeedlogic.com, nis-domain=(none)
[    8.045288]      bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=, mtu=9000
[    8.045296]      nameserver0=192.168.1.1
[    8.057015] IP-Config: Unable to set interface mtu to 9000 (-16)

So - what to do? I can see three defensible arguments:

- The network drivers should allow MTU changes on-the-fly (many do), or
- The ipconfig code could bring the adapter down and up again, or
- This is out-of-scope, and I should be reconfiguring the interface in userspace anyways.

thanks,
Graeme

