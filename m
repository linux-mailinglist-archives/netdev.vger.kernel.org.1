Return-Path: <netdev+bounces-272572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCHuDfuExmmhLQUAu9opvQ
	(envelope-from <netdev+bounces-272572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:24:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA283451F3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4AA30075CD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD213093B8;
	Fri, 27 Mar 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDCfkIYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805352F744F
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617794; cv=pass; b=eYFVdPjJC1bQ1icVNtJdDdgnGWDqBpqhL1aDFxhBnTCKplMZ+LRj0xDLDUiLmYsMAzPSPDDnLqfkX+47C96M8rqM1HtypVJiCj8/xKpR8tvUFOkvj8xWzhYaum0zvgYu/3d2zPw2GuBzSIq4aJNc+Cdyj0oLywAv8TtqzS3vMEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617794; c=relaxed/simple;
	bh=Q7oU4hJPlL6djnZwZRz9W0OHitIv8nDHH8/rU8cIL9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDBQlH2RONbny6X46IxzFNR/PHzdDqDg9AH9+rk40qoY6qYz+/ypKcLg7z5uWCxwwkz2Jd5J7lw7RQpVWOpDrCceds+bnzn3CkH0xKf6phDViQ7tQBrItexKCUHTlf4Ks8vMZ+KV0ico2H8haESDGh6aBr3TCxxTB2DeZ8CkQmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDCfkIYU; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c4b5dfe6cso1054469b3a.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774617793; cv=none;
        d=google.com; s=arc-20240605;
        b=NwVzrZln1StBDlqrYDEZTWhkKa9xAsPS1xagALUR2Pvb4whlbCs1FOsNpCxvVMgzbJ
         PBjrXiuSNOvog0PwAgGYkhEyvrNarQ2Bg2L3rLtCHLCSRL+5fskMOEKu8REFR3PPihCY
         S3JrUs3K3k9V4VvnJjiLBLKAIGlM+IDVp11xGMysqLiXSuQ+VCiV0GO6S4QrQQRJSuCB
         RAW+fQY+d+tapnfUOXN3iw6m7SG3Y+2D5DPXMOSbh1gGa2eKlXFI75dy5VtOU7cjKAkQ
         cRGqOjzDO+4V7IUVNxqgtOi9IjsXewqLdF3x/h9RK8sHPQeHxb4StO8lDlYlIR2HN2qI
         tq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q7oU4hJPlL6djnZwZRz9W0OHitIv8nDHH8/rU8cIL9E=;
        fh=rW1SPKhnWhUsegGFLwYSiKI2O9T8tYouWbuQ1tqqTtE=;
        b=E3XXJHcbhNuyaFmzh+3Y6LtYBPAQlagFdydREI7ta93h0+nmaDWDK/Z0J8gogrq+1T
         EikS97Q1qq8ifSTxj+0LQrj82RPX5+erpL1xyXiJ5qTTvsPOWntzHHGVt1UOp6egIadu
         LZQiMK2c5mSI3Evl1hbobwlb1d9aiEJUgdjRSPFR+CRHoYYUrkw+lLIxqUAkVaZAhqKu
         yChtu+ND7IhiDxaZAVksyN9Chh/4eNyYzI/opWWtf9IQM+4kTQ81r0w9Mcw9uneB4dvI
         wngbwoSxkeSbYJZKoA+LnAjFDZq+uxrjMflLOKVgNMyto715eMFbWuc0l/VQ8WxDXY/K
         zBug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774617793; x=1775222593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7oU4hJPlL6djnZwZRz9W0OHitIv8nDHH8/rU8cIL9E=;
        b=XDCfkIYU5rDBEBTa5vmP9uZ/JNUMJlVrZmm8QlvpYXySCENxjFzEP0J15N+2blV4AL
         mqiAjZjEsl9tjDHQSWd4dB6lJG2L6eqz602L7xJIGA+xSzt4gKo79elrZcFT42HWaiLv
         lgMGbSku+Vtlfdl0RUjZWj1af60U2rD5uH6XQiAHLnLapQk+EsT0z5NrED7Cmndby8zo
         SImpwE2jCyipxmdOr6pCQjjvm05fEAm0Dgtheb0dCn4KV8kdk8IHQsKRzBYS9mXBnAPB
         kHh2XPS1U4/GgxiFlvrZV3Ka8w8ElP+gu3oDXkMnIYQ83HINIBFsCiDVHaamFIsSBylq
         qVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617793; x=1775222593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7oU4hJPlL6djnZwZRz9W0OHitIv8nDHH8/rU8cIL9E=;
        b=Paa/GCppipheF2bS5ZGka9g3p1USxiGBUVOJ8TTtUVj/95U84i/5fc7uMC+0XdDjiy
         eg+TT6XMnDgY8diEc+EuzQj8FlZIjDzD7T3yy9O1BwtQx7e2qdXFTb1wWQn3WFbn4HVu
         UV5aiX0ohnz5+T+o1zj7bPc/Z+UaAkcwrFQeRAII3IQ2LcLJPMBMfsUc18WonQ9r0E94
         vEYiBXp8cxvcnJT22JZKIkzpyGkmnUfleysZaZ94M5uqk9o7ud17g+PyZt1e2qZZZUNO
         /DE3m+EnqecczxWFKfcfWyKnaJIYSAFC3tfQ8VdogYVRF4QHk1JZ6gr2ft07joNnHtgW
         oVrw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzT6kDFX8wB6qH2032RodSjO/QAceY7nch3PlzztclQnoeGrlyWCv0F+kfU3zB/GW18N5bWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hw0CFUkK5Pn6qKGeMhhiaCZPDWT1AbBUVHEM4Jo34kXTrz88
	wPp7Ip855P5FU66mZp2KbxckSb4OVWZ+f98KFhd0slgwwC/PfnIkXtqJK2l7ft8dCUPBKOCKSm1
	Cn4wYI0Fkkr2n6lu+n45Qw7Knv2LPK4g=
X-Gm-Gg: ATEYQzx4nER7ODqkBoGIMw62/bvTJonB2EtixMz4T2BybVHTgWCaIzvn+Y0ieHJo2fY
	tadlSkxMkrm2hXc1DqqRKiFmkdTqIegRz3tNHeP06FOWNsMW/ChoAPceBpxu6W6/SSVvnRYwjc9
	KWmWOJ21W+T/itehZYLqMqhYAriWKDsY159InbP5uYHaB8bjSdKb43XT01KbsXtwk/YS6WkCTyW
	CbAYcF1db27+Ldw0qFCl7fBx/sJU8AAUIPX5dJfYBt0vBJE685c9PzAbkSA2HFfHs9AxQdlwSvU
	ADCwD4+cYKENxEnH+1+ZhcC129Iss8WcaGDbEFwSybVhmAiSi1op86ZYFtLIMCJDUQRVZcpjNU9
	kOCZ1ozexXQdtUf9C
X-Received: by 2002:a05:6a00:1253:b0:82c:212a:906a with SMTP id
 d2e1a72fcca58-82c9605d1e6mr2451504b3a.36.1774617792775; Fri, 27 Mar 2026
 06:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
 <CADvbK_fj_26MLP=+U+rzOMfqdPpdvFQJgN_fozd2uAjRsfHweQ@mail.gmail.com>
 <CADvbK_f3LwEt+-BG-1Pcr4jMn6Jxry+0p-Fu_s0C6Px+F_NHCA@mail.gmail.com> <CALW65javKc9H1zQ4m5cb0qPfXix+bWM9LcVZ+uQN5BdgdTQ=gQ@mail.gmail.com>
In-Reply-To: <CALW65javKc9H1zQ4m5cb0qPfXix+bWM9LcVZ+uQN5BdgdTQ=gQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 27 Mar 2026 09:23:00 -0400
X-Gm-Features: AQROBzDeJATj6uIDvTHeARXRmosZWl-Wxm7cMWSFpdK_thjyU_C8O3jj3D6-iPg
Message-ID: <CADvbK_fug3vckLkfufLTtqTEKzywRUw8C_dzfW032_cb6vLpZg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Qingfang Deng <dqfext@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Richard Gobert <richardbgobert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272572-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.711];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEA283451F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 9:49=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Hi,
>
> On Thu, Mar 26, 2026 at 10:44=E2=80=AFPM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > On Thu, Mar 26, 2026 at 10:43=E2=80=AFAM Xin Long <lucien.xin@gmail.com=
> wrote:
> > >
> > > On Wed, Mar 25, 2026 at 10:43=E2=80=AFPM Qingfang Deng <dqfext@gmail.=
com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > In some cases (such as BIG TCP) a GRO skb length can overflow a u16=
,
> > > > then what should I do with the u16 length field here?
> > >
> > > I think you can either add a check in pppoe_gro_complete() to ensure
> > sorry, I meant add a check in pppoe_gro_receive().
> > > the aggregated size does not exceed U16_MAX, avoiding BIG TCP
> > > behavior; Or, set phdr->length to 0 and rely on skb->len to determine
> > > the actual length, as done in BIG TCP itself.
>
> In my v6 patch, I set phdr->length to 0xFFFF. Is that okay?
>
> https://lore.kernel.org/netdev/20260326081127.61229-1-dqfext@gmail.com/

I think you need to check how the PPPoE stack handles this value. If
it recalculates the actual length using skb->len when phdr->length =3D=3D
0xFFFF, then this approach might be fine.

Also, how does the PPPoE stack distinguish between 0xFFFF being the
actual payload length versus it being used as a marker to indicate a
jumbo packet (similar to BIG TCP)?

Thanks.

