Return-Path: <netdev+bounces-262162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBlgM2QVo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:18:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA91C4403
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA7F1304522C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9412C21F8;
	Sat, 28 Feb 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APZNAHS4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F531E8320
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295521; cv=pass; b=kseGWV6HIGazQo5Rcdb8Ne7osiFm89A2Fz8F40XZPKrY0hW/w18ulIZd3S6SKe/iwhMKrkllISU6PFDBV1nueDdVED4wjD7ET84iA3o2ElUI/Miuo6bg+4IktI/aFAE5h/TYEpsIkwvJ5UyMHZ49NTZgRLIGY3Zn9/7tJ1hSDmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295521; c=relaxed/simple;
	bh=I9Htbx8YRVVx+Dh52aFuMPMJhCx5RZLrSa99pcuLQsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dl3l9/k6Ar3fuwdotE+eTlDphHIAcd6s7pS7DH5gLd37FGDmKhODhdo6nSftyuOBflCZbJclHB9+HKSRWgn/my/uh3Abz/xQpXqkpJ8CSSw+v1Do2NH8fdLQgnQ5DLtzn2vSAePi87n5nq60qeQbJCQog29TovTUeQxlavcqRq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APZNAHS4; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-505e2e4c35fso32222781cf.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295519; cv=none;
        d=google.com; s=arc-20240605;
        b=Er6fdg4hshPqK0Ldpe202eEwXmN+8WGGeQEIUWw03lXMA+AnlXvcGTDlFm1CTcVa9N
         SDP7uVhBqwxheegrn9rXgLR+K0snBmj/I7vG2xQoA2o6r7/HlHD9rx0GPAtMseBCy5kO
         3bhN7M/jtltr3l6LgZP6OFt7vb5gmsZGxZZVYVopYaDviIaoH/iB1y3dliSLGaaBt3ET
         +X0JyhhfXbwAshK4CELMtDYXTZeowdZIaGwiEIKVaHCDWyTfYGNsMKE5XJjCR2vZxftN
         WiTNDdvpj1qxwf6X7XLB4Hm0zWrULVARJ0//fegKPLp7M+tvbQlmFNE4cS60GrjxDgg+
         LtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9Htbx8YRVVx+Dh52aFuMPMJhCx5RZLrSa99pcuLQsI=;
        fh=xyDzLADwYBxsgQ0Mh+Q/4WZdUYRe1BiJ8aQnFcnlzs8=;
        b=bRlgdHIHX4LWhuNqNfINaxL1jSDI66t1nSAfSrEmfrOV+d6+eG4NDGDI6hR8ID+aIO
         SWNDyIz1IjuWI4mJJ5tflllPKb9Zsb8yCtUSTjChUk34FaC8itVmvBW7DkNKce6YJ+S8
         MNaxidDbdbQ/eh3RTnldVnKKfzlgNah0+6tNRuRNvKdj+/EvW6xTVW6X/frs2ABxc0Iy
         gnfZ1F8A0ZK6SmSm8nuiLvZTfRo7k6aNQZWopFj73L06SPEYIm8lnU0k9W6f/jyrFojE
         oXLTKX1ZCHhdSW/xYhZK+LLjQfwOoz8UN+XsKUkywilEk9zsrrFTqvrggzLHkFn8H5SP
         Zchg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295519; x=1772900319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9Htbx8YRVVx+Dh52aFuMPMJhCx5RZLrSa99pcuLQsI=;
        b=APZNAHS4uqB+bO7Tx9dscAXKO7HVsniAiEssdKG6B9QUezCckLH7XLJyxbAg7e1eug
         DRuyyHTiSL9G8bOYIh07IpNNpiSTaKIBvR3i+WRS7dQQB5ry9vMkuotOqivwe5oR8y9M
         JGJPA1zi+iYvEDShNcC+uCGooFghxYa24W1xkKI6NFHzY7APyEwH3sX7CGJVMuCX8OZZ
         Um6ZpuZ7XlkygF2ZjfMU23RjFZgGXWQJoB4rpuXXlbe/ZXx5kx7R2pf4qLoPk+hy1Uu0
         t2Yi1pcMDGma8gfZKsk5Yk41eOcMM6RZjXO9oiFCro/cfsZ6GrwBFB9W4TlTIpx/+Zdk
         U+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295519; x=1772900319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9Htbx8YRVVx+Dh52aFuMPMJhCx5RZLrSa99pcuLQsI=;
        b=v7mEb1DKlCocga6uTWQ0cfe2NXt2ZnN1r0chKQT3PBzeoYGX8cW7ROYdm5P37VUPHt
         lzhE8GFjTV4FQaAX5qrMnUKMxFa+BVmtUQR8QHfSdb3Nh5hZYIGvQzIUqvn1JKXOlOp1
         bCDMA+BHxiudg2OxINLsr6ibrQKfry4uLencnnOmB/1KMwQkep4/eiE9C8bL92yWErLh
         rxl18Yg4lONhpYcvpKa8DzNRpiVV0fAAtysfoF1GYCsAeAg0puPLP99qtMH4qnOw/ZGV
         eTydGfzHy5gDJ3lY4/l8b2lTVntuHVQxjMPCy/tuaDuC3B0E/G3osmwVnabTdw776Hm7
         G6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5jhTv4h6iOPb8nLVjjNzO7l7db0UtoEfVsoAST6KL1t1/IH4whJ4HamH4LsU99hifRlEByNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJDG7rs2QTHX4qd7GYmIC264vNNA9oVE1U8gsVYXxk9nBrMH+
	fHTBya7bZgfNienJDKUXjhPsCc8xA0sv9js8SmP0wim1+UvZC5L1Fry5ko69QsB2ljmcuWMlFgW
	xKpLC0w+NXZiZeGG5J2byKWL+KoTEPAMDmvkMb7/D
