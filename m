Return-Path: <netdev+bounces-161987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C9A24FDA
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2523A3B96
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6841FC0F0;
	Sun,  2 Feb 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4aPxxFqZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A01F9F62
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738525269; cv=none; b=sJc7e6g74UFWnMV1kx9EOO/IgVqYr8mK+qZ9lINzqmXj0LRojQSBReBzKgPzUQzowkueadsx/dyLNT86wgF54bmACdDkqH+dL4hNX6KUm2zPBVgVfIYIk2/GTsx4OCv8Auch6bUNJbHdcXb+Nt8aSu/7gq7feGXWmy3+UjHCGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738525269; c=relaxed/simple;
	bh=QpSmqWUXQanCQdsiF+shfYlCOZx8vISGIYu39jg+dJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG3R38A7hpkzU/8QZMJ+V4yxJxO9+YPiL6jvYbSUhwteFI3N/8RPYoTSbqenE7YUqjCMYV6IPR67LcpG3NEbLAzAK6hzO8qPDSElyOmg2nSw4bm6A6MyeapQ6cgMCjesHT5SPgBbryNfv9XwbFvzmi/TSr21THthU7x2TPg3Xw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4aPxxFqZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MBZAUuc9MGf3QdUDLnuUzJroJoNqzMXjOQM+2Ke73M4=; b=4aPxxFqZbNkbdqMKtdG8XglkBJ
	C8fqsyysWvu9oVxxxNvXN1xURnBvTyDXca1MqB2p8X9c6hWzRbQV119X9s3KpneZxclf5F1/cajxG
	7IEkUvBch1zzjlWwfMa3+QSyg9dHwYwDqYSwj6JpAA0s3LbtCJ2jz6D0DdF5nsWrao+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tefpx-00AKMz-U4; Sun, 02 Feb 2025 20:40:57 +0100
Date: Sun, 2 Feb 2025 20:40:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>,
	NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <bb6268d7-d467-40a8-8980-c707a20d6a45@lunn.ch>
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-9-danieller@nvidia.com>
 <20250127121258.63f79e53@kernel.org>
 <DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128140923.144412cf@kernel.org>
 <DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250129171728.1ad90a87@kernel.org>
 <DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250130082435.0a3a7922@kernel.org>
 <DM6PR12MB4516414BC58997DB247287CAD8EA2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4516414BC58997DB247287CAD8EA2@DM6PR12MB4516.namprd12.prod.outlook.com>

>         "module_temperature": 37.3477,
>         "module_voltage": 3.3406,

Device tree often puts the units in the property name. module_temperature_C, module_voltage_v,  

>         "laser_bias_current": {
>             "high_alarm_threshold": 13,
>             "low_alarm_threshold": 3,
>             "high_warning_threshold": 11,
>             "low_warning_threshold": 5

             "high_alarm_threshold_mA": 13,


>         },
>         "laser_output_power": {
>             "high_alarm_threshold": 3.1623,
>             "low_alarm_threshold": 0.1,
>             "high_warning_threshold": 1.9953,
>             "low_warning_threshold": 0.1585
>         },

             "high_alarm_threshold_W": 3.1623,


>         "module_temperature": {
>             "high_alarm_threshold": 75,
>             "low_alarm_threshold": -5,
>             "high_warning_threshold": 70,
>             "low_warning_threshold": 0
>         },

             "high_alarm_threshold_C": 75,

etc. This makes it more self contained.

	Andrew

