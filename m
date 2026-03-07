Return-Path: <netdev+bounces-265113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFJmF7D2q2kqigEAu9opvQ
	(envelope-from <netdev+bounces-265113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 10:58:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D822AECF
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 10:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E79C33004603
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B333AD91;
	Sat,  7 Mar 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE8jJ2/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCD1B532F
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772877482; cv=none; b=LW5xG3GExSA+rN4NTyLGABNfXN55pbncXQ1apI869bqCaRIjH1ojfDKytgn3hUYrenX0HP/jcHXeC84fov5eS2RqSteEy97jUHA8prYiYFT6PghtvC2GNwqIxTrG6QKqfj6AIWVBSgqyeXDzEl9ZpQHn22p9uUImq70emtYdG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772877482; c=relaxed/simple;
	bh=nMbfybaslcGWuJll4XhNNCg3BCbYqtCEQr0rH+DHam4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om4winWkx+Q/p6Pl2hVr9QJkDwjyvTbw5aCVwBdIUU/7GT7hKfMgE/ELKB80KleuLal/Ic7wFJDKQfsO3s8ob9GSvSCiHkXjNPRj/v4RMCFKd8gzdkuHbyam0W9DBazH11SsJAgPSjugIMJxWEWQAX6xFS62iNhBboV1YfIrPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE8jJ2/B; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-660fb578f8eso7430699a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 01:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772877480; x=1773482280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xtSLp/nbsYx54XEX3utPW4eMsXzJHDqw5M1U4odAek=;
        b=RE8jJ2/BcHjHlLJlZcYU4Ce765NS+2SJpdIFlq1TTFCq2DPwBxMwSJbCq/gnV6yRVM
         dIg7KyC67RSrljcWrhCqAVMjXugqIAnyvaVTupD7gpYKkzhqXqmug0y94nQouEzGsY2K
         1jv3mLEbE1b8w34l4YUaxvFOwOvLotAuLUxKGODXXxbprtRs5DtXwvcH/1KBGcN/t0Tk
         Lv3SINkhNwinptebQ0aYozTgvF0LIfXRqDtZpEuLUzhlMzMB0f22f7bL83vSTZ/Gktup
         q746Ec7N88uI/k2yHPOTShNY4qQDHtuqvAo9TIMg6u5ej/trecewyepo7mGMeOCCTode
         Plvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772877480; x=1773482280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xtSLp/nbsYx54XEX3utPW4eMsXzJHDqw5M1U4odAek=;
        b=sKhtRazyEYT1ncotZfvbHq/2GiVmy1WOcyi2z2krJCPeCbQF6bImXQtLFtIbIr6ylC
         gAfq35JY/21xQItY20DuH8f5/n3nbJBKY7BBEEYP6KbBbeIwhy35bBBLAjQhAQnAyEVK
         Rut/U1VTtfoe2Av754wIC3trwhN6CjcPxzx1Jfy5aEiEFTNU+lgTLvNqmR7QKZpFxEmc
         eL/du0lh5HKZpSlm+7VlXwSB0ddgWH/O67Isfx0bpCY6TA9QJSRkbe5ztfJTYs+BG734
         eHLs029nCuJKSv5B5/rH4696G4AzobAaasT2R7lzSGAV8RWQqf7Gl8VD+AMf2orfVL8L
         ZQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUoh9S2OYQEchF+8frUQPT8OA306Z2wQy4iCJnN+ysx+CIZ3lQG5LroVGkPTf75S/9y2zJZkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJNNLqkoRWA119KzFFLLEGy5454obPJYh8Zkvioe/Iorpa7Iu
	PaRBeZM4efWtDMzXSOz+TmlxzhCij4YzwYi4HpNLiv07OWLTZQ14AWcZ
X-Gm-Gg: ATEYQzw4aIctuo3wkdA1DvXUketKRzEUOqw59/VZogSYyM/Jz+DtC1gZ0aa89tqt5LF
	6mhBh1+hswbhNFKZBe1hF68QE6oFDPIANDeRQyvmaeyxnItZQVipfBrFM0EegkIv0GclpseSdoG
	JHQ5YMUeTnQ9nY6CskkDkP1102e+tvs8aD4r48Ll8PsMdx7ePLWEegx9lT9T9wHnb3sLA7IGNjn
	tS1QS9KAShKQoOYwjHO8iCOawGN6538iEkZ5J2zDidD/EG+uQT/93KGokuAKKIwKeOWoX/qfGP/
	EKnXPKR6lAhjmHdzUzi6qDURbqa+7v5i47czaYh9xQKW5XoRpyDwbuSnoIAZQsHZbEiYwzrvMht
	HU0DX9b3eBJcT79AHh6aK1JRAxaveLjkHZ97Brm2k5dWBIzgmeev1ZGdK4CPKTtmYOAptjeZ+UU
	eaQpZdwJakSq4rz1vJuo5cJvZLPpC2kxwk75SqdJpeh4rRjBjqaCMc6/eVVxpuR7aKj5pS4+a7i
	tCO/WwIUc7o
X-Received: by 2002:a17:907:968e:b0:b94:15e4:4d36 with SMTP id a640c23a62f3a-b942db8ffddmr353231266b.17.1772877479351;
        Sat, 07 Mar 2026 01:57:59 -0800 (PST)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15d532sm127392066b.54.2026.03.07.01.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 01:57:58 -0800 (PST)
Message-ID: <3bee5ef1-0692-4779-832f-193017810c38@gmail.com>
Date: Sat, 7 Mar 2026 10:57:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
 Cezary Wilmanski <cezary.wilmanski@adtran.com>, Liang Xu
 <lxu@maxlinear.com>, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1772853341.git.daniel@makrotopia.org>
 <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 509D822AECF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265113-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.926];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

On 07/03/2026 04:30, Daniel Golle wrote:
> The MxL862xx offloads forwarding between bridged ports to the
> hardware, so set dsa_default_offload_fwd_mark() to avoid duplicate
> forwarding of packets of (eg. flooded) frames arriving at the CPU
> port.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  net/dsa/tag_mxl862xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> index 01f2158682718..c02f69de61cbb 100644
> --- a/net/dsa/tag_mxl862xx.c
> +++ b/net/dsa/tag_mxl862xx.c
> @@ -92,6 +92,8 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
>  	skb_pull_rcsum(skb, MXL862_HEADER_LEN);
>  	dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
>  
> +	dsa_default_offload_fwd_mark(skb);

Does the switch (by default) also flood link local traffic (e.g. STP, LACP,
etc)? If not, you should not mark these as fwd offloaded.

Is there is a bit in the header that says whether a packet was flooded or
trapped that you can check?

Best regards,
Jonas

