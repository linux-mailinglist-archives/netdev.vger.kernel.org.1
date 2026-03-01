Return-Path: <netdev+bounces-262459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0l+4JJjMpGkCrwUAu9opvQ
	(envelope-from <netdev+bounces-262459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 00:32:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A41D1EF5
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 00:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25586301017C
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC73277C81;
	Sun,  1 Mar 2026 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJmmGUhG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE71990C7
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772407956; cv=none; b=kt0vesFZBBxBJg2uthAu6e50ROr7nT+mM3PskaGTF6w8RFQenIyzDvY4z11jnMNAsYreG3BCGmr13yaeWs8UkpjNvQNZH+QVMF7c0cCMi/7K484YIlLUWiFtGXnGafGoBSQSnrHRJ/x1cNx5SnIV01GpOlY7d26n5LfLBjsuSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772407956; c=relaxed/simple;
	bh=E9+8K5X4PFgbviQ5fbMMaqHuGnu5jFGcIv4+c8sTzig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+kj9Hb1tRZwBAHNVb6CxYXrR0RuToXpbEKua8+tpdgq2zaD2dXXamU0kt0T9sS8lRDeM2VgtPiICFnIdT3J54+lMYx9Zzit+XtD2I4FtHaw62RJvf2U4YB9iahyDZ3ZT8Q8FsLXBpXRRdrjeuxNX5Te3S5OoQJfBObfGCgf4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJmmGUhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4DDC2BCB5
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772407956;
	bh=E9+8K5X4PFgbviQ5fbMMaqHuGnu5jFGcIv4+c8sTzig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AJmmGUhG+Rx3fYegXZkYQxzrbXkY0+7ai+ephpaQ+mcXYzC4deYFqxoUp3RTj6hp+
	 fyZhNniW60GBr0NvI1O84JAeiONxRyfdooBaL8onkEBr5LNvbt0jpHULyMAVMN3Ce1
	 p/cPnB3+X1C9/jbXam72Im6OISmUaN1VZSZwRtr27bprrRaCLTqR37+aWT3CET2PYf
	 yaQKNlvOaXIr1kKKVOjyYK4/C5PQBliOE5txlU5Z0EAoOrYBNokYEo6qo4oCW25uLV
	 j0bNcAO+C3kaThi9Cj2Ej/jUrVUE/DzCvZTNd15Fl7JRr+a464j+oDjDCaXJmKrIec
	 yGdA4EU9BGL5A==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79495b1aaa7so33019727b3.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 15:32:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUENWvnWZIfgAsVnYbJa2rCmAyRRr0tAMfluw/B1DlwQi/Fgd/w6PCT4lqFntEC+cfJefCyc10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIuQU/5jmppoWVyasjI0yUH0U1h/2bInq7IP+9W0zT3ebXtMU
	Qnye4j489alW2aZ/rlwWHqOlnOyBjGBAonKa7GxVuwi65s5SyrBa5ou8cBDovGRShvQBOL1S2iG
	S8sIyV51DNCAAbN0dBjiHa9zn085tNv0=
X-Received: by 2002:a05:690c:890:b0:796:5a14:87c3 with SMTP id
 00721157ae682-798855df177mr85506547b3.40.1772407955381; Sun, 01 Mar 2026
 15:32:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com>
In-Reply-To: <20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 2 Mar 2026 00:32:24 +0100
X-Gmail-Original-Message-ID: <CAD++jL=_HO3fWntEJ9=qM6t=L1qT41dNWRU5LYGR7_2z7G_hCw@mail.gmail.com>
X-Gm-Features: AaiRm51FHqD_Cy7PkXkrgv3GLB0glL1EistMVS8VTEFO-XqofykOvqymFuZj1Js
Message-ID: <CAD++jL=_HO3fWntEJ9=qM6t=L1qT41dNWRU5LYGR7_2z7G_hCw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: fix
 rtl8365mb_phy_ocp_write return value
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,yahoo.com];
	TAGGED_FROM(0.00)[bounces-262459-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: C92A41D1EF5
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 10:13=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
>
> Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
> occurs during register access. This patch fixes the return value to
> propagate the actual error code from regmap operations.
>
> Link: https://lore.kernel.org/netdev/a2dfde3c-d46f-434b-9d16-1e251e449068=
@yahoo.com/
> Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PH=
Y register access")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

