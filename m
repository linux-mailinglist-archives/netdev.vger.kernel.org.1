Return-Path: <netdev+bounces-253503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jQM+GTR8d2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:37:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7E8997A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB043192619
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108C22DFB8;
	Mon, 26 Jan 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TH15sgCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7D2367D3
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437855; cv=none; b=InhA4TU3jOpQQHYk/KecPwP7TEVMqDy9TL5Z65a0LzMz24k4t7N3E/bCcCrjVhTmSsdFdodZRQzRCgkDwVjDnZOROxGv2YJxT5esyJdZesYVtrbm0qNT2xUvd9XJ1Jgu+MCZRHP3saWOOSOMNMoYbL0PH+Tbezej4wBYr8rxps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437855; c=relaxed/simple;
	bh=9lal1y80TjMOe8e6CtuzMYFHogezVJkhDM/qVH78O5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLlqOatpFieY4h0VcjnSinHs2KsNVvCM4ouZ5tt34O6ROjX9PEp5bHIweZWhCxhSiNsS0r4PBmLac4Vr9VSuWyTpLwLQD6YqTEub0x/dn77+AzikD60/FNymQIH6PZZoJd42lxpGmGArVijs4WH3M7aWhDEZFomNwNKipPdfxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TH15sgCZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E8348C21A84;
	Mon, 26 Jan 2026 14:30:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 421ED60717;
	Mon, 26 Jan 2026 14:30:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92C9F119A8409;
	Mon, 26 Jan 2026 15:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769437850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oGOu1acFDzY7QezPEMddKtt+4qHQKgIX3FItFAcKfnA=;
	b=TH15sgCZQxpMf/AH4JvqA7zD/LuRor3i0kubsJ0vJ+fZWgRKy9ik7e6CWkl1WUkH/bd9qQ
	QJZ2rHka3KFn01ypP9gaS+2DrUO+SDhIbewvJhtZdNwpp5AJ7d+KAU0vGKtcesiF3KF7XL
	To4+2zUkvEteMBvNmjVbUDc3SI7WFpar3cq/lngtamICLthirY3e6FmQHARriA2qYW96CH
	TMNLehSjtNmcE3GKaTgtJ//E3/U8kmM0i+t3UpnIAz8u8/7u0TRxCapsfGr0QPm927WWRH
	TqfYJaeYyvyHvV0ndzxvHgv55KMgEGSftYL5VD5ZkfhkpHAbTLbsZaPC3szeGw==
Message-ID: <d8d29c67-59ba-4f5c-beab-f93d61e93aed@bootlin.com>
Date: Mon, 26 Jan 2026 15:30:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/8] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
To: kernel test robot <lkp@intel.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
References: <20260126-ksz8463-ptp-v3-4-9f092aeb8492@bootlin.com>
 <202601262210.Ncec5HWm-lkp@intel.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <202601262210.Ncec5HWm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253503-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: BEA7E8997A
X-Rspamd-Action: no action

Hi all,

On 1/26/26 3:17 PM, kernel test robot wrote:
> Hi Bastien,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 3adff276e751051e77be4df8d29eab1cf0856fbf]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Curutchet-Schneider-Electric/net-dsa-microchip-Add-support-for-KSZ8463-global-irq/20260126-163430
> base:   3adff276e751051e77be4df8d29eab1cf0856fbf
> patch link:    https://lore.kernel.org/r/20260126-ksz8463-ptp-v3-4-9f092aeb8492%40bootlin.com
> patch subject: [PATCH net-next v3 4/8] net: dsa: microchip: Add support for KSZ8463's PTP interrupts
> config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260126/202601262210.Ncec5HWm-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601262210.Ncec5HWm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601262210.Ncec5HWm-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/net/dsa/microchip/ksz_ptp.c: In function 'ksz8463_ptp_irq_setup':
>>> drivers/net/dsa/microchip/ksz_ptp.c:1171:35: warning: unused variable 'ops' [-Wunused-variable]
>      1171 |         const struct ksz_dev_ops *ops = dev->dev_ops;
>           |                                   ^~~
> 
> 
Sorry about the noise on this one, I should have spotted it.

I'll respin again.


Best regards,
Bastien

