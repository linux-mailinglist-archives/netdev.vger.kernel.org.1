Return-Path: <netdev+bounces-299565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vLzMITRHMGoZQwUAu9opvQ
	(envelope-from <netdev+bounces-299565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3B68940B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:40:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=aoYWPCvl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299565-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299565-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 226E530091D3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D855381AEB;
	Mon, 15 Jun 2026 18:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C93803EF
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:40:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548838; cv=none; b=I5i7WtR/1RXqe1IEKNUaZTpFRwpD+X+D+KCfpfDIDD/zQF9HuAEDWdqztnDPOcXltxsaEu1mc9W3ucfm7hIl4g6QyGvPIXTiru+DLvtjUTA+Z9f9QEC6pSSesttci4vFEByORjvrVOIY0lvmAduBGEEiXlrRDxNq2rOwp3wjSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548838; c=relaxed/simple;
	bh=O/0PgMIUbrt5dC1obpu7YDpcI1Xe6FmOAjZPjgqRAjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ks3/3vshdSFEiJDF9xdoi9ELm04RAvNSvqNu4GYp7XQEEJZ+EWwg35LJciMvuMrTzzRk8XjNpWohaD9wFqZrtx0TDZ2xb7qRj93mGzBNdNjCRgCXJSIbp86OEpltWykCsaBCRIqSXXQ4JiINnvIhWUoqQeS+vwcV9WgABK/7z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aoYWPCvl; arc=none smtp.client-ip=209.85.161.100
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-69d862236ddso2279487eaf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548836; x=1782153636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9o6wAB7eFbPGoIqOzkbGD+Zrc1oQu5LJtlmd5I0v30=;
        b=n5YrJmZWccfnIiJh7DYFDktbYF2Audm3E3K5800J+vdtxwZhilWAf6MNiEZ66NMwBz
         3EwgdQxGk/HuDvHn5Jmvp25J8F2Q0SgYm4p/olnjlKVZ/3twmeM3NNt5CeB43F0AiRgo
         AcvbfRzubDaEp4z2ACoEGeLMLGxVV0NY7aUTUnj/hKnLhZUKduZMn4uIjhkRWwlQaGcC
         wp7bxMB4TIL/h1EpcYH6oUfjO4JolhJ+AUQQkMcdjtQLiSvA4ehCThkDJ0gT7rhOdPa1
         tOcHMNVF0tUFCHxLHOeP2EZ54tx0Voor1xGKzD3uEM+KLkK3IZFy08gkTdQ0T+L4jBOk
         F51g==
X-Forwarded-Encrypted: i=1; AFNElJ8OfgSc4qj49dMKAo2OQzHmX6cUax/7C1jT0VsKFSaRKpKCg2FsiWHZHCvLt+s9pPkmg2kssWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYW9ujtYDjm+TdeUdNVMlDp9hWcXZggMNn+liFbl1dHtQV0RO
	MXpW3sYM7sCJMGUA3O1HaD0BmKUFuMEGLIbMQz0KAqQK4Xk1wjSQbcbkw6L3oK96E4xFqE7p8q7
	nwtZ31QyNbN/18dNrH5q3kI8tqeL6sh3ASLYTtKiySTuaYg7Dg2wJUgpI92ssHcU+yxqWwEzUPa
	a2HDbjfO1k6XLXWsEH3swf4p47wN4n15Q4QZa2TW59WA4U8/Xef0epD/M8G4CeYH+sRaYYAeoZW
	zOvlQVUyg==
X-Gm-Gg: Acq92OGfOvV2TGGb7uj+hCSmwmhiZQ1U9xyzx+yghX4UueXU6MASimmQdmwxHPTcEwz
	gRTP61mBH3pVtwO85u0RmhPIAmV32fXDf1zD5u9Jse8sYtKXiAQLwmfM28/f07jTtgcE1smeYxW
	CY/0k/skGr/wcGQr8oA6PkOktc5D7/27cGEVl89WCYSJDPxw9I5RiLkxESjWu9+fuxO+0JB1fFz
	tP38OAlssXARJhCrfGb2ESWMOFIQkrGFgYKIZrQC+6wS32ej7eY1C1fhF2DNI+myxW78nsUtmxO
	PunhHFr17j6J7HUEOHkGmgxHL+y0CpEJMOyu3/8yDnkpyKXQbM1s1ulmuW+GL7CFZ9z6nkHjpqX
	8SeAvI1h4dEprYxb3nm7b3zPv+PlDWwaCU6soHHLpMBe5FLCuHjfXJ9RWGEF6rlepzHFh+2sZt5
	8PV0NW+9bX6SxZJrNyEpvJl0Dyk3p2vvsMsnGtMHqVUcDAVmT9xSh/5hWwTg==
X-Received: by 2002:a05:6820:16ac:b0:69d:8d1d:1cc4 with SMTP id 006d021491bc7-69eec9508afmr7476818eaf.39.1781548835735;
        Mon, 15 Jun 2026 11:40:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69f00ec4f2asm334110eaf.18.2026.06.15.11.40.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 11:40:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-918622c3c7bso538229185a.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781548835; x=1782153635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9o6wAB7eFbPGoIqOzkbGD+Zrc1oQu5LJtlmd5I0v30=;
        b=aoYWPCvln3Rv75Y+5lPbL4MaRtjt/SthMCYDUhDszG9ALqeTxJAZ56cDyNyKerANlf
         eE9IyIE3j3NntKnUH2OfcHlk8bf5W3Hf26PwTwAgLk41gmyqKJ00dK9jQ2B9C4We8TAj
         sSqqLIQI9OF/sqzva7LFOBKCDP3BRnEr45Rw0=
X-Forwarded-Encrypted: i=1; AFNElJ//NW6FgNtdwLJa7AQGAwyuq30F+lBEBVSWy+S35GmTw3o71ZPe6uN7LGVUxWn+5H6Grz4MXH8=@vger.kernel.org
X-Received: by 2002:a05:620a:4047:b0:914:e3dd:17e3 with SMTP id af79cd13be357-917ee4d90b4mr1935252785a.4.1781548834819;
        Mon, 15 Jun 2026 11:40:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4047:b0:914:e3dd:17e3 with SMTP id af79cd13be357-917ee4d90b4mr1935243985a.4.1781548834154;
        Mon, 15 Jun 2026 11:40:34 -0700 (PDT)
Received: from [10.14.5.238] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f210b7sm1199212285a.18.2026.06.15.11.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 11:40:33 -0700 (PDT)
Message-ID: <6cb16df1-4964-4195-8237-96dcd49f015b@broadcom.com>
Date: Mon, 15 Jun 2026 11:40:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bcmgenet: remove dead priority queue
 plumbing
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260612205915.3156127-3-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260612205915.3156127-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299565-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,tipi-net.de:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FF3B68940B



On 6/12/26 1:59 PM, Nicolai Buchwitz wrote:
> With a single TX ring there is nothing left to prioritize. Drop the
> unused register writes, enum entries, helper macros, and the dead
> "flow period for ring != 0" branch in bcmgenet_init_tx_ring().
> 
> The DMA_ARBITER_{RR,WRR,SP} and DMA_RING_BUF_PRIORITY_* HW defines
> are kept as register documentation.
> 
> No functional change.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Tested-by: Justin Chen <justin.chen@broadcom.com>

