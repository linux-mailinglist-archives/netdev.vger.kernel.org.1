Return-Path: <netdev+bounces-298885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /mcWMr68LGqxVwQAu9opvQ
	(envelope-from <netdev+bounces-298885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:13:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559D67D83C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:13:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pZmBJ8tb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298885-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88D1A3013616
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CC3A3E7A;
	Sat, 13 Jun 2026 02:13:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768E39E6E4
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:13:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781316796; cv=none; b=LyfTHGnM9saItDXe7uEjdS+TO5owhmWGG11fWIMoEmInncEV+jAHbTeMl2Yoo1HvLWUuq6GCTfIz/FOHpzvkcLXn51yyk4Nhm1IXZjPYi34AjdDd4ITZk44vxXi8kd3n1gEovHh7K7pBp8yNMaiW6XEhuQXkY0TCUu+IzDdSyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781316796; c=relaxed/simple;
	bh=6cmijRI5V7P9USb4+x1RRVJ2PCaIYvLxOmNSxNpMftY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JSuFKvoUKG3dSzzdI2+fqeJCmqto0tsoM1e+6+mI8j+/hyKVRwW17boGDq9SJ4LAFa5vU6VgOw5dwEQRagwaUvtxv5QtTej1glXsELT6YNmUvl5SR/dj3XvYO+QPrXWcRqCyxwt18JuE8TJgMYGijCAxlkjvYdCEtjZJQxSQVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZmBJ8tb; arc=none smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e8b45dfb3dso20324327b3.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781316794; x=1781921594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjnB0IRIF5mo49HLDOpqQWrW5AN9ELBnpM+0ifgLB8s=;
        b=pZmBJ8tbii3ukivutkXcOPmVPPQbA5L92wDAN/AByE7tlquxk90AmskL7MvKvFIRs9
         2E5qQXRtAvuBbQs5lwajUqEZdGdGyr3lCZYrOksiaNy16mG8d5RH8S5G4zLm/TswSLqc
         kgLjcPU1xiBjjUenJXQZItnPXq8uD3dyBYBiz7Vh51hgatxK5flOQ5vuIxqwt10sGSvn
         Wz+CLC6nNLXfgJR2CWZOkNt/cvgn1TZjP/+wqF8CVY8LNlduI6DspWCrYlMYQbI8+sn/
         B2U6ietQXoYEATJlj/x6Toa2dLmvDkJqVNi9lMdsv7LXmJqh1TAvPD5L76QitxR0hMx4
         5hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781316794; x=1781921594;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjnB0IRIF5mo49HLDOpqQWrW5AN9ELBnpM+0ifgLB8s=;
        b=rtXtO4CvR3bjwtJrgqaOUnFJh6BxUBBSL7PYRjxP0AdMaJTdK7BUtTeCVdBqE1+JY/
         epmJP6hfkXEOAvCTD67D/W03VfHrCILqUjcwVX5opG9ty2xBZKzU7xcbXnk5ZQnKaW1B
         7ybBXG7CnYB79P5wyYIAiWeW8X5M2k5iqBQegIgD2cTqKeUsUtLtYqvXUdX7j1UoA+nX
         6XuyDsBHslRW+/gkrKE2HQ60je4KVlB9ZQ0UoS4mOA4LWISJ6bHUNYhvay3c8/Kymi20
         G7Ho/vb6BYCUDcsGzW1EoxQRejGcSMHMCEJ0yWaOIx61sYrDMMuRpSyPDMyCCRCBUhyW
         ugvw==
X-Forwarded-Encrypted: i=1; AFNElJ/Gs+zuY3ei3jwBbLJAaEaB0OC1g1+JZOevIoWulgjsRTjEUysQF5VTwCsPYXI7denC9HmhrEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyWxc4wc9pRWVEnN9Juw77PtTW8rOAT64kgkdDu90QIgr8McT
	ahelThKIyZ9giU6pWbcx+7Lxz5Kij+tmvB5trCVAObkOpQ/dajINi9us
X-Gm-Gg: Acq92OEG28Q9XiqTeycUZ5MRKJNnUOJ9/OCY/ZX4WArPAky+9pRAk8fMubiYpI6neF/
	CTr41awq/10C6dXNXRB3sHG62SpY9v9DzxCLogKfPt36mA8CS+opHiKG2zNtTvu4k4rsoMm9CLf
	DueognYTuW1XhszqhWZcx1EeiASfazOM/vrGxHas+jWstjfatNuDJTq7pVofk0CYCE2WBILbiNp
	MGuoMosg3LuoGJ8/tN/PDm+XdT5i8YRmYRmacjJTotgdh3WSFijqmQgXJJTr90/nzHP7jIm3eIw
	ma+SMFMDbzs28wrYSVhkuKuMlH3VDVPpt6VLUHaMSapGIWr7BelHlNJZnHzA7l7gfs9kPOyOw0B
	AvX365nXvGPgEaKZTNh1XjHPc8mAmqDoHq1KiXgdm2OPpMYU61vegyUMQp9yi6607ZV0SjFXRNZ
	ol0Cb3iW1IPXTW09DkFxvm/GZc4YkSa4Y/XJQrMo+IspR3QRw/2ya2dq9tnBlPm3/kXmbNgzHju
	DW7JZE=
X-Received: by 2002:a05:690e:441c:b0:660:56ee:ebf1 with SMTP id 956f58d0204a3-66284e68df9mr1616587d50.22.1781316794269;
        Fri, 12 Jun 2026 19:13:14 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274c675f6sm1955578d50.5.2026.06.12.19.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 19:13:13 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:13:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team@meta.com
Message-ID: <willemdebruijn.kernel.11beaafde34f6@gmail.com>
In-Reply-To: <aiwyvEbSHLHKNXBk@gmail.com>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
 <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
 <willemdebruijn.kernel.26a37316bb5e2@gmail.com>
 <aiwyvEbSHLHKNXBk@gmail.com>
Subject: Re: [PATCH net-next 2/2] udp: convert udp_lib_getsockopt to sockopt_t
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298885-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FREEMAIL_TO(0.00)[debian.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6559D67D83C

Breno Leitao wrote:
> Hello Willem,
> 
> On Fri, Jun 12, 2026 at 10:58:19AM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > In preparation for converting the proto-layer getsockopt callbacks to the
> > > sockopt_t interface, switch udp_lib_getsockopt() to take a sockopt_t.
> >
> > What is the benefit of this conversion?
> 
> This enables kernel callers (io_uring, bpf, etc.) to invoke getsockopt
> directly. The setsockopt() conversion previously used sockptr, but
> Linus objected to that approach and suggested iov_iter instead.
> 
> For full context, see:
> https://lore.kernel.org/all/20260408-getsockopt-v3-0-061bb9cb355d@debian.org/
> 
> > It does add a lot more complexity and makes the code less obvious.
> 
> I agree this adds complexity. Unfortunately, I don't see a simpler way
> to enable getsockopt to work with non-__user addresses.

Oh right, this is already applied for other protocols such as l2tp_ppp
rds and smc.


