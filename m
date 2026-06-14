Return-Path: <netdev+bounces-299220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JidzKwesLmoR1wQAu9opvQ
	(envelope-from <netdev+bounces-299220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:26:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1666812A3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KKBGR+1r;
	dkim=pass header.d=redhat.com header.s=google header.b=sesKV6Kf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299220-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299220-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63B0F30036F9
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781202F7EF2;
	Sun, 14 Jun 2026 13:23:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319B2253A1
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:23:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443427; cv=none; b=DVLSJoVdvlDQPuvFgAMIMtVX9YHtB1EtYdkh3fVqNCoggTKcbU6GbF1dTawUnUA7ROLvRmDwsm+GF4NpKr+pOcRQe8Ci3pb/2a3NGjy9J/Hfwtm+8oee0BoPH/1TyJgV7SFBP+oU2Nv5eWQC82R+I4TPXm3GYyRq9ctB97vMtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443427; c=relaxed/simple;
	bh=7XgZfgoltE8UQm6ubkiQz7dHUPwqp8oah/+8azjHRPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8n+FjAR6c5xsOxKGysKa+5jKVaeA2DHOmoI3byM6nDzpY1heli0lH5wF6++UNbRzREX06P7J7EHeazutJCg6hyoK1MhZI5RWCTeSs4q6+no2oQNzIqMod11ajqKELnGkJO1inU1rY89V14Z4vpH1La8mQQCgzG6T2H43HFfXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKBGR+1r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sesKV6Kf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781443425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n52zBHpIw2P0e001HAVBmR9pGZfbYJ3V0bABD1aLSGU=;
	b=KKBGR+1rYA+crQsCFNw+oMJin5PqMwzuWQWwf2CvYu7EhO4nlRDhtaKLPVZH5+ZTNci02y
	3gIfdJaKqRDhfg7CdHbvmOFoOKZ5m7cJzBWSwVzdkCSSlEFRT/2zFbmbMAjpdSTtpjPKOR
	iPZiOiyKI2JDJ5MdeLHGk0zTbclQnyk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-i4GRiL7JMJObxPAxraWz4Q-1; Sun, 14 Jun 2026 09:23:43 -0400
X-MC-Unique: i4GRiL7JMJObxPAxraWz4Q-1
X-Mimecast-MFC-AGG-ID: i4GRiL7JMJObxPAxraWz4Q_1781443422
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so1102400f8f.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781443422; x=1782048222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n52zBHpIw2P0e001HAVBmR9pGZfbYJ3V0bABD1aLSGU=;
        b=sesKV6KfKcSPAS+qBdjY7+coKyzFqec0F3S6Cr83sHpL6j0cO9ZsaphcdMF54SI/ru
         eGYH6WC3w8ZZfXz33Thsu0ecDZ7jnrPrjzx2ptfn/RtG719fDqOTe+ItJu11hPIkTFWU
         f7ss6nY7+bzOQR/qpBH8GvPvLnSPs4I8VoLewRYPg8jQvtr0klmFzhqd1tmFeyoiuihj
         8szxf8mO84h3MEm4g1+O2OkH/eJUGJW9KtSHA/lfjezpG9FDKZARGLyGWpMrHgfdhgHm
         DzyXPWRC9ni3n/mfNS/NotNdFhB+4jc6cen14aD/u1j7zb8f7y0/OGt39xMXaMDmNtO5
         n7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443422; x=1782048222;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n52zBHpIw2P0e001HAVBmR9pGZfbYJ3V0bABD1aLSGU=;
        b=bICKVDBhS9HRZtbmezT+mEgxOUwHZ4L4vPrMOhEGPr/aXdQqfs6ySgXjTMvHJ0/967
         iKMhNLdgnW+ImyRMnuUGu+QWetOgufOnxFhYMfK8sLGqm+d/ewYkZhnLbgUnJXOIqksw
         /RhxMxpqxw1Fqn7j65anGBzNUApR4cFuc8g61NbF+W0g1IMklLQmEKPkA9S2Sg33rfF1
         RMVEwza584K5iwAsgyciYKXSdMq6GBzZx8Gt+xhwZ5rzrWvAsGoVOD+aBkvYUSZzur77
         Uf+oJgWUgmBBHOCGzOvfKtky+NhS2R8F9DK89m8Bl1GppiAYquRCQ8nZ9FMKvKTSrMSz
         Ku2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mXT3qgTyswoJfPE6jnJTN/95yINVC1CNye0IewixA/c+6c4oOB4N/252+Oa9r/5z+n+Xt6rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtjM2GvSbdjDCFjuRBithIEyaFftqZYfEaV7OO8uXJfYn6A++
	6Qm1vkClK9pl283I69V2GDGooD9Bft5tzrfMgt1y2dF6hdaTg8rmgMJYFak2l9RME8FEf2xunmp
	lvGwcsBPjoaoSvbbz1+8H0ewLOBxbRfXV2PTubsX1LVuQ5dkxI4i46jh4UQ==
X-Gm-Gg: Acq92OH2I0Prt87qRh5C/FPnN6Bpzrfm18ARhiG8xvX39G30ObbaKogNeviRw0Zu5vV
	JeXfYbU9Qgui4dbAoK4X5IcxrdBB0zvKkVuHkNCpfnugRBzcpTJvGDR+Ica+oR7gwSj1KI3hcP8
	ZY1logV+quVYoQra4L+Q71wpU/3SYhT5+H1omiLLg+VhGQJADen66ZBEYwMcoYLEld9JN4hAS6J
	nA8BhlhvflR8dkmlSmWqF9YGYaAhxsffij8Z+meYFvCT5+bhScDOJBhxQMX2XElodd+7JtRPd+d
	PD0HJ0tN/+gRYxZhPIBxfz99T6nfcispY9rma7JMd51/yz3UjEW70FaBmUfVOuuIxOJKzS6Zmyz
	r08Ex3qBNqU2h0lf3TiNb0bzJUyL+ThX2hMulIeLNE/H2bPKps84+Pjw=
X-Received: by 2002:a05:6000:2684:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-46076b18bdbmr8919202f8f.21.1781443422359;
        Sun, 14 Jun 2026 06:23:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2684:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-46076b18bdbmr8919147f8f.21.1781443421971;
        Sun, 14 Jun 2026 06:23:41 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cd6c2sm24849721f8f.30.2026.06.14.06.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 06:23:41 -0700 (PDT)
Message-ID: <34f749cf-56bc-450c-acbd-df38cf2c09ec@redhat.com>
Date: Sun, 14 Jun 2026 15:23:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 11/11] selftests: net: Add a test for BIG TCP
 in UDP tunnels
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-12-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260611192955.604661-12-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299220-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A1666812A3

On 6/11/26 9:29 PM, Alice Mikityanska wrote:
> +trap cleanup EXIT
> +setup
> +for tunnel in vxlan geneve; do
> +	for tun_family in 4 6; do
> +		for traffic_family in 4 6; do
> +			setup_tunnel "$tunnel" "$tun_family" || exit "$?"
> +			do_test "$traffic_family" || exit "$?"
> +			cleanup_tunnel
> +		done
> +	done
> +done

Sashiko noted that the above does not validate the GRO/GSO csum code
path. It could be useful to add another variant, with veth csum offload
disabled.

/P


