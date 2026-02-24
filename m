Return-Path: <netdev+bounces-260663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGe1Ak8lnmn5TgQAu9opvQ
	(envelope-from <netdev+bounces-260663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:25:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 750BC18D1CA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBCA300C998
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036233446AF;
	Tue, 24 Feb 2026 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDw7pbdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60E3191BB
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971907; cv=pass; b=bHqeez2dMZBV9Fyu6xftEQinTyO0OAE87ip64YCHZQP1DdQTLX7hlnA9uRvQmdOyAjj9T34b3QOyfk/diQh9EBFFrJLlxF17a+UTrv6TAOJQDYbLL8mwjGZw2XIkOvAG6bPWyBJWBStuEOLV1+s9HLKTJSLJJByI/Jp5LI+VqDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971907; c=relaxed/simple;
	bh=OJRFVl43rP8OrxWJz6h90mSomARljyBQ9KU+2/3xc/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvG5NpAyjM3TVQ0E/n5VFVJfhhxbWeU4cwX6vEvAI010S+NzKd5rLMYgTpMppmziaYN39gRkLcWwQhNLmzWiyS7Cpx5MPVBmPtfJF8msSGH6yeMuidH+GvIyH8/jcg/rR8TB4InFNA7OTRejuKG3CxcBDEcyd1/dw6s8bX/OWHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDw7pbdA; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f9568e074so1051892466b.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:25:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771971905; cv=none;
        d=google.com; s=arc-20240605;
        b=Uy1zQP2Ci2XzwELaqcRjcX20PW2mk+lI2I2iXWdAFNg56UTMfpIWxxP/pnvf/ja1hM
         UW1lOhSIRkyLsYalnnOXhQeO7/rA3wGytQJqsuRN3SfDUoOwIgluDOd0ANQOH9WCn2YT
         oPJEVnAl4sg8eyfWYdLPZTiIldz2h39JAZlJKPBFNc7G2qILC/lNTCqoATPq+4ammozC
         Nx+EsnbEhQbZ3ftp55oa6t3ViDvjpxAG3vdvf6YoSJJcrKtHDtOfX36qYZLNq/HHWuDH
         j0MOQEfvZ9pZzUR89Vvl6a3sRULU9hG9Ly8B/zBYkr0I2Qn0umh5MADXEmKgiAil0/pr
         hU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GeG94KI9bru0PlOxbMT6Maxajt6lIFY7C4sE+hV7LKE=;
        fh=9Gi68cCcH6MmFTDjENug2tuKFxMwc2ZdgDXDA52wFfE=;
        b=FfqMrCKdLJ9GiRJVUEx4Q6s0kVNM11E1IvobqlaSp3RAj5l0eTH5tvAuZupZIFvOP6
         QD73gyu2jgkyMSDaf3JaUV9qkmBh8w5asMg/ZG0mCr3rsz7icfKxbhYbZSr57EkBvYUn
         eZz5ZAUZi6OsQqmrxDqGqLa1BqDV6E3VEJC10RBH3jvBEkTyvvcGiG5OQVf4OJsfiekL
         sX+/cZLHvxDCs5C9irqO4XxxQbA5AeilOFgXXzR8eblz3XHX7SaEyIpUKXsd4Um4FW9p
         4+35uIOv3iDS19VK0fGbxY6dUKjPbsdsiT//BvH2W6Gedaek6DzrFo15oCeE8XD+jv9x
         PsAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771971905; x=1772576705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeG94KI9bru0PlOxbMT6Maxajt6lIFY7C4sE+hV7LKE=;
        b=KDw7pbdA9j+R7UNvYWaZLWDUECKwq+jCALHxCwmbx2jy2V6tdchlbZxlQ++LCVZHCb
         EiPu/jBhCupjD4G0IK1VmqhfY4ryI3yYaOuLyVKEYn2aI5+qViHOV7pyLOf0DhYBwQSI
         u1hFKBeAq2g3emJygnk44bPTigthWgY0iDGWBb0o0otH+dwxg/PNLFKsBj8K/B7giMDk
         iBi4vZi0INif/0VVB7q0BjtLaUBE+G9TzwoKyl4i7hqB/WYQnV6/vkxbLZbMgmY0vVda
         ZZjNCjMvE4b8jkrkLMKzxTwAeE59TJUXLt6VkQasJglEBigMajkQs9tPp+KL/mmK1b92
         bv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771971905; x=1772576705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GeG94KI9bru0PlOxbMT6Maxajt6lIFY7C4sE+hV7LKE=;
        b=S+YvTPZPcCFPeH0PiFSLFbz1SLIkET+BcuX2XidVO1HvMdqts2X5yWiby034Ku4BhK
         Dld2+XfkaZx+JBobGMDZHMzavv8t0afjCtNflrI3tU7GSLT2asXiD4jbBrbTQmJhyBKY
         GWKO8AB/5IkBHC8z++Z+aj1xDRjRZdW75XCT3ESQV83iwUWqbQf+97xfDLUcFt9Yn4ba
         sAJbRkEygTJf+moAdrHi8G86Zrm3Z6aoIgB+qDhuS+Rgk4G5d+3JXkcSaVjGAXDbUe7p
         UnWAOLerJtFnbfvzvP4gvvu08VllJiQGyaVJWoLMsl5kYBtDr1zS/d2IXvLW3CLniCYA
         z/LQ==
X-Gm-Message-State: AOJu0Yxz93LTt1U/N+9N8Qy/MLagcJIHlyrOjo/C9PmQl6BQsAZsrjBo
	/eniE75bT21g60YAH7L08U81LKk+v6aR+TcK+ztRxevZ9GcIWV8U5RlMUY6q2WRjyEUZAEMwm33
	hx98ITCsQux/jIaWRYQ/GLAxWZQ+KYhM=
X-Gm-Gg: ATEYQzy5zeDbMaCuT2M+SnSiF/6m6+Cpa/oDrJ1Hq06cBIduTNm+zkmz6PocDxa9Zxg
	jy90BpuwOhhGmfxKEiK/I+QoxIzvp3eYuCjeLeyd7n1wrXjBlIYLip0Kk2F7cwMc8fJ/1pWDbBl
	gwYEeDb8lTkGXylfzCS4MTHXDYv/73eWyWiPd+qXze9yzYQYqcZRg9yF6rW7hw/2xA/2wmV6y+t
	VUvHG+kUc/eDDWgAW7zQELrFpNcIAYcazLsNgy3eSY9wutU305eW4AvM+6Lswo6jx0me7U4V0XN
	A5yaN+nExJgKx3tiAaNQn+FWjo794ZvoL9FgN7pdGK/+ir/yW47mRAuqu1+iYeV30CH/7sK8z5i
	nRYjP/A==
X-Received: by 2002:a17:907:da8:b0:b87:756b:cfab with SMTP id
 a640c23a62f3a-b9341ed5b42mr13708166b.36.1771971904735; Tue, 24 Feb 2026
 14:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224015517.354145-1-rosenp@gmail.com> <027d191f-f04e-4ead-a9b8-a6626e0828c1@kernel.org>
In-Reply-To: <027d191f-f04e-4ead-a9b8-a6626e0828c1@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Feb 2026 14:24:53 -0800
X-Gm-Features: AaiRm52c7Q_-qyo-w0gauSRipSibFmKBLRI1XYX-N2j5XsyKRZqiSj0Ok-4hXik
Message-ID: <CAKxU2N8pedieviayis9CoRtm7z0S2C_f-pC1N0uoU0--4cXFSA@mail.gmail.com>
Subject: Re: [PATCH net] net: fs_enet: add missing kfree in _remove
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: netdev@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 750BC18D1CA
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:20=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 24/02/2026 =C3=A0 02:55, Rosen Penev a =C3=A9crit :
> > The kfree is present in _probe on failure but not in remove.
>
> Which kfree ? Which structure ?
probe has

out_free_bd:
        fep->ops->free_bd(ndev);
out_cleanup_data:
        fep->ops->cleanup_data(ndev);
out_phylink:
        phylink_destroy(fep->phylink);
out_free_dev:
        free_netdev(ndev);
out_free_fpi:
        kfree(fpi);

remove has only
'
        fep->ops->free_bd(ndev);
        fep->ops->cleanup_data(ndev);
        dev_set_drvdata(fep->dev, NULL);
        phylink_destroy(fep->phylink);
        free_netdev(ndev);

Conversion to devm would fix all of this but I got yelled at last time
I did devm conversions for netdev drivers, even when I have the
hardware to test.
>
> Provide more details in the commit message.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/dr=
ivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > index d3c772ed5fc9..ee2b7e8866ee 100644
> > --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > @@ -1008,6 +1008,7 @@ static void fs_enet_remove(struct platform_device=
 *ofdev)
> >       dev_set_drvdata(fep->dev, NULL);
> >       phylink_destroy(fep->phylink);
> >       free_netdev(ndev);
> > +     kfree(fep);
>
> This is not correct I think. fep is allocated by alloc_etherdev() and
> released by free_netdev()
>
> >   }
> >
> >   static const struct of_device_id fs_enet_match[] =3D {
> > --
> > 2.53.0
> >
> >
>

