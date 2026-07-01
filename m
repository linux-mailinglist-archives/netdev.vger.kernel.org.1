Return-Path: <netdev+bounces-303860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AxGxDcqMRWp5BwsAu9opvQ
	(envelope-from <netdev+bounces-303860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3F16F1FB9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eDKlw19a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303860-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303860-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF65B30210F5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA83BD65A;
	Wed,  1 Jul 2026 21:51:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E383A5E88
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:51:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942682; cv=none; b=KjK41cQECCQH14GQxuz0DBbtanwr0Y4Vb0AKLAX25N5SeUiCWJVK9yNfPM5/tKDtC+r6lGAsn+VwZg7bd0ZnwMhZO8CyPJT0jGOG6zWbir28rnYkjw/OZUybPWkxXVDFCdMtZESdJvd+kInBQlKPtzpDmRafwBUM3XWwFfBgamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942682; c=relaxed/simple;
	bh=0k/L4mrFt2XqSGLGWZRN3iV90KhxUQkGyJHmQilQFfk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gMKrvw8dS1az48j/mZpJIezeKnK1OdLp56D5+6Ct0Wp7Ka1dDK8pCL6UnlhigR2r6sDkqixJ6sd8/LexX3F1UZ6BOWx0rKnu9hZm7kM8ySG9bgRGna5gUiLcMXPbOawQNgiM7LP3huVSmzG9BI8dpjPh7vc9KZsX47QTGoRSUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDKlw19a; arc=none smtp.client-ip=74.125.224.50
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6651bc57458so926559d50.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782942680; x=1783547480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T74aVSqrgVA8muoQOluLCkwY8h43e3yrgKZJcJIZZc0=;
        b=eDKlw19aVak72Hkp4BTVMsZ2duQ2qsd+SXnjIzCEgYkcqw8qyxG5AoKNpyA2lPIQbK
         dpnYs2Qp+DI3s7Wug5sZMSdZz3PieVKERc2VgbRqUJeqBcpwlpG/dfgOKXS3w15nQsxx
         Dz0RSUfTVRF18+xljta/g66RQ5UVjn7axZp6bcFH6nCq7KzifNgb3gWzodd0m9SiRx9O
         Rp9wvu/1FOMX1ZtOb7qoVbQJ5dt6IllkNWat3eBXb0BFCMPGre9/FvIwjbKq0A6/tGEz
         6da1WWyn7mwQi//Sf4qaKX/ldbJOvfHyyv+iZ9B5RghWG8UDiaPD5DDiXNOTFR0P153Z
         5XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942680; x=1783547480;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T74aVSqrgVA8muoQOluLCkwY8h43e3yrgKZJcJIZZc0=;
        b=NhlkDdQGk3oOl3w2IttE+uQ69RNIMx5hLI6PgTs+Fsl0h2S1/NnyQRHfpcZNbrP0N9
         KGH4Oc5bXqEPJtRbGu3dHwVM6hDbwUsMg+gfHDCCcBWqyKjrcQTseNZcgABhc9RBoSPy
         pMIgkM2/HXTIEgDoahgVQSRHZaUev+tT9N51/OHzlOQpev3n3lVNc8VywUwdxlnMVoKS
         Nogm7bogaTT2EO3O7aDyC+zh5BmXnaZDqpKPT68bJciAeZk4ZTlkkhMBgiqxEltol3Wd
         IF1oxv6ytxaj8BvQiUhGBzmxoGZ8GaweIrT5I6XtV0t3S7AQ+7JjuDA+69xLtnZefB/e
         k+Zg==
X-Gm-Message-State: AOJu0YxhJxOKVcugzLmyDvHpGYgIxuyFD4sy+7zdUBFZPmPGznaz4WjO
	O4n03rNW7PF6CNiUyFsnZgeP1wa+jg86ToV/GvjRQnXU3dfPiDL8NfZ4
X-Gm-Gg: AfdE7cllT+ow7m5BDmwLO+trFGG1A+l16vUp8JKv/GNYgCs8Qq7KGsCypo/Mf7l+Srn
	w8xnLwMBFeJvb0/pb4mXgrnedj5+PA6uR3SwdnN8GnIO6PxPldpHQoavG7yhuWVF5zP5/SmZC4Q
	8OEYmS2rDlGkj1tPCq7F0GC9EgsDiXbaQGx3pChIrM0lBHt7ulgZpc4xAO8WV9ixDIFGb3EGwvK
	T5SIhVO5trzBa20EJIhkCGiAo4lVbzCRdbhrVUQPETLwZ1yZnNnvWdYSx1NedESJXHOfrPjV7SW
	Wx/2arpn4kzHcNjKltY0iVLni1kmE5CNfvoDgBztWMdmpIvIjuCVGg0vsmNw3ejUqrD2/uY89+j
	QAclTdtRVLOhdr0ksDMKdYzfGZODbOQTjE+5nAnT3TmGQjfbNwt7jnWI/AXuNb3uSmXvmMsrn0Q
	HZWm4QUSamZYMrWYzucctovW75PM4Q82mRrNKxCEhwM8hIsnpLSbTTi6/VHqQbTbB9Vw==
X-Received: by 2002:a05:690e:1181:b0:664:ae6a:eeb with SMTP id 956f58d0204a3-6659664e507mr2523260d50.73.1782942680377;
        Wed, 01 Jul 2026 14:51:20 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66623df955esm275466d50.5.2026.07.01.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:51:19 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:51:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
Message-ID: <willemdebruijn.kernel.3788f4681060@gmail.com>
In-Reply-To: <20260630-getsockopt_phase2-v2-2-193335f3d4d1@debian.org>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-2-193335f3d4d1@debian.org>
Subject: Re: [PATCH net-next v2 2/4] udp: convert udp_lib_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[debian.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C3F16F1FB9

Breno Leitao wrote:
> In preparation for converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, switch udp_lib_getsockopt() to take a sockopt_t.
> 
> The thin udp_getsockopt()/udpv6_getsockopt() wrappers keep their __user
> signature for now: they build a user-backed sockopt_t with
> sockopt_init_user(), call the helper, and write the returned length back
> to optlen. The helper uses copy_to_iter() instead of copy_to_user().
> No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Willem de Bruijn <willemb@google.com>

