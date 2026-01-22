Return-Path: <netdev+bounces-252417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLm3OhxXcmlUiwAAu9opvQ
	(envelope-from <netdev+bounces-252417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:58:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA16A7FE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70EE3065A34
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA554DB57C;
	Thu, 22 Jan 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2x4rP07v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CE4DBD82
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097068; cv=pass; b=knSx1CLRXMry0o/HiDwtvo1aGfqvP00JOSMj2n5yNDw99BEYvobEn/3R1SOPDtZEuoRq9JJV0IyJAI/YMESX49bOcNzM8ZB6MsKZZrbLrypIJeeTUl6lQ1ePTMy9s/ifXujYPt/VAtySdT0RPzjkXQfCb8T8fLo6dvw1NdGb/f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097068; c=relaxed/simple;
	bh=zELFPOpkKYtaBXZQ1nQqFqcPDXL3St3JrqClhZyZZOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MW9WcRODq5iAhWk6Z2yzPZxyvv/du2yqKZWiTaE3oTFVP7MtBywLKDovg1sQykJpQ2VvVccnjj32i+26FLPQ9+vvA/EVEKHv8n509NbuAv/f2xp0c+KZBSIlp5d3vpO8KIvVEQfh4n15AWjex2pLc98EdOU1x/ZrnGG06GDX7TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2x4rP07v; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502a98c66f7so8667451cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:50:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769097055; cv=none;
        d=google.com; s=arc-20240605;
        b=lK63pIlZp2ZnOnDbJIjPJlyeJnN6e0v/29dwZKBFfYrt1Mg+ku/lMzhLDEO9TeKhFv
         gU08ZT9Y3SDkwksya54nOPmVjiO54CW4OfefTS6D+LKldIRTW3SMz79VFXQamMu1kmiZ
         VObRiJgYHLBl0V3U63HiKum1dYWWkVIRpiUP1HmY41jgY0Wq2DO3IrvqOe5OjhRj007K
         gDuVtrhBuZz2mVrG675j/0tVDR/MT5dtxvqzdjVqsS+p40qCNBDt/DoYKxHHrPMQ6O3i
         jdgHSfSmVxxY2w0w/jCELYyqzYiXcEgcH8JEdo2c/pRK3LirD2EULR/9ljVJQL4mgVas
         8kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jft8fEYPshM4HAmGjPy1hkjLP+epz7TMW/Ln1R9fGfc=;
        fh=3Rk5QNjezc4mX5WbylVOe50dx4lNaBmVPjoqE/ClL78=;
        b=OXV9RBRBVLPfAONdSvw1MH5Pn+fv3Q4M3ZnOZyCTr7z6yF/v4w9ZHSl8US+6ivm8yL
         10YRTfLSL/yHvJ0ZSUKG9cFEGNcmpIL1w8r820/AtVFbvweXr4ooh62NuPNqMJm1vNpf
         hMaTq9Fu55nGe6i7qGV6u9UN5M4/l0hQXZGJI49Tf0tkWNt4OKm08qPvmDqsxGN7ZQck
         rNEPSV/v9C+dZxeLDatQc5v4+m/eDJD0MolZ06eDDYoVFyq9aEnVPRM+LR4STeJoPK33
         VpgYmwddrz+mufd7u7VZkuo115U4S2ovbbhyY3PpSfQZQDvnoEOvydEFlyJQSCEoumBe
         1tlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769097055; x=1769701855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jft8fEYPshM4HAmGjPy1hkjLP+epz7TMW/Ln1R9fGfc=;
        b=2x4rP07v1pjdKnlqzKf5XS8PaZFAIDNwcjv65dG2UaNQMiRCODjX/apdaaSiaKoUON
         QWxdI2++TYdWBkh2nwlyvOtDOpJJRi+RDZZGNVfN8kEi4yM392S6rDmwsNoJ4K7AuunW
         fL4DnXF2UjXl/+VS5yYRzhYkBpwHKGmVGu+cNa7nNFLjiCSnlamBiKGqOq0Nis6OqWjR
         mmt891wQ6EEDXl7K8r9aJ2dJNCxQ8l7BP7yoFBLIIMpjIs8NyFLwhwT72HhNunzfE+Z1
         889uBv+dav/w9xtLuCiJHri99Zjv580vQwUU0IH7v5qzbA6rYav0zbBIlYgIot3+zLrv
         G38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097055; x=1769701855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jft8fEYPshM4HAmGjPy1hkjLP+epz7TMW/Ln1R9fGfc=;
        b=gSxf/Nn49Z9NbJN7Q8LMbca+VE/jQ59Wd/qjOg4BBMA7ycW9OjGe09ABIOuGndkw9J
         8y9C4mLqZLzZgngPEQHOOicZ5OEAOSkpyB+qIagy4t8G6lU2XRa6kVVGr5vJs38u4RE8
         eicQJkV+S2M0OC2EfpFetadc/oeldZrCaXvPHTEDyyyPgtBgZtdSugYzF2/5ttTnn96m
         mdor2AKOGHyura0L2L3CCNatYfQYp+njXkR/o9Xue1F84D79FxbBkWsXn1noMEwRPy5Z
         rrjOzdGEtp/N/8+LRbJ4U4T9yjEWjExXwLOoU5HPi8fIh8HenNgTzwfoLMc2g6P5krxk
         x+yw==
X-Gm-Message-State: AOJu0YxU0ehICoDvJHWVl5ZhDnLFUyq2QqAfoN78cr1z1mjgqIEzcYWu
	9LWPUHGDqEUuO2WKIcg1NBgvXbBYJq96XjYH/0leTchJudTmEvNz11U2tvtLFt5huVZc4EQgRGP
	onSskR0W/uhvWgbFVCycNI2HzuQ4NtRGhaFqz/wbl
X-Gm-Gg: AZuq6aIak5CmK7/xGfshnHo5YGj4gVVuXh/N9A+xa4slGXRqE9p2lGogfj4iJo4CKpk
	5Tjb9qyJfsUHzGjuL5G4SeFFXRqnU6pHDRebkyQ2Ey3AB5vo5EiIbG0y/e3CKJI+B5xQnQRAUNT
	Z2WrS+ZukkZhegdCkkPoKHV0KseXPx0MlggTJj27KF4hp38YXTUJEMoSvMEtj+bSK7bRZoZbeTH
	XQDSbNmYYZ24Ho3PS2ZBndKF4Mn/XBP10Xe21LoD9xiRDId3MyfeZ0pIL/BrK+8Kif26DqT
X-Received: by 2002:a05:622a:a492:b0:502:a268:9de0 with SMTP id
 d75a77b69052e-502a268a7c4mr242940161cf.11.1769097055210; Thu, 22 Jan 2026
 07:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152856.1694824-1-edumazet@google.com> <20260122022237.2529455-1-kuba@kernel.org>
 <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com> <20260122072858.2b652eb7@kernel.org>
In-Reply-To: <20260122072858.2b652eb7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 16:50:43 +0100
X-Gm-Features: AZwV_QgZlGtRVdi2OsFipCo2VES5nwGnShjh8vNRoHIvVXr7P4vPCb_SH8gAw6I
Message-ID: <CANn89i+0kJ5M1_6NPxbe4k5eY4sPwNeKN0yKyaHzFhZDT9-=kQ@mail.gmail.com>
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net, 
	eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252417-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AEA16A7FE
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Jan 2026 05:42:55 +0100 Eric Dumazet wrote:
> > > This seems like the same concurrent access pattern that the ARP IPv4 =
path
> > > needed fixing for.
> >
> > I saw this spot, but determined this was used at setup time, not in
> > packet processing.
> >
> > I was maybe wrong.
>
> I guess if nothing else we should do it for consistency?

To be clear, I will cook a V2 with this part.

However, I will not add WRITE_ONCE() in bond_enslave() :

    new_slave->last_rx =3D jiffies -

(msecs_to_jiffies(bond->params.arp_interval) + 1);
     for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++)
            new_slave->target_last_arp_rx[i] =3D new_slave->last_rx;

      new_slave->last_tx =3D new_slave->last_rx;

