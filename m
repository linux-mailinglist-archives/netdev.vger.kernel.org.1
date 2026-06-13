Return-Path: <netdev+bounces-299041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ujAUNXW9LWojjQQAu9opvQ
	(envelope-from <netdev+bounces-299041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:28:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EE67FA18
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:28:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qa69RF0s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299041-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299041-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34A8301918F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3AC35E949;
	Sat, 13 Jun 2026 20:28:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA7125A0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:28:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382493; cv=pass; b=u7ZzQbNFjfIHEU8zAYiy7/pDvm8RDxaeWraslNZS8xW3+cxk/B7WRmv5W3FAvoNKLboxdfW//S0ojWIQ8MY08FfimvEfMeKtuYBeiXZpzwtC8KEPgtV4a8xgCSgqlr0fwXkBBf+gKX4vCSX1YnkBTmgDAvE4A9SEAELcZd4XfHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382493; c=relaxed/simple;
	bh=HEbgtSrF6kiF+klxt6cfMMiHY0oNLU0k/jmeQfBgct4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjCsSW82x397e6fDsf8TQU82uNLmM4/SqW3pMGyaP226isZv9h34xU/oYIpGJGBBykbW5dPZdWRbblBn5GcJqx673DVnIUvqUc8+u7oAaAA9bPlCgD8vELORJASSLU1hOj00+OrHMKczec403ZxqPPl0akO9IgUWVe0KoWqrU+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qa69RF0s; arc=pass smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec449d0af2so246880766b.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 13:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781382491; cv=none;
        d=google.com; s=arc-20240605;
        b=lJ4lsbxRQ6p15LBP3UPjvw6EWzOrTpZd0ep9EyTmLsYUvYapPvnBxaR7RCHj+vccWi
         CN+Hl+pVXHxC8Cq1mPRWtQNMOlHAVdjo2BkaLIWraORZyMbzTOegTcQS8SbQdVhP+L8L
         fZ9dy97oUUIw4HC/7Ivigc4mFv5SnIWqf37hyCHCEOrNBkP8+S9gJ1Ms8lSYKeweDhyl
         VQyLkzpvlEVO8kxPtBWyNpWCjUnPtgM/2j2pSY6GcYz1LEK0Q2hOHCB/OkGzO17cldC+
         iZw+MNDy6dVaQQ4l2XtS/+19HqFUYWrhaWIOhfkF+PNhdEU4FFFY9aBTv6KFJffupXB5
         eVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h7Xa/LLr6O6gSEj//llcOq7CDd+rGFrTiK7pZGgR5uQ=;
        fh=UodXUToeHmh/UpcTOMdX59KfXuER6Zcj9vCg52F4WEE=;
        b=ZCwTGjRwFac9zTAAhG3WNPZdSMMxUIXsziQEYEmgqgU4K+Wl45piuuffHK1XRSinYg
         L9oKTfn66Al9IxgjW52g2T3nvFmn+oM+hxWCRbr0zPWLVDNDeaOZlIkkvxQcixWTfF/X
         uNMyIDZu5vYotbRHdIN/fYZ2Y3wLFeoeQDWcFTCNrLVNr6QU4uvfoq6EafYZY1HxSPIZ
         qnBJ7Wk5iauttm9L4lFr2JMw2NYCJ7mkntOlLL6Zc2tfesLXLC3aGAp2i3XaOly3LCW2
         o16wLztfFkegbHJAVAJuQ5dSECd0EomHga9v8ZKOADRsgzUoF0IZAWF6I1t8jOeuwKy7
         cODw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781382491; x=1781987291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Xa/LLr6O6gSEj//llcOq7CDd+rGFrTiK7pZGgR5uQ=;
        b=qa69RF0s3YgG5jgPFOFIBZ4cR1Xt9cLLVhdNDuVOa/Qx9R2Ne1fxeekMC2MMSkp3D+
         BkTWCukCYodhffLrs0+njg1YokjFcr0O6KhQ6Njbsv/XS3T9hlIZ400bL/4ZRtW+MZXW
         M7fWoejxnnVQUyL98r6vk2ee232HLCvlJ54U3bKxBO6moiBT0vPmNWqpjBlg9vCV/GNg
         y7K/cwV7TZztZu+p765PUV2TRin5gWwksmQGNkcGyy0l/PinihDsJSpC4Yj/JzTepW0j
         AW7tTUUlB3tQNPWVlg0/oB/kq7eemCGDU5U7TJpKsh/uisK8N8css2pzzG/ovCYWcDVG
         1E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781382491; x=1781987291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7Xa/LLr6O6gSEj//llcOq7CDd+rGFrTiK7pZGgR5uQ=;
        b=NKFSsmIskYL03D9jSnx7xDcFzSgEIlMAqc4IVL4yaa1mHbIbz6aBVAWYlap0Y2VAYZ
         8dku3Ca1HLmoxc5DZPi1pDbHAXtC/K7b/HvOh10a2lIdXk+r+0cFuJUErBIulSSbwUAf
         V7LxsuxkMaK28ir1NgDYy5iu8RKDhTJJGJ6dtZ1UjsOVeD+WiDDkowSbWJZQ/na71g9P
         9l+w0XtFpAdfHt9YujLvvirPtL9AiE10ZRDEvm6zf+yYGmSBzpKyWCp6Tp46l7m866kB
         XgjDu9BQjo6fjXpI8yZPtp7g5+HS3pvH61v/1wwB5TGgxaqpNCcLIDXMycyite0iB7KM
         Y09g==
X-Forwarded-Encrypted: i=1; AFNElJ8eEuIeRcDnJk/HtkexjO47YDW/HyaIQebqPn5nhNW67m1ZpdFgPXjBjKqSTQNLxNLRgOevMUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LQ6yYrtoPR0afeQeoZajysLV1D0aL4Qmpp8lJxpIa1ZF+pjy
	h2P3tOmBbd+6sH6YeGQh3jJCqdckFRJIRPhskPzmouyghQuL0suZf6zd6WkytiMRefV5rJZMDis
	nJpo8p9SrVncOZbDQhYOdnKU3CN0ovf8=
X-Gm-Gg: Acq92OHahMK7RpBKGSqvBzKDImQ7uKsO7eONpT5LVUVTD24RFVR4AveB3XotMTc/Vnx
	wD6zdlYhLUFbbsdVH23cX2v6X4RbxiplgHpYhG0DrJQfsHbcr04TD7nJIOppTOZDa85hA/iYTp2
	sgsIYm77uD3hXnAbCM6UW9WNAGoyLEv27XLJUmDek7wKrHl1dQGO1OVbH824SCQYYCHhr81fEkd
	Ou5a2UIUKALJCPQ3VzY78ZGtLqq/ZBOtEQAc2uXKX/4XJP9b8z2EAqbw4VxVYeiv5iceWK3SUcH
	7GWMC4YCmrKLqsjEMZc5ifyI4/nroSIHgr7XK2cHuAFhRzN93vk=
X-Received: by 2002:a17:907:2d12:b0:bd8:bb13:2227 with SMTP id
 a640c23a62f3a-bff4a10ae6emr196917266b.6.1781382490521; Sat, 13 Jun 2026
 13:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org> <20260612-rtl8366rb-improvements-v1-3-9232286fc20c@kernel.org>
In-Reply-To: <20260612-rtl8366rb-improvements-v1-3-9232286fc20c@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jun 2026 17:27:57 -0300
X-Gm-Features: AVVi8CcX55kRNKR_sCby7fLh1mhX0oeU5j1M7bSUKGejKVglfNfJwUvi-GsLXCY
Message-ID: <CAJq09z6oPRAsF2QCD9n4HjruHvE-nqanYvP1CaFVDn7sg-ef6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: realtek: rtl8366rb: Disable STP
 learning on all ports in setup
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299041-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 413EE67FA18

> +static void
> +rtl8366rb_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> +{
> +       struct realtek_priv *priv = ds->priv;
> +       u32 val;
> +       int i;
> +
> +       switch (state) {
> +       case BR_STATE_DISABLED:
> +               val = RTL8366RB_STP_STATE_DISABLED;
> +               break;
> +       case BR_STATE_BLOCKING:
> +       case BR_STATE_LISTENING:
> +               val = RTL8366RB_STP_STATE_BLOCKING;
> +               break;
> +       case BR_STATE_LEARNING:
> +               val = RTL8366RB_STP_STATE_LEARNING;
> +               break;
> +       case BR_STATE_FORWARDING:
> +               val = RTL8366RB_STP_STATE_FORWARDING;
> +               break;
> +       default:
> +               dev_err(priv->dev, "unknown bridge state requested\n");
> +               return;
> +       }
> +
> +       /* Set the same status for the port on all the FIDs */
> +       for (i = 0; i < RTL8366RB_NUM_FIDS; i++) {
> +               regmap_update_bits(priv->map, RTL8366RB_STP_STATE_BASE + i,
> +                                  RTL8366RB_STP_STATE_MASK(port),
> +                                  RTL8366RB_STP_STATE(port, val));
> +       }

Hum... I might need to check rtl8365mb as well. There we disable only
MSTP/FID 0.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

