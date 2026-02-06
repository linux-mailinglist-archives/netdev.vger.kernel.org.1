Return-Path: <netdev+bounces-257579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HYXD4YHhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:23:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203FFFB2C
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32419301412B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D113ECBF3;
	Fri,  6 Feb 2026 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/uXAkMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC926ED41
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391427; cv=none; b=BBe47VvfRaWaUJxkZa4toHBs5QiWzZ9jLbEad95WJriWoqiAWjq3hDexewyfUaGkIEAt2wiSwZCWEAqyJuGb2jOZPlklL7JbeVsnGx+3+uZtHZRNmibmmYFtfXYJgrizeVystMIh0xcwpy6RnPobc4wOfT54UfjZBtUieutyOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391427; c=relaxed/simple;
	bh=+O1Ls5mJN2w86ohgl0FWaLhpMAN9yWArFMvJtTQfTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHZi+bg3VkhIZgxOiyEFYHIy3BLbD/71u2ZtgYzPoBpnaJDHxLhQ8u1S/djyuAKw1y2BNgmu9RQQoB/BfUob8yen1qiq5Kz+iUf2p7cuHn5xzz5OvbHEGG2v4gmsrHcwmCBuWO79k7bG/f3bI7zJhPbPu4GxUU63Oyq7fen93Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/uXAkMD; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso24279845e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770391425; x=1770996225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmk3i2Xic+N6h+88mYHjXnA3IoHoaC3fj4TmXWw7rGg=;
        b=K/uXAkMDWvGQxodUUir939WxLkYqVCxvkC6umuDuKPQ+bl/LrMa2xTRS1g6wpO5zSe
         FubY9ilhu3RR3GIfEql69EVwOmXbdN2OBTEb1C7o8NQ6P8bwMP4U/PnmTYRHix/Hpb7u
         6lzE3KZtcPQNtId6S3uuJ4FqV4YG8ueqltz0stLJRSbi9yDRLq0v4H01SwDTerxTzXeA
         dQrKivfRuOxhNeU3pxDWMbpV/zkO3nu6FtwgPAzcRJZFvF9ZfgM+kmiKR8g8wVPhU1mR
         XLKpNnOBu1LsthkmCoiQxd9VJ8XIAUQ6XnLXvlswQ8R+DP6aJTeomLsiqZ8W7JXLSlVp
         ETTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770391425; x=1770996225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmk3i2Xic+N6h+88mYHjXnA3IoHoaC3fj4TmXWw7rGg=;
        b=MUFn6A+CXa8fvSsBhHp/kGMjgEe7YKv7aEPwwOpPH4attBgTguqAsjxq7C23lBXC4M
         f4Ws8N0mg1ECfLAkx4ibtdBUx5CXjJ7no87vP/Y0iYLPI9Fj2+xEvva/RESHl8Q7F4nq
         LdVmL0rAdeeQIKBlYmm1fhag3Lncl2th1Za+f3XxhmbZbS9lYETZrjgJZrN9FGZNb9NH
         THoitICqNlPOUQ8gNy3KGje8TPLvVkfeus9c2cM/7bh0gD8NKrcRhZFG1sDNBa4uEy35
         Gf6B9OjMs9vYhaXEPq+J6EEwBt0kHdhKFunaMhJJubKCNyMwqKef5S5OBh4GDR+k7y7f
         O+2A==
X-Forwarded-Encrypted: i=1; AJvYcCWIZX8wPLWPmZb0EF228uABxT3Tfr5T/+NzmMLwyA/mbdj9OrYsSEbZCSxBfsbI0gXhkOlSUuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIurLcs8rnZCuXoiHLrD4klA3HJxY+w5OcAGyOWaqZF5altq9
	bB7TsaHuBzWXfQmFGXw2TCYEgWREJ9V/pny5upl/4u5nlcDiyOGYmfIujM76WLfVx3M=
