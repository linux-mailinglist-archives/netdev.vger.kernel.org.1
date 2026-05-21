Return-Path: <netdev+bounces-290488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBSJBgwXD2oDFgYAu9opvQ
	(envelope-from <netdev+bounces-290488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CF5A74B7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCD0332C9A25
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51D3D890E;
	Thu, 21 May 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCvQk+hP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qeHHPaP6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2C3148A7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372788; cv=none; b=DIrjwnOQOrQsCEzT5Am82PhCaZf3NS51OPRoGErsrPQW6BDAhu8jflwDGRkd83JKgV6oJRkMPGCp+EuvX579sDZDC1NYClXcPuEI8rXHQWCCYW/veCPtGGLDST3F7PRdOJxhfG+mDmzYI5r+XSj4TmHgN+Gs64CF9yGxmiIbmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372788; c=relaxed/simple;
	bh=/Ll4LsJw2NuGzLS/mu1onbW6xXMghR0UiL10bny4GZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuB0UnkBR3z+QdE5oQ8ZWsb8Fc8D4db2EjUxUW3l5IS9QAK4WGXgn+n9MVPOyCJtvGoB+a4c892zRr6BeHOR6rLEFHNxZwj4VXJT48LGwY5Z7asUN4jHptHhE75Vtkw8DTN3BXMfNkqHzN8CDI3Vd6r7i0vscZFtar62XAjP8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCvQk+hP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qeHHPaP6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779372786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SaWkb3YbEdaxwTpBI74c931mIOI0075U6MVUEur6iVg=;
	b=VCvQk+hPrRucCN5HheHVXYlooxsXxSvrppZRi1vM3r18spTpC1wvhVaOtxEJ7Ty6pjyyP+
	kq+37mAFfamDnBi+D8RUBnA/gM6ZCsrk2nTjwtxchp1NVfN0S8ngfDIlFTd3AwWw+l3Q2A
	b7ffXISAxW2lnz/lR3p8Br+OyJ2cVJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-1pldBW1TNQ-DRkAN0IVMkg-1; Thu, 21 May 2026 10:13:04 -0400
X-MC-Unique: 1pldBW1TNQ-DRkAN0IVMkg-1
X-Mimecast-MFC-AGG-ID: 1pldBW1TNQ-DRkAN0IVMkg_1779372783
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e73a4f1dfso4421066f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779372783; x=1779977583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaWkb3YbEdaxwTpBI74c931mIOI0075U6MVUEur6iVg=;
        b=qeHHPaP6vaTnE+skqhQhM2j++2c2D/SlFomnM7LlCqcE5vOP5Uq1CTAGiwdSMUgehJ
         dw3hz/rpdM0NIk3OAxX6Z1xRgLpNUp4sliKt4aLoay7Byidj3BPvML/3/yuXWH9Cv1JO
         orl6KYc+BWS7jq5zUBMZjdVDLwWEZiyZY9JQhDoTFSiRe558jEDzPA5donMM3pE6Mmi8
         /OFO1YNYb5mjn4RQvyd68Y0lq6sEwt4Q9xxku54vced5Kt2zf6em0HD93dg5RIED7POa
         97dkUxQxGJ8GENoIN5ReWSTvFdkG6t8JVQ7hHLfUOwVa2mIMxkrAJbLu8CJEk/QL37VJ
         VeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372783; x=1779977583;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaWkb3YbEdaxwTpBI74c931mIOI0075U6MVUEur6iVg=;
        b=JppaZeNRZP0nuK8kwLjoaZ1+sA0G97Jq+lV6OoPMdhf7W88+M7QX2MK4pTW4I0K/Bm
         /PJV2dwrVEFLQ8VaoV37oGVX9kQI+YgCeyCCR6NwgzldGw2aLkF/NAivoHl8VL+8nA2t
         vhbb8PQQhML7zUq10E7WKx8etJwIeghvFb8ur/X4bv+NZ02ptlyehYYnmtfwDDUBxyQ2
         ECQg9Km94zvrpK3pZBHjYgmkCFSsVXlyYYkMZTZA3/8I4bFzWLN6dwIx24o7oCcJ3XdB
         AJhfMqotuo60SmIOjTkZwL/++QUpMOfQ/6JoS+Dn0tjoONmoNHxuPNU1bKdw2xdQ7A4e
         5FbA==
X-Forwarded-Encrypted: i=1; AFNElJ/EWvXvdBsXDRbGX4U/MyjvXiMqIBIrcH9HRnNOG8CVXQSXFgPCdNqHfiFmFS1q5xAo+11kjHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKK6oMDWeDemNJSog5LiJAH53CKChk8ihV2AIhNR1ndJswf9wM
	QvZpuA5WDb135/1incrfGfnXo4r2PbsyoXMqL81YLKjDKiLd6aP9wyHoHpuTPC0m4/mGKWkhtPU
	dRfkh0LNcEoWL6WnnPX49yNQ2n1S5Dg45NSnyJ65zBjqi17fsxupZiJalGQ==
X-Gm-Gg: Acq92OEp1DlPbrvNwkT49JITmPkPAr/bY0VHpZ20s/pFmNAnNfti9tQEyyarTT5qwtL
	Fgt6BVy7PkWt5HS1B1Su1/gqBYvs10uqboZr+Cnp7aMjWuRdrM5AjbYpWKupXFOAS6FvC96Ywh7
	OtfTVxaEkp0ghgvLOctHTp9aw4qZnj92cLUwsCNqlRQm574zQAmTGXrX3wYBCRzx5g47ue8fh3r
	+c1mn1Q757N4AvIkDAfOB7s63pfpAdkvkEymPqwiFi2CNwsOuaU4b1wSHmnclyF7Qy4JSNEsCAr
	eVEAXwrQ+hF82n+LH6jfTHbphyzp0gQKhR6TnImDSIq4UGECzmueJvtbUTqZBJ7aj2mPjxDKGxD
	GFFpr1iYmdDcl0nCYOK732gZXOT6m9CpEZ1Yk8oTeWiyCSf0ID4J9aXCYTA==
X-Received: by 2002:a05:6000:468e:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45ea3ae602cmr3713709f8f.4.1779372783436;
        Thu, 21 May 2026 07:13:03 -0700 (PDT)
X-Received: by 2002:a05:6000:468e:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45ea3ae602cmr3713651f8f.4.1779372782943;
        Thu, 21 May 2026 07:13:02 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa9358c5sm3054266f8f.30.2026.05.21.07.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 07:13:02 -0700 (PDT)
Message-ID: <780d21ed-4ab3-478c-a932-6feb7aa6d7b4@redhat.com>
Date: Thu, 21 May 2026 16:13:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: napi: Skip last poll when arming gro
 timer in busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, =?UTF-8?B?Qmrvv71ybiBU77+9cGVs?=
 <bjorn@kernel.org>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290488-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 247CF5A74B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 8:13 PM, Martin Karsten wrote:
> +	} else {
> +		/* All we really want here is to re-enable device interrupts. */
> +		rc = napi->poll(napi, budget);
> +		/* We can't gro_normal_list() here, because napi->poll() might
> +		 * have rearmed the napi (napi_complete_done()) in which case
> +		 * it could already be running on another CPU.
> +		 */
> +		trace_napi_poll(napi, rc, budget);
> +		netpoll_poll_unlock(have_poll_lock);
> +		if (rc == budget) {
> +			gro_normal_list(&napi->gro);

Not blocking, but I find the above slightly confusing after this
refactor. Perhaps it should be re-worded?

/P


