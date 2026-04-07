Return-Path: <netdev+bounces-275959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FqqGgft1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:39:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E223ADD31
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E9E7301FCBA
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A603AEF5F;
	Tue,  7 Apr 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meSPw4ID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFD3AEF36
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561978; cv=pass; b=NBo+YKYWv5mOdEZnmNL/+iAJ+8Y/U5OEsQn6zAL/SuqzX2AvtwUN7sDcy3nUXOfuCtyZIFhCs9BEadwCtvKdf6lt1+iehpeGkcPqLMBYNk5ysxHiXX89FpOWY8tCIosh2mNOerIRcusoenmeLHLxr7hH9YqQJMkqdQbFxbqa0A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561978; c=relaxed/simple;
	bh=Y+L391ccTop7JAEDFPHSUA9TtUeK9eR43E0B28a0rmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea1XS6TsDCOwedIYVLohw8Wq1/GME8AQklBgJkHjIpVASglvBS66PV8UZJtW5gjOC0uVdy2/EqJwgMmpRmhdTpfDHCQ6xTCbro1fm5tAUJaRJC4S1JglReT+JPp+zaVfsrGidn5Q43khlDjngrRfUr6apseBiq89YDIjyH5i0X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meSPw4ID; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a58057d7baso75465496d6.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775561976; cv=none;
        d=google.com; s=arc-20240605;
        b=Yafygrb0mlw0y4MT3/XIBq9OsfCenz/OCdiVi9Sw/Nm2hjQO59P6wYF6qpWNuc0tHG
         PtqZOq7IyfSNzF5uqO5Wezq7ezVbB0BVeKFWx7zFGyK5IyI6l+uf94XGvdVkDFOyxUtu
         IX8C67qEsqIIH5hI91o8FWN0Mtk2svm1iFmlk/7F7WoOPvH3qrh3iX7dok1ZS62Ep0T2
         kVTsvhgbEr27YJdgcfxp3oYV5guAzVTgrA87PLIFxebUmEt0XPQzYKjN5P2pRpViEAb1
         ghggO/w7By0Lx0MQQocJty2ozYMKjTQQQmwMkfHNSXQJbOIltxI6XKOM2l0pfuyj/ZKY
         UOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWsc5LreZNGCj8euVjnYrc0UrCyMHiSNMq7w4UZnThc=;
        fh=lEkw4JlDB2DHWbvRZKGKFS7AipqtNNoSr8QkLbFGqYQ=;
        b=WJGcwmZGB1qTc6fWBh3OUJJY3so142TTeH+Mt+HuSguVz5YZsScrJt3jH0SU6MkkpC
         36gXS9fL12CNvy8erg4KKtJfcIA7CD4NhY6iepGmqVHASjBANKkvAlKEy1NT/DjWxunr
         yFI8X0IkqscM8shC1xMLEZ7+FLusSKy0Neadb1yP2TVGibl33NllygKENrGCSO0DYETp
         k+Wbr8uOKscvYnJlh4V5PMN9O1EkM0W67SUmbB8qqOuAz70RH6ChpXna4dG+/7s4B7U4
         kzMdbO24qkxQjYRkQigUGq9aawY2lfKw/EBNyxx8ya1m72OV7vgo9WB2SJVNDndlS0jO
         Znyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775561976; x=1776166776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWsc5LreZNGCj8euVjnYrc0UrCyMHiSNMq7w4UZnThc=;
        b=meSPw4ID2+u30GNVpWZMKxyn2VTFtw+RGNolxUS1JgTIrngZ16TwEVzHf/3f2X9aBL
         rgaQDLV9gbyD/zjD6etqDT6xqfD4txUYwVDs0em3lU9k/bc0WNCcJgqg5WoTvdm5Xv6V
         3MaB1J7SHuuhp+qyhqxOvZQQO+KtN+c+r9cAVd7umSKu1T8NxS14pSMbzELa0BVoovJt
         uE/Q+Rw3h6Lcs89PmP+NsHIA/s6hN01VP98tUX0jMrgSAGjkkTxFJcS8wIxquam0eZzl
         tFecpOw+tjrAnfQDvQZiFKqUIfGyBHXeEXAe+YcjxqVAdPa8CWDF3Y8rfYsymFlijEI+
         JJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561976; x=1776166776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWsc5LreZNGCj8euVjnYrc0UrCyMHiSNMq7w4UZnThc=;
        b=tGNaCvTaelJAR2Hg1yfq5ydUfYrpcRtMGnFHS7OuLBcBhe/jb0rbtWFDJmFfg5IWu8
         VfcAnP34j9E8gixmuVLHbSGmm/nv+r+fF4ComKZZSoXGWuyGy1DCVQORo52ugB7zs96R
         SArPHLGOfw0TtYZ1KRLJr0r8rpC/m2xcZpnhiBPIH8IY4x8OO8wz3GOnROfd9DxY2xRn
         zsAwvLgjdmJJNsVR4MH7+91MpqBRDBRnjV3k/1VN8Utbd2xas//Re4KFiUITJ3F+aftt
         IxgOhkJIlGuqo3+D5guHvCn/rRAlbFSGWDw/3C670PJ7L+/aOkYzOHe0QLVCgjUNiq1g
         AS9g==
