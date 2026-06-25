Return-Path: <netdev+bounces-301883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BI65FbvaPGp5tQgAu9opvQ
	(envelope-from <netdev+bounces-301883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:37:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB486C365D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:37:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=G+Lrnyun;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301883-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301883-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22AAB302A6AE
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9882037AA97;
	Thu, 25 Jun 2026 07:37:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEF40D595
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373022; cv=none; b=uwCEUUCHykeRobxFLHbjO7UZjmCrRWKdLHy+ZUBpc3j9cTI0hwhhHEJXzv03Og8KjwUC65DNRupWncZVwfPb6YP/hjWxlsGZxV+nnL3bCRCpQDMa1NpSjFTcBqtZcTcOhuVeTZPa6ESFFpvuL+wYDhuRu69GRTTrac1TwFP9+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373022; c=relaxed/simple;
	bh=K+xei74GjQBfLgo9TrmbCdxyVBk3k9EcuNOxbDd+f78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTsDzanqPmpH4wVsiTFjT5HcmljYOmLQAhulRs/y+ovoA/j+sZuii//YpBFhYxxSu8u3khZMNsQXrBT8oL3uwIanxJSnVooh9f2NdPsLfGTccMGBgDGHWPS0/kBMr1XGswiSEMT7Jm6lawOoldjGOa+aeotFnGdVMOK6wSfnH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G+Lrnyun; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0977A1A08FC;
	Thu, 25 Jun 2026 07:36:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D08315FF03;
	Thu, 25 Jun 2026 07:36:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9019106C8442;
	Thu, 25 Jun 2026 09:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782373018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CQKNNE+ysP6hZ4N3+rq7u/CP8moMd0AcqYlMGT2Ifxs=;
	b=G+LrnyunLLl7KMAc8zgTIEX3UeqNUnJuWBNHjsDyj/b5sTzk7kReVzHgrm929nNwTLVZpq
	c8FzpuAVBG253rVzwbUiQeVvG4Xcd5008C6h6/tUie2kRIcXYEp7NhN+jcu2pxb5DN55lV
	V2NaJt8GsuTvOdFcpRohyXObzsV3AS3m545DhOBMxXaZxacHI22tDI48wYSGcaX4eGdQjT
	C/VpvXT1BRK2F+rf2vOSJyKBn0Aw2gzmVRBV2xAA6+xdTe8sNvvjSsISOKcDVcwBYjQUxF
	WRMS7k8cj50Fy6EVhRcuWRjk9PSusrrxuNzgz+KrGl7sHrHAHAHowJBd7RtNiA==
Message-ID: <d24cd9a3-7825-4739-a5e7-8d3a8345451e@bootlin.com>
Date: Thu, 25 Jun 2026 09:36:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pch_gbe: return errors from MIIM accesses
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301883-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EB486C365D



On 6/25/26 05:05, Pengpeng Hou wrote:
> pch_gbe_mac_ctrl_miim() polls for the MIIM controller to become ready,
> but returns zero on the initial ready timeout and ignores the completion
> timeout after issuing the operation. MDIO and PHY helpers can then report
> success with zero or stale data.
> 
> Make the MIIM helper return an errno and pass read data through an output
> parameter. Propagate the error through the MDIO read path, the probe-time
> PHY discovery path, and the internal PHY register helpers that already
> return an error status.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  .../net/ethernet/oki-semi/pch_gbe/pch_gbe.h   |  4 +-
>  .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 54 ++++++++++++++-----
>  .../ethernet/oki-semi/pch_gbe/pch_gbe_phy.c   | 22 +++++---
>  3 files changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
> index 108f312bc542..4bdf0afca462 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
> @@ -619,6 +619,6 @@ void pch_gbe_set_ethtool_ops(struct net_device *netdev);
>  
>  /* pch_gbe_mac.c */
>  s32 pch_gbe_mac_force_mac_fc(struct pch_gbe_hw *hw);
> -u16 pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
> -			  u16 data);
> +int pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
> +			  u16 data, u16 *read_data);

You should look and replicate what other mdio accessors do, that is return a
negative value on error, and the actual value otherwise.

Maxime

