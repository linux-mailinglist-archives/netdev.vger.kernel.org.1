Return-Path: <netdev+bounces-298474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2xlQEyyrK2qmBgQAu9opvQ
	(envelope-from <netdev+bounces-298474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50173677037
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=l6LAupRV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298474-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A549C31AC3BD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC63AA1B8;
	Fri, 12 Jun 2026 06:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2055365A1D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:45:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246744; cv=pass; b=RwK/6dte4r7h4MgZha4UCE70SKsCc9q+IxHctst4aevFfl1KuNnvvURDZ9p5q90ttUrTY/tsiN9hV+9b8mP2WFoG1vn7QcIvtp6shY/KSpWWfHrlxlNQ4+23YparZIbWMzkHCL9wWDDXxmp9xGc88VgcKiT64J2Kdlz72aPc1jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246744; c=relaxed/simple;
	bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR6527lji9RSXnW0kwlLz1Xrlf31RuU7tQlYaqvYMIBYif4kz5o18wvwPFah001moe8Mo+Thp0R1Mh/K44PIj5sJQ9p6THZNZYwiXbOs3DDACK05D/8CBArFZVBymO+UEWR3RkW9vtDEc/nV6YMowubT30nRsi7CjypfAOcAi0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6LAupRV; arc=pass smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137dd3af345so577081c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246741; cv=none;
        d=google.com; s=arc-20240605;
        b=BFAF8FcEfzE0OT8obatVrACR4THPsPq1qYxh+0G8Rq1k6M7iYJ88MN10VAFClVk+k+
         vs3YqMLT296+4rAbQG98MI1MgJq97QbBsB/R0AuXfQY39FCs0qJV5uTI520LGnljGvJi
         9LRyETLuc/QkBUspSo+9SQ78XX8OkRmJZMsw7CzR4G0iH81A9N23vp6SJsCTz4v7wH5G
         2E0SQ1A+HFrLFZu1Rgt4nK0YEy16CmAmOwvzlJq2QkOH4YEUwz7orOw4xhWKAkjcLzSu
         fz1OdbICDTKYyTA7atViQNrtl9SlEEX9Pvx5PDfN73aFkqrbtu9QfKPARALteNtL4/Ai
         /MWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
        fh=zU630Zpd6/1drjE0vTnj+BpT65wOqCe/lp4ehfS9DsU=;
        b=j+sv5f2tzBN9GYwpkyQZjqT50awAr/942l24V/4aahGnLCKJqdrzF3/9e8NWdyOZF6
         JK/qCUdOlw9YIyo8zGgHSn0VnJJmiA8te38Wp40wmONsdeQHBKvlrz4t20JMPSw+vlxB
         OpVmGdCcjCkuNH4/UFSH9UgBil5WaleBgIi9/Yl7/XC7aAaBpTuq4F3+TuRsMzS8ybt9
         ZNjZQZiwKvK2lLnp49T0kHW0K/W7V+tDHLcx+oKkWdfViSNZDWDkag54WMD0Y7nLnzrk
         Fq5hc4AH71Oso0AkqYvL9GohH07zvi6ah9Dy2aH9zIY5sPfdrjk0YbwuYxsT0VwO9b0d
         EUEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781246741; x=1781851541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
        b=l6LAupRVSl2c6T/trhMOUfkI+N+NbvzGGEwMG8IhUjiS779OzDaSM6tPKhYrL2mnEt
         tk+ETpORJf0bij7SrL9Vp4vQfkGh3WojWSuSZMyd6FmbksAVQZAfto6i5y5xCpmVwsRE
         B0ptRUfV4VpPPeoXDAm1/FTDzLwfXX8N4Qle3Xtz+5YYQfh2AKB/DHLemELOCX+e1+tq
         siPED2aPOvJWhHHecFzZPMlLJWsF4qFFGv3SqUrZrZhtQRcaVFG2HqwXhfKQfrFe+LvG
         m/5FZg2YwYl478MxUufGkM9zIG1DCCNSBljxU/vzERHFQn0/pBt2wPKg1h3qW2nJh0Pw
         wMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246741; x=1781851541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
        b=C7gocg5wnUnlqbAPr2IVt9B/6AdegJPl68CDnZd/XDa6lxhHOT19gp2/gp8ulNu1Ti
         b9J+qgbS53kLRoRPc95tugu78JBsERCrBcVh8LrMgGnoTzUfIEElMfA/3ckIW1L9PxGZ
         y/T8Ip6C6Ywrf88drVEU+7iPcp/Wupl8A9wvFXJxmVQr1yl5NXFiatkfmviaFtfb1vGj
         qFfh0ZFPJAjQZSHWGkN+777DPmXD897S55+GCMcZLkJX4m9H//6PHcwzol7KneISEm1F
         Y/gmc00zeE2db14xCJWdM1VlZIeCPa3zyiQClyTqPcEoHQIMfrHEDn58QP1RebecbSn0
         7LQA==
X-Forwarded-Encrypted: i=1; AFNElJ/RDEFjjibjgvv/th7AR0GgMgSQ76Fs53VDcTRnoGeLVOn2o/+qFeRliUF3wjd68myeZswwX5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXSWoGpTfeTqhw06DQinyBwQksKv0dn+lyYrFOXk98U0P//rx
	uGSGb/q30Fy30vOdDxbOui3ybvL2Mlo3wRZXYPHO+XLlYq1p+pCSd8MBKIE0b/MDDF3KnWev62c
	zpKsdLZild651jI6qnAf+Qs6wwG42jbaUoKRJkOKI
X-Gm-Gg: Acq92OFrGJL2zWteLYIcQ1vbz8Av/5zxec9JAV6nT+mQAlz1kLug2IaLnEgB2R1XiZX
	KDrM09fWRuOgorD/uF9TxhiookjIjI/2MriKqKDSXDqyLSy0qhN14+akDjV4t3pNp+tBfeylqeU
	Av5GjQJtTmyG3KqWFd5RbZQEKOydNIBE25xABTSyx2yk+K2WvLj/x42U50mmvDKRYK4/Q9QlTeg
	JxpQS4rYCw+MuuZQ2Q1kv9AsMGTmjy9liqdGzjHMRulRtf0zg3Uh3K9I5/Ep8t/6ubOHUuKgfa7
	YHSPsCg+g0Kjr+5lpzm4DFbYt1YrfgMFTQGk4FQK6G3HU9VMWk3FwwptzirlqiI8osLOndXm094
	ec+H1+C558uRR1Qe/FEsGf+3rfVP0/Ceb9/MgehFAGnUruOAvhfON
X-Received: by 2002:a05:7022:5f04:b0:137:ec94:b487 with SMTP id
 a92af1059eb24-1384bb877f6mr373348c88.30.1781246740207; Thu, 11 Jun 2026
 23:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-3-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:45:29 -0700
X-Gm-Features: AVVi8Ceb_WszCLrvRcLCFH8FpJsAV2LIBVuQJNjjqU_Xa2Ev1Ja5-d4kf85ySDE
Message-ID: <CAAVpQUCL834OQfOWBmYnAGHNtrKhecdm-_qK5F8A9uyQ9cF=BA@mail.gmail.com>
Subject: Re: [PATCH net v5 2/7] net: ipip: require CAP_NET_ADMIN in the device
 netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-298474-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50173677037

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ipip_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")

This is wrong too.

Fixes: 6c742e714d8c ("ipip: add x-netns support")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

