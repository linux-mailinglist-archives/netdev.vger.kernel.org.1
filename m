Return-Path: <netdev+bounces-260407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KgEKPFonWnBPwQAu9opvQ
	(envelope-from <netdev+bounces-260407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:01:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD718429E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B618230C1BAE
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D336923B;
	Tue, 24 Feb 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ06zKs6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5736681D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923510; cv=pass; b=F/mtgLlHLww1DRnJUAfzrCPBSULvsWiZbroJMykW6/bH7KqBe5pMAZZPsQOrjKz/iYcYE9rFNahBVHwclvlAkVpG8eXN0pK8jwjQVs4LaYg58EJBFvIYR5RnMBbw2b7WfStJYO21iXE8gA9WfrNKaSG7Iybv17k/YmrFkWy1uNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923510; c=relaxed/simple;
	bh=mta6LWH3cTBXZPT17cmG9x77cb73YKR8dmdhfMZOP5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbkfI2Gokxos/LRrKPS2CgwNoqiq+oJGmIHNinofKqODOqXqmR226zUQw72075Q34SpkNiKjQfNkef3Xfddp+J1Gqjs/RVXkvibnVJ7vFySn1oP5hXRDx9aczPt/lf1hUj5+jjJuCski4b6++nrOToxh6RPLiY8cMIBM+frZj60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ06zKs6; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c5a7785b4so7985049a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771923507; cv=none;
        d=google.com; s=arc-20240605;
        b=Ezp/1wccThSFKIw/gLGUNhYamP61QNGlkU3mVH75AREOvEtDN7vDbtiQWSppkALTL2
         6UvAoX5OGPzEcoQKkLAqDbnG1+pIa4ZNs7b0h7d+iYNS6WRLCiJUs8X/awgfw9yYZVzz
         zK0bDIw2jnzE80woINCas33YquT42cY1zmn/sKEqMiklo/w6SYR09fNATP5BmM6cNJ6z
         JfpXe770d4A9agZ+RnMrrQ7SD5/ZJyBBnpNGNwweGrHD0ARme2RfIhyj1Qt/tO9295/s
         EhGdzE7yRzZcbioH+YuuCcdnovoAo0iUSMD91lYc7wPlkCDohiSS010u0gBuOH+OT+Xv
         OD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=faiZjMOkti3cU0i9Gy2EPz0ZebIZs9O9WnlPDsTpWAc=;
        fh=SXYNJTJg2zL0xaRB9RvULz36TBANkolDBUckpN7+Btw=;
        b=QcEHVGdJnyQ+nP10XrLHNx83wzybsAoZmcVRjHPQLqKK5tCs8q6R4feqYRFH1r8o12
         qWaQbD2gCFEu+Cie9HFwiwzcCk6EkCU8+SDr3cX4IiMGAWk1AuCFj/JZOnohU7hyoAmj
         MuG6NrJIgCfyCWMC/xC9/ZzBt7Urx2q0dZ/i+YzNrxlLM52l0CuSiBo/rupSEWCwGIW5
         KFikehbcpysfrPKvU//OSl2USD9BFD/phtpjcBTVXonM3Thwpt2UGOYlV2TnadwregJ1
         xaIR9cUKdJY4Oxtvznsuh4cQTfa3/dbQA9R2PikwwfFKTDwi0Tx1KnWBXuK/KQhGRPfT
         WFuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771923507; x=1772528307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faiZjMOkti3cU0i9Gy2EPz0ZebIZs9O9WnlPDsTpWAc=;
        b=aQ06zKs6KzZQM3ceLGqgE/bqoi67rYKGbCgN7MRE6fm5rQy2/filUd1+50pGV5slO8
         gU3sR1GkXJ0ehioDs4o5D3vnZrNbmQ5ip234z3N5S1yBQJu2245JtHDYIsn1SgDrsXGo
         uhkpnHwhiabZ3mPA6AiUD9ZTzpfklSrSAOdl69/0NVQSOcweewtFyM6bhS7iHBwNTYMD
         lMbji5PiTEMbcjxZA0VsYCQb2vtmU1cI9/0Ys/DItO0hhKDBRZpNjtH64upEoEEecQdH
         gPgzij/DRkEiFkaMOhGBojD4JK8qzs0k+V8gFRiRK1U4NREWIoMuxDJrhKaPCry+9jIu
         /6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771923507; x=1772528307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faiZjMOkti3cU0i9Gy2EPz0ZebIZs9O9WnlPDsTpWAc=;
        b=dWfgNYsyxzRB+7Q5Sc0L7KTQaOdBasWOMNvmmhP1nFC4oyFTrre3b+fGsbN2VVPILi
         WFMHFBzxVdybdIm7TH3zZjK6Kr6R5wLZB5vD+oChG1s0mCFl11IMCeqx4as2rp2Pt5iz
         4PrEO9h7cCgrtMn/9uB08QyneP1/q1bf0c0EyOvj+JfKlqLTND7/mPSx8fHVxgD3RNRR
         VVigk3KNN1dEdgzqvCcaN+EkDaWJTSeS1hbGvaD5mp4ySiZNyJ1I1xgoh7Pj/9gruw0p
         9XZryk4HbfzGF+ni0/+UHpGwNhGHVooi0X/DwBkSqiqn4xu8Yc1LS5fcgDWZgQZdtFgI
         bSqg==
X-Gm-Message-State: AOJu0YyHDoK8lSGhubHXGb8fPR7loa1ZkTswqNAaLWnKAtLzXD2RAL6O
	e4PDrEK3cPZwHOvDRdjD2Kld4dY0MRmgNSa6kYkjVOBYkModO8E0kbJkpCmTxpbEZT5hzsEqyC1
	ZpvY7dzllhyhMoE5y1I9Lh1LAJtdd5dU=
X-Gm-Gg: AZuq6aIXsZ7M64XHa39baOklqMRnxiHRvqFnC6wkL+1IWxLbR5lWkRDXiQ4Y1HVxay9
	eofSO/u3klBCZ3EyKkMNoS5E2NDju4MKVoTcDF6JLdYm5RB4aoDQUQyNUNzhOw3OYQ1fiVbqU7p
	+y6QCEjkTBt+HxKLXJ7EikIIEB9CEcesxEfB0jmtQdBUmg64GjWIVEvSb6qI/wYFqiXkCjYGNHK
	NX8PIBkHyo9LmR2bR+Qz1JYdUkOp/yR8TlzmUNn4rRCyeBWs0aD1AWSc1QCkeYi+20piJr9Skde
	ZY7a0S8SPq3CXP5xHJrCIjt3Wmx8azKWpdK+/FC4iMwGz51Uf1ZyVyd4ediBRqGXqzHohF+cf0U
	YL+jV2w==
X-Received: by 2002:a17:906:2083:b0:b8e:7d43:edd9 with SMTP id
 a640c23a62f3a-b9081b403camr443962166b.34.1771923506344; Tue, 24 Feb 2026
 00:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224014607.353378-1-rosenp@gmail.com> <ff1c77b9-bb29-48f8-b942-6ace8ea31dd1@kernel.org>
In-Reply-To: <ff1c77b9-bb29-48f8-b942-6ace8ea31dd1@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Feb 2026 00:58:14 -0800
X-Gm-Features: AaiRm50Bek9WP5Ws1AwhONIM9bVEBKCp-RC5r12jn8hk7U7EM-DczY17IsUaeCc
Message-ID: <CAKxU2N-Vr_cQBBwWd49j6U=WO3pFjLWos4A50AOnFTY1qhyNiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fs_enet: allow nvmem to override MAC address
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: netdev@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260407-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[chleroy.kernel.org:query timed out,rosenp.gmail.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66AD718429E
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:29=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 24/02/2026 =C3=A0 02:46, Rosen Penev a =C3=A9crit :
> > NVMEM typically loads after the ethernet driver and
> > of_get_ethdev_address returns -EPROBE_DEFER. return in such a case to
> > allow NVMEM to work.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/dr=
ivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > index 2cbcc29408e3..d3c772ed5fc9 100644
> > --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > @@ -951,7 +951,9 @@ static int fs_enet_probe(struct platform_device *of=
dev)
> >       spin_lock_init(&fep->lock);
> >       spin_lock_init(&fep->tx_lock);
> >
> > -     of_get_ethdev_address(ofdev->dev.of_node, ndev);
> > +     ret =3D of_get_ethdev_address(ofdev->dev.of_node, ndev);
> > +     if (ret =3D=3D -EPROBE_DEFER)
> > +             goto out_cleanup_data;
>
> What about other error cases ? Shouldn't it exit on all types of errors ?
For MAC acquisition? No. That would result in a non working interface
for no good reason.

The way other driver handle this is exit when probe is deferred, and
set a random MAC on other errors.
>
> >
> >       ret =3D fep->ops->allocate_bd(ndev);
> >       if (ret)
> > --
> > 2.53.0
> >
> >
>

