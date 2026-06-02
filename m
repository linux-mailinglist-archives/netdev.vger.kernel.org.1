Return-Path: <netdev+bounces-294291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tAf8MXEFH2rSdQAAu9opvQ
	(envelope-from <netdev+bounces-294291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:31:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B363037D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:31:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZdalMcVU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294291-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6729E3003343
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8A1607A4;
	Tue,  2 Jun 2026 16:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFD36AB56
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:31:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417881; cv=pass; b=Y6gGMNm4CrTjPXY4OyyKUW9MIi+fC57rjZvepsj0TpxNeLkJ2Md2QnyB7UO4EMIsR3YvURrlTfaZjHE30AHsV5qLR3/yqhxlSrog3C2HRwFyz6idmwJ8Jj5kfCGaP2XeaZYdMfZ+oAD646chdVs948kmoqeWqpo7jKbFRhg7UDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417881; c=relaxed/simple;
	bh=+VXIRUZA/7AmOZN7PldaZezSA0YftdYb3eBo00Is0Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkPvUQP8aGDHf6aXPP7pFSCntS0jtFfWx6gqaBsUEpil9PtPFySct8YtfwlKyqV6gUOWG1O/e6svpsTviO8NLTXII3Ae6lZ4s3pLzCXLxHwkiOWOCSDtuedfKQ0ma3dfB1s6NCoB8/jqL+t3NGvFVqQ1eFdYAnmpXAwno7Qg5EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdalMcVU; arc=pass smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137bd9ed2b1so726086c88.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 09:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780417879; cv=none;
        d=google.com; s=arc-20240605;
        b=JXE/DcbSvsWrDt7rurGg7x2mFn2qno6KylZQJwonsiaBbHedsHZ4RCxCo5y+4yEY8K
         LqdXomxv78YKE4n9RctlCV9JC2ADtWumqkop3HAmtNFdo1NQ5U/X+0P3oq+/iSLZAHAA
         /8SjeObV3FwYGiRCnxBUfevFfXYaAs7I1Ck12q80vAKYPTaUCJh3d+m7hwoqYzLseOoH
         0JgtussSN1opUugwLqFJys9HQNuFM0v4Go6uj4NEmm79kAC9kDlCUEVLxq4/HM42AjbP
         9/IJVCB2hSoID/honQvCVMyVn5Tb64VKY8u5be8P4rOubPvGX0REww4z3FTVwVP0scPP
         VIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+VXIRUZA/7AmOZN7PldaZezSA0YftdYb3eBo00Is0Pk=;
        fh=EccM44b9IYiws1njXD7BAGv4P+Jc3+OceSa5aB4M4+c=;
        b=fKm+Atc+VtOwjb+dmhQ1JgL3AoyDFla0ZIPzNJH4R53Q0Py03pDVPzl614UVaWGCSd
         0MrHxbIHLqNB9M9NJ8V4TY7pK3GuHn6xa3mDuJqmxpFT34011lzLsjaSIeqK4Hg1K0HB
         Di8NLA3v+Je+2gCsXJlOl4imu7D6p7whPc2FM0UqpEWPRanbl8wz7FOteX4m4hcrUhod
         RYOKnNytgvIXTUIHFSCFS++GatmdeCnbPz8JQNWzELaI5iB5kyhYpFteOxtmh/BVIUVz
         3ztpOV+DP/mXqY8SL3ToEc8hrSxMa5swdq5XJi2nIHRQ13Ly4P8ip3Bk6tzIjheJ66Ro
         oB9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780417879; x=1781022679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VXIRUZA/7AmOZN7PldaZezSA0YftdYb3eBo00Is0Pk=;
        b=ZdalMcVUkhLldAetHFpsc5HfCEK1orVfZHIMbZ9iirDo3v0BtR2ictAFBoWG0iN9Iz
         HTJ3yuawfz18F1cti6G8mtjI91CGrBMNqznsoIABst7thrVbgl5J0ofG9+EgS6C2xNRt
         V6+yPYg4sU1qNJ9jfLWgiHPBCSajW16qhDAqY5xtfOSvRBz94AujbAwAvqHp0FTsIQ6b
         aalLFToXdhSVgSziEzrCFSfz17eC8BwZqxQXgQJs5JmAUfguDQBWUDNsyFv2QDC4BYgA
         rfcOlj32/wSlH62B7ctIezaiLlzc3EWlwHaZTd/ZxEBo2C5/JReoaboEqAoliyBMeecc
         cmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417879; x=1781022679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+VXIRUZA/7AmOZN7PldaZezSA0YftdYb3eBo00Is0Pk=;
        b=I+jyr4iA5+NOauS2EFT/jOy+fRZHWdLHCiO15wZUPe5i1GAzdLPnzCmTJIMwyY0uhM
         ntuq8LyuiFPq/ZLz7uS7V+yVERJHo8JIqn7xB95HRCzDy4TSmWjWKeDK9CctPBbLmFEy
         OrX9ISIntn6dqsw433+LUK7YzW+vG7kqnL4e1V3SDSJol86nGXZ9MzrzKg41edRatAIn
         AsnoiE6xMpmNlATVzWDAIB/GVMAgvXad0Xewfj3uvj+Ma8ow57ENo23aBDp8iY1xbEU/
         XIVzU8xsaqmfmWITajFq++IFD+l1CP1mR/HCNU+Cc3v1wnWcI0/7N/RbG4WQqj5TN2jI
         QdtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WTPcxWbFuG8uIe/DMr2Os+78X2Y3SR6zIdskC4b0ysfLZTCcDYT7HyAy/z3RJWXiRQZwwRNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRv0YgwK0nB10kXPGqnvchOzwmnKaPFQxINdeg09URCyZ6Ga+
	nxoUDf2qgWVYiTdVKITRbSzKDo2yuJNjlrb228Sb0vDOmyFwe0AooTU3+UHH6guLE9VBcoriOPU
	Vwd/5TmCe7kU8z+R5zOikf4ypVsPCIYUF2+igRTN/
X-Gm-Gg: Acq92OF5RTvaIZyIbAw3h3OtxB2cnoh6AIeuAe3kPlvMby3VAqHQvhqpbLxoqu0mARu
	ODSf9MPqaos3Vh4u1zK/7ZMl3fTekZjG0jKGzI1ayLymX+8wVGDqXI7pGWYPMZUroCUtopYnIyr
	t5HNppAFbO/ful2UYkwg+cWHyWxmul0LlO7LXL+NKj1o1cDfPzdE3JjKoZT9/hib+tIsq3Rn2xE
	/oshFANTPN99DhNv5wXHTkRkwaC7Ndroej/jgmc5HTUfOdECvlrj8jcs2TlOVqLZK3ZAzSRDNQI
	fRyikbrKEj2Mwusu2vZm1jTM/dzL21+2ibz9N1TWXu6GKgAcuNCET1Ya6SYiVy0WotJrpiLWcl+
	+TLEd1reyMTRUJ97zqH5QLDM5mxW21iyyJwhyhLBzlH+MC048utzmQCQ7Q0SLwcA=
X-Received: by 2002:a05:7022:607:b0:137:c0a7:8d0c with SMTP id
 a92af1059eb24-137d42420fcmr7967313c88.23.1780417878501; Tue, 02 Jun 2026
 09:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528005658.1756248-6-kuniyu@google.com> <20260602023402.1647750-1-kuba@kernel.org>
 <CAAVpQUD23owCGnbX0nxGgOGfjwr7At1sYncimrs6Sab6=rZ8yg@mail.gmail.com> <20260602092115.67f813e6@kernel.org>
In-Reply-To: <20260602092115.67f813e6@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Jun 2026 09:31:06 -0700
X-Gm-Features: AVHnY4LjqOdPHFjnuNplDTfZhtbYqeG8RhATAszAr4UENZ9VL5KWtiHRepTlPvE
Message-ID: <CAAVpQUDudcbkr0E3QJ-pojsJ5DdeLZ-BkPhVSgM_+YgH8K2rrQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, 
	stephen@networkplumber.org, kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D0B363037D

On Tue, Jun 2, 2026 at 9:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 1 Jun 2026 20:25:24 -0700 Kuniyuki Iwashima wrote:
> > > Does this emit IFLA_GENEVE_LOCAL or IFLA_GENEVE_LOCAL6 on every
> > > non-collect_md device, including legacy devices created without any
> > > local address?
> > >
> > > cfg->dualstack is only set true for collect_md devices, so for any
> > > device where the user never specified a local address, info->key.u.ip=
v4.src
> > > is 0 (or info->key.u.ipv6.src is ::) but the attribute is still emitt=
ed.
> > > This would change the visible output of ip -d link show and netlink
> > > dumps for existing GENEVE devices, adding a synthetic local 0.0.0.0 o=
r
> > > local :: that was not present before.
> > >
> > > Would gating this on a non-zero source address (or tracking whether t=
he
> > > user explicitly set LOCAL) avoid the dump-output change for unaffecte=
d
> > > devices?
> >
> > Honestly I don't have strong preference on this.
> >
> > New iproute2 will show 0.0.0.0 or :: even for devices created without
> > the attribute indeed, but I guess it's almost always the case that
> > the dump command shows every attribute when we add a new one...?
>
> IDK if there's any strong reason one way or the other, but my
> understanding was that we try to only dump back the optional
> attributes which were actually set by the user.
>
> Whether we follow that here or not is less important, but I think
> the bot makes a legitimate point. If we default to dumping zeros
> even if user never set the addr - we should allow user echoing back
> already set values in changelink.
>
> IOW the ask is not to rebind but to compare the addr to current one
> in changelink.

Ah okay, I'll apply both changes, thanks !

--
pw-bot: cr

