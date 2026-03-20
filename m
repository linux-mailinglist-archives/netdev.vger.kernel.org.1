Return-Path: <netdev+bounces-270009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMsnEz6NvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:09:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31A2DF2F9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C476A31B540D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D130595C;
	Fri, 20 Mar 2026 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAjakDrV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D1309EE2
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029770; cv=pass; b=TuP6ZZJf1ysDwEsqeZuJM/1pbp0XlWsUnwVqBo3iacbfAqK9Ro9GEmWNplYvxeVcnMD7g0dOEMFxRcYoNxKflqaWiiTH9KxU+mQ6P2HNrl5wjgq+6FC1gR4Cdvkve9r70OabsZoKi2nRfMHgYYHo+bEbsTocPlib/LlMDlVj/rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029770; c=relaxed/simple;
	bh=wN6kpZeaNONl9B4mFN236xU8f+pgFkGY773WjFaxrS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+AfxLllIew80kfQ+u4nEDXMv3550Mc7KMoUL5kqH3h9CbeEzcrvqHhqgo30kYIWWKPGj20Qn7eZwiRyvjtHFIRdouYxHQu7ndSGCmlvbBxTdGyjctHT/f/flv3Jc4Agb8STPN9NMTSb8//uihHcHSWFEYNLheYtYfith2AleDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAjakDrV; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9ebd1369so2296098d50.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774029768; cv=none;
        d=google.com; s=arc-20240605;
        b=efzQpjSpl4PDLV6EvWIiy0rLuhB2SWqx8t5JsxH57/hnZVgKN+GmVBolmjcqAYaLc/
         t4YPCrt/jfbHgjF/9jkTA8t7Xdfxca1imp69fyz8lBUY6j/pheu2Hhapa6cBZuHYwF7h
         0CHgiLo8XOB2oq5IUO2qE6T/b2uLJYPTxYpeuWLsWe+JecwhJkgBm2f69ZNckllG/nzK
         HZSd+fKY9apsYLH5wx2fqfa9dQU9TyqtStRNGVf/eWtNzyR6yswClIBD4kLF20Z3+b8/
         aPumStdgL32G7JNVTzVuR3zvqJ/k0FktFlwu4Xc349PbIvQiGBQKDIOx1XNHNBbSaDnV
         ASYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cA6FO5PK5MXNem7BCc+OhGtaRpwVisqbTVMiqZHzls4=;
        fh=LI3+bxG0OVrUH6jjGgJ/3HvFb6bASrCqOyLCoX/nji8=;
        b=aMZpGi4FWuijrtu5qKZ2OHF9GWtkHAnqhW3Ol1DyKQK37vofoxDcKIMBINn45hAGKe
         utkhsYkb8fLb0UUtq09YCNCYKPN3O9UXndxWzJkwsDG0VsHfh7GlsQC5RBHyuEMRBEz8
         LHyaFEFdfcJjXaeHGRQpJ+dS9k9cC5yF7+o2btHEo35SH8mFSTq1lVZrZRFXbxKv2hJ+
         ydSFDL3iQ03pRNmc/nk/lBnBAhxhOLg4zVWLGgnPCQrhTDIhYx87qvYF0Y8hKzogeeRR
         KOJd03WwkwQTsyY9ZmCTLSZq9q22l/AzFAjBajLe102YjCEq50mX28vUgVaFiRA6/pZ7
         dqLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774029768; x=1774634568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA6FO5PK5MXNem7BCc+OhGtaRpwVisqbTVMiqZHzls4=;
        b=iAjakDrV2JnOdSKmzB/JTsv0Lskd7+OGsZMlcbFAOyGpswwXoPuchIgp90W5+W7QCP
         hkzYtDpKR5NEb1l7vPx3rXWEXCWiY2SCRlrIpZDp1u4zNBeDs3veV3uHah5qdYEBysAw
         DwUazMAuTd0laNFypAARYC6E/X563galHQuwJnOuBgfkS9YAuFH/8Dk4JiYjfqGH38Ri
         rMwowIoCDMq5WOAVOSTKKAWvLlMfYI/OaVsyan7sOl9Gb/drRMe6896mHRqkDrVSnBkX
         ED7UtqI357Koen7IoPAG+Rj6g3DdnTKkIicb92Hcwwqj0MlRnUFdBaxE6HoLVIPXuOKb
         fkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029768; x=1774634568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cA6FO5PK5MXNem7BCc+OhGtaRpwVisqbTVMiqZHzls4=;
        b=SnZ0OeXJiHY66ctDke7Ahkmyczv0GJHjuTjKZZnvOqKLOl/c7Gy/rlLG+VWucE9Sg7
         LmXPQhEDstOMk1+oos0lo257zO4/21dBtIxDy0PBc8xd3VlZAqV71+w9IxtYP5Unq7Cr
         c+/BJoI1cVAgCD+UwJQYfn7rXexABsiW3vM5fAXYFCeWqbQyxPN/+h3VzAu+C+PyaNQa
         KleYyYunPUXZna9wi1am9fkrhOFLc6be2KKYPCHErumfT0ADTv7O8Dz1eEloXMvk3VLv
         l56MthQR26rzA/TeQd0aDSMyQi48TSoPOJQZTzEaCKkNqp2L7OTVWGrKZMLo+LorOrn+
         BMNg==
X-Forwarded-Encrypted: i=1; AJvYcCXuLz5yOxuUipWsy0JqnogfP5GisNuhHHarh/dGVGC+upRZ4ku1irhWQvWp/w/T/Ct4vzq7KjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H2RQX9JrTVmbj4CvxbBwDx0z9ZnqEI/XIdfc1c6ToJokyjcw
	DiJbOdy18MgcBa3RhtKcJuXir4lUH0nwPu1v2vy2dvz35xCu9pDa11Yd7lDYAliChJiv2Xk0pwc
	qLQT+vvc3MJptEzy9+LB6xlF6JInRIKhs2cXk
