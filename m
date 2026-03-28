Return-Path: <netdev+bounces-272764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAfQI6Wzx2mZawUAu9opvQ
	(envelope-from <netdev+bounces-272764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:55:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DC34E1F0
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472D2302E7C5
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B6387361;
	Sat, 28 Mar 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UlspkpdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f104.google.com (mail-pj1-f104.google.com [209.85.216.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F830E0C0
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774695279; cv=none; b=YXnqvcFulYbEtjwit8p9H7yCayB8R7oA7hPRZtKTk3Txet4lI4kKEu6+Wiq6Odkda7FngmayaIy/CQ2wL6SBNQ3QRvIbnu/EZRN1Ndm7RKCNrkpY3QRxpvvW8aRiIzitXN92J/Y1I7dSDC8SkLsQp3huEsmfNordT+32M/RoWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774695279; c=relaxed/simple;
	bh=PspH/X4KJAHkqtDhj/K1jV42/wju9Xfv45eoFPuzSFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsrPm1l8HzaYlvuzfWsS0o09DsXN5/DOmEKFUrlnrGGViXnFT+xw9N+dT542G5I073L7hX9aPQ74jmZ52R/m897HEkwpsA8UJwINzPkntE3KaJU8OWGVg4GZcS8MJKITMQl5yBKm86rXCJ6fnk9O7BmzbZRwYud1FrvF4ys/Q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UlspkpdY; arc=none smtp.client-ip=209.85.216.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f104.google.com with SMTP id 98e67ed59e1d1-35d90833cacso532875a91.2
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774695276; x=1775300076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ofaDT6oEuKpoTRxG6lwEX7XMq+tIFsfO197Yw+XEcu8=;
        b=nbLBlLftcJUZz/PDTQOEDANGIM4YbBw7zUBQBCoVC0dpOHaw1PtYdh4lhZgLfIxoJ/
         kxTnohmRZk1W1wpHoxUn9G2OQcHTxSYnz8a+G8b6ocjLNWBDhPjJlyql2/GN8V+4ndZ0
         9DrOUBUVUZFqw+/CyFvjcY8vYCDvctnEjRF59hnJK8GFaV5DMaNT4cX7QDvFkzt4AFjy
         A+D/GX45G31gbtyr/CfVPcW9wSJNKb5da6AT01gYrJh0dWAOIX+b8kZsUlGr3X5y8YLb
         BbrAMeOMmc/f8GsnlivGCuXNeX93+O9Y+z6lViqkBieVfQg2lAsj/GpnCXtwhhoh0+CU
         Bkjg==
X-Forwarded-Encrypted: i=1; AJvYcCURUoOMgKFdgHK2hjnkaCMXWKt821zc+b1XgfjItGYg1jDBS+fMUCjgfhyQznnL5koDSSsyU1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPoMbdqNhEQM1IILRqQiFAQqJrAZU233wXxUnc/R5+x9Jz2xXi
	5BjvP4zy8YdFA1R6MhuGPgEgviVBbnn4mCiFJLWmTKo18kctmbsymFSPFcqon/iRh/mfhyPwicw
	DW0R1YrBkoKtsLwatyuoALmT4p4iwbxd42V+O1MQ1oNK+dwimLeszU2exsdhZ1/P+bCBAHSZCVH
	F8CLI6Shw86vFMjmzzzdsCuDNI+lW5grGdrjVno0K4hrnDwNVvJEzc/QwBXLMZZn41KtIx9fqco
	B/vB68CXTE5NjIC8Mhm
X-Gm-Gg: ATEYQzw3ZInYmnMZGgqptTTRjg7oMGq025qvH8rjCWADEFaCRGTkdokCCbzJPOsTxBL
	wGcsWfOIvhqoalAo2FsJlaP05TT+ligyYQiJTjih4b4mXo6+lqoThZG4eOaeRFcG0V52LjeOvsX
	SjBCxopViQw4+h9UiQHH0o64OvtNdhGZPxYmSk2GN2ocsiVMANncQCBo4ZRpbpH5y4PAZWlCLaP
	PifOz8PemMKvC25ivBYUpua8emUSlEe5IrE+LWxDdtSSXsCdCOWzJ8fhqSw4jhYFLxfZROzPn7+
	MZpm+z3AVObrsSSPQ/bROlIdJV3W+zN7MjZs/qkPjxXzMFHrhLYcXPmr/jARMRFbvEk2vzXW5XG
	fuyjeL5tj0QVZ+ZmYHWIBhQ/xfq6GAShg5ABwyGgzHUn7mV7bZ+PWybsF+qCLxKZlovt5Tym138
	/uAFS/SsFr
X-Received: by 2002:a17:90b:3dce:b0:35b:8d89:719a with SMTP id 98e67ed59e1d1-35c2ffbcfefmr5607058a91.15.1774695275683;
        Sat, 28 Mar 2026 03:54:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35c22d74618sm882896a91.4.2026.03.28.03.54.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:54:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-662f12c2747so4097966a12.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774695273; x=1775300073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ofaDT6oEuKpoTRxG6lwEX7XMq+tIFsfO197Yw+XEcu8=;
        b=UlspkpdY+zBWLNr99upvLJ/qKgWjdJleYmDzINwWbPA6XvkvxgZBjFok+G5B1Mihq/
         AeK3aCYlIVdXUtmB6+F0NMPokApC00SzoZDTK8BTPHsjfF7iVY5fpbsNKyzPvBC4QXGI
         qfNyA63o6Wu3xrKDLLiu58zMkK5YDbi1ze+2k=
X-Forwarded-Encrypted: i=1; AJvYcCXIhetxiCZp8FgcV6NIg+PPjgU6mfr8UIiDaZ6y9GBbV97tjlL9eNnjwdgj3I7s+9DV+dZkjcw=@vger.kernel.org
X-Received: by 2002:a17:907:c70f:b0:b98:5b2:77fe with SMTP id a640c23a62f3a-b9b50301ec3mr363012466b.3.1774695273386;
        Sat, 28 Mar 2026 03:54:33 -0700 (PDT)
X-Received: by 2002:a17:907:c70f:b0:b98:5b2:77fe with SMTP id a640c23a62f3a-b9b50301ec3mr363010966b.3.1774695272862;
        Sat, 28 Mar 2026 03:54:32 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b801bf80fsm56205866b.0.2026.03.28.03.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:54:32 -0700 (PDT)
Message-ID: <ccd8a143-7467-4b3b-96b7-e5c3e0a2fe0a@broadcom.com>
Date: Sat, 28 Mar 2026 11:54:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] wifi: brcmfmac: fix use-after-free when
 rescheduling brcmf_btcoex_info work
To: Robert Garcia <rob_garcia@163.com>, stable@vger.kernel.org,
 Duoming Zhou <duoming@zju.edu.cn>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Pieter-Paul Giesberts <pieterpg@broadcom.com>,
 Piotr Haber <phaber@broadcom.com>, "John W . Linville"
 <linville@tuxdriver.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312031429.3432419-1-rob_garcia@163.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260312031429.3432419-1-rob_garcia@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272764-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org,zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,zju.edu.cn:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0B1DC34E1F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 04:14, Robert Garcia wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
> 
> [ Upstream commit 9cb83d4be0b9b697eae93d321e0da999f9cdfcfc ]
> 
> The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
> flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
> runs as timer handler, sets timer_on to false. This creates critical
> race conditions:

[...]

> To resolve the race conditions, drop the conditional check and call
> timer_shutdown_sync() directly. It can deactivate the timer reliably,
> regardless of its current state. Once stopped, the timer_on state is
> then set to false.
> 
> Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Link: https://patch.msgid.link/20250822050839.4413-1-duoming@zju.edu.cn
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [ Keep del_timer_sync() instead of timer_shutdown_sync() here. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

What tree should this go to. This looks like a stable patch so probably 
it should have been CCed to stable@vger.kernel.org?

Regards,
Arend

