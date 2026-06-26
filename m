Return-Path: <netdev+bounces-302245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GhXyLQKyPmqGKQkAu9opvQ
	(envelope-from <netdev+bounces-302245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F406CF58A
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PfGGy3dD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302245-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302245-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D411C3008A7B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF93EAC76;
	Fri, 26 Jun 2026 17:06:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA53FFAC5
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:06:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493564; cv=none; b=SLeFIfdxPUXC9GNTPLylqYWOXxPVSTysug80PkLsox4dYRdFIEGEXyqZlAt4he+phrYyFGWYw9ChCi9ZOTvEWOd03a/NVyiUHrQaIjncozhZRrtOvWN+ZDYCwW32o/HS3uFwoqSE9RCXE5awNAO/ivaWadpbrKOIonu9VFkt4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493564; c=relaxed/simple;
	bh=GQKFAfjK37kURb8eXgj/bP3eu1MfUrZ2X80i3UfUWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2y1jZT6v8sta7bvJeMfIjhkk+jNtV9jgPNLgXIKqs88ApRCVEPJuSRe79hQTusrGBcpU4nvHTKVAoR8g38kygzgOL0VuevjfqMIQrWr7DCp2n+477jv/sPw0CeHOCI2EZykM3qa6uSIa47C596tsQI3MwXSwPtvxdM3vZD6hRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfGGy3dD; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so13851595e9.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782493559; x=1783098359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
        b=PfGGy3dDJntvUAhwdN74MoQyZ7Kb76WVRvfiYiz1r1uk3V/wjmc0ccylG8JVhL0+aO
         9WSY+r+SENhfxJL8CUeOB1pmR59D9qbmsIm0QL0geqEQ3IJNFp5Fq7qrY/5fyGWdsqG0
         nIyYMLaVYge3kigQjmdxvMGDVbUqMNI+4R/I6uQ1sMOrczr5lwCRWg+mi2S0BVuQYDKL
         dDgqcqfyH8rsZo98a4Dkff0WHyw9Af1jwt2qhjUEWTtw3ws3bdrW5rBD3IoBPhrQQzZE
         8/ce3DSxR7gM6HlnWvwnjDorWuEU3FMzRK5nbfmPEGSUPopV0SrDeRoc0yqUq7qQ+8gO
         PhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493559; x=1783098359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
        b=oLgDjAzuZZ87EwztE2gwSX8Qfb9GFqHtwLgv4RoP3ZFGNVq/1cz6SacXQXGXiZ2aF3
         woL/UjXxlm+s82WkoABGoPOIaOylGsGOndHejBrGkzoRx0xWr96gAnr/NsbKTM5Nv4Ga
         6/x469jfHI3dpnNwYTfbTeitdCzWkkVd372HHh7v7uEkzsUQywiIn4vVI+TonB2w5EWb
         qarGaokNVzU9/XaOK2qgEboSOiMLg1Nqwjed04PpSgHUdxcEobtKzoMm8lJcFDpFEsH7
         8dsQttNKu/J3wG2s5PpavQQOa2fHEPa9EukFjb8v5sTV9ZkHl9xpZjq8a34qkXJ4OVY9
         A93Q==
X-Forwarded-Encrypted: i=1; AFNElJ9xusQ/Hn9DcUTsWQEvbCbsJwraOWVnKRX6mhxd7o1nDgmXOO3Ff/L+nGs5V6s0B4tBvH1bNqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlaxpdk/eN/Kc8Cey1l5YGOVbfQ/PfIQyjn9dmHRQUxz7CDbky
	QOJnBl1L/Xf8MHnnPlUSTTW9fMIaDWXUfZDoBGJrU1SD1eCM6aP1Ocuu
X-Gm-Gg: AfdE7ckflVSxfcnG8oJTrL4Ljmu/M8AYzVJDA2byvGHThY0OkwtTzeBnC1YyAJ5c0hy
	8emqocuFsHJI5fdgKbaC+3jaV9fzXrgXRVdb2MbdLCgZrHauETAzUTugYanWMBhzlixewKgPmYm
	UdwLKqo7CnhJUVccSD4FYy7cqbLCHlPaDJKOUJ5xOs9iuX5zeUW5A6lmy36kkJgTGg7ZMhhmIYl
	XUbgsgM9LW1ztFT9R3B5+/HFp30+30jJ5nNr7NHhCpM9RjrxeMV3BmsVMUC8m6auIIls+CF8ZF1
	ZOHEAQFuweD9XTDbfWWWkyqQMFz7BstKBi2/asNyfuKD6+Ftgl+ehA5hCv1qAD1Ph8H7kJesap3
	oY7P8H8F3ko3wIdN5qhNMJpU4IFmBYBDl9GLonTHBqIMkn6gn7xN3EpR+As3bnD8yP879wTiIUp
	sL5qfs1mX3zvcF+UAH5eNvE48GxHJv2QPc2yHnR6BSjlWLYLb/ks3xR6IQsSVN//+7de8RtaL5s
	naBvRyQ
X-Received: by 2002:a05:600d:864a:20b0:492:5bf9:d149 with SMTP id 5b1f17b1804b1-4925bf9d18amr186215685e9.5.1782493559068;
        Fri, 26 Jun 2026 10:05:59 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fe25429d5sm1694876f8f.7.2026.06.26.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 10:05:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
Date: Fri, 26 Jun 2026 18:05:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13F406CF58A

Hi Sumit,

On 6/26/26 14:34, Sumit Garg wrote:

>  config QCOM_SCM
> +	tristate "Qualcomm PAS SCM interface driver"
> +	select QCOM_PAS
>  	select QCOM_TZMEM
> -	tristate
I think QCOM_SCM is missing a 'select IRQ_DOMAIN'. Right now I get a
build error without it:

drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
  drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
of function ‘irq_create_fwspec_mapping’; did you mean
‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
   2512 |         return irq_create_fwspec_mapping(&fwspec);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
        |                irq_create_of_mapping

- Julian Braha

