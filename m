Return-Path: <netdev+bounces-283909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCYnNFK1+Gm3zAIAu9opvQ
	(envelope-from <netdev+bounces-283909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E014C05A9
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92331303E485
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225923DFC82;
	Mon,  4 May 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p019Oz2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7E3DF00C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906637; cv=none; b=EUiI7I7UWqbKqZn5b0UV4VRUlAeX3qD8JLSwaHuwz/iAM8R9hmG9UwWZ1k6tb0ww0eEb5vqSw036jKI1jSbalWDLh72AyNSnS3FSc5Eb0wUvWIjJtG9qTXfbNqqh9SHjhyZy33ClhnryfaOJWwkr/QA7Cck1wsO/KNvghGXm2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906637; c=relaxed/simple;
	bh=P5AYiYaexfBJ/K3fA1q4qvJtcqVqhbY/zXL2LN0DYa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3RIiR4NAK6/pFKukswRVFYpWW4qZpKpkqmmL0e4fuGab+SufXT5jKhcTxCJ5w82kxMrq9PbwSenB2z2WoazZnlejXfSKi+4c4xCucg4vGwd1DwLjVIobEGK3XT7Y7w0M69hLbDTiAWVHt+W35yIrjoxb8Jjbw/6pQcBZrUFLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p019Oz2N; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-835386ff122so1479641b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906635; x=1778511435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh0KAxFwMLTC3nMk85f7Nx2m9dqehymzX+YJyU/vwmc=;
        b=p019Oz2NBulotq4MIwmCpXzzkkVVu4GlXxiNtEqqBBYSVyt4mpaHOy8OXvZwICcpoo
         l0NmA9V93kSJ4Dc8aHE/X5B94LTvy1liXHZIM/YQ07oQtZ1yHhfFm0GH2poIhk/AX9TL
         7qptPDVMu2fXehJBEJYKQZj5c/cp9knhj5SwxWi8CArCWzdLOvaQTlOQmVeFecte+YT4
         nxhHtWJ4MUsxMZqymQ4F6RyJsvPf5BTQJciJfDfTxeG96CK602NdDqSXmR3nPDzaw80a
         umDIwoeY+q+Bj+MK1kEg+j3fBGlkgprYtT609vYYB70d5kgHiFi8K3IGfGFpPXzllX19
         T6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906635; x=1778511435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh0KAxFwMLTC3nMk85f7Nx2m9dqehymzX+YJyU/vwmc=;
        b=tIfzRQuCq2Qm04TzaakzMA1OY+abOOlgiHlYAebbq1c0MtWkdrCkPdpkQUHvmVrOJS
         vukUzx4pgsymdnzZvk3E4aM4vj131gfJPyurFS8VzHqVfsHjnBzazOsCRmtH1Gel3HZU
         McL0ZoRY/6g1zcb2zZClW1YsdOTf+auQZW4L3ldtYKgDxoguGUwqqhxYWpSsg4lsPSFl
         K5ckbyPvkS/4WZPyXnIduIFFcapEFlXzyD7I5tqnJJ7uYF1bhbzNI3tYuoV37ZKEyDmO
         cP5UtkDhBz5PT14cgUrZkdRSvU3fZDNhUg3QcJLHojsVrqhb14zVxmuMRgFgrGDf0NZj
         avvw==
X-Forwarded-Encrypted: i=1; AFNElJ+03uCDQ3uJjE9a7+2tYYdavmeMt/5nrmjweR4AhHzo47/C2SFkl5oIMw9btnoZH7pj0qERS24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxV4dVAQ0fF2l9BOQWTAkkKrsMo9JJxbxfSAS7xqgTJIBuvYI
	/hSsUurraI2dHht11aSdkFX+m468WN6eXTGcCfJ6T203cVoZoncz37OG
X-Gm-Gg: AeBDietYTGsNWn9mLtJiqMojztn3wAq9WOmmVC/Ef5fDXtz11u8Go0oCmusdnSqVhT1
	mhb+F4/KdSndrSZ1KaphhDUPqWSKUyJxvwWi+wtpDBpwnnU+XNJFLiXxUMcS22ESjXnQPa9C6G9
	ufWKw66OY0jIgV9zCdPdG1v9lt8Gi+6whcvuL2vA7q3/9wq18R+JdJ09s/dRliRLyZ1T5ZE+zOa
	czH2khhK2RbKfFcGrJ3agn56QEO0c9MI/+3/rtN83wDxO0yB//lsUzU+eTSMV9PNPwwnQ2dahjp
	VaUuZGJ7TNNRLhHci/LtZAoypHTZeqY/jyeJfG+1z6AhIFA+rv3dV59hGLbgtmXeqVa98b1D+eI
	qqN2SFIcu5QYymO2Brksq8MdehjkPkdRvSAsmKJOzUBq5z2HrtVq8ZT5Ep1eOVMPvSaG7pO56of
	fRh7NfQAGcQCGdDHnoLVibhfowdGY=
X-Received: by 2002:a05:6a00:a1f:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-8352d012d24mr9616412b3a.10.1777906635168;
        Mon, 04 May 2026 07:57:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837aa3e4f30sm3467508b3a.1.2026.05.04.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:57:14 -0700 (PDT)
Date: Mon, 4 May 2026 07:57:14 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/3] net: selftests: add getsockopt_iter
 regression tests
Message-ID: <afizImGChdnDsj9S@devvm7509.cco0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
X-Rspamd-Queue-Id: 30E014C05A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 05/01, Breno Leitao wrote:
> Add a single kselftest covering the proto_ops getsockopt_iter
> conversions for AF_NETLINK and AF_VSOCK, using one fixture per protocol:
> 
> netlink:
> 
> NETLINK_PKTINFO covers the flag-style int path (exact size, oversize
> clamp, undersize -EINVAL); NETLINK_LIST_MEMBERSHIPS covers the
> size-discovery path that always reports the required buffer length back
> via optlen, even when the user buffer is too small to receive any group
> bits.
> 
> vsock:
> SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path (exact size, oversize
> clamp, undersize -EINVAL).
> 
> Each fixture also exercises an unknown optname and a bogus level so
> the returned-length / errno semantics preserved by the sockopt_t
> conversion are pinned down.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

A few nits if you happen to respin (or for similar tests in the future):
- add ASSERT_EQ(optlen, xxx), won't hurt
- christmas tree (although not sure how much we care, you'll have to move
   optlen = sizeof() assignment)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

