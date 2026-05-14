Return-Path: <netdev+bounces-288067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK7xHcwLBmqleQIAu9opvQ
	(envelope-from <netdev+bounces-288067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:52:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D16CB5458D1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 954B9304F2D5
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5138F248;
	Thu, 14 May 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYOv8U9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7838F951
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781094; cv=pass; b=UB/DvAL2eNfvhaC3VT4JKS6tzU1krssryXOuN3zYG0fWiDDlK/Di2SYRDpKZCVwadTH7Ud20gBTmax3mBenekgTW0d4XNZPCzhe8vJ34Ttr8EVnkcYeVLQA4k1PfRbLcWEYjzPjhNZudLHwwaeLIyY3usFWlv6Ph0EeRndrbKq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781094; c=relaxed/simple;
	bh=oEZTFGT/zsbjhwuKvWnfYPy3McEOR01XWhw4l9V3p8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLU+1/KXpFhp3mstiP7tf/Ly7NeWQd8OfH2JeGb2wrzvfWvNNmf8TTipuZfaR7FgpK5qv1pxWkkmzR99rRTU3a5lScxWtPB9H51V3J2vnkpND4DFfoPrGmwJXOI12GYIenZ/aaZcVqgUj74nhtwM0+L4XkzaPLZvK9zKYhpi2N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYOv8U9k; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bf695701so10589391d50.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778781088; cv=none;
        d=google.com; s=arc-20240605;
        b=KCnHzc9J7A/bHqtQPVVzFRTq49ZalX18To326PHjidPppE0TPaQxSrdHE+JOXCle0+
         SY8ScrCxLx7/5zk6D72lMlksMBvgTjL6BOH+t6ZeUju9SHsO2VY+6Uh1YLrN0+mSp5pD
         2EMebsMTDfrRAEOhuJqqpg9F+Yy7dAUdXBxURdmHqoIvLGrlV9yHd68bxheosHdW9uCm
         gdkNTIV0ZcnqfAhEUDDbJKNoqlY7S1EHLDCgmTDOTYFaLlzYo7zGOsJFY4TOnTwBxYa3
         gpWIeP+UPgpOEdwaEYd8Q5d8OG4Y+1kGxXudi9snDQVE4+a3M+pG36kzY0XSDNQ7n5x0
         9yNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wDiBZDMexEMEADEYdo6MQjjkOCysVPN+9Ft5KwrZRw=;
        fh=uSfr/3GiaSl1j81drYBZQ0IFJBH2Srteqm9nFGhbJ1A=;
        b=ajyzjECB1BlwJZgiIfepbuufEzaQ+iJAcFQkKhJNRUe7Ylgpmr6YCwbjQL/y64hTjv
         XqbaH1WkI3gkZfzTHR4ob5qYc5qUM7evY+wQawbriIT+2a9dJ9QxKSuGPiPTnoCETYRu
         0dtzpL9dw09twc4L8ysjkCKbW8YmpgviMopzDieXoEMypreDE8KzDIRBhbK65KDWxusY
         U5jmDh+opSpNJ1+LY4sGFScAk4OsCvZ4THIGNtppDKemsUFChny1j6VDQtYKmWJS6rse
         hLmKn4sqd8Qc9CUkrkMAAezi1D70tToCg9tb5zuHruDIRGTUa1fJPDk551SKYfEh4aCc
         gbow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778781088; x=1779385888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wDiBZDMexEMEADEYdo6MQjjkOCysVPN+9Ft5KwrZRw=;
        b=WYOv8U9kRDVZWcHQGhZunhQgkMDOaeuANoqDV6EQmSWDBtReTLpolS3t154WTR3lb2
         8NHD5SZKRdBYk3aFv2Qzejs54BC99AnBhyuZeD6Yeq+MU/icS/UV5gOx7Tyhq8vt8AXk
         qkmmT5IUG6o1/2peFbqHZ2H6SvC1BAqQgodC9Bd0OPUPMB7peIvD9/51aUCwAGGa1Lnu
         lQB188mz52MAGzutTME0f9eJWFkWGZ5QFTKJp9bM0vvnHLNxa9H2lDODY+IX/Y/Bge/k
         fN8PZ9DTmWmWQeZvrpqDKjtzOxnYou5pMYmESdR1k3p9HBA7B+rnsRTvPiQvxOWdvKVd
         5cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778781088; x=1779385888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wDiBZDMexEMEADEYdo6MQjjkOCysVPN+9Ft5KwrZRw=;
        b=WrG2f1wrR09TPLFru4uWVN2NbXJl2Fy/Tws8p3qmG/bi8Sl6gvFf3bfUllULfrKOKE
         EAZCocUbRXfLeQ37S1nCY2cHrdQghM596rqcGxYb3Ryucq8Dwm14pJHwvhrGJCwJNdFM
         GqqYxwbVnUgAcFYYIClodrgMS/OgrwW2gtbrlClq0ebJEbBAc7u3svlGeLvhCYm9cXLW
         e2Z/vxu/6eB7dg9Mz+0+J+fWJf3wFSAkuNcakQHAn/Dp6VgE6sm0r441vJawQDEMSQDO
         JALWNqfazS0MkuxOg/m3Xggc0B9XW3Awi57SGrx8CZfkrjNRmtxpTH8n9BcEaO/fAM6u
         9KCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/J0pvp61IIGImBHtqJoz3YKt2fyWAg0wMMPeapydK++wl34iKyRy462JzqmzbfpolZRZnYCn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzH1GNrdL07JeYwz4WXhU+IBaU5V833wngUije7l1sRqUGTwUC
	fDIKpLAPAi6YKX3uiACmKCzpMhfHLq6BhUpxYvCYLQbRjuU8rYNqjf7BJJAk2MGgDV6elTe60gA
	xc8zhW3y4U2lCG2HJy6VjVGYfkAwQo3I=
X-Gm-Gg: Acq92OGRA7xvWv3rxFZves5TKmFJoGXd9xxjV56zMrmIahGeTLcXrBaeIasvUkGbHcO
	cDNz2PEqbputWa5IpwOgPMi5+ojpoIh2BPoZJ3TZzUvu6ChAVKP+xuJn+U234/cowaAULUh6TJE
	BysfmU2ib5zUtjf0y4KJ/OWDXznbG0zEKQnCINK0TicKvY6MIPXDiZSvvadP8RqKKINetaSW8cM
	YWzCNpja40Vb2ROcVRmM4GG6MAPFrpxv+U8TA1lpCEehKWwZOIGpQ0lDKY7nyEOnf3iqkZ/sLTB
	Lk48hRLGVgyAK+aKBiN1fPpJTsEzJeCIqFpD4GMQUqwhe4SKSDwdI3Hbr+JBALR3811M/CZyfRT
	ML62v
X-Received: by 2002:a53:c049:0:10b0:651:c047:f09c with SMTP id
 956f58d0204a3-65e227d52f7mr245379d50.39.1778781087600; Thu, 14 May 2026
 10:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
In-Reply-To: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 May 2026 13:51:16 -0400
X-Gm-Features: AVHnY4LxOXAY7x1GGPoD-ZrWMAi2sQqAU3A0fF7icss2dq6JW-g14LN3XOF-d6E
Message-ID: <CABBYNZ+nvtMHcU9but5VEG891vyO=K0MF3OAGofANxzdLVmw-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] Bluetooth: convert remaining bluetooth
 socket families to getsockopt_iter
