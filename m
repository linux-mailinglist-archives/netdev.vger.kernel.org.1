Return-Path: <netdev+bounces-100276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F58D8619
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC3281F1C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A32130A53;
	Mon,  3 Jun 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e8OycE3u"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5113113212F
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428776; cv=none; b=TJdJKbZ9cRnc6JF49wqXXNd6rZRt0d4XS5hDvo8D0J8syLRUnGl+K2L/IpOydyZwnVsKYT8L2sIviBbC9EPgqWvtSlszIMY3aTpIACXCL3rUkdC1gK7jdZK7Ep3gq3rQ6v/sVmgJGIj4yjg37VK5o8PKDh2u9KsM4vuisMyTA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428776; c=relaxed/simple;
	bh=OAwTePRedi3gdRIXf7Cp5PRiOAp31n90wFv4SHEoLBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Jy6Rw9fMAaw6KFrFXTDJB0zQy1/6N9eejV+xyFDKuS2y6C+wX/GkPcDadRHprNtxptZ/Q/02pzyLSQOsxJEFF1Ddm9FcMkMTZAOWl7265IWwwCaEt2MS4bMX8/0SUDC3XpUfZEfP8svVAm97bh8OT9i7VUIoaddaBthOXCHeidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e8OycE3u; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=6QRNhJ/5iKbZMDRUG/
	tdhRNGdotsBC+WL3FP2F6jJbs=; b=e8OycE3umnvFclXrjWsCZ1AksxSMlH+nH/
	NADdP7FiTergfOOruS/ZDtT1+d3eNy4xJANbm1EGcPXjEWqMuMwwUH/ZKXYvmz6A
	GJpT/zy8rexfElIgB9ZoBDJ5A24EHnug0mxQ2UZk+otsd1NFqUAcoCycAmik6z40
	I+wyDcvL4=
Received: from yang-Virtual-Machine.mshome.net (unknown [223.148.145.250])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDnVz7_4V1mm8_yCQ--.29546S2;
	Mon, 03 Jun 2024 23:32:17 +0800 (CST)
From: yangfeng <yangfeng59949@163.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn
Subject: Re: Re: [PATCH] net: phy: rtl8211f add ethtool set wol function
Date: Mon,  3 Jun 2024 23:32:15 +0800
Message-Id: <20240603153215.6628-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <098c355c-a7b7-4570-988f-56e7d54989f3@lunn.ch>
References: <098c355c-a7b7-4570-988f-56e7d54989f3@lunn.ch>
X-CM-TRANSID:_____wDnVz7_4V1mm8_yCQ--.29546S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4fCry8Zry7KFWDGrykKrg_yoW3GrcEkF
	1DJrs29w42vrs3Ga95GFyfuw4293y7tws5Xr9xX34ay3Wava92kFZ7Gw1fury3uw1IkF9r
	Cws8G3y09wn8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUXTmUUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiVgrxeGV4IoOLEgADsz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The RTL8211F series can monitor the network for a link change event, 
a Wake-Up Frame, or a Magic  Packet, and notify the system via the INTB/PMEB (Power Management Event; ‘B’ means low active) pin  
when such a packet or event occurs. The system can then be restored to a normal state to process incoming  jobs. 
The INTB/PMEB pin needs to be connected with a 4.7k ohm resistor and pulled up to 3.3V. 
When  the Wake-Up Frame or a Magic Packet is sent to the PHY, the INTB/PMEB pin will be set low to notify  the system to wake up. 


For example,
 1.Set MAC Address Page 0x0d8c, Reg16~Reg18 
 2.Set Max packet length Page 0xd8a, Reg17 = 0x9fff
 3.WOL event select and enable Page 0x0d8a Reg16 =  0x1000 //enable Magic Packet Event

Kind regards，
Yang Feng


