Return-Path: <netdev+bounces-305686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cFBoALUPTmqzCQIAu9opvQ
	(envelope-from <netdev+bounces-305686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E77235A2
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="es8yhK/d";
	dkim=pass header.d=redhat.com header.s=google header.b=bXwvNn2U;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305686-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305686-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AF55300B1C0
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA109404BE3;
	Wed,  8 Jul 2026 08:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511232F12A5
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 08:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500721; cv=none; b=m/KCnRtU8TSncL5yMHuhj0nptPDlk7jBSYKP1cH6PiN+9hC4X2oiVgyRKS8De9BYxJ8TrHeIRzMYgby7Oh++eb+eOLZ8JLiNv4Feun38UzALtH3ck7Ho84B5lPhttGXS647uyX9KCa9bPdv7v9iHwkewV+vPHpw8Jb51/Gu7Pf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500721; c=relaxed/simple;
	bh=iTg55uFf+DBgT1GkSZ2OOhCGyEfIb5SUu5yPitKHF2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTjUNLyEKg28hyVz6TaMjsqN4rguUWR9IcrLzKHuywqDS0GwZ47jenKHLAduhbNZva1R6RYZV7bpgSsQvZpIISn4zinTf/ALeiEHrj5CML2IsPhvC5KA2rklWHDYF7AlR/zXQpuJwTzEG/fT+UW6U/9bclUNl1WpKR8auT39iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=es8yhK/d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXwvNn2U; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783500719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5u8E9yd/ckZ8PLZBECSPkzMZR3A3Q5NfRAHTKkSoC3U=;
	b=es8yhK/dSX2cS8rAUSNJu6JVopPHllLnBiD/T21RUALHc9XUnnxrEWkWM7QVpuLSQMh7Sj
	9SRFlYe5vzKa0hwstCcoHrm8j+Tk4xzlLc8hXKVUN0ae3wVOSCNX14vdfdhiz+n2JqikKK
	YJU9FFRivT4uDkFMip3rpeH7fWfQ2Sw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-8xoKqk8KMDyFuW8aVPAFQA-1; Wed, 08 Jul 2026 04:51:57 -0400
X-MC-Unique: 8xoKqk8KMDyFuW8aVPAFQA-1
X-Mimecast-MFC-AGG-ID: 8xoKqk8KMDyFuW8aVPAFQA_1783500717
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so3528025e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783500716; x=1784105516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5u8E9yd/ckZ8PLZBECSPkzMZR3A3Q5NfRAHTKkSoC3U=;
        b=bXwvNn2UlJ/41YgHA5MMRCkjn+qLjb1qlZnWKPvHjS9SS0viEW6/P7HA7qHp2iDTHd
         POTxdQ0nfdjcjXfvx7vjEQeoyeShFJPMWt2LRYFcP2NPythUep1lmUSjyzl9p8msKUlI
         EG0YZ5YFUNHFdsK7Aj3ANEJGMdUIGqIobfohiC0SHPLEK3GTvoiVvbnWRyJI+VIuAiUV
         jspcza6M8PvgRIxxrljeUF37BP00EhBYJC1zuVpa6mw8FKMDxRkuWoiTYoC9ItF5g/3t
         QDSY73MQv68l14osB03Pa/KGVAjs7N4av3AzrCELue0mKnhw3QBQ7aSOxkU2kzhxMhlM
         74TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500716; x=1784105516;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5u8E9yd/ckZ8PLZBECSPkzMZR3A3Q5NfRAHTKkSoC3U=;
        b=R07ip50vhSdZ1qXf369asxiwo7c2VYueaW4ATs/DNerDpewASQbc9mE8kqNnwEJw3Q
         Ifm1RzJrQgdSSDKMin2SgBrrHeq5o1z876qKbq2C6zJSxr8cJ4EmNkkeYWKL8NLTXX41
         NiXpsL0aXId916axgGBdXj40DbhD14jSL4Ctu4zXHjq0WfHBaRRfNOzPI+s+OJIcwV4w
         a+AYUhWmH+5lzp6TLY+4GWRnQuDVmblpbmvg8pfZOxVCWk8oz+LFmuocFWkYYDTqwzRw
         hsg4JtdQUFa+SMRAeZ8bx23knwkADA39VS5io9yZvnN0Bia6wag0NwCwHL+QUTzdbuMY
         ge6Q==
X-Gm-Message-State: AOJu0Ywn+v0zqsQ4RpEaHR6fdyyV8XIXPjX2Mc0GDy6MteCNkgsyFpBt
	j3xgAIJ8/Kw1fy2pp6YO4h4qc9P4t57RTKaEcBS7ILLnEqzCgjayeRY+zY7BEYdCVHCxlXX4U4Y
	aKpGfNGG1eHBNdBJIUCqhPxVMt5He3AtBMZlEaa3gk19c/nn+bPXM44H7Gg==
X-Gm-Gg: AfdE7ckU6aOCWNEtd0oNUJA9PoZrGLFJNnSLUEsiBr60k72EYCBpC1HoMUhdwocMK+H
	F1hDOkSjEpecuafmWkjBLsbT909TlW/0WwhjzrwQsgoXf0up+n5DY44CT9JddmqluHmQo9jESCj
	RTyKGIs3rXu1VCGdIAJ4/xR7a+hph0zykZx6yVcqAJIvllNU4pcg2j6kizp8L8br+d+hZ+fQOas
	qJ/mccOrsgOVfTlnHKf1vCwSj4l3rl5K/G+voCevJooTSg+5fMZvTOBvqrN4FE7tdshOeB9OAQc
	K05c/5nCETYNOYaDdjNMyJk+ZYU8ZRdsJY/Wgj7I2hRU+rny992qIpU3HhFM9IojPbw8iIDYPbY
	2Qagl6w9VgEMYb7Ybidhj72r0Ro6U8ncxS6nSTFneTTogdLf2gHZlP8i/1pML/08TC6x4wIZ85n
	ffk4EPeiqY7p3Q
X-Received: by 2002:a05:600c:1d9a:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493e6369acbmr14827975e9.2.1783500716616;
        Wed, 08 Jul 2026 01:51:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1d9a:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493e6369acbmr14827685e9.2.1783500716184;
        Wed, 08 Jul 2026 01:51:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40d50sm142908365e9.5.2026.07.08.01.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 01:51:55 -0700 (PDT)
Message-ID: <1240f40e-ba1b-4773-bf65-facad8b4fc0c@redhat.com>
Date: Wed, 8 Jul 2026 10:51:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 0/7] i40e: re-init and UAF fixes
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, kuba@kernel.org,
 horms@kernel.org, przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 930E77235A2

On 7/1/26 2:45 PM, Maciej Fijalkowski wrote:
> v5:
> - include three new patches to address last Sashiko review
>   *
> - do not release the irq lump in rebuild path in patch 7
> - clear dangling pointers from rx and xdp rings arrays
> v4:
> - add preceding patch that fixes a case when some of re-init allocations
>   failed and we missed de-registering netdev at failure path
> - pull out i40e_vsi_setup() changes onto separate patch
> v3:
> - address UAF when ring arrays were freed before q_vector's ring
>   containers (Sashiko, Jacob)
> - remove bool params from alloc/free array routines (Simon)
> v2:
> - NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)

FTR, I'm not 100% sure about the actual target here: the subj prefix
point to the net tree, but the to recipient is IWL.

Since this is not sent by Tony, I assume the real target is IWL and
tentatively set the series to 'Awaiting upstream'. Note that for 'net'
inclusion you will need an actual, not empty, cover letter.

/P


