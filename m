Return-Path: <netdev+bounces-234486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B3C217F5
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED7D04E23D3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F030369984;
	Thu, 30 Oct 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iptGO4bv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3222D0C73
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845417; cv=none; b=DwaRyn0ABe5oqr2eBCm3JBYaWPPYcmhKkOa56288vrk34iAbuHLx6v2LDyZyEbEm0V+UdKKG82WLYRqsKg4iTgu/GjYGnS0MwFpKeIYK2xZT9fnd+J8RhRV/iqTQ7bKBMtXlvdMpSeUBuhv038l4t2lG9QhNCymEnNsdTfN6msY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845417; c=relaxed/simple;
	bh=+QGXLARjxrKSlzhv+YEhH/3qatJWbDVYNNvDfi4CsC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7RtXbfKXLd1u49fIgKdfjYSIMNwJefUqtUKjBMApIpIBK1/UKByebh+GrzBoqBJGA3YbRG9TUToYdg4GJJqnzBHiXNFBLn7dtEvUvyYYXlhIQQCenOJGDeICnoAZNWQBvUBbfOSRObX4g2FNWvKRZP+/QValmBdWIfSjiZml7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iptGO4bv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 86F58C0DABA;
	Thu, 30 Oct 2025 17:29:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0031B60331;
	Thu, 30 Oct 2025 17:30:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97854118090BB;
	Thu, 30 Oct 2025 18:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761845413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1i92LoqCY+FtT4LaGDqOwEYxMdjowaojPaKNbxcfnMM=;
	b=iptGO4bvDF0TNaDMkG/yGZ7AakadD3FezH/KSvU2TTtf3YCE4UL2XVLLrFbooBED65Jlel
	5aMDTs3DKRKStjzt9dIucWelR/PyNlLyNR7U+8zEq5xKfar9xqtm0/BnGWQnHRQiR/2dMP
	JtxYZvst50SlzPon2JF9vF+Tq9OHWRUV3RyeJccvgztEfbfOoZeYJPGEmiaj8sxQVMiQw+
	8LBO2OJADrLKaavA7NAlQHWG3Rm9doV/b497Hm0Kr5K9rZKk42WwkmXNgtvDa3pGaOYAPS
	yRm13zRysvPk/rlR4nD9LhEssWgmy+qXF+Ew11rdU4tAVQmG+jNKRop/yvDAIA==
Message-ID: <036e360b-9e9d-48b5-bc91-c35beb660319@bootlin.com>
Date: Thu, 30 Oct 2025 18:30:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 2/5] amd-xgbe: introduce support
 ethtool selftest
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 30/10/2025 10:13, Raju Rangoju wrote:
> Add support for ethtool selftest for MAC loopback. This includes the
> sanity check and helps in finding the misconfiguration of HW. Uses the
> existing selftest infrastructure to create test packets.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

[...]

> +static int xgbe_test_loopback_validate(struct sk_buff *skb,
> +				       struct net_device *ndev,
> +				       struct packet_type *pt,
> +				       struct net_device *orig_ndev)
> +{
> +	struct net_test_priv *tdata = pt->af_packet_priv;
> +	const unsigned char *dst = tdata->packet->dst;
> +	const unsigned char *src = tdata->packet->src;
> +	struct netsfhdr *hdr;
> +	struct ethhdr *eh;
> +	struct iphdr *ih;
> +	struct tcphdr *th;
> +	struct udphdr *uh;

Reverse xmas tree :(

With that fixed,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


