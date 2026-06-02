Return-Path: <netdev+bounces-294098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG9IDTKgHmquDAAAu9opvQ
	(envelope-from <netdev+bounces-294098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAD62B4C2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D2EC3004692
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBD3CCFC4;
	Tue,  2 Jun 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X14OFgqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A62383323
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391681; cv=pass; b=jbkMsUjIuikaDETju6nnXFOhgzea5obiHSwXkIAf9sL2klQ40VNFSKsMhhD3PqWnEoH8WGxu6/bEkj062+gPcZcKlwHcisQ3dFmigMZ6j8zpQDJ5D7JNL2oLTdQcFacpJ05vLjfJCq1Db7vcaS4B+XgVwN/5RZ2Cdc9dr/xxuNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391681; c=relaxed/simple;
	bh=Thb8rnvMXKOzLq+3rzbZD2QbzY7ih0kabUxEPV3mvR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHTomJEnTyLnsOSP6pWw7q5sSw17SQSXy5wa52m01XecbifTJHrlXs0Ip6V1HSMaKzTrbGbStT4kYD4iqJ+5uMq0qj73BA4AWujnlQb0GGb1lh8pJHOmPdZvx7k+wAf9r46xBmiNUMO2QBiymlAxki6ct/eygjeGU8xeYCfzFb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X14OFgqS; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9157b94a07aso53961085a.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 02:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780391680; cv=none;
        d=google.com; s=arc-20240605;
        b=PuA3Nic7dubATTSdFTNAd7llvIE4DdFQ0i22Z8d5fS+zMj78hvs5UBmMHlSEscLxbL
         Tj3gLZjZZSyr0T0FW0BUZKB/Hd7UuxU8F04/DjR9uujIvi8WISOxqxuicYdkuW8sq/7V
         mMjVfvmO3ss+CYrXgr1PcKkddzMxilJnLX/hE/0LyVH+eRY7yaYS6o3ST5sbhndB998+
         ZfGtIqMxGHFqV14mUDQjvdVpjChmYds6BCrrTeGAQDEoGcLrJ6ruIhqOYTb/ezJ/F69c
         dhtPV16lKLNY5VTYNwTHDRgIEg3eEPcpD2tiqLbzZtfmEC1IS1BT0r2jAE0G7NBxXhUj
         R2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g3j92x6WEIOH7fOsQ+0GySgS/ybsvoUHbq6+YbJw3Oc=;
        fh=D9T77AnLx4sGRSkZPPwSbpunRx9eSm9REMmOU/WKK+8=;
        b=O7JLVMvP4n+t+HEoSvUC9iaM4EX1zYlRLtn+Jql4pf763unFIo9qAJhMxt+uvhSeBx
         rWmymgNPJBkGb5ABfu1/PSECymE0mRI+Yq+0eVmg26pTdIR9tamg+r7s+jXOB93nU9Gy
         VoWSJ5Ts05lQLAasOCG9VCoCWOe8PDH+9uAa7zIKNoK0s7OXq81CIVmdy65/wqZ6EpAh
         PWF/yk3WCq+ZqCjbVN5bvli4hhc0QkOsL+SeAHK9sJ9SDjAkmKPBfvj1dRZ8Y68HyREY
         Dg2SeFnWSFsuAVXXbRLPBGNcRQ21WPxeukwDguLKIkwYMMgr74AcBDhonGTb3+prXNIh
         MHqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780391680; x=1780996480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3j92x6WEIOH7fOsQ+0GySgS/ybsvoUHbq6+YbJw3Oc=;
        b=X14OFgqSTi6Fxm6zR+6PPYKR2P26Xhm6if7wXeVeW49nM9lzntbJ6hbI0hd/FTWupI
         1S+SE3zDW0FxKpROxNmA6Qf5e8SROnZAhtoG2BuF7voQ4hETObN2wWznE2ZkrNxl4gEe
         PY+BD+o03Sd/RMp0fC0vu2g3O63w8+cuqkEiggGt4yWUoCcMIIt1jC+HyMRWrFT7af7/
         1wTWj1Wz/2VPky1YogpWnoI+piKuRBU9bnctb4bUy1xCCNdgmWgbG32aTD+twf4wie4d
         SSiC/K3ImZCdV6/0riNYb44Pdess0eRDGQC3DF+zQjB5gZvwZ+F8ZZrKHLx8Zeckxidw
         /PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780391680; x=1780996480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3j92x6WEIOH7fOsQ+0GySgS/ybsvoUHbq6+YbJw3Oc=;
        b=lTlXvFLU68Eyu6MhulD+N/TQILCEsnV5GwHLrheAzyvpdyVJBE9cUwVX6+AByJdhMU
         DpBVEDyIE+H7kYDTEB0VjKyfBuhpk0fUHGn4tVJ3q1WCjSFgSZnYIMulA7x8p5jrGp3E
         zJunKGLs+yZo34+eZ22ni60p6fLAiIsS7Mf2Yon2S2s1bj5ajl2XrYkhEmSk6OrMOQrM
         O59Gw69jqw/4HRnJE4XtBrYC75E+kSdx4cAFN4krmMSINTFA65Iu7qYPZJcV6IhfROno
         dCJs2VN00SbJh1FcNs4GjEr24JKxpjjP5vNKyXyzbaRpR5S2NdlUJYTgppAVCOVhZtZ3
         U+Vg==
X-Forwarded-Encrypted: i=1; AFNElJ98TvZJW86kk3VJX5JruGX+0tYUWwxdMCV/exVzuF+tZhy3O+7RvByuo58Sfb4cwonlaFd0WuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmr2foL6uLbga5qwsxXtHVUH5s+jyypLkb9YTBNsvRirUVO6G
	RZ9fvEk6Vxg3LwISKAUQMzzx7RrT28vTO+kYEZIkK622G1+VTeud9u7UfeRKZuQ7svC24k7yRq/
	ow7GVO+OFTCL/nZE+na4dgzh8XZLGqb0fN9+Hw3K5
X-Gm-Gg: Acq92OFXnXFxC8MgGC+ctsV5YsE/qwWaDtP4+k+/mKCMwl8D3byRsjVQLWOPl/u3Aqz
	f0RoeMj/zxujg++0g2QiRTZp78z41PNIlatgizA4rS8MBVj6JrOxJtr+VlRNwA7DO1nG7F7Kwkj
	VtZGSihiWjHQxZYMliV05oxwqEBjkYUpc3g+NCzDTgbzE6CyfWjReRrchO5ofYqBNZLAT3kTfwe
	83rhVi5lDPfQ/90mXJbiQV++VlMggLKpbbYtbY15f+v5HK1ZwfmFCANmI4R+K+mbKbTEv6wrru/
	lfIHDDox3zS4tpul0Qhlg2c/0tzTvnWuA1fH/AscxzMuD3GKAvD8dqM2unZUZqzm/4/FUhw937F
	573TwuC49iobQ+Meqyz9LFILvC9KH
X-Received: by 2002:a05:622a:2505:b0:50d:9b4a:e6f with SMTP id
 d75a77b69052e-5173a5e8040mr213274941cf.1.1780391679041; Tue, 02 Jun 2026
 02:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601061304.344248-1-jiayuan.chen@linux.dev> <20260602005915.3474979-1-kuniyu@google.com>
In-Reply-To: <20260602005915.3474979-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 02:14:27 -0700
X-Gm-Features: AVHnY4Jp08Gasiud5lSa-TXdDMVtxAEieTG_UEDGa40z59uWSH6511403_aKwxI
Message-ID: <CANn89iKsSPqeVsYLtWiwkSMbF9oKig-Fwc-MOC4BY-a0Y+w4kg@mail.gmail.com>
Subject: Re: [PATCH net-next] macvlan: fix use-after-free of macvlan_port in macvlan_fill_info()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: jiayuan.chen@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2EAAD62B4C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294098-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On Mon, Jun 1, 2026 at 5:59=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Date: Mon,  1 Jun 2026 14:13:03 +0800
> > This issue was reported by our internal syzkaller [1].
> >
> > rtnl_link_ops->macvlan_fill_info() reads and dereferences
> > 'port =3D vlan->port'.
> >
> > However, when we delete the underlying physical device of a
> > macvlan (e.g., eth0), we traverse all child macvlan devices and call
> > ndo_uninit -> macvlan_uninit.
> >
> > Each child goes through ndo_uninit -> macvlan_uninit, which
> > synchronously kfree()s the shared port once the last child is gone, but
> > does not clear vlan->port. The child netdevice itself is NOT freed here=
:
> > its free_netdev() is deferred to netdev_run_todo(), and a concurrent
> > rtnl_getlink() additionally holds a reference via netdev_hold(). So the
> > netdevice stays alive with a now-dangling vlan->port, which
> > macvlan_fill_info() later dereferences -> use-after-free.
> >
> > Here, we set vlan->port =3D NULL after kfree(port), and then add a NULL=
 check
> > in macvlan_fill_info(). Both kfree(port) and vlan->port =3D NULL are at=
omic
> > under the protection of the rtnl lock, so this is safe.
> >
> > In macvlan_fill_info(), if port does not exist, we should simply ignore=
 it
> > and not goto nla_put_failure; otherwise, it would trigger WARN_ON_ONCE(=
1)
> > in rtnl_getlink().
>
> The splat implies the same class of issues in other devices, so
> I don't think this macvlan-specific fix is the right approach.
>
> We should give up dumping if dev->reg_state is not NETREG_REGISTERED
> after acquiring RTNL, and I think Eric was preparing such a patch ?
>
> https://lore.kernel.org/netdev/CANn89i+UMyx-rKO0ScZkcJYG_vk=3D_kddcQC+Sxb=
bYSEyUTPgGw@mail.gmail.com/
>

Indeed!

https://lore.kernel.org/netdev/20260602091319.1753654-1-edumazet@google.com=
/T/#u

Thanks!

