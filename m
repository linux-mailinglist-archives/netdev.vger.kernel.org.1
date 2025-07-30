Return-Path: <netdev+bounces-210988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D2B16071
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5863A3BA1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814742980B0;
	Wed, 30 Jul 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nchip.com header.i=@nchip.com header.b="ZM3wmNNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nchip.com (mail.nchip.com [142.54.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CC42A82
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.54.180.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878991; cv=none; b=oBHr2OmNlC0Q8XzNo9DPYsPE7LwoHsnHq/K8Bsu9nXRHGlSMuu6DX5WseVr5k9lw/+wTsLaqGX2sDjc2XVv1QlQUzJYa+vGFzJ+s5Nlt+/ok6OzJm3HApMH/Pv13NFAly8Kb045Pz7udz1oNUjgbpkePYVY5aGP99IjgL88UOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878991; c=relaxed/simple;
	bh=0J7NR2rPchDw2WfBKLjZFM1+e9LbnRrg+HT9OhV0Fec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BpP6336qAK75vLkqzjICH67uKNwwq5v6Jo1AT8kUJZHPx9QST8AZPxSR9T5RiJooeJGVEUWBCVAXvAFoQrEWddB+PrI7agtgwoMvvgv1iEfBfG71N2+LflYVchVJHgS0Zwx76rmC833czuNh4SsKIfRUDIytfwSNryZSLKQhI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nchip.com; spf=pass smtp.mailfrom=nchip.com; dkim=pass (2048-bit key) header.d=nchip.com header.i=@nchip.com header.b=ZM3wmNNi; arc=none smtp.client-ip=142.54.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nchip.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCDB2FA00E0
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nchip.com; s=dkim;
	t=1753878988; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZsjlD/iu8zq4HeB5ZQoQIPdLVzS2Vamc05DT7rIfgCI=;
	b=ZM3wmNNiivXFc1CWdiCfPZZq2kNotWqSlcLNMDNhC0lJ835Z7OmA79iWk8lS3DYMOWtEeG
	6ubqrjxR03Mh8cB8vciaS99vsk+YBVSqUp+VtOzMJ/jXKiUHzI6rhWlxNW1ovzKFsLpGDg
	ObAE892eUF2CD1rNggDJhn58/IWC2N5XvwIp+8mqnnXo0QfmcQ876EPFCRZhRbkoVA2LdM
	R+m36keYfu+M7XukeGbdBPIjyRRbiYcZHHPCoesWcG5ybKUc1b7uRAR5SrwKJbkDChmIEa
	e6yW4/nmsizqMGdbjPofAQvtfTAkPM5GXTbaK3+cHv+y3lmVgl8TJwEaR/gE7w==
Message-ID: <b0bd1e38-f9a0-48d7-9e5f-fb47e4734b25@nchip.com>
Date: Wed, 30 Jul 2025 08:36:25 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: no printk output in dmesg
From: _ <j9@nchip.com>
To: netdev@vger.kernel.org
References: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>
Content-Language: en-US
In-Reply-To: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Is this the right place to ask this question ?


On 7/29/25 19:26, _ wrote:
> Hi
> 
> In "stmmac_main.c", in function "stmmac_dvr_probe", after probing is 
> done and "ret = register_netdev(ndev);" is successfully executed I try this
> 
> netdev_info(priv->dev, "%s:%d", __func__, __LINE__);
> netdev_alert(priv->dev, "%s:%d", __func__, __LINE__);
> printk(KERN_ALERT "%s : %d", __func__, __LINE__);
> 
> But in kernel buffer there is no messages from these 3 function calls
> 
> Any suggestions how to make printing work and why these are skipped ?
> 


