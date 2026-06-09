Return-Path: <netdev+bounces-297100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Op9GLJQyKGrQ/wIAu9opvQ
	(envelope-from <netdev+bounces-297100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:34:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A42D2661CCE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:34:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G9WGlduZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297100-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DDE731F26E2
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE747D934;
	Tue,  9 Jun 2026 15:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620835E1B3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:09:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017768; cv=none; b=gui6NfLVXVAKurcgGF+5hOM5aR9h6aSVFl1E3DS302kM100uDreiQ2WoL+xeYh5ybtps9APbNBuZ3nAx3QCBCzsIrhk+gQW5Cwt4XkSvXSmM/Nqg45OiCfUABK/+s3pShsYWz3xUPKumcu/RWgH1hm4jSKctfjiAFNN/WOSR6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017768; c=relaxed/simple;
	bh=NgOku+kOtZFMwP+N1pCTFHMki0MWqL+yi3KZd7s2JhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvz9+Djl/Ipx1nQd6POrTv2m9UU70MJ0JZrQD851WkW2RGk30ZKVAOg0bpQA3XalRiFL16ruDIliOfBrgwuyOV1vCzQDrlAyDbJLR3H0DJiTL5Oei8TrcQzltuV+ZIJZ6x+qVnMMnU0bY/oKxwgGViHDKz4m5D6r5aD+dAIUQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9WGlduZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E167B1F00893
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017766;
	bh=m6GRnCt3iEzDR+1BDeOhhAllED/qkyhg1ytTSiyIFoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G9WGlduZEoSZGvVJh4dCWgFkcyY0qgcZWE6JJDU9sM5TP1AL5Z9yqpQNjRpwMbTu0
	 VDybp4s59jLrTi8U9UBwPSE6DymK287VxOrjnJM93SKkpQF7U4HHpxMe9mSNM/UdCv
	 3qA3Lg76o1WKJ5v6fK2Lzl2zzHcXbg2Fd2/fh+UwiNRhHtm6E9MaLZytx9dBmb2UdS
	 dKBmwkXqKbGhbMIxRLhpdkgo/3itxCqOsdEfgi7lDDBU7lqEVdL8zUKe86B+eoCJ9R
	 5AZfeapPUGWVb/rlEPhFQf0Xvx+RscmE8OVtXUoMQw6kIKct0bcd/UDs1fr1Jen5Ai
	 UK8mn4QhGhJTA==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66077c46c5cso5119420d50.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+8DkrkwT8CdWqrATvo3hdMHkGol+odsjSGJ6vCUwhYmskPKWIVrlBcoguoPwdWVnWKlFIr8CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRA8n1Nbb4OCG89+Afbd7iYudWQt0DBeauyGV9xfioz5lEn4u
	mZF8e4YvD3FYQtWJhVFNVbi/H1LtVirLDwg9BbvkoUkOvVwIczbKG61MIxEDWjNlwuaQwofNdnb
	xx2Fu8K8vCXToQoueDAFOuurOCYpV3cA=
X-Received: by 2002:a53:c3c3:0:b0:660:580f:69f with SMTP id
 956f58d0204a3-66106f3ff76mr15067067d50.40.1781017766129; Tue, 09 Jun 2026
 08:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-30-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-30-david.laight.linux@gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 9 Jun 2026 10:08:49 -0500
X-Gmail-Original-Message-ID: <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
X-Gm-Features: AVVi8CezcShmV8w3vG8YvNt5rtMRYufLSGPSIMO6Dnp0q70W64s1zDjdmwyhCoM
Message-ID: <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use
 strscpy() to copy the ethtool strings
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297100-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:timur@kernel.org,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[timur@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timur@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A42D2661CCE

On Mon, Jun 8, 2026 at 4:55=E2=80=AFAM <david.laight.linux@gmail.com> wrote=
:
>
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/=
net/ethernet/qualcomm/emac/emac-ethtool.c
> index f502db9cdea9..ffc300641aac 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> @@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev,=
 u32 stringset, u8 *data)
>
>         switch (stringset) {
>         case ETH_SS_PRIV_FLAGS:
> -               strcpy(data, "single-pause-mode");
> +               strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
>                 break;

It would be better to replace this with a call to ethtool_sprintf(),
which already takes ETH_GSTRING_LEN into account.  And may as well
update the ETH_SS_STATS case underneath it.

>         case ETH_SS_STATS:
> --
> 2.39.5
>

