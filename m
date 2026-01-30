Return-Path: <netdev+bounces-254953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NCrBUr2e2nKJgIAu9opvQ
	(envelope-from <netdev+bounces-254953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:07:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A1B5CB5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17368300D956
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C69B672;
	Fri, 30 Jan 2026 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPWloqYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092441862
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769731655; cv=pass; b=S1cGjEPulgTOsMsnF90gTFWz/JXCqtzROnGMF7YJYECDV2IsXHrDtKcL2z36Uz/9u0xYIKfDfgjAFRtLgoLLcsWmBZltbP7cnKex+wstq+18EoFO49dS5Oy8IOOwnC7UwLPxGCAMDE2vTEiVJ+LFTWdUpy9vrw9h2W2rsz2o5ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769731655; c=relaxed/simple;
	bh=hTqXBnUUMSOAjIRz5btrHJcZQHibbqU+6OIdwjiI3zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kR7GOu+csanL/nX16AbIxNk5VNaBu1Jb7zwF84GJZvCXuk8/eDitTWdWYhEwskGXXKld9I6Hw4jJ3TjlRs3LctlssC584a75QQ5mATaEHMzTFu1gFSiU6nwBJaxbWWFhps61sz8PtuhC4i0+0Ku2Bj3A9Fwn5Y56IV0W03YbiKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPWloqYK; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso2493617a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769731652; cv=none;
        d=google.com; s=arc-20240605;
        b=AnErwqDsR1F3HrkxNoRcBEc2G5IfIAHXuYncxgWpi2HhZd/IW9OwM6uiqFI1IyRudJ
         iELoVMhbHxgsSITLv4ZBLh5b3jQzQ9i0uUcPJzBuVIk1PYSQM4kpr9yz5k6A0EetK6Ty
         luQvAdPzENMl6sKXNyFwstm+aRVQXLmz8fM1ry7YP/Ptv/zYzPSPT+zS6CEnYXVQ3w4z
         9eIUrnnvnZ3Yt3M0HsjKHtnnmR5NBGVqTnsyd2xm0d08xaumS31O6k29vXzYRTDjQYVG
         iOLaXOhZZiOaiW00w+6GQXeJ2PmeyEV97pfwz9+Pc9RvCQk5o2qzlC1OK+//0JBY0DFW
         LM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYC742VyDVV8+oX7kKIbHIGMTBb5liB9wZLrFBsLqU8=;
        fh=IMpvYBFpXq7tI6yoAEIxriQpbSZs06eDD1IG1tVPeC4=;
        b=RBL0hEpxWOzP/tHR3VrK97tiqI8OvgLdOwogddV6gt4kKuJD8qu5s1z3fXaqpZHh3b
         1YaejUtWK+YOysk9gw5bNXldNkD62IbqMsEcWpoDH+5FVQqg9qQfz7TvPRO7gkbDHqMh
         84/6pJnEKvtcAWbmrYyxpYhlHRTPhXgq1SuCYXGtVM4NptVWokYZryRqxzUlSeIGKUJX
         ZpWwml/kdKxFshjT9RadAayLjuvpU/DuMpxRR8/869OFZXOUjz+X1ZtyRR+O7fPRJjUB
         NIOYHQUqErMRYHZhlYsZbyHQljsZp9ZtPbaL//np9KAap3S/9mu2JDycWZkwIryOPlPm
         xHAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769731652; x=1770336452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYC742VyDVV8+oX7kKIbHIGMTBb5liB9wZLrFBsLqU8=;
        b=EPWloqYKEl9MRIIaFF/da/hR8vXpYxZAwSECfN6cviUNUXWghHPF/KoLMHmh83RLnZ
         6DaiFcS0NaKH6pu4FiEn1ZrPiwmMV802RY5aXy808TifeHiziFWa508+GCEgACI1soxK
         EMZ4C5onZ3PCHF2aDl9G2PzEqZdgDBMCNaBocKrgPGqh5yvAnbVlCVXVftkpPqT6EnFd
         8AgBo5TMisqRlyRyrkSsSCJbgzBpGOLbV+QBxYeFZj9KVpnQSQyx6XKhUOZ8gy1jtHoq
         3G3UVCGkspdyWQB+NqcollABNro/an/0UTM8GNZz16kxXJJrEOw1hUsdNhX4Vq2pnArT
         9dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769731652; x=1770336452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYC742VyDVV8+oX7kKIbHIGMTBb5liB9wZLrFBsLqU8=;
        b=utujK4dKpGMVRXUBoXIgX2B47WelojTa7c43/nXI8H3Nz9mB1lL0osbS1wwMFeAefP
         dq/cM58wwEMalbPpwzfwx5MBQfgaSqIkEKZndRqpL+o1rpy2+1to9abT4Z6rez9m+DIP
         vFoO4UbWdrNL8OiG9wly6cbHLH6ae6N0qC1gd2SwtJA3Zx6/TfYehGSeu8a0/oIJRpze
         cNirJkIh2lsffuUmiPqeiQpCUDtgT46qGaGuJQRuvcrL8evDF59AJwChzCZHm381DV+h
         jTbNi3GpUJv13ZPt3gOc0wBNgjXl+Iu+pazGedcNGbn9GhAcpAIIU67WJkx/64FOsSPM
         mv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLBTEUdvwWREE1miytCSOz/trOEmwQ9+VQtmF9JHMGioPDsP8nwonBvhFWIkhNas8+dnm+8Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OTCqLh/AcRQNkWzLh9+IulvzX4zkfUA8+UIhxg3w4MmvPaJ7
	K93b82VOauoyeS/G9h9YgY7aO83VFPuEX3awIVzQJw4eeNNP42hMblfwUfCv5ttgtnqci+/66zb
	y0WJkFUQTYPRxiLjJgiM1Ngd+r14NrtE=
X-Gm-Gg: AZuq6aLoEF3jHfTdp+I5NWgsHRbqa6j9toXISUzZCHoo7DLgvoQ3C2EKkNb1G46U0F7
	oPr4f+hNU87EnWhUD77/DU80eSeau3aX8py1vzyOkbjqk5aezPv6fpH12VXIoA7Igk0WSFWAQOI
	bs70Mp07dz9WjtTM7nnH88a8SvDC/NKapL0EVDxw7bHFUQA2p3k/kZffKFZhATVtcgo2orosV1Y
	rnjHury3o4m/21nnKjIWYii1OtlAWw9CJg/txP/034Bj31tzi88RcHQ7bIt/Khcp/e6anaxk6ER
	ql5hVesJ
X-Received: by 2002:a05:6402:1d50:b0:649:afbf:ce4c with SMTP id
 4fb4d7f45d1cf-658de544f24mr789401a12.3.1769731651928; Thu, 29 Jan 2026
 16:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <43dff7cf-cb00-4480-8856-501a8313951e@gmail.com> <d80fef86-ba14-4bd4-bce5-4d61a75d591b@hauke-m.de>
In-Reply-To: <d80fef86-ba14-4bd4-bce5-4d61a75d591b@hauke-m.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 29 Jan 2026 16:07:20 -0800
X-Gm-Features: AZwV_QjZPZfhXur7flQehyzBN15xthflTmeWduAx4kmVpHsBLv4OMwB-py0WlHM
Message-ID: <CAKxU2N_hKNbQ6fUssZkyvbog6SNJ=LdYNc_oMZnvonX=PRvtyA@mail.gmail.com>
Subject: Re: Status of orphaned ltq_etop ethernet driver: mainline vs. OpenWRT
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, John Crispin <john@phrozen.org>, 
	Daniel Golle <daniel@makrotopia.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254953-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,phrozen.org,makrotopia.org,kernel.org,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org,lists.openwrt.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,openwrt.org:url,openwrt.org:email,hauke-m.de:email]
