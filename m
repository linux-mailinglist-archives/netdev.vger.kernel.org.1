Return-Path: <netdev+bounces-282445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMWtH+U78mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:12:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FECD4980A6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1518D3031283
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5388410D1F;
	Wed, 29 Apr 2026 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHcZa2+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418540FD94
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482566; cv=pass; b=b8rSgJLkoOMAeOxjfnvprxdT9Jwx1Kedc9ZthO9MX5XsFO8PdKvKZ5Ve0M7Uwu84ayW6IiFpjZRjJnuYW/nzTIl4MPPTGetcTlzS1ey8zLl27nXh99VHUXdwcmWUW7JE9s7DZusknFZ9+8IUyc0YJq1ItJP3MR8YpWKEAkzPYb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482566; c=relaxed/simple;
	bh=Jc036UNFiTk91r6U1mllnkkJA7+qa9C1cyx94UKntPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2vsYL465IwXtQ4mMp5joiQY/EAHdohEqYaa7ZzY1dCsm6O/+QQ98ZIw9MO3FC7fU6Gen7lSFOMrHqysQZYNXcbFHrabmdqw9j7OYo7VbK/A7yfTiewCt90XIXvSWWVcD09AHaF6ZJsZKEhQ5IIsJncg2RPwIc1MfVJe2HkqzqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHcZa2+K; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ec37d52c0dso494085a.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482564; cv=none;
        d=google.com; s=arc-20240605;
        b=IMeH1m14wmkTqoHUtZ3TS6ZUkKMPRuUW/h5XURghGCnJzpu97iP8qzOpahmWNnkMCm
         0EIJD2miq1qqEyF6TcUPFyjg+MPQFpEeD4oUybYS6lfC9qa1AwGorPnqYDnCF1bzrZrx
         PgzWYvdS3+GIQscYTKhQO0cE3zPVpQ33YO1/w7dUI8v++JCRhW4YBy7F/L2oS37iaKMV
         0c4jHX0oV6ZSZLPOe3AKiSLGBgo08S+lwoc6GiXaAtOBPAYHLYKpOgkWSWJZN70LZX1O
         /s3tq0mkMyFE40c1nIjc0tumbwsHaL1s4gVMdERPOigkPXJY/1z4s0rzlQ33eMz2IWYq
         kLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pcySCSuyVJ62/qChmzgFkWLnmc44NjB6hJi/T7/VFws=;
        fh=jNCfrwU0fZejb068WWejcb7fSxD64QydUnbqf1cCIWI=;
        b=JyFlsfjnsVp//0OGyXgqpcxHMs5MA0IGyesJu8w4JTietIyTj0O1hf2DaAB6BD3SLB
         8xrXvrv5hqr8w/1N3W6sdtqQV7/ysfgegYlHxvBdpYfY/BaOYzgvVkJR7vDqbLShdLDN
         HRZmRZKXVLgyFUmPomBzalFINc40ThI2aHJEYX+BmCLGyvlmu7hnjL1iruPXG/Yt3R9s
         Qq+g9PDeDkIsKPLchqf+xPUQWneIcwheYOgs1CbGjA9FgFHN1srLEOktV5zCoQm3NrQ+
         pTWlFI0ocTcC7AKrkiqDwsSsa/LOZwkgOWpCMprDE0MAsB7pPiM6zbwOPCyCIo/18wlL
         TxRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777482564; x=1778087364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcySCSuyVJ62/qChmzgFkWLnmc44NjB6hJi/T7/VFws=;
        b=RHcZa2+KPdhw6QIrjBSsf8a6rgCpyExqL0HhkBQ69ISnz+NE4tihm8jd5J26bmBEau
         sIxXe1PQ1m0kWY48p0krolwRHWl8PhjqhmsYMi3hAruTTzWeBwwzyxyn+ZoZTGc82/bR
         kbaqkc9zPtiNo8Vt/NomSQN/uPRMfHqQan8h8M1RAnf5cLsFe43104gR2ugGda/2cIbr
         LhZYi4Jq9D7OAthoynUliKQn+QrLMVo1FuOTHCpvxZ+6yasMxEFYF943PV81FzYN1vr5
         mgKlaTXz3pAyqkP1HRnfcF7XdK7IGHhWKcSe+BrOiC4HE+1Bun1u58Z7/N8tMOozQt+n
         w0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482564; x=1778087364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcySCSuyVJ62/qChmzgFkWLnmc44NjB6hJi/T7/VFws=;
        b=pjhd8l+RK5tdZKjPHXYf6OavdamOTFWsh9YwrH27XkouC3URAGE7DS8kqiiikTTW5s
         BA2+Kb1LZz5DM7bBvfQ0ONOyIxV+NeMT+puP8vdQVuwFbTe7593nJinReRYNPRaK/5gw
         8IHg3z/oeyPkkT42ZV31yKqCMYKwZaDMeMvqYHPoFjBb4tNtALvEiC2IdQUYqtoDyWvr
         yPyyYerakRHOhvHfftxfAJIAIaHh80YO8M84YCj4ziVkvU3klrbOKpoOZTr3QDUW9bye
         tMaWs3gJm8EEuMBpMDLETp8HzPdw8xHTlfa5Jt6c+/y0TJpbCNuPPnppAJXUpQxq8Nxn
         f1SA==
