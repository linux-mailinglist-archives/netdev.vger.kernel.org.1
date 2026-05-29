Return-Path: <netdev+bounces-293286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAhBKoYjGmow1wgAu9opvQ
	(envelope-from <netdev+bounces-293286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:38:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD5609DDC
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AED343051FE3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAAC3AD526;
	Fri, 29 May 2026 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb3+HuZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946AF3A7843
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097717; cv=pass; b=oKtAKaHD3C/rI3Hx8k7HUe1HFqSIRgG2JEdxqCfxPS7+yhCITkd1DUUJB0nUAngjYlqR7RUYdLCvDTVp6L2l7PTqQvEBOxFGZXBZE0wW4Ey1jTa2FztXR7dq49qNOptxn7OMvCjEtitwFOsvjnfxbL6cNkwOE/ZuIrutTLcaxVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097717; c=relaxed/simple;
	bh=RDh1TryiPEs1usA4DHyJRDiRkmO5dyOy8Ut688rhdGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzL93CXipAge1YvKnBdGf0IZ0R0MNdMD0ixT5OOFmlD/o1lr3s0Ml2Gug4l5iyQQ8gEkRY3/O/GuP1jSfgvd5v4Zkeo6t4Anwgfu1BbaxynCzIjW/rYl2fHfr6q0uXdUqiT1hG+afttooTq3MVSx7jwXA/4XpzTDoy7RAmvJOx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb3+HuZ0; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso24370043a12.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 16:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780097715; cv=none;
        d=google.com; s=arc-20240605;
        b=hh5Q37PoYvDh3TUvwowv4ovqjc88PWY+0Jozba2ZZawaELsf76p9X5pVaEaXK4a0DW
         /GCe9XQ5r7WPnBLPaxejM1Gq8o1JLpumTcwzizMspqocTlDfrq4CmNiE2otIzxvIx1np
         eHBDRrBZxFFgzZwQzB0/89lKsJfTjlT+mSdyx0S3Rzgc85uFhLCTKAYEXdku8zbHaV3X
         CIFxyFQ21IwJsOdwEuek+WSq7ZBhbTZ5Iqo2DCYXHVJB77fqncNLCk/gzVORxltnKUeJ
         xT5y81pv1+at7IDyDSvvolhmswgVAVoB5XuE6dNjdq5Za+/WWIB2eM1mt2PG69l+8Dqd
         t3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lxSeB53o5o8Molm682lS7nVO1oy6iqUaszae9HOR1E=;
        fh=+LwgmKDJVrA84EXy/qacbpmZPnIUhYoV0uBQGf7wRv4=;
        b=ZrM/htR5ZoPHzGLYnWoBY9wtYWm0wO1/uu1s6Nhz2HMnh9SF58odnhTx80ynPr+C4K
         7ofvviOi3WWzQuO5gl1akqE9yz9+VXq9UGPOEu8QsVTG+1LvDwRJFEAbO9oQC4mZUvJa
         gHHqimAs/718zS18R+5mLM46tAecGJ+oOFO9zUr55Q9PS8N3eFrEQEYccmwie35OgQbM
         lk0nAsvQVaxdfTbZtBUgc0/sZ8pAQZvo0sE7Is4BUvQrhkkpx8hAQw9+xSiDnYmPTOEu
         dgtKiGNGWtHs1wuMUB8aCnqmiFZloOPRZzE1xGNnxUnnP8yMsNbehsC/cYpiAPP9r82w
         GLtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780097715; x=1780702515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lxSeB53o5o8Molm682lS7nVO1oy6iqUaszae9HOR1E=;
        b=Kb3+HuZ0PZ6d3iOA2l/Oc4wqcPibjNKJTMnhmRr5EEiwsaH2z163PjlJLy+kzx1y6d
         Hblauc/c/HBd6GrEv+tbcwXtg9RQ3JfQ4Q3IHjP6PX5wZUpKSZ0gB67MXiDD3H8GTb3u
         0qSk4Zbu21yYb6H1d65UJSrNVtUpuctez45nEHQORbrcpXgwPs7NWPPRjnHnz5wf62RC
         ep+g75wtFHUjOxFdgHPDUEKT9+Ltyfa7vF13QKOMWklpTa6f1eyPNooODCVCKYfYdXR5
         65HNNCNopFKooN77tqYqquLl6eLIS3orh+1WRulN4Fr97nrM51M9r+WecBxwqo9ReznY
         drJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780097715; x=1780702515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lxSeB53o5o8Molm682lS7nVO1oy6iqUaszae9HOR1E=;
        b=Kxv63PZEI217alxXRP9/OwvV2U0Vtj/X4BMcNQTC90Tw1bM/XLB782P/fAkUy2P0dQ
         3eqQUxjJ1aGV5q4dcSK6yFvcggTEdz5LpvMt3nDhjxBP4WJND/vXSRNsa8s8KvqRr9um
         yqBOSMl2c1HuJ5uKG22hfvWjiRGdxi+WXS7rKBVU76q1OvgiZxrjrpqcrUUwS936Ezpd
         NfOQV/b7MSKl8//wUSk+TsPgYE5+eLaTWQ0KdiTIun5/x9OwVG1AHCPllfcHapp/avuR
         gP8AdOMC7yXiN6QnJ1wx0KD651+CXFAzP0zCPK/7weTKpMY1nKHFE9jIwR0r88daF6mz
         8R7Q==
X-Gm-Message-State: AOJu0YyQJSUgR3+Ls4xD8DfASkdV7SHwxbfob4nFNC5t5WSWb5p23nR6
	hHUSCicqG4LkorCzjTr11k7PFvEr2BDurVdrbecqBPgEnCCou6pgpGqx2ooChI/odAYGDFb5Ezd
	nBgZyb72UKy8hccSTAemO3F3K8N61dBQVShyU
X-Gm-Gg: Acq92OG+7AcoPFO3j1BkmOFYrTBBMqGokQW5CSYbwCP3A2IcXFmR4h1V3PIPw86LgfR
	XSijEni4wZs4Fe359D/AvyU7JXZcTZyKHvwhu3SWsmxyaQsRs0suTwYcOtrw+PH3QICXerU2clu
	aHXcSn430VBpfWkUzlSWLvFotkuFzpaQJDyDdV3HG7Nwy49m737tvq8Kdbgci66Mfskq2w7bvcg
	W+Od6b6zL1u1J9IMog9C0UCQX9mPI+3tOXclpQBCBSCQaGO6RBuj/xvRPJYmnCa1EgVjUV7JipC
	D884tp4iHfg4fcLV5PIbIDR5/QRhOWunkxepBeVHtrZnyG2JLDHnfVf/yv1jfFgTFmT2t6GGHCH
	wNhytmck7ix+lzG4RXBuoF6ZgeZ0j73LU2TmMf00h1upZ9ILBRaoN+p/gVhlZaMK5LkompMTCO1
	/8uQU=
X-Received: by 2002:a05:6402:f26:b0:683:dd5c:191d with SMTP id
 4fb4d7f45d1cf-68c8d6cfa76mr704640a12.24.1780097714953; Fri, 29 May 2026
 16:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526202247.13823-1-rosenp@gmail.com> <625ecceb-3b0a-45a8-817d-337b37df7335@intel.com>
In-Reply-To: <625ecceb-3b0a-45a8-817d-337b37df7335@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 29 May 2026 16:35:03 -0700
X-Gm-Features: AVHnY4KOmlV4ahsFRoWTD0cIKs98CXPPUJAQG44FDr_DLyrGwTZaz7e6ch52nv0
Message-ID: <CAKxU2N9aYv8Cn7Ltae9uygzfnAiZ=qR2Z_9dH2_N_LThi05Xow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ibm: emac: Reserve VLAN header in MJS limit
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293286-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 30DD5609DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 4:18=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
> On 5/26/2026 1:22 PM, Rosen Penev wrote:
> > The IBM EMAC programs its Maximum Jumbo Size (MJS) drop
> > threshold from ndev->mtu directly. The hardware sizes the threshold
> > against the L2 frame minus the ethernet header, but does not
> > discount the 802.1Q tag, so a frame carrying a VLAN tag and a full
> > 1500-byte payload exceeds MJS by exactly 4 bytes and is dropped.
> >
> > This is normally hidden because JPSM (and therefore the MJS check)
> > only engages when the MTU is raised above ETH_DATA_LEN.  With the
> > qca8k DSA tagger the conduit MTU is bumped by QCA_HDR_LEN to 1502
> > during dsa_conduit_setup(), which is enough to enable JPSM and
> > expose the off-by-VLAN-tag in the limit.
> >
> > Pad MJS by VLAN_HLEN so a VLAN-tagged full-MTU frame passes.
> >
> > Reported on Meraki MX60 (qca8k switch): tagged VLAN
> > traffic drops at 1500-byte payload, while 1496 bytes works
> > and untagged 1500 bytes works.
> >
> > Assisted-by: Claude:Opus-4.7
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> If this results in dropped packets, that seems like a user visible bug..
> Should this have a Fixes tag and target the net-next tree? I guess its
> not a "regression" since the driver has always behaved this way, but it
> still seems like a bug to me.
Good question. This bug is because of DSA. When this driver was
written, DSA didn't exist.

net instead of net-next makes sense but it's not my call to make.

Trivia: downstream OpenWrt used its own downstream switching mechanism
called swconfig. Before I transitioned this device to DSA, it worked
fine. After DSA it started to fail on tagged VLAN.
>
> > ---
> >  drivers/net/ethernet/ibm/emac/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index 11d673a9f119..90471cff37dd 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/crc32.h>
> >  #include <linux/ethtool.h>
> > +#include <linux/if_vlan.h>
> >  #include <linux/mii.h>
> >  #include <linux/bitops.h>
> >  #include <linux/of.h>
> > @@ -457,7 +458,7 @@ static inline u32 emac_iff2rmr(struct net_device *n=
dev)
> >
> >       if (emac_has_feature(dev, EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE)) {
> >               r &=3D ~EMAC4_RMR_MJS_MASK;
> > -             r |=3D EMAC4_RMR_MJS(ndev->mtu);
> > +             r |=3D EMAC4_RMR_MJS(ndev->mtu + VLAN_HLEN);
> >       }
> >
> >       return r;
>

