Return-Path: <netdev+bounces-293608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFptC/U+HWq8XgkAu9opvQ
	(envelope-from <netdev+bounces-293608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C161B4C6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F70B30162AE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDF38644D;
	Mon,  1 Jun 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgf3ZrBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5823242CA
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301553; cv=none; b=dr8cS4h/015Ekuyca4nd5oVkbGDBxU0WUSJvsuOSbdR1KEihBYvTVc6nLdTKTyOi/eMaLe+yPl02QY3H8cfOYBPS1E0TA11ihuXdUxO0A3mRGqfVikXDRns90ppCwzxE8qoVp6uxcQFCyxgzLrRK7I2laHUQfDNiPnPx1QUi788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301553; c=relaxed/simple;
	bh=b8B8XYBKm+lVpv2IskSnUzRO6kERXLWeYR3tawxyozA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgd7UwvKcHTxLwS/2XPssokBmq5hdDlhCC+NFt77YucqHCKPoTESG7s8BFG9ZtIclYMILRRdB+qvG8DJnYZiTzph4lxZjH6+MZIk07gnKgADcfiP1RsE63QT5pyy34IITtXDcvSF0ArCxcbJgTitwwq2d5flluzH6gWY7wZmw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgf3ZrBL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E0B1F0089F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780301552;
	bh=b8B8XYBKm+lVpv2IskSnUzRO6kERXLWeYR3tawxyozA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fgf3ZrBLcl4WREs84KRMtYah9V4k91hzixnpqsn+4yblpIougAk6LkNXiUfHQVEdO
	 usbB1yCaVoLag22UktUC/vdMmE8TQ6LBpYv39lkW4A+iLwTECchPbWNqvcoA2iQ2Ct
	 eNrmroBDbHYzrn+puL3CjEuVabe2hAb63drU/eBQEnhCGczH53KQq1u7q4p2SxEZeJ
	 NNDNWdF0bONl5Yt4ssc52Ik/j8LEBHSv9aEGx5JEdEqMMAodos/pmrwul0Iu5Sl8io
	 JsYndDXhRfnHGaKrKSsDuFuK/xVxPjjFdOYVjokSdLATC5Q20MLZEceK8obX9J/lxj
	 HyDbLVDSGmKYg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1278700e87.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:12:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8vg5vmP3cYu+yPApYdj7OQZ9eGciqb5WADzOeoXYnOyl54KoI8NhzjOn2YlDxEbTZjZYfMzcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5i6tRmAv8v/Yl1vUD0P9o4b+9U6SXMPt99WQz5XtVU9PJLv0
	OFDb3cF/5+OazSHlQE0bpDc7Txd4Zoi8KRdFsGs5Ht4PzHmFuJ4rZhXjk9bXTSjDp+iA+8XQbdL
	JFXlkBV6EbjYvyaMJ3GgjAc8qdbEMseo=
X-Received: by 2002:a05:6512:2215:b0:5a8:64fd:142 with SMTP id
 2adb3069b0e04-5aa607c4e2cmr3334002e87.15.1780301551459; Mon, 01 Jun 2026
 01:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com> <20260531-realtek_forward-v11-2-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-2-50d60f5717e8@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 1 Jun 2026 10:12:18 +0200
X-Gmail-Original-Message-ID: <CAD++jL=zq20yzjGybBXEcGLvnYe-Cbd4tQPbn5Dk2MDKtCpObQ@mail.gmail.com>
X-Gm-Features: AVHnY4JyRl1je7aw3ES1flUxJqu-tWTnHJjFF2GRoBuvC9hSBbnSHto6IY6-DQQ
Message-ID: <CAD++jL=zq20yzjGybBXEcGLvnYe-Cbd4tQPbn5Dk2MDKtCpObQ@mail.gmail.com>
Subject: Re: [net-next PATCH v11 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 952C161B4C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 4:53=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
>
> These topologies were already non-functional. Without a CPU port, the
> driver does not activate CPU tagging. Additionally, the switch hardware
> was not designed to be cascaded, and DSA links never worked because
> CPU tagging is not enabled for them.
>
> Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

