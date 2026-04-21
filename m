Return-Path: <netdev+bounces-280207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CDVGWC452mu/wEAu9opvQ
	(envelope-from <netdev+bounces-280207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:48:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 648AC43E2DB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D6CF3014297
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90E82DECA3;
	Tue, 21 Apr 2026 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4DnlMn0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4362D97B8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793691; cv=pass; b=i92D78R74EBqr656sFyfu+OblUSQd92GSHPcdmKaE2S115xLf8DJjLatuutRsNXN6LIqnOBSGRn+weC7XpeyosHQm0jVqiAVcCPFWJkfuRDSIeuBEdjjufI0WaK4R+qqLUqaZ+czTTFy5eLXlJ5rbdVx9ito3gO7ttshMhUQZjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793691; c=relaxed/simple;
	bh=hcx0YvejmS56JerzIhSsVfjd9XdxU+3Ujo+jeia083Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3m/t7OHwDvlpNxsHGuvTHlTL99gH/Mo/JK/9t0RI+PE/qInnV5wMPu9A9wpeLsKLKq1KPsNKlnDZS2QY3VaTWqf9+lM8m2wQbcHDGE/A8Su7DKQkxVWgPKo6oNMQi53RXmkXpDGh2JERvy5LmfU49c6aYO+t4k6UBrdA5bjFm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4DnlMn0; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e538decso44299667b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776793688; cv=none;
        d=google.com; s=arc-20240605;
        b=WYBVf4RPqYSVDxE2Tkqrdq52yM1kZavJSLJttxO9+GIOP/OVnK7IIkjizyUqyUo1Ul
         OwYDNxTAXzHFLi7MvayXKwUM7LjisAmHYOxbbRYq32H7prpclOvCk7gHx7QLIpcXJYPb
         +npgf0aqxHcgcrfCQpyTrlIyQPMgf/3T7eMvGuNeLzJUX2McL2W7/3m6VOw23pi2ZSGu
         qBK5tqfBAJHtL/r0Ioqf8RTcBM+ZioGTV4Mn88RLefFEs/YVVu3nOjkRdBsBtj40nDjg
         KPpIPdn8/bhtZ5Rqnv9chGDXZUzoQqe/S3HqTAVIPaROYmaa0e/XbU7lbvLxfDHDqZqw
         affg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R03tCF/ZHiy8KuP/YlPNlHYbG1HQ0Gao1w4hpVeTgxA=;
        fh=/FreAOyBHMQU/xBdQb56Vb924U82dD04pzfE/xlKvys=;
        b=PcsbJQtJSFLz22NS6+YuAf8nae/E7Q3lsg53+gdS7BD/nEISvZd0ybIvK+FpV5coRj
         KPGvhgLWGmpiu3pOfKkYKQjQUsD8z76l9LpI1jIEqycnaaX2aRMD6KlGQ+s6ijPDqGwu
         WQPxGZVngevPzSnL+x4EHb/tezAuFFLXFqCdjrRZV4djxbaVCrscWoJyTbjhsKORMhd0
         ZeF3LlXOxzHpgFrjOrT6eeT/XOkYhUBmyEgxfM7AJr1ITW0tML034zbDeHFpfNuXDx5t
         MB2zg22CEukpaSPKT6neOoid3Hez8sKeo5aCiqUyLseTxoly14afvCABaG4Ex1lerESR
         BA/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776793688; x=1777398488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R03tCF/ZHiy8KuP/YlPNlHYbG1HQ0Gao1w4hpVeTgxA=;
        b=k4DnlMn0nwgZvsc3wFfEyq/BVj360bYBk69WcMHVTbu3DEAuyv+f8FIZHYgX4iAh4H
         PhG0Ryp78+MdHcAeqt7wlRIlPlwCP9NP1swyf8ba04db/pM5OPiltOIZo4Ue2g98uy6I
         cpQt5nzPvenThYtc6/+oKpvwg1ZS6Pkz+7GkZVVZCcvhcJHWm9IgqmHS214DDUk4PiG/
         C+2Iv7PNbf7ciGC/4xX2nlSOH8RPlYS628+qZR5391POGk3zncYWcOxAHBm4midKJyl7
         kldlLHrQK1GueLPrku0zK3JY8c6HPe2D70Nt9KmgW4ePdaUCxnQpm2NGi2m44FfQfSRZ
         kM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793688; x=1777398488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R03tCF/ZHiy8KuP/YlPNlHYbG1HQ0Gao1w4hpVeTgxA=;
        b=KpRwy2bmfNXdEGxfDGKTAqPnE94sFLZ8ZglOOFBdrBaMpxEiqXzHDWTB2ahjV4YjcK
         +Gwf8s0iiTtEQN9TdcN9NouZAR7xkoAqPtCJfawTHYMyFspR5QwMh3Pve2mriB8cyRnm
         /YyhqgJnridYmfMzBpEugXHv7duL/6cPf3bSpLmfVBMMtQ2OOSMVbOo4TV7m3afkbWKq
         gPJ6F5pe/VVMimiqTNkUINb3TpcTvYD+bpClvAL5ZZ5y5hNYYyhLxYw3b+39iDKlkMAT
         z6n7pRiPbUUuFShWHs4AmAzQ7ih+o4B+AxxaBR93z9q3P13JLu1i8DaPuY8IkH56S+Wl
         5B7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/VZc3W4QrL5+V8C3I14sEszlEfoIgtoa4Px+/5FgKuBLW83vVJ0GkNYRQ8g9twFdsZQLOQwas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELKOOt0yM6KhqVDZGU64h8yAf6GO0wnCBD6GuEJXd1UataiXO
	SoajR7oLfIDm3wAi0h5bEmvU+RzllfBaf120UDcAMI82UuszjPM/ziNxOZng9sQ5shL4s6eQ7AP
	a7/THBm6jVCHBw1TxdVCZghkq9FlBWuw=
X-Gm-Gg: AeBDiet3rwqeMfBgVuUmlrJUwlvfdCVpe0PN76ep3hmAOcVbB3jTa877iJc+faquE2H
	ofkOcBGsYTgCNGJmaKG5FbvC17QispDQGGNLAF8Hy00AuDKiPqRas3RZbgbJpbaaAPozp6ydc3L
	0dfciAQF69j7nbpq5VfxguhyTi5eLBKfzSjGkPQQHa6ZOOPODA3qzjU680qQ/UylOvEufaL37wA
	grVxbnrGHdUA62hNiNgwH/EkH/dOqCBb+/TM0vPOSLZCrkKTNmZkdP+ulxFy72AHUzwa4Okq0cM
	hBYNdNvVX4/rKD+coURB+fXXW8rxLagFKf0zO6B/08Ir8P86Ms8RGxvB2cuzbVxf4DX+mvGPYTX
	2ct5hUktix1/vEmoRb2O7uzg+SdL8TqUItUc4
X-Received: by 2002:a05:690c:385:b0:7b4:2bbb:441e with SMTP id
 00721157ae682-7b9ecefc3e9mr204444267b3.22.1776793687897; Tue, 21 Apr 2026
 10:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421021824.1293976-1-kuba@kernel.org> <20260421065507.2c5e3ba7@phoenix.local>
 <CAEoi9W6ZRw6aEh62Xbgkg-TW8URHbVp6dHTT9krFiTkotjTuTA@mail.gmail.com> <20260421101400.67545b20@phoenix.local>
In-Reply-To: <20260421101400.67545b20@phoenix.local>
From: Dan Cross <crossd@gmail.com>
Date: Tue, 21 Apr 2026 13:47:31 -0400
X-Gm-Features: AQROBzCKdVzPerkFTjJ54Zrsr1a5zXRmBIrK9mgKPR_CiQnkbs5x85ZT4lxTKvU
Message-ID: <CAEoi9W5OWmme-cwH2qiwN6JaFbvyWSUHdJemk4UaRG7zQehuCg@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	federico.vaga@vaga.pv.it, carlos.bilbao@kernel.org, avadhut.naik@amd.com, 
	alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn, 
	2023002089@link.tyut.edu.cn, tsbogend@alpha.franken.de, dsahern@kernel.org, 
	jani.nikula@intel.com, mchehab+huawei@kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au, 
	ebiggers@kernel.org, johannes.berg@intel.com, geert@linux-m68k.org, 
	pablo@netfilter.org, tglx@kernel.org, mashiro.chen@mailbox.org, 
	mingo@kernel.org, dqfext@gmail.com, jreuter@yaina.de, sdf@fomichev.me, 
	pkshih@realtek.com, enelsonmoore@gmail.com, mkl@pengutronix.de, toke@toke.dk, 
	kees@kernel.org, jlayton@kernel.org, wangliang74@huawei.com, 
	aha310510@gmail.com, takamitz@amazon.co.jp, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280207-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,lwn.net,linuxfoundation.org,vaga.pv.it,amd.com,linux.dev,hust.edu.cn,link.tyut.edu.cn,alpha.franken.de,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,netfilter.org,mailbox.org,gmail.com,yaina.de,fomichev.me,realtek.com,pengutronix.de,toke.dk,huawei.com,amazon.co.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[crossd@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 648AC43E2DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 1:14=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 21 Apr 2026 12:17:23 -0400
> Dan Cross <crossd@gmail.com> wrote:
>
> > On Tue, Apr 21, 2026 at 9:55=E2=80=AFAM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > > On Mon, 20 Apr 2026 19:18:23 -0700
> > > Jakub Kicinski <kuba@kernel.org> wrote:
> > > > Remove the amateur radio (AX.25, NET/ROM, ROSE) protocol implementa=
tion
> > > > and all associated hamradio device drivers from the kernel tree.
> > > > This set of protocols has long been a huge bug/syzbot magnet,
> > > > and since nobody stepped up to help us deal with the influx
> > > > of the AI-generated bug reports we need to move it out of tree
> > > > to protect our sanity.
> > > >
> > > > The code is moved to an out-of-tree repo:
> > > > https://github.com/linux-netdev/mod-orphan
> > > > if it's cleaned up and reworked there we can accept it back.
> > >
> > > It would be good if these protocols could be done in userspace
> > > or with BPF?
> >
> > Consensus for a userspace implementation is what folks on linux-hams
> > seem to be converging on.
> >
> > The amateur radio protocols are more or less specific to low-speed
> > links, they are not particularly coupled to anything else that
> > requires running in the kernel, and the main coupling point (IP over
> > AX.25) can be implemented via TAP/TUN.
> >
> > There are several popular packages that already implement AX.25 and
> > NET/ROM in user-space (for the interested, LinBPQ seems to be the
> > canonical example).  The main missing piece is ROSE, but it is likely
> > easier to add that to an existing package, or potentially something
> > brand new, than keep it in the kernel.
> >
> > There's no compelling reason to keep these protocols in the kernel,
> > whether in-tree or out-of-tree; at least, one has not been
> > articulated.
>
> Thanks, my other concern is carrying support for these in ip commands.
> If not kernel based, then iproute2 doesn't need to worry.

Agreed.

If someone really wants mimic the existing output of those commands in
the context of a userspace implementation, they could write a wrapper
program that invokes the real thing, and extracts relevant information
from the ham protocol implementation, and interpolates it into the
output. It may be an imperfect simulation, but it's probably close
enough for most users.

        - Dan C.