X-Gm-Gg: AZuq6aJkCOHIXQAeSJracJXCIJpphFeqe/TawbQHIZa2yU+PtwC1qFZaKM9MDGb5gJy
	u71r2kTiwF+Y6eTjiYfxu0ex6Bc/5h0rvOX60GKYN4v1o9T0Sg+Zvb9FErly1f04gjvZNm7HRYC
	KOg6RaicKAB8h8yNY/NAekZH1GEZJTxX5/B/gp81kHlFiRsPY4bOCIY3KzbgzmZ6ladprf6hi2T
	8FK58RTEshjjgQDOwXhX3PTYgHIhAc0f6e8w96VGknuku7XIoeGf6SgvhGNfkZ+1Lk0ELh1J0L8
	A9LI80kRg5XyrrU7ADkOFM4YQNdjW6NxMn8j2kSUJm81ynZa3vyZjsaA9BXF5ez5v1ulWv5VMtb
	tSDwFiSdHezLqIxDN820/Gb7ufteVdMB2nrzL1VX2ZJkVuJVyOZvpqc52B4G+IhFdEV0vEnR7Y5
	8QOPJMLKA5YV6wFdy5khmdFbSRd34=
X-Received: by 2002:a05:600c:3b87:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-48320966a0cmr42152645e9.18.1770391425272;
        Fri, 06 Feb 2026 07:23:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm202077135e9.10.2026.02.06.07.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:23:44 -0800 (PST)
Date: Fri, 6 Feb 2026 18:23:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] net: wwan: Add Qualcomm BAM-DMUX WWAN network driver
Message-ID: <aYYHfapZdjGYCGLI@stanley.mountain>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXu1uXRG1KHrKej@stanley.mountain>
 <aYYE0SBR6V-HWcPr@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYYE0SBR6V-HWcPr@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257579-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 9203FFFB2C
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 04:12:17PM +0100, Stephan Gerhold wrote:
> Hi Dan,
> 
> On Fri, Feb 06, 2026 at 04:38:30PM +0300, Dan Carpenter wrote:
> > [ Smatch checking is paused while we raise funding.  #SadFace
> >   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> > 
> > Hello Stephan Gerhold,
> > 
> > Commit 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network
> > driver") from Nov 27, 2021 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/net/wwan/qcom_bam_dmux.c:505 bam_dmux_cmd_data()
> > 	error: buffer overflow 'dmux->netdevs' 8 <= 255 user_rl='0-255' uncapped
> > 
> > drivers/net/wwan/qcom_bam_dmux.c
> >     500 static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
> >     501 {
> >     502         struct bam_dmux *dmux = skb_dma->dmux;
> >     503         struct sk_buff *skb = skb_dma->skb;
> >     504         struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
> > --> 505         struct net_device *netdev = dmux->netdevs[hdr->ch];
> >                                                           ^^^^^^^
> > Smatch thinks skb->data is untrusted.  This is the rx path.
> > 
> 
> Thanks a lot for the report!
> 
> I believe this is not a problem in practice, since there is an existing
> check for this in bam_dmux_rx_callback() (which is the only function
> that calls bam_dmux_cmd_data()):
> 
> 	if (hdr->ch >= BAM_DMUX_NUM_CH) {
> 		dev_dbg(dmux->dev, "Unsupported channel: %u\n", hdr->ch);
> 		goto out;
> 	}
> 
> 	switch (hdr->cmd) {
> 	case BAM_DMUX_CMD_DATA:
> 		bam_dmux_cmd_data(skb_dma);
> 		break;
> 
> Is that something Smatch should be able to detect?
> 

Ah, you are right.  Thanks.

The problem is that skb->data is a buffer of u8 data.  Smatch does cross
function analysis, but it treats a buffer like that as opaque data.

Btw, I see that this code is actually from five years ago so I don't know
why it's showing up as a warning now.  :/  Sorry about that.

regards,
dan carpenter

