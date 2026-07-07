Return-Path: <netdev+bounces-305423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GqsGMibmTGoCrwEAu9opvQ
	(envelope-from <netdev+bounces-305423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:42:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6384B71B0C9
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:42:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SZAZArHJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305423-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305423-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5986C300E153
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7B3F8ED1;
	Tue,  7 Jul 2026 11:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E063F88AA
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:41:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424480; cv=pass; b=g9fWxK0o3hw/p7qSr04zcKEKM6eLVC3U1NV2GnUP2wcPvZD8FsJdd4gjwBNqg657F5kdu1O3K1F9XDBURl/ORm7sQtvCGFWhifz/HtAKYtVXD6LUjgvqid7ezOQTK811KHsavYrIAFODZrcmBQ2FmzY7TlCVIN/4zD3i12YHrW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424480; c=relaxed/simple;
	bh=OWyWmQEYhkRL90N/CiUZJJ/VwdkL0OU21xb6FIW3tFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPL7kxr9aTV1mj0uWbuBk6I0gp59GnBeybuE6lD+v9ZYAGRdPd3rQ1U/AH/u562y3l/L79Qifke1kU8uvPOaPq3P9jsXIM+BjyuMRJSM/lfO4WxJxoinWtFVm6CJOOec7/uy3y25DjtKDSrtDlS9YCoa9dQx5XVT/Ae4G5I4E4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZAZArHJ; arc=pass smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80814edb536so54258447b3.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 04:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783424478; cv=none;
        d=google.com; s=arc-20260327;
        b=MF9jTr90sRZYqyuRj8YDls1jCUt9WCyjkVl66j8ZampZW56TnXeJ8nUeRggRktSXCL
         j/nBfZcbiTocAANS689FdF/VpvDodk+9Suy6DzzjR771XJYOEvuRAbDVYLNupHTSZvN6
         XBdDYbqI+o+urLwucTE9wAb3ifXb/WzMHVN0f7BEDjsnbpqj26FNBwC+MkjIeuGluL9r
         m+kvvSeZ/LD7CgMrFYrPAWMiAq2ee7S2Bpf52jY8lBaf5yxjE1zq8Udpo3NDNRH9X94d
         JbVZ9Df+ApUxukJgsoMw+UShgvEKvy1mjFkoKWHi4NoRufPUlkqZDVOvQrm0xxgUgOMw
         rEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ItFoCW41RZ5gmudIKa5HNvq1QPMGcjaMoEDjVCrU9H4=;
        fh=STBM4Pw242zzBHccUnmC2gx5mFS8ELkZW1OwMfpw28s=;
        b=YWQOizFhA1KlYcLzfdkSKSllOF/M9w+OwzfJSZQHNf+UIgEi3XqsmSAQsaJp3ANcm0
         mF4jhknaK0KPJZrooE56w9ckI7T/caFnWaEZpZiKt8G7LiUO+Bsw7jxqaUwq42RDE+Bm
         kj4F8UEALX2+6qancqNyqkPumSf65+F7LA7fOfyAKK8ei1R3Trbb28IDFQXk5fPvJBov
         VwuWfIne36WE6UkudUihhjIU89+vaM8rPqIvdHUJcBCqq1IyClHk+d8w0mBloC/rOqSl
         Dkn2DOsxv4cQE0AruCqVFqwtW85Z94L8FJ7Y6vcZyTAFp87ghgBQRbLj33NTpyAyb3/7
         HKdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783424478; x=1784029278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ItFoCW41RZ5gmudIKa5HNvq1QPMGcjaMoEDjVCrU9H4=;
        b=SZAZArHJ9WEO+/vgelNzVUsWtuBYjP51LMyKM1oaK/ccF2ScaYPWI1FQyiFJH0fBgw
         YVQ0M/ZlCJ3rff8hMxuO8qbTh+oUlyIVd98zt3EtjhRpLq9igt6t+Tb5l156A/Oh90bp
         7Yaay1APUYTWNk0CuEH1eT5eUkWfiswwoq9oeamh3MCTb7osAUzlJJmKnK8FLwU4qiJD
         hBGOnEQ0/ZumpQTOR4RNUKkqEOz43Ogi0wWI8ooG5xJmVp5aB+VXrVgcGIOrSqXmRWQ7
         7cUCDij+EfWi1BAAJi7ZZh+8WG/olzc+m+mjzJpj7rB3siJMEwaPSGHajH/AeCpxKfuq
         tX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424478; x=1784029278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItFoCW41RZ5gmudIKa5HNvq1QPMGcjaMoEDjVCrU9H4=;
        b=TkN+w6E2NIzjjoDjtOVl6UtM/Te3dtDan1PUwtyEutiKjOeFLcvgwLjIIZUqfTjgri
         x6GRCPg4ARRJDiJlCckSW+JF3seiTIYp7uILfSUfjpxDFKbaV+wyxHAdjX61nX09fKMz
         nEjnoUGeLIxQ5/QjKf48AXpzr8qDNv0lHgF+gBWV8Ju89i4kk/nAQ/LMG+oJ8fjJb6Uz
         s+FSujKgJ8uff+PFmcccpQVrW1sEUIFBVMEeH9zLQDlknhMX8vo/LSwcndxwGNfTcdZf
         dQ7OKOD8+CERYkFkYR/2mmghQDnGIAr9UXlYcrG//XuJ+w9MCmhocILQl3gxmppTu/By
         D2sA==
X-Forwarded-Encrypted: i=1; AHgh+Rpi5GulVZvzOUmWBN2ouetk4KRpADDvj0HJXyRVJuTJs+RSj5gU7gFL52VI8vTQlHiElbrZzKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04IQYCX+tvtQIkGXQ+RMAHFa52ehUYOzX/kZVnpGVJl3fsrT3
	CS7oR85mgF91IIN6f1CWL8i+x0aqZzA5g12s4fZfSUXPH8Gd1xNQY0fcaU1NkZ9NqkeLqw80PBA
	ixHWOUBOzeOpa+KHg3T4OQpgugMXTUdI=
X-Gm-Gg: AfdE7cm0MnLbrdOL/5M0lP+64G9l/k9FnYUd2ko7DNIjjoEgp0GkDvk7P7r499s4PIJ
	VT0hg+W0+64h7IS1hWk+8E1PE8SYpw3yREZXfKexYZuu8fY/3zXqJJKarCBwknWip6WHn0UQpNg
	lG3J8WiqGWYcR/4LEsTwqoAnxtFCAwZIy7CBEHDmTNY2H7KThTXUmT8FducQ8WlK74OIdEUQPho
	ju+5dBpr1EIv/ybcJJlPqLoSxDbR7MMLntaMA+hIo8y4TZrmNs3zAWiWGAJJmFujiGs7sPGZA==
X-Received: by 2002:a05:690e:1591:10b0:664:ae6a:efb with SMTP id
 956f58d0204a3-6677fd66364mr3137473d50.69.1783424478076; Tue, 07 Jul 2026
 04:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707010622.487333-1-zhangzl2013@126.com>
In-Reply-To: <20260707010622.487333-1-zhangzl2013@126.com>
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 7 Jul 2026 19:41:04 +0800
X-Gm-Features: AVVi8Cdx2CJsJB4o--5Ri1bLgd4xLSleqOu22sj-sKIk8UErNZjebYDhM8mHcHw
Message-ID: <CAPwn2JRWExDmG9s9nkT_kpX27LhzbfVE1J8_tBCAfPcno7Ezcw@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix devconf_all NULL dereference when IPv6
 is disabled
To: zhangzl2013@126.com
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qianheng Peng <pengqh1@chinatelecom.cn>, 
	Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-305423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	FORGED_SENDER(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangzl2013@126.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengqh1@chinatelecom.cn,m:zhangzl68@chinatelecom.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chinatelecom.cn:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6384B71B0C9

On Tue, Jul 7, 2026 at 9:07=E2=80=AFAM <zhangzl2013@126.com> wrote:
>
> From: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
>
> When booting with the 'ipv6.disable=3D1' parameter, the devconf_all is
> never initialized because inet6_init() exits before addrconf_init() is
> called which initializes it. bond_send_validate(), however, will still
> call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
> NULL derefence of net->ipv6.devconf_all in ip6_pol_route().
>
>  BUG: kernel NULL pointer dereference, address: 000000000000000c
>  [...]
>  Workqueue: bond0 bond_arp_monitor [bonding]
>  RIP: 0010:ip6_pol_route+0x69/0x480
>  [...]
>  Call Trace:
>   <TASK>
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_ip6_pol_route_output+0x10/0x10
>   fib6_rule_lookup+0xfe/0x260
>   ? wakeup_preempt+0x8a/0x90
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? sched_balance_rq+0x369/0x810
>   ip6_route_output_flags+0xd7/0x170
>   bond_ns_send_all+0xde/0x280 [bonding]
>   bond_ab_arp_probe+0x296/0x320 [bonding]
>   ? srso_return_thunk+0x5/0x5f
>   bond_activebackup_arp_mon+0xb4/0x2c0 [bonding]
>   process_one_work+0x196/0x370
>   worker_thread+0x1af/0x320
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xe3/0x120
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x199/0x260
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>
> Fix this by adding ipv6_mod_enabled() condition check in the caller.
>
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
> ---
>  drivers/net/bonding/bond_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index e044fc733b8c..522eab060f9e 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3455,7 +3455,8 @@ static void bond_send_validate(struct bonding *bond=
, struct slave *slave)
>  {
>         bond_arp_send_all(bond, slave);
>  #if IS_ENABLED(CONFIG_IPV6)
> -       bond_ns_send_all(bond, slave);
> +       if (likely(ipv6_mod_enabled()))
> +               bond_ns_send_all(bond, slave);
>  #endif
>  }
>

Thanks for your fix. Next time please use PATCHv2 with a change log.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

