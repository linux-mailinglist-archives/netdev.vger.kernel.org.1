Return-Path: <netdev+bounces-296823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cWx8BChnJ2obwQIAu9opvQ
	(envelope-from <netdev+bounces-296823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:06:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB5D65B896
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:06:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TXlUP0Ep;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296823-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296823-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18E303006B7B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E552D7DCF;
	Tue,  9 Jun 2026 01:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C332561A2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:01:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966918; cv=pass; b=SkopuyVMR5GclwxmHPC1lZaYR4wuPaLSHtkKNXbffJo6fk0ZWbhh+WE6PdbRMQX5OLrhcp7WnVoPFdx93FXXn4fi59+sUKcpQZtNs6Px5fIDeYzyWXbbtTbm6gS2HQ1kl1Rdzu28WWsRrMmXVMeQcux9LkLedBYGrZJISlsIbvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966918; c=relaxed/simple;
	bh=G1dM1/dmgyUNWxst0HUlUzNrzLN0MwbQPeefV5ok+Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erEw6U7jyQeHYN2IDbE0YC7wQDinsXGS2lt6VwpioaAA4OVjtIe/ulhU8ht44LM7jzbVds9ZCj1XMTGU3YJPCKXQDeEMkluCk7c5dpU1Lw3QFSTg25NcGfv4xmVBzLwQYw28hANMVt5I9JieJ93e/RPonQDTyvT693N0jysAy4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXlUP0Ep; arc=pass smtp.client-ip=74.125.224.52
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66043ecf6b3so4952188d50.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780966916; cv=none;
        d=google.com; s=arc-20240605;
        b=GqGZ9RRnXPcNNhRQjUOO/HC535wHup8D6v2DdnXWLpJ4ATB9NnOlXTogMNnRNFJijH
         W8ZLGEUln0pNHU0Iru9gg+6TwU7I6H1U6/lQMm1LFSStdyLW2L7R6gdOsNL1GjVU3G+v
         o428ttZ8n2qIlr4O1p21H/KkD2V1t58vSOikQWaqB7JbA72yXtWsKtvxLGVDpadNzg0f
         u9BbVLfvwa59o94F1X2l8rNNQU0TlFSaRLQjRENZwJtUT5J91IiKZKIF5nQZW2kuAQ1M
         hMWsEZBBHv0jGTqVBJt/IKIecSfT+KNq6FAMC2g/lKNDnQFELGKUYikQZo8yjYXCkO19
         lnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJw++SBO3vvhIzM19PeiMqqjbpHfaLtptXftUz02z8M=;
        fh=T5ZVxOGLo5mCT4S4J1ztjjBU0SvKSBNYJ7/zghOMJEo=;
        b=hR3OiRrhcFgV3x/IufPtDz4285vwvHb7kb3stmHKOMQir5rckFjWmDPZ5BoxDY3mGB
         GyJgsMekZq+YsfJ05CEqWzLTcB1pvlHXUIV3qYkcJmo3hByr3//G/D5gUgsz89vJrzq7
         qac7jRNdM+xeKH6mEPw2G+8mOY/ej0RcFDVcpOaEKvrRs+Lkp7dpKJY4/k0AUvpX/4uA
         iWDsry6qshYIh94qsQYZFBOD+18Nek3EpQkw7lVnMIzd/pEOB2S+OKW+U9Uz+Stqn8gM
         iww9ZJ+2wZnafGKEe45D/DPC3boNEbuJxCGsGK4sAYBOvulrpz2mqNrK8T4tzGCXfcPI
         1yTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966916; x=1781571716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJw++SBO3vvhIzM19PeiMqqjbpHfaLtptXftUz02z8M=;
        b=TXlUP0EpK3E8uEzoWDmAYEIYQQe7pv2LtS/IPWx8JTYDR42qb0YoArT+8+h4Pw7GP8
         sqYvhu3pB6Z1viooLVR0oCRSmRRJr4eCDIr3YVbpqY3ow9ajVMOOkcbFufqbvac+ElMA
         3h9kLymXNR8KHjhwjywtx7Dx7xscaTdJ6EfS2Jx02uXUfF0Sd0ccaWjsGOVATRs30V1u
         MDw+NnnLKwHT5sehPnJXB0B070nFbmSu7BXuOcdLfPj6bsQBFaoJDEnj7jcOdV40QEjX
         OdXMwXhUBltt7Jn9b1yzf1jTATwBDb2v46hsjQgB8j0JWC7XKtuGoiH127K1PHI+pQGz
         ZYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966916; x=1781571716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJw++SBO3vvhIzM19PeiMqqjbpHfaLtptXftUz02z8M=;
        b=UXvL2gylALrynuqmya6LBq5vVFQd0Qf41Jpp+4OxvPb+MtDZ3sMMfXHvrYCi/3fx+P
         WKEvPGi6j0Tm5R0iqna/7zleBx2w5ALSlRkA3JMnTIvUbWmR9f0zSsABCmZQGdxdbXwU
         yAbbG8twy5mlZIRX2wIERMMbfX/ezfj7Q0eRDc+dGiYVYzDZ85huEKYiBbqdcCzubhM5
         +LaAYJdjyhOGPlJ1SOhz787wI2/h6XF9K3nX8pwFMPhpqWzU86VWZ4ofFB0MlQzrRzaV
         lhga3syh5E19+qdEVbGgL9KPdRWnHudNq+5qQBJTMVg5WFgoNKME//Qy+WSJoRKf3ebd
         WY2A==
X-Forwarded-Encrypted: i=1; AFNElJ+mHDOMD4Y4WBNqGcFyDO3pV/BZwHdZrq1HLxBj51kYAgjmrekoGhcVM620MZsMWIyYKr65NnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzKFJ6VeMknzLUefmzuHlK+gDFxq6RRXLuYAtNkirp26yU5KZ
	cIC06h6SKlwz5CAFuda9sTVifU8UZRk4V48t6XkgW83Yf7544vbFIlrBI6a0GUiXSR9CZ45Diw6
	kuB4PhulRLrPrNzTloLDofFFUkaYl63MYGn3HCO/S
X-Gm-Gg: Acq92OEAzdYCQyJn5xqn4/9Ap8kC9Zi7kOXrgls2uhQRxc5NnzoMXJM0KgbA9iYHTR8
	5+ySMhxgFHHfkDaFNdMtnVVXn/hrJ2zezRTrFRnzS/zor7gl7+fKre6+hGTu1Io4C/qpNdECqQG
	6/xFNLxR+TbkdXPQ2iD5CB/l2SdOF5KeCnid028MjZs4jbTAdjIYCylJNrhESQzN+Q0wJBTRSK5
	bnBPZLgLekSrKskzwBjqdtH9LNqi/lalpVGAUYijQDJJtTgM7tIsqcTTG/h0TdyLhiBM4mo3yU3
	utrwDLTOzIAd9MRvSw0ndReadbETQkWTnFeYmQVcrUGQv6Zx0yG7NJqcI6s7Q3u2R+PSxlzWlpB
	GKg0qp+yPQqm6MVDXy1GAXidKkg8j
X-Received: by 2002:a53:d206:0:b0:660:6497:f8ac with SMTP id
 956f58d0204a3-66106f496b2mr11036563d50.33.1780966915187; Mon, 08 Jun 2026
 18:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605151315.2124527-1-sam.moelius@trailofbits.com>
In-Reply-To: <20260605151315.2124527-1-sam.moelius@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:01:44 -0700
X-Gm-Features: AVVi8Cdel9XH_aHeXIgwyy8hd_nd6AVLtLfoFNRnNk5CDuesRBYahw3S4vilmGk
Message-ID: <CANn89iJwRC==tUjFT-9bm8SMbnEso5OpbM4rMt2zBNsrXkfUqA@mail.gmail.com>
Subject: Re: [PATCH] net: pfcp: allocate per-cpu tstats for PFCP netdevs
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-296823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,trailofbits.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DB5D65B896

On Fri, Jun 5, 2026 at 8:13=E2=80=AFAM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> PFCP uses dev_get_tstats64() as its ndo_get_stats64 callback, but
> pfcp_link_setup() does not request NETDEV_PCPU_STAT_TSTATS.  The net
> core therefore leaves dev->tstats NULL for PFCP devices.
>
> Creating a PFCP rtnetlink device can immediately ask the new netdev for
> stats while building the RTM_NEWLINK notification.  That reaches
> dev_get_tstats64() and dereferences the NULL dev->tstats pointer.
>
> Set pcpu_stat_type to NETDEV_PCPU_STAT_TSTATS during PFCP link setup so
> the net core allocates the storage expected by dev_get_tstats64().
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  drivers/net/pfcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
> index 28e6bc4a1f14..a6aa30ae0af7 100644
> --- a/drivers/net/pfcp.c
> +++ b/drivers/net/pfcp.c
> @@ -148,6 +148,7 @@ static void pfcp_link_setup(struct net_device *dev)
>         dev->flags =3D IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
>         dev->priv_flags |=3D IFF_NO_QUEUE;
>
> +       dev->pcpu_stat_type =3D NETDEV_PCPU_STAT_TSTATS;
>         netif_keep_dst(dev);
>  }
>

We request Fixes: tags in networking tree.

Please look at Documentation/process/maintainer-netdev.rst

