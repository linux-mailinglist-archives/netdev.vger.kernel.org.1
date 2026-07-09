Return-Path: <netdev+bounces-306173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ZcABex7T2qjhwIAu9opvQ
	(envelope-from <netdev+bounces-306173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92072FD0B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=G9aHB3RJ;
	dkim=pass header.d=redhat.com header.s=google header.b="s/ywE89g";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306173-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306173-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83DB330B4AFD
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAD406801;
	Thu,  9 Jul 2026 10:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F004071C5
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:27:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592864; cv=none; b=lAVW2g37DaKly8euz3QuUyilL5T9ZsBZ8IdhMbV3SUEM/SP3Orhf6DhrC23xJ2fceqWdfUQLiPozcBgh0N/0xQJuAqk1XQHla4etXpFFSwoMu6ehMFPUQHoSj4ylNP0frV2iRNXQueQHz/3Yn4tONnRy96zu4Z7HRpOdZ597XFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592864; c=relaxed/simple;
	bh=8rw2+1N6I+CKhDNKIcPmKqR49a5NkelTqlHrQwL+yd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwNqneAfnrwrBO3bzVF7+raQ9AJwT8WF+qoifqj+Raep3ZSwG567jMnB13XUvzQ9iNXzMJ0rCkZXA47SAZXyhkXuIJEpLPUiIfVn3gz9EdNM70a1sSZNeLVpYscufB3pSRViokU2GL5Lk2LkzGatszSPcOsOxlzJk63q2JdlKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9aHB3RJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s/ywE89g; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783592860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IViGw+4uEHmm4fFUeiv/BS5iug4sUEilxSd+a+plBgI=;
	b=G9aHB3RJdWyQ18Hq54G8EthTA7bSjxydrqd6edKL+Wph8o0aViBoC+2xANTnhsU2qIcAuH
	s7lNWxFGa5CcLLkN0E9pIfJmWdXVhoO7qnZPBi1H50VVOuGxjCmlswE0k+5iQjFin95oKV
	xN4r4+4DOvi3bA1Mo2nYiV8ENhz7CKs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-N7YAwl5BOyyKuPZ0zk7Kbg-1; Thu, 09 Jul 2026 06:27:38 -0400
X-MC-Unique: N7YAwl5BOyyKuPZ0zk7Kbg-1
X-Mimecast-MFC-AGG-ID: N7YAwl5BOyyKuPZ0zk7Kbg_1783592858
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bd1716b4so9241285e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783592857; x=1784197657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IViGw+4uEHmm4fFUeiv/BS5iug4sUEilxSd+a+plBgI=;
        b=s/ywE89gyFizbV4Q8eRHIrxZh4IEzbyChizTf9RmQwXB6dQp6fGebcaKbSl1EFUGaI
         jx8/AwC8BXfwyh7fMSIOPkIWeNYIGLt0vf+wZq5vetdTQ0P6LRZHZ9b07ipG0jHQUelv
         IFWC1nlJHn28uq+V3pzh7T3zKp/XVD3oCQnpsPj1pGp9IMzlrFc2RrAEsU6aqn9HmgEP
         /99KSCjOmdtJyyxO8m2LtTBKPUqptfxEXHwg9ec/MMFim9p/g/9kvIfux39ZaRJVBcHz
         FJYa1KHgfDJUEfJtrgCLMtNb3ivlWCkdR4nZ7gmRw0HFo9ncZuS0W/jTGFI518Ppc2rB
         iCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592857; x=1784197657;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IViGw+4uEHmm4fFUeiv/BS5iug4sUEilxSd+a+plBgI=;
        b=diQQIHdQuuWIDKAAgJBfmK3S9yntrUJaJGMOb703S9BHoYM6uEqLMK9APpMRYrI4Q/
         97rsQFpqzlp1deslnTQVAXp30E0AzVtiD9mXAEJNi8nQV66JKsAQatu1KcJbozfGebAh
         slT0ylwpnC/9Daq/YQQmLWT0Qh7hX54DEWJ7ypK0Rm0ww2cFtwVsvvGVSmSthy3fswMU
         hi1Po29krynW3IAsngm3wf8U6uiOqI2GXjxKQm4C2x3ahMzW7W5DihOet0RGybOyz4+f
         y3U7KRCXhHcvlalhlv+8bu6Agtd/eywmMJEOeDsITmFwiEtXthozzn7NvkWeqMCGZibT
         y6pg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/BZ87axgrT80+0LZ79OzNd9Mde45WSKrFX/PkJ3ii0oGK86xRcyHjftUlVozHXn/MdataDR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljptGBaVmE5KA3fce4ZBzAaiu18meEuFUv+tUkqZyGOn+b5PX
	bJkquDw1PmcHZ3EljQKVus/OadC0LBmlr8I0u5h6TWyF4XZ8u9DL5e8w1KK1m1zhUtEYOzGXGz9
	meV6YfzwfCdAk6ahQRTwISRqH2x7brGIF6BPYhv0SAxby2pBK/Go54+Rnjg==
X-Gm-Gg: AfdE7clWlP2awKYU85DU0vFVwTFVe+g9OdmlRF00pVe6+fIxOACNRi1fBUYuMOXq2X/
	RqO+Uy7P5MUcH10vsji8QwKYerSxdUlE41IXD3e+x3QZKBE8k/8zIjTTPxi2CDPilQ09mf56Rob
	OhTMKAc9E81bNegrvTL345/O2sjbGW3kc9r2xs5fCcbc0NiqS5SDlgqWde7pv+iwXRmSCseMh1D
	0CS+xahkSyobCKsUJpvuWFnAkeCfrd0XjFglIIQmd1Iq/9Oc6h5TtiR14OQlVvLRSmX6frZzygd
	GP/ULUCQgPW85i9yw01zD/67Ng/uL0vTNdPyzA6GvLrPpr4FpOrChu2nRXZNi0M9CuYNzEYvZoi
	wlx4VLsq5cn3ptN64rqyYWw3zGL5OOGAc8fVcK3pACtV04uHgWIl15ugtxb+dEFytLphw1LUo+W
	ksfhnE6tnyPYuQ
X-Received: by 2002:a05:600c:870e:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-493e687f380mr61307875e9.38.1783592857523;
        Thu, 09 Jul 2026 03:27:37 -0700 (PDT)
X-Received: by 2002:a05:600c:870e:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-493e687f380mr61307475e9.38.1783592857085;
        Thu, 09 Jul 2026 03:27:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm48492955f8f.29.2026.07.09.03.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:27:36 -0700 (PDT)
Message-ID: <64257110-d9fe-42df-9990-2ec1421a7c29@redhat.com>
Date: Thu, 9 Jul 2026 12:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
To: Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 asantostc@gmail.com, gustavold@gmail.com, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
 <akuUkNgyjVOTHMuz@gmail.com> <20260709101945.GN1364329@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260709101945.GN1364329@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-306173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E92072FD0B

On 7/9/26 12:19 PM, Simon Horman wrote:
> On Mon, Jul 06, 2026 at 04:55:35AM -0700, Breno Leitao wrote:
>> On Thu, Jul 02, 2026 at 05:19:44AM -0700, Breno Leitao wrote:
>>> This work continue to untangle netconsole and netpoll, improving
>>> memory usage for netpoll users that are not netconsole.
>>
>> Quick follow up on the sashiko findings. most of them are assuming that
>> netconsole_write is called locklelly, which is not the case, except
>> on panic (CON_NBCON_ATOMIC_UNSAFE). 
>>
>>
>> There are in order as they appear in
>> https://sashiko.dev/#/patchset/20260702-netconsole_move_more-v2-0-1ebedd921dcb%40debian.org
>>
>> Tl;DR: There are two pre-existing issue that I will get fixed, but
>> I don't think they are blockers for this series (IMO).
> 
> Thanks, I agree.
> 
> For the series:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I did notice that patch 2/8 now applies with some fuzz, which trips up git am.
> You may want to consider a rebase.

Yep, a rebase is needed, thanks!

Paolo


