Return-Path: <netdev+bounces-244445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A82ADCB7754
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 01:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7C1301D587
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2E21CFFA;
	Fri, 12 Dec 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="IIC7vyuK"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5457217F53
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499828; cv=none; b=o062R3SYYC2ZoPbo0ioW+HUlJeNAmdKv692le79DQgvVDwtUukr9pe/SkOsyqdCR4cAidnKUl7Dss4vHGXKCjXrSo77xgo+z6b4PmEv7IyeqOszYKmKV7JZs5n3Co/2TRsrHgsk+JFPOA2OVoMJYhBF+zvXAGyQ4Wn8acGpJNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499828; c=relaxed/simple;
	bh=PBPIvxJPyfAUKuzkEJ84KOdiVQNxNF7W9EysHCiFzck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM3yTtykISDHW7xLJ/8L6Bq7OxmbaWe7Qrw4cEIz7UGf7umCp6VcYBvsEyyi1n0tfKV8UgcVZ2+Fvtwx6EQ426qe1Ox8rOkL4uXw4jXc700nkL5kGJUZAqcJMKhoiKil3EE5sTwELt8oBjgtFKO3/WchuTiUziWDM/45OMwhpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=IIC7vyuK; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 5BC0b0JY766585;
	Fri, 12 Dec 2025 01:37:00 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 5BC0b0JY766585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1765499820;
	bh=jCakqoTJukG9WlRb8vCZiheesEQFmp5aknKdUs9Q2n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIC7vyuKI0N9EI9o+LlpJcVsBrEBHP4WHaPecM8IACHODbwtnKTfLA4JbUH54QCU8
	 5lJxg8GPJP8FUNGWd3OnWXih9JHB2ZRzf2zv6XnyVZE1p+ikcj18O+B5K/zUmtOmE5
	 2ze+9fSPmfi40h6C6XFaXGAPEfcN6jyYaWnz3vw0=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 5BC0axhi766584;
	Fri, 12 Dec 2025 01:36:59 +0100
Date: Fri, 12 Dec 2025 01:36:59 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] epic100: remove module version and switch to
 module_pci_driver
Message-ID: <20251212003659.GB766557@electric-eye.fr.zoreil.com>
References: <20251211074922.154268-1-enelsonmoore@gmail.com>
 <BY3PR18MB47070F7D806327202FEB4066A0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB47070F7D806327202FEB4066A0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
X-Organisation: Land of Sunshine Inc.

Sai Krishna Gajula <saikrishnag@marvell.com> :
[...]
> One downside is, users who previously relied on the printed epic100 version strings in dmesg, will no longer see them. 
It may be called a feature so that devs who previously relied on users hear
them again.

There is also a user noticeable change in ethtool_drvinfo.

User(s) of this hardware are probably able to cope anyway.

-- 
Ueimor