X-Rspamd-Queue-Id: 6D8A1B5CB5
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:36=E2=80=AFPM Hauke Mehrtens <hauke@hauke-m.de> =
wrote:
>
> On 1/28/26 21:23, Heiner Kallweit wrote:
> > This driver in mainline lost its in-tree user with commit
> > cd93b4895ea5 ("MIPS: lantiq: drop mips_machine support")
> > in 2012. Since then it has had no in-tree user.
> >
> > Only (?) user seems to be OpenWRT, with several changes to
> > the in-tree driver version:
> > target/linux/lantiq/patches-6.12/035-owrt-lantiq-wifi-and-ethernet-eepr=
om-handling.patch
> > target/linux/lantiq/patches-6.12/028-NET-lantiq-various-etop-fixes.patc=
h
> > target/linux/lantiq/patches-6.12/701-NET-lantiq-etop-of-mido.patch
> > So it seems the driver is maintained in OpenWrt only
> > (except tree-wide in-tree changes).
> >
> > To me this leaves two questions:
> > - Move this driver to OpenWRT completely?
> > - Or mainline all downstream changes, maintain driver in
> >    mainline, and mainline also the users of this driver?
> >
>
> Hi,
>
> I think dropping this from the mainline kernel is fine, if it causes
> efforts for you.
> This is the Ethernet of the Lantiq Danube SoC, the SoC is probably EoL
> since 15 years. I assume that all users either use the vendor SDK with
> Linux 2.6.X or OpenWrt.
>
> I will not spend much effort on this driver and others will probably
> also not spend much effort. We can move it completely into OpenWrt and
> keep it running there.
FWIW I have some cleanup commits on the driver. Would be great to have
the driver as C files to make editing easier...
>
> Hauke
>
> _______________________________________________
> openwrt-devel mailing list
> openwrt-devel@lists.openwrt.org
> https://lists.openwrt.org/mailman/listinfo/openwrt-devel