X-Gm-Gg: ATEYQzxlxF54Bvi61MBym413QG3FxiP1fzhuiQnAB+w+D1dQiJSRhoJISa65Igq3d5o
	/hbeA8js4x+0GdBHgxdgsuUFJ9JSNKnoYHg9o88uebQjX/YJUmQAx7s9maM5bCe8APCrO7NZOM7
	BxSc1Ih7ikjccacTDgSvUyRC03CAuHhIEDBaP7iFiZlAdTPKEhIT3WwSmlXYuUFp+BH8MtEK9O3
	ccM5BweXQw3D276xbajFSk/ekhCq4BMJQ4NpZf6M1X0i7/041T0ThlrwEMPATOHoRYVJwlJnbhh
	P6NW1J7CofzkEPTO0h0pCurY2eKp7vTQXrDbq4Vpo+AQzxquQTab79vorIaxu0dIbmt5IPqbyLg
	siUWI
X-Received: by 2002:a05:690e:4292:10b0:649:e6de:8f3f with SMTP id
 956f58d0204a3-64eaa6de62emr3219341d50.32.1774029767001; Fri, 20 Mar 2026
 11:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
In-Reply-To: <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Mar 2026 14:02:34 -0400
X-Gm-Features: AaiRm53NYqewKQi3pNJ2dEJTs9aDibGtDwtQHrJUYixyc7-oeqpSDV2VIuxCqs4
Message-ID: <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: kuba@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270009-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.880];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,leemhuis.info:email]
X-Rspamd-Queue-Id: AC31A2DF2F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Thorsten,

On Fri, Mar 20, 2026 at 12:47=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 3/20/26 01:00, patchwork-bot+netdevbpf@kernel.org wrote:
> > This pull request was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Thu, 19 Mar 2026 15:04:55 -0400 you wrote:
> >> The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa=
9f229:
> >>
> >>   MPTCP: fix lock class name family in pm_nl_create_listen_socket (202=
6-03-19 09:37:48 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.gi=
t tags/for-net-2026-03-19
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [GIT,PULL] bluetooth 2026-03-19
> >     https://git.kernel.org/netdev/net/c/57ce3b2e9cda
>
> [preface: sorry for being a pest again and making life of maintainers
> harder with mails like this; but I think Linus (CCed) wants me to bring
> up situations like this; Linus, if I'm wrong, please do not hesitate to
> tell me]
>
> The quoted bluetooth pull to net afaics came a tiny bit too late for
> this week's net PR to mainline. I assume there won't be another this
> week, as that would be unusual from a look at the history (and well, if
> I'm wrong I'm happy!). That is kind of unfortunate, as those bluetooth
> changes contained a fix[1] for a regression that at least three people
> reported (and I know of at least one other person that was affected)[2].
> A regression that is known for nearly a month now and thus already took
> way longer than the "fix within a week, preferably before the next rc."
> rule of thumb Linus recently mentioned[3].

Afaik, it was tagged as regression on March 1st afaik, according to
[2]; traces were only provided on March 15th, so yeah it was fixed
within a week once the necessary traces were supplied.

> We had a similar situation last week already with the netfilter PR to
> net[4], which came on a Friday -- and missed last week's net PR to
> mainline, so those netfilter changes were only mainlined yesterday. Due
> to this a revert[5] that fixes a regression multiple people reported[6]
> missed -rc4 and will only be in -rc5.
>
> These two examples make me wonder if we might want to optimize something
> here. Have a second net PR to mainline in some weeks? Or should the net
> PR to mainline maybe be sent later during the week whenever possible
> (say on a Friday)? That would have avoided the problem. And yes, I know,
> Linus at some point due to last-minute problems asked to send net
> mainline PRs mid-week. But he iirc (not totally sure, hence correct me
> if I'm wrong) recently mentioned that things have improved. That's why
> I'm wondering if we should forget about the mid-week thing again and
> shift things a little.

Bluetooth regressions are normally device-specific, though. In this
case, the regression was introduced to pass a new Bluetooth
Qualification test, so we would have to weigh what is more important:
compliance or interoperability? Which would probably be a split
decision, though we always tried to balance that, since both are
important. However, I can't remove a valid compliance fix just because
a user (later more appeared which raized the severity) said his device
stopped working.

> Ciao, Thorsten
>
> P.S. Once again I wonder if we should have a dedicated tree to collect
> and quickly mainline regression fixes subsystem maintainers ACKed -- but
> at the same time I think strongly that it's a totally stupid idea, as
> bypassing subsystem has many downsides (like bypassing subsystem
> specific CIs, the need for backmerges [or duplicated commits] and things
> like that).
>
> [1]
> https://lore.kernel.org/all/20260319152247.13225-1-luiz.dentz@gmail.com/
> -- in next as 761fb8ec8778f0
> [2]
> https://lore.kernel.org/all/20260301233619.1807980-1-joanbrugueram@gmail.=
com/
> and links to bugzilla in that thread
> [3]
> https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2=
BLsMyJmcuMSA@mail.gmail.com/
> [4] https://lore.kernel.org/all/20260313150614.21177-1-fw@strlen.de/
> [5] https://lore.kernel.org/all/20260313150614.21177-5-fw@strlen.de/
> [6] https://bugzilla.kernel.org/show_bug.cgi?id=3D221152,
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221158 , and
> https://lore.kernel.org/all/143e1a402ad78dd7076516a6ceb637f378310b16.came=
l@sapience.com/
> (some of those are with stable kernels, where the culprit was backported
> and reverted earlier already due to the regression)



--=20
Luiz Augusto von Dentz

