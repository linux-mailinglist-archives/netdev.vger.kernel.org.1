Return-Path: <netdev+bounces-259825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAZ0JlW1mWk8WQMAu9opvQ
	(envelope-from <netdev+bounces-259825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 14:38:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F293416CECF
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 14:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA34E301327E
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A5C137750;
	Sat, 21 Feb 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bG+rCLR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E21C28E
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771681107; cv=pass; b=eScHwHScjoZCHs4SOgtoq2F6XBacA+xXrWYKIfw2b70Zu1ElzdLHaJxqCa3u+75hiePjANY9PLPeMMTkJOKZr4KpcK4fK/EXSVJQHE1L4hpi5WmkbSwU6CL6iENV3QZiYal2VCZ0sbYE5pw7YT+0DP1vMYW+DDDzm0hK60BRRo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771681107; c=relaxed/simple;
	bh=iOdbFwbiXpl3qoP55Nkw75IRYzutRQQLoQ3oz2XvZBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qk0UU2z4UD9KmRMJN9zvptQ/jzHAo2ne6yGFq0RWrHnaUTI0D0kfFPoWGUCvcSnFngaJDlBxYajBEhWKL8wHSZY+5nVtlhr4aI/P1IgxBB+yW1pbweekp7xlSjp63C1bKg1wXFmu9XJdOhByqeQWtC8Qld7+AoZ8N+BuWqMr57w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bG+rCLR7; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506bad34f51so23671861cf.2
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 05:38:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771681105; cv=none;
        d=google.com; s=arc-20240605;
        b=M/dCA2UuVhWliJquAS1WTpOrCJTmnJVVr9yPcLOx4jG1eBfJX+PcLprZn/JUHfrn0Q
         Sxt4g/JAQxvTNWjoWL9cwbEDinH2WXlmGLYEbjqTmMG1H77WqPyLNGBFwcwCAJgJ/OmY
         flglOnNK/fiaJoI+t8u7Zd+BZ56qsMoU1oB+gHlDhlyDs7ldxUYJgcjjE8on749/JAAT
         OCslRU6TbIXoRNwiNykI/DjurVmGWrVGS2axLKR2guVLUUn2Hs/pIViDd8GoHJKuYDmM
         am0QveoyKBavMKHIX9ANz1OkFI+MqWU0qIkTtmGNQJJwbJN59p8MQF5ZVvToV2d8J9EU
         LxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iOdbFwbiXpl3qoP55Nkw75IRYzutRQQLoQ3oz2XvZBk=;
        fh=rnBc9HHBJeVNldphjx7Vdo2AE5JP5bzmig8hfxgGejI=;
        b=PDJvTaJvK3BiYgkgzUcbzG/SOoCHV3sJEigou0ylgnELBAq8VaxijBHs0HSg5Bz+i8
         KbMZXs2gVMKW3yQKkfxQhSLwV8afKPT08AGSBducCy0OMeVv4mEImfD2w/MVGajq8grm
         vf9tfUy7825wjyXEhVoOiStGWGghB55IUTYHpjktruljPe3oXEO4OFeBjwm7DckkXUHl
         zww6lkJ4tD2nKSr9Z8R6mt1fTDStP4gxEJvXBZZXLe5q/QWmdvLHUHQufRsUSmpKrYA2
         3hMXCu4AfAyjpRcmmp6rmgf6E9P8W5jhpPh8ohW0XHr3Doejy2kKYKwbAeEsqKiUh1x7
         5mcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771681105; x=1772285905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOdbFwbiXpl3qoP55Nkw75IRYzutRQQLoQ3oz2XvZBk=;
        b=bG+rCLR7U3+mtD8P3rqLGUYF+txZSX6XNBaBP9LAJnyddlWuVTd6MtYqH1RDLEbduA
         YbAWIaiBazzgHIxHY+WOwfLgTZohtbNwb1NKZzJzUVtu9ywDaxNQ039Gy1fqMGNZGhwP
         gxGeqkTAU9uiIW2tY5jiBBwRdowrDdS3rdgxJi3qhxRD9/jU+UXYD9kazVeBlzzrU+t7
         BYIKQu9Prph2rPJ8XSL3HwEW+D5n0W4OyVzz5zvhgKwDgYLT76jBNs1r1IaRSG4adMSx
         5MBtfDkhqC4pW4fq/TodxoyaKCs/qq00ET9PO4IDY8YRry1JXsl1Xd/IsBT+xw/IED9e
         ulJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771681105; x=1772285905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOdbFwbiXpl3qoP55Nkw75IRYzutRQQLoQ3oz2XvZBk=;
        b=m7OAR8v/lNEB3QavdGRhliQDoHE41RRMOx3QCtDAgroV4UUkjQ4Y7GDwuI2N5UJ4MX
         eVX5QYK0MozPaVWgU+f8otP4xHdvg/vAEzSinY/rJEQs4yOP6ZYZGyXUkd+QRyXAmlUj
         /zwyhghXARuA2ObDDdDdFHa/KUyhLWaDOg2taPdzCQK7gKVA8Q3RnQK1tKvwEK+bEw12
         8NVRpfs0cwp1fxtF2QtAD2+2ybyKT4ukdRcAJEOeMbRG5z4MiEKfKeoc2MQZ/UiWG8Kx
         ae46guDts38iS3xx0458cDABbQvkXuRCG5xAbTjH1RYfdMy/j9Nq2f5SbaTpteP11BK5
         GUTQ==
X-Gm-Message-State: AOJu0YyU/y+kR1n0yBxciG7JFe1Ibnn1L+qob3dZh9xqXG1sZNy+eegV
	9OrM/F7NvTipDt4EihDJxIikUgIOjrkBhspmiGkbrFIsHz+XL9Crv287fal8FclyZW+QCS+bHjU
	bN72/ZG9CdT6BkFbe7lg9U/CEcTd6ss68gDYqQOq3
X-Gm-Gg: AZuq6aK9bDWY5UK9w9n+jeeYWJq5u1extMZNI7RAla2HpSpldGi2fDqTJCU8kkOXndb
	932LUlQJpDR7HZu9V5uYR9e5kg5neF63R9O/Ncd9TQUvG2n7rpHHbD8hgFPdnsTLkG4yTYT3fmX
	AAkpH8g5aI0Cnd2RdACYKyBLYME2EVO6nl6ZVX6b8E2YCAV85DMWJndlJQC/VPgOYSaHK5ON6kv
	5hoIFYILlj8/1s+g6xE5C4ejHBSu2swBaViTiD51bkZcMrJqpSiMKYG4WghKvWJ2BW5anMJ2r+D
	P6CO3glFriNY0g/uvGA=
X-Received: by 2002:a05:622a:164d:b0:501:4ca3:7420 with SMTP id
 d75a77b69052e-5070bc73886mr43108611cf.36.1771681104394; Sat, 21 Feb 2026
 05:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221114806.1231666-1-git@sphalerite.org>
In-Reply-To: <20260221114806.1231666-1-git@sphalerite.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 21 Feb 2026 14:38:13 +0100
X-Gm-Features: AaiRm53dzgGuxNigHx9sXSXSu_FEQ8g_VmIJNIG5B51SCgANoua-Twh2jYO32rA
Message-ID: <CANn89iJM1eKPs=EEEad7xiEP=KPHJvbtAX+3kRvyVeDconUx7w@mail.gmail.com>
Subject: Re: [PATCH v4] selftests/net: add test for IP-in-IPv6 tunneling
To: Linus Heckemann <git@sphalerite.org>
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, davem@davemloft.net, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, morikw2@gmail.com, 
	pabeni@redhat.com, syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com, 
	rbm@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,syzkaller.appspotmail.com,suse.com];
	TAGGED_FROM(0.00)[bounces-259825-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,sphalerite.org:email]
X-Rspamd-Queue-Id: F293416CECF
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:48=E2=80=AFPM Linus Heckemann <git@sphalerite.or=
g> wrote:
>
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
> (and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
> for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.
>
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvR=
jcGS31CBw=3Dg@mail.gmail.com/
>
> Signed-off-by: Linus Heckemann <git@sphalerite.org>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> Reviewed-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
> Tested-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

Thanks for adding a new test, even if it won't be backported to earlier tre=
es...

Reviewed-by: Eric Dumazet <edumazet@google.com>