To: Breno Leitao <leitao@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D16CB5458D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288067-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,holtmann.org:email,msgid.link:url,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Breno,

On Tue, May 12, 2026 at 7:12=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Continue the conversion to .getsockopt_iter for the Bluetooth socket
> families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
> small precursor that fixes a long-standing 1-byte put_user write in
> hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.
>
> The riskiest change in this series is the SCO BT_CODEC conversion: it
> is the only one that drops an open-coded ptr cursor in favour of
> relying on iter_out advancing naturally on every copy_to_iter() call.
> Every other socket option is a near-mechanical s/copy_to_user/
> copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
> codecs + capabilities and previously tracked its own write offset by
> hand. Getting the cursor semantics wrong here would silently truncate
> or misalign user-visible codec data.
>
> For more context about the motivation for this change, please check
> commit 67fab22a7ad ("net: add getsockopt_iter callback to proto_ops")
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - rebase the tree on top of bluetooth-next.
> - Remove the selftest, which was mixing network and bluetooth together.
> - Link to v1: https://patch.msgid.link/20260511-getsock_three-v1-0-1461fa=
8786ab@debian.org
>
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Breno Leitao (6):
>       Bluetooth: hci_sock: write the full optval for getsockopt
>       Bluetooth: hci_sock: convert to getsockopt_iter
>       Bluetooth: ISO: convert to getsockopt_iter
>       Bluetooth: RFCOMM: convert to getsockopt_iter
>       Bluetooth: L2CAP: convert to getsockopt_iter
>       Bluetooth: SCO: convert to getsockopt_iter
>
>  net/bluetooth/hci_sock.c    | 26 +++++++++++--------
>  net/bluetooth/iso.c         | 27 ++++++++++----------
>  net/bluetooth/l2cap_sock.c  | 61 +++++++++++++++++++++++++++------------=
------
>  net/bluetooth/rfcomm/sock.c | 30 ++++++++++++----------
>  net/bluetooth/sco.c         | 59 ++++++++++++++++++++++-----------------=
----
>  5 files changed, 114 insertions(+), 89 deletions(-)
> ---
> base-commit: c2f0079e8c42fd6814c8d6b1491e3ce0a0e3b3fa
> change-id: 20260511-getsock_three-d0d7f1b2629e
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>

There are some comments from sashiko on this:

https://sashiko.dev/#/patchset/20260512-getsock_three-v2-0-30b7b22ef14c%40d=
ebian.org

Now Im not sure the truncating is actually used by our tools, but that
sounds like it could break userspace if we don't check properly, or
have you already done this for other socket families and it was
considered to be ok?

--=20
Luiz Augusto von Dentz

