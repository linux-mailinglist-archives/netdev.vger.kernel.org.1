Return-Path: <netdev+bounces-191563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A954DABC273
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFC317DB4A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E02857DB;
	Mon, 19 May 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luuD0GWt"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939E2857D5
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668590; cv=none; b=jNweVHNxuUN50l8AgO/4Z7+wlM2fnde28LojbL28cKulIgKajXvZItGj/0tq7dxItMiMp7RpTlJEnNnJERctKzueiyGBPGDar+mod+r+zwQXBaz3rA8auE31sxNBSUQwm3f2DUQTEWEVREW8h3InJONK4GSpBkHqtBxfpQuw8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668590; c=relaxed/simple;
	bh=dU0t219Hy+0YzyLO0ZatIatua6I558/Q69hN/3VqUe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utZjl2Fx+vppT7tXITiGhyLLLVnyDXIuUYqyM8fb25fLTaKMIBKdlPMGfbmtULQZNgbs1b7OIWyZVGrpDX32LQMOlF29nuMTDHDFDKyeQ2qPt9Idgt9yJ5jA5UbBVCFBxWugcfhwl33zjjd7KrU27KuKHxgAuriJaYAcB7Dihgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luuD0GWt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae1bb763-5461-4be1-983f-0155aab8ca6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747668576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xumGfFtSe+qcAudX3LPcfaE2MqABEtJR7l9tjfT+N60=;
	b=luuD0GWtPMk7VwhSXXSWr7/gnEPUxyEXBrnCKRmi5vCq6sZfj4NAeaoc5Qc3iLyLcXKYDF
	JQGtrwlfmovBTn4V5+gOJhj7sdAeZsxABHKJ4kafj6oaIO4rNwPqouGW9PxR+BHZY0IAXz
	hzwEEx+YjyiNoGPNl3K+68Cb9TF91Io=
Date: Mon, 19 May 2025 11:29:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 06/11] net: phy: Export some functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161013.731955-7-sean.anderson@linux.dev>
 <20250514195716.5ec9d927@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250514195716.5ec9d927@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/25 22:57, Jakub Kicinski wrote:
> On Mon, 12 May 2025 12:10:08 -0400 Sean Anderson wrote:
>> Export a few functions so they can be used outside the phy subsystem:
>> 
>> get_phy_c22_id is useful when probing MDIO devices which present a
>> phy-like interface despite not using the Linux ethernet phy subsystem.
>> 
>> mdio_device_bus_match is useful when creating MDIO devices manually
>> (e.g. on non-devicetree platforms).
>> 
>> At the moment the only (future) user of these functions selects PHYLIB,
>> so we do not need fallbacks for when CONFIG_PHYLIB=n.
> 
> This one does not apply cleanly.

Sorry, I forgot to rebase before sending this series.

--Sean

