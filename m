Return-Path: <netdev+bounces-290658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M9WNmLMD2obPwYAu9opvQ
	(envelope-from <netdev+bounces-290658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:24:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C55AE517
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A83830221EC
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAE3161BF;
	Fri, 22 May 2026 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Io78+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF13101C8
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419861; cv=pass; b=UO3W5VuXVyMdUrlsh5+739owyahYZ0lta3uMVZ/3DY81EVf9dfWlPeHuUIrNKufhf9k2z2j74aXP0VbFVCbsszUeoBeREca+zZiKvn5fsCUevQOftv5UVuMG0PEjarCLCFep4otaSykX7l1eExM8x9wZvtIJldl+Ws32HAl0bMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419861; c=relaxed/simple;
	bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX7rM1ZERsRRFpIzp+cl/QnS8mumP+BiHbfVOMJqKHlCfM+epG7FMxQxdwQ+6w2mCFkhx6yrhImuBJy780aLPVunsdew7iEQs0NDthJn/dV+/vXsaWHLQGvY40q+wLA/wcYUE6bnpOmtpWEUDHHmhDlvRGFu94qFUqPQjvGdHls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1Io78+K; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso66524815e9.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779419858; cv=none;
        d=google.com; s=arc-20240605;
        b=eyoR3oXNeKUmJ3QByjkf6sErOJMjRJeLxUXz9vyKe2mse2j9UWjq+n/2eukBvEE7km
         Hdd979vZzs8Cac1/i10Oct/vqSv8M5opahPR0wGuWAzrFEL7wveqsT6dhct62EGHyrT+
         KyVDwAAf/vCd4CeXzJpnINAhZvJm/CEwFhmzjWnqgLjIqzBt2L2xrHzPbIY22NBTpATq
         qNa4PuCR6ItWDMqifpoPh/g7buIJaWBl3IQJyKSYYJ8qfwgH+rlhw5sFeHxbdabw0YIc
         fZLKSUvbepUdNtquJDyY8n4eVwofPKlBL7V8emxC3UEzeemUilsI8kdP7rcjjc8otkeT
         Nbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
        fh=fRhB1zrsyUhXmYqhS+pKcH2erfIGWhCQR2oHU+VwZsE=;
        b=Olyex0C21ejJ9qKIKq0E588QlnTeat/6WWK63rSxsOWlyxgmTygyvcw/B+XOPMfNUn
         86DsUioqfwtlt41e+yieIL9SMmVxMDizkI2zp6LaYoGnUF2mPp2AlS0j1GMtN+Ktq4R0
         +z2NnXt0No5Fny5+2S1CNicpzFLzcIb9JflMkWIhb4ZMCQbYuiPu6F7yQ63AK+FIr6T5
         OpaL3anAiBlyAaKCCBfwW3Tdz9YRFmoYI+NTdVKUycpoA3iKwfn5B1p+Laqbd/tWDT6L
         sRzWR071TqnlmoxkQultcFo+7+fZuTC096n6xQQ+3NQksimzQL2NnC6JnwvIWavtnxBF
         Ch4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779419858; x=1780024658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
        b=A1Io78+KpGOR1fVHL+A04AnAhyAwRvNHibBH7TvEdlugo/K5WMmb2ZSoc+rDRo9KdX
         sGieBdVXWH8lq4r/g30cCwGVOf5is0zgViu+d60RF240KATNa8ha6yOyaHDIhaK8Fyey
         XUZ3O7lRSg2IITA0O3xQKBTDktjsOEtH7UrNYC0HYYUaiKtSCyIG7OEL71+/3aYlzgoo
         cBcfKZg0OF6z9QeIB3GhydAnSq/OvST7TJfufBTgJPuOH1jzK/oMIwMBTGEd2sOOLAMI
         kHdKTKwu2pkkk/AsSXsDsKM7WAs5tftLmmiT/O38nqGqRttNKrJ+stBk1UW99F15Twtw
         JYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779419858; x=1780024658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
        b=CI1VpaxfnYSVCJffdz7RPXSmvh+d3+E4PUVqeLOB9qfYvmcfuYdLpe2AfrdwaoI00E
         OeJmlVl5QU7BiTNVSH4mx4hfnD66SGhZGB+x3LiOdzZDVmiIg+Fx3yYTxCbBnBEtcjnq
         W6Yig/5+nzF7UFFXorcGdyCCNtIy3S32PdHroC6MmS8PY3zWxl+dkZCYTREY8hdDtG7+
         B5nem3CNZMiSB0kXKKA1wMGrnBH+WxKexxNjOSg1GjKMoo/jLfDsaxsEoJ+H55+5qPGk
         Fba0jcmMygyxTnkY7EZYMReODBthdee4R8gCEPjehp9qZlQVx2FA9NeXZjMyY5H8EEVO
         SlIA==
X-Forwarded-Encrypted: i=1; AFNElJ+7oRm0FQezl0V93J7S8vxjZsQ3WFsMhfVBoM1QM4o2TmfiU3y5fK57CqM7A2Bgyj1rj2mPVLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqimykxjQBQycHw3dowmfBPjzltquKYYSVMzrALe0jCZ1NVtyi
	tbS3hfWdmlrReTaJH7N67s4fICPUTwAYGRW2FrcEJBoz1U5YTzaMJdH4tYxKkyvXUh890j208n/
	xPUcx/PO+wvHrX+U/lAIQ6enjXcl3TtI=
X-Gm-Gg: Acq92OGR93vHFemKV7gz+KbtXtgcn+JTcyqzbfk/8vRQNJoK8JrwaDr/zoRMapwxmCk
	7Q/KCt7Ha6cB35AwbM0znBxwFF1S8bxRx1/P8Jl/YKnPNuPH8zbSesiA9XWS3PJAbKliFk1kL3l
	KcJVZhD2wScXFdvuFtyFbOjpkUZcL8KC5RcFTOumqm0iSsxIclEqq0Bx9+dlAX94sdkSMJUmbff
	SKKCcDv8UXtG4vG7r8iojm4+2bfpWy7RwCR7/2GdgfP1So5VieFqr/ozEtLoKhHddICOaJGmBO7
	H5r9sFTbQqz1N3+TEzRQkf66B6t2kJfx4s0XXw==
X-Received: by 2002:a05:600c:4fc9:b0:490:3cec:52f5 with SMTP id
 5b1f17b1804b1-490424883a9mr16488425e9.2.1779419857596; Thu, 21 May 2026
 20:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
 <20260519123547.2055911-3-maoyixie.tju@gmail.com> <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
 <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com>
In-Reply-To: <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 22 May 2026 11:17:01 +0800
X-Gm-Features: AVHnY4JuqaQ7c-wuivZin8SvqfKHD7bmMZmQJKeBranmaSXhaRffZpEtfvmbT0I
Message-ID: <CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290658-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 355C55AE517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 8:58=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> Hi Xiao,
>
> Thanks for the review, and sorry about the wrong Fixes tag.
> 5e72ce3e3980 is not where the bug starts. The dev_net(dev)
> vs t->net divergence first became reachable in commit
> 61220ab34948 ("vti6: Enable namespace changing"), which
> dropped NETIF_F_NETNS_LOCAL and let vti6 devices move through
> IFLA_NET_NS_FD. v4 will use that on both 1/2 and 2/2. Same
> shape Jakub took for the sibling fix 1d324c2f43f7.
>
> Thanks also for the ns_capable suggestion. The top of the
> switch case only checks dev_net(dev)->user_ns. After migration
> that is the attacker's netns. With the v3 patch the lookup
> uses self->net. The else branch still sets t =3D self, and
> vti6_update() inserts the device into the creation netns
> hash. I reproduced this on a v3 kernel. An unprivileged
> caller in the migrated netns picked params absent from
> init_net. The SIOCCHGTUNNEL returned 0. SIOCGETTUNNEL in
> init_net for those params returned the migrated device.
> v4 adds ns_capable(self->net->user_ns, CAP_NET_ADMIN) before
> the lookup. With that check the call returns -EPERM.

I think a similar issue also exists in the rtnetlink path.
rtnl_newlink() requires CAP_NET_ADMIN in the link netns only when
the IFLA_LINK_NETNSID attr is supplied. However, this attr is not
required when modifying tunnel parameters. As a result, a user with
capabilities only in the device netns can modify tunnel parameters in
the link netns, including endpoint addresses and keys. I'm not sure
if this behavior is expected.

>
> I will send v4 shortly.
>
> Thanks,
> Maoyi

