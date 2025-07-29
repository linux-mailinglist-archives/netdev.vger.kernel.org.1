Return-Path: <netdev+bounces-210901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EACB155D9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059933B7D8D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8D285404;
	Tue, 29 Jul 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nchip.com header.i=@nchip.com header.b="EUw5SDhD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nchip.com (mail.nchip.com [142.54.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555771E5207
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.54.180.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831118; cv=none; b=c2Twd+8bhzhkysGU1OUX7rJl7v+9ZlzzoiuchBuHpDSartSpY/a1kW6ZFIejLw8M/sJKOl1uDU20zdk+w0GDtCudEQXAM7V6mbZFkVxAgkEEHX/+Bj/AgoHpl6xCQcklA3Vv/sNI/6YFf8i7eT9SyvqXRkq5BWfU+R8wgTeuHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831118; c=relaxed/simple;
	bh=mr5bMEjA0Z9HFBn8afVtfRRKdZPSJHwxQMbmUkOadaw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CThOzEgzNJ4z6zySDrf/RAElTZK6mcyGsODbAkiFv3A2Ak4aFhUj4ryTkkqEuOLjxfaH9esROcWTCybVDhISv1IpYBTxQBTCsrO2RMFNn73UKyOnLv/Lf1rdS3kX7lptkd09gCp6uSBcvWLsUx8c7PXTjKF8xRQ2vX4DaUUPGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nchip.com; spf=pass smtp.mailfrom=nchip.com; dkim=pass (2048-bit key) header.d=nchip.com header.i=@nchip.com header.b=EUw5SDhD; arc=none smtp.client-ip=142.54.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nchip.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7EACFA00E7
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nchip.com; s=dkim;
	t=1753831115; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=XuwV2UD5TAECPTtBwD/5ZdOMlloQ6AbKYBmwG5fD59c=;
	b=EUw5SDhDP/sK4saSrGjJlPZj/LW0TqCbwrQTg5i7OrxeMCV2aHldK0TFBQEUHokW1FezYi
	D6Yru9RzXzd15CwiCpipY+LW6OKtlDNQlgThqs73cfQ4NLK8YbezCdrvsa22jbnVKH6J+f
	vOH7ODeApHuW6Nxva+OuhNpgcqsAHw1i37fsIIc3POxWWkDAE1TZ180gXGRWZtI39Jco+T
	QZXl/btpd7vL9C2/M93UMa166V1lX8hWKYQj+kQ9uKkIg8VNf5K0Fmwci+A0MafhpTu9rZ
	i4BDQej+RYaSJQ296m3dQxecETM8YV4EiUrCyJe7ELakUa6q8i4I5/yfFOLTtg==
Message-ID: <ce1dba69-b759-485c-bc3b-5558306735bc@nchip.com>
Date: Tue, 29 Jul 2025 19:18:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: _ <j9@nchip.com>
Subject: NETDEV WATCHDOG + transmit queue timed out
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

When I try to use network interface end0 on kernel version 6.14 for 
Rockchip RK3588 SoC, I get this in dmesg:

"rk_gmac-dwmac fe1c0000.ethernet end0: NETDEV WATCHDOG: CPU: 1: transmit 
queue 1 timed out 5408 ms"

dmesg:
rk_gmac-dwmac fe1c0000.ethernet end0: Link is Up - 10Mbps/Half - flow 
control off
rk_gmac-dwmac fe1c0000.ethernet end0: NETDEV WATCHDOG: CPU: 2: transmit 
queue 1 timed out 5388 ms
rk_gmac-dwmac fe1c0000.ethernet end0: Reset adapter.
rk_gmac-dwmac fe1c0000.ethernet end0: Timeout accessing MAC_VLAN_Tag_Filter
rk_gmac-dwmac fe1c0000.ethernet end0: failed to kill vid 0081/0
rk_gmac-dwmac fe1c0000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
rk_gmac-dwmac fe1c0000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-1
rk_gmac-dwmac fe1c0000.ethernet end0: PHY [stmmac-0:01] driver [RTL8211F 
Gigabit Ethernet] (irq=POLL)
dwmac4: Master AXI performs any burst length
rk_gmac-dwmac fe1c0000.ethernet end0: No Safety Features support found
rk_gmac-dwmac fe1c0000.ethernet end0: IEEE 1588-2008 Advanced Timestamp 
supported
rk_gmac-dwmac fe1c0000.ethernet end0: registered PTP clock
rk_gmac-dwmac fe1c0000.ethernet end0: configuring for phy/rgmii link mode
8021q: adding VLAN 0 to HW filter on device end0
rk_gmac-dwmac fe1c0000.ethernet end0: Link is Up - 10Mbps/Half - flow 
control off


phy controller: realtek rtl8211f
soc: RK3588

Did anyone have this kind of issues?



