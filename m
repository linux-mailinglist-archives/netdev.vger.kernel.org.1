Return-Path: <netdev+bounces-282397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEPGH7kK8mnUnAEAu9opvQ
	(envelope-from <netdev+bounces-282397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:42:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C5C495037
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B3B30205CE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6393FE37C;
	Wed, 29 Apr 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8v5W6Bw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9923FE64D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469993; cv=pass; b=oIgXCZtSylVrQkr0cXAni+7UuuzbuVDpRz/5eDDPslBncher7pKMNm7cKjBoPeZmUioK8Ik/gFaYcfOK4k9b66ctRuN2vf6kSkbGjSVyCJcgAJCQG618gpK65y/IFfmMWI6QVOBDJggVNy5jujz/kQmS8luNWu6g+uZe6sF049s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469993; c=relaxed/simple;
	bh=6lTwsKzoco8204zJA+A8A8Aq9fKPHZghXz1D7HXzSlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcA7yLu072sv8GGIeem87YL6O6/q6k3W5OdHBOHUtF7nfoDIhPiB/3OvIhg8xPYNS8YkVCy1JtpwUUM4gMeQKRPh+Y6VLlDUI17PBXVgCp8eDBVeDNd7fyRP0+OsXgc9LGjr3fQxgVQ2YSfIQLWU/DjjPJ34+67IaENbN+MJKW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8v5W6Bw; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8aca0469204so120180996d6.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777469986; cv=none;
        d=google.com; s=arc-20240605;
        b=dkc4MRv4EiqsLzdQYzi40SvAPQVQb85E4KW3sUxzAW+GHqV10mt5CPQLio96DIDfmk
         1l2XcU/b+urxMLQG8mddQx72kbuVdRn2RsF3sW671sRYz0CRb6JgD3TBSECTK0k6P5t4
         2M3LB4OGSp22vnnljQVclzTCpfEhWmMil5oTo+UH4CK9s7Ipheb5v+VGUUg9+cbR3+0Z
         o3Jqpsi7NztTfqRqO2A/d48JkknqD/a4yGkCO+J8cyP+fnH+na9o2+F/OWEH46yq1lqq
         lrU4OJRhc2vlk7RATsvoCpsT2kdoIx4hcB4yoqM1NHfjFS299rzlIXoqYXFUrJPqooht
         9r9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmN3i4v+qSq0c8ObecbxP86npQAGpZY6vVo1lKQcIsI=;
        fh=CtCMkVpBxcjFlkfZ5kdqrftw9q4mnFCfpPflswOn9fw=;
        b=JLJ//6EjvIaIeAkNh1SCBl3kmUIp9J6JBRDPxZmx0AnNoxFZ7/pB8I24/PoNu1tC9Z
         EhUljIJRO5a27PCMKqCtp66Dn+JNtCt7fnyAVJeKkWOUls00hkzwQwAoBkYF87zgAvu7
         kG7Oomx2fBdLha1IOhR0nS7mos9smnhEPppGjrkSH2rHVCTaYrQzMoBoUz6FojmRdmIl
         /kyaZM3GtsU7WtXjic1gQ1Y7oMpreudg6lF93du75RoBcY5s3ojXhHgJwLh4cy1pNeZA
         D75r8Ik5tKFk1URB9BFZ9pgzQDgRtgUfQcwJTaPr3R3vWozC1wj5ra2eaPyL8ZDidhYH
         9snA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777469986; x=1778074786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmN3i4v+qSq0c8ObecbxP86npQAGpZY6vVo1lKQcIsI=;
        b=g8v5W6BwjJ4Qw1eV5jRd3o0CHlPMYHSX52aFfdVl5GpIqu+sq2xNKXcf41xNZZ4mah
         MydI4jK9IxctnQGN7U0crBPyK9wYXLojGmsU5CJI1OAiSeb4U6PzBN+KqjVk2fckOikB
         WIxuMmuY9BRexzuAMoH0D4NSSlUnC6zEA5RswKN/fmaIN9zRETvbXMOQwpbwFD++CW4/
         mXrlPbxSDAf3Sdyum3a/FHsz/KBzjJaSw73mpxumTPWddJAOnc7RQcyUASTV5i9RdMxY
         vJDqmkoOHr1foK90/ws+5WPoWAzPtCZrR8LPOj8+4pn1kkSgRJY7jgfZiq39AWsVay7h
         OgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469986; x=1778074786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmN3i4v+qSq0c8ObecbxP86npQAGpZY6vVo1lKQcIsI=;
        b=VQ1i2jKW55JYShPkDydWd7F0+6+zrIC4cEWesm/+HTJ8p/4cGXKX5Uatn9ISh0ZOqO
         Pze7YXt48vysBL8IxiUOF+65VmjgM25Z4fh/qi/k/eZ54G5jXHiZEdfCt7zBvMOqK6eG
         jx8Cx6hOYWctl02dkZioI6IHy0d8e+L4nTUOE1l0NmyMlybVIs6a5aRitOkdSbZadr/b
         4EfCq6stId8EHtve1Ana426vVPDA+xF/4/THtnR1K3oFMUO6xAMwTUwNMxetcyj/vfAk
         cAggDTtt0pi98euWSYljf+7DYtlYJF/rh0gvmY74XUNr/L2Ye0fGjA9ZeuGSg+i+Z5Gw
         L34w==
X-Forwarded-Encrypted: i=1; AFNElJ8xdDm25Kx4ZtFD9tvN1Sn1jQsyPDUJxGh9txSlvZIYtDGoaGhv5CvsrF+HOQyoaPIeR1qmkvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMXkUtCMh48pn2iJI+hU7q3+tnY5tptmQ70xuLs32hvmRsBAP
	dE5FM1dvtF2ZsBGhOsZa5c6D8lCuTkIlUJHcvJIvIuLKr7PKa7jEkSR9TsA5SNxcxT0Xwtg7iQR
	aK2fBadLy5J5cUdToS6UUzCQZz8pteRxBGCN3hIGYkr7qw85hBcr9WvWs
X-Gm-Gg: AeBDietvpNO5qj21u+oEprVnqEE2TQEamvGmfJtc8wR/cWe0GFqGZD5rIbBfc5x1t0e
	q2QWfpNiHRJgvEw+7Rl3BxEJkBBGypoTEJvMk4CUxGzFVwAG+OkWsjkoVHWZrb5DzmvTov34uJq
	0AD2tOcPVVYolf89LfWmEp78VVyN5hZWSZPUTnISZEOTHdsItOlLzF1mdpInrte9kUGZr20xLEq
	Ny/eT+6ShIHJwN0VbfvoPJBz6ACVromot7Gvaz+QH68VTC1RlikcMlvJ+n67HXm+yjLo1wOozDU
	D1GKYU6oe4dgPQ+UYwARwiGYHt2XpHLU2xDHhC35E7gOo/j1QdXTQ40v8COjLaH6gcf8aAQUnvg
	4VGIscrRE
X-Received: by 2002:a05:6214:4c47:b0:8ac:b9e7:a969 with SMTP id
 6a1803df08f44-8b3edd11dcdmr58201216d6.21.1777469986048; Wed, 29 Apr 2026
 06:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429132218.3548644-1-lee@kernel.org> <CANn89iL_o4dJ-zgjGzA=gGXiVF1P0TTz74LJNuy2zrgbxB5S0Q@mail.gmail.com>
 <20260429133742.GE1806155@google.com>
In-Reply-To: <20260429133742.GE1806155@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 06:39:34 -0700
X-Gm-Features: AVHnY4IUl3LUyP0WG6LdMT45HU-ADOEnuAV4yl8wsmAedgBrUgIjyR9TT__oz7U
Message-ID: <CANn89iJGh6-Nfm3ox8HKRUgnDu5W70M8EezgHvG=VvO8VP9gNg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfc: llcp: fix use-after-free in llcp_sock_release()
To: Lee Jones <lee@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 23C5C495037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-282397-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]

On Wed, Apr 29, 2026 at 6:37=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>

> No problem.  Please ignore both of these and I'll follow-up with a
> coherent set with `Fixes:` tags applied.

Thanks a lot!

