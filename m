Return-Path: <netdev+bounces-243234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF43C9C033
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 687CE3490C3
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64669324B2C;
	Tue,  2 Dec 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="uOdzu5AQ"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED13168FB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690463; cv=none; b=OeA7G0j6qQYTqe0d8lGl+vYB259TfNCcz3LkYpDLzWSmyLpSwx6C+VzzszHnLd16YLAUr8OJ9qnFVegqV1dVdLXEA1LhQNV64PHnlGsprdlngk8/vt1JqMTIEmYAyBJEgi6diHAb2ElqYKN0lcDsQrIUxrfVKtDyJr5Rrdla1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690463; c=relaxed/simple;
	bh=qkwjFnrK5hLRNxCLPcLy6ihRaGeDx6SD0+LCXlVVuRM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cQTjdDKsR2F5UGkJxj0CEVpCzJUuJWeGcJp6nexW2qC1H9MA5Zh67JuyWoRxLdP6ed4rY161GOqmNuS/Gr/xFheoVu4X3ctEP82lne/TEiIR9e2247bcPc0OVLA0hDwkNknwrJBKpltXqDcdp5lKQnOAuQHqO+e3BYbWR3BTbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=uOdzu5AQ; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yttXHC44416RR3sDrPk2p2RoPtu+dtQDyd/+QMi5iKY=; b=uOdzu5AQc0gEWg35YXjD1rFbLb
	CTFVZx9rm6pfLyWc0//luF0ZeAeu0gETtzBNOU+PXqF7H9l3nHc7FhkE2alG0gLYuSjzHiHJrZr/e
	knNnv1z7WIXCQpv0Gc/s+aeYRy7ilVzWCtoxjIeBQD/Xon1rtVDZRrwgQTWBh9Xu8SblZGZ2QhN8t
	GvudewnVBn8+jLN+YshMo2L0OAoGM5+a2eD+Zn3BzbtRt6pFlnZ8FlbYunT+esJVYIhjKMHhCTW9c
	G7hnBCgVPg8m+nvNihWG48KsdLNO/95OYV3AKAIWlRz6klkDVK/Hx1hjKB3tS3Pjygw50bcIAMfCO
	+hGVBZ1A==;
Date: Tue, 02 Dec 2025 16:47:38 +0100 (CET)
Message-Id: <20251202.164738.1343792086968703812.rene@exactco.de>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <f14f1078-311e-47ff-ad5f-01d2fd9ea40d@lunn.ch>
References: <20251201.201706.660956838646693149.rene@exactco.de>
	<f14f1078-311e-47ff-ad5f-01d2fd9ea40d@lunn.ch>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 2 Dec 2025 16:41:49 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> > While at it, enable wake on magic packet by default, like most other
> > Linux drivers do.
> 
> Please give examples, because i think that is false.
> 
> You should have the option to enable any WoL mode the hardware
> supports, but none should be enabled by default.

All my other 42 computer systems in the company come up with WoL g
enabled. Here is an Intel example:

root@7950x:/srv/upstream/linux# ethtool -i eth0
driver: igc
version: 6.17.9-t2
firmware-version: 1068:8754
expansion-rom-version:
bus-info: 0000:0c:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool  eth0 | grep wake -i
        Supports Wake-on: pumbg
        Wake-on: g

You could git grep the linux kernel for more data.

> > There is still another issue that should be fixed: the dirver init
> > kills the OOB BMC connection until if up, too. We also should probaly
> > not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
> > should always be accessible. IMHO even on module unload.
> 
> Is there any way to know there is a BMC connected?

In general that is what this dash mode in the driver is about.

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

