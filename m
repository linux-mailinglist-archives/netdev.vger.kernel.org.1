Return-Path: <netdev+bounces-281461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKqLKa2272mFEAEAu9opvQ
	(envelope-from <netdev+bounces-281461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:19:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB747930C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB842301DAE7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60F367F31;
	Mon, 27 Apr 2026 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czB/+iSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8232D7DD4
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317546; cv=pass; b=pIqF64eXpp6DYtH3CAqR9FtXz5zPKxCjJ5sE9GtMDHiwVVcCEl6tVA6lrgReY8TWhqDyreGh5xo2rQKD1d6w8gZ1DzIGWiNVrrutHX9JYYZfBsg07oxcqxV0sW093on3wY+7qRczxLSLwVMDG05KYJfFiZsLWuqnqBsq0YDvjfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317546; c=relaxed/simple;
	bh=oCed6AHV7gJT140mEhucOBlX3rBg1cgyhsZYg+LSRVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDcx8zZEkm5ewAt66N8PtqJ/MYbJVg3YpMyrdSBUG45X3ClXcZiEonCT9xmUtIz3jfHb0hvGi+ls567XrlkpUQs0Bky+l4itU9z4covN/flJGOu+kdZebA8mXocBwQU0+UoVHD2b4uuo1ZdCg/cYlU0FQ27q3xjC0rwAino7ygg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czB/+iSx; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c01854477so677486366b.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 12:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777317544; cv=none;
        d=google.com; s=arc-20240605;
        b=ilvWF7sv6HZRnzjaFwUDWmEJt4cPLG8e7kTyLBkSpoO6TE7qDbPAByo3Gp5tKYGVVb
         Fkcow+Y81R/YELO3Dch5DpRfhpS4S2arLnNzOM+JojSXJ2mRbDHRwYF+rcB8ONJ3SiIv
         MXk0udSXW++Ad+2Id3VEgfbJoPzTubGyVpjQ2fVhxeq3t04Z4n0aaN7dbATjfvr2f+xq
         e+ilQ5OV87DEHcAmgTtUqM3uVtpB2dE8ICrxVYIJz5ITCi/b1741bR+WVlf3yx9Qf+dn
         VQx8x1fwilzRRsZNPo3ka4+Kemi03E4d8dbEcf9J1qgD0fmoLsVVsae60TpCpCi8lFIA
         K5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fhUrkB7IssRLD7hXJmlDXdTKyH+vXPkeeczcxPPXpnE=;
        fh=9qs7J2ij9l1jwcrECCkxzrXUjTRTgACkgSN7OSp4xq4=;
        b=Uy5f7nYIhdY3U1jXAg3Q9gVdrlxQhKDXJHnnf3gdCA5pMD7CyAWQsmBCv9/lUkeZlb
         hUr18C47cRb8XE0aagQa9QCh0LfLW3iRBEQ+IkK6f2M3p6VeSAzzD80ly0wzr+HFvbzD
         3Imhemo12gHFFUgzkKiqNN9uRF11H9CjADs6c9uAvbYU32+rghS5ei+mDjvfZ1EpwFsN
         E7famzGZUy/xUA2QuMyWhktG8sYyfbzT6xmFKC7bxgysQF0VUrPD3lsMReXr7Y3rotqp
         Ohty8+jyt25Hh74pzQlzzkgUTCJmqv6TOgE4k0rllhEcRT2c/szGpcnnB9WLyTHS8+Id
         OCQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777317544; x=1777922344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhUrkB7IssRLD7hXJmlDXdTKyH+vXPkeeczcxPPXpnE=;
        b=czB/+iSxSpGf4TMtuWPIvMGLKES6qU7Ag3LOHbmhwNKPVM5QWigUGEy3T4rgrIyjJj
         P9QxjTLKLCm3b6YrFzv/rYo2kvEMx/wCJtiGw40XgzB6RVoMlMJGEZiVxN52Al7XwVPt
         HDsi78WYRxOwuf66cS/6UM2qok2oWNDriQ9Cv4j1dGmBBzEkaReJ6Ew4xVLdcpsadbEG
         xKZiM/y1cSEQzDvnvJ9yPtiFQOK5LVdqNv+HxFZIEz/sfZzCiCo4cc6wVEtrRBBhRkq9
         waoWfv0MrS43rGe6n/xnwDpMDK4t6vKimW+fTtHjCH0IWZimUFAsUs57Bjm/BrO1n3w9
         pYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777317544; x=1777922344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhUrkB7IssRLD7hXJmlDXdTKyH+vXPkeeczcxPPXpnE=;
        b=Ugzlg+yicMyKIYxp9FYz6FSmvFCUceEzTnfrQE5VEWxyZX1EAQWua2xeDCfGJaqf8N
         R89jOy1/BeDXFzoO77RCXcG9hX1F6Td99hMCnWeSrKVwbqOMcvAvc1bC5knYMnMhiRrv
         dLhlsMPiElu34J7QWoLLyFwoDoLyMSc6NmkHkBXmeESnrPictQxB0uUG/Ypf33QEDafk
         m0he5KdrvGBCjvUlG7r7UotQAMQHSfrg3tuQ1MQIgf7gWWvemqK9oet205iXNVUEQDsS
         miB0ZgRGYhQGypHAU0/COEX3OmzHffl3YQxPPH5NaXav6/jb3EVgi75FP8RWlebn40Hj
         i0KQ==
X-Gm-Message-State: AOJu0YzHgeniRzeZcL4l3kivhHJEBX87tEt2LvsJngpp4adukeOskXJd
	lynXgaVJjlSj5ppa5DvOT829EwIvBze3OipcYk+xNZAlrJ7AEq0sLg4B03mTJJFu51oXkhzgocI
	rSDp0IIAHgYl51P65jBpVMihOC3e7ogs=
X-Gm-Gg: AeBDievUD+SpbPK9AH1Nzj9iNaOR/307V9NWTYkmPrSA+rH7poycPRY25dQHnZ25hIl
	b6VINj2ub+JQHwGB7iI29dwvXkPThxu3wwiAaJZfbVZYxbQy/VGT4jkZGI+062YPxtjXoim8hYW
	Bc9UGEW2KM3sFd1ZWTXHZT9tNMiE8rvwprjOP0zLk+/UhZbjumizhHX/YWJVHOYwmEiizttvebt
	PkwOqmGf43s5/vJKSa6iQSDgH/+cP2cr5tmJ1LRC/lmA5Hft+sc4BHitv3aBllFvgOxmrrIy8vC
	szGUsRXDCk/R1DflEW6diHSghBVmdJ9HFGbzGok/TPIA55o+d03D+bHYpK+uIPOzjxRHdfzkUjR
	FKp5hoLz6v7NyDiML4bkCbxAJMa61OyDzsGyNhWAnPxjpPJMNllBLDS43sAc=
X-Received: by 2002:a17:907:8745:b0:ba7:cc67:488b with SMTP id
 a640c23a62f3a-bb8020ca223mr7657666b.5.1777317543502; Mon, 27 Apr 2026
 12:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427052533.960487-1-rosenp@gmail.com> <b1dcbb65-8fce-40d9-b259-6d9bc9f3d454@lunn.ch>
In-Reply-To: <b1dcbb65-8fce-40d9-b259-6d9bc9f3d454@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 27 Apr 2026 12:18:52 -0700
X-Gm-Features: AVHnY4KZmVuwvr0dESa1DbnbWpi9IoTNtua2LaV2_lTGmpDRfo88dyyr1qkqkZs
Message-ID: <CAKxU2N9mUEi5gGhOVBvpP5Kz0L8zXNL2KqY8ThR-Fzmm-8V_hA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: enc28j60: use of_get_ethdev_address
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 17DB747930C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281461-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, Apr 27, 2026 at 7:19=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Apr 26, 2026 at 10:25:33PM -0700, Rosen Penev wrote:
> > Since this is an OF only driver, of_ instead of device_ allows nvmem to
> > be used to specify the MAC address.
>
> Now that is usual, somebody converting device_ to of_. It is normally
> the other way around, for not particularly good reasons. Nice.
>
> > -     if (device_get_ethdev_address(&spi->dev, dev))
> > +     ret =3D of_get_ethdev_address(spi->dev.of_node, dev);
> > +     if (ret =3D=3D -EPROBE_DEFER)
> > +             return ret;
>
> /**
>  * device_get_mac_address - Get the MAC for a given device
>  * @dev:        Pointer to the device
>  * @addr:       Address of buffer to store the MAC in
>  */
> int device_get_mac_address(struct device *dev, char *addr)
> {
>         if (!fwnode_get_mac_address(dev_fwnode(dev), addr))
>                 return 0;
>
>         return nvmem_get_mac_address(dev, addr);
> }
> EXPORT_SYMBOL(device_get_mac_address);
>
> This appears to support nvmem. Would device_get_mac_address() actually
> work? I'm not against swapping to of_get_ethdev_address, but the
> commit message should be accurate.
I seem to have missed
https://lore.kernel.org/all/20250912140332.35395-3-wahrenst@gmx.net/
>
>    Andrew