X-Gm-Gg: ATEYQzzz2hgX7h7dZIYyQI8XDK8iqFM3y8B5v+gMep/yMropMFem9YqYLgzAiX/6XNo
	M2i/1JxteH5V92gKhJGK22DLCg7Y8EEijC5xnh++WRHPRg1ukH4Tewn5FndmaJX2+tRiOjCMM0p
	SMigj71wZk0hc7mN0UnBq6CI3A3qqSscHt7fjwezoFkY3rmZhfHOs8YozqMmmKEPyoPW7+WzB/p
	mHzLGzLtNjteC0SB8uxo4wNdHx6Iu4zyF/PeISexjEQzuvO32p9NWrR6gbuJm7do6Ik2bWkoKUG
	0FctDsmE
X-Received: by 2002:a05:622a:53:b0:501:4e87:70b2 with SMTP id
 d75a77b69052e-50752a27e4cmr82086171cf.69.1772295519131; Sat, 28 Feb 2026
 08:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-11-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-11-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:18:27 +0100
X-Gm-Features: AaiRm53-THVLeNa862adc1hG2LMHAFLQmMvhDeycacx1MmbIb-PHXQvRnRxxt34
Message-ID: <CANn89i+5+k__yYmpON3pzCKbeDYrAiMtdpYOKZbtHwSS_FAiNg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 10/15] ipmr: Remove RTNL in ipmr_rules_init()
 and ipmr_net_init().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262162-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 16CA91C4403
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> When ipmr_free_table() is called from ipmr_rules_init() or
> ipmr_net_init(), the netns is not yet published.
>
> Thus, no device should have been registered, and
> mroute_clean_tables() will not call vif_delete(), so
> unregister_netdevice_many() is unnecessary.
>
> unregister_netdevice_many() does nothing if the list is empty,
> but it requires RTNL due to the unconditional ASSERT_RTNL()
> at the entry of unregister_netdevice_many_notify().
>
> Let's remove unnecessary RTNL and ASSERT_RTNL() and instead
> add WARN_ON_ONCE() in ipmr_free_table().
>
> Note that we use a local list for the new WARN_ON_ONCE() because
> dev_kill_list passed from ipmr_rules_exit_rtnl() may have some
> devices when other ops->init() fails after ipmr durnig setup_net().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

