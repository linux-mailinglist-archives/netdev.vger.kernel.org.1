Return-Path: <netdev+bounces-257575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK2WJvYFhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:17:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C6BFF9DD
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C0243063A39
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94F281369;
	Fri,  6 Feb 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2FMg3MJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27627FD72
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390753; cv=none; b=mHIcWHWLeXfpqD2CimtcFy078a0w/RFX6rMcdYrQxlRQFyP8D9r2nsYul8+4gzGsKqtJ+ZfPEaSiiOoS34ujN4KKgx4Ke75kql8Lv0z4VmkrMlzcdtxRazbWX5zaYQ7MEcovOVG173e0N5HahHh1eVsXmcqtqOQSn4uoZ0+VY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390753; c=relaxed/simple;
	bh=exS9lpvMIPSui5dYPl8RRm6T2he8TXZfJaJDI9hyJHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhkzrw+2jt16+JJceu2huHDp1XKh888Nwr1IQoUJLSpCEiD2CH6Co7EvpKuOMaOfsrBoA41ZffAnmA63eHs0eM/KDnStmKAhJ8InDVzBohzdZI0aAibH325FSkIjTA0gj2EVTsdfTVHMTQP+4AOhnHpF4U+gm2P6l633PUlX87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2FMg3MJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362d4050c1so577765f8f.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770390752; x=1770995552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qv6VsOCxQoO4j1TGj8cncRGggXzBemd1h0aOThntp4=;
        b=r2FMg3MJZL1KVF/3nybmiXSppFRVmpLbp6Q9sjDcpoU3uu9W4VaUk2r9Zs0KIUjPLZ
         x6i9Lb1pd+e51w2RLHJZo6I3izNhPqolFkMNbzjuXKEVjZpK3+JOtinkx7SuuRWBfEzb
         JuiGceWDURv/TCVVcOpmwfvjQgqALAcpfdNBGeDpyxPrx6jZde9doTxHzd1DgwtMyLDZ
         iix1CaISfxJyVk/kvJC1HBxBoGD5gvjwnu954cqsPJrmQdLNQOLGjFvdNrjgMESrO4xD
         Y71kpbEx7be/hBcM5eQ63/k3EL0N1Ij5/p21xDg3pgXO/0DmkVGm3nyE5bPXOSYnyib6
         mo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390752; x=1770995552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qv6VsOCxQoO4j1TGj8cncRGggXzBemd1h0aOThntp4=;
        b=MyBU1rEb5DmaVh7Up+MgvYEolHz4HxuFVDSorvMQguH7KIA7BA+jfpFT02LpiKL3Wt
         jCIm60U8W4BNPMtxwnDB6si0jmp6ASFEIK1cRyQodNWExKekXBkvs78BhDA9VV5e6WPu
         3VOGeNDoAJlq/sqyBL21rDpX3d3OiIR5/G8mkL7IeO4oJRQpiQwjvKAb5io1mIyLFEaG
         9ML6xeSxdMSR7Qre92M8ateJko/0xA/mvM56ekKUSPzsbuoMXzfFNvdaQ71OwZ8GB4hG
         zULwix7ERmIaUkDv+MVX80GmNefOn1fxZH0rdjoxkD9OEziW7IxG/yOGIbEdrxBIT7gW
         Y+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT2P3u9tpdukTQ/yaJ+T9YzsrGuCxA4KuiPXY6kLD2/BnweCQX1iuQtO4m+P8VEgym+4XunO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLw+Fj4uD3ih/V8tc7FQBsJ7QU5XbXmr7cEf91/R4vriV2cIpc
	GYH5dlkC4mgoj7xJzEOFwZWsXmos1KvQK/DeRQxqXj6Og76eDe5MgQTxQW1FlLWhpIU=
X-Gm-Gg: AZuq6aK5fab46b2p0IXyjEh3wSfNjqd/j1oK3ORMjFDI2vO2hIWWWDWf8OqqX/wZ3RP
	oT3gCMibQ40Ro+oVmrWWEGJHONLGr3IzwWsjIdYwvjcQWf13C0FxtU/Hl55+y8oI60BDhJJTNvr
	B/oz8Dc6Rka6ZNbamDbGfAA1bQWGRO8p9YhJ116lTfDiO1yNw21yDLvbwV8FUMJWbWYxtgropbI
	hsaeYsxkPdJW1zPvCKmiCtHh9ZCSH7Uxet6umZJ8LSSJN3fsIQin3gdqmlTpUfY+Xrib/mVV4HR
	mE0eaq/tTkITIdKPnw3Zk5+lR0mtLCkb9MtlrmvUo7zllu8HtugBB+0EYeO0BH8VDxgs+P4t7/i
	76SgRCaiBRCORPoaAeOxjFP0TAOdmNPjLY0dtMTagIMHviINSMDTA2UNG8yQg0M3yECef15pQjy
	35T+1iMVhMHDHpP1CLuiCk8C0=
X-Received: by 2002:a05:6000:1844:b0:436:68e:3302 with SMTP id ffacd0b85a97d-4362933bd46mr4575279f8f.13.1770390751499;
        Fri, 06 Feb 2026 07:12:31 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff23:4441:1c2c:7aff:fe45:362e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2110sm6393053f8f.3.2026.02.06.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:12:30 -0800 (PST)
Date: Fri, 6 Feb 2026 16:12:17 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] net: wwan: Add Qualcomm BAM-DMUX WWAN network driver
Message-ID: <aYYE0SBR6V-HWcPr@linaro.org>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXu1uXRG1KHrKej@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYXu1uXRG1KHrKej@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6C6BFF9DD
X-Rspamd-Action: no action

Hi Dan,

On Fri, Feb 06, 2026 at 04:38:30PM +0300, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> Hello Stephan Gerhold,
> 
> Commit 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network
> driver") from Nov 27, 2021 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/wwan/qcom_bam_dmux.c:505 bam_dmux_cmd_data()
> 	error: buffer overflow 'dmux->netdevs' 8 <= 255 user_rl='0-255' uncapped
> 
> drivers/net/wwan/qcom_bam_dmux.c
>     500 static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
>     501 {
>     502         struct bam_dmux *dmux = skb_dma->dmux;
>     503         struct sk_buff *skb = skb_dma->skb;
>     504         struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
> --> 505         struct net_device *netdev = dmux->netdevs[hdr->ch];
>                                                           ^^^^^^^
> Smatch thinks skb->data is untrusted.  This is the rx path.
> 

Thanks a lot for the report!

I believe this is not a problem in practice, since there is an existing
check for this in bam_dmux_rx_callback() (which is the only function
that calls bam_dmux_cmd_data()):

	if (hdr->ch >= BAM_DMUX_NUM_CH) {
		dev_dbg(dmux->dev, "Unsupported channel: %u\n", hdr->ch);
		goto out;
	}

	switch (hdr->cmd) {
	case BAM_DMUX_CMD_DATA:
		bam_dmux_cmd_data(skb_dma);
		break;

Is that something Smatch should be able to detect?

Thanks,
Stephan