X-Gm-Message-State: AOJu0Yz/25PE+4D1bAJtQBmme8x6Z3jD3bCtKzh+V0tXVVEMSEFXiNJH
	k7lePDrT3sZKufR0EIMYl4zsszotmGDJAMBj1yilgUpHGqfAJ9CevK/q9RZHPM6T1MfN4L9Occ8
	sGnSFjdUJ6PDIWUZfEuapusgIglKmERnAExW+OShc
X-Gm-Gg: AeBDiesHl1imDNGecMpMTpT5cC1ve/pghiAfMD7nBTFsd/i8xwSTtMtXQ2uNgFqH6w2
	aWytd9Sqcvkek5rz0JOn9aKAwEUdQTjpYzpFt72ERkrOKZZLuXwbvPwXlKIhYsTxDoW3igW9A5s
	veIufDz3VudOCPgIHc+rW1Wmm3YjY2ynho3TfuEm9uAhLdVqnvr1ske99kuhglJg2U9Xub51ivO
	Chw/6rdxIQwLPpwF7GKwnLd3uZuj5wqFdz0DD7LWwR0f/16VRCiESa8HbYqrxyLnNoYGV1XR8f0
	FsOwco5iOUEKOtY=
X-Received: by 2002:a05:6214:e6d:b0:89c:4d0f:d7d1 with SMTP id
 6a1803df08f44-8a703f0eac7mr272931856d6.33.1775561975748; Tue, 07 Apr 2026
 04:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
In-Reply-To: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 04:39:23 -0700
X-Gm-Features: AQROBzD-S_BCgj4LW1WaAD08cZ9GJDtXH1gR3Sydyb2OsYRAgnP9YBNpVcPwKfU
Message-ID: <CANn89iL5KKzmKF5qaQ6Sw3kUxrc1g_ysT63HGAh=jWZwStpP5A@mail.gmail.com>
Subject: Re: [PATCH net] net: rtnetlink: zero ifla_vf_broadcast to avoid stack
 infoleak in rtnl_fill_vfinfo
To: Kai Zen <kai.aizen.dev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275959-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D5E223ADD31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 4:32=E2=80=AFAM Kai Zen <kai.aizen.dev@gmail.com> wr=
ote:
>
> rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
> without initialisation:
>
>     struct ifla_vf_broadcast vf_broadcast;
>
> The struct contains a single fixed 32-byte field:
>
>     /* include/uapi/linux/if_link.h */
>     struct ifla_vf_broadcast {
>             __u8 broadcast[32];
>     };
>
> The function then copies dev->broadcast into it using dev->addr_len
> as the length:
>
>     memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
>
> On Ethernet devices (the overwhelming majority of SR-IOV NICs)
> dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
> written. The remaining 26 bytes retain whatever was previously on
> the kernel stack. The full struct is then handed to userspace via:
>
>     nla_put(skb, IFLA_VF_BROADCAST,
>             sizeof(vf_broadcast), &vf_broadcast)
>
> leaking up to 26 bytes of uninitialised kernel stack per VF per
> RTM_GETLINK request, repeatable.
>
> The other vf_* structs in the same function are explicitly zeroed
> for exactly this reason - see the memset() calls for ivi,
> vf_vlan_info, node_guid and port_guid a few lines above.
> vf_broadcast was simply missed when it was added.
>
> Reachability and impact
> -----------------------
>
> The leak is reachable by any unprivileged local process. AF_NETLINK
> with NETLINK_ROUTE requires no capabilities. The only environmental
> requirement is that the host has at least one SR-IOV-capable
> interface present, which is the common case for cloud, datacenter
> and HPC hosts.
>
> Trigger: send RTM_GETLINK with an IFLA_EXT_MASK attribute whose
> value has the RTEXT_FILTER_VF bit set. The kernel will then walk
> each VF and emit IFLA_VFINFO_LIST, including IFLA_VF_BROADCAST,
> which carries the 26 bytes of uninitialised stack per VF.
>
> Stack residue at this call site can include return addresses
> (useful as a KASLR / function-pointer disclosure primitive) and
> transient sensitive data left over by whatever ran on the same
> kernel stack just prior. KASAN with stack instrumentation, or
> KMSAN, will flag the nla_put() when reproduced.

Please note:

1) You forgot to add the Fixes: tag as mentioned earlier.

2) Your patch is mangled, tabulations have been replaced with spaces.

Documentation/process/applying-patches.rst

3) Please wait ~24 hours before sending a new version.
 Documentation/process/maintainer-netdev.rst

Thank you.

