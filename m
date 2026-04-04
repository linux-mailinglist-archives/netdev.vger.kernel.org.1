Return-Path: <netdev+bounces-275398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMPiLq5J0WlwHQcAu9opvQ
	(envelope-from <netdev+bounces-275398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 19:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD339BF3F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 19:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5756300B45C
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49028CF6F;
	Sat,  4 Apr 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foj2L3PY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85184299A87
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323556; cv=pass; b=EGd3EQgKA5gV4VjVJnyoQYggnHgzvVPBUmcxmMYsPPOWbreBCCfwzIK/QuAHuH1GxaQnQpvg040M3PjEVxASsMfXQlOz1SIFkl1d9oX33tSfDYEn1rDYQmaEH0VRnVBFxUGPnQPEsXiCPsSOPamY8uisgZY8SIu0kqUqsG+5Qwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323556; c=relaxed/simple;
	bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZUccowhOL3Zl8DRBEFASWU7Y/Pv/j/4Tbq0i9Ta3DL9ajSQQouxf1jBTOpiqtWA5ZH4L9ut3ErCxamYOl7uOh1f3HGlFjS5ORYrb/PVg2CPip4eIvn7EV3SSqWI0M9MjYm4ECfKNrdoeDEBB2a8mbj7Wsqg43hQmLZFOvio3UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Foj2L3PY; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66ea74f472cso508414a12.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 10:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775323554; cv=none;
        d=google.com; s=arc-20240605;
        b=lrr5lW4NYA+Lt6KXscNpTzrP7WgOxeePzIYS+HwScb/qw9Bj8U0KWN/R5PKWZhEfZI
         KKmJKhnGT8bym1E+vJJnLuqLPfAIB1VsWfRy3YmqfNqhZNc2FF5bGLUAz/ZcMe8O9JAY
         stZzFQX4R4cAhIVGuS9HlE+8WoqApt1TBLjpj9Ie2kEz18UUxc9KXOrj2h1LcEJ4LGp+
         WsbC9D6t2pc9dBKlDqqh2EfwmBVYoNIPWg4WSGnZB/nK5nEoFS4K38rQjvTGtxdUBDmO
         9Bl6b+qVUBO98aBhVxusf9Kk9DN+HFRNidiQ8KZ1/pA8vhEfK8aWh36CA61MR8mifFCR
         1xIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
        fh=A/9K6+8mtkge4UfDGah/fZVkBMmCtphYr4IoeOJGBhg=;
        b=Rwsg7zbi746YUx08fesrOsGDYtTUFq1QKvjunaNHF1+d65lhrZudlu3g1SYleIpmmq
         OnPwaDBD54n+qePvGRk5hFwvTOroQskGbQ5xLNKKsHBSDRO+bQGxmAPFkW77mUU3K+7M
         vHFhljUuIIlcvdH0HTJl9OpnX73ROagGxBOH4Zc8wcVJrtwwIDKA8XQg2GsOU6Hkg5b/
         Ze9LZoxw+QobcMlhSP4Jydha2CXvbbpY9sg/XRV81q8OSNH7rkJJvdhx8i/BeqkVKzwK
         +dAlUjApAxG6dhKT2/njx7se6mF3gY9yZpNyrI+tWg3r83zlUG00KiKALN3fCQUiJb9+
         IX9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323554; x=1775928354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
        b=Foj2L3PY/2C5011OYzRTRh+FtzyiYjsJW4ZTU0VGU+uhDG0Z0IaNv8CCV6Mr6Ra6Jp
         hnsPFwzH9rhviGQ4/znbhQCN4YLmWk4FaWHU48bCBFyH3NjBqd9c3FLFBX7d1kqnA9hq
         165DkUOCUm5PsRAvobBUqBUibwtY1+Oe4BKgwNvlPnjL27WiwkIUHjqWGqgDSrguktHr
         ZCDb9kavuAG76FUklKoCVDB3mxwrmJ4a3oktDSXY3PV1h7w9K8bNLl9jqGsZkXegR86O
         PaR8p+pEho9EcGcoq7BB8KAkdA7vujIzmjwjO0FWjgjOkZV1PRN6002emu5EDVT2eTP3
         5qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323554; x=1775928354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
        b=sgQQnSY4GSewCAi0HkzneljQxYwieSZ87CzUurbRO7Ab7a39EyfGC+Go6YY9TnW0o9
         7uR2zjC2yCNT4RqR3XiULJHRKket0NrWrJGJv4qT5IFl+P/dm1nhFkfFQgNfDQ04gf6P
         +I6JgQxNsSNc3w8uzW+p9n4rDOZco8S0wqldoXM4SM635wFYydz8cZBKdZNlodiqpSie
         JXemMngaFMqmlAR4BbtDUaw3JXryIWcbWCmw+EGXwbc13KkvBgCqkJEfB5GA0/NAM1Qe
         R2TZNRUUGTT5bCc3bYzA7u3Ju3f8ufI9k/aErVed0ewXP45Sv3ei5KHSWfbz7iOxwzWL
         l/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAYaOBHtGCxXWVRuBt/PArVBtLDA5U7ttcO8hsNwBamhJcziko4/JKVU9PSWE/lIqi2+Ki4lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAI12JBfVyh07rqf8X4IPs72XtRk8Zmb2mQI5TPfmx7nmshpT
	E2saBVBAelpvou0uEgRWpKBy2xg/VEnGmzb1Exww0h2lRL+h0Rycmb33VBytVVf8FzEiR/yDhtI
	1dM64e8ZqZoCFdhhO1Hiu8aDOz6aPhPg=
X-Gm-Gg: AeBDieu33m+EOZ0EnOzbAJAA97hb7dK/NfXshLBR2FuiFThYHo/sotyrGO3pH29TaWI
	NUSMhQpqEZEHmttlLIXhKAWKn3ev2Zhg5vb3nGxCdJyQvzXuUlk3sC5iTADV6IMimFNlISwLIBJ
	nbXbrNmf+LCritCH0M5hgI5UGSs77JBhovFuBsWq1XCQAqs7SlMHE42Q7gv8zwN2G1OtOmmnsYV
	VtCHxYa4MjgA7Yw9XNm4yFkmmFCEqWgK3kyk6ij2gmPKu/+O2j+tkG4Bwmn0zk+r0o1/fCvUWF+
	XhSfPIg=
X-Received: by 2002:a17:907:ca19:b0:b98:4b8:1046 with SMTP id
 a640c23a62f3a-b9c67922d67mr245594366b.31.1775323553422; Sat, 04 Apr 2026
 10:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com> <20260331141647.GB1637150@shredder>
In-Reply-To: <20260331141647.GB1637150@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Sat, 4 Apr 2026 22:55:38 +0530
X-Gm-Features: AQROBzBVeQxzaE8wUvFhFsGym5EPOw52jRhY5t-OqeOyQKNixaLBWAKYKMiyQyE
Message-ID: <CAE2MWk=CSaijB_x0BzMtVGjuibqbzuCov8y+3Hm2UodrJJpF3A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast
 exponential field encoding
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	Kernel <netdev@vger.kernel.org>, Kernel <linux-kernel@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275398-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 22FD339BF3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026, 7:47=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wrot=
e:
>
> On Mon, Mar 30, 2026 at 07:16:06PM +0000, Ujjal Roy wrote:
> > Description:
> > This series addresses a mismatch in how multicast query
> > intervals and response codes are handled across IPv4 (IGMPv3)
> > and IPv6 (MLDv2). While decoding logic currently exists,
> > the corresponding encoding logic is missing during query
> > packet generation. This leads to incorrect intervals being
> > transmitted when values exceed their linear thresholds.
>
> Thanks for the patches. I will take a look, but please read:
>
> https://docs.kernel.org/process/maintainer-netdev.html
>
> In particular:
>
> "The new version of patches should be posted as a separate thread, not
> as a reply to the previous posting."

I have updated the cover letter title and sent the new version as a
separate thread. The same can be found here in this link:
https://lore.kernel.org/all/20260403150050.1235-1-royujjal@gmail.com/