X-Forwarded-Encrypted: i=1; AFNElJ8E0mmxWR+fW3mFcIw9TwB0n97Q4gQmgqm2xsVqNeIP3qVMJ+2vJLpQy4UE+qnjpM4yVVsvfk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAmI0vBddD17b57IP94hRuMXwWVW3wSxaAHnwlwwOrvoCFSer
	G2070fqXGB/icIkNyvQTyQFd1btrdP+cLgovSLFsYcTS5ORA/Cz5GQtRBtf1vBHE9F6HfAuAqq4
	qlDTUb2a6RHKSWoWQALx7kUCwlsthP9ZOAPtaUadrr2SCast9WNNhpCeDdjQ=
X-Gm-Gg: AeBDies+yF5+BTTOKIvpUsjbCnmLBVtoevVlfbITFqMOyyhuXFE76cPiiAdFx6lqX8y
	ALRlH7dnQ3MoP95BfC4mBztZmf5y4kClSicpB6jRxgYt7btigW+apGCc5ANUKrnSzGEoO77JrRg
	kcJA67sIp38eLHCop0i+hsJ0j4kQeCde3UdTSgrKemhX+ky24DGl5In9+/FTvWNMbUNXcrWWCjm
	MumUjIOhVpQ2zVeAPHYwkexAM6rFyIxXVSoB8bXVydz8dKNExfx7wL3yPZ6f4RAv3z0tsKL/Yme
	KUe5E0RWnmRQKJ2MRAFrsL8UfDrj+o8h/1AVVqJF9tgwXohPVdUGv8rcPBKhlkeisss4aTZFMn6
	3eNPraRUh
X-Received: by 2002:a05:622a:653:b0:509:1ffc:c538 with SMTP id
 d75a77b69052e-5100e1258e9mr125471931cf.19.1777482563719; Wed, 29 Apr 2026
 10:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429080036.1528533-1-edumazet@google.com> <20260429094805.1aa6bf3c@kernel.org>
In-Reply-To: <20260429094805.1aa6bf3c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 10:09:12 -0700
X-Gm-Features: AVHnY4JihzGCJr-PNb0zSHpuSXK2T9COzFsm8evSoQR9OVGayBJBzpiQWwlO8OM
Message-ID: <CANn89i+KuSf8PhAsf7a=h+tR1c8aLNdiM6NzaBU8tjpoLAfcQA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3FECD4980A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282445-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 9:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 29 Apr 2026 08:00:36 +0000 Eric Dumazet wrote:
> > This test checks syncookie mode is able to reconstruct some
> > client options when TCP TS are used:
> >
> > - wscale option.
> > - sackOK.
> > - MSS (in a limited way).
> > - ECN (not tested, because of limited value).
>
> We're getting:
>
> # TAP version 13
> # 1..1
> #   File "/tmp/code_oyWax9", line 223
> #     assert tcpi_snd_wscale =3D 10, tcpi_snd_wscale
> #                            ^
> # SyntaxError: invalid syntax
> # tcp_syncookies_ip6_9k.pkt: error executing code: 'python3' returned non=
-zero status 1
>
> do we need to update packetdrill ?

No, this should have been

 assert tcpi_snd_wscale =3D=3D 10, tcpi_snd_wscale

I initially had a value of 8, and decided going to 10 just to make it
different than the output wscale value.

Sorry for the confusion.

