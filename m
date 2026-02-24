Return-Path: <netdev+bounces-260430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBqQKkZvnWk9QAQAu9opvQ
	(envelope-from <netdev+bounces-260430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:28:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56F184965
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CA48311AE7A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0A36B074;
	Tue, 24 Feb 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKmojdgk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994620A5F3
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924955; cv=pass; b=r4yUehrWTzQKS/BK+Gzu5OMqbPAP6ZY4uBbpUFMw5OqDxfN9dIJUNm4FxE+MlQ/9GuQgKzYhvmWtXAaX9twpm2Nk+TeoxBVVEr48pP1BhqeHkB/Qc0hhO29UGvNaquyeQ2ks/9ypcj5jtmsK7rJyADE4ercicZ8vLdCRE/5Pp+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924955; c=relaxed/simple;
	bh=W1IR9WScIDkn/Ldtj14H5MHS1TFfCVSY4+W1vxZj6aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCr4ShmceODqDjJ1UVPfK1v0s8mC379x5fgFY568gZyE2dWLpuV+6rW79+Nbdy9DenVliMjr/F1esZYBddkbwaca6ZQTI82QpS+l5qzZZyhHJB3yqohf/GBkblpIdFWXNKUN2HbnhJIH6n8icHC+0szw+kiSjd/iEmzk7hrOfZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKmojdgk; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5033387c80aso82645011cf.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:22:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771924953; cv=none;
        d=google.com; s=arc-20240605;
        b=ES0U2Fp8KTHDGP6gHF5no3p3GtOws8jdsMp5gRueGDctSjDIeqUyC84B+WXQOOslcB
         CNY1vKMcPAfwFl8dAjcXcEGR+n2Vct7HoGPBjrEOC5ZTrybUV8ZlXsDNq4WsJ5IzDipM
         CzkzF4gTLLCs9GLSHc361YyunzDMwPcw+4A8HVO20mdLZvtdRONfOm8qFpUc+qTRxy7k
         6T6i+zw7FQLBIPoSx2ZgqBzXkL7EPoYhQtdEMBH9JgKOye5okRmCwDSDa/8VE1qIq3nU
         9HQFXDn35AdbiXEfAY2sfhIc9fEOJu9gIhwG0wwhkNjhkwhm+0lmqoEQVSyDbrcYffdn
         TbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bK9XwEb9y6Wjy1j2b+uWduqpfjZe/0b6JObJU2L/7Zc=;
        fh=rNIG6lsmA9ZRvsLUuHJX6r3EsKdHCZ4te8wNCHNozEM=;
        b=dkrZyHSxTwSwWtVwi5yiNPPDdm6bRvAbGSgiTlItM9lV0L1uq9APvRiu8iAgU4tNsp
         pye/3KeaPO4Rc4dL5Ry/aDXtptkRT9KwDqWsy/lEdeRlVXYmQvNH6GY4itD55gZQxuM5
         8xdn5/EVJzk5uzqKEOEjwtSdpX/tMpXxBWT8ivcM9sJW7HRqzhHkUJU70O8JHx45lpjs
         7RojI/+0NA+cr01B5sfwKlmiUCtaNmxGrIXXCoMCBNBtnZFH82LRKtXGQ3zZwEV4ovRh
         DGNvxLOTCEdDXvblKijF9Y47CdtjgdHde5bXEM1mCj6837NhntWbHUj3mwOg2lqOMqRA
         MGWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771924953; x=1772529753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK9XwEb9y6Wjy1j2b+uWduqpfjZe/0b6JObJU2L/7Zc=;
        b=cKmojdgkRw4js7rFJxZ1jn65i1bqplTVNCvpA6hkpBQeDVtcB8FH/vkbmTbnDqFaup
         KHNMv5VSsuDxqvMuPofBmFzQXO8PjB61FDeAhCxPPeifvPXoPz0ZNGcy75zjWfR6m7Ra
         HriuqCv5gxqMIDKPGksYZEg82wFhsztUf5IOGjBZbPNYwEgth+niDzLjr5oFguEoVH8O
         6mJTzLH9+GGaL3zVccwSUIiVkdTTnbT9EyZGMC3mtO5p478s5HC2EnHwz5TjSu8KZORN
         aK4nCVoav/Vxw2FtesI65/YoEc2KWdotuub7RsCe4oQU9F41wuxDX3aq6qptWWzbYtdF
         3GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924953; x=1772529753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bK9XwEb9y6Wjy1j2b+uWduqpfjZe/0b6JObJU2L/7Zc=;
        b=xMTxYhVrbZ9JoBLV5jFhvrZEDnW4Ly3yK2RTs7j98qYPHQi+flDFfbmcC3B6zRqlUK
         gCVTPz7VoGQ0aOKg7Av4Is1xj4RISOVAF1asx2FCiz41ERkcXmAbfpX1GRnL71K/C5wT
         fDNQyvUkGEat/4EswH2hGkX4A79xPzTStNY55pDdzMO1/Sd3BBxU+dxJXNkGj/rr4uiR
         LVq6fzdm0Y/1n3kFxJZLe/Vso0U5URznN43jhiQ2NFR1Se9Z1L+RG6jts1TBE5KB9hWU
         1sTmoFY6k66xz7m2eHl+XdR2xr2tJ9gpsYXj7mmG9mP9HSvarFEE1aUTWGjTeGWm1P8g
         yC/A==
X-Forwarded-Encrypted: i=1; AJvYcCV2HBTMq3Jg4hGCSkyVPiTDNLjbjo1S8k37TgFZFDtF2ZKjiBrC7C4LpxobMedJnyA5hrdlNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTLAFpF4TfG5ZmiA40/UD4P5BM13jj89Ymy/bH643sFH6DcAi
	l+8cKRgANEONl732IWE/hgbOcDeMzWo7NLCtO3g5c12QEywq1TqcQcPNAyvpjOW5JubdkKwVOek
	MbJwkIQ87BQsYo9kYkn3M5qxFv67VFgyijg4YwhNh
X-Gm-Gg: AZuq6aITiLlpcMCnRgrvx9fwmcj23zTDF7xczVlNI7a5pTchrQ7OYM80y3GxVFTHJQh
	CgcjdZnG0eQnPrBJ5FCY+60ME9DZUGqvDoP7YAK4dS7zB2vSlNZKedbQYUed3cjxbp6O17yl8jQ
	dCxe3uoUDFLCmodp1ZnwdUAacpUB4fgB28qBCJWWqRgZxeN/QQX+g6OlYBMg3IkOJ6zkxlKwY4F
	WosHjCb8eO/rTPVh5PZGh05QEy9Wgegn0f98Di4AP+ORf/IVKHF3ZZFi33RJLoZ/BzIwYHvI1ad
	qd3LjcmDIhu/pojHuIvDYiMGuG2eOCUa/T09o++JrQ==
X-Received: by 2002:ac8:7fc1:0:b0:4ee:1dd0:5a50 with SMTP id
 d75a77b69052e-5070c2bd60amr156825011cf.17.1771924952622; Tue, 24 Feb 2026
 01:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
 <CANn89iLd=P2nftdMReVkc+d-8+0PGi1ACxhrhnVCxFVxNOhvJg@mail.gmail.com> <aZuaQSdsuWaAZza8@gandalf.schnuecks.de>
In-Reply-To: <aZuaQSdsuWaAZza8@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 10:22:21 +0100
X-Gm-Features: AaiRm522a6qXQbkPHi8t91KDO1mc-rlMizziA9EwmS69J1Clnl3Iw5_n02w5ZPk
Message-ID: <CANn89iL1rQ=ZhuQwNsxt2H1LPtigJbbNx+WtSjqDqJ1dmpF_ug@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/4] tcp: RFC 7323-compliant window
 retraction handling
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Stefano Brivio <sbrivio@redhat.com>, Jon Maloy <jmaloy@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0E56F184965
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 1:07=E2=80=AFAM Simon Baatz <gmbnomis@gmail.com> wr=
ote:
>
> Hi Eric,
>
> On Fri, Feb 20, 2026 at 09:58:00AM +0100, Eric Dumazet wrote:
> > Hi Simon, thanks for the clean series.
> >
> > I would guess you use some AI ? This is fine, just curious.
>
> Thank you!  Yes, I=E2=80=99ve found AI helpful for getting familiar with =
a
> new code base.  I also use it to refine or clean up the wording of
> bigger commit messages.  Code generation works quite well for quick,
> throw=E2=80=91away code (like reproducers).
>
> > Can you add more tests, in memory stress situations ?
> >
> > Like :
> >
> > A receiver grew the RWIN over time up to 8 MB.
> >
> > Then the application (or the kernel under stress) used SO_RCVBUF to 16K=
.
> >
> > I want to make sure the socket wont accept packets to fill the prior
> > window and consume 8MB
>
> I suspect generating 8=E2=80=AFMB worth of RX data in packetdrill won't b=
e
> fun (unless there=E2=80=99s a trick I=E2=80=99m missing).  And using regu=
lar TCP
> sockets on both ends would probably be rather uninteresting (no
> packets sent once RWIN =3D 0)
>

8MB was only to show my point.

A packetdrill test reaching 1MB should be doable.

